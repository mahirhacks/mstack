# Role Contracts

## Parent / Orchestrator

Owns workflow state.

Responsibilities:

- read project instructions;
- classify the request;
- choose direct, feature, bugfix, design-first, or quick-plan mode;
- ask necessary clarification;
- create or assign spec work;
- enforce approval gates;
- assign implementation tasks;
- track task status and review cycles;
- preserve role separation;
- present final results.

The parent may integrate work, but it must not turn its own implementation opinion into the final independent verdict.

## Spec Writer

Writes or revises exactly one artifact:

- `requirements.md`;
- `bugfix.md`;
- `design.md`;
- `tasks.md`.

Rules:

- verify repository claims;
- follow prior approved artifacts;
- avoid invented modules, files, and behaviour;
- use current project patterns;
- address reviewer feedback completely;
- put unresolved ambiguity in `Open Questions`;
- do not approve or implement.

## Spec Reviewer — Read-Only

Reviews one artifact against:

- user intent;
- prior approved artifacts;
- steering;
- the real repository.

Rules:

- be rigorous;
- verify claims;
- identify concrete gaps;
- do not edit;
- return PASS or FAIL;
- PASS only when no major blocker remains.

Checks by artifact:

### Requirements or Bugfix

- clear and testable behaviour;
- important edge cases;
- confirmed versus open decisions;
- scope and non-goals;
- feasibility against the current product;
- unchanged behaviour for bug fixes.

### Design

- every approved requirement is addressed;
- repository patterns and constraints are respected;
- data flow and contracts are coherent;
- error and security behaviour are covered;
- the design is MVP-sized;
- testing is realistic.

### Tasks

- every requirement and design section is covered;
- main tasks use `Task 1` numbering and executable work lives in `Task 1.1` subtasks;
- every subtask has Objective, Implementation, Criteria, and Test;
- dependencies are correct;
- tasks are independently verifiable;
- file conflicts are identified;
- no implementation work is hidden in vague task descriptions.

## Implementation Worker

Executes assigned approved tasks.

Rules:

- read all approved artifacts first;
- follow dependencies;
- stay inside assigned scope;
- follow nearby code patterns;
- add relevant tests;
- update task status;
- report blocked tasks;
- report design deviations;
- do not add dependencies silently;
- do not self-approve.

## Integration Worker

Use when multiple workers or components are involved.

Responsibilities:

- combine completed outputs;
- resolve shared-file conflicts without changing approved behaviour;
- run generators or migrations;
- run complete verification;
- create a concise evidence summary.

This is still a worker role, not a reviewer role.

## Implementation Reviewer — Read-Only

Checks the integrated repository against:

- requirements or bugfix;
- design;
- tasks;
- project rules;
- test and build evidence.

The reviewer checks:

- task coverage;
- requirement satisfaction;
- design conformance;
- code quality;
- tests;
- basic security;
- scope control;
- operational readiness appropriate for an MVP.

It never repairs source files.

## Model Routing (Optional Cost Control)

Roles are defined by contract, not by model. When the platform can assign a different model per role, route by how much judgment the role needs:

- **Strong model — required:** spec writer, spec reviewer, implementation reviewer. Planning and review are where weak models fail silently: vague specs that don't transfer the thinking, and rubber-stamped reviews of plausible-looking code. A cheap reviewer defeats the entire verification layer.
- **Cheap model — safe:** task workers executing approved subtasks. A well-written subtask requires execution, not judgment: the Objective, Implementation, Criteria, and Test fields already contain the thinking.
- **Either:** the parent/orchestrator and integration worker, since the workflow files script their decisions.

Escalation rule: when a cheap worker fails review twice on the same subtask, reassign that subtask to a strong-model worker instead of spending the third repair cycle on a repeat failure.

This split works only when subtasks are self-contained. The task-writing standard in `templates/spec-templates.md` — an executor with no context beyond the approved artifacts and the repository can complete the subtask — is what makes cheap execution safe. The final independent review is never routed to a cheap model.

## Sequential Fallback

When subagents are unavailable:

1. label the current pass clearly;
2. finish the writer or worker pass;
3. freeze the current artifact or code state;
4. run a reviewer pass without editing;
5. produce a verdict;
6. begin repair only after the review ends.

This preserves useful separation without requiring a complex multi-agent runtime.
