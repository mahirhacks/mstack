# Requirements: Online booking

- Status: Approved
- Last updated: 2026-10-13

## Overview
Patients book and cancel appointments on their clinic's page without phoning, and get an SMS reminder 24 hours before. This serves the product.md metric "30 clinics with ≥50 online bookings/week".

## Scope
### In
- Booking a free slot, cancelling through a link, SMS reminder.

### Out
- Rescheduling (patients cancel and re-book) [U:Q-04], payments, patient accounts.

## Requirements

### REQ-001 — Book a free slot
**As a** patient [U:I-1.3]
**I want** to pick a free slot and enter my name and phone
**So that** I get an appointment without phoning

#### Acceptance criteria
- AC-001.1: WHEN a patient opens `/book/<clinic>` THE SYSTEM SHALL show free slots for the next 14 days. [U:Q-01]
- AC-001.2: WHEN a patient submits a free slot with a valid name and UK mobile number THE SYSTEM SHALL create the booking and show a confirmation within 2 seconds. [U:Q-02]
- AC-001.3: WHEN the phone number isn't a valid UK mobile THE SYSTEM SHALL reject it with the inline message "Enter a UK mobile number". [U:Q-03]
- AC-001.4: WHEN the slot was taken in the meantime THE SYSTEM SHALL show "Just taken" and the next 3 free slots. [U:E-03]

### REQ-002 — Cancel through a link
- AC-002.1: WHEN a booking is created THE SYSTEM SHALL include a signed cancel link in the confirmation SMS. [U:Q-05]
- AC-002.2: WHEN a patient opens a valid cancel link before the appointment THE SYSTEM SHALL cancel the booking and free the slot. [U:Q-05]

### REQ-003 — SMS reminder
- AC-003.1: WHEN an appointment is 24 hours away THE SYSTEM SHALL send one SMS reminder. [U:I-3.1]
- AC-003.2: WHEN the SMS provider fails THE SYSTEM SHALL follow failure policy EP-01. [U:E-01]

## Cross-cutting
- Security: every query is scoped by `clinicId` (security.md). Cancel links are signed and single-use. [U:E-05]
- Abuse: at most 3 bookings per phone number per clinic per day. [U:E-06]
- Accessibility: WCAG 2.2 AA on the booking page.

## Done when
- A patient can book, gets the confirmation SMS, can cancel, and gets the reminder. [U:Q-06]

## Traceability
| REQ | Serves (product.md) |
|---|---|
| REQ-001, REQ-002, REQ-003 | 30 clinics with ≥50 online bookings/week |

## Decision record

### Human decisions
| ID | Question | Answer | Source | Date |
|---|---|---|---|---|
| Q-01 | How far ahead can patients book? | 14 days | user | 2026-10-13 |
| Q-04 | Is rescheduling in this feature? | No: cancel and re-book | user | 2026-10-13 |

### Agent decisions (minor)
| What | Choice | Why it's minor |
|---|---|---|
| REQ grouping | 3 stories | structure only |
