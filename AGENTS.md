# AGENTS.md — mstack project rules

Read this file at the start of every agent session. This project plans and builds with **mstack**.

## Where mstack lives

`MSTACK_ROOT` is the first of these that exists:

1. `.agent/mstack/`
2. `.cursor/skills/mstack/`
3. the installed Claude Code plugin (skills appear as `/mstack:*`)

The project's own mstack files live in `.mstack/` (project files, `state.yaml`, `spec/`).

## Commands

| Say (any tool) | Claude Code | Runs |
|---|---|---|
| "mstack goal" / "start the mstack interview" | `/mstack:goal` | `MSTACK_ROOT/skills/goal/SKILL.md` |
| "mstack product" | `/mstack:product` | `MSTACK_ROOT/skills/product/SKILL.md` |
| "mstack feature: <what>" | `/mstack:feature` | `MSTACK_ROOT/skills/feature/SKILL.md` |
| "mstack bug-fix: <what>" | `/mstack:bug-fix` | `MSTACK_ROOT/skills/bug-fix/SKILL.md` |
| "mstack high-level chart" | `/mstack:visualhigh` | `MSTACK_ROOT/skills/visualhigh/SKILL.md` |
| "mstack low-level chart" | `/mstack:visuallow` | `MSTACK_ROOT/skills/visuallow/SKILL.md` |
| "mstack mode" / "use mstack" / "continue mstack" | `/mstack:mode` | `MSTACK_ROOT/skills/mode/SKILL.md` |
| "mstack status" | `/mstack:status` | `MSTACK_ROOT/skills/status/SKILL.md` |

When one of these is asked for, read that SKILL.md and follow it.

## Rules that always apply

1. **No guessing on crucial decisions.**
   - Anything a user would notice, anything hard to undo, anything touching security, privacy, money or legal, any vendor or cost commitment, and any change to the project files is decided by the human.
   - Ask, and don't assume. When unsure whether something is crucial, treat it as crucial.
   - Minor internal choices are yours, but list them. (`MSTACK_ROOT/core/decision-policy.md`)
2. **Three flows only:** the interview → the 4 project files; a feature; a bug-fix. A change to a built feature is a bug-fix. A tiny fix (typo, one-liner) skips the flows. (`MSTACK_ROOT/core/workflow.md`)
3. **No building before approval.** Requirements, design, edge cases and tasks are each approved per the approval mode (default: Gated, which means after every document).
4. **Reviewers are read-only, and nobody approves their own work.**
5. **Finished spec folders are never edited.**
6. **Always stop and ask before:**
   - adding a dependency;
   - destructive file or data actions;
   - deploying or other external side effects;
   - touching secrets;
   - deviating materially from the approved design;
   - accepting a failed critical check.
7. **Never put secrets or credentials in version-controlled files.**
8. **Be honest.** Never claim a check passed if it didn't run. Disclose skipped checks and limitations.

## Read before working

- `.mstack/product.md`, `tech.md`, `security.md`, `architecture.md`
- `.mstack/state.yaml`, and the active `spec/<folder>/` documents
- the code and tests near the change
