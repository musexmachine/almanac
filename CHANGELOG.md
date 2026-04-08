# Changelog

## [Unreleased]

### Changed
- Almanac now treats **persistent watched-folder analysis** as a first-class product capability, not just a side effect of repository inventory generation.
- The core purpose of repository collection is now explicitly defined as maintaining a **continuously updated watched workspace** that mirrors selected repositories and supports analysis against the real filesystem mirror.
- The product boundary is now split into two coordinated layers:
  - canonical public artifacts:
    - `PROJECTS.md`
    - `projects.csv`
    - `projects.json`
    - `projects.pdf`
  - persistent watched-folder analysis over mirrored repositories.
- The core analysis rule is now locked: **analysis runs against the watched repository mirror on disk, not just GitHub API metadata**.
- Analysis outputs are now explicitly separated from canonical public artifacts and must never be published automatically without passing the publication safety gate.

### Added
- Added roadmap support for a **watched workspace** model that:
  - mirrors selected repositories into a local/server-side root
  - keeps those repositories updated continuously
  - supports full and incremental analysis passes
  - ties analysis results back to profiles, repositories, and runs.
- Added planned standard/schema support for watched-folder analysis with new canonical concepts:
  - `RepositoryMirror`
  - `AnalysisWorkspace`
  - `Analyzer`
  - `AnalysisRun`
  - `AnalysisArtifact`.
- Added planned `spec/v1` expansion for watched analysis:
  - `analysis-workspace.schema.json`
  - `analysis-run.schema.json`
  - `repository-mirror.schema.json`
  - `analyzer.schema.json`.
- Added planned config support for watched-folder analysis under `.github-projects.yaml`, including:
  - workspace root path
  - workspace layout
  - watch enablement
  - sync strategy
  - analyzer selection
  - analysis output policy.
- Added planned Go package areas for the watched-folder subsystem:
  - `mirror`
  - `workspace`
  - `watch`
  - `analyze`
  - `analyzers`
  - `index`.
- Added planned River job families for mirror, watch, and analysis orchestration, including:
  - mirror sync/clone/fetch/checkout
  - full and incremental workspace scans
  - analyzer runs for metadata, language stats, README summaries, and future deeper analysis.
- Added planned API resource families for hosted watched-folder analysis:
  - `/v1/workspaces`
  - `/v1/mirrors`
  - `/v1/analysis-runs`
  - `/v1/analyzers`
  - matching admin endpoints.
- Added planned CapRover service expansion for watched-folder analysis with a dedicated analyzer-oriented workload alongside the already locked app/runtime services.
- Added planned runbooks for watched-folder operations:
  - watched workspace bootstrap
  - mirror sync failures
  - mirror storage capacity
  - analysis run failures
  - filesystem watch failures.

### Integrated analysis guidance
- Integrated the previously researched watched-folder tooling direction into the roadmap as architectural input:
  - **CodeGraphContext** is treated as the leading structural code-graph candidate for serious watched-folder analysis.
  - **Cortex** is treated as the strongest semantic memory/decision-memory candidate, but still early-stage.
  - The combined **CodeGraphContext + Cortex** pattern is now captured as a viable external-analysis architecture when structural graph analysis and semantic project memory are intentionally split.
- Added the CapRover-first analysis pattern to the roadmap:
  - shared read-only mirrored repository root
  - CodeGraphContext owning structural code analysis
  - Cortex owning semantic/high-signal memory extraction
  - separate persistence boundaries for graph and semantic stores
  - backup requirements for mirrors and persistent volumes.

### Milestone impact
- Milestone 0 now needs watched-analysis scaffolding in the repo structure and standards.
- Milestone 1 now includes:
  - watched workspace bootstrap
  - repository mirroring
  - initial analyzer execution
  - proof that public artifacts stay isolated from analysis-only outputs.
- Milestone 2 now includes hosted workspace management, scheduled mirror sync, scheduled analysis runs, and admin visibility into mirror/analyzer failures.
- Milestone 3 now includes richer analysis visibility in the web and mobile product surfaces.
