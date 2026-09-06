# Skill 24: Graceful Degradation Analyzer

**Status**: Wave-5. File exists. Never ran. Not in orchestrator. Not promoted to Brain.  
**Source**: Blind Spot 5 — `DNA_BLIND_SPOTS_ANALYSIS.md`  
**Output**: `24_degradation.json`  
**Needs**: catch-all fallbacks + success metrics that hide quality loss.

Flags silent stale cache, skipped validation under load, timeout-as-success, client retry masking server failure.

## Contract

- A green success rate is not evidence of healthy behavior.
- GAP over guess.
- Fail closed. No auto-promote.
- Activate / Engage language only.
