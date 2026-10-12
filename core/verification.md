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
| Unit / integration / e2e | task, sub-phase and phase tests |
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

The `spec-reviewer` checks the whole chain before the tasks gate:

- every REQ maps to a design section and at least one task;
- every MUST-HANDLE / SHOULD-HANDLE edge maps to a task and a test;
- the design's Project file impact maps to a project-file update sub-phase;
- the task dependencies reference real IDs and contain no cycles;
- every task has Objective, Implementation, Criteria, Test and Depends on;
- every sub-phase and phase has its own test.

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
