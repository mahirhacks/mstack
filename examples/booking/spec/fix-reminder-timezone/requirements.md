# Requirements: Reminder shows the wrong time

- Fixes: booking
- Status: Approved
- Last updated: 2026-10-20

## Overview
During British Summer Time, reminder SMS messages show the appointment one hour early ("09:00" for a 10:00 appointment). Patients arrive early or call the clinic.

## Bug
- **What's wrong:** WHEN a reminder is sent for an appointment during BST THE SYSTEM shows the time in UTC.
- **How to reproduce:**
  1. Book a 10:00 slot on 2026-10-22 (BST) at a clinic in `Europe/London`.
  2. Run `runDueReminders()` 24 h before.
  3. The SMS says "09:00".
- **Expected:** WHEN a reminder is sent THE SYSTEM SHALL show the appointment time in the clinic's time zone.
- **Root cause:** `src/reminders/message.ts:14` formats `slotStart` with `toLocaleTimeString()`. On the worker, that uses the server's time zone (UTC). [R:src/reminders/message.ts:14]
- **Must not change:** WHEN reminders are due THE SYSTEM SHALL CONTINUE TO send them 24 h before, retried per EP-01. [U:Q-02]

## Scope
### In
- Reminder text shows clinic-local time.

### Out
- Showing times in the patient's own time zone [U:Q-01]; changing the booking page.

## Requirements

### REQ-001 — Reminder shows clinic-local time
- AC-001.1: WHEN a reminder is built THE SYSTEM SHALL format the time in the clinic's IANA time zone (e.g. `Europe/London`). [U:Q-01]
- AC-001.2: WHEN a clinic has no time zone set THE SYSTEM SHALL use `Europe/London` and log a warning. [U:E-01]

## Done when
- A BST and a GMT appointment both show the correct local time in the reminder. [U:Q-03]

## Decision record

### Human decisions
| ID | Question | Answer | Source | Date |
|---|---|---|---|---|
| Q-01 | Clinic's time zone or the patient's? | Clinic's | user | 2026-10-20 |
| E-01 | Clinic has no time zone set: what then? | Default to Europe/London + log a warning | user | 2026-10-20 |
