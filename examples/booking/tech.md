# Tech: ClinicBook

- Status: Approved
- Last updated: 2026-10-12

## Stack
| Part | Choice (version) | Source |
|---|---|---|
| Language / framework | TypeScript 5, Next.js 14 (App Router) | [U:I-5.1] |
| Hosting / runtime | Vercel (app) + Railway (worker) | [Δ:I-5.2 — delegated, agent proposed, user confirmed] |
| Primary datastore | Postgres 16 (Neon, managed) via Prisma | [U:I-5.1] |
| Authentication | NextAuth, email magic link (staff only) | [U:I-7.2] |

## Third-party services
| Service | Purpose | Source |
|---|---|---|
| Twilio | SMS reminders | [U:I-5.3] |

## Team and budget
- Maintained by: one full-stack TypeScript developer. [U:I-4.2]
- Infrastructure budget: ≤ $60/month during the pilot. [U:I-4.3]

## Environments and deployment
- Environments: local, preview (per PR), production. [U:I-5.4]
- Production deploys on merge to `main`; rollback by redeploying the previous build. [U:I-5.4]

## Commands
| Task | Command |
|---|---|
| install | `pnpm install` |
| run locally | `pnpm dev` |
| build | `pnpm build` |
| test | `pnpm test` |
| lint / types | `pnpm lint && pnpm typecheck` |

## Testing
- Required: unit + integration for the server logic; one e2e test of the booking journey. [U:I-5.5]

## Conventions
- Server logic in `src/<domain>/`, routes in `app/api/`. Errors return `{ error: { code, message } }`. [M]

## Decision record
<abridged in this example>
