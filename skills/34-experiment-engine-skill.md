# Skill 34: Experiment Engine

**Status**: Wave-6. File exists. Never ran. Not in orchestrator. Not promoted to Brain.  
**Remapped from**: architecture skill 13. Wave-4 already used 13 for Secrets Quarantine. Wave-4 stays.  
**Output**: `34_experiments.json`  
**Needs**: a sandbox + rollback plan. No live-repo writes.

Does not A/B test in production. Does not auto-push. Human gate before any experiment lands.

## Contract

- Sandbox only. No live README rewrite. No auto-push.
- GAP if no rollback path.
- Fail closed. Activate / Engage language only.
