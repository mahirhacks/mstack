# Specification Templates

These are the canonical artifact formats. A complete worked example following them lives in `examples/feedback-widget/`.

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

Main tasks are numbered `Task 1`, `Task 2`, … Subtasks are numbered `Task 1.1`, `Task 1.2`, … Workers execute subtasks. Each subtask uses exactly these four fields: Objective, Implementation, Criteria, Test.

Write every **Implementation** field so an executor with no context beyond the approved artifacts and the repository can complete it: exact files, the specific change, dependencies, and mapped requirements. A vague subtask forces the worker to guess and defeats routing execution to a cheaper model (see Model Routing in `references/roles.md`).

```markdown
# Tasks: <Feature or Bug Name>

## Metadata
- Status: Draft | Reviewed | Approved | In Progress | Complete

## Traceability
| Requirement | Design section | Tasks |
|---|---|---|
| REQ-001 | Components / Data Flow | Task 1.1, Task 1.2 |

## Implementation Plan

### Task 1 — <Main task title>

#### [ ] Task 1.1 — <Subtask title>
- **Objective:** <what this subtask achieves>
- **Implementation:** <specific change; files/components; dependencies; mapped requirements>
- **Criteria:** <verifiable completion>
- **Test:** <test, lint, build, or smoke step>

#### [ ] Task 1.2 — <Subtask title>
- **Objective:** <what this subtask achieves>
- **Implementation:** <specific change; files/components; dependencies; mapped requirements>
- **Criteria:** <verifiable completion>
- **Test:** <verification>

### Task 2 — <Main task title>

#### [ ] Task 2.1 — <Subtask title>
- **Objective:** <what this subtask achieves>
- **Implementation:** <specific change; files/components; dependencies; mapped requirements>
- **Criteria:** <verifiable completion>
- **Test:** <verification>

## Parallel Groups
- Group A: <independent subtasks or none>

## File Conflicts
- `<path>`: Task 1.1 and Task 2.1 must be completed in one coordinated pass.

## Execution Notes
- <migration, generated file, shared state, or sequencing note>
```
