# Verification and Repair Reference

## 1. Verification Matrix

Use only checks relevant to the change.

| Area | Typical evidence |
|---|---|
| Requirements | acceptance criteria mapped to tests or observable behaviour |
| Build | successful build command |
| Formatting | formatter check or clean diff |
| Static analysis | lint and type-check results |
| Unit behaviour | targeted unit tests |
| Integration | API, database, or component tests |
| Runtime | manual smoke test or local run |
| Data | migration, schema, and rollback checks |
| Security | auth, permission, validation, secret, and input-boundary checks |
| Documentation | updated setup, API, or user instructions when needed |

A missing irrelevant check is not a failure. A missing relevant critical check must be disclosed and may block PASS.

## 2. Reviewer Verdict

Every review must end with one verdict:

```yaml
verdict: pass | fail
failed_checks:
  - id: <check id>
    severity: critical | major | minor
    evidence: <file, command, behaviour, or artifact>
required_changes:
  - <direct instruction>
recheck_scope:
  - <artifact, file, test, or requirement>
```

### PASS

PASS means:

- no critical or major defect blocks the intended MVP use;
- the approved scope is complete;
- relevant checks pass or limitations are explicitly accepted;
- minor polish can be deferred.

### FAIL

FAIL means at least one critical or major issue requires repair.

## 3. Human-Readable Review

```markdown
# Review

## Scope
- <what was reviewed>

## Checks
- ✅ <verified result>
- ⚠️ <risk or unavailable evidence>
- ❌ <failed result>

## Required Changes
- <specific instruction>

## Recheck Scope
- <exact files, requirements, tasks, or checks>

## VERDICT: PASS | FAIL
<one-sentence reason>
```

## 4. Repair Process

On FAIL:

1. extract exact failed checks;
2. assign a fresh writer or worker;
3. repair the smallest affected scope;
4. re-run affected checks plus integration checks that could regress;
5. use a fresh reviewer;
6. repeat no more than three times.

Do not repeat the same failed approach without changing the plan.

## 5. Final Smoke Test

For an MVP, perform a short end-to-end test of the primary user path when possible.

Examples:

- create account → authenticate → complete the core action;
- submit input → agent processes it → result is stored and displayed;
- create record → update it → retrieve it;
- start local service → call main API → observe expected output.

Do not substitute a smoke test for unit or integration checks when those are clearly required.

## 6. Honest Limitations

The delivery report must explicitly state:

- checks not run;
- unavailable services or environments;
- flaky or skipped tests;
- unverified migrations;
- mocked external integrations;
- known limitations;
- blocked tasks.

Never report `PASS` merely because the code looks plausible.
