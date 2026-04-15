# almanac

Almanac builds canonical public project artifacts from GitHub work and keeps a watched repository mirror on disk so analysis runs against real files, not just API metadata.

## Current status

This repository is in bootstrap mode and is working toward Milestone 0 in `PLAN.md`.

What exists today:
- canonical planning and governance docs
- bootstrap Go CLI and API entrypoints
- initial `spec/v1/` contract files
- a starter `Makefile`, Go module, and pnpm workspace manifest

What is still missing:
- the locked scaffold for `pkg/`, `internal/`, `apps/`, and `sdk/`
- `turbo.json` and actual workspace packages
- schema placeholders beyond the current spec roots
- workflow and issue template scaffolding

## Product rules

These rules are already locked:
- public artifacts are `PROJECTS.md`, `projects.csv`, `projects.json`, and `projects.pdf`
- analysis runs against a watched repository mirror on disk
- analysis outputs stay separate from public artifacts
- Go owns operational logic
- TypeScript is for UI and SDK only

## Repository guide

- `PLAN.md` — canonical architecture and roadmap
- `TASKS.md` — milestone checklist
- `DECISIONS.md` — locked product decisions
- `spec/v1/` — canonical contract surface
- `cmd/almanac` — bootstrap CLI
- `cmd/almanacd` — bootstrap API daemon
- `runbooks/` — operational runbook standards

## Bootstrap commands

From the repository root:

```bash
make test
make build
```

Direct Go commands:

```bash
go test ./...
go build ./cmd/almanac ./cmd/almanacd
```

## Evaluation summary

During this review, the bootstrap Go paths compiled and `go test ./...` passed.

The JavaScript workspace is only partially scaffolded today:
- `package.json` and `pnpm-workspace.yaml` exist
- `turbo.json` does not exist yet
- no workspace packages exist under `apps/` or `sdk/`

## How to work in this repo

1. Read `PLAN.md`, `AGENTS.md`, and `TASKS.md` first.
2. Keep changes aligned with Milestone order.
3. Update source-of-truth docs when behavior or scope changes.
4. Do not blur analysis outputs into public artifacts.

## Near-term focus

The next meaningful bootstrap steps are:
- finish the remaining Milestone 0 governance files and GitHub scaffolding
- add the locked repo tree and placeholder packages
- complete the spec placeholders for core and watched-analysis models
- wire the TypeScript workspace that `package.json` already expects
