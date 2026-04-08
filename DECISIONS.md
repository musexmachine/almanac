# Almanac Locked Decisions

This file captures the detailed decisions already made for Almanac.

## Product shape

- Go owns operational logic.
- TypeScript is used only where UI productivity is highest.
- CLI binary: `almanac`
- API daemon: `almanacd`
- Canonical config file: `.github-projects.yaml`
- Canonical spec root: `spec/v1/`
- Canonical API prefix: `/v1`

## Canonical public artifacts

- `PROJECTS.md`
- `projects.csv`
- `projects.json`
- `projects.pdf`

## Core product rule

- analysis runs against the watched repository mirror on disk
- public artifact generation is separate from analysis outputs
- analysis outputs are never published automatically

## Pricing

- Free: `$0`
- Founding lifetime: `$199`
- Standard lifetime: `$299`
- no monthly subscription in v1

## Identity, billing, and provider boundaries

- identity provider: Clerk
- GitHub access: one GitHub App
- billing provider: Stripe
- product authorization and entitlements: Almanac
- database default: managed Neon Postgres
- self-hosted DB fallback: plain PostgreSQL
- object storage default: Cloudflare R2
- self-hosted object storage fallback: MinIO

## Deployment and infra

- CapRover-first
- attach existing services first, provision only what is missing
- most runtime services on CapRover
- external managed exceptions: Clerk, Stripe, Neon, R2
- do not self-host Neon
- queue system: River on PostgreSQL
- observability: OpenTelemetry + Grafana Alloy + Prometheus + Loki + Tempo + Grafana
- migrations: Atlas, versioned SQL migrations
- registry: GHCR
- release automation: GoReleaser
- versioning: SemVer

## Frontend and SDK

- web: Next.js App Router
- mobile: Expo + React Native with Expo Router
- SDK strategy: OpenAPI-generated TypeScript client + thin wrapper
- SDK generator: `typescript-fetch`
- no business logic in the SDK

## PDF rendering

- canonical render model -> Go `html/template` -> embedded assets -> Chromium via `chromedp` -> PDF
- PDF is a renderer, not a separate logic path

## Watched-folder analysis

- watched mirror is first-class
- workspace can be local or server-side
- mirror state is durable
- full and incremental analysis both exist
- mirror sync runs before dependent analysis

### External analysis architecture supported

- CodeGraphContext may own structural code graph analysis
- Cortex may own semantic project memory and contradiction tracking
- Neo4j may back CodeGraphContext in CapRover deployments
- shared repo mirror root should be mounted read-only
- Cortex should watch semantic/high-signal subsets only when paired with CodeGraphContext

## Routes and surfaces

### Marketing routes
- `/`
- `/pricing`
- `/open-source`
- `/docs`
- `/examples`
- `/security`
- `/caprover`
- `/self-host`
- `/faq`
- `/privacy`
- `/terms`

### App routes
- `/app`
- `/app/account`
- `/app/billing`
- `/app/github`
- `/app/profiles`
- `/app/runs`
- `/app/artifacts`
- `/app/settings`
- `/admin/*`

### Mobile is a companion app in v1
It should focus on:
- sign in
- account and entitlements
- run status
- artifacts
- billing visibility
- notifications

## CLI contract

- `almanac init`
- `almanac validate`
- `almanac run`
- `almanac tui`
- `almanac doctor`
- `almanac version`

Default behavior:
- interactive terminal -> TUI
- non-interactive -> `validate --headless`

## Roles

- anonymous
- member
- lifetime_member
- support
- admin
- owner
- service

## Retention policy

- public artifacts: indefinite once published
- private hosted artifacts:
  - free: 30 days
  - lifetime: 365 days
- run history:
  - free: 90 days
  - lifetime: 365 days
- notification history:
  - free: 30 days
  - lifetime: 180 days

## Beta policy

- private beta first
- hosted beta intentionally capped
- self-host can open earlier than hosted if needed
- hosted beta requires a safe first run and publication safety gate before public publish

## Content style

- builder-teacher voice
- active voice
- plain language
- concrete terms
- no corporate filler
- no fake urgency
- no hidden tradeoffs

## Non-negotiables

- do not move business logic into TypeScript clients
- do not use client-only auth guards as authorization
- do not blur analysis outputs into public artifacts
- do not duplicate watched analysis ownership without a hard boundary
- do not claim compliance not actually achieved
