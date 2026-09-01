# Requirements: Feedback Widget

> **Worked example.** This spec shows what a finished `requirements.md` looks like. The stack (Express-style web app with a SQL database and server-rendered views) is illustrative — imitate the structure and level of detail, not the technology.

## Metadata
- Status: Approved
- Spec type: Feature
- Last updated: 2026-09-01

## Overview
Signed-in users can send short product feedback from any page. The team reads submissions in an admin list. This replaces "email us" links that lose page context and get ignored.

## Goals
- Collect feedback without the user leaving the current page.
- Let the team read submissions, newest first, with enough context to act.

## Out of Scope
- Replying to feedback.
- Attachments or screenshots.
- Tagging, sentiment analysis, or dashboards.

## Assumptions
- Session-based auth exists (verified: `src/middleware/auth.ts` exports `requireUser`).
- An admin role flag exists on the user record (verified: `users.is_admin` column).
- Expected volume is low (unverified; assumed under 100 submissions/week).

## User Stories

### REQ-001 — Submit feedback
**Status:** CONFIRMED

**As a** signed-in user
**I want** to submit a short feedback message from the page I am on
**So that** I can report a problem in context without interrupting my work

#### Acceptance Criteria
- AC-001.1: WHEN a signed-in user submits a message of 1–2000 characters THE SYSTEM SHALL store it with the user id, current page URL, and timestamp, and show a success confirmation.
- AC-001.2: WHEN the message is empty or exceeds 2000 characters THE SYSTEM SHALL reject the submission with a visible validation message and store nothing.
- AC-001.3: WHEN a signed-out visitor calls the submit endpoint THE SYSTEM SHALL respond 401 and store nothing.

#### Constraints
- Message text is untrusted input: stored raw, escaped on render.

#### Evidence
- Integration tests on `POST /api/feedback` covering all three criteria.

### REQ-002 — Review feedback
**Status:** CONFIRMED

**As an** admin
**I want** submissions listed newest first
**So that** the team sees recent problems without digging

#### Acceptance Criteria
- AC-002.1: WHEN an admin opens the feedback list THE SYSTEM SHALL show submissions newest first with message, submitter email, page URL, and time.
- AC-002.2: WHEN a non-admin user requests the feedback list THE SYSTEM SHALL respond 403.

#### Constraints
- Reuses the existing admin layout and role check; no new permission model.

#### Evidence
- Integration tests on `GET /admin/feedback` for both roles.

## Cross-Cutting Requirements

### Security and Privacy
- Feedback content must be escaped wherever it is rendered.
- Submitter email is visible only to admins.

### Reliability
- A failed insert returns a visible error to the user; submissions are never silently dropped.

### Performance
- Not a concern at MVP volume; one indexed query serves the list.

## Open Questions
- None. Retention policy was raised and deliberately deferred; recorded under design non-goals.
