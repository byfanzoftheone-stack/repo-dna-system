---
name: fanz-agents
description: Specialized agent roster under FáNzO orchestration. Covers the 11 purpose-built agents (Airbnb Arbitrage, TikTok Shorts, Leads, Receptionist, SEO, Contracts, Quotes, Warehouse Manager, Trucking, AI Brain) plus Guardians and mission execution. Triggers on agent roster, specialist agents, mission dispatch, or FanzAgent crew.
---

# Fanz Agents

## Purpose

This skill manages the specialized agent crew that operates under FáNzO.  
It knows the roster, their capabilities, and how they connect to the IOF Warehouse mission system.

## Agent Roster (from FáNz AgëNz UI)

1. **FáNzO** — Orchestrator (backpack)
2. Airbnb Arbitrage
3. TikTok Shorts
4. Leads Generator
5. Receptionist
6. SEO Agent
7. Contracts
8. Quotes & Invoices
9. Warehouse Manager
10. Trucking Dispatch
11. AI Brain

Plus HQ Guardians (LeadHunter, SalesRep Twilio, ProposalFactory, etc.) registered under FanzAgent.

## Warehouse Mission Integration

Agents receive work via the live Warehouse:

- Poll: `GET /v5/agents/missions/queue`
- Start: `POST /v5/agents/missions/:id/start`
- Complete: `POST /v5/agents/missions/:id/complete` with artifacts, logs, test_results
- Results: `GET /v5/agents/missions/:id/results`

Code primitives never execute in the Warehouse itself — only in the FáNz Agent sandbox after human promotion.

## Behavior

1. When a specialist is requested, load its system prompt and capabilities from the roster.
2. All meaningful outputs go to Warehouse intake as quarantined sessions.
3. Mission dispatch only after capability packages are promoted.
4. Coordinate with `fanzo-agent` for overall orchestration and `index-of-flow-heart` for continuity.

## Activation Language

- Activate Fanz Agents
- Load agent roster
- Dispatch mission
- Agent status

Never use summon language.

## Security

Bound by organism-constitution.  
Human approval required for promotion and high-risk missions.
