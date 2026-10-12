# Edge Cases: Online booking

- Status: Approved
- Design version: 2026-10-13
- Counts: 6 found (shortened here from 27) · 6 resolved · 0 open · 1 dropped

## Edge surface model
- Flows: F1.1 open page · F1.2 pick slot · F1.3 submit · F1.4 confirmation SMS · F2.1 cancel link · F3.1 reminder
- Entities and invariants: Booking — at most one booked booking per `(clinicId, slotStart)`
- External dependencies: Twilio — timeout, 5xx, invalid number
- Trust boundaries: public form → API; cancel link → API
- Actors: patient, receptionist, attacker, reminder worker

## Failure policies applied
| Policy | Decision | Source |
|---|---|---|
| EP-01 External service down | retry 3× over 1 minute, then mark failed and show it in the staff calendar | [U:E-01] (new, added to architecture.md) |
| EP-02 Duplicate submission | deduplicate with an idempotency key | [U:E-02] (new, added to architecture.md) |

## Edges

### EDGE-001 — Two patients submit the same slot at the same moment
- Flow step: F1.3 · Component: design §Components slot-service
- Category: State & concurrency
- Impact: High · Likelihood: Likely (popular slots at peak hours) · Severity: S1
- Coverage before analysis: Uncovered
- Options offered: (a) first wins, the second sees the next 3 free slots (b) hold the slot for 5 min while the form is open (c) allow both, staff resolve it (d) accept the risk
- **Resolution:** (a) First wins, enforced by a unique constraint. The second patient sees "Just taken" and the next 3 free slots. [U:E-03]
- Status: MUST-HANDLE
- Changes: +AC-001.4 · design §Data unique constraint
- Test: concurrent POST test, exactly one booking created

### EDGE-002 — Patient double-clicks "Book"
- Category: Retry & idempotency · Severity: S2
- **Resolution:** EP-02, an idempotency key from the form. [U:E-02]
- Status: MUST-HANDLE · Test: two identical POSTs create one booking

### EDGE-003 — Twilio is down when the reminder is due
- Category: Dependency failure · Severity: S2
- **Resolution:** EP-01. [U:E-01]
- Status: MUST-HANDLE · Test: mocked 503 → 3 attempts → `failed` shown in the calendar

### EDGE-004 — Phone number valid but unreachable
- Category: Dependency failure · Severity: S3 (asked grouped with F1.4)
- **Resolution:** mark the reminder `failed` and show it in the staff calendar, no retry. [U:E-04]
- Status: SHOULD-HANDLE · Test: Twilio "unreachable" response → no retry, flagged

### EDGE-005 — Cancel link used twice
- Category: Data integrity · Severity: S4 (approval table)
- **Resolution:** the second use shows "Already cancelled". [U:E-05, approved in the table]
- Status: SHOULD-HANDLE · Test: second GET returns the already-cancelled page

### EDGE-006 — Bot spams the form to send SMS messages
- Category: Abuse & security · Severity: S2 (protected domain: cost)
- **Resolution:** at most 3 bookings per phone per clinic per day, and 20 per IP per hour; return 429. [U:E-06]
- Status: MUST-HANDLE · Changes: +Cross-cutting abuse line in requirements · Test: 4th booking → 429

## Considered and dropped
| Candidate | Why dropped |
|---|---|
| Clinic changes its time zone mid-day | design stores the clinic time zone at setup, and v1 has no setting to change it |

## Changes proposed to earlier documents
- requirements.md: +AC-001.4, +the abuse limit line
- design.md: unique constraint; rate limit in the route
- architecture.md: EP-01, EP-02

## Decision record
<the E-01…E-06 answers above, in the table format of core/decision-policy.md §5>
