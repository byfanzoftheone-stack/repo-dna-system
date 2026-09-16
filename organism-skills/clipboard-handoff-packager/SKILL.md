---
name: clipboard-handoff-packager
description: Packages staged IOF Hand-off MD files and harvest JSONs into clean, clipboard-ready blocks or Brain ingest curl commands. Bridges the gap between local intake and the governed clipboard key card / Google Drive workflow. Triggers on package handoff, clipboard package, prepare for clipboard, generate ingest curls, or master handoff packaging.
---

# Clipboard Handoff Packager

## Purpose

After Advanced Organism Extraction or any Hand-off batch is staged in `/home/workdir/artifacts/iof-intake/`, this skill produces:

1. A single clean Master Consolidation document (for Claude or any AI)
2. Clipboard-ready blocks the human can paste into the key card
3. Optional Brain ingest curl commands (one atom or batch) that still require human approval

Nothing auto-promotes. Everything remains governed.

## Core Behavior

1. Scan `/home/workdir/artifacts/iof-intake/` for pending Hand-offs and harvest JSONs.
2. Consolidate high-value content into one Master Hand-off following the clipboard-agent schema.
3. Produce clipboard-ready markdown or JSON blocks.
4. Optionally generate authenticated curl commands for `/v5/brain/ingest` using the correct field names (`core`, valid categories, batch format `{"atoms":[...]}`).
5. Never write to canonical Brain, Google Drive, or production systems.

## Safe Agentic Pattern (Warehouse Sandbox)

```
Quarantine → Validate → Human Promote → Sandbox Execute → Results return to Warehouse
```

Rules that stay non-negotiable:
- Nothing leaves the Warehouse without explicit human consent
- No direct writes to canonical Brain or production systems
- Fingerprint + runtime verification still required
- High-impact actions still require human release
- Compound Protocol (ADD + PRESERVE) always applies

## Activation Language

- Activate Clipboard Handoff Packager
- Package handoffs for clipboard
- Prepare Master Consolidation
- Generate ingest curls
- Package for Claude

Never use summon language.

## Security

Bound by organism-constitution and organism-security.  
Human remains the final gate.
