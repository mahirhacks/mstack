# Review and Delivery Templates

## Spec Review

```markdown
# <Artifact> Review — Score: X/10

## Ground-Truth Checks
- ✅ <finding with evidence>
- ⚠️ <risk or uncertainty>
- ❌ <failure with evidence>

## Coverage
- <requirement, design section, or task coverage>

## Critical / Major Issues
- <issue>

## Minor Findings
- <optional improvement>

## Required Changes
- <specific action>

## Recheck Scope
- <artifact section or repository area>

## VERDICT: PASS | FAIL
<reason>
```

## Implementation Review

```markdown
# Implementation Review — Score: X/10

## Task Coverage
- TASK-001 — complete | blocked | skipped

## Requirement Conformance
- REQ-001 — ✅ | ⚠️ | ❌ — <evidence>

## Code and Architecture
- <finding>

## Verification Evidence
- Build: pass | fail | not run
- Lint: pass | fail | not run
- Type check: pass | fail | not run
- Tests: pass | fail | not run
- Smoke test: pass | fail | not run

## Required Changes
- <specific repair>

## Recheck Scope
- <files, tests, requirements, or tasks>

## VERDICT: PASS | FAIL
<reason>
```

## Worker Report

```markdown
# Worker Report

## Tasks Completed
- TASK-001 — <summary and files>

## Tasks Blocked
- <task and reason>

## Tests and Checks
- <command or check>: <result>

## Deviations
- None | <what differed and why>

## New Dependencies
- None | <dependency requiring approval>

## Summary
<current implementation state>
```

## Final Delivery

```markdown
# Delivery Complete: <Change Name>

## Outcome
<What now works.>

## Approved Artifacts
- Requirements or bugfix: `<path>`
- Design: `<path>`
- Tasks: `<path>`

## Implementation
- <major change>

## Files / Components Changed
- `<path>` — <reason>

## Verification
- <check and result>

## Traceability
- REQ-001 → TASK-001 → <test or observable evidence>

## Deviations
- None | <approved deviation>

## Known Limitations
- None | <limitation>

## Final Verdict
PASS — <reason>
```

## Blocked Delivery

```markdown
# Delivery Blocked: <Change Name>

## Completed
- <work that is valid>

## Remaining Blockers
- <issue, severity, and evidence>

## Checks
- <what passed and failed>

## Decision Needed
- <single next decision>

## Verdict
BLOCKED — completion is not being claimed.
```
