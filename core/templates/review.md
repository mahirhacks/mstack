# Review and report formats

## 1. Document review (`spec-reviewer`)

```markdown
# Review: <document> — <feature>

## Checks
- ✅ <verified, with evidence>
- ⚠️ <risk or missing evidence>
- ❌ <failure, with evidence>

## Guess audit
- <crucial claims without a valid source tag, or "none found">

## Coverage
- <REQ / design / EDGE / task links checked; gaps>

## Required changes
- <direct instruction>

## Recheck scope
- <sections, files>

## VERDICT: PASS | FAIL
<one-sentence reason>
```

Then the YAML verdict from `core/verification.md` §4.

## 2. Worker report (`task-worker`)

```markdown
# Worker report — Tasks <IDs>

## Done
- 1.1 — <summary> — files: <paths>

## Blocked
- <task — reason — question for the user, if crucial>

## Tests run
- `<command>` → <result>

## Minor decisions made [M]
- <decision — why it's minor>

## Deviations from the design
- none | <what and why>

## New dependencies needed
- none | <dependency — needs user approval>
```

## 3. Phase report (shown to the user after each phase)

```markdown
## Phase <n> done — <phase outcome>

- Sub-phases: <n, each with its acceptance verdict>
- Tasks: <x>/<y> done · blocked: <list or none>
- Test cases: <passed>/<total> (`<command>`)
- Phase acceptance: PASS | FAIL (<cycle n of 3>)
- Minor decisions made: <count, or list if few>
- Next: Phase <n+1> — <outcome>. Continue?
```

## 4. Final review (`task-reviewer`, the final acceptance task of Phase Z, written into tasks.md → "Final review")

```markdown
## Final review — <date>

### Coverage
| Item | Status | Evidence |
|---|---|---|
| REQ-001 | ✅ / ⚠️ / ❌ | <test or file:line> |
| EDGE-003 | ✅ / ⚠️ / ❌ | <test> |

### Checks
- Build: pass | fail | not run (<why>)
- Lint / types: pass | fail | not run
- Tests: <counts> pass | fail
- Smoke (primary journey): pass | fail | not run

### Guess audit
- <undisclosed crucial behaviour in code, or "none found">

### Project files
- <updated as design.md listed | not needed | ❌ missing>

### Deviations
- none | <approved deviation>

### Limitations
- <checks not run, mocks, skipped tests>

### VERDICT: PASS | FAIL
<reason>
```

## 5. Final report (to the user)

```markdown
# Done: <feature or fix>

- Outcome: <what now works>
- Folder: spec/<slug>/
- Changed: <main files or components>
- Verification: <checks and results>
- Tasks: <x>/<y> done; blocked: <none or list>
- Deviations: <none or list>
- Limitations: <list>
- Final review: PASS
- Charts: <shown | offered | not requested>
```

## 6. Blocked report

```markdown
# Blocked: <feature or fix>

- Completed: <valid work>
- Blocker: <issue, evidence>
- Checks: <what passed / failed>
- Decision needed: <one clear question>

Completion is not being claimed.
```
