# Requirements: <Feature or Fix Name>

<!-- Used by both mstack:feature and mstack:bug-fix.
     Bug-fix only: keep the "Fixes:" line and the "Bug" section. Feature: delete both.
     Clarify slots R1–R10 (core/interview.md §8.1) with the user before writing; never guess them.
     Every crucial line carries a source tag ([U:Q-n] user · [R:path] confirmed repo fact · [Δ:Q-n] delegated + confirmed). -->

- Fixes: <feature folder>            <!-- bug-fix only -->
- Status: Draft | Reviewed | Approved
- Last updated: <date>

## Overview
<What this delivers and why it matters, in 2–4 sentences. Link to the product.md goal or metric it serves.>

## Bug                                <!-- bug-fix only -->
- **What's wrong:** WHEN <condition> THE SYSTEM <incorrect behaviour>.
- **How to reproduce:**
  1. <step>
  2. <step>
- **Expected:** WHEN <condition> THE SYSTEM SHALL <correct behaviour>.
- **Root cause:** <explanation backed by code evidence: `file:line`>
- **Must not change:** WHEN <condition> THE SYSTEM SHALL CONTINUE TO <behaviour>. [R10]

## Scope
### In
- <capability>

### Out
- <explicit exclusion>

## Requirements

### REQ-001 — <Title>
**As a** <actor from product.md> [R1]
**I want** <capability>
**So that** <value>

#### Acceptance criteria
- AC-001.1: WHEN <trigger> THE SYSTEM SHALL <behaviour>. [R2, R3]
- AC-001.2: WHEN <invalid input / limit / empty state> THE SYSTEM SHALL <behaviour>. [R4, R7]
- AC-001.3: WHEN <actor without permission> THE SYSTEM SHALL <behaviour>. [R6]

#### Notes
- Inputs and validation: <field — type, required, limits, format> [R4]
- What the user sees on success: <…> [R5]
- Notifications: <who, what, channel> [R8]

## Cross-cutting
- Security and privacy: <from security.md, or "no change">
- Reliability: <availability or recovery expectations, if any>
- Performance: <budgets that matter, with numbers>
- Observability: <what must be logged or measured>
- Accessibility: <per product.md>

## Done when
- <how the user will judge it finished> [R9]

## Traceability
| REQ | Serves (product.md) |
|---|---|
| REQ-001 | <goal or metric> |

## Open questions
- <parked item — blocks this gate if crucial>

## Decision record
<per core/decision-policy.md §5>
