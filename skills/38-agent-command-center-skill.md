# Skill 38: Agent Command Center

**Status**: Wave-6. File exists. Never ran. Not in orchestrator. Not promoted to Brain.  
**Remapped from**: architecture skill 17. Wave-4 already used 17 for Harvest Fail-Closed. Wave-4 stays.  
**Output**: `38_agent_status.json`  
**Needs**: skill 32 registry + live health signals. Dashboard mock ≠ command center.

Does not implement GPU / Slack / Jira / 4 machines. Harvest remains PAUSED. This skill does not unpause it.

## Contract

- Consume 32. Do not overwrite Wave-4 17.
- GAP without health evidence. Fail closed. No auto-promote.
- Activate / Engage language only.
