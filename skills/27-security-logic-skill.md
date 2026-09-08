# Skill 27: Security Logic Analyzer

**Status**: Wave-5. File exists. Never ran. Not in orchestrator. Not promoted to Brain.  
**Source**: Blind Spot 8 — `DNA_BLIND_SPOTS_ANALYSIS.md`  
**Output**: `27_security_logic.json`  
**Needs**: auth flow paths. Skill 5 already flags committed .env / keys. This skill is logic, not scanners.

Flags privilege escalation, frontend-only checks, TOCTOU, stale role cache, default-admin init.

Wave-4 hit (skill 5 / 13): `sample-market` `frontend/.env` stays quarantined. Do not re-promote.

## Contract

- Evidence paths required. GAP over guess.
- Secrets stay quarantined.
- Fail closed. No auto-promote.
- Activate / Engage language only.
