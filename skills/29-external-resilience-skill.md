# Skill 29: External Dependency Resilience

**Status**: Wave-5. File exists. Never ran. Not in orchestrator. Not promoted to Brain.  
**Source**: Blind Spot 10 — `DNA_BLIND_SPOTS_ANALYSIS.md`  
**Output**: `29_external_deps.json`  
**Needs**: outbound calls + timeout / retry / circuit-breaker evidence.

Flags missing breakers, thundering-herd retries, inconsistent timeouts, harvest auto-POST (already fail-closed by skill 17).

Related live fact: `harvest.js` sha `cb277eed` auto-POSTs Railway `/v1/brain/ingest`. Harvest **PAUSED**. This skill does not unpause it.

## Contract

- Evidence paths required.
- Fail closed. No auto-promote. No Railway ingest from this skill.
- Activate / Engage language only.
