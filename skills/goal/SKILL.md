---
name: goal
description: mstack interview. Runs a structured, multi-round interview to pin down a product's goal, users, scope, tech, architecture and security without guessing anything crucial, then hands over to mstack:product to write product.md, tech.md, security.md and architecture.md. Use for /mstack:goal, "mstack goal", starting a new project with mstack, or when the product changes direction (pivot).
---

# mstack:goal — the interview

**Setup:** `MSTACK_ROOT` is the folder two levels above this file (it contains `core/`). Read `AGENTS.md` if present, then:

- `MSTACK_ROOT/core/interview.md`: **the rules you follow, all of them**
- `MSTACK_ROOT/core/decision-policy.md`: source tags, the crucial test, the question format, delegation

**You run the interview yourself, in the main conversation.** Subagents can't talk to the user, so never delegate questions.

## Steps

1. **Check state.** Read `.mstack/state.yaml`.
   - Unfinished interview (`interview:` present): resume at its phase and open slots.
   - Project files already exist: run **delta mode** (`interview.md` §7).
   - Otherwise start fresh.
2. **Phase 0, recon (silent):** read the repo (`interview.md` §3, phase 0). Pre-fill slots as `repo-found`, and note conflicts inside the repo.
3. **Phases 1–8:** run the iteration engine (`interview.md` §4).
   - At most 5 questions per round; one decision per question.
   - Use a structured question tool with options when available (`AskUserQuestion` in Claude Code). Otherwise use numbered plain-text options.
   - After every round: classify each answer (§4.1), queue follow-ups (§4.2, vagueness lexicon §4.3), apply probe rules (§4.4), pick the next round (§4.5), and print the progress line (§4.6).
   - Brownfield: show the repo confirmation table once (§5).
   - Every 4 rounds, offer the fast lane (§4.7). Hard stop at 12 rounds (§4.8).
   - Save progress to `state.yaml` → `interview:` after every round, so the interview can resume.
4. **Phase 9, playback** (`interview.md` §6): one structured summary grouped by file, every line with its source tag. The user confirms each section. Corrections re-open only the affected slots.
5. **Hand over.** Once the playback is confirmed, follow `MSTACK_ROOT/skills/product/SKILL.md` with the confirmed playback as input.

## Never

- Never ask what the repo or an earlier answer already answers. Do confirm repo facts once.
- Never fill a crucial slot from your own assumption. If the user doesn't know, follow `decision-policy.md` §7: options, then delegate (with confirmation) or park.
- Never write a project file before the playback is confirmed.
