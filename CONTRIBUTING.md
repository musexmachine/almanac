# Contributing

## Workflow

- read `PLAN.md`, `AGENTS.md`, and `TASKS.md` first
- keep changes scoped
- update docs/specs with behavior changes
- do not bypass the locked product decisions

## Branch naming

Use:

```text
<type>/<short-kebab-slug>
```

Examples:
- `feat/spec-v1-schemas`
- `fix/pdf-render-timeout`
- `docs/caprover-setup`

## PR titles

Use:

```text
type(scope): concise summary
```

Examples:
- `feat(spec): add inventory schema`
- `fix(render): block private leak in markdown`

## Done criteria

A change is not done until:
- code or docs changed in repo
- tests or validation path still works
- relevant milestone checklist advanced
- `CHANGELOG.md` updated when externally meaningful
