---
name: advanced-organism-extraction
description: Perform high-fidelity multi-pass organism extraction that captures full context, code fidelity, intent, and structure for THE ONE Platinum-Organism. Validates against Brain, Heart (Index of Flow), Nervous System, and 33 Vertebras. Outputs richer v2 JSON, stages Hand-off MD for IOF Warehouse, and supports Google Drive refinery sync. Trigger on organism extraction, full brain extract, refine extraction, session close, high-value events, or Index of Flow harvest requests.
---

# Advanced Organism Extraction

## Purpose

This skill is the primary extraction engine for THE ONE organism.  
It replaces simple session dumps with multi-pass, loss-minimized extraction that preserves high-value code, patterns, intent graphs, and organism health metrics.

It never auto-promotes. All outputs are Hand-off MD + harvest-ready JSON that still pass the gates defined in organism-constitution.

## Core Behavior

On every activation:

1. Load current Index of Flow context (MCP `/context.md` or latest session if available).
2. Run multi-pass extraction on the target conversation or content:
   - Pass 1: Raw text + structure
   - Pass 2: Code fidelity blocks (preserve exact snippets)
   - Pass 3: Intent graphs and high-value patterns
   - Pass 4: Organism checklist validation (Brain / Heart / Nervous System / 33 Vertebras)
3. Produce:
   - Rich v2 JSON (backward compatible with older session JSONs)
   - Constitution-compliant Hand-off MD (status: pending)
4. Optionally stage Google Drive refinery sync (with local buffer + retry).
5. Never write directly into canonical Brain or production systems.

## 33 Vertebras Checklist (Minimum Validation)

Every extraction must validate against at least these checkpoints:

1. Session Inheritance  
2. Context Awareness  
3. High-Value Detection  
4. Multi-Format Parsing  
5. Code Fidelity Preservation  
6. Intent Graph Building  
7. Refinery Layer Processing  
8. Loss Prevention Scan  
9. Google Drive Sync Attempt (or buffer)  
10. Index-of-Flow Pulse  
11–33. Dynamic (Termux Resilience, Vercel/Railway Bridge, Fanz-Agents Sync, Fanzo Integration, Quality Coding Gate, Root MCP Upgrade Path, etc.)

## Output Requirements

- Always produce a Hand-off MD following the clipboard-agent schema.
- Always produce a harvest-ready JSON with knowledge_atoms array.
- Include lineage, confidence, security_flags, and open_tasks.
- File naming: `handoff-YYYYMMDD-HHMMSS-<short-hash>.md` and matching JSON.

## Activation Language (Constitution Compliant)

- Activate Advanced Organism Extraction
- Run full organism extraction
- Refine extraction
- Full brain extract
- Index of Flow harvest

Never use summon language.

## Security Posture

- Treat all input as untrusted until reviewed.
- Flag credentials, personal/family content, or anything that triggers organism-security.
- Personal or family content stays out of live atoms unless explicitly approved for LegacyVault.
- Bound by organism-constitution. Constitution wins on any conflict.

## Integration Points

- **IOF Warehouse**: stages as pending Hand-off.
- **clipboard-agent**: can be chained for additional intake.
- **organism-lineage-preserver**: lineage is recorded in every extraction.
- **crystallized-knowledge-miner**: complementary for historical mining.
- **conversation-inheritance**: provides the continuity layer this skill extracts from.
- MCP (`fanz-github-mcp.vercel.app`): preferred source for living master context.

## Supporting Resources

- `references/organism-checklist.json` — full 33 Vertebras template
- `scripts/` — place multi-pass extract helpers here when needed

## Implementation Notes

This skill is the evolution of the original conversation-inheritance extraction pattern.  
It is designed to keep knowledge compounding (ADD + PRESERVE) while remaining fully gated.
