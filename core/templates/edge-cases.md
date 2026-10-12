# Edge Cases: <Feature or Fix Name>

<!-- Rules: core/edge-cases.md. The edge-analyst fills everything except the Resolution lines.
     Every Resolution comes from the user: [U:E-n] chosen · [U:EP-n] existing failure policy · [Δ:E-n] delegated + confirmed. -->

- Status: Draft | Reviewed | Approved
- Design version: <date>
- Counts: <found> found · <resolved> resolved · <open> open · <dropped> dropped

## Edge surface model
- Flows: <F1.1 …, F1.2 …>
- Components: <…>
- Entities and invariants: <entity — what must always be true>
- External dependencies: <service — how it fails>
- Trust boundaries: <…>
- State machines: <entity: state → state>
- Actors: <users, attacker, admin, system/cron>

## Failure policies applied
| Policy | Decision | Source |
|---|---|---|
| EP-01 External service down | <decision> | [U:E-n] (new, added to architecture.md) or [U:EP-01] (existing) |

## Edges

### EDGE-001 — <Short scenario title>
- Flow step: <F1.2 …> · Component: <design section>
- Category: <from core/edge-cases.md §3.2>
- Impact: <Critical/High/Medium/Low> · Likelihood: <Likely/Possible/Rare> · Severity: <S1–S4>
- Coverage before analysis: Covered | Partial | Uncovered
- Scenario: <what happens, in plain language>
- Options offered: (a) <…> (b) <…> (c) Accept the risk
- **Resolution:** <chosen option, stated precisely> [U:E-n]
- Status: MUST-HANDLE | SHOULD-HANDLE | ACCEPTED-RISK (reason: <user's words>)
- Changes: <+AC-00x.y in requirements · design §… · none>
- Test: <how the handling will be proven>

## Considered and dropped
| Candidate | Why dropped |
|---|---|
| <edge> | <why this design rules it out> |

## Changes proposed to earlier documents
<!-- Approved together with this file at the edge-cases gate. -->
- requirements.md: <new or changed ACs>
- design.md: <changed sections>
- architecture.md: <new failure policies>

## Decision record
<per core/decision-policy.md §5>
