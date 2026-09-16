---
name: registry-assembler
description: Aggregates many individual repo_dna.json files into a single trustworthy index.json using the canonical index.schema.json v1.1.0. Use when building or updating the organism-wide capability registry. Triggers on registry, index assembly, multi-repo DNA, or final stage of Repo DNA stack.
---

# Registry Assembler

## Purpose

Combine validated single-repo DNA reports into one coherent, auditable registry index that conforms to `index.schema.json` v1.1.0. This is the multi-repo gate.

## Canonical Schema

All output must validate against:

`references/index.schema.json` (schema_version: "1.1.0")

## Input

List of paths to `repo_dna.json` files (or a directory containing them).

## Output Contract

Produces `index.json` that strictly matches the schema:

- schema_version: "1.1.0"
- registry_version: string (e.g. "2026.08.02")
- generated_at: ISO8601 datetime
- ecosystem: string
- repos: array of repo_entry objects

Each `repo_entry` must include the full required set (id, name, full_name, repo_url, default_branch, primary_language, current_state, ledger_path, report_path, readme_rewrite_path, evidence_path, readme_exists, readme_status, readme_bootstrapped, last_analyzed_at, confidence, tags, notes).

## Instructions

1. Load each DNA file.
2. Reject any file that fails schema validation or has empty evidence.
3. Map each accepted DNA into a clean `repo_entry` that satisfies the v1.1.0 required fields.
4. Surface cross-repo gaps and low-confidence items in notes or a companion validation report.
5. Never invent relationships between repos (that belongs to lineage-mapper).
6. Fail closed if the final `index.json` does not validate against the schema.

## Failure Conditions

- Zero valid DNA files
- All inputs fail validation
- Final index fails schema validation against references/index.schema.json
