---
name: readme-auditor
description: Judges the current README against actual code reality using DNA evidence. Use after DNA extraction to score README quality and surface stale or missing claims. Triggers on readme audit, readme status, or third stage of Repo DNA stack.
---

# README Auditor

## Purpose

Compare the existing README to the evidence in `repo_dna.json` and produce an honest status report. This skill never rewrites — it only diagnoses.

## Input

- Repository identity
- `repo_dna.json`
- Current README content (if present)

## Output Contract

```yaml
repo: "owner/repo"
status: missing | partial | stale | good
score: 0-100
reasons: []
missing_sections: []
outdated_claims: []
evidence: []
gaps: []
```

## Instructions

1. If no README exists, status = missing and score = 0.
2. Check whether purpose, capabilities, quick start, and architecture sections exist and match DNA evidence.
3. Flag any claim in the README that is not supported by evidence paths.
4. Flag any strong capability present in DNA that is completely absent from the README.
5. Produce a short list of concrete reasons.
6. Never invent improvements here — that is the bootstrapper's job.

## Failure Conditions

- Missing or invalid `repo_dna.json`
- Empty evidence list in DNA
