# High-level chart: Online booking

- Folder: spec/booking/
- Drawn from code at: 2026-10-16 · commit 4f2a9c1
- Key: rectangle = step · diamond = decision · cylinder = data · hexagon = background job · `[[ ]]` = external service · dotted = failure path · thick = async

```mermaid
flowchart LR
    subgraph PATIENT["Patient"]
        PATIENT_OPEN([Open clinic page]) --> PATIENT_PICK_SLOT["① Pick a free slot"]
        PATIENT_PICK_SLOT --> PATIENT_DETAILS["② Enter name + phone"]
        PATIENT_SEE_CONFIRM(["⑤ See confirmation"])
        PATIENT_SEE_TAKEN["Sees next 3 free slots"]
    end
    subgraph SERVER["Booking service"]
        SLOT_FREE{"③ Slot still free?"}
        CREATE_BOOKING["④ Create booking + reminder"]
    end
    subgraph DATA["Data"]
        DB_BOOKINGS[("bookings")]
    end
    subgraph JOBS["Background"]
        REMINDER_JOB{{"Reminder worker (every minute)"}}
    end
    subgraph EXT["External"]
        SMS_PROVIDER[["Twilio SMS"]]
    end

    PATIENT_DETAILS --> SLOT_FREE
    SLOT_FREE -- yes --> CREATE_BOOKING --> DB_BOOKINGS
    CREATE_BOOKING --> PATIENT_SEE_CONFIRM
    SLOT_FREE -. "EDGE-001: just taken" .-> PATIENT_SEE_TAKEN
    PATIENT_SEE_TAKEN --> PATIENT_PICK_SLOT
    DB_BOOKINGS ==> REMINDER_JOB ==> SMS_PROVIDER
    classDef failure fill:#fff4d6,stroke:#b8860b,color:#1d1d1f
    class PATIENT_SEE_TAKEN failure
```

## Walkthrough
1. ① The patient picks a free slot on the clinic's page.
2. ② They enter a name and a UK mobile number.
3. ③ The server checks the slot is still free. A unique constraint makes this race-safe.
4. ④ The booking and its reminder are saved.
5. ⑤ The patient sees a confirmation. 24 hours before the appointment, the worker sends the SMS reminder.

## Failure paths
- EDGE-001: the slot was taken in the meantime → the patient sees the next 3 free slots.

## Trace
| Node | Traces to |
|---|---|
| PATIENT_PICK_SLOT | AC-001.1 |
| SLOT_FREE | AC-001.4, EDGE-001 |
| CREATE_BOOKING | AC-001.2 |
| REMINDER_JOB | REQ-003, design §Components |

## Unverified links
- none
