---
name: clipboard-agent
description: Governed Clipboard Agent for THE ONE organism. Captures clipboard content, writes structured Hand-off MD files, stages pending atoms in IOF Warehouse intake, and never auto-promotes. Connects to terminal, session JSONs, Index of Flow, and governed gates. Activate on any mention of clipboard, copy, hand-off, intake, harvest, or capture-to-warehouse flow.
---

# Clipboard Agent

## Purpose

The Clipboard Agent is the primary governed intake surface for knowledge, code, conversation extracts, and agent outputs.  
It turns every meaningful copy into a structured, reviewable artifact that can move cleanly through Index of Flow without cutting corners.

It implements the Hand-off requirements defined in the organism-constitution.

## Core Behavior

On every governed capture:

1. Read the clipboard content.
2. Write a structured Hand-off MD file to the governed intake folder.
3. Optionally stage a lightweight pending atom in IOF Warehouse.
4. Optionally notify the local terminal / FanzAgent.
5. Never auto-promote anything into the canonical Brain or production systems.

Promotion happens only through the gate structure in the constitution.

## Hand-off MD Schema (Required)

Every Hand-off file must contain at minimum:

```markdown
---
id: handoff-YYYYMMDD-HHMMSS-<short-hash>
timestamp: ISO-8601
source: clipboard | terminal | session | agent | manual
category: theory | architecture | insight | system | philosophy | pattern | build | other
confidence: 0.0-1.0
security_flags: []
session_id: <optional>
status: pending
lineage: []
---

# Title

## Content

<the actual captured text or code block>

## Notes

- Why this was captured
- Suggested next gate or action
```

File naming convention:
`handoff-YYYYMMDD-HHMMSS-<short-hash>.md`

Default intake location (Android / Termux):
`/sdcard/Download/IOF/clipboard/` or the equivalent Termux-shared path that the Warehouse harvest can see.

## Integration Points

- **IOF Warehouse**: stages as pending. Uses the same intake / promote endpoints that catchup-skill already understands.
- **Terminal / FanzAgent**: can receive a notification or a simple pipe of the hand-off path.
- **Session JSONs**: when a session_id is present, the hand-off links back to it for continuity.
- **Index of Flow**: hand-off files are the primary reviewable unit that can be circled, linted, and released.
- **Lint gates**: every new hand-off is eligible for skill / content / security lint before review.

## Activation and Status Language

Use only constitution-compliant language:
- Activate Clipboard Agent
- Engage Clipboard Agent
- Clipboard Agent status
- Bring Clipboard Agent online

Never use summon or equivalent.

## Security Posture

- Treat all clipboard content as untrusted until reviewed.
- Flag credentials, personal/family content, or anything that triggers organism-security rules.
- Personal or family content stays out of live atoms unless explicitly approved for LegacyVault.
- 2FA / GitHub boundaries are never bypassed by this agent.

## Relationship to Constitution

This skill is bound by organism-constitution.  
It may not weaken any gate, language rule, or sandbox rule.  
If a conflict appears, the constitution wins.

## Implementation (Current)

### Capture Surface (CLI)
Script:
`scripts/create-handoff.sh`

Usage (Termux):
```bash
termux-clipboard-get | create-handoff.sh "optional title"
echo "text" | create-handoff.sh
```

It writes a constitution-compliant Hand-off MD into the governed intake folder with `status: pending` and never auto-promotes.

### Review & Release Surface (UI)
Location:
`ui/Clipboard.jsx` + `ui/schema.js`

- Full Intake → Review → Released → Log interface
- Isomorphic schema with the Hand-off MD format
- Human gate (Index of Flow) required before any Brain release
- Import Hand-off MD supported

Import into HQ / Companion or any surface:
```jsx
import Clipboard from "./ui/Clipboard.jsx";
```

### Intake README
`/home/workdir/artifacts/iof-intake/README.md`

## Future Extensions (Governed)

- One-tap Create Hand-off from current selection
- Automatic categorization hints
- Direct Send to Sandbox for prototype path (still quarantined)
- Lint status badge on each hand-off
- Real Static Lint + Security checks in place of simulated gates

All extensions must preserve the never-auto-promote rule and the multi-layer gate structure.
