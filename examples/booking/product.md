# Product: ClinicBook

- Status: Approved
- Last updated: 2026-10-12

## Purpose
Online appointment booking for small dental clinics, so patients can book without phoning. [U:I-1.2]

## Users
| User | Trying to get done | Source |
|---|---|---|
| Patient | book, reschedule or cancel an appointment quickly | [U:I-1.3] |
| Receptionist | manage the clinic calendar; book on behalf of patients | [U:I-1.3, I-2.1] |
| Clinic owner | see booking reports | [U:I-2.1] |

## Problem
- Pain: receptionists miss calls, especially at lunch, and patients give up. [U:I-2.3]
- Current alternative: phone only. [U:I-2.3]

## Primary journey
1. Patient opens the clinic's booking page.
2. Picks a free slot.
3. Enters name and phone.
4. Gets a confirmation, then an SMS reminder 24 h before. [U:I-3.1]

## Success metrics
| Metric | Target | By when | Source |
|---|---|---|---|
| Clinics with ≥50 online bookings/week | 30 | 6 months after launch | [U:I-3.2] |

## Scope
### In v1
- Booking, cancelling, SMS reminders, receptionist calendar. [U:I-3.3]

### Out / later
- Payments, reviews, multi-location clinics. [U:I-3.3]

## Platforms and reach
- Platforms: web (mobile-friendly). No native apps in v1. [U:I-3.4]
- Languages: English. [U:I-3.5]
- Accessibility: WCAG 2.2 AA. [U:I-3.5]

## Business
- Model: per-clinic monthly subscription. [U:I-4.1]
- Timeline: pilot with 3 clinics by 2027-02-01. [U:I-3.6]

## Product principles
- Booking takes under 60 seconds. [M — approved at playback]
- Staff are never double-booked. [M — approved at playback]

## Open questions
- none

## Decision record

### Human decisions
| ID | Question | Answer | Source | Date |
|---|---|---|---|---|
| I-1.2 | Describe the product in a sentence or two | Online booking for dental clinics instead of phoning | user | 2026-10-12 |
| I-3.2 | Six months after launch, what number shows it's working? (follow-up to "lots of bookings") | 30 clinics with ≥50 bookings/week | user | 2026-10-12 |

### Agent decisions (minor)
| What | Choice | Why it's minor |
|---|---|---|
| Section wording | plain English summaries | prose only; content confirmed at playback |
