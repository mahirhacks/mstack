---
name: mvp-spec-driven-delivery
description: A lightweight, project-agnostic workflow for planning, implementing, and independently reviewing MVP-level software changes. Use for multi-file features, meaningful bug fixes, AI products, SaaS applications, agentic tools, and other work that benefits from requirements, design, tasks, approval gates, and bounded repair loops without enterprise-heavy process.
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

Load detailed files only when needed:

- `references/workflow.md` — phases, gates, and change control.
- `references/roles.md` — parent, writer, worker, and reviewer contracts.
- `references/verification.md` — checks, verdicts, and repair loops.
- `templates/spec-templates.md` — requirements, design, tasks, and bugfix templates.
- `templates/review-templates.md` — review and delivery formats.
- `agents/*.md` — reusable subagent prompts.

## Core Principles

1. **The repository is ground truth.** Verify assumptions against real code, configuration, tests, schemas, and project instructions.
2. **Reviewers are read-only.** They inspect and issue verdicts; they do not repair the work they review.
3. **No self-approval.** Writers do not approve specs. Workers do not approve implementations.
4. **No silent scope changes.** Report added dependencies, skipped tasks, design deviations, blockers, and unavailable checks.
5. **User gates matter.** Do not implement a spec-driven change before requirements, design, and tasks are approved.
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
→ user approval
→ design.md
→ independent review
→ user approval
→ tasks.md
→ consistency review
→ user approval
→ implementation
→ independent final review
→ delivery
```

When uncertain, use the spec path.

## Workflow Modes

### Requirements-First

Default for new features. Define behaviour first, then design the implementation.

### Design-First

Use when the user already provides a technical architecture or strict constraint. Reconcile the design with explicit requirements before generating tasks.

### Quick Plan

Use only when explicitly requested.

Quick Plan creates requirements, design, and tasks back-to-back, reviews them, and pauses before implementation unless implementation was also explicitly authorized.

### Bugfix

Use `bugfix.md` instead of `requirements.md`. Capture:

- reproduction;
- current incorrect behaviour;
- expected behaviour;
- root cause;
- unchanged behaviour that must not regress;
- proposed fix boundary.

## Default Approval Gates

Stop after each reviewed artifact:

1. Requirements or bugfix approval.
2. Design approval.
3. Tasks approval.

After tasks are approved, the agent may execute all approved tasks without asking after every task, unless the user requested task-by-task control.

Pause during implementation only for:

- a new dependency;
- a destructive action;
- a major design deviation;
- an unresolved product decision;
- a security-sensitive decision not covered by the approved spec;
- a blocker that prevents honest completion.

## Planning Standards

### Requirements

Requirements must:

- use stable IDs such as `REQ-001`;
- describe user value and observable behaviour;
- use EARS-style criteria where useful:
  `WHEN <condition> THE SYSTEM SHALL <behaviour>`;
- define in-scope and out-of-scope behaviour;
- identify important edge cases;
- separate confirmed decisions from open questions.

### Design

Design must cover only what the MVP needs:

- affected and new components;
- main data flow;
- data models and API changes;
- error handling;
- auth, validation, privacy, and secrets;
- testing strategy;
- deployment or migration notes when applicable;
- important trade-offs and deliberate non-goals.

Do not add infrastructure, abstraction, or extensibility without a current requirement.

### Tasks

Tasks must:

- use stable IDs such as `TASK-001`;
- map back to requirements;
- list dependencies;
- name expected files or components;
- include a verifiable `Done when`;
- identify tasks that touch the same file;
- be small enough for focused review.

Task markers:

```text
[ ] not started
[~] in progress
[x] complete
[!] blocked
```

## Implementation Standards

Workers must:

1. Read approved requirements or bugfix, design, tasks, and steering.
2. Follow dependency order.
3. Inspect nearby code before introducing new patterns.
4. Keep changes inside approved scope.
5. Add tests for changed behaviour when practical.
6. Run the narrowest relevant checks during each task.
7. Update task markers.
8. Report blockers and deviations.
9. Avoid unapproved dependencies.
10. Never mark their own work approved.

Parallel work is optional. Use it only for genuinely independent tasks that do not modify the same files or shared contracts.

## Verification Standards

The final reviewer checks:

- task coverage;
- requirement satisfaction;
- design conformance;
- code correctness and project-pattern fit;
- build, lint, type, and tests where applicable;
- basic security and data-boundary handling;
- no unexplained scope creep;
- no broken references or unfinished placeholders;
- manual smoke behaviour when automation is insufficient.

A PASS means no critical or major issue blocks the MVP's intended use.

A FAIL must include:

- failed checks;
- severity;
- concrete evidence;
- required changes;
- exact recheck scope.

## Repair Loop

On FAIL:

1. Send structured feedback to a fresh worker or writer.
2. Repair the affected scope first.
3. Re-run relevant checks.
4. Use a fresh reviewer.
5. Stop after three failed cycles and report the blocker honestly.

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

Keep the detailed execution rules in the linked references instead of expanding this entry file.
