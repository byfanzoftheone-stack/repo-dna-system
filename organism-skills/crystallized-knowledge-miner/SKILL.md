---
name: crystallized-knowledge-miner
description: Mines previous conversations in this Grok thread for keywords like crystallize, forge (EchoForge, Third Eye Forge, LifeForge), Index of Flow and related lineage concepts. Extracts context and meaning, structures it into harvest-ready JSON, and prepares it for ingestion into the user's IOF Warehouse and Brain. Use when the user wants to gather historical crystallized knowledge or trace the origin of key ideas.
---

# Crystallized Knowledge Miner

## Purpose
This skill helps systematically extract and structure knowledge from our ongoing Grok conversation history. It focuses on concepts that have already been "crystallized" through deep discussion, especially around the evolution of the organism, key inventions like EchoForge / Third Eye Forge / LifeForge, Index of Flow patterns, and lineage of ideas that originated from the user's vision versus what emerged in conversation.

## When to Activate
- User mentions "crystallize", "crystalized", "forge" (any variant), "Index of Flow", "lineage", "canonical", or asks to gather historical knowledge from past conversations in this thread.
- User wants to trace how a concept (e.g. Seeds, Beacon, Handshake, triple memory layers, EchoForge) was created or evolved.
- User wants structured output ready for their Artifact Harvester or Brain Extractions folder.

## Instructions
1. Search the current conversation history (this thread) for relevant sections containing the target keywords.
2. Extract the surrounding context and the core meaning of the crystallized idea.
3. Determine lineage where possible: Did this originate primarily from the user's stated vision/curiosity, or did it emerge and evolve through our dialogue?
4. Structure the extracted knowledge into clean, harvest-ready JSON using this format:
   - session_id (use a descriptive name based on the thread/topic)
   - source_platform: "grok"
   - knowledge_atoms: array of objects with id, category (e.g. Brain-Organism, Flow-Index-5.2, Governance), title, core (the crystallized meaning), confidence (0.7–0.95), tags (including the original keyword + related concepts), relationships (link to other components like Warehouse, metabolism, EchoForge, etc.), lineage_note (brief note on origin)
5. Always include open_tasks or next_steps if they appear in the extracted context.
6. Output the JSON in a ready-to-save format so the user can drop it into their Brain Extractions folder and run it through their harvester.
7. Maintain awareness across turns of what has already been extracted so we build a complete, non-duplicated picture of the organism's history.
8. After extracting, briefly summarize what was found and ask the user if they want to ingest it now or refine the extraction first.

## Output Style
Always produce the structured JSON first, then a short human-readable summary of what was crystallized and its importance to the current IOF Warehouse / organism vision. Keep the focus on helping the user feed accurate historical knowledge into the Warehouse so it becomes the true central, self-aware hub.

## Constitution Compliance

This skill is bound by organism-constitution.  
Crystallized output intended for Warehouse or Brain must be accompanied by or convertible to a governed Hand-off MD when moving between surfaces.  
Respect sandbox / quarantine rules. Never auto-promote. Use only clean activation language.
