---
name: mode
description: mstack full flow. Runs everything end to end — interview and project files if missing, then the feature or bug-fix flow through build and charts — and resumes an interrupted mstack run from .mstack/state.yaml. Use for /mstack:mode, "mstack mode", "use mstack", "plan and build this with mstack", or "continue mstack".
---

# mstack:mode — the whole flow

**Setup:** `MSTACK_ROOT` is the folder two levels above this file. Read `AGENTS.md` if present, plus `MSTACK_ROOT/core/workflow.md` (the canonical flow) and `MSTACK_ROOT/core/decision-policy.md`.

## Steps

1. **Read state:** `.mstack/state.yaml`, if it exists.
2. **Resume:** if anything is unfinished, say what and where, then continue it from its earliest incomplete or invalidated step:
   - an unfinished interview → `skills/goal`;
   - a feature that isn't `done` → `skills/feature`;
   - a fix that isn't `done` → `skills/bug-fix`.

   If several are unfinished, ask which one to continue.
3. **Project files:** if they're missing or not approved, run `skills/goal`, which hands over to `skills/product`.
4. **Route** the user's request (`workflow.md` §1.1). If they haven't said what to build, ask.
   - new → `skills/feature`
   - wrong, or a change to a built feature → `skills/bug-fix`
   - tiny → the tiny-fix path

   When the route is unclear, ask one question. Never guess the route.
5. **Mode:** infer Gated, Quick Plan or Pre-authorized from the wording (`workflow.md` §4). If it's unclear, ask once. The default is Gated. Whatever the mode, crucial questions, new dependencies and destructive actions always stop the run.
6. **Run** the chosen skill to completion, including charts (`skills/visualhigh`, `skills/visuallow`) and the final report.
7. **After it's done,** ask: "Anything next: another feature, a bug-fix, or done?"

Each step's details live in the skill it runs. This skill only sequences them.
