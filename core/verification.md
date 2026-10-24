# Verification

The canonical rules for checks, verdicts and evidence.

## 1. Checks

Run the checks that matter for the change. `tech.md` lists the project's commands.

| Area | Evidence |
|---|---|
| Requirements | each acceptance criterion maps to a passing test or an observed behaviour |
| Edge cases | each MUST-HANDLE / SHOULD-HANDLE edge maps to a passing test |
| Build | build command succeeds |
| Lint / format / types | lint, formatter and type-check results |
| Unit / integration / e2e | the planner's test cases in each sub-phase's test task, the verification sub-phase of each phase, and Phase Z |
| Data | migration runs; rollback works where the design promised it |
| Security | auth, permissions, validation, secrets and input boundaries from `security.md` |
| Project files | updated when the design listed a Project file impact |
| Smoke | the primary journey run end to end, when possible |

A missing check that doesn't apply isn't a failure. A missing check that does apply must be disclosed, and blocks PASS when it's critical.

## 2. Guess audit (every review)

FAIL when any crucial claim or behaviour:

- has no source tag;
- is tagged `[M]` (minor) even though it passes the crucial test;
- rests on a repo fact the user never confirmed;
- is still open (`[?]`) at its gate;
- exists in code without tracing back to an approved document or a recorded user decision (final review).

The full rules are in `decision-policy.md` §9.

## 3. Consistency check (tasks review)

The `spec-reviewer` checks the whole chain, and the plan's shape, before the tasks gate. FAIL on any miss.

**Coverage**

- every REQ maps to a design section and at least one task;
- every MUST-HANDLE / SHOULD-HANDLE edge is tested twice: in the sub-phase that builds it, and again in Phase Z's planned attacks;
- the design's Project file impact maps to an "Update project files" sub-phase.

**Shape** (`templates/tasks.md`)

- phases are lettered and run in order, and `PHASE Z — Break it` is last;
- sub-phases are numbered across the whole file, and tasks are `<sub-phase>.<n>`;
- in every sub-phase, the second-last task is a test task and the last is a `[reviewer]` acceptance task;
- in every phase, the last sub-phase is the verification sub-phase, ending with the phase acceptance;
- Phase Z has planned attacks, a `[strong]` bug hunt, and final verification;
- dependencies reference real IDs and contain no cycles.

**Small-model readiness**

- Every `[worker]` card has Files, Do, Pattern, Don't, Done when, Run and Traces.
- It names exact paths, symbols and values, and leaves **no decision** to the worker.
- Each card is about one or two files and roughly ≤150 changed lines. Bigger work is split.
- Every test task lists its exact cases (input → expected). "Write tests for X" without cases is a FAIL.
- Every acceptance task lists criteria, each with how to verify it.

## 4. Verdict

Every review ends with:

```yaml
verdict: pass | fail
failed_checks:
  - id: <check>
    severity: critical | major | minor
    evidence: <file, command, output, or document section>
required_changes:
  - <direct instruction>
recheck_scope:
  - <document section, files, tests>
```

- **PASS:** no critical or major issue, the approved scope is complete, and the relevant checks passed or their absence is disclosed and accepted. Minor polish can wait.
- **FAIL:** at least one critical or major issue.

Never PASS because something *looks* right. PASS needs evidence: a command and its output, a test result, or a cited file and line.

## 5. Honest limitations

The final report must state:

- checks not run;
- unavailable services;
- skipped or flaky tests;
- mocked integrations;
- unverified migrations;
- blocked tasks;
- known limitations.
