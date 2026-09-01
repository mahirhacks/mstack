---
description: Draft requirements, design, and tasks with internal reviews, then pause before implementation
argument-hint: <feature-name or description>
---

# Quick Plan

The user invoked: `/quick-plan $ARGUMENTS`

## Instructions

1. Read `<skill-pack>/SKILL.md` and follow the **Quick Plan** approval mode in `<skill-pack>/references/workflow.md`.
2. Resolve `<skill-pack>` as the first path that exists:
   - `.agent/mvp-spec-driven-delivery/`
   - `.cursor/skills/mvp-spec-driven-delivery/`
   - `${CLAUDE_PLUGIN_ROOT}/skills/mvp-spec-driven-delivery/`
3. Create or update spec artifacts under the project's spec directory (default `.agent/specs/<feature-name>/`):
   - `requirements.md`
   - `design.md`
   - `tasks.md`
4. Run an independent review after each artifact. Repair on FAIL.
5. Present the complete plan and **pause before implementation** unless the user also authorized implementation.

Use artifact formats from `<skill-pack>/templates/spec-templates.md` and imitate `<skill-pack>/examples/feedback-widget/`.
