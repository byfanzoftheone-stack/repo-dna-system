---
name: repo-dna-extractor
description: Turns discovery output into a schema-valid repo_dna.json with zero guessing. Use after repo-discovery when building accurate capability maps, DNA reports, or organism registries. Triggers on repo DNA, capability extraction, DNA report, or second stage of the Repo DNA stack.
---

# Repo DNA Extractor

## Purpose

Convert a clean discovery inventory into a strict, evidence-backed DNA report. This is the intelligence layer, but it is still forbidden from inventing facts.

## Input

- Full output from `repo-discovery`
- Optional additional evidence files (README content, key source files, package manifests)

## Output Contract

`repo_dna.json` must contain at minimum:

```yaml
repo: "owner/repo"
ref: string
generated_at: ISO8601
schema_version: "1.1.0"
purpose: string | null          # only if clearly stated or strongly evidenced
core_capabilities: []           # list of {name, description, evidence}
key_assets:
  prompts: []
  agents: []
  schemas: []
  ui_components: []
  other: []
architecture:
  stack: []
  patterns: []
  entry_points: []
lineage_signals: []             # forks, shared names, obvious relationships
metrics:
  file_count: number
  estimated_loc: number | null
gaps: []                        # every unknown becomes a GAP entry
confidence: 0.0-1.0
evidence: [paths]
```

## Instructions

1. Accept only paths present in the discovery evidence list.
2. Extract purpose only from README or explicit top-level docs. If ambiguous, leave null and add GAP.
3. List capabilities only when code or config clearly demonstrates them.
4. Inventory prompts, agents, and schemas by path and short factual description.
5. Architecture section uses only observed stack signals (package.json, imports, config files).
6. Every claim must carry an `evidence` path.
7. Calculate confidence based on evidence density and completeness of key categories.
8. Fail if the resulting JSON does not validate against the schema or if evidence list is empty.

## Hard Rules

- No guessing
- No inferred capabilities without a path
- Prefer GAP entries over soft language
- Required keys must always exist (use null or empty arrays when unknown)

## Schema

Validate against `references/repo_dna.schema.json` (schema_version 1.1.0).

Copilot `repo_dna.schema.json` uses metadata / tech_stack / project_info. Translate those fields into this organism shape. Do not emit the Copilot shape as the organism DNA file.

## Failure Conditions

- Empty evidence
- Schema validation failure
- Discovery input missing or malformed
