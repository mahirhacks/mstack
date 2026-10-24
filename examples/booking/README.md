# Worked example: dental booking

This folder is what `.mstack/` looks like in a project after:

1. **the interview** → `product.md`, `tech.md`, `security.md`, `architecture.md`;
2. **one feature**, `spec/booking/`: patients book appointments online;
3. **one bug-fix**, `spec/fix-reminder-timezone/`: reminders were sent at the wrong hour.

Copy its *shape*, not its content. The documents are shortened to stay readable. A real run fills every template section.

| File | Shows |
|---|---|
| `product.md` … `architecture.md` | project files with source tags (`[U:I-2.3]` = interview round 2, question 3) and a Decision record |
| `spec/booking/requirements.md` | EARS acceptance criteria, traceability |
| `spec/booking/design.md` | stable diagram IDs, Project file impact table |
| `spec/booking/edge-cases.md` | edge entries resolved by the user, a failure policy, the dropped list |
| `spec/booking/tasks.md` | phases A–C + PHASE Z (Break it); every sub-phase ends with a test task and a reviewer acceptance task; planner-written test cases; a bug hunt with repairs |
| `spec/booking/visuals/high.md` | high-level chart: journey with lanes |
| `spec/booking/visuals/low.md` | low-level chart traced to `file:symbol` |
| `spec/fix-reminder-timezone/requirements.md` | the Bug section with root cause |
| `spec/fix-reminder-timezone/visuals/low.diff.md` | the red-box before/after chart |
| `state.yaml` | resume state and the `charts` pointer |

The bug-fix's `design.md`, `edge-cases.md` and `tasks.md` follow the same formats as the feature's, so they're left out here.
