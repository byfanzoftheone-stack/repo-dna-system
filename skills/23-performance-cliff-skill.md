# Skill 23: Performance Cliff Detector

**Status**: Wave-5. File exists. Never ran. Not in orchestrator. Not promoted to Brain.  
**Source**: Blind Spot 4 — `DNA_BLIND_SPOTS_ANALYSIS.md`  
**Output**: `23_perf_cliffs.json`  
**Needs**: volume vs latency curves. Big-O on a file is not a cliff.

Flags non-linear slowdowns, cache thrash thresholds, pool exhaustion, P95 cliffs.

Architecture’s “90x cache / 280x first insight” numbers are claims in `DNA_PERFORMANCE_OPTIMIZATION.md`. This skill does not treat those as measured.

## Contract

- Evidence: metrics, not slogans.
- GAP if no production series.
- Fail closed. No auto-promote.
- Activate / Engage language only.
