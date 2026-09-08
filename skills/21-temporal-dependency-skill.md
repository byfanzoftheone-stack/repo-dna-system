# Skill 21: Temporal Dependency Analyzer

**Status**: Wave-5. File exists. Never ran. Not in orchestrator. Not promoted to Brain.  
**Source**: Blind Spot 2 — `DNA_BLIND_SPOTS_ANALYSIS.md`  
**Output**: `21_temporal_deps.json`  
**Needs**: lockfile history across repos over a time window.

Flags version divergence, upgrade deadlocks, coordinated upgrade chains, “works on my machine” pin drift.

Wave-4 skill 6 maps declared deps once. This skill tracks them over time. Do not overwrite skill 6.

## Contract

- Evidence: lockfile commits + dates. GAP over guess.
- Fail closed. No auto-promote.
- Activate / Engage language only.
