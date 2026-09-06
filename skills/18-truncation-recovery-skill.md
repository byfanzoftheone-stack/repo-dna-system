# Skill 18: Truncation Recovery

**Status**: Wave-4 overlay. Sandbox / quarantine. Not promoted to Brain.  
**Output**: `18_tree_recovery.json`  
**Purpose**: A 20k JSON cut is truncated dump, not a small repo.

Connector truncates large trees. Recover:
1. Non-recursive root listing
2. path_filter on src/, skills/, governance/, brain/
3. Never treat truncated dump as inventory complete

Used on the-one-brain (31k+ blobs) and fanz-refinery node_modules.

## Contract

- Evidence paths required. GAP over guess.
- Fail closed. No auto-promote.
- Activate / Engage language only. No occult summon.
