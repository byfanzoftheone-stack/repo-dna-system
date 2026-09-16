---
name: repo-dna-adapter
description: Maps Copilot repo-dna-system names, schemas, and 30-skill sprawl onto the governed organism Repo DNA stack. Use when ingesting Copilot thread output, repo-dna-system docs, scout/extractor aliases, or when something from that repo does not match the organism registry.
---

# Repo DNA Adapter

## Purpose

Keep one stack. The Copilot session built a parallel document system inside `byfanzoftheone-stack/repo-dna-system`. THE ONE already has a governed stack. This skill translates that material and rejects what cannot pass the constitution.

## Canonical stack (keep)

1. repo-discovery
2. repo-dna-extractor
3. readme-auditor
4. readme-bootstrapper
5. registry-assembler
6. lineage-mapper (optional)

Orchestrator — repo-dna-stack.

## Alias map (Copilot name to organism skill)

- repo-scout-skill / Skill 1 — repo-discovery
- dna-extractor-skill / Skill 2 — repo-dna-extractor
- readme-auditor-skill / Skill 3 — readme-auditor
- readme-generator-skill / Skill 4 — readme-bootstrapper
- batch-assembler-skill / Skill 5 — registry-assembler
- lineage-mapper-skill / Skill 6 — lineage-mapper
- ledger-sync-skill / Skill 7 — clipboard-agent plus Index of Flow gates (never auto-commit)

See `references/alias-map.md` for the reject list.

## What to keep from Copilot repo

- Evidence-first language
- GAP instead of guessing
- Termux-safe shell (curl + jq, no Docker)
- Incremental / cache idea for repeat runs
- Schema field ideas that already map to extractor output
- Public inventory of `byfanzoftheone-stack` repos from GitHub API

## What not to import

- Skills 0 plus 3.5 through 30 as separate organism skills
- Blind-spot skills 20-30 that need production telemetry, Slack, Jira, GPU, 4-machine clusters
- Claims of 46 min to 5 min with no measured baseline
- Auto-commit / unsigned ledger writes
- Overwrite of live README.md
- Schema that drops organism required keys (core_capabilities, evidence, gaps)

## How to adapt a Copilot artifact

1. Identify the Copilot skill number or filename.
2. Map it through the alias table.
3. If mapped, extract only contracts and evidence rules. Rewrite into the existing SKILL.md. Do not create a duplicate skill.
4. If unmapped and it requires runtime telemetry you do not have, record a GAP in lineage. Do not stand up a new skill.
5. If it is a shell script, keep curl/jq only. Drop Node/Redis/GPU unless those already exist in the organism.
6. Output stays quarantined. Hand-off MD required before any GitHub write.

## Registry truth

Live GitHub search on 2026-09-06 returned 74 repos under `byfanzoftheone-stack`, not 62. Use the inventory file, not memory counts.

Inventory path (sandbox) — `/home/workdir/artifacts/repo-dna-registry/github-inventory-2026-09-06.json`

That file is inventory only. It is not `index.json`. Assembler still requires per-repo `repo_dna.json`.

## Compliance

Bound by organism-constitution. Sandbox only. No auto-promote.
