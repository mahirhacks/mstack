# MVP Spec-Driven Delivery Pack

A lightweight, reusable agent workflow for building serious MVPs without turning every change into enterprise bureaucracy.

It is designed for projects such as:

- AI-powered web applications
- Agentic tools and developer platforms
- SaaS MVPs
- Internal automation products
- Security-oriented developer tools
- Products that may grow quickly after the first working release

## What each file does

- `SKILL.md` — portable workflow entry point and orchestration rules.
- `AGENTS.md` — repository-level instructions that should be read every session.
- `agents/` — reusable prompts for writers, workers, and independent reviewers.
- `references/` — detailed workflow, role, and verification rules loaded only when needed.
- `templates/` — copy-ready specification and review templates.
- `steering/` — starter project-context files to customize per repository.

## Recommended installation

1. Put `AGENTS.md` in the repository root.
2. Put `SKILL.md`, `agents/`, `references/`, and `templates/` together wherever your agent platform loads skills.
3. Copy the files from `steering/` into the project's preferred steering directory:
   - `.agent/steering/`
   - `.cursor/steering/`
   - `.kiro/steering/`
   - or another established project location.
4. Customize the steering files before major implementation.
5. Keep generated specs in the project's existing spec directory. When none exists, use `.agent/specs/<change-name>/`.

## Typical commands

- `Start requirements for <feature>.`
- `Quick plan: <feature>.`
- `Bug: <problem>. Start with diagnosis.`
- `Requirements approved.`
- `Design approved.`
- `Tasks approved. Execute all tasks.`
- `Do Task 3 only.`
- `Review the current implementation.`
- `What is the current spec status?`

## Recommended default mode

For a meaningful MVP feature:

```text
requirements
→ user approval
→ design
→ user approval
→ tasks
→ user approval
→ autonomous implementation
→ independent verification
→ delivery summary
```

For a tiny, low-risk fix, use the direct path.
