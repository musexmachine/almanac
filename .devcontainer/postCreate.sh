#!/usr/bin/env bash
set -euo pipefail

if command -v go >/dev/null 2>&1; then
  go mod tidy || true
fi

if command -v pnpm >/dev/null 2>&1; then
  pnpm install || true
fi

if [ -f Makefile ]; then
  make help || true
fi

echo "Codespaces bootstrap finished for Almanac."
