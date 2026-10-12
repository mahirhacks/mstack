# Tasks: Online booking

- Status: Done
- Last updated: 2026-10-16

## Phase 1 — A patient can book a slot
- **Goal:** the booking page shows free slots and creates bookings safely
- **Covers:** REQ-001
- **Exit criteria:** an e2e booking succeeds; a concurrent double-book yields exactly one booking
- **Phase test:** `pnpm test:e2e booking.spec.ts`

### Sub-phase 1.1 — Data and slot reservation
- **Objective:** tables and atomic reserve
- **Depends on:** none
- **Sub-phase test:** `pnpm test src/booking`

#### [x] Task 1.1.1 — Booking and Reminder tables
- **Objective:** add the models from design §Data
- **Implementation:** `prisma/schema.prisma`: add `Booking`, `Reminder`, and the partial unique index `(clinicId, slotStart) WHERE status='booked'`; generate the migration
- **Criteria:** the migration applies on a clean DB
- **Test:** `pnpm prisma migrate dev` + schema test
- **Depends on:** —
- **Traces:** design §Data, EDGE-001

#### [x] Task 1.1.2 — `reserve()`
- **Objective:** create a booking or report the slot as taken
- **Implementation:** `src/booking/slot-service.ts`: `reserve(input)` inserts; on a unique violation it returns `SLOT_TAKEN` + `nextFreeSlots(3)`
- **Criteria:** concurrent calls produce one booking
- **Test:** `slot-service.test.ts` "concurrent reserve"
- **Depends on:** 1.1.1
- **Traces:** AC-001.2, AC-001.4, EDGE-001

### Sub-phase 1.2 — API and page
#### [x] Task 1.2.1 — `POST /api/bookings`
- **Objective:** validate, rate-limit, deduplicate, reserve
- **Implementation:** `app/api/bookings/route.ts`: zod schema (UK mobile), rate limit (EDGE-006), idempotency key (EP-02), call `reserve`
- **Criteria:** the contract in design §Contracts
- **Test:** `route.test.ts`: 201, 409, 422, 429, duplicate key
- **Depends on:** 1.1.2
- **Traces:** AC-001.2, AC-001.3, EDGE-002, EDGE-006

## Phase 2 — Cancel link
<sub-phases and tasks in the same format, covering REQ-002 and EDGE-005>

## Phase 3 — Reminders
<covering REQ-003, EDGE-003 and EDGE-004; task 3.1.1 builds `src/reminders/worker.ts`>

## Phase 4 — Update project files
#### [x] Task 4.1.1 — Update architecture.md and tech.md
- **Objective:** reflect the reminder worker and the new failure policies
- **Implementation:** architecture.md: add the component and EP-01/EP-02 · tech.md: add the Railway worker process
- **Criteria:** the files match the built system
- **Test:** reviewer comparison against the code
- **Depends on:** 3.1.1
- **Traces:** design §Project file impact

## Dependency list
| Task | Depends on |
|---|---|
| 1.1.1 | — |
| 1.1.2 | 1.1.1 |
| 1.2.1 | 1.1.2 |
| 4.1.1 | 3.1.1 |

## Coverage
| Item | Tasks | Test |
|---|---|---|
| REQ-001 | 1.1.1–1.2.1 | phase 1 e2e |
| EDGE-001 (MUST) | 1.1.1, 1.1.2 | concurrent reserve |
| EDGE-006 (MUST) | 1.2.1 | route 429 test |

## Final review
### VERDICT: PASS — all REQs and MUST-/SHOULD-HANDLE edges have passing tests; `pnpm build`, lint, types and 48 tests pass; e2e booking journey passes; project files updated.
