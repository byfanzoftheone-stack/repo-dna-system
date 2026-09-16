---
name: servicepro-integration
description: Registers Words ServicePro v2.0 as a first-class, Triple S cleared analytics microservice inside THE ONE / FanzAgent ecosystem. Provides native agent discovery via /v1/agent/capabilities and /v1/agent/tools, circuit breaker resilience, correlation ID tracing, and governed integration patterns. Activate when building, deploying, or orchestrating ServicePro as an organism-native capability.
---

# Words ServicePro v2.0 — Organism Integration Skill

## Purpose
This skill makes **Words ServicePro v2.0** a first-class, discoverable, and orchestratable component inside THE ONE / FanzAgent ecosystem.

It is a production-grade, Dockerized SAS 9.4 + FastAPI analytics microservice with:
- Native agent endpoints (`/v1/agent/capabilities` and `/v1/agent/tools`)
- Circuit breaker + retry logic for SAS sessions
- Correlation ID propagation on every request
- Structured logging + Prometheus metrics hooks
- Audit logging of all analytics operations
- JWT authentication + rate limiting
- Kubernetes-ready with proper probes

**Triple S Status:** ✅ Fully cleared under the Sovereignty Security System. Strictly professional. No personal narratives. Observable and governed.

## When to Activate
- When registering ServicePro as a capability in FanzAgent, THE ONE Command Center, or Refinery
- Before deploying or scaling the ServicePro container
- When an agent needs to discover or call ServicePro tools (job costing, crew forecasting, risk scoring)
- During integration planning or hand-off to other platforms

## Integration Points (Agent-Native)

### 1. Discovery Endpoint
`GET /v1/agent/capabilities`

Returns a full machine-readable manifest with:
- All available tools (analyze_job_cost, forecast_crew_needs, get_risk_score)
- JSON schemas for every parameter
- Tags and descriptions optimized for LLM reasoning

### 2. OpenAI/Anthropic/Grok Function Calling Format
`GET /v1/agent/tools`

Returns tools in standard function-calling format so FanzAgent or any LLM can call them directly.

### 3. Business Endpoints (Examples)
- `POST /v1/analyze/job-cost` — Job costing with optional SAS validation
- `POST /v1/forecast/crew-needs` — Crew demand forecasting
- `GET  /v1/risk/score/{job_id}` — Operational risk scoring

All responses include `correlation_id` for full traceability.

## Circuit Breaker & Resilience
ServicePro includes a production-grade SAS session manager with:
- Automatic circuit breaker (opens after repeated failures)
- Exponential backoff retry
- Graceful degraded responses (`degraded: true` flag)
- Health checks that surface SAS connectivity status

This aligns with chaos engineering principles and the organism’s resilience goals.

## How to Use This Skill

1. Deploy the ServicePro container (Docker or Kubernetes) using the provided Dockerfile + docker-compose.yml
2. Call `/v1/agent/capabilities` to get the full manifest
3. Register the manifest (or a summarized version) as a capability atom in the brain vault / FanzSpot HQ / Refinery
4. FanzAgent can now autonomously discover and call the tools

## Files & Hand-off

The complete production package (Triple S cleared) lives at:

`/home/workdir/artifacts/servicepro-v2.0/`

Key files:
- `SERVICEPRO-V2.0-PORTABLE-HANDOFF.md` — Single clean document for other platforms (Claude, GPT, etc.)
- `REGISTRATION-TRIPLE-S.md` — Official Triple S cleared registration artifact
- `BLUEPRINT.md` — Full technical architecture
- `Dockerfile` (multi-stage, non-root ready)
- `docker-compose.yml`

## Standing Order
ServicePro must remain observable, governed, and strictly professional at all times.  
All calls must carry correlation IDs.  
Degraded mode responses must be respected by calling agents.  
No hidden behavior or stealth modification is allowed.

This component strengthens the organism’s real-world analytics and field-service capabilities while staying inside the Triple S frame.

By FanzoftheOne  
Together We Are The One 🛡️