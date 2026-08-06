# Specification Templates

## Feature Requirements

```markdown
# Requirements: <Feature Name>

## Metadata
- Status: Draft | Reviewed | Approved
- Spec type: Feature
- Last updated: <date>

## Overview
<What this MVP feature does and why it matters.>

## Goals
- <goal>

## Out of Scope
- <explicit exclusion>

## Assumptions
- <verified assumption>
- <unverified assumption, clearly marked>

## User Stories

### REQ-001 — <Title>
**Status:** CONFIRMED | UNCONFIRMED

**As a** <actor>  
**I want** <capability>  
**So that** <value>

#### Acceptance Criteria
- AC-001.1: WHEN <condition> THE SYSTEM SHALL <behaviour>.
- AC-001.2: WHEN <edge case> THE SYSTEM SHALL <safe behaviour>.

#### Constraints
- <security, compatibility, performance, or product constraint>

#### Evidence
- <test or observable result>

## Cross-Cutting Requirements

### Security and Privacy
- <requirement or not applicable>

### Reliability
- <requirement or not applicable>

### Performance
- <only what matters for the MVP>

## Open Questions
- <decision needed>
```

## Bugfix

```markdown
# Bugfix: <Bug Title>

## Metadata
- Status: Draft | Reviewed | Approved
- Severity: low | medium | high | critical
- Affected environment: <scope>

## Reproduction
1. <step>
2. <step>

## Current Behaviour
WHEN <condition> THE SYSTEM <incorrect behaviour>.

## Expected Behaviour
WHEN <condition> THE SYSTEM SHALL <correct behaviour>.

## Root Cause
<Repository-grounded explanation.>

## Unchanged Behaviour
- WHEN <condition> THE SYSTEM SHALL CONTINUE TO <behaviour>.

## Proposed Fix Boundary
<What will change and what will not.>

## Verification
- <regression test>
- <smoke or integration check>

## Open Questions
- <decision needed>
```

## Technical Design

```markdown
# Design: <Feature or Bug Name>

## Metadata
- Status: Draft | Reviewed | Approved
- Related requirements: <REQ IDs>

## Overview
<Smallest coherent technical approach.>

## Existing Context
- <current component or pattern>
- <constraint discovered in the repository>

## Components

### Modified
- `<component>` — <change>

### New
- `<component>` — <single responsibility>

## Main Data Flow
1. <step>
2. <step>
3. <step>

## Interfaces and Contracts
- `<method/path/event>` — <input, output, errors>

## Data Model
- <schema or state change>
- <migration note if applicable>

## Error Handling
| Scenario | Behaviour |
|---|---|
| <error> | <response or recovery> |

## Security and Privacy
- authentication:
- authorization:
- validation:
- secrets:
- sensitive data:

## Testing Strategy
- unit:
- integration:
- smoke:
- regression:

## Deployment / Migration
- <only when applicable>

## Deliberate Non-Goals
- <future capability not implemented now>

## Open Technical Decisions
- <decision needed>
```

## Tasks

```markdown
# Tasks: <Feature or Bug Name>

## Metadata
- Status: Draft | Reviewed | Approved | In Progress | Complete

## Traceability
| Requirement | Design section | Tasks |
|---|---|---|
| REQ-001 | Components / Data Flow | TASK-001, TASK-002 |

## Implementation Plan

- [ ] **TASK-001 — <Title>**
  - **Depends on:** none
  - **Requirements:** REQ-001
  - **Files/components:** `<path or component>`
  - **What to do:** <specific change>
  - **Done when:** <verifiable completion>
  - **Checks:** <test, lint, build, or smoke step>

- [ ] **TASK-002 — <Title>**
  - **Depends on:** TASK-001
  - **Requirements:** REQ-001
  - **Files/components:** `<path or component>`
  - **What to do:** <specific change>
  - **Done when:** <verifiable completion>
  - **Checks:** <verification>

## Parallel Groups
- Group A: <independent tasks or none>

## File Conflicts
- `<path>`: TASK-001 and TASK-003 must be completed in one coordinated pass.

## Execution Notes
- <migration, generated file, shared state, or sequencing note>
```
