---
description: Start the requirements phase for a new feature
argument-hint: <feature-name or description>
---

# Start Requirements

The user invoked: `/start-requirements $ARGUMENTS`

## Instructions

1. Read `<skill-pack>/SKILL.md` and follow the spec path in `<skill-pack>/references/workflow.md`.
2. Resolve `<skill-pack>` as the first path that exists:
   - `.agent/mvp-spec-driven-delivery/`
   - `.cursor/skills/mvp-spec-driven-delivery/`
   - `${CLAUDE_PLUGIN_ROOT}/skills/mvp-spec-driven-delivery/`
3. Create `requirements.md` under `.agent/specs/<feature-name>/` (or the project's existing spec directory).
4. Follow `<skill-pack>/templates/spec-templates.md` and imitate `<skill-pack>/examples/feedback-widget/requirements.md`.
5. Run an independent spec review. After PASS, apply the user gate for the active approval mode.
