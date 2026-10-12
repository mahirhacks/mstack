---
name: status
description: mstack status. Read-only report of the project files, every feature and bug-fix (current step, approvals, build progress, open questions) and the next step, from .mstack/state.yaml and the spec folders. Use for /mstack:status, "mstack status", "where are we", or "what's next" in an mstack project.
---

# mstack:status — read-only

**Setup:** `MSTACK_ROOT` is the folder two levels above this file. Don't change any file.

## Steps

1. Read `.mstack/state.yaml`, the project files' `Status` lines, and every `spec/*/` folder. If the user names a feature, report only that one.
2. **Check the state against the files.** Count the task markers in `tasks.md`, and read each document's `Status` and `Open questions`. If `state.yaml` disagrees with the files, report the mismatch. Don't fix it.
3. Report:

```text
mstack status — <project>

Project files: approved (product · tech · security · architecture)   | missing | draft — <what's open>
Mode: gated

Feature / fix          Step          Approved                          Build            Open
booking                done          req · design · edges · tasks      12/12 ✅         —
fix-double-booking     build         req · design · edges · tasks      phase 2 · 5/9    1 question (B-02)

Next: answer B-02 in fix-double-booking, then continue phase 2.
Charts: booking (high, low) · latest low: spec/fix-double-booking/visuals/low.md (pending)
```

4. End with **one** next step, using the rules in `MSTACK_ROOT/core/workflow.md`.
