# Almanac Spec v1

This directory holds the canonical contract for Almanac v1.

## Purpose

`spec/v1/` is the source of truth for:
- API transport contract
- config schema shape
- project/inventory model shape
- artifact model shape
- watched-folder analysis model shape
- examples, fixtures, and golden outputs

## Required files

At minimum, v1 should define:
- `openapi.yaml`
- `enums.yaml`
- core JSON schemas
- watched-analysis JSON schemas
- examples
- fixtures
- golden outputs

## Rules

- API prefix remains `/v1`
- canonical public artifact names remain fixed
- breaking contract changes require a new version path
- generated SDK output must follow this spec, not invent new behavior
