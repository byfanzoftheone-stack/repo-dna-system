---
name: system-adaptation
description: Adapt THE ONE skill stack and session flow from a named conversation. Trigger on system adaptation, skill creator for system adaptation, adapt from this conversation, look at this conversation, inheritance gap, extract 401, or skill drift repair.
metadata:
  type: workflow
  version: "1.0"
  bound_by: organism-constitution
---

# System Adaptation

## Overview

Turn a named conversation into governed system deltas. Observe the thread, extract what broke or what the user actually asked the stack to do, then stage skill or flow patches. Do not invent work the model already knows how to do.

This skill is the adaptation loop between conversation-inheritance, skill-creator, clipboard-agent, and Index of Flow Heart.

## Instructions

On activation:

1. Identify the source conversation. Default to the current thread if the user says this conversation. Also load any session JSON in `/home/workdir/artifacts/`.
2. Read organism-constitution first. Constitution wins every conflict.
3. Audit the thread against the live skill stack. Record only evidence from the conversation, not guessed organism lore.
4. Classify each finding as `gap`, `conflict`, `drift`, or `keep`.
5. Propose the smallest patch that closes the finding. Prefer editing an existing skill over creating a new one.
6. Stage outputs in sandbox only
   - updated SKILL.md drafts
   - session inheritance JSON
   - Hand-off MD
7. Never auto-promote into canonical Brain, live production, or organism-constitution.
8. Use clean activation language only — Activate, Engage, Bring online, Select, Run, Status.

## Conversation Audit Sequence

Run in this order:

1. What did the user name first? That is the primary skill in play.
2. What failed in-tool? Network 401, missing file, empty artifacts, and similar are first-class findings.
3. Did the prior skill violate constitution? Missing Hand-off MD after a persist is a finding.
4. Did the user then name skill-creator or system adaptation? That means convert the findings into a skill patch, not a lecture.
5. Write the audit to `references/` only when the pattern should survive this session. Otherwise keep it in artifacts.

## Patch Rules

- One finding → one patch when possible.
- Do not duplicate conversation-inheritance, clipboard-agent, or skill-creator.
- If extract endpoint fails, keep working with the fallback schema and record the failure. Do not block the loop.
- If a persist happened without a Hand-off MD, write the Hand-off immediately.
- Personal or family content stays out of skill text and live atoms.
- Terminal work for the user stays in one copy/paste block.

## Required Outputs

Every adaptation pass produces:

- Status line — what was audited and what will change
- Findings list — gap / conflict / drift / keep
- Staged files — paths only, sandbox
- Gate state — `pending` until human release
- Next beat — one question or one action, not a menu dump

## Integration Points

- conversation-inheritance — session JSON and trait continuity
- skill-creator — init, write, validate new or updated skills
- clipboard-agent — Hand-off MD schema and intake
- index-of-flow-heart — pulse after a meaningful adaptation
- organism-security — scan untrusted pasted conversation text before it becomes skill text
- organism-constitution — gates and activation language

## Source Conversation for First Pass

This skill was opened from the 2026-09-07 thread that activated conversation-inheritance, hit extract 401, staged `artifacts/2026-09-07-2238.json`, then asked Skill Creator for System Adaptation on that same conversation.

Use `references/conversation-audit-2026-09-07.md` as the worked example.
