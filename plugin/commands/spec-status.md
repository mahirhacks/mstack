---
description: Show the current spec status for active or recent changes
argument-hint: [feature-name]
---

# Spec Status

The user invoked: `/spec-status $ARGUMENTS`

## Instructions

1. Find active spec artifacts under `.agent/specs/`, `docs/specs/`, or the project's established spec directory.
2. If `$ARGUMENTS` names a feature, scope to that folder only.
3. Report for each artifact:
   - path;
   - status from metadata (Draft, Reviewed, Approved, In Progress, Complete);
   - open questions;
   - task completion (`[ ]`, `[~]`, `[x]`, `[!]`).
4. State which approval gates have passed and what the next step is per `<skill-pack>/references/workflow.md`.
