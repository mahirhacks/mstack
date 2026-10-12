# Changelog

## 2.0.0 — 2026-10-12

Renamed from `mvp-spec-driven-delivery` to **mstack**, and redesigned as an independent planning skill. See the [README](README.md).

- **Three flows:** the interview → `product.md`, `tech.md`, `security.md`, `architecture.md`; feature; bug-fix. Plus a tiny-fix shortcut.
- **New skills:** `/mstack:goal`, `product`, `feature`, `bug-fix`, `visualhigh`, `visuallow`, `mode`, `status`.
- **No-guess policy:** the human makes every crucial decision. Every claim is source-tagged, and every reviewer runs a guess audit.
- **Slot-driven interview:** follow-ups for vague answers, probe rules, conflict checks and a playback you confirm.
- **Edge-case step after design:** a systematic sweep. The user decides how every edge is handled, with the format scaled by severity, and shared failure policies are reused.
- **Phased task plans:** phases → sub-phases → tasks, with tests at every level and a review per phase.
- **Flowcharts after every build:** high-level (journey with lanes) and low-level (traced to `file:symbol`). Bug-fixes get a red-box before/after diff. An HTML viewer is included.
- **Simpler layout:** the repo root is the Claude Code plugin. The duplicated `skill/` and `plugin/` folders and the sync scripts are removed.

## 1.0.0

`mvp-spec-driven-delivery`: requirements → design → tasks with approval gates and independent review.
