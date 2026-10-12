# mstack

An independent planning skill for building production software with AI coding agents.

**The human makes every crucial decision. The agent plans, builds, and shows you what it built.**

```text
Interview  →  product.md · tech.md · security.md · architecture.md
Feature    →  requirements → design → edge cases → tasks → build → charts
Bug-fix    →  requirements → design → edge cases → tasks → build → charts (before/after)
```

## Install

**Claude Code**

```text
/plugin install mstack --marketplace mahirhacks/Spec-Driven-Agents
```

Other tools (Cursor, Codex, Windsurf…) and the details are in **[INSTALL.md](INSTALL.md)**.

## Skills

| Skill | Does |
|---|---|
| `/mstack:goal` | Interviews you until every crucial fact is answered, then writes the 4 project files |
| `/mstack:product` | Writes or refreshes the 4 project files (also from an existing codebase) |
| `/mstack:feature` | New feature: requirements → design → edge cases → tasks → phased build → charts |
| `/mstack:bug-fix` | Fix or change to a built feature: same steps, with root cause and before/after charts |
| `/mstack:visualhigh` | High-level flowchart (journey with lanes) of what was built |
| `/mstack:visuallow` | Low-level flowchart traced from the code, every box → `file:symbol` |
| `/mstack:mode` | Runs the whole flow, and resumes where it stopped |
| `/mstack:status` | Where everything stands, and what's next |

## How it works

- **The interview** fills a fixed checklist of facts (users, journey, scope, stack, scale, data, roles, compliance…). Each round asks at most 5 questions, vague answers get a follow-up, and trigger words open new questions. It ends with a playback you confirm.
- **Every feature and bug-fix** gets its own folder under `.mstack/spec/`. You approve each document by default (Gated mode). Quick Plan and Pre-authorized modes pause less often, but never let the agent decide crucial things.
- **Edge cases** come after the design. The agent sweeps every step of the design against a fixed checklist, ranks what it finds S1–S4, and **asks you how to handle each one**: serious ones one by one, small ones in an approval table.
- **Tasks** are phases → sub-phases → tasks, with tests at every level. The build runs one phase at a time, and each phase gets its own review.
- **Charts** after the build: high-level or low-level, as you choose. For a bug-fix you get the previous chart with the change in a red box, then the same chart with that area expanded. If nothing renders Mermaid, an HTML viewer opens.
- **No guessing.** Every crucial line in every document says where it came from: you, the repo (confirmed by you), or a choice you delegated. Every reviewer fails anything that was guessed.

## Repository layout

| Path | Purpose |
|---|---|
| `.claude-plugin/` | Claude Code plugin + marketplace manifests |
| `skills/` | The 8 skills (`SKILL.md` each) |
| `agents/` | Subagents: writer, edge analyst, worker, chart maker, 3 read-only reviewers |
| `core/` | Canonical rules: workflow, no-guess policy, interview, edge cases, charts, roles, verification |
| `core/templates/` | Formats for every document, plus the chart viewer |
| `examples/booking/` | A worked example: project files, one feature, one bug-fix with a before/after chart |
| `AGENTS.md` | Rules file to copy into your project |
| `architecture.md` | How mstack itself is designed |
