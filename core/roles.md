# Roles

The canonical role contracts. Each role's subagent prompt is in `agents/`.

## Main agent (orchestrator)

- Reads `AGENTS.md`, the project files and `state.yaml` at the start.
- **Asks the user every question.** Subagents can't. They return questions to the main agent instead of guessing.
- Runs the flow from `workflow.md`, dispatches writers, workers and reviewers, shows documents at gates, and keeps `state.yaml` current.
- Never approves its own work or a subagent's. Approval comes from a reviewer verdict plus, at gates, the user.

## Writer — `spec-writer`

- Drafts or revises **one** document: a project file, `requirements.md`, `design.md` or `tasks.md`.
- Follows its template, the approved earlier documents, the project files, and the real repo.
- Tags every crucial claim with its source (`decision-policy.md` §2). Never invents files, modules, APIs or behaviour.
- Returns crucial unknowns as questions. Doesn't review, approve or build.

## Edge analyst — `edge-analyst`

- Finds the edge cases of an approved design and prepares 2–4 options for each, with consequences (`edge-cases.md` §3).
- **Never chooses a resolution.** It returns the edge list, the options, the policy questions and the dropped list.

## Worker — `task-worker`

- Builds the assigned approved tasks in dependency order, inside their scope, following nearby code patterns.
- Writes the tests each task names and runs them. Updates the task markers honestly.
- Makes minor decisions and lists them. Stops and reports on anything crucial (`decision-policy.md` §8).
- Never adds a dependency silently and never approves its own work.

## Reviewers — `spec-reviewer`, `task-reviewer`, `chart-reviewer`

- **Read-only.** They inspect, run checks, and return a verdict. They never fix what they review.
- Always run the **guess audit** (`decision-policy.md` §9) as well as their normal checks.
- Use a fresh reviewer for each pass.

| Reviewer | Reviews |
|---|---|
| `spec-reviewer` | project files, requirements, design, edge cases, tasks (including the consistency check across all of them) |
| `task-reviewer` | each build phase, and the final review of the whole feature |
| `chart-reviewer` | charts against the code and `charts.md` |

## Chart maker — `chart-maker`

- Draws the high- and low-level charts from the code and the approved documents, and makes the before/after diff for bug-fixes (`charts.md`).
- Writes only under `visuals/` and `.mstack/.cache/`.

## Model routing (optional)

When the platform can pick a model per role:

| Role | Model |
|---|---|
| writer, edge analyst, all reviewers | strong: weak models write vague plans and rubber-stamp reviews |
| worker | may use a cheaper model, because well-written tasks need execution, not judgment |
| chart maker | either |

If a cheaper worker fails review twice on the same task, give that task to a strong-model worker. The final review never runs on a cheap model.

## Without subagents

When subagents aren't available, run the roles one after another in the same session:

1. label the pass ("Writer pass", "Reviewer pass");
2. finish the writer or worker pass;
3. freeze the result;
4. run the reviewer pass without editing anything;
5. give the verdict;
6. repair only after the review has ended.
