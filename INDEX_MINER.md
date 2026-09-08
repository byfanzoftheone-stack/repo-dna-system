# Skill 41 — Crystallized Knowledge Miner

**Date**: 2026-09-08  
**Status**: LIVE standalone. Not in orchestrator v2. Not promoted to Brain.  
**Live README.md / INDEX.md**: not rewritten (INDEX.md numbering still drifts).

## Pipeline (separate from DNA)

```
DNA extract (vault or local dna-extracts/{owner}/{repo})
  → python3 crystallized-knowledge-miner.py <extract-dir>
  → output/09_crystals.json
```

Orchestrator stays `1→2→3→5→6→7→8→9→3.5→4`. This skill does not join that line.

## Why

DNA is a fingerprint. Crystals are compressed facts with evidence.
`harvest.js` auto-POST is fail-closed. This miner writes files only.

## First run

`byfanzoftheone-stack/the-one-universe` extract in the private vault.
