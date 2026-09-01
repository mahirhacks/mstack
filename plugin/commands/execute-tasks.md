---
description: Execute approved tasks from tasks.md
argument-hint: [task-id like 1.2 or "all"]
---

# Execute Tasks

The user invoked: `/execute-tasks $ARGUMENTS`

## Instructions

1. Confirm `tasks.md` is approved. If not, stop and ask for approval.
2. Read `<skill-pack>/agents/task-worker.md` and `<skill-pack>/references/roles.md`.
3. If `$ARGUMENTS` is empty or `all`, execute all approved subtasks in dependency order.
4. If `$ARGUMENTS` is a task id (for example `1.2`), execute only that subtask.
5. Update task markers as work proceeds.
6. Run focused checks per subtask Test field.
7. When complete, send the integrated result to a fresh implementation reviewer per `<skill-pack>/agents/task-reviewer.md`.
