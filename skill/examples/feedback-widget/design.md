# Design: Feedback Widget

> **Worked example.** This shows what a finished `design.md` looks like: the smallest coherent approach, grounded in the (illustrative) repository, with explicit non-goals.

## Metadata
- Status: Approved
- Related requirements: REQ-001, REQ-002

## Overview
One new table, one route module with two endpoints, one small view partial, one admin page. No new dependencies.

## Existing Context
- Express routes live in `src/routes/`, one file per resource, registered in `src/routes/index.ts`.
- Auth middleware `requireUser` and `requireAdmin` exist in `src/middleware/auth.ts`.
- Migrations are plain SQL files in `migrations/`, applied with `npm run migrate`.
- Admin pages are server-rendered EJS views in `src/views/admin/`.

## Components

### Modified
- `src/routes/index.ts` — register the feedback router.
- `src/views/layout.ejs` — mount the widget partial for signed-in users.

### New
- `migrations/007_create_feedback.sql` — feedback table and index.
- `src/routes/feedback.ts` — `POST /api/feedback` and `GET /admin/feedback`.
- `src/views/partials/feedback-widget.ejs` — trigger button, textarea, submit, success/error states.
- `src/views/admin/feedback.ejs` — submissions list.

## Main Data Flow
1. A signed-in user opens the widget and submits text.
2. The client POSTs `{ message, pageUrl }` to `/api/feedback` with the session cookie.
3. The server checks auth and length, inserts a row, and returns 201.
4. An admin opens `/admin/feedback`; the server queries newest first and renders the list.

## Interfaces and Contracts
- `POST /api/feedback` — body `{ message: string, pageUrl: string }`; 201 on success, 400 on validation failure, 401 when signed out.
- `GET /admin/feedback` — server-rendered HTML list; 403 for non-admins.

## Data Model
- New table `feedback`: `id`, `user_id` (FK → `users`), `message` (text), `page_url`, `created_at`.
- Index on `created_at` for the newest-first query.
- Additive migration only; no backfill.

## Error Handling
| Scenario | Behaviour |
|---|---|
| Empty or >2000 character message | 400 with a field error; nothing stored |
| Signed-out submission | 401; nothing stored |
| Non-admin requests the list | 403 via existing `requireAdmin` |
| Insert failure | 500 with a generic message; widget shows "try again" |

## Security and Privacy
- authentication: `requireUser` on the submit endpoint, `requireAdmin` on the list.
- authorization: role check only; no per-row ownership needed.
- validation: server-side length check (1–2000); message stored raw as untrusted input.
- secrets: none involved.
- sensitive data: submitter email rendered only on the admin page.

## Testing Strategy
- unit: message length validation.
- integration: POST valid / empty / oversized / signed-out; GET as admin and as non-admin.
- smoke: submit from a real page, confirm it appears in the admin list.
- regression: none — this is a new surface.

## Deployment / Migration
- One additive migration, safe to apply before the UI ships.

## Deliberate Non-Goals
- Retention or deletion policy — revisit once real volume is known.
- Pagination — the list is capped at the 200 newest rows for the MVP.

## Open Technical Decisions
- None.
