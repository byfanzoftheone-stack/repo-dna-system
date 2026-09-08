# Orchestrator v2 — skills 5–9 wired · forensic 19–23 filled

**Date**: 2026-09-06  
**Status**: Orchestrator runs these. Outputs are local. Not promoted to Brain.  
**Live README.md / INDEX.md**: not rewritten.

## Pipeline

```
1 scout → 2 extractor → 3 README auditor
  → 5 security → 6 deps → 7 quality → 8 assets → 9 architecture
  → 3.5 forensic (23 sections) → 4 README.rewrite.md
```

Skill **0** stays synthesis (file exists, not a separate step — skill 2 still writes `02_repo_dna.json`).  
Skills **10–40** stay files. Orchestrator does not run them.

## Why this wave

Skill 4’s 23-section list was a contract. Skill 3.5 in the shell was a **placeholder** (keys 1, 3, 10, 18, 23 only).  
The highlighted tail — **19 What’s Missing · 20 Critical Path · 21 Architectural Recommendation · 22 Final System Map · 23 Executive Verdict** — had no evidence behind it.

Skills 5–9 existed as LIVE guides. The orchestrator never called them.

## Outputs (local `dna-extracts/{owner}/{repo}/output/`)

| Skill | File |
|---|---|
| 1 | `01_scout_output.json` (+ `00_tree.json` cache) |
| 2 | `02_repo_dna.json` |
| 3 | `03_readme_audit.json` |
| 5 | `04_security_audit.json` |
| 6 | `05_dependency_map.json` |
| 7 | `06_code_quality.json` |
| 8 | `07_asset_inventory.json` |
| 9 | `08_architecture.json` + `08_architecture.txt` |
| 3.5 | `03.5_forensic_report.json` (all 23 keys) |
| 4 | `README.rewrite.md` — **never** live `README.md` |
| final | `10_consolidated_dna_report.json` (single merged DNA result) |

## Forensic 19–23 (fail-closed)

- **19** compiled from gaps in 5–9 + missing tests/CI/license + truncated tree + secrets **paths** (no values).
- **20** only steps that follow from P0. No invented product roadmap.
- **21** KEEP / MODIFY / DEPRECATE from tree evidence. `rebuild` stays empty unless the tree is empty.
- **22** ASCII from skill 9. GAP if tree truncated.
- **23** verdict from verified lists only. `commercial_potential` defaults **UNKNOWN**.

## Contract

- GAP over guess. Evidence paths required.
- Secrets: flag **path + type**. Do not copy values into extracts.
- Fail closed. No auto-promote. No live README rewrite. No auto-push.
- Activate / Engage language only.
- Tree fetched **once** (Termux-safe). Truncation is a gap, not a small repo.
