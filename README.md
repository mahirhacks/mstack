# cursor-spec-driven

> Stop vibe coding. Start shipping structured, predictable, token-efficient code with Cursor IDE.

A single `CURSOR.md` file that transforms Cursor into a **spec-driven development machine** — inspired by Kiro IDE's agent workflow, adapted natively for Cursor.

---

## The Problem

Most developers use Cursor like a smarter autocomplete — typing vague prompts, getting mediocre code, then spending hours correcting it. You burn tokens fixing mistakes that should never have happened.

## The Solution

Force a 3-phase gate before any code gets written:

```
Requirements → Design → Tasks → Implementation
```

Cursor won't write a single line of implementation code until you've approved each phase. The result: Composer writes exactly what you meant, first time.

**Real numbers from production use:**
- Composer 2.5 wrote **9,000 lines of code** consuming barely **1% of token budget**
- Planning phase (requirements + design + tasks) with Claude Opus used **~4%**
- Zero back-and-forth correction loops

---

## How It Works

### Phase 1 — Requirements
Cursor turns your idea into structured user stories using EARS notation:
```
WHEN [condition or trigger]
THE SYSTEM SHALL [expected behaviour]
```
Cursor stops and asks for your approval before moving on.

### Phase 2 — Design
Cursor produces a full technical design — architecture, data flow, sequence diagrams, error handling, testing strategy. Another approval gate.

### Phase 3 — Tasks
Cursor breaks the design into discrete, dependency-ordered implementation tasks mapped to specific files. Final approval gate.

### Phase 4 — Implementation
Only now does Cursor write code — one task at a time, announcing what it's doing and checking in after each task.

---

## Quick Start

**1. Copy `CURSOR.md` into your project root**

```
your-project/
  CURSOR.md        ← drop it here
  src/
  ...
```

**2. Set up your folder structure**

```
your-project/
  .cursor/
    steering/
      product.md        ← what your product is
      tech.md           ← your stack and constraints
      structure.md      ← folder layout and naming conventions
    specs/
      [feature-name]/
        requirements.md
        design.md
        tasks.md
  CURSOR.md
  src/
```

**3. Bootstrap steering files (optional but recommended)**

Open Cursor Composer (`Ctrl+I` / `Cmd+I`) and type:
```
Bootstrap this project
```
Cursor will scan your codebase and generate draft steering files for you to review.

**4. Start your first feature**

```
I want to add [feature]. Start with requirements.
```

That's it. Cursor handles the rest.

---

## Key Commands

| What you want | What to type |
|---------------|-------------|
| Start a new feature | `"I want to add [feature]. Start with requirements."` |
| Skip straight to tasks | `"I have a design doc — skip to tasks."` |
| Quick mode (no gates) | `"Quick plan: [feature description]"` |
| Report a bug | `"Bug: [description]. Steps: [steps]. Expected: [X]. Actual: [Y]."` |
| Jump to a specific task | `"Do Task 3."` |
| Check progress | `"What's the current spec status?"` |
| Set up steering files | `"Bootstrap this project"` |

---

## Approval Gates

Cursor will stop and wait at each checkpoint — it will not proceed until you say the word:

| Gate | Phrase to continue |
|------|--------------------|
| After requirements | `"requirements approved"` / `"looks good"` / `"continue"` |
| After design | `"design approved"` / `"looks good"` / `"continue"` |
| After tasks | `"tasks approved, start implementation"` / `"do task N"` |
| After each task | Cursor asks before starting the next |

---

## Recommended Model Setup

This workflow is optimised for a **two-tier model approach**:

| Phase | Recommended Model | Why |
|-------|------------------|-----|
| Requirements + Design | Claude Opus (1M context) | Dense reasoning, edge case coverage |
| Tasks | Claude Sonnet | Fast, structured output |
| Implementation | Cursor Composer 2.5 | Token-efficient, instruction-following |

You get the thinking of an expensive model and the execution speed of a cheap one.

---

## Folder Templates

The repo includes ready-to-use templates for all three steering files:

- `templates/product.md` — product overview, users, objectives, out of scope
- `templates/tech.md` — stack, libraries, preferred patterns, banned alternatives
- `templates/structure.md` — folder layout, naming conventions, architectural decisions

And spec templates:
- `templates/requirements.md` — user stories with EARS acceptance criteria
- `templates/design.md` — architecture, sequence diagrams, error handling
- `templates/tasks.md` — dependency-ordered task list with verifiable completion criteria

---

## Why Not Just Use Kiro IDE?

Kiro has a great spec-driven workflow but it's a separate IDE. This repo brings the same discipline to **Cursor**, which has better model selection, Composer 2.5, and a more mature extension ecosystem. Use whatever IDE you prefer — the spec-driven principle works anywhere.

---

## Contributing

Found a way to improve the workflow? PRs welcome. Especially interested in:
- Stack-specific steering file examples (Next.js, React Native, Django, etc.)
- Alternative task breakdown formats
- Integration with CI/CD pipelines

---

## License

MIT — use it, fork it, adapt it for your team.

---

*Built out of frustration with vibe coding. Tested on a real production React Native + Supabase project.*
