---
name: repo-dna-stack
description: Orchestrates the full Repo DNA skill stack for accurate multi-repo capability registries. Use when building organism-wide repo inventories, generating schema-valid DNA reports, auditing or rewriting READMEs, assembling indexes, or evolving the registry of GitHub repositories. Triggers on repo DNA, registry, capability map, readme audit, lineage map, or skill stack evolution.
---

# Repo DNA Stack

## Purpose

Governed skill stack that produces accurate, evidence-based DNA reports and capability registries. Designed for THE ONE organism so agents and humans can build a trustworthy inventory without hallucination.

This is an orchestrator. Individual skills do one job. This skill sequences them and enforces the shared guardrails.

## Core Principles

- Evidence first. Every factual claim requires a path.
- Fail closed. Empty evidence or schema failure stops the run.
- No guessing. Unknowns become explicit GAP entries.
- Sandbox outputs stay quarantined until Index of Flow or human release.
- Intelligent process only. Speed comes from correct sequence, never from skipped gates.
- One stack. Copilot aliases route through repo-dna-adapter. Do not grow a second 30-skill tree.

## Skill Sequence (Standard Run)

1. repo-discovery — normalized file tree + key asset inventory
2. repo-dna-extractor — schema-valid repo_dna.json
3. readme-auditor — status + reasons against actual code
4. readme-bootstrapper — evidence-grounded README.rewrite.md
5. registry-assembler — multi-repo index.json (when running across many)
6. lineage-mapper — cross-repo graph (optional)

Adapter (when ingesting Copilot / repo-dna-system material) — repo-dna-adapter.

## Shared Guardrails

- Every claim must include evidence path
- Unknowns become GAP entries
- Never omit required schema keys
- Fail if JSON schema validation fails
- Fail if evidence file list is empty
- Prefer under-claiming over over-claiming
- All outputs land as Hand-off ready artifacts
- Never write live README.md
- Never auto-push to GitHub

## Speed that is allowed

Termux-safe only. See `scripts/scout-repo.sh` and `references/termux-batch.md`.

Allowed accelerations

- Parallel scout of many repos with a small concurrency cap (4-8)
- Skip a repo when pushed_at and default_branch sha match last scout cache
- Progressive output (inventory first, DNA second)

Not allowed as "done"

- GPU / Redis / 4-machine claims from Copilot performance doc
- Blind-spot skills that need Slack, Jira, or production traces

## When to Activate

- Building or updating the organism repo registry
- Generating accurate capability maps for private or public repos
- Cleaning stale or missing READMEs with evidence
- Preparing structured data for FanzAgent / Refinery / Brain intake
- Any request involving Repo DNA, capability registry, or skill stack evolution
- Any request to continue the Copilot repo-dna-system thread

## Output Contract

Single-repo run

- discovery.json
- repo_dna.json
- readme_audit.json
- README.rewrite.md (optional)
- Hand-off MD ready for Warehouse intake

Multi-repo run

- github inventory JSON (API list, not DNA)
- index.json only from validated DNA files
- lineage-graph.json when stage 6 runs
- validation report
- confidence summary

## Relationship to Organism

- All outputs remain in sandbox / quarantine until explicit release
- Hand-off MD required before any promotion to canonical Brain or live agents
- Respects organism-constitution activation language and integrity rules
- Compatible with clipboard-agent intake patterns
- Security scans stay in organism-security, not a new DNA skill

## Current registry fact

GitHub search 2026-09-06 — 74 repos under byfanzoftheone-stack (5 public, 69 private).
Inventory file — artifacts/repo-dna-registry/github-inventory-2026-09-06.json
DNA extracted — 33 repos (wave-1 18 + wave-2 15). Remaining 41 inventory-only.
Private trees work through the authenticated GitHub connector. Empty repos fail closed.

## Evolution Notes

New skills must follow single-responsibility + evidence + fail-closed.
Candidate later skills (not created until a runner exists) — drift-detector, capability-overlap.
