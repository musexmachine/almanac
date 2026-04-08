# Almanac Plan

This is the canonical execution plan for `musexmachine/almanac`.

It is written to be easy for humans and agents to execute.

## Purpose

Almanac has two coordinated jobs:

1. Build canonical public artifacts from GitHub work:
   - `PROJECTS.md`
   - `projects.csv`
   - `projects.json`
   - `projects.pdf`
2. Maintain a continuously updated watched workspace of mirrored repositories so analysis can run against the real filesystem mirror, not just GitHub API metadata.

## Core product rule

Analysis runs against the watched repository mirror on disk.

Public artifact generation is separate from analysis outputs.
Analysis outputs are never published automatically.

## Product shape

Use:
- Go everywhere it matters operationally
- TypeScript only where UI productivity is highest

### Go owns
- spec-backed core engine
- discovery
- normalization
- classification
- enrichment
- validation
- rendering
- PDF generation
- billing and entitlements
- API server
- CLI
- Charm TUI
- schedulers
- Git/GitHub write operations
- watched-folder mirror and analysis engine

### TypeScript owns
- web app
- mobile app
- generated API SDK

## Locked standards

### Names
- product name: `almanac`
- repo: `musexmachine/almanac`
- CLI binary: `almanac`
- API daemon: `almanacd`
- config file: `.github-projects.yaml`
- spec root: `spec/v1/`
- API prefix: `/v1`

### Canonical public artifact names
- `PROJECTS.md`
- `projects.csv`
- `projects.json`
- `projects.pdf`

### Plans and entitlement model
- Free: local/self-host core remains real and useful
- Founding lifetime: `$199` for first 100 customers
- Standard lifetime: `$299`
- No monthly subscription in v1

### Auth / billing / data boundaries
- identity provider: Clerk
- GitHub integration: one GitHub App
- billing provider: Stripe
- database default: managed Neon Postgres
- self-hosted DB fallback: plain PostgreSQL
- object storage default: Cloudflare R2
- self-hosted object storage fallback: MinIO
- Almanac owns authorization, roles, entitlements, and product rules

### Infra model
- attach-or-provision by default
- prefer reusing existing CapRover services when present
- CapRover-first deployment
- do not self-host Neon

## Architecture

### Core repo layout target

```text
almanac/
  cmd/
    almanac/
    almanacd/
  pkg/almanac/
    billing/
    classify/
    config/
    discover/
    enrich/
    github/
    model/
    render/
    report/
    validate/
    version/
    write/
    mirror/
    workspace/
    watch/
    analyze/
    analyzers/
    index/
  internal/
    api/
    cli/
    tui/
    ui/
  apps/
    web/
    mobile/
  sdk/
    ts/
  spec/
    v1/
  migrations/
  runbooks/
  design/
  demo/
  examples/
```

### Separation rule
- `pkg/almanac/*` is the reusable core engine
- `internal/*` is transport and UI glue
- `apps/web` and `apps/mobile` are clients only
- `sdk/ts` is generated from OpenAPI plus a thin wrapper

## Watched-folder analysis subsystem

This is first-class, not a side feature.

### Workspace model
A profile can have a watched workspace that:
- mirrors selected repositories into a local or server-side root
- keeps them updated continuously
- supports full and incremental analysis
- stores analysis results tied to profiles, repositories, and runs

### Planned spec additions
Add these schemas under `spec/v1/`:
- `analysis-workspace.schema.json`
- `analysis-run.schema.json`
- `repository-mirror.schema.json`
- `analyzer.schema.json`

### Canonical watched-analysis concepts
- `RepositoryMirror`
- `AnalysisWorkspace`
- `Analyzer`
- `AnalysisRun`
- `AnalysisArtifact`

### Config additions
Add an `analysis:` block to `.github-projects.yaml` for:
- workspace root path
- workspace layout
- watch enablement
- sync strategy
- analyzer selection
- analysis output policy

### Core rule
Analysis outputs are separate from the canonical public artifacts.

## External analysis architecture to support

The product should allow external or adjunct analysis engines when useful.

### Best-fit split captured from research
- CodeGraphContext: structural code graph, callers, callees, complexity, dead code, dependency tracing
- Cortex: semantic project memory, decisions, patterns, constraints, contradictions, dashboard

### Recommended CapRover split when both are used
- shared read-only repo mirror root
- CodeGraphContext owns full structural code watching
- Cortex watches semantic/high-signal subsets only
- Neo4j backs CodeGraphContext
- Cortex keeps its own SQLite/LanceDB-style persistence

### Shared repo mirror root
Recommended host path:

```text
/srv/dev-mirror
```

Recommended mount into analyzer containers:

```text
Host:   /srv/dev-mirror
Target: /repos
Mode:   read-only
```

### CapRover analysis service map
- `neo4j`
- `codegraphcontext`
- `cortex`
- optional repo-mirror sync job / mirror service

### Operations rule
Back up these separately because persistent directories are operationally critical:
- repo mirror root
- Neo4j data
- Cortex data

## API model

### Resource style
- resource-first HTTP model under `/v1`
- long work is async through runs/jobs
- list endpoints use cursor pagination
- filtering is flat query params
- responses use a thin envelope:

```json
{
  "data": {},
  "error": null,
  "meta": {}
}
```

### Core resources
- `/v1/health`
- `/v1/profile`
- `/v1/me`
- `/v1/account`
- `/v1/entitlements`
- `/v1/github/*`
- `/v1/profiles*`
- `/v1/inventories*`
- `/v1/projects*`
- `/v1/runs*`
- `/v1/artifacts*`
- `/v1/checkout/session`
- `/v1/billing/portal/session`
- `/v1/webhooks/stripe`
- `/v1/admin/*`
- `/v1/workspaces*`
- `/v1/mirrors*`
- `/v1/analysis-runs*`
- `/v1/analyzers*`

## Jobs

Use River on PostgreSQL.

### Job families
- GitHub sync jobs
- inventory build/classify/enrich/validate jobs
- render jobs for markdown/csv/json/pdf
- publish jobs
- billing webhook and entitlement jobs
- mirror sync jobs
- workspace scan jobs
- analysis jobs
- cleanup jobs

### Job rule
Jobs must be idempotent.

## Rendering

### PDF pipeline
Use:
- Go canonical render model
- `html/template`
- embedded template assets
- headless Chromium via `chromedp`

Rule:
- PDF is rendered from the same canonical public model as `PROJECTS.md`
- no separate PDF-only business logic

## UX surfaces

### CLI/TUI
Commands:
- `almanac init`
- `almanac validate`
- `almanac run`
- `almanac tui`
- `almanac doctor`
- `almanac version`

Default behavior:
- TTY: launch TUI
- non-interactive: behave like `validate --headless`

### Web
Use Next.js App Router.

Primary app routes:
- `/app`
- `/app/account`
- `/app/billing`
- `/app/github`
- `/app/profiles`
- `/app/runs`
- `/app/artifacts`
- `/app/settings`
- `/admin/*`

Marketing routes:
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

### Mobile
Use Expo + React Native with Expo Router.

Mobile is a companion app in v1.
It should handle:
- sign in
- account and entitlements
- run status
- artifacts
- billing visibility
- notifications

## SDK

Use:
- OpenAPI-generated TypeScript client
- thin handwritten wrapper
- no business logic in the SDK

Generator choice:
- `typescript-fetch`

## Data model

### Core database modules
- `identity`
- `accounts`
- `github`
- `inventory`
- `runs`
- `artifacts`
- `billing`
- `jobs`
- `ops`

### Additional watched-analysis modules
- `workspaces`
- `repository_mirrors`
- `analysis_runs`
- `analysis_artifacts`

### DB rules
- use PostgreSQL
- use named constraints and targeted indexes
- use additive migrations by default
- use Atlas versioned SQL migrations

## Deployment

### CapRover-first topology
Host most services on CapRover:
- `almanac-web`
- `almanac-api`
- `almanac-worker`
- `almanac-analyzer` if analysis is split out
- observability stack
- optional MinIO
- optional Neo4j / Cortex / CodeGraphContext adjunct services

External managed services:
- Clerk
- Stripe
- Neon
- R2

### Observability
Use:
- OpenTelemetry
- Grafana Alloy
- Prometheus
- Loki
- Tempo
- Grafana

### Registry and release
- container registry: GHCR
- one image per service
- versioning: SemVer
- releases: Git tags + GitHub Releases + GoReleaser

## Product analytics and retention

### Product analytics
- operational telemetry: OTel + Grafana stack
- product analytics: PostHog

### Retention policy
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

## Milestones

### Milestone 0 — Bootstrap the repo, standard, and scaffold
Success means:
- repo scaffold exists
- governance files exist
- `spec/v1/` exists
- Go module + pnpm workspace + turbo exist
- CI skeleton exists
- project is ready for real implementation

### Milestone 1 — Local truth, clean artifacts, hosted-ready core
Must include:
- discovery/classify/enrich/validate/render core
- Markdown/CSV/JSON/PDF outputs
- CLI and Charm TUI
- watched workspace bootstrap
- repository mirroring
- initial analyzers
- proof that public artifacts stay isolated from analysis outputs

### Milestone 2 — Hosted beta, real accounts, real billing, real publishing
Must include:
- hosted accounts
- Clerk auth
- GitHub App connect flow
- hosted runs
- artifact storage and publishing
- Stripe lifetime purchase flow
- admin v1
- CapRover deployment
- scheduled mirror sync and analysis runs

### Milestone 3 — Public product surface, mobile companion, scalable hosted operations
Must include:
- public product website
- mobile companion app
- polished docs/onboarding
- stronger admin/support tooling
- richer analysis visibility in product surfaces
- public launch readiness

## Repo governance

### Required files
- `README.md`
- `CONTRIBUTING.md`
- `SECURITY.md`
- `CODE_OF_CONDUCT.md`
- `LICENSE`
- `CHANGELOG.md`
- `AGENTS.md`
- `runbooks/`
- issue templates
- PR template
- `CODEOWNERS`

### Branch and PR rules
Branch name format:

```text
<type>/<short-kebab-slug>
```

PR title format:

```text
type(scope): concise summary
```

### CODEOWNERS bootstrap
Single owner is acceptable initially.
Protect spec, migrations, billing, and governance paths.

## Content style

### Global
- builder-teacher voice
- active voice
- plain language
- concrete terms
- no corporate filler
- no fake urgency
- no hidden tradeoffs

### UI
- one primary action
- next safe step always clear
- dry-run before publish

### Docs
- task-first
- exact commands
- verification steps required
- runbooks are part of the product

## Immediate execution order

1. Keep this plan as the canonical execution source.
2. Scaffold the repo according to the locked day-one tree.
3. Add governance files.
4. Add `spec/v1/` placeholders and real root contract files.
5. Add Go entrypoints that compile.
6. Add pnpm/turbo workspace skeleton.
7. Add Makefile targets.
8. Add CI skeleton.
9. Start Milestone 0.
10. Start Milestone 1 core engine and watched-workspace implementation.

## Do not do

- do not blur analysis outputs into public artifacts
- do not put business logic in the TypeScript SDK
- do not let clients enforce authorization on their own
- do not fully duplicate watched trees across analysis systems without a hard ownership split
- do not self-host Neon for this project
- do not claim compliance you have not actually earned

## Canonical priority

If there is a conflict between convenience and correctness, preserve:
1. safety
2. determinism
3. reproducibility
4. clean public/private boundaries
5. operator clarity
