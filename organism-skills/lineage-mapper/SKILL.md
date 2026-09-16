---
name: lineage-mapper
description: Maps cross-repo lineage from validated repo_dna.json files and GitHub inventory. Use after registry assembly when you need shared assets, name families, fork signals, or dependency overlap. Triggers on lineage map, cross-repo graph, shared prompts, or skill stack stage 6.
---

# Lineage Mapper

## Purpose

Build a conservative cross-repo graph from evidence. Never invent relationships.

## Input

- Directory of repo_dna.json files (preferred)
- Optional GitHub inventory JSON
- Optional index.json from registry-assembler

## Output

`lineage-graph.json` plus optional `lineage-graph.md`.

```yaml
generated_at: ISO8601
schema_version: "1.0"
nodes: [{id, full_name, tags}]
edges: [{from, to, type, evidence}]
clusters: [{name, members, evidence}]
gaps: []
confidence: 0.0-1.0
```

Allowed edge types — name-family, shared-manifest-dep, shared-path-pattern, documented-link, fork.

## Instructions

1. Load only files that exist. Skip invalid DNA. Record each skip as GAP.
2. Group by name families with evidence (example — Warehouse*, Little-Pro*, the-one-brain*).
3. If DNA lists the same npm/pypi package in two repos, add shared-manifest-dep with both evidence paths.
4. If DNA lists identical prompt or agent filenames, add shared-path-pattern.
5. Do not infer service calls from names alone.
6. Inventory-only repos may appear as nodes with tag inventory-only. They must not get capability edges.
7. Fail if zero nodes.

## Relationship

Stage 6 of repo-dna-stack. Complements organism-lineage-preserver (heritage narrative). This skill writes the graph file only.

## Compliance

Sandbox output. Hand-off required before promotion.
