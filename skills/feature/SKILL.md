---
name: feature
description: mstack feature flow. Creates a feature folder and runs requirements → design → edge cases → tasks → phase-by-phase build → final review → charts, with the user approving each document and making every crucial decision. Use for /mstack:feature, "mstack feature", "plan this feature", "build <new capability>" in an mstack project.
---

# mstack:feature

**Setup:** `MSTACK_ROOT` is the folder two levels above this file. Read `AGENTS.md` if present, plus:

- `MSTACK_ROOT/core/workflow.md`: flows, gates, modes, build loop, state (the canonical rules)
- `MSTACK_ROOT/core/decision-policy.md`: who decides what
- `MSTACK_ROOT/core/roles.md`: who does what

## 0. Start

1. **Project files.** If `.mstack/` project files are missing or not approved, run `mstack:interview` first (`MSTACK_ROOT/skills/interview/SKILL.md`), then come back.
2. **Route check.** If the request is a fix or a change to an already-built feature, switch to `mstack:bug-fix`. If it's tiny, offer `mstack:quick-fix` (`workflow.md` §1.2) and let the user decide. If you're unsure, ask the user.
3. **Folder.** Name the folder yourself (short kebab-case) and create `spec/<feature>/`.
4. **Mode.** Infer the approval mode from the user's wording (`workflow.md` §4). If it's unclear, ask once. The default is **Gated**.
5. **State.** Record the feature in `state.yaml`.

## Every document step: clarify → write → review → gate

- **Clarify:** list the decisions the step needs and apply the crucial test. **Ask the user** about every crucial unknown (≤5 questions per round, the question format in `decision-policy.md` §10). Minor ones are decided and recorded.
- **Write:** dispatch the writer agent named in the step. Pass it `MSTACK_ROOT`, the folder, the inputs and the answers. If it returns questions, ask them and re-dispatch.
- **Review:** dispatch a fresh, read-only `spec-reviewer`. On FAIL: repair with a fresh writer, at most 3 cycles (`workflow.md` §8).
- **Gate:** per mode, show the document (summary + path) and wait for approval. Record the approval in `state.yaml`.

In Claude Code, the agent names are `mstack:spec-writer`, `mstack:edge-analyst` and so on. Without subagents, run the roles sequentially (`core/roles.md`).

## Steps

1. **Requirements:** clarify slots R1–R9 (`core/interview.md` §8.1). Writer: `spec-writer`, using `templates/requirements.md`. Delete the Fixes line and the Bug section.
2. **Design:** clarify slots G1–G6 (`core/interview.md` §8.2). Writer: `spec-writer`, using `templates/design.md`, with the Project file impact table filled.
3. **Edge cases** (`MSTACK_ROOT/core/edge-cases.md`):
   1. Dispatch `edge-analyst`. It finds the edges and prepares options, but never resolves them.
   2. Have a `spec-reviewer` check the method coverage (§3.9) before the user sees anything.
   3. **You ask the user**, in the order of §5.1:
      - the edge map;
      - new failure policies;
      - S1/S2 edges one by one as scenarios;
      - S3 edges grouped;
      - S4 edges as an approval table;
      - confirmation of covered and policy-resolved edges;
      - finally, "anything else you're worried about?".
   4. Write each resolution into `edge-cases.md` with its source.
   5. Collect the requirement, design and failure-policy changes the resolutions imply (§5.8).
   6. Review. The gate approves the edges **and** those changes together.
4. **Tasks:** writer `spec-writer`, using `templates/tasks.md`: phases A, B… plus `PHASE Z — Break it`; every sub-phase ends with a test task and a `[reviewer]` acceptance task; the planner writes every test case. The reviewer runs the full consistency and shape check (`core/verification.md` §3). At the gate, the user also confirms whether to stop after each phase (the default comes from the mode).
5. **Build:** phase by phase, sub-phase by sub-phase (`workflow.md` §7):
   1. Dispatch `task-worker` for each sub-phase's `[worker]` tasks (a cheaper model is fine) and `[strong]` tasks (strong model).
   2. Dispatch a **fresh** `task-reviewer` for every `[reviewer]` acceptance task.
   3. If the Phase Z bug hunt confirms findings, have `spec-writer` append a repairs sub-phase, then re-run the bug hunt (at most 3 cycles).
   4. After each phase's acceptance, give a phase report (`templates/review.md` §3), and stop if the mode says so.
   4. If a worker hits a crucial question, stop and ask the user (`decision-policy.md` §8).
6. **Final review:** the final acceptance task of Phase Z, run by a fresh `task-reviewer`. Write its result into `tasks.md` → Final review. On FAIL, repair (≤3 cycles). If it's still failing, give the blocked report (`templates/review.md` §6) and stop.
7. **Charts:** ask which chart, as in `core/charts.md` §2: high, low, both or neither. In Pre-authorized mode, make the low-level chart and offer the high-level one. Follow `skills/visualhigh` / `skills/visuallow`.
8. **Done:** set `status: done` in `state.yaml` and give the final report (`templates/review.md` §5). From now on, this folder is never edited. Later changes go through `mstack:bug-fix`.
