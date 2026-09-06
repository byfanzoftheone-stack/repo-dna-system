# Skill 26: Distributed Systems Analyzer

**Status**: Wave-5. File exists. Never ran. Not in orchestrator. Not promoted to Brain.  
**Source**: Blind Spot 7 — `DNA_BLIND_SPOTS_ANALYSIS.md`  
**Output**: `26_distributed.json`  
**Needs**: traces across services. A fetch() in source is not a partition.

Flags inconsistency windows, cascade timeouts, clock skew, missing tracing, split-brain risk.

Most of this portfolio is single-process Vercel apps. GAP if there is no trace graph.

## Contract

- Evidence paths required.
- Fail closed. No auto-promote.
- Activate / Engage language only.
