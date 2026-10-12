# Tasks: <Feature or Fix Name>

<!-- Phases → sub-phases → tasks. The build runs one phase at a time (core/workflow.md §7).
     Write every task so a worker with only the approved documents and the repo can finish it without guessing.
     Markers: [ ] not started · [~] in progress · [x] done · [!] blocked (with the reason). -->

- Status: Draft | Reviewed | Approved | In progress | Done
- Last updated: <date>

## Phase 1 — <Outcome the user can check>
- **Goal:** <what works after this phase>
- **Covers:** <REQ IDs>
- **Exit criteria:** <observable result>
- **Phase test:** <integration / e2e test proving the outcome, and the command to run it>

### Sub-phase 1.1 — <Slice: one component or flow>
- **Objective:** <…>
- **Depends on:** <sub-phase IDs or none>
- **Sub-phase test:** <test and command>

#### [ ] Task 1.1.1 — <Unit of work>
- **Objective:** <what this task achieves>
- **Implementation:** <exact files; the specific change; approach>
- **Criteria:** <verifiable completion>
- **Test:** <test to write or run, and the command>
- **Depends on:** <task IDs or none>
- **Traces:** <REQ / AC / EDGE / design section>

#### [ ] Task 1.1.2 — <Unit of work>
- **Objective:** <…>
- **Implementation:** <…>
- **Criteria:** <…>
- **Test:** <…>
- **Depends on:** 1.1.1
- **Traces:** <…>

## Phase 2 — <Outcome>
<same structure>

## Phase N — Update project files
<!-- Only when design.md lists a Project file impact. -->
### Sub-phase N.1 — Project files
#### [ ] Task N.1.1 — Update <architecture.md | tech.md | security.md | product.md>
- **Objective:** reflect <change> in the project file
- **Implementation:** <section and exact change, from design.md Project file impact>
- **Criteria:** the file matches the built system
- **Test:** chart/structure check against the code; reviewer confirms
- **Depends on:** <tasks that built the change>
- **Traces:** design §Project file impact

## Dependency list
| Task | Depends on |
|---|---|
| 1.1.1 | — |
| 1.1.2 | 1.1.1 |

## Coverage
| Item | Tasks | Test |
|---|---|---|
| REQ-001 | 1.1.1, 1.1.2 | phase 1 test |
| EDGE-003 (MUST-HANDLE) | 2.1.1 | `<test name>` |

## Parallel groups and file conflicts
- Parallel: <task IDs that may run together, or none>
- Conflicts: <file — tasks that must not run together>

## Final review
<!-- Filled after the build: verdict, checks run, deviations, limitations. Format in core/templates/review.md. -->
