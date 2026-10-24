# Tasks: <Feature or Fix Name>

<!-- Written by a strong model, so that a small model can build it equally well.
     Every decision is made here. A worker task never asks the worker to choose, design or invent anything.

     SHAPE (the reviewer checks it — core/verification.md §3)
     - Phases are lettered A, B, C… and run in order. PHASE Z — Break it is always last.
     - Sub-phases are numbered 1, 2, 3… across the whole file (never restarting per phase).
     - Tasks are <sub-phase>.<n>: 3.1, 3.2… Tasks inside a sub-phase run top to bottom.
     - In every sub-phase:  second-last task = TEST task   ·   last task = ACCEPTANCE task.
       Test task titles contain the word "test"; acceptance task titles start with "Acceptance:".
     - In every phase:      last sub-phase = VERIFICATION sub-phase (phase-level tests, then phase acceptance).
     - Who runs a task:  [worker] any model, cheap is fine · [strong] strong model · [reviewer] fresh read-only reviewer.
     - Test cases are written HERE, by the planner. Workers only turn them into test code and run them.

     Markers: [ ] not started · [~] in progress · [x] done · [!] blocked (with the reason). -->

- Status: Draft | Reviewed | Approved | In progress | Done
- Last updated: <date>

---

## PHASE A — <Outcome the user can check>
- **Covers:** <REQ IDs, EDGE IDs>
- **Phase acceptance:** <observable result, e.g. "a patient can book a free slot; a double-book yields exactly one booking">

### SUB-PHASE 1 — <Slice: one component or flow>
- **Depends on:** — <or sub-phase numbers / task IDs, e.g. 1, 2.3>

#### [ ] 1.1 [worker] — <Unit of work>
- **Files:** `<path>` (create) · `<path>` (edit)
- **Do:**
  1. <exact, code-level step: names, signatures, values>
  2. <step>
- **Pattern:** copy the style of `<existing file:line>`
- **Don't:** <what must not be touched or added>
- **Done when:** <checkable facts>
- **Run:** `<command>` → <expected output>
- **Traces:** <REQ / AC / EDGE / design §>

#### [ ] 1.2 [worker] — <Unit of work>
<same fields>

#### [ ] 1.3 [worker] — Test sub-phase 1
- **Files:** `<test file path>`
- **Pattern:** copy the test style of `<existing test file:line>`
- **Implement exactly these cases:**

  | Case | Scenario | Setup / input | Expected | Traces |
  |---|---|---|---|---|
  | T1.1 | <happy path> | <exact data> | <exact result> | AC-001.2 |
  | T1.2 | <edge case built in this sub-phase> | <exact data> | <exact result> | EDGE-001 |

- **Run:** `<command>` → all <n> cases pass
- **If a case fails:** don't change the code under test. Mark this task `[!]`, report the case and its output. The repair loop fixes it.

#### [ ] 1.4 [reviewer] — Acceptance: sub-phase 1
- **Check each criterion, with evidence:**
  - [ ] <criterion> — verify by: <command / inspection>
  - [ ] T1.1–T1.<n> pass — verify by: `<command>`
  - [ ] no change outside the files listed in 1.1–1.3 — verify by: `git diff --stat`
- **Verdict:** PASS or FAIL (core/verification.md §4)

### SUB-PHASE 2 — <Slice>
- **Depends on:** 1
<build tasks · test task · acceptance task>

### SUB-PHASE 3 — Phase A verification
- **Depends on:** 1, 2

#### [ ] 3.1 [worker] — Phase A integration tests
- **Files:** `<path>` · **Pattern:** `<file:line>`
- **Implement exactly these cases:**

  | Case | Scenario | Setup / input | Expected | Traces |
  |---|---|---|---|---|
  | T3.1 | <components working together> | <…> | <…> | REQ-001 |

- **Run:** `<command>` → all pass · **If a case fails:** mark `[!]` and report.

#### [ ] 3.2 [worker] — Phase A end-to-end test
<same fields: the primary journey of this phase>

#### [ ] 3.3 [reviewer] — Acceptance: Phase A
- **Check, with evidence:**
  - [ ] Phase acceptance: <restated> — verify by: <…>
  - [ ] every task in sub-phases 1–3 is `[x]`
  - [ ] full test suite passes — verify by: `<command>`
  - [ ] build, lint and types pass — verify by: `<commands from tech.md>`
- **Verdict:** PASS or FAIL

---

## PHASE B — <Outcome>
<same shape. The last build phase also contains, before its verification sub-phase,
 a "Project files" sub-phase whenever design.md lists a Project file impact:>

### SUB-PHASE <n> — Update project files
#### [ ] <n>.1 [worker] — Update <architecture.md | tech.md | security.md | product.md>
- **Files:** `.mstack/<file>.md`
- **Do:** <exact section and text change, from design.md Project file impact>
- **Done when:** the file describes the built system · **Traces:** design §Project file impact
#### [ ] <n>.2 [worker] — Test: project files match the code
- **Implement exactly these checks:** <e.g. each new component in architecture.md exists at its path>
#### [ ] <n>.3 [reviewer] — Acceptance: project files updated

---

## PHASE Z — Break it

### SUB-PHASE <a> — Planned attacks
- **Depends on:** every earlier phase
#### [ ] <a>.1 [worker] — Attack tests: <group, e.g. concurrency>
- **Files:** `<path>` · **Pattern:** `<file:line>`
- **Implement exactly these cases** (every MUST-HANDLE / SHOULD-HANDLE edge appears here again, run together):

  | Case | Edge | Attack | Expected | Traces |
  |---|---|---|---|---|
  | T<a>.1 | EDGE-001 | <exact trigger> | <exact handling> | EDGE-001 |

#### [ ] <a>.<n-1> [worker] — Test: run the full attack suite
- **Run:** `<command>` → all pass · **If a case fails:** mark `[!]` and report.
#### [ ] <a>.<n> [reviewer] — Acceptance: every MUST-/SHOULD-HANDLE edge proven

### SUB-PHASE <b> — Bug hunt
- **Depends on:** <a>
#### [ ] <b>.1 [strong] — Hunt: <area, e.g. auth boundaries of POST /api/bookings>
- **Try:** <starting ideas beyond the edge list: inputs, sequences, timing, roles>
- **Budget:** <e.g. 30 attempts or 45 minutes>
- **Don't:** change product code. Record findings only.
- **Output:** findings — steps to reproduce, observed, expected, severity
#### [ ] <b>.<n-1> [strong] — Test: a failing regression test for each confirmed finding
- **Files:** `<path>` · **Run:** `<command>` → each new test fails for the recorded reason
#### [ ] <b>.<n> [reviewer] — Acceptance: findings are real, reproducible and recorded

<!-- If the bug hunt confirms findings, the main agent has spec-writer append a REPAIRS sub-phase here
     (one [worker] task per finding, with exact fix steps; then a test task re-running the regression tests
     and the full attack suite; then a [reviewer] acceptance task), then re-runs the bug hunt. Max 3 cycles.
     A repair that passes the crucial test goes to the user first. -->

### SUB-PHASE <c> — Final verification
- **Depends on:** all
#### [ ] <c>.1 [worker] — Run everything
- **Run:** `<full test suite>` · `<build>` · `<lint/types>` · `<e2e>` → all pass
#### [ ] <c>.2 [reviewer] — Final acceptance (final review)
- **Check, with evidence:** every REQ / AC and every MUST-/SHOULD-HANDLE edge (Coverage table) · guess audit on code · project files updated · deviations disclosed
- **Verdict:** PASS or FAIL, written into "Final review" below

---

## Dependency list
| Sub-phase / task | Depends on |
|---|---|
| 1 | — |
| 2 | 1 |
| 3 | 1, 2 |

## Coverage
| Item | Built in | Tested in | Re-tested in Phase Z |
|---|---|---|---|
| REQ-001 | 1.1, 1.2 | T1.1, T3.1 | T<c> suite |
| EDGE-001 (MUST) | 1.1 | T1.2 | T<a>.1 |

## Parallel groups and file conflicts
- Parallel: <sub-phases or tasks that may run together, or none>
- Conflicts: <file — tasks that must not run together>

## Final review
<!-- Filled by the reviewer at task <c>.2. Format: core/templates/review.md §4. -->
