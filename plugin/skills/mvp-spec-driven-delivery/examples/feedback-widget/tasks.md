# Tasks: Feedback Widget

> **Worked example.** This shows what a finished `tasks.md` looks like: main tasks group outcomes, subtasks are the executable units, and every subtask has exactly Objective, Implementation, Criteria, and Test.

## Metadata
- Status: Approved

## Traceability
| Requirement | Design section | Tasks |
|---|---|---|
| REQ-001 | Data Model, Interfaces, Components | Task 1.1, Task 1.2, Task 2.1 |
| REQ-002 | Interfaces, Components | Task 3.1 |

## Implementation Plan

### Task 1 — Feedback storage and API

#### [ ] Task 1.1 — Create the feedback table
- **Objective:** Persist submissions with submitter, page context, and time.
- **Implementation:** Add `migrations/007_create_feedback.sql` with the `feedback` table and `created_at` index exactly as in the design Data Model. No dependencies. Maps to REQ-001.
- **Criteria:** `npm run migrate` applies cleanly on a fresh database and the table matches the design columns.
- **Test:** Migration runs in the integration test setup; schema assertion on the `feedback` table.

#### [ ] Task 1.2 — POST /api/feedback endpoint
- **Objective:** Accept and validate feedback from signed-in users.
- **Implementation:** New `src/routes/feedback.ts` with `requireUser`, server-side length validation (1–2000), row insert, and 201/400/401 responses per the design contract; register the router in `src/routes/index.ts`. Depends on Task 1.1. Maps to REQ-001 (AC-001.1–AC-001.3).
- **Criteria:** All three acceptance criteria are observable over HTTP.
- **Test:** Integration tests: valid submit, empty message, oversized message, signed-out request.

### Task 2 — Submission widget

#### [ ] Task 2.1 — Feedback widget partial
- **Objective:** Let users submit feedback without leaving the current page.
- **Implementation:** New `src/views/partials/feedback-widget.ejs` (trigger button, textarea, submit, success and error states); mount it in `src/views/layout.ejs` for signed-in users only. Depends on Task 1.2. Maps to REQ-001.
- **Criteria:** Submitting from any page stores a row and shows confirmation; validation errors appear inline; the widget is absent for signed-out visitors.
- **Test:** Smoke test: submit from the dashboard and confirm the stored row.

### Task 3 — Admin review

#### [ ] Task 3.1 — Admin feedback list
- **Objective:** Show submissions newest first to admins only.
- **Implementation:** Add `GET /admin/feedback` to `src/routes/feedback.ts` behind `requireAdmin`, query capped at the 200 newest rows, render `src/views/admin/feedback.ejs` with the message text escaped. Depends on Task 1.1. Maps to REQ-002 (AC-002.1, AC-002.2).
- **Criteria:** Admin sees the newest-first list with message, email, page URL, and time; non-admin receives 403; message HTML is escaped.
- **Test:** Integration tests for both roles, plus a stored `<script>` probe rendered as escaped text.

## Parallel Groups
- Group A: Task 2.1 and Task 3.1 — independent once their dependencies are done, except for the shared router file noted below.

## File Conflicts
- `src/routes/feedback.ts`: Task 1.2 and Task 3.1 both edit this file. Complete Task 1.2 first or assign both to the same worker.

## Execution Notes
- Run `npm run migrate` before the integration tests.
- Status markers as work proceeds: `[ ]` not started, `[~]` in progress, `[x]` complete, `[!]` blocked.
