---
name: product
description: mstack project files. Writes product.md, tech.md, security.md and architecture.md into .mstack/ from a confirmed mstack interview, or from an existing codebase plus a short gap interview. Use for /mstack:product, "mstack product", after mstack:interview, or to create or refresh the project files of an existing repo.
---

# mstack:product — the four project files

**Setup:** `MSTACK_ROOT` is the folder two levels above this file. Read `AGENTS.md` if present, plus:

- `MSTACK_ROOT/core/workflow.md` §2, §4, §5
- `MSTACK_ROOT/core/decision-policy.md`
- the templates `MSTACK_ROOT/core/templates/{product,tech,security,architecture}.md`

## Input

- **From `mstack:interview`:** the confirmed playback. This is the only source of crucial content.
- **Standalone on an existing codebase:** derive what you can from the repo. Show the repo confirmation table (`core/interview.md` §5). Then run the interview engine **only** for crucial slots that are still empty (`core/interview.md` §2 catalog). Finish with a playback of the gaps you filled.

## Steps

1. Create `.mstack/` (or the root the user chose, `workflow.md` §2), plus `.mstack/.gitignore` containing `.cache/`.
2. **Write:** dispatch the `spec-writer` agent (`mstack:spec-writer` in Claude Code) to draft all four files from the templates, giving it `MSTACK_ROOT`, the playback, and the confirmed repo facts. Without subagents, write them yourself as a labelled writer pass (`core/roles.md`).
3. **Questions:** if the writer returns crucial questions, ask the user, then send the answers back to the writer.
4. **Review:** dispatch a fresh `spec-reviewer` (read-only). It checks:
   - the playback diff: no crucial content that isn't in the confirmed playback or a confirmed repo fact;
   - no overlap or contradiction between the files;
   - the guess audit.

   On FAIL: repair and re-review, at most 3 cycles.
5. **Gate (always stops, in every mode):** show the user a short summary of each file with its path, and ask for approval.
6. On approval, set each file's `Status: Approved`, set `state.yaml` → `project_files: approved`, and remove the `interview:` block.
7. **Next:** ask what to build first. Then route the answer: `mstack:feature`, `mstack:bug-fix`, or offer `mstack:quick-fix` for a tiny change (`workflow.md` §1).
