# Skill 28: Data Corruption Analyzer

**Status**: Wave-5. File exists. Never ran. Not in orchestrator. Not promoted to Brain.  
**Source**: Blind Spot 9 — `DNA_BLIND_SPOTS_ANALYSIS.md`  
**Output**: `28_data_flow.json`  
**Needs**: transform paths + stored samples. A `db.save` is not proof of integrity.

Flags lossy transforms, timezone bugs, encoding, null-as-zero, cascade-delete, cross-repo drift.

## Contract

- Evidence paths required.
- GAP if no stored samples.
- Fail closed. No auto-promote.
- Activate / Engage language only.
