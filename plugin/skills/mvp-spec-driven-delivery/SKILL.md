---
name: mvp-spec-driven-delivery
version: 1.0.0
description: >-
  Plans and delivers MVP software through requirements, design, and tasks with
  approval gates, independent review, and bounded repair loops. Use when the user
  asks to "quick plan", "start requirements", "write tasks.md", "spec-driven",
  "requirements approved", "design approved", "tasks approved", "bugfix spec",
  or wants multi-file features, meaningful bug fixes, or agentic workflows
  without chaotic implementation.
---

# MVP Spec-Driven Delivery

## Purpose

Build useful MVP software with enough discipline to avoid chaotic implementation, while keeping the workflow fast.

This skill uses:

- a **direct path** for tiny, low-risk changes;
- a **spec path** for meaningful features and risky fixes;
- explicit user approval before implementation;
- separate writer, worker, and reviewer roles;
- dependency-aware tasks;
- bounded repair loops;
- evidence-based final verification.

Read `AGENTS.md` first when it exists.

## Canonical Rule Locations

Every detailed rule lives in exactly one file. This file and `AGENTS.md` carry summaries; when a summary and a canonical file disagree, the canonical file wins.

| Topic | Canonical file |
|---|---|
| Phases, approval modes, gates, change control | `references/workflow.md` |
| Role contracts (parent, writer, worker, reviewer) | `references/roles.md` |
| Checks, verdicts, repair loops | `references/verification.md` |
| Requirements, design, tasks, bugfix formats | `templates/spec-templates.md` |
| Review, worker report, delivery formats | `templates/review-templates.md` |
| Subagent prompts | `agents/*.md` |
| Complete worked spec to imitate | `examples/feedback-widget/` |

Load these files only when needed.

## Core Principles

1. **The repository is ground truth.** Verify assumptions against real code, configuration, tests, schemas, and project instructions.
2. **Reviewers are read-only.** They inspect and issue verdicts; they do not repair the work they review.
3. **No self-approval.** Writers do not approve specs. Workers do not approve implementations.
4. **No silent scope changes.** Report added dependencies, skipped tasks, design deviations, blockers, and unavailable checks.
5. **User gates matter.** Do not implement a spec-driven change before the required approvals for the active approval mode exist.
6. **Loops are bounded.** Default maximum: three review-and-repair cycles per stage.
7. **Evidence beats confidence.** A PASS requires relevant checks or observable proof.
8. **Keep it MVP-sized.** Prefer the smallest coherent design that satisfies the approved requirements.

## Project Paths

Reuse existing project conventions.

Preferred fallback paths:

```yaml
spec_root: .agent/specs
steering_root: .agent/steering
max_review_cycles: 3
max_clarifying_questions: 5
```

Do not create `.agent/` when the repository already uses `.cursor/`, `.kiro/`, `docs/specs/`, or another established structure.

## Session Start

Before planning or editing:

1. Read the nearest `AGENTS.md`, `CLAUDE.md`, `CURSOR.md`, or equivalent.
2. Read applicable steering files.
3. Detect the stack, package manager, build command, test command, linting, type checking, and deployment shape.
4. Inspect the current repository state and preserve unrelated user changes.
5. Use structured code search, symbol search, or a repository graph before broad text search when available.
6. Record missing tools or unknowns honestly.

## Choose the Path

### Direct Path

Use when the change is all or nearly all of the following:

- one or two files;
- low risk;
- obvious desired behaviour;
- no schema, migration, public API, auth, privacy, or architecture impact;
- easy to test and reverse.

Flow:

```text
define focused contract
→ implement
→ independent review
→ targeted repair if needed
→ deliver
```

### Spec Path

Use when any important condition applies:

- new user-visible feature;
- three or more files or multiple components;
- ambiguous behaviour;
- AI/agent workflow change;
- database, API, auth, permissions, persistence, or migration impact;
- expensive regression risk;
- architectural change;
- user asks for requirements, design, or tasks.

Flow:

```text
requirements.md or bugfix.md
→ independent review
→ user gate (per approval mode)
→ design.md
→ independent review
→ user gate (per approval mode)
→ tasks.md
→ consistency review
→ user gate (per approval mode)
→ implementation
→ independent final review
→ delivery
```

When uncertain, use the spec path.

## Approval Modes

The user chooses how much gating they want. Full definitions live in `references/workflow.md`.

- **Gated** — pause for user approval after requirements, design, and tasks. Default when the mode is unspecified and the change is high-risk or multi-stakeholder.
- **Quick Plan** — draft all artifacts back-to-back with internal reviews, then pause once before implementation.
- **Pre-authorized** — the user authorizes planning and implementation in a single instruction; only Required Pauses interrupt the run.

For solo, low-risk MVP work, suggest Quick Plan when the user has not chosen a mode.

Regardless of mode, pause during implementation only for:

- a new dependency;
- a destructive action;
- a major design deviation;
- an unresolved product decision;
- a security-sensitive decision not covered by the approved spec;
- a blocker that prevents honest completion.

## Artifact Standards

Artifacts must follow `templates/spec-templates.md` exactly. `examples/feedback-widget/` contains a complete requirements → design → tasks set to imitate.

Key invariants:

- requirements use stable `REQ-001` IDs and observable, EARS-style acceptance criteria;
- design covers only what the MVP needs — no speculative infrastructure or abstraction;
- tasks use `Task 1` / `Task 1.1` numbering, and every subtask has exactly four fields: Objective, Implementation, Criteria, Test;
- task markers: `[ ]` not started, `[~]` in progress, `[x]` complete, `[!]` blocked.

## Implementation Standards

Workers follow the contract in `agents/task-worker.md` and `references/roles.md`: dependency order, approved scope only, nearby patterns, tests for changed behaviour, honest status markers, no silent dependencies, no self-approval.

Parallel work is optional. Use it only for genuinely independent tasks that do not modify the same files or shared contracts.

Model routing is optional cost control: strong models plan and review, cheap models may execute well-specified subtasks. Rules and the escalation path live in `references/roles.md` (Model Routing).

## Verification Standards

Reviewers follow `references/verification.md`: evidence-based PASS/FAIL verdicts with required changes and an exact recheck scope. No numeric scores. On FAIL, repair with a fresh worker or writer, re-check, and re-review with a fresh reviewer — at most three cycles per stage, then report the blocker honestly.

Return to the design gate when implementation proves that the approved design is materially invalid.

## Change Control

When requirements change after approval:

1. Update the requirements or bugfix artifact.
2. Identify affected design sections.
3. Identify affected tasks and completed implementation.
4. Re-review the changed artifacts.
5. Ask for approval again only for the affected contract.
6. Continue from the earliest affected phase.

Do not quietly bend the implementation around changed requirements.

## Completion

A change is complete when:

- required artifacts are approved;
- every approved task is complete or explicitly accepted as blocked;
- relevant checks have passed or unavailable checks are disclosed;
- the independent final reviewer returns PASS;
- the parent gives a concise delivery report with files changed, verification, deviations, and known limitations.
