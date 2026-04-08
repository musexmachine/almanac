# Security

## Scope

Almanac handles:
- GitHub App access
- hosted account data
- artifact publication
- billing webhooks
- watched workspace analysis

## Reporting

Until a dedicated disclosure channel is added, report security issues privately to the repository owner.

## Rules

- do not open public issues for unpatched security vulnerabilities
- do not expose secrets in test fixtures or examples
- keep public artifacts separate from private analysis outputs
- do not expose Neo4j, database, or internal worker services publicly unless explicitly required
