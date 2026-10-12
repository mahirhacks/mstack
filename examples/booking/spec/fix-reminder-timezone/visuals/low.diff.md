# Low-level change: Reminder shows the wrong time

- Fixes: booking
- Previous chart: spec/booking/visuals/low.md
- Change: the reminder text is now formatted in the clinic's time zone, which is read from the clinic record (REQ-001, AC-001.2).
- Unchanged: the booking path and the retry/failure handling (11 of the 12 existing nodes are unchanged).

## Chart A — Before: where the change happens

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
        subgraph CHANGE["⚠ CHANGES HERE"]
            REMINDER__BUILD_TEXT["buildReminderText()"]
        end
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
    REMINDER_WORKER__RUN_DUE --> REMINDER__BUILD_TEXT --> TWILIO__SEND_SMS
    TWILIO__SEND_SMS -. "EDGE-003: 3 attempts failed" .-> REMINDER__MARK_FAILED
    classDef failure fill:#fff4d6,stroke:#b8860b,color:#1d1d1f
    class SLOT_SERVICE__NEXT_FREE,RESP__TOO_MANY,REMINDER__MARK_FAILED failure
    style CHANGE fill:#fff0f0,stroke:#d00000,stroke-width:3px,color:#7a0000
    classDef modified stroke:#d00000,stroke-width:2px
    class REMINDER__BUILD_TEXT modified
```

## Chart B — After: the red zone expanded

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
        subgraph CHANGE["⚠ CHANGED: clinic-local time (REQ-001, AC-001.2)"]
            CLINIC__GET_TIMEZONE{"getClinicTimeZone()"}
            CLINIC__DEFAULT_TZ["default Europe/London + warn"]
            REMINDER__BUILD_TEXT["buildReminderText(tz)"]
            DB__CLINICS[("clinics")]
        end
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
    style CHANGE fill:#fff0f0,stroke:#d00000,stroke-width:3px,color:#7a0000
    classDef added fill:#ffd6d6,stroke:#d00000,color:#1d1d1f
    classDef modified stroke:#d00000,stroke-width:2px
    class CLINIC__GET_TIMEZONE,CLINIC__DEFAULT_TZ,DB__CLINICS added
    class REMINDER__BUILD_TEXT modified
```

## Change legend
| Node | Change | Why | Where |
|---|---|---|---|
| CLINIC__GET_TIMEZONE | added | REQ-001, Task 1.1.1 | `src/clinics/timezone.ts:getClinicTimeZone` |
| CLINIC__DEFAULT_TZ | added | AC-001.2, Task 1.1.2 | `src/clinics/timezone.ts:getClinicTimeZone` (fallback branch) |
| DB__CLINICS | added (newly read) | REQ-001 | `prisma/schema.prisma:Clinic.timeZone` |
| REMINDER__BUILD_TEXT | modified: now takes `tz` and uses `Intl.DateTimeFormat` with `timeZone` | AC-001.1, Task 1.2.1 | `src/reminders/message.ts:buildReminderText` |
