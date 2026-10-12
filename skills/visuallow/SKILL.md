---
name: visuallow
description: mstack low-level chart. Shows the user a low-level Mermaid flowchart of what was just built — entry points, functions, data and error branches traced from the real code, every box pointing to file:symbol; for a bug-fix, shows the previous chart with the change in a red box, then the same chart with that area expanded. Use for /mstack:visuallow, "show the low-level chart", or after an mstack build.
---

# mstack:visuallow

**Setup:** `MSTACK_ROOT` is the folder two levels above this file. Follow `MSTACK_ROOT/core/charts.md` for the rules and `MSTACK_ROOT/core/templates/chart.md` for the formats.

## Steps

1. **Which folder.** Use the feature or bug-fix that was just built, or the one the user names. Its final review must be PASS.
2. **New chart or diff:**
   - **Feature folder:** a new chart.
   - **Bug-fix folder:** a diff against `state.yaml` → `charts.<fixed feature>.low`. If there's no previous chart, draw a new one and say so.
3. **Draw:** dispatch `chart-maker` with `MSTACK_ROOT`, the folder, `level: low` and the previous chart path if there is one.
   - It traces from the code: entry points → call paths → data and external calls → the error branches that implement MUST-/SHOULD-HANDLE edges.
   - Every node gets `file:symbol` in the trace table.
   - Connections it can't verify are drawn dotted with `?` and listed. They're never guessed.
   - Charts over 40 nodes are split by entry point, with an index chart (`charts.md` §5.4).
4. **Review:** dispatch a fresh, read-only `chart-reviewer`. It checks that every symbol exists and every solid link is real. On FAIL, repair and re-review, at most 3 cycles.
5. **Show it** (`charts.md` §6 / §7) through the best available renderer (`charts.md` §8). If the client can't render Mermaid, use the HTML viewer at `.mstack/.cache/view-<slug>-low.html`. **Always** also print the walkthrough, failure paths and (for a diff) the change legend as plain text.
6. **Update state:** set `state.yaml` → `charts.<feature>.low` to the new clean chart.
7. **Offer:** "Ask about any box · see the high-level chart · zoom into an entry point".

In **Pre-authorized** mode, `mstack:feature` and `mstack:bug-fix` run this skill automatically after the final review.
