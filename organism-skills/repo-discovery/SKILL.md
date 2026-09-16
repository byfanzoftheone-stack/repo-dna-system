---
name: repo-discovery
description: Produces a normalized, evidence-based inventory of a single repository. Use when scanning any repo for structure, key files, manifests, workflows, prompts, agents, schemas, or Docker/IaC before DNA extraction. Triggers on repo discovery, file tree, key assets, or first stage of Repo DNA.
---

# Repo Discovery

## Purpose

Create a clean, factual inventory of what actually exists in a repository. No interpretation. No guessing. This is the foundation every later skill depends on.

## Input

```yaml
owner: string
repo: string
ref: string          # default main or HEAD
depth: shallow|full  # optional
```

## Output Contract

```yaml
repo: "owner/repo"
ref: string
scanned_at: ISO8601
file_tree: [relative paths]
key_files:
  readme: path | null
  package_manifests: [paths]      # package.json, pyproject.toml, Cargo.toml, go.mod, etc.
  workflows: [paths]              # .github/workflows/*
  docker_iac: [paths]             # Dockerfile, docker-compose, terraform, k8s
  prompts: [paths]                # *.prompt, prompts/, system prompts
  agents: [paths]                 # agent definitions, crew configs
  schemas: [paths]                # *.schema.json, prisma, zod, openapi
  configs: [paths]                # tsconfig, eslint, next.config, etc.
  docs: [paths]
evidence: [all paths examined]
gaps: []                          # only structural absences (e.g. "No README found")
```

## Instructions

1. Resolve the repository and ref.
2. Build a normalized relative file tree (ignore node_modules, .git, dist, build, coverage, .next unless explicitly requested).
3. Identify key files by exact pattern matching and conventional locations.
4. Record every path that was examined in `evidence`.
5. If a expected category is completely empty, add a clear GAP entry.
6. Never invent files or assume contents.
7. Fail the run if zero source files are discovered.

## Failure Conditions

- Empty repository or zero readable files
- Authentication failure on private repo
- Invalid owner/repo format

## Notes

This skill is deliberately strict and non-interpretive. Intelligence comes later in the extractor. Keep it pure.
