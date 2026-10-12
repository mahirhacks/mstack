# Security: <Product Name>

<!-- Written by mstack:product. Slot IDs (S1…) refer to core/interview.md §2.4.
     Every line here is crucial: nothing untagged, nothing [M]. Slot hints like [P1] show which interview slot fills a line. Replace each hint with the real source tag.
     -->

- Status: Draft | Reviewed | Approved
- Last updated: <date>

## Data collected
| Category | Examples | Sensitivity | Source |
|---|---|---|---|
| <PII, payment, health, location, children's data, credentials…> | <fields> | <low/medium/high> | [S1] |

## Login
- Methods: <password, magic link, SSO, OAuth providers> [S2]
- MFA: <required / optional / none> [S2]

## Roles and permissions
| Role | Can | Must never | Source |
|---|---|---|---|
| <role> | <actions> | <forbidden> | [S3] |

Permission checks are enforced on the server, never only in the UI.

## Compliance
| Regime | Applies? | Why | Source |
|---|---|---|---|
| <GDPR, HIPAA, PCI, SOC2, COPPA…> | yes / no | <reason> | [S4] |

## Retention and deletion
| Data | Kept for | User can delete? | Source |
|---|---|---|---|
| <category> | <duration> | yes / no | [S5] |

## Threat model
- Assets: <what must be protected>
- Trust boundaries: <client → API, webhook → API, model output → tool call…>
- Threats of concern: <top 3, from the user> [S6]
- Worst realistic consequence: <in the user's words> [S11]

## Internal access
- Who can see production data, and how: <answer> [S7]
- Audit logging: <which actions are logged, or none required> [S8]

## AI / agent safety
- <"no AI", or what the model can read, write and execute; human review rules; cost cap> [S9]

## Secrets
- <where they live; never in version control> [S10]

## Required checks per boundary
| Boundary | Authn | Authz | Validation | Rate limit | Logging |
|---|---|---|---|---|---|
| <boundary> | <check> | <check> | <check> | <check> | <what, no secrets or needless PII> |

## Open questions
- <parked item and what it blocks>

## Decision record
<per core/decision-policy.md §5>
