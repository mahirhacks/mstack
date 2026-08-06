# AGENTS.md — MVP Project Operating Rules

Read this file at the start of every agent session.

This repository uses a lightweight spec-driven workflow for meaningful features and risky fixes. The goal is to ship a coherent MVP quickly without allowing agents to guess silently, self-approve, or drift away from the requested product.

## 1. Read Project Context First

Read these files when they exist:

1. Product steering
2. Technical steering
3. Structure and architecture steering
4. Security steering
5. Testing steering
6. Active specification artifacts
7. Nearby code and tests for the area being changed

Preferred fallback locations:

```text
.agent/steering/
.agent/specs/
```

Reuse an existing `.cursor/`, `.kiro/`, `docs/specs/`, or other project convention instead of creating a duplicate structure.

When steering is missing for a new project, inspect the repository and draft the starter files from `steering/` for user review.

## 2. Understand Before Editing

Before changing code:

- identify the requested outcome;
- determine what must remain unchanged;
- inspect the relevant modules, call paths, configuration, schemas, and tests;
- detect the project's normal patterns;
- note unknowns that cannot be inferred;
- check for unrelated uncommitted work and preserve it.

Prefer repository graphs, semantic search, symbol search, and call hierarchy over broad recursive text search when available.

## 3. Direct Change vs Spec Change

Use direct implementation for a tiny, low-risk, easily reversible change.

Use a spec for:

- meaningful new features;
- multi-file changes;
- AI or agent workflow behaviour;
- database or API changes;
- authentication or permission logic;
- risky bug fixes;
- architecture changes;
- ambiguous requests.

When using a spec, do not write implementation code before approved tasks exist.

## 4. Spec Workflow

Default flow:

```text
requirements.md or bugfix.md
→ review
→ user approval
→ design.md
→ review
→ user approval
→ tasks.md
→ consistency review
→ user approval
→ implementation
→ independent final review
```

The user may request `Quick plan`, which skips intermediate user gates but still pauses before implementation unless implementation is also authorized.

## 5. Agent Boundaries

- The parent agent orchestrates.
- Spec writers draft or revise artifacts.
- Workers modify implementation.
- Reviewers are read-only.
- Writers and workers never approve their own work.
- A fresh reviewer should be used for each review pass when possible.

When subagents are unavailable, run the roles sequentially and keep reviewer passes read-only.

## 6. Clarifying Questions

Ask no more than five focused questions at once.

Do not ask for information already available in the repository or steering.

Ask only when the answer materially changes:

- scope;
- user behaviour;
- data or API contracts;
- architecture;
- security;
- migration;
- success criteria.

Put unresolved non-blocking uncertainty in `Open Questions` instead of inventing an answer.

## 7. Implementation Rules

1. Follow approved requirements, design, and tasks.
2. Follow task dependency order.
3. Match nearby code patterns.
4. Do not add a dependency without approval unless the project explicitly pre-authorizes it.
5. Add or update tests for changed behaviour when practical.
6. Keep changes scoped; do not perform unrelated cleanup.
7. Do not leave hidden placeholders or unfinished branches.
8. Do not silently skip or merge tasks.
9. Update task markers: `[ ]`, `[~]`, `[x]`, `[!]`.
10. Explain every deviation from the approved design.
11. Preserve compatibility unless a breaking change is approved.
12. Never place secrets or credentials in version-controlled files.

## 8. MVP Design Rules

Prefer:

- the fewest components needed;
- existing libraries and project patterns;
- one clear path through the product;
- simple data models;
- explicit error behaviour;
- manual operational steps when automation would be premature;
- visible future-work notes outside the active implementation.

Avoid:

- speculative microservices;
- unnecessary plugin systems;
- premature generic frameworks;
- abstractions with only one current consumer;
- infrastructure for hypothetical scale;
- broad refactors unrelated to the MVP outcome.

## 9. Parallel Work

Parallelize only tasks that:

- have no unmet dependencies;
- do not change the same files;
- do not modify the same public contract;
- can be independently tested.

The parent or integration worker combines results and runs the complete verification set.

## 10. Required Pauses

Stop and ask before:

- adding a new external dependency;
- destructive database or filesystem changes;
- production deployment or external side effects;
- changing secrets or credentials;
- materially deviating from the approved design;
- expanding product scope;
- accepting failed critical checks;
- making an unresolved security decision.

## 11. Verification

Run the checks relevant to the project:

- formatter;
- build;
- lint;
- type checking;
- unit tests;
- integration tests;
- migration checks;
- targeted manual smoke test;
- security checks for changed boundaries.

Do not claim a check passed when it was not run. State unavailable tools, environments, and skipped checks.

## 12. Final Delivery

The final report must contain:

- outcome;
- major files or components changed;
- verification performed;
- task completion state;
- approved deviations;
- known limitations;
- final reviewer verdict.

A change is not complete while a critical task is blocked or the final reviewer has returned FAIL.
