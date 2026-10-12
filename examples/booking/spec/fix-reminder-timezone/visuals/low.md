# Low-level chart: Online booking (after fix-reminder-timezone)

- Folder: spec/fix-reminder-timezone/
- Drawn from code at: 2026-10-22 · commit 9b31e07
- Key: parallelogram = entry point · rectangle = function · diamond = branch · cylinder = table · hexagon = job · `[[ ]]` = external call · dotted = failure path

```mermaid
flowchart LR
    subgraph API["app/api/bookings"]
        ROUTE__POST_BOOKINGS[/"POST /api/bookings"/]
    end
    subgraph BOOKING["src/booking"]
        BOOKING__VALIDATE["validateBooking()"]
        RATE_LIMIT__CHECK{"checkRateLimit()"}
        SLOT_SERVICE__RESERVE{"reserve()"}
        SLOT_SERVICE__NEXT_FREE["nextFreeSlots()"]
        RESP__TOO_MANY["429 TOO_MANY"]
    end
    subgraph REMINDERS["src/reminders"]
        REMINDER_WORKER__RUN_DUE{{"runDueReminders()"}}
        CLINIC__GET_TIMEZONE{"getClinicTimeZone()"}
        CLINIC__DEFAULT_TZ["default Europe/London + warn"]
        REMINDER__BUILD_TEXT["buildReminderText(tz)"]
        DB__CLINICS[("clinics")]
        TWILIO__SEND_SMS[["sendSms()"]]
        REMINDER__MARK_FAILED["markFailed()"]
    end
    DB__BOOKINGS[("bookings")]
    DB__REMINDERS[("reminders")]

    ROUTE__POST_BOOKINGS --> BOOKING__VALIDATE --> RATE_LIMIT__CHECK
    RATE_LIMIT__CHECK -- ok --> SLOT_SERVICE__RESERVE
    RATE_LIMIT__CHECK -. "EDGE-006: over limit" .-> RESP__TOO_MANY
    SLOT_SERVICE__RESERVE -- inserted --> DB__BOOKINGS
    SLOT_SERVICE__RESERVE -- inserted --> DB__REMINDERS
    SLOT_SERVICE__RESERVE -. "EDGE-001: unique violation" .-> SLOT_SERVICE__NEXT_FREE
    REMINDER_WORKER__RUN_DUE --> DB__REMINDERS
    REMINDER_WORKER__RUN_DUE --> CLINIC__GET_TIMEZONE
    CLINIC__GET_TIMEZONE --> DB__CLINICS
    CLINIC__GET_TIMEZONE -- tz set --> REMINDER__BUILD_TEXT
    CLINIC__GET_TIMEZONE -. "no tz (AC-001.2)" .-> CLINIC__DEFAULT_TZ --> REMINDER__BUILD_TEXT
    REMINDER__BUILD_TEXT --> TWILIO__SEND_SMS
    TWILIO__SEND_SMS -. "EDGE-003: 3 attempts failed" .-> REMINDER__MARK_FAILED
    classDef failure fill:#fff4d6,stroke:#b8860b,color:#1d1d1f
    class SLOT_SERVICE__NEXT_FREE,RESP__TOO_MANY,REMINDER__MARK_FAILED failure
```

## Walkthrough
1. The booking path is unchanged (see spec/booking/visuals/low.md).
2. `REMINDER_WORKER__RUN_DUE` now gets the clinic's time zone (`CLINIC__GET_TIMEZONE`) before building the text, and falls back to Europe/London with a warning.

## Failure paths
- AC-001.2: no clinic time zone → default Europe/London + warning.
- EDGE-001, EDGE-003, EDGE-006: unchanged.

## Trace
See spec/booking/visuals/low.md for the unchanged nodes. New and changed nodes are in low.diff.md → Change legend.

## Unverified links
- none
