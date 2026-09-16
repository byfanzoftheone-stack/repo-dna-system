# Clipboard Agent — Visual Surface

This folder contains the React UI for the Clipboard Agent skill.

## Files

- `Clipboard.jsx` — Main component (Intake / Review / Released / Log)
- `schema.js` — Shared Hand-off schema helpers (`makeHandoff`, `toMarkdown`, `fromMarkdown`)

## Authority

The skill definition (`../SKILL.md`) and `organism-constitution` remain the source of truth.

- Schema changes must be made in the skill first, then reflected here.
- The UI never auto-promotes. Human review (gate 5) is required before any Brain release.
- All Hand-offs stay in `status: pending` until explicitly approved.

## Usage

Import the component into THE ONE HQ, Companion, or any surface that needs the governed intake UI:

```jsx
import Clipboard from "./ui/Clipboard.jsx";
```

The component is self-contained and uses `window.storage` when available for persistence.
