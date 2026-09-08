# Skill 20: Runtime Behavior Analyzer

**Status**: Wave-5. File exists. Never ran. Not in orchestrator. Not promoted to Brain.  
**Source**: Blind Spot 1 — `DNA_BLIND_SPOTS_ANALYSIS.md`  
**Output**: `20_runtime_behavior.json`  
**Needs**: live traces / heap / GC / queue metrics. Static tree is not enough.

Flags what a snapshot misses: unbounded Maps, race windows, GC pauses, cascade timeouts, queue buildup under load.

## Contract

- No inferred leaks without a measured path.
- GAP if production metrics are missing.
- Fail closed. No auto-promote.
- Activate / Engage language only.
