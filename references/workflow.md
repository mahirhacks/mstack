# Workflow Reference

## 1. Classify the Request

Record a lightweight classification:

```yaml
path: direct | spec
type: feature | bugfix | refactor | migration | operational
scope: small | medium | large
risk: low | medium | high
ambiguity: low | medium | high
security_impact: none | possible | material
reason: <one sentence>
```

Use the spec path when one meaningful risk factor exists. This workflow is intentionally biased toward planning multi-file MVP features, but it should not turn typo fixes into documents.

## 2. Direct Path

### D1 — Focused Contract

State:

- intended outcome;
- likely files or components;
- unchanged behaviour;
- verification method.

### D2 — Implement

Make the smallest coherent change. Add a focused test when behaviour changes.

### D3 — Review

A read-only reviewer checks the requested behaviour, relevant tests, nearby patterns, and unrelated changes.

### D4 — Repair

On FAIL, repair only the affected area and re-review. Maximum three cycles.

### D5 — Deliver

Report the result, files changed, checks run, and limitations.

## 3. Feature Spec Path

### Phase 1 — Requirements

Create:

```text
<spec-root>/<feature-name>/requirements.md
```

Requirements should capture:

- product outcome;
- users or actors;
- core stories;
- acceptance criteria;
- edge cases;
- non-functional constraints that matter now;
- out of scope;
- open questions.

Run an independent requirements review. After PASS, ask for user approval.

### Phase 2 — Design

Create:

```text
<spec-root>/<feature-name>/design.md
```

Design should explain the smallest viable technical approach and how it fits the current repository.

Run an independent design review against requirements and the repository. After PASS, ask for user approval.

### Phase 3 — Tasks

Create:

```text
<spec-root>/<feature-name>/tasks.md
```

Tasks must be ordered by dependency and mapped to requirements and design sections.

Run two consistency checks:

- requirements ↔ design;
- design ↔ tasks.

After PASS, ask for user approval.

### Phase 4 — Implementation

After tasks are approved:

1. Mark selected tasks `[~]`.
2. Implement in dependency order.
3. Use parallel workers only for independent, non-conflicting tasks.
4. Run focused checks during implementation.
5. Mark completed tasks `[x]`.
6. Mark blocked tasks `[!]` with reasons.
7. Integrate all outputs.
8. Run final checks.
9. Send the complete result to a fresh read-only reviewer.

## 4. Bugfix Spec Path

Use `bugfix.md` instead of `requirements.md`.

The bugfix artifact must include:

- environment and reproduction;
- current behaviour;
- expected behaviour;
- root cause supported by repository evidence;
- unchanged behaviour that must not regress;
- fix boundary;
- verification plan.

Then continue through design, tasks, implementation, and final review.

## 5. Design-First Path

Use design-first when the user already has a concrete architecture, protocol, migration design, or technical constraint.

1. Draft or normalize `design.md`.
2. Derive explicit requirements from the design.
3. Reconcile conflicts between desired behaviour and proposed architecture.
4. Review both artifacts.
5. Obtain approval before tasks.

Design-first never removes requirements traceability.

## 6. Quick Plan

Quick Plan is for a well-understood feature.

The agent:

1. creates requirements or bugfix;
2. reviews and repairs it;
3. creates design;
4. reviews and repairs it;
5. creates tasks;
6. runs consistency review;
7. presents the whole plan;
8. pauses before implementation unless implementation was also explicitly authorized.

## 7. Approval Phrases

Treat clear equivalents as approval:

```text
requirements approved
design approved
tasks approved
looks good
continue
start implementation
execute all tasks
do task <id>
```

Do not treat unrelated positive language as approval when the user's intent is unclear.

## 8. Mid-Flight Requirement Change

When the user changes an approved requirement:

1. update the requirement;
2. identify affected design sections;
3. identify affected tasks and code;
4. invalidate only the affected approvals;
5. re-review the changed scope;
6. continue from the earliest affected phase.

## 9. Loop Guardrails

Default:

```yaml
max_cycles_per_stage: 3
fresh_reviewer_each_cycle: true
targeted_repairs: true
honest_exhaustion_report: true
```

When exhausted:

- stop;
- keep the repository coherent;
- report what passed;
- report what remains;
- identify the decision needed;
- never claim completion.
