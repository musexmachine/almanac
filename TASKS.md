# Almanac Tasks

This is the execution checklist for agents.

## Milestone 0 — Bootstrap the repo, standard, and scaffold

### Repo and governance
- [x] replace placeholder `README.md` with real bootstrap README
- [ ] add `CONTRIBUTING.md`
- [ ] add `SECURITY.md`
- [ ] add `CODE_OF_CONDUCT.md`
- [ ] add `LICENSE`
- [ ] add `.github/CODEOWNERS`
- [ ] add `.github/PULL_REQUEST_TEMPLATE.md`
- [ ] add issue templates
- [ ] add workflow skeletons

### Build and workspace
- [x] add `AGENTS.md`
- [x] add `PLAN.md`
- [x] add `CHANGELOG.md`
- [ ] add `go.mod`
- [ ] add `Makefile`
- [ ] add root `package.json`
- [ ] add `pnpm-workspace.yaml`
- [ ] add `turbo.json`

### Go entrypoints
- [ ] add `cmd/almanac/main.go`
- [ ] add `cmd/almanacd/main.go`
- [ ] make both binaries compile

### Standard and spec
- [ ] add `spec/v1/README.md`
- [ ] add `spec/v1/openapi.yaml`
- [ ] add `spec/v1/enums.yaml`
- [ ] add schema placeholders for core models
- [ ] add schema placeholders for watched-analysis models

### Examples and runbooks
- [ ] add `.github-projects.yaml.example`
- [ ] add `runbooks/README.md`
- [ ] add initial runbook placeholders

### Milestone 0 exit
- [ ] `go test ./...` passes
- [ ] workspace install commands pass
- [ ] repo structure matches locked scaffold

## Milestone 1 — Local truth, clean artifacts, hosted-ready core

### Core engine
- [ ] implement config loading and validation
- [ ] implement GitHub discovery model
- [ ] implement ownership classification
- [ ] implement artifact eligibility classification
- [ ] implement renderers for Markdown/CSV/JSON/PDF
- [ ] implement publication safety gate

### Watched workspace
- [ ] implement watched workspace root model
- [ ] implement repository mirror manager
- [ ] implement full mirror sync
- [ ] implement incremental mirror update path
- [ ] implement metadata analyzer
- [ ] implement language stats analyzer
- [ ] implement README summary analyzer

### Interfaces
- [ ] implement `almanac init`
- [ ] implement `almanac validate`
- [ ] implement `almanac run`
- [ ] implement `almanac doctor`
- [ ] implement initial Charm TUI shell

### Quality
- [ ] add fixture set under `spec/v1/fixtures`
- [ ] add golden artifacts under `spec/v1/golden`
- [ ] add render tests
- [ ] prove analysis outputs stay isolated from canonical public artifacts

## Milestone 2 — Hosted beta, real accounts, real billing, real publishing

### Hosted accounts and auth
- [ ] add DB-backed accounts and profiles
- [ ] add Clerk auth to web and API
- [ ] add GitHub App connect flow

### Hosted runs and storage
- [ ] add hosted run orchestration
- [ ] add artifact storage tracking
- [ ] add publication tracking
- [ ] add scheduled mirror sync
- [ ] add scheduled analysis runs

### Billing
- [ ] add plans and entitlements
- [ ] add Stripe Checkout flow
- [ ] add Stripe webhook processing
- [ ] add lifetime purchase activation path

### Admin
- [ ] add `/admin` overview
- [ ] add runs/admin retry tools
- [ ] add entitlements/purchases views

### Deployment
- [ ] add CapRover service manifests
- [ ] add staging and production deploy workflows
- [ ] attach to Neon and R2 defaults

## Milestone 3 — Public product surface, mobile companion, scalable hosted operations

### Public product
- [ ] complete marketing site routes
- [ ] complete pricing and onboarding UX
- [ ] complete docs IA
- [ ] complete public beta checklist

### Mobile companion
- [ ] scaffold Expo app routes
- [ ] add sign-in flow
- [ ] add runs and artifacts views
- [ ] add billing visibility
- [ ] add notifications surface

### Operations
- [ ] complete runbooks
- [ ] complete observability dashboards
- [ ] harden support/admin workflows
- [ ] launch public beta
