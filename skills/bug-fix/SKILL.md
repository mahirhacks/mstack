---
name: bug-fix
description: mstack bug-fix flow. For anything wrong in, or any change to, an already-built feature. Creates a fix-<name> folder and runs requirements (with a Bug section and root cause) → design → edge cases → tasks → phase-by-phase build → final review → before/after red-box charts, with the user approving each step. Use for /mstack:bug-fix, "mstack bug-fix", "fix <bug>", or changing a finished feature.
---

# mstack:bug-fix

A bug-fix runs **the same steps as a feature**. Follow `MSTACK_ROOT/skills/feature/SKILL.md` (where `MSTACK_ROOT` is the folder two levels above this file), with only these differences.

## Differences from a feature

1. **Route check.** A tiny fix (a typo, a one-liner, a config value, ≤2 files, no schema, API, auth, security or data impact) takes the tiny-fix path instead (`core/workflow.md` §1.2). Any bigger change to a built feature, even a planned improvement, is a bug-fix.
2. **Which feature.** Identify the feature folder being fixed from `spec/*` and `state.yaml`. If more than one could match, ask the user. Never guess.
3. **Folder:** `spec/fix-<name>/`, which you name yourself. Record `fixes: <feature>` in `state.yaml`.
4. **Investigate before requirements.** Reproduce the problem if you can, and find the root cause in the code, with `file:line` evidence. If you can't find it, say so and ask the user for what's needed (logs, steps, environment). Don't invent a cause.
5. **Requirements** (`templates/requirements.md`): keep the `Fixes: <feature>` line and fill in the **Bug** section:
   - what's wrong;
   - how to reproduce it;
   - what's expected;
   - the root cause, with evidence;
   - what must not change.

   Clarify slot R10 (`core/interview.md` §8.1) with the user: which existing behaviour must stay the same.
6. **Inputs to every step** also include the fixed feature's documents and earlier bug-fix folders of that feature. The edge analyst uses their past root causes in its history lens.
7. **Tasks:** same shape as a feature. The first sub-phase's test cases include a regression case that reproduces the bug (it fails before the fix and passes after it), plus cases guarding the "must not change" behaviour. Phase Z still runs.
8. **Charts:** a **before/after red-box diff** (`core/charts.md` §7), where the previous chart is `state.yaml` → `charts.<feature>`. The chart files are `visuals/<level>.diff.md` plus the clean `visuals/<level>.md`. Afterwards, move the `charts` pointer to the new clean chart.
9. **Never edit the fixed feature's folder.** All documents for this change live in the fix folder.
