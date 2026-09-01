# MVP Spec-Driven Delivery Pack

A lightweight, reusable agent workflow for building serious MVPs without turning every change into enterprise bureaucracy.

Designed for AI-powered apps, agentic tools, SaaS MVPs, internal automation, and security-oriented developer products.

## Install

See **[INSTALL.md](INSTALL.md)** for per-platform steps (Cursor, Claude Code, Codex, Antigravity, and others).

**Fastest path:**

```bash
# In your project
mkdir -p .agent/mvp-spec-driven-delivery
cp -R skill/. .agent/mvp-spec-driven-delivery/
cp AGENTS.md ./AGENTS.md
```

Then: `Use mvp-spec-driven-delivery. Quick plan: <feature>.`

## Repository layout

| Path | Purpose |
|---|---|
| `skill/` | **Canonical pack** — edit here. Contains `SKILL.md`, agents, references, templates, examples, steering. |
| `AGENTS.md` | Template for project root — copy into every target repo. |
| `plugin/` | Claude Code plugin — slash commands + bundled skill. Run `scripts/sync-plugin.ps1` after editing `skill/`. |
| `INSTALL.md` | Full install guide for every platform. |

## Typical commands

- `Use mvp-spec-driven-delivery. Quick plan: <feature>.`
- `Start requirements for <feature>.`
- `Bug: <problem>. Start with diagnosis.`
- `Requirements approved.` / `Design approved.` / `Tasks approved. Execute all tasks.`
- `Do Task 1.2 only.`
- `Review the current implementation.`
- `What is the current spec status?`

Claude Code plugin slash commands: `/quick-plan`, `/start-requirements`, `/spec-status`, `/execute-tasks`.

## Approval modes

Defined in `skill/references/workflow.md`:

- **Gated** — approve requirements, design, and tasks separately.
- **Quick Plan** — draft all three with internal reviews, pause once before implementation. Default for solo MVP work.
- **Pre-authorized** — `quick plan and implement` authorizes the full run; only required pauses interrupt.

Internal independent reviews and the final verification run in every mode.

## Cost control via model routing

Expensive thinking is front-loaded into the spec so execution can run on a cheaper model:

- **Strong model:** spec writer, spec reviewer, implementation reviewer
- **Cheap model:** task workers executing well-specified subtasks
- **Escalation:** subtask fails review twice → strong-model worker

Full rules: `skill/references/roles.md` (Model Routing).

## Contributing

Edit files under `skill/` only. Then run `scripts/sync-plugin.ps1` (or `.sh`) to refresh `plugin/`.
