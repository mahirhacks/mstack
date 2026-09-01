# Installation Guide

This pack has two layers:


| Layer                           | Purpose                                                               | Install target                            |
| ------------------------------- | --------------------------------------------------------------------- | ----------------------------------------- |
| **Skill pack** (`skill/`)       | Workflow orchestration — planning, review, task format, model routing | Tool skill directory or project `.agent/` |
| **Project rules** (`AGENTS.md`) | Session contract — read steering, follow gates, no self-approval      | Target project root                       |


Install both for the full experience.

---

## Quick start (any project)

1. Copy `skill/` into your project as `.agent/mvp-spec-driven-delivery/`
2. Copy `AGENTS.md` into your project root (merge with an existing file if needed)
3. Copy `skill/steering/*` into `.agent/steering/` and customize
4. Say: `Use mvp-spec-driven-delivery. Quick plan: <feature>.`

Generated specs go in `.agent/specs/<feature-name>/` unless your project already uses another convention.

---

## Cursor

### Personal skill (all your projects)

**Windows (PowerShell):**

```powershell
$dest = "$env:USERPROFILE\.cursor\skills\mvp-spec-driven-delivery"
New-Item -ItemType Directory -Force -Path $dest | Out-Null
Copy-Item -Path "skill\*" -Destination $dest -Recurse -Force
```

**macOS / Linux:**

```bash
mkdir -p ~/.cursor/skills/mvp-spec-driven-delivery
cp -R skill/. ~/.cursor/skills/mvp-spec-driven-delivery/
```

Then copy `AGENTS.md` and the skill pack into each project (see Quick start), or reference the personal skill path in your project's `AGENTS.md`.

### Project skill (shared with the team)

```bash
mkdir -p .cursor/skills/mvp-spec-driven-delivery
cp -R skill/. .cursor/skills/mvp-spec-driven-delivery/
cp AGENTS.md ./AGENTS.md
```

Commit `.cursor/skills/mvp-spec-driven-delivery/` and `AGENTS.md` so everyone gets the same workflow.

### Invoke

```
Use mvp-spec-driven-delivery. Quick plan: add user notifications.
```

---



## Claude Code

### Option A: Plugin (recommended)

From this repository:

```bash
claude plugin install ./plugin
```

Or from a published copy:

```bash
claude plugin install <owner>/spec-driven-agents
```

Slash commands after install:

- `/quick-plan <feature>`
- `/start-requirements <feature>`
- `/spec-status [feature]`
- `/execute-tasks [1.2|all]`

Also copy `AGENTS.md` into your project root and optionally install the skill pack locally (Quick start).

### Option B: User skill only

**Windows (PowerShell):**

```powershell
$dest = "$env:USERPROFILE\.claude\skills\mvp-spec-driven-delivery"
New-Item -ItemType Directory -Force -Path $dest | Out-Null
Copy-Item -Path "skill\*" -Destination $dest -Recurse -Force
```

**macOS / Linux:**

```bash
mkdir -p ~/.claude/skills/mvp-spec-driven-delivery
cp -R skill/. ~/.claude/skills/mvp-spec-driven-delivery/
```

Copy `AGENTS.md` into each project you work on.

---



## Codex / repo-instructions-first tools

Codex and similar agents read project instructions every session rather than a skill registry.

1. Copy `skill/` to `.agent/mvp-spec-driven-delivery/` in your project
2. Copy `AGENTS.md` to the project root
3. The agent resolves workflow files from `.agent/mvp-spec-driven-delivery/`

No separate skill registration needed.

---



## Antigravity / Windsurf / other IDEs

These tools typically use project rules instead of a formal skill folder.

1. Copy `skill/` to `.agent/mvp-spec-driven-delivery/`
2. Copy `AGENTS.md` to the project root (or merge into `.windsurfrules` / your IDE's rules file)
3. Point rules at `.agent/mvp-spec-driven-delivery/SKILL.md` for on-demand workflow loading

---



## Maintainers: sync the Claude plugin

`skill/` is the single canonical source. After editing `skill/`, refresh the plugin bundle:

**Windows:**

```powershell
.\scripts\sync-plugin.ps1
```

**macOS / Linux:**

```bash
./scripts/sync-plugin.sh
```

This copies `skill/` into `plugin/skills/mvp-spec-driven-delivery/` and `skill/agents/` into `plugin/agents/`.

---



## Verify installation

1. Confirm the skill pack exists at one of:
  - `.agent/mvp-spec-driven-delivery/SKILL.md`
  - `.cursor/skills/mvp-spec-driven-delivery/SKILL.md`
  - `~/.cursor/skills/mvp-spec-driven-delivery/SKILL.md`
2. Confirm `AGENTS.md` is in the project root
3. Ask the agent: `What is the current spec status?` or run `/spec-status` (Claude Code plugin)
4. Try a small feature: `Quick plan: add a health check endpoint`

---



## Directory reference

```text
spec-driven-agents/
├── skill/                  # canonical portable pack — edit here
│   ├── SKILL.md
│   ├── agents/
│   ├── references/
│   ├── templates/
│   ├── examples/
│   └── steering/
├── AGENTS.md               # template → copy to project root
├── plugin/                 # Claude Code plugin wrapper
│   ├── .claude-plugin/plugin.json
│   ├── skills/mvp-spec-driven-delivery/   # synced from skill/
│   ├── agents/                            # synced from skill/agents/
│   └── commands/
├── scripts/
│   ├── sync-plugin.ps1
│   └── sync-plugin.sh
├── INSTALL.md
└── README.md
```

