# Claude Code Plugin — MVP Spec-Driven Delivery

This directory is a Claude Code plugin wrapper around the canonical `skill/` pack.

## Install

From the repository root:

```bash
claude plugin install ./plugin
```

Or install from a published repository once available:

```bash
claude plugin install <owner>/spec-driven-agents
```

Also copy `AGENTS.md` from the repository root into your project.

## Slash commands

| Command | Purpose |
|---|---|
| `/quick-plan <feature>` | Draft requirements, design, and tasks; pause before implementation |
| `/start-requirements <feature>` | Begin the requirements phase only |
| `/spec-status [feature]` | Report artifact status and next step |
| `/execute-tasks [1.2\|all]` | Run approved subtasks from `tasks.md` |

## Components

- `skills/mvp-spec-driven-delivery/` — synced from `../skill/` (do not edit directly)
- `agents/` — subagent prompts synced from `../skill/agents/`
- `commands/` — slash command definitions

## Maintainers

After editing `../skill/`, run from the repository root:

```bash
./scripts/sync-plugin.sh      # macOS / Linux
.\scripts\sync-plugin.ps1     # Windows
```
