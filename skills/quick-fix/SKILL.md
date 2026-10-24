---
name: quick-fix
description: mstack quick fix. Makes a small code change fast and with as few tokens as possible — no spec, no review, no tests, no charts. Runs only when the user asks for it. Use for /mstack:quick-fix, "mstack quick-fix: <change>", or "just quickly fix …".
---

# mstack:quick-fix

Speed and low token use come first. The user chose to skip verification, so don't add it back.

## Do

1. **Find the spot, don't explore.** Search for the exact code to change and read only that file, or the few lines around it. Don't read the project files, specs, `core/` rules or unrelated code.
2. **Make exactly the change asked.** Nothing extra: no refactors, cleanups, renames, comments, formatting passes or new tests.
3. **Reply in one or two lines:** what changed, at `file:line`, then `Not verified (quick-fix).`

## Skip

Spec folders, `state.yaml`, reviews, tests, builds, lint, type checks and charts.

## Stop and ask one short question only if

- the request is ambiguous about **what** to change;
- it needs a new dependency, deletes files or data, touches secrets or credentials, or deploys;
- it turns out not to be small: more than a few files, or a schema, public API, auth or security change. In that case, suggest `mstack:bug-fix` or `mstack:feature`.

## Note

A quick fix doesn't update specs or charts. If it changes how a built feature behaves, add `(spec/charts not updated)` to your reply.
