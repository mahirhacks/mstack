# Workflow

The canonical rules for mstack's flows, gates, approval modes, state and build execution. When a skill file and this file disagree, this file wins.

## 1. The three flows

```text
Interview  →  product.md · tech.md · security.md · architecture.md
Feature    →  spec/<feature>/    requirements → design → edge-cases → tasks → build → charts
Bug-fix    →  spec/fix-<name>/   requirements → design → edge-cases → tasks → build → charts
```

There is no other flow: no "feature update" and no "extend". A change to an existing feature is either a **new feature** or a **bug-fix**. A big change to an existing feature is a bug-fix.

### 1.1 Routing a request

| Request | Route |
|---|---|
| No project files yet | the interview first (`mstack:goal`), then the request |
| Something new | feature (`mstack:feature`) |
| Something wrong, or a change to a feature that is already built | bug-fix (`mstack:bug-fix`) |
| Tiny: a typo, a one-liner, a config value; no schema, API, auth, security or data impact; ≤2 files | tiny-fix path (§1.2) |

When the route is unclear, ask the user (one question). Don't guess it.

### 1.2 Tiny-fix path

```text
state the change in one line → make it → read-only review → report
```

There are no spec files and no charts unless the user asks. If the fix turns out to be bigger than tiny while you're working on it, stop and route it as a bug-fix.

## 2. Project root and files

Use `.mstack/` in the target project. If the project already keeps specs somewhere else (for example `.kiro/` or `docs/specs/`), ask the user once whether to use `.mstack/` or that folder, with the same inner layout, and record the answer in `state.yaml` as `root:`.

```text
.mstack/
├── product.md
├── tech.md
├── security.md
├── architecture.md
├── state.yaml
├── .gitignore            # contains: .cache/
├── .cache/               # chart viewers (never committed)
└── spec/
    ├── <feature>/
    │   ├── requirements.md
    │   ├── design.md
    │   ├── edge-cases.md
    │   ├── tasks.md
    │   └── visuals/      high.md · low.md
    └── fix-<name>/
        ├── requirements.md   # starts with "Fixes: <feature>"
        ├── design.md
        ├── edge-cases.md
        ├── tasks.md
        └── visuals/      high.md · low.md · high.diff.md · low.diff.md
```

- The agent names folders itself: a short kebab-case slug. Bug-fix folders start with `fix-`.
- **A finished (`done`) folder is never edited again.** Later changes to that feature go into new bug-fix folders.
- A folder that isn't `done` yet is revised in place under change control (§6).

## 3. Steps of a feature or bug-fix

Each step runs the same cycle:

```text
clarify (ask crucial unknowns)  →  write  →  read-only review (≤3 repair cycles)  →  user gate
```

| # | Step | Writer | Output | Rules |
|---|---|---|---|---|
| 1 | Requirements | `spec-writer` | `requirements.md` | `templates/requirements.md`; clarify slots R1–R10 in `interview.md` §8 |
| 2 | Design | `spec-writer` | `design.md` | `templates/design.md`; clarify slots G1–G6 in `interview.md` §8 |
| 3 | Edge cases | `edge-analyst` finds, main agent asks | `edge-cases.md` | `edge-cases.md` (the rules file) + `templates/edge-cases.md` |
| 4 | Tasks | `spec-writer` | `tasks.md` | `templates/tasks.md` |
| 5 | Build (phases A … Z) | `task-worker` + `task-reviewer` | code + tests | §7 |
| 6 | Final review | `task-reviewer` | the last acceptance task of Phase Z → Final review section of `tasks.md` | `verification.md` |
| 7 | Charts | `chart-maker` | `visuals/` | `charts.md` |

The clarify part follows `decision-policy.md` §4. Questions are always asked by the **main agent**, because subagents can't talk to the user. A writer that finds a crucial unknown returns it as a question instead of guessing.

Writing for a bug-fix differs only in the Bug section of `requirements.md` (see the template) and in the charts: a before/after red-box diff (`charts.md` §7).

## 4. Gates and approval modes

A **gate** is a pause where the user approves the reviewed document. Ask the user for a mode once per flow when it isn't clear from their wording. The default is **Gated**.

| Gate | Gated (default) | Quick Plan | Pre-authorized |
|---|---|---|---|
| Project files (after interview) | stop | stop | stop |
| Requirements | stop | — | — |
| Design | stop | — | — |
| Edge cases | stop | — | — |
| Tasks (before building) | stop | stop | — |
| After each build phase | stop | stop | — |
| Which chart | ask | ask | low-level made automatically; high-level offered |

"—" means no pause, but the read-only review must still PASS.

- **Gated** is the default, and is what the user gets with "plan this feature".
- **Quick Plan** is selected by phrases like "quick plan", "plan it all then show me".
- **Pre-authorized** is selected only by an explicit instruction like "plan and build", "do it all", "pre-authorized".

**Modes change when the agent pauses, never who decides.** These always stop the run, in every mode:

- a new crucial question (`decision-policy.md`);
- a new dependency;
- a destructive action (deleting data or files, dropping tables, force-pushing);
- external side effects (deploying, sending messages, calling paid APIs for real);
- changing secrets or credentials;
- a material deviation from the approved design;
- an exhausted repair loop or a blocker.

### 4.1 Approval phrases

Treat clear equivalents of these as approval of the document at the current gate: `approved`, `looks good`, `continue`, `go ahead`, `yes`. Treat "approved, but change X" as **not approved yet**: make the change, review it, and show it again. When the intent is unclear, ask.

## 5. Interview flow

```text
mstack:goal (interview, playback confirmed) → mstack:product (writes 4 files) → review → project-files gate
```

The rules are in `interview.md`. `mstack:product` can also run alone on an existing codebase: derive what it can from the repo, confirm the repo facts with the user, and ask only about the gaps.

**Project files drift.** When a feature changes the system's shape, stack, security or failure policies, its `design.md` lists the change under **Project file impact**. `tasks.md` then ends with a sub-phase that updates those files, and the final reviewer fails the build if the update is missing.

## 6. Change control (unfinished folders)

When the user changes something that was already approved in a folder that isn't `done`:

1. update the changed document;
2. find the later documents and code affected by it;
3. invalidate only those approvals (record this in `state.yaml`);
4. re-review the changed scope;
5. continue from the earliest affected step.

Don't bend the implementation quietly around a changed requirement.

## 7. Build execution

`tasks.md` has a fixed shape (`templates/tasks.md`):

- **Phases** A, B, C… run in order, and `PHASE Z — Break it` is always last.
- **Sub-phases** are numbered across the whole file, and **tasks** are `<sub-phase>.<n>`.
- **In every sub-phase:** the second-last task is a **test** task, and the last is an **acceptance** task.
- **In every phase:** the last sub-phase is the **verification** sub-phase.

### 7.1 Who runs a task

| Tag | Run by | Notes |
|---|---|---|
| `[worker]` | `task-worker`, any model, cheap is fine | builds exactly what the task card says; implements the planner's test cases |
| `[strong]` | `task-worker` on a strong model | only for the Phase Z bug hunt |
| `[reviewer]` | a **fresh, read-only** `task-reviewer` | every acceptance task; never the model that built it |

### 7.2 The loop

```text
for each phase (A, B, … , Z):
    for each sub-phase (in order, after its "depends on"):
        build tasks, top to bottom: do the card → run its check → [x]
        test task: implement the planner's cases exactly → run
            a failing case → [!] → repair loop (§8); never weaken a test to make it pass
        acceptance task: fresh task-reviewer checks each criterion with evidence → PASS / FAIL
    the phase's verification sub-phase ends with the phase acceptance (the phase review)
    gate per mode: phase report, then stop or continue
```

### 7.3 Phase Z — Break it

1. **Planned attacks:** every MUST-HANDLE / SHOULD-HANDLE edge, re-run together as exact attack cases.
2. **Bug hunt** (`[strong]`): try to break the system beyond the edge list. No product code changes; findings only. Each confirmed finding gets a failing regression test.
3. **Repairs**, when there are findings: `spec-writer` appends a repairs sub-phase in the same shape:
   - one `[worker]` task per finding, with exact fix steps;
   - a test task that re-runs the regression tests and the full attack suite;
   - a `[reviewer]` acceptance task.

   A repair that passes the crucial test goes to the user first. The bug hunt then runs again, with at most 3 repair cycles.
4. **Final verification:** run everything. Its acceptance task **is the final review** (written into `tasks.md` → Final review).

### 7.4 Rules

- **Markers:** `[ ]` not started · `[~]` in progress · `[x]` done · `[!]` blocked (with the reason).
- **A worker never improvises.** If a card is unclear, incomplete or wrong, it marks the task `[!]` and reports. The main agent fixes the card (a crucial gap goes to the user) instead of letting the worker guess.
- **Parallel work:** only sub-phases or tasks with no unmet dependencies that touch different files and different public contracts. Afterwards the main agent integrates the results and runs the full checks.
- **Failing work:** a failed test or acceptance goes through the repair loop (§8). The build never moves on while the current sub-phase is failing.
- **Questions during the build:** a crucial question stops the build (`decision-policy.md` §8). Workers may continue only with tasks that don't depend on it.
- **Phase report:** format in `templates/review.md` §3.

## 8. Review and repair loops

- Every document and every phase gets a **fresh, read-only reviewer**.
- On FAIL: repair only the failed scope with a fresh writer or worker, re-run the affected checks, then review again with a fresh reviewer.
- **At most 3 cycles per step.** When they're exhausted, stop: keep the repo coherent, report what passed and what remains, name the decision needed, and never claim completion.

## 9. `state.yaml`

This is the resume state, and the only machine-maintained file. Keep it small.

```yaml
mode: gated                      # gated | quick-plan | pre-authorized
project_files: approved          # missing | draft | approved
interview:                       # only while an interview is unfinished
  phase: 6
  open_slots: [A5, A6, S1]
features:
  booking:
    status: done                 # requirements | design | edge-cases | tasks | build | review | charts | done
    approved: { requirements: 2026-10-12, design: 2026-10-12, edge-cases: 2026-10-13, tasks: 2026-10-13 }
  fix-double-booking:
    fixes: booking
    status: build
    phase: 2
    approved: { requirements: 2026-10-20, design: 2026-10-20, edge-cases: 2026-10-20, tasks: 2026-10-21 }
charts:                          # newest chart of each feature: the "before" for its next bug-fix
  booking:
    high: spec/booking/visuals/high.md
    low: spec/booking/visuals/low.md
```

Update it after every gate, every phase, and every chart.

## 10. Completion

A feature or bug-fix is `done` when:

- requirements, design, edge cases and tasks are approved;
- every task is `[x]`, or `[!]` explicitly accepted by the user;
- the relevant checks ran and passed, or the ones that couldn't run are disclosed;
- the final reviewer returned PASS;
- the project files are updated if the design listed an impact;
- the user has been asked about charts (or the low-level chart was made, in Pre-authorized mode);
- the final report was given (`templates/review.md`).
