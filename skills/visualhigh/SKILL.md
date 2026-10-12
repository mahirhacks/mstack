---
name: visualhigh
description: mstack high-level chart. Shows the user a high-level Mermaid flowchart (journey with lanes) of what was just built, traced from the code and approved spec; for a bug-fix, shows the previous chart with the change in a red box, then the same chart with that area expanded. Use for /mstack:visualhigh, "show the high-level chart", or after an mstack build.
---

# mstack:visualhigh

**Setup:** `MSTACK_ROOT` is the folder two levels above this file. Follow `MSTACK_ROOT/core/charts.md`, which holds the rules, and `MSTACK_ROOT/core/templates/chart.md`, which holds the formats.

## Steps

1. **Which folder.** Use the feature or bug-fix that was just built, or the one the user names. Its final review must be PASS. If it isn't, say so and stop.
2. **New chart or diff:**
   - **Feature folder:** a new chart.
   - **Bug-fix folder:** a diff against the previous high-level chart at `state.yaml` → `charts.<fixed feature>.high`. If there's no previous chart, draw a new one and say "no previous chart, so there's no diff".
3. **Draw:** dispatch `chart-maker` (`mstack:chart-maker` in Claude Code) with `MSTACK_ROOT`, the folder, `level: high` and the previous chart path if there is one.
4. **Review:** dispatch a fresh, read-only `chart-reviewer`. On FAIL, repair and re-review, at most 3 cycles.
5. **Show it** (`charts.md` §6 for a new chart, §7 for a diff) through the best available renderer (`charts.md` §8):
   - render it inline if the client can;
   - otherwise open it in an IDE Markdown preview, or open the HTML viewer at `.mstack/.cache/view-<slug>-high.html`.

   **Always** also print the plain-text walkthrough, failure paths and (for a diff) the change legend.
6. **Update state:** set `state.yaml` → `charts.<feature>.high` to the new clean chart. For a bug-fix, the feature is the fixed feature.
7. **Offer:** "Ask about any box · see the low-level chart · zoom into a step" (`charts.md` §9).
