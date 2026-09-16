---
name: readme-bootstrapper
description: Generates an evidence-grounded README.rewrite.md from DNA and discovery data. Use after audit when the README is missing, partial, or stale. Triggers on readme rewrite, bootstrap readme, or fourth stage of Repo DNA stack.
---

# README Bootstrapper

## Purpose

Produce a high-quality `README.rewrite.md` that is strictly grounded in observed facts from discovery and DNA. Never overwrites the real README automatically.

## Input

- Discovery output
- `repo_dna.json`
- Optional current README (for reference only)

## Output

`README.rewrite.md` with this recommended structure:

1. Purpose (one clear paragraph)
2. Core Capabilities (bullet list with evidence)
3. Quick Start (only if real commands/config exist)
4. Architecture (high-level, evidence-based)
5. Key Assets (prompts, agents, schemas if present)
6. Status / Gaps (honest)

## Instructions

1. Use only paths present in evidence.
2. Prefer under-claiming. If something is unclear, omit or mark as GAP.
3. Keep language direct and professional.
4. Do not invent install steps, badges, or features.
5. Output must be valid Markdown.
6. Never write directly to README.md — always produce a rewrite file.

## Failure Conditions

- Empty evidence
- Invalid or missing DNA input
