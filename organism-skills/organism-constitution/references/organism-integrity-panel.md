# Organism Integrity Panel — Design Reference

Bound by organism-constitution.  
This is the living surface that extends the original EcosystemPartsList (model-kit view).

## Purpose

Single governed view that shows:

- Overall integrity / build progress of the organism
- Status of every major sprue and part
- Active agents (clean activation language only)
- Index of Flow key card + gate status
- Clipboard Agent intake health
- Warehouse ↔ Brain reconciliation status
- Lint / security indicators

## Required Sections

1. **Header / Index of Flow Key Card**
   - Brain atom count (canonical)
   - Warehouse pending count
   - Last catch-up / reconciliation
   - Overall integrity score or status

2. **Quick Actions**
   - Activate Clipboard Agent
   - Run Catch-up
   - Session Start / Extract
   - Engage specific agent (Fanzo, Echo, Jarvis, etc.)
   - Open Sandbox status

3. **The Build (Sprues)**
   - Reuse the existing parts-list model (Chassis & Frame, Engine, Body Panels, etc.)
   - Add integrity indicators per part (lint status, last review, quarantine status)

4. **Agent Strip**
   - List of known agents with status (online / offline / in-sandbox)
   - Activate / Status buttons only (no summon language)

5. **Gate Status Strip**
   - Visual indicators for the multi-layer stack:
     Static Lint → Plan Check → Sandbox → Security → Index of Flow / Human → Released

## Rules

- All language must obey the constitution.
- No auto-promotion controls on this panel.
- Any action that moves content toward the canonical Brain must route through the defined gates.
- Panel itself should eventually be able to display live counts from Warehouse and Brain MCP when the connections are wired.

## Implementation Notes

- Start from the existing React EcosystemPartsList component.
- Add the new sections above without removing the model-kit metaphor.
- Persist state locally first; later connect to live endpoints under governance.

## Current Artifact

Working component created at:
`/home/workdir/artifacts/organism-panel/OrganismIntegrityPanel.jsx`

It includes:
- Index of Flow header with Brain / Warehouse placeholders
- Quick Actions (constitution-compliant language)
- Agent strip (Fanzo, Echo, Jarvis, Clipboard, Guardians)
- Gate Stack visual
- Full sprue / parts list with quarantined status added
- Constitution and Clipboard Agent already marked as built
- Footer integrity statement
