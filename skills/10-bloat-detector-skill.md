# Skill 10: Bloat Detector

**Status**: Wave-4 overlay. Sandbox / quarantine. Not promoted to Brain.  
**Output**: `10_bloat.json`  
**Purpose**: Detect committed junk that is not a product.

Flags: node_modules, .next, .cache, .cargo, .npm, __pycache__, zip-only roots, 0-byte pages.

Hits (wave 4):
- the-one-brain — home directory in git (.cache .cargo .npm .next). brain.json 1.83 MB is the signal; caches are not.
- The-One-Dev-Pilot- — backend/node_modules committed
- Little-Pro-V10- — .next + node_modules + 0-byte skin pages
- fanz-refinery — node_modules committed

Output: path + size + class (bloat|stub|zip|real). Never infer capability from a bloated tree.

## Contract

- Evidence paths required. GAP over guess.
- Fail closed. No auto-promote.
- Activate / Engage language only. No occult summon.
