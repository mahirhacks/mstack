# Tasks: Online booking

- Status: Done
- Last updated: 2026-10-16

<!-- Phases A and Z are written out in full. Phases B and C are shortened to their cards' titles, but keep the same shape. -->

---

## PHASE A — Patients can book a slot
- **Covers:** REQ-001 · EDGE-001, EDGE-002, EDGE-006
- **Phase acceptance:** a patient books a free slot through the page; two simultaneous requests for one slot create exactly one booking

### SUB-PHASE 1 — Data and slot reservation
- **Depends on:** —

#### [x] 1.1 [worker] — Booking and Reminder tables
- **Files:** `prisma/schema.prisma` (edit) · `prisma/migrations/<timestamp>_booking/` (generated)
- **Do:**
  1. Add `model Booking { id String @id @default(cuid()) · clinicId String · slotStart DateTime · name String · phone String · status String @default("booked") · cancelTokenHash String · createdAt DateTime @default(now()) }`, with a relation to `Clinic`.
  2. Add `model Reminder { id String @id @default(cuid()) · bookingId String @unique · dueAt DateTime · status String @default("pending") · attempts Int @default(0) }`, with a relation to `Booking`.
  3. Run `pnpm prisma migrate dev --name booking --create-only`. In the generated SQL, append: `CREATE UNIQUE INDEX booking_slot_booked ON "Booking" ("clinicId", "slotStart") WHERE status = 'booked';`
- **Pattern:** copy the model style of `prisma/schema.prisma:12` (`model Clinic`)
- **Don't:** change `Clinic` or any existing model
- **Done when:** the migration applies on an empty database and the partial unique index exists
- **Run:** `pnpm prisma migrate reset --force` → "Database reset successful"
- **Traces:** design §Data · EDGE-001

#### [x] 1.2 [worker] — `reserve()` and `nextFreeSlots()`
- **Files:** `src/booking/slot-service.ts` (create)
- **Do:**
  1. Export `async function reserve(input: { clinicId: string; slotStart: Date; name: string; phone: string }): Promise<{ ok: true; bookingId: string } | { ok: false; code: "SLOT_TAKEN"; nextSlots: Date[] }>`.
  2. In one `prisma.$transaction`, create the `Booking`, then a `Reminder` with `dueAt = slotStart − 24 h`.
  3. Catch Prisma error code `P2002` → return `{ ok: false, code: "SLOT_TAKEN", nextSlots: await nextFreeSlots(clinicId, slotStart, 3) }`. Rethrow anything else.
  4. Export `async function nextFreeSlots(clinicId: string, after: Date, count: number): Promise<Date[]>`. It returns the next `count` 30-minute slots after `after`, inside clinic opening hours (`getOpeningHours(clinicId)` from `src/clinics/hours.ts`), that have no booked booking.
- **Pattern:** copy the transaction style of `src/clinics/clinic-repo.ts:34`
- **Don't:** add a dependency; read or write any table except Booking and Reminder
- **Done when:** both functions exist with these exact signatures, and `pnpm typecheck` passes
- **Run:** `pnpm typecheck` → no errors
- **Traces:** AC-001.2 · AC-001.4 · EDGE-001

#### [x] 1.3 [worker] — Test sub-phase 1
- **Files:** `src/booking/slot-service.test.ts` (create)
- **Pattern:** copy the DB test setup of `src/clinics/clinic-repo.test.ts:1-30`
- **Implement exactly these cases:**

  | Case | Scenario | Setup / input | Expected | Traces |
  |---|---|---|---|---|
  | T1.1 | book a free slot | clinic `c1`, slot 2026-11-03 10:00Z, free | `{ ok: true }`; 1 Booking; 1 Reminder with `dueAt` 2026-11-02 10:00Z | AC-001.2 |
  | T1.2 | slot already taken | same slot booked first | `{ ok: false, code: "SLOT_TAKEN" }`, `nextSlots` has 3 entries, all after 10:00Z | AC-001.4 |
  | T1.3 | two requests at the same moment | `Promise.all` of 2 `reserve()` calls for one slot | exactly 1 `ok: true` and 1 `SLOT_TAKEN`; 1 Booking row | EDGE-001 |
  | T1.4 | cancelled slot can be rebooked | booking for the slot with `status = "cancelled"` | `{ ok: true }` | design §Data |
  | T1.5 | next free slots skip booked ones | 10:00 and 10:30 booked; ask after 09:30 | `[11:00, 11:30, 12:00]` | AC-001.4 |

- **Run:** `pnpm test src/booking/slot-service.test.ts` → 5 passed
- **If a case fails:** don't change `slot-service.ts`. Mark `[!]` and report the case and its output.

#### [x] 1.4 [reviewer] — Acceptance: sub-phase 1
- **Check each criterion, with evidence:**
  - [x] the partial unique index exists — verify by: `\d "Booking"` in psql
  - [x] T1.1–T1.5 pass — verify by: `pnpm test src/booking/slot-service.test.ts`
  - [x] the test file implements T1.1–T1.5 exactly (inputs and expectations as listed) — verify by: reading the test file
  - [x] no changes outside `prisma/` and `src/booking/` — verify by: `git diff --stat`
- **Verdict:** PASS

### SUB-PHASE 2 — Booking API
- **Depends on:** 1

#### [x] 2.1 [worker] — `POST /api/bookings`
- **Files:** `app/api/bookings/route.ts` (create) · `src/booking/validate.ts` (create) · `src/booking/rate-limit.ts` (create)
- **Do:**
  1. `validate.ts`: zod schema `{ clinicId: string, slotStart: ISO datetime, name: 1–80 chars, phone: /^(\+44|0)7\d{9}$/, idempotencyKey: uuid }`. Export `validateBooking(body)`.
  2. `rate-limit.ts`: export `checkRateLimit({ phone, clinicId, ip })`. It returns `false` when there are ≥3 bookings for phone + clinic in the last 24 h, or ≥20 requests from the IP in the last hour. Count bookings from the `Booking` table, and IP requests in an in-memory map (design §Approach).
  3. `route.ts` `POST`:
     1. validate; on failure → `422 { error: { code: "INVALID_PHONE" | "INVALID_INPUT" } }`;
     2. rate limit; if limited → `429 { error: { code: "TOO_MANY" } }`;
     3. idempotency: return the stored response for a repeated `idempotencyKey`;
     4. call `reserve()`: `ok` → `201 { bookingId }`, `SLOT_TAKEN` → `409 { error: { code: "SLOT_TAKEN" }, nextSlots }`.
- **Pattern:** copy the route and error format of `app/api/clinics/route.ts:8`
- **Don't:** add dependencies (zod is already installed); log the phone number
- **Done when:** the four status codes are returned as specified
- **Run:** `pnpm typecheck && pnpm lint` → clean
- **Traces:** AC-001.2 · AC-001.3 · EDGE-002 · EDGE-006

#### [x] 2.2 [worker] — Test sub-phase 2
- **Files:** `app/api/bookings/route.test.ts` (create)
- **Pattern:** `app/api/clinics/route.test.ts:1-25`
- **Implement exactly these cases:**

  | Case | Scenario | Setup / input | Expected | Traces |
  |---|---|---|---|---|
  | T2.1 | valid booking | free slot, phone `07700900123` | 201 + `bookingId` | AC-001.2 |
  | T2.2 | invalid phone | phone `12345` | 422 `INVALID_PHONE` | AC-001.3 |
  | T2.3 | slot taken | slot already booked | 409 `SLOT_TAKEN` + 3 `nextSlots` | AC-001.4 |
  | T2.4 | double click | same body + same `idempotencyKey`, sent twice | both 201, same `bookingId`, 1 Booking row | EDGE-002 |
  | T2.5 | 4th booking for one phone in a day | 3 bookings already today for that phone + clinic | 429 `TOO_MANY` | EDGE-006 |
  | T2.6 | phone not in logs | valid booking, capture logger output | no log line contains `07700900123` | security.md |

- **Run:** `pnpm test app/api/bookings` → 6 passed
- **If a case fails:** mark `[!]` and report.

#### [x] 2.3 [reviewer] — Acceptance: sub-phase 2
- **Check, with evidence:**
  - [x] T2.1–T2.6 pass and match the table — verify by: running them and reading the test file
  - [x] the error body format matches `app/api/clinics/route.ts` — verify by: inspection
  - [x] no new dependencies — verify by: `git diff package.json`
- **Verdict:** PASS

### SUB-PHASE 3 — Phase A verification
- **Depends on:** 1, 2

#### [x] 3.1 [worker] — Phase A integration tests
- **Files:** `tests/integration/booking.test.ts` · **Pattern:** `tests/integration/clinics.test.ts:1-40`
- **Implement exactly these cases:**

  | Case | Scenario | Setup / input | Expected | Traces |
  |---|---|---|---|---|
  | T3.1 | API → DB round trip | POST a valid booking | Booking and Reminder rows exist with the posted values | REQ-001 |
  | T3.2 | 10 parallel POSTs, one slot | 10 concurrent requests | 1 × 201, 9 × 409 | EDGE-001 |

- **Run:** `pnpm test tests/integration/booking.test.ts` → 2 passed

#### [x] 3.2 [worker] — Phase A end-to-end test
- **Files:** `e2e/booking.spec.ts` · **Pattern:** `e2e/clinic-page.spec.ts:1-30`
- **Implement exactly these cases:**

  | Case | Scenario | Steps | Expected | Traces |
  |---|---|---|---|---|
  | T3.3 | patient books | open `/book/c1` → pick the first free slot → enter "Ana", `07700900123` → submit | confirmation shows the slot time in under 2 s | AC-001.1, AC-001.2 |
  | T3.4 | slot taken while the form is open | book the slot via the API, then submit the form | "Just taken" with 3 alternatives | AC-001.4 |

- **Run:** `pnpm test:e2e e2e/booking.spec.ts` → 2 passed

#### [x] 3.3 [reviewer] — Acceptance: Phase A
- **Check, with evidence:**
  - [x] Phase acceptance (book a slot; a double-book yields one booking) — verify by: T3.2, T3.3
  - [x] every task in sub-phases 1–3 is `[x]`
  - [x] full suite passes — verify by: `pnpm test` (24 passed)
  - [x] build, lint and types pass — verify by: `pnpm build && pnpm lint && pnpm typecheck`
- **Verdict:** PASS

---

## PHASE B — Patients can cancel through a link
- **Covers:** REQ-002 · EDGE-005
- **Phase acceptance:** a valid link cancels the booking and frees the slot; a reused link shows "Already cancelled"

### SUB-PHASE 4 — Cancel link
- **Depends on:** 2
- [x] 4.1 [worker] — Signed cancel token: create on booking, store its hash
- [x] 4.2 [worker] — `GET /cancel/[token]` page and handler
- [x] 4.3 [worker] — Test sub-phase 4: T4.1 valid link · T4.2 expired link · T4.3 reused link (EDGE-005) · T4.4 tampered token
- [x] 4.4 [reviewer] — Acceptance: sub-phase 4

### SUB-PHASE 5 — Phase B verification
- **Depends on:** 4
- [x] 5.1 [worker] — Phase B integration test: cancel frees the slot, which can then be rebooked (T5.1)
- [x] 5.2 [worker] — End-to-end test: book → open the link → cancelled (T5.2)
- [x] 5.3 [reviewer] — Acceptance: Phase B

---

## PHASE C — Reminders
- **Covers:** REQ-003 · EDGE-003, EDGE-004
- **Phase acceptance:** one reminder is sent 24 h before; provider failures follow EP-01; unreachable numbers are flagged

### SUB-PHASE 6 — Reminder worker
- **Depends on:** 1
- [x] 6.1 [worker] — `sendSms()` Twilio client with a 10 s timeout
- [x] 6.2 [worker] — `buildReminderText()`
- [x] 6.3 [worker] — `runDueReminders()`: every minute; retry 3× over 1 min (EP-01); flag unreachable numbers without retrying
- [x] 6.4 [worker] — Test sub-phase 6: T6.1 due reminder sent once · T6.2 not-yet-due skipped · T6.3 Twilio 503 → 3 attempts → failed (EDGE-003) · T6.4 unreachable → flagged, no retry (EDGE-004)
- [x] 6.5 [reviewer] — Acceptance: sub-phase 6

### SUB-PHASE 7 — Update project files
- **Depends on:** 6
- [x] 7.1 [worker] — architecture.md: add the reminder worker component and failure policies EP-01, EP-02
- [x] 7.2 [worker] — tech.md: add the Railway worker process
- [x] 7.3 [worker] — Test: each component listed in architecture.md exists at its path (T7.1)
- [x] 7.4 [reviewer] — Acceptance: project files match the built system

### SUB-PHASE 8 — Phase C verification
- **Depends on:** 6, 7
- [x] 8.1 [worker] — Phase C integration test: booking → reminder row → worker sends at `dueAt` (fake clock) (T8.1)
- [x] 8.2 [reviewer] — Acceptance: Phase C

---

## PHASE Z — Break it

### SUB-PHASE 9 — Planned attacks
- **Depends on:** 3, 5, 8

#### [x] 9.1 [worker] — Attack tests: every MUST-/SHOULD-HANDLE edge, together
- **Files:** `tests/attacks/booking.attack.test.ts` · **Pattern:** `tests/integration/booking.test.ts:1-20`
- **Implement exactly these cases:**

  | Case | Edge | Attack | Expected | Traces |
  |---|---|---|---|---|
  | T9.1 | EDGE-001 | 50 concurrent POSTs for one slot | exactly 1 Booking | EDGE-001 |
  | T9.2 | EDGE-002 | same `idempotencyKey` 5× within 100 ms | 1 Booking, same `bookingId` returned 5× | EDGE-002 |
  | T9.3 | EDGE-003 | Twilio returns 503 for 2 min | 3 attempts, then `failed`; worker keeps running | EDGE-003 |
  | T9.4 | EDGE-004 | Twilio "unreachable" | flagged after 1 attempt | EDGE-004 |
  | T9.5 | EDGE-005 | open the cancel link 3× | first cancels; the next two show "Already cancelled" | EDGE-005 |
  | T9.6 | EDGE-006 | 25 POSTs from one IP in a minute | requests 21–25 return 429 | EDGE-006 |

#### [x] 9.2 [worker] — Test: run the full attack suite
- **Run:** `pnpm test tests/attacks` → 6 passed

#### [x] 9.3 [reviewer] — Acceptance: every MUST-/SHOULD-HANDLE edge proven
- **Verdict:** PASS

### SUB-PHASE 10 — Bug hunt
- **Depends on:** 9

#### [x] 10.1 [strong] — Hunt: tenant isolation
- **Try:** booking or cancelling with another clinic's `clinicId` or slot; cancel tokens from clinic A used on clinic B; enumerating booking IDs
- **Budget:** 30 attempts · **Don't:** change product code
- **Output:** 1 finding — F1: `nextSlots` in the 409 response ignored the clinic's closed days (Sunday slots offered)

#### [x] 10.2 [strong] — Hunt: input and time boundaries
- **Try:** a slot in the past; a slot exactly at closing time; DST change night; 80-character names with emoji; leading/trailing spaces in the phone number
- **Budget:** 30 attempts
- **Output:** 1 finding — F2: a phone number with spaces (`07700 900123`) was rejected, but receptionists paste numbers that way

#### [x] 10.3 [strong] — Test: failing regression test per finding
- **Files:** `tests/attacks/regressions.test.ts`
- **Run:** `pnpm test tests/attacks/regressions.test.ts` → T10.1 (F1) and T10.2 (F2) fail, as recorded

#### [x] 10.4 [reviewer] — Acceptance: findings real and recorded
- **Verdict:** PASS (both reproduced; no product code changed)

### SUB-PHASE 11 — Repairs from the bug hunt (cycle 1)
- **Depends on:** 10
- [x] 11.1 [worker] — F1: `nextFreeSlots()` skips days where `getOpeningHours()` returns closed
- [x] 11.2 [worker] — F2: strip spaces from `phone` before validation (asked the user first: Q-07, "yes, accept spaces")
- [x] 11.3 [worker] — Test: T10.1, T10.2 now pass; full attack suite still passes
- [x] 11.4 [reviewer] — Acceptance: repairs (then the bug hunt re-ran with 0 new findings)

### SUB-PHASE 12 — Final verification
- **Depends on:** all

#### [x] 12.1 [worker] — Run everything
- **Run:** `pnpm test` · `pnpm build` · `pnpm lint && pnpm typecheck` · `pnpm test:e2e` → all pass (52 tests)

#### [x] 12.2 [reviewer] — Final acceptance (final review)
- **Verdict:** PASS (see Final review)

---

## Dependency list
| Sub-phase | Depends on |
|---|---|
| 1 | — |
| 2 | 1 |
| 3 | 1, 2 |
| 4 | 2 |
| 5 | 4 |
| 6 | 1 |
| 7 | 6 |
| 8 | 6, 7 |
| 9 | 3, 5, 8 |
| 10 | 9 |
| 11 | 10 |
| 12 | all |

## Coverage
| Item | Built in | Tested in | Re-tested in Phase Z |
|---|---|---|---|
| REQ-001 | 1.1, 1.2, 2.1 | T1.1, T2.1, T3.1, T3.3 | T12 suite |
| REQ-002 | 4.1, 4.2 | T4.1, T5.2 | T12 suite |
| REQ-003 | 6.1–6.3 | T6.1, T8.1 | T12 suite |
| EDGE-001 (MUST) | 1.1, 1.2 | T1.3, T3.2 | T9.1 |
| EDGE-002 (MUST) | 2.1 | T2.4 | T9.2 |
| EDGE-003 (MUST) | 6.3 | T6.3 | T9.3 |
| EDGE-004 (SHOULD) | 6.3 | T6.4 | T9.4 |
| EDGE-005 (SHOULD) | 4.2 | T4.3 | T9.5 |
| EDGE-006 (MUST) | 2.1 | T2.5 | T9.6 |

## Parallel groups and file conflicts
- Parallel: sub-phases 4 and 6 (different files, both only need 1–2)
- Conflicts: none

## Final review
### VERDICT: PASS
Every REQ and every MUST-/SHOULD-HANDLE edge has passing tests, both in its sub-phase and in Phase Z. 2 bug-hunt findings were repaired, and the re-hunt found none. Build, lint, types and 52 tests pass, and the e2e booking journey passes. Project files are updated. No undisclosed crucial decisions in code.
