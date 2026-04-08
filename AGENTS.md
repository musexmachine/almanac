# AGENTS.md

This file tells agents how to execute work in `musexmachine/almanac`.

## Read order

Before changing code or docs, read in this order:

1. `PLAN.md`
2. `AGENTS.md`
3. `TASKS.md`
4. `README.md`
5. `CHANGELOG.md`
6. relevant files under `spec/v1/`

## Source of truth

- `PLAN.md` is the canonical architecture and roadmap.
- `TASKS.md` is the canonical milestone checklist.
- `spec/v1/` is the canonical contract surface.
- `CHANGELOG.md` records externally meaningful changes.

## Product invariants

Never violate these:

- Canonical public artifacts are:
  - `PROJECTS.md`
  - `projects.csv`
  - `projects.json`
  - `projects.pdf`
- Analysis runs against the watched repository mirror on disk.
- Analysis outputs are separate from public artifacts.
- Go owns operational logic.
- TypeScript is for UI and SDK only.
- The TypeScript SDK must not contain business logic.
- Clerk owns identity.
- GitHub App owns GitHub access.
- Stripe owns billing collection.
- Almanac owns authorization, roles, and entitlements.
- CapRover-first deployment.
- Attach to existing services first; provision only what is missing.
- Managed Neon is the default DB path.
- Plain PostgreSQL is the self-hosted fallback.
- Do not self-host Neon.

## Execution rules

- Prefer minimal necessary changes.
- Fix root causes.
- Keep migrations additive.
- Dry-run before publish paths.
- Do not publish analysis-only outputs.
- Do not move client-side code into core engine paths.
- Do not invent a parallel plan file when `PLAN.md` or `TASKS.md` can be updated instead.
- Keep wording concrete and action-oriented.

## Milestone order

Execute in this order:

1. Milestone 0 — bootstrap repo, standards, scaffold
2. Milestone 1 — local truth, clean artifacts, watched workspace core
3. Milestone 2 — hosted beta, auth, billing, publishing
4. Milestone 3 — public product surface, mobile companion, scalable hosted ops

## Completion rule

A task is not done until:

- code or docs changed in repo
- the relevant milestone checklist was advanced
- the change is reflected in the correct source-of-truth file
- build/test/validate path still works
- `CHANGELOG.md` is updated when the change is externally meaningful

## Immediate mandate

Bring the repository from bootstrap placeholder state to Milestone 0 completion without violating the locked product decisions.
