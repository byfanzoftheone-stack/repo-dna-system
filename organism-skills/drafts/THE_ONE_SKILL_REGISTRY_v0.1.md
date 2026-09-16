# THE ONE — Skill Registry v0.1

**Status:** FOUNDATION / CONTRACT-FIRST  
**Skills:** 153  

This registry defines the common full-state contract for every skill. It is a foundation, not a claim that every skill is implemented or validated.

## Universal Skill State

`ID → Name → Purpose → Inputs → Preconditions → Action → Tools → Outputs → Validation → Risk → Authority → Evidence → Metrics → Failure Modes → Recovery → Version → Lineage → Status`

### context-recall
**Layer:** Core Capabilities / Contextual Memory  
**Purpose:** Retrieve the most relevant prior context for the current task.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: retrieve the most relevant prior context for the current task.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### context-link
**Layer:** Core Capabilities / Contextual Memory  
**Purpose:** Connect related facts, events, decisions, and knowledge across contexts.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: connect related facts, events, decisions, and knowledge across contexts.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### context-prune
**Layer:** Core Capabilities / Contextual Memory  
**Purpose:** Identify and quarantine stale, conflicting, or irrelevant context.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: identify and quarantine stale, conflicting, or irrelevant context.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### trend-detection
**Layer:** Core Capabilities / Predictive Analytics  
**Purpose:** Detect meaningful directional patterns in time-series or sequential data.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: detect meaningful directional patterns in time-series or sequential data.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### outcome-prediction
**Layer:** Core Capabilities / Predictive Analytics  
**Purpose:** Estimate likely outcomes from current evidence and historical patterns.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: estimate likely outcomes from current evidence and historical patterns.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### forecast-confidence
**Layer:** Core Capabilities / Predictive Analytics  
**Purpose:** Calibrate and report confidence and uncertainty for a forecast.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: calibrate and report confidence and uncertainty for a forecast.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### goal-breakdown
**Layer:** Core Capabilities / Autonomous Planning  
**Purpose:** Convert a high-level goal into ordered, actionable objectives.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: convert a high-level goal into ordered, actionable objectives.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### plan-generation
**Layer:** Core Capabilities / Autonomous Planning  
**Purpose:** Construct an executable plan from goals, constraints, resources, and dependencies.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: construct an executable plan from goals, constraints, resources, and dependencies.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### plan-revision
**Layer:** Core Capabilities / Autonomous Planning  
**Purpose:** Revise an existing plan when evidence, constraints, or state changes.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: revise an existing plan when evidence, constraints, or state changes.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### option-ranking
**Layer:** Core Capabilities / Decision Optimization  
**Purpose:** Rank candidate options against explicit decision criteria.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: rank candidate options against explicit decision criteria.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### tradeoff-analysis
**Layer:** Core Capabilities / Decision Optimization  
**Purpose:** Expose benefits, costs, risks, and competing objectives among options.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: expose benefits, costs, risks, and competing objectives among options.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### decision-score
**Layer:** Core Capabilities / Decision Optimization  
**Purpose:** Produce a transparent decision score with evidence and uncertainty.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: produce a transparent decision score with evidence and uncertainty.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** medium-high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### source-merge
**Layer:** Core Capabilities / Knowledge Synthesis  
**Purpose:** Combine compatible information from multiple sources while preserving provenance.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: combine compatible information from multiple sources while preserving provenance.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### knowledge-summarize
**Layer:** Core Capabilities / Knowledge Synthesis  
**Purpose:** Compress source material into an accurate, useful representation.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: compress source material into an accurate, useful representation.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### knowledge-model
**Layer:** Core Capabilities / Knowledge Synthesis  
**Purpose:** Build a structured model of entities, facts, relationships, and rules.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: build a structured model of entities, facts, relationships, and rules.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### pattern-detect
**Layer:** Core Capabilities / Pattern Recognition  
**Purpose:** Identify recurring structures or behaviors in observations.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: identify recurring structures or behaviors in observations.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### anomaly-detect
**Layer:** Core Capabilities / Pattern Recognition  
**Purpose:** Identify observations that materially deviate from an established baseline.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: identify observations that materially deviate from an established baseline.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### pattern-classify
**Layer:** Core Capabilities / Pattern Recognition  
**Purpose:** Assign discovered patterns to defined categories with confidence.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: assign discovered patterns to defined categories with confidence.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### state-monitor
**Layer:** Core Capabilities / Real-Time Adaptation  
**Purpose:** Continuously inspect relevant state and detect material changes.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: continuously inspect relevant state and detect material changes.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### response-adjust
**Layer:** Core Capabilities / Real-Time Adaptation  
**Purpose:** Modify an active response when monitored state changes.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: modify an active response when monitored state changes.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### change-prioritize
**Layer:** Core Capabilities / Real-Time Adaptation  
**Purpose:** Rank detected changes by impact, urgency, and relevance.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: rank detected changes by impact, urgency, and relevance.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### performance-track
**Layer:** Core Capabilities / Continuous Improvement  
**Purpose:** Track performance against defined metrics and baselines.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: track performance against defined metrics and baselines.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### failure-learn
**Layer:** Core Capabilities / Continuous Improvement  
**Purpose:** Extract reusable lessons from failed or degraded outcomes.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: extract reusable lessons from failed or degraded outcomes.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### improvement-generate
**Layer:** Core Capabilities / Continuous Improvement  
**Purpose:** Generate evidence-backed opportunities to improve performance.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: generate evidence-backed opportunities to improve performance.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### agent-route
**Layer:** Core Capabilities / System Orchestration  
**Purpose:** Select and assign work to the most appropriate agent or capability.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: select and assign work to the most appropriate agent or capability.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### workflow-coordinate
**Layer:** Core Capabilities / System Orchestration  
**Purpose:** Coordinate dependencies, sequencing, and handoffs across execution units.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: coordinate dependencies, sequencing, and handoffs across execution units.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### execution-monitor
**Layer:** Core Capabilities / System Orchestration  
**Purpose:** Track active work, state, blockers, and completion.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: track active work, state, blockers, and completion.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### domain-map
**Layer:** Core Capabilities / Cross-Domain Reasoning  
**Purpose:** Identify domains, concepts, and expertise relevant to a problem.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: identify domains, concepts, and expertise relevant to a problem.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### knowledge-transfer
**Layer:** Core Capabilities / Cross-Domain Reasoning  
**Purpose:** Transfer validated knowledge from one domain into another with applicability checks.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: transfer validated knowledge from one domain into another with applicability checks.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### cross-domain-solve
**Layer:** Core Capabilities / Cross-Domain Reasoning  
**Purpose:** Combine reasoning from multiple domains to solve a shared problem.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: combine reasoning from multiple domains to solve a shared problem.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### environment-scan
**Layer:** Core Capabilities / Environmental Awareness  
**Purpose:** Collect relevant signals describing the external or operational environment.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: collect relevant signals describing the external or operational environment.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### state-model
**Layer:** Core Capabilities / Environmental Awareness  
**Purpose:** Maintain a structured representation of current system/environment state.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: maintain a structured representation of current system/environment state.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### change-alert
**Layer:** Core Capabilities / Environmental Awareness  
**Purpose:** Generate alerts for material environmental or system changes.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: generate alerts for material environmental or system changes.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### intent-understand
**Layer:** Core Capabilities / Human-AI Collaboration  
**Purpose:** Infer and represent the user’s intended objective, constraints, and preferences.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: infer and represent the user’s intended objective, constraints, and preferences.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### human-assist
**Layer:** Core Capabilities / Human-AI Collaboration  
**Purpose:** Provide decision support while preserving human authority.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: provide decision support while preserving human authority.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### human-handoff
**Layer:** Core Capabilities / Human-AI Collaboration  
**Purpose:** Transfer control to a human when authority, uncertainty, or risk requires it.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: transfer control to a human when authority, uncertainty, or risk requires it.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### goal-parse
**Layer:** Core Capabilities / Goal Decomposition  
**Purpose:** Extract objective, success criteria, constraints, and scope from a goal statement.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: extract objective, success criteria, constraints, and scope from a goal statement.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### milestone-create
**Layer:** Core Capabilities / Goal Decomposition  
**Purpose:** Convert an objective into measurable intermediate milestones.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: convert an objective into measurable intermediate milestones.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### task-decompose
**Layer:** Core Capabilities / Goal Decomposition  
**Purpose:** Break milestones into executable tasks with dependencies and completion criteria.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: break milestones into executable tasks with dependencies and completion criteria.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### resource-map
**Layer:** Core Capabilities / Resource Optimization  
**Purpose:** Inventory resources, capacities, ownership, and availability.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: inventory resources, capacities, ownership, and availability.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### allocation-optimize
**Layer:** Core Capabilities / Resource Optimization  
**Purpose:** Allocate constrained resources against priorities and objectives.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: allocate constrained resources against priorities and objectives.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### resource-monitor
**Layer:** Core Capabilities / Resource Optimization  
**Purpose:** Monitor consumption, availability, bottlenecks, and waste.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: monitor consumption, availability, bottlenecks, and waste.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### risk-identify
**Layer:** Core Capabilities / Risk Assessment  
**Purpose:** Identify credible threats, failure conditions, and exposure points.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: identify credible threats, failure conditions, and exposure points.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** medium-high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### risk-score
**Layer:** Core Capabilities / Risk Assessment  
**Purpose:** Estimate risk using likelihood, impact, detectability, and uncertainty.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: estimate risk using likelihood, impact, detectability, and uncertainty.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** medium-high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### risk-mitigate
**Layer:** Core Capabilities / Risk Assessment  
**Purpose:** Generate and compare controls that reduce material risk.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: generate and compare controls that reduce material risk.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** medium-high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### scenario-create
**Layer:** Core Capabilities / Scenario Simulation  
**Purpose:** Construct plausible alternative future states from current assumptions.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: construct plausible alternative future states from current assumptions.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### scenario-run
**Layer:** Core Capabilities / Scenario Simulation  
**Purpose:** Evaluate a scenario through a defined model or simulation.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: evaluate a scenario through a defined model or simulation.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### scenario-compare
**Layer:** Core Capabilities / Scenario Simulation  
**Purpose:** Compare scenario outcomes, assumptions, risks, and sensitivities.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: compare scenario outcomes, assumptions, risks, and sensitivities.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### cause-detect
**Layer:** Core Capabilities / Causal Reasoning  
**Purpose:** Identify plausible causal factors behind an observed outcome.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: identify plausible causal factors behind an observed outcome.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### cause-map
**Layer:** Core Capabilities / Causal Reasoning  
**Purpose:** Represent causal relationships and dependencies explicitly.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: represent causal relationships and dependencies explicitly.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### impact-trace
**Layer:** Core Capabilities / Causal Reasoning  
**Purpose:** Trace downstream effects from a change, action, or event.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: trace downstream effects from a change, action, or event.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### entity-extract
**Layer:** Core Capabilities / Knowledge Graph Integration  
**Purpose:** Extract and normalize relevant entities from source material.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: extract and normalize relevant entities from source material.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### relationship-map
**Layer:** Core Capabilities / Knowledge Graph Integration  
**Purpose:** Represent validated relationships among entities.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: represent validated relationships among entities.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### graph-query
**Layer:** Core Capabilities / Knowledge Graph Integration  
**Purpose:** Retrieve connected knowledge using graph relationships and constraints.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: retrieve connected knowledge using graph relationships and constraints.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### vision-understand
**Layer:** Core Capabilities / Multimodal Perception  
**Purpose:** Extract relevant visual objects, attributes, relationships, and signals.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: extract relevant visual objects, attributes, relationships, and signals.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### audio-understand
**Layer:** Core Capabilities / Multimodal Perception  
**Purpose:** Extract relevant speech, sounds, events, and attributes from audio.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: extract relevant speech, sounds, events, and attributes from audio.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### multimodal-fuse
**Layer:** Core Capabilities / Multimodal Perception  
**Purpose:** Combine evidence across modalities into a unified representation.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: combine evidence across modalities into a unified representation.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### tool-discover
**Layer:** Core Capabilities / Tool Utilization  
**Purpose:** Identify an authorized tool capable of satisfying a required operation.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: identify an authorized tool capable of satisfying a required operation.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### tool-execute
**Layer:** Core Capabilities / Tool Utilization  
**Purpose:** Execute an authorized tool operation with captured parameters and results.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: execute an authorized tool operation with captured parameters and results.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### tool-verify
**Layer:** Core Capabilities / Tool Utilization  
**Purpose:** Validate tool outputs before they influence downstream decisions.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: validate tool outputs before they influence downstream decisions.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### environment-observe
**Layer:** Agentic Operating Loop / OBSERVE  
**Purpose:** Capture relevant environmental observations without interpretation drift.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: capture relevant environmental observations without interpretation drift.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### signal-collect
**Layer:** Agentic Operating Loop / OBSERVE  
**Purpose:** Collect raw signals required for downstream understanding.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: collect raw signals required for downstream understanding.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### state-capture
**Layer:** Agentic Operating Loop / OBSERVE  
**Purpose:** Create a timestamped snapshot of relevant state.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: create a timestamped snapshot of relevant state.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### context-build
**Layer:** Agentic Operating Loop / UNDERSTAND  
**Purpose:** Assemble relevant context into a coherent working representation.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: assemble relevant context into a coherent working representation.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### meaning-extract
**Layer:** Agentic Operating Loop / UNDERSTAND  
**Purpose:** Extract actionable meaning from observed information.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: extract actionable meaning from observed information.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### intent-identify
**Layer:** Agentic Operating Loop / UNDERSTAND  
**Purpose:** Identify the objective and desired outcome implied by a request or event.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: identify the objective and desired outcome implied by a request or event.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### evidence-evaluate
**Layer:** Agentic Operating Loop / REASON  
**Purpose:** Assess evidence for relevance, quality, consistency, and support.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: assess evidence for relevance, quality, consistency, and support.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### hypothesis-generate
**Layer:** Agentic Operating Loop / REASON  
**Purpose:** Generate plausible explanations or hypotheses from available evidence.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: generate plausible explanations or hypotheses from available evidence.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### logic-check
**Layer:** Agentic Operating Loop / REASON  
**Purpose:** Test reasoning for contradictions, invalid assumptions, and unsupported conclusions.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: test reasoning for contradictions, invalid assumptions, and unsupported conclusions.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### strategy-build
**Layer:** Agentic Operating Loop / PLAN  
**Purpose:** Create a strategy connecting objectives, constraints, resources, and actions.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: create a strategy connecting objectives, constraints, resources, and actions.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### task-sequence
**Layer:** Agentic Operating Loop / PLAN  
**Purpose:** Order tasks according to dependencies, timing, and priority.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: order tasks according to dependencies, timing, and priority.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### dependency-map
**Layer:** Agentic Operating Loop / PLAN  
**Purpose:** Identify dependencies that constrain execution order or feasibility.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: identify dependencies that constrain execution order or feasibility.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### plan-check
**Layer:** Agentic Operating Loop / VALIDATE  
**Purpose:** Validate that a proposed plan is complete, coherent, and executable.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: validate that a proposed plan is complete, coherent, and executable.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### constraint-check
**Layer:** Agentic Operating Loop / VALIDATE  
**Purpose:** Validate plans/actions against explicit constraints and policies.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: validate plans/actions against explicit constraints and policies.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### risk-check
**Layer:** Agentic Operating Loop / VALIDATE  
**Purpose:** Evaluate a planned action for material risk before execution.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: evaluate a planned action for material risk before execution.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** medium-high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### action-execute
**Layer:** Agentic Operating Loop / ACT  
**Purpose:** Perform an approved action through the authorized execution pathway.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: perform an approved action through the authorized execution pathway.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### tool-dispatch
**Layer:** Agentic Operating Loop / ACT  
**Purpose:** Dispatch a task to an approved tool or execution capability.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: dispatch a task to an approved tool or execution capability.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### action-confirm
**Layer:** Agentic Operating Loop / ACT  
**Purpose:** Confirm that the intended action occurred as specified.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: confirm that the intended action occurred as specified.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### result-capture
**Layer:** Agentic Operating Loop / MEASURE  
**Purpose:** Capture the observable result and evidence produced by an action.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: capture the observable result and evidence produced by an action.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### performance-score
**Layer:** Agentic Operating Loop / MEASURE  
**Purpose:** Score results against defined metrics and acceptance criteria.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: score results against defined metrics and acceptance criteria.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### outcome-compare
**Layer:** Agentic Operating Loop / MEASURE  
**Purpose:** Compare actual outcomes with expected outcomes and baselines.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: compare actual outcomes with expected outcomes and baselines.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### experience-extract
**Layer:** Agentic Operating Loop / LEARN  
**Purpose:** Extract reusable experience from completed execution episodes.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: extract reusable experience from completed execution episodes.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### lesson-create
**Layer:** Agentic Operating Loop / LEARN  
**Purpose:** Turn validated experience into explicit lessons.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: turn validated experience into explicit lessons.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### knowledge-update
**Layer:** Agentic Operating Loop / LEARN  
**Purpose:** Update the knowledge base with validated new or revised knowledge.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: update the knowledge base with validated new or revised knowledge.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### strategy-adjust
**Layer:** Agentic Operating Loop / ADAPT  
**Purpose:** Modify strategy based on measured outcomes and new evidence.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: modify strategy based on measured outcomes and new evidence.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### behavior-adjust
**Layer:** Agentic Operating Loop / ADAPT  
**Purpose:** Modify operational behavior within approved boundaries.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: modify operational behavior within approved boundaries.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### capability-refine
**Layer:** Agentic Operating Loop / ADAPT  
**Purpose:** Improve a capability definition or implementation based on evidence.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: improve a capability definition or implementation based on evidence.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### human-approval
**Layer:** Governance Layer / HUMAN OVERSIGHT  
**Purpose:** Obtain explicit human authorization for actions requiring approval.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: obtain explicit human authorization for actions requiring approval.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** medium-high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### human-escalation
**Layer:** Governance Layer / HUMAN OVERSIGHT  
**Purpose:** Escalate decisions when uncertainty, risk, or authority exceeds bounds.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: escalate decisions when uncertainty, risk, or authority exceeds bounds.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### human-override
**Layer:** Governance Layer / HUMAN OVERSIGHT  
**Purpose:** Apply an authorized human override to an active system decision or action.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: apply an authorized human override to an active system decision or action.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### permission-check
**Layer:** Governance Layer / AUTHORITY BOUNDARIES  
**Purpose:** Determine whether the current actor has authority for the requested operation.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: determine whether the current actor has authority for the requested operation.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** medium-high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### scope-enforcement
**Layer:** Governance Layer / AUTHORITY BOUNDARIES  
**Purpose:** Restrict execution to the authorized scope of the task.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: restrict execution to the authorized scope of the task.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### authority-escalation
**Layer:** Governance Layer / AUTHORITY BOUNDARIES  
**Purpose:** Route an action to a higher authority when current authority is insufficient.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: route an action to a higher authority when current authority is insufficient.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** medium-high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### policy-load
**Layer:** Governance Layer / POLICY ENFORCEMENT  
**Purpose:** Load the policies governing a requested operation.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: load the policies governing a requested operation.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** medium-high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### policy-evaluate
**Layer:** Governance Layer / POLICY ENFORCEMENT  
**Purpose:** Evaluate a proposed action against applicable policies.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: evaluate a proposed action against applicable policies.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** medium-high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### policy-enforce
**Layer:** Governance Layer / POLICY ENFORCEMENT  
**Purpose:** Block, modify, or permit actions according to policy decisions.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: block, modify, or permit actions according to policy decisions.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### pre-action-check
**Layer:** Governance Layer / ACTION VALIDATION  
**Purpose:** Perform required checks before an action is allowed to execute.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: perform required checks before an action is allowed to execute.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### action-verify
**Layer:** Governance Layer / ACTION VALIDATION  
**Purpose:** Verify action parameters and execution state against the approved intent.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: verify action parameters and execution state against the approved intent.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### post-action-audit
**Layer:** Governance Layer / ACTION VALIDATION  
**Purpose:** Audit completed actions for compliance, evidence, and outcome.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: audit completed actions for compliance, evidence, and outcome.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### decision-record
**Layer:** Governance Layer / AUDITABLE DECISIONS  
**Purpose:** Create an immutable record of a material decision.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: create an immutable record of a material decision.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** medium-high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### decision-lineage
**Layer:** Governance Layer / AUDITABLE DECISIONS  
**Purpose:** Trace a decision back to inputs, evidence, policies, and responsible components.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: trace a decision back to inputs, evidence, policies, and responsible components.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** medium-high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### decision-replay
**Layer:** Governance Layer / AUDITABLE DECISIONS  
**Purpose:** Reconstruct the state and evidence surrounding a prior decision.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: reconstruct the state and evidence surrounding a prior decision.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** medium-high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### action-capture
**Layer:** Governance Layer / COMPLETE ACTION LOGGING  
**Purpose:** Record what action was attempted, by whom/what, and with what parameters.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: record what action was attempted, by whom/what, and with what parameters.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### event-timestamp
**Layer:** Governance Layer / COMPLETE ACTION LOGGING  
**Purpose:** Assign reliable temporal metadata to system events.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: assign reliable temporal metadata to system events.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### execution-history
**Layer:** Governance Layer / COMPLETE ACTION LOGGING  
**Purpose:** Maintain an ordered history of execution events and state transitions.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: maintain an ordered history of execution events and state transitions.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### risk-detect
**Layer:** Governance Layer / RISK CLASSIFICATION  
**Purpose:** Detect conditions indicating potential operational or governance risk.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: detect conditions indicating potential operational or governance risk.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** medium-high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### risk-classify
**Layer:** Governance Layer / RISK CLASSIFICATION  
**Purpose:** Assign standardized risk classes and severity levels.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: assign standardized risk classes and severity levels.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** medium-high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### risk-escalate
**Layer:** Governance Layer / RISK CLASSIFICATION  
**Purpose:** Escalate risk when thresholds or authority boundaries are exceeded.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: escalate risk when thresholds or authority boundaries are exceeded.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### failure-detect
**Layer:** Governance Layer / FAIL-SAFE CONTROLS  
**Purpose:** Detect execution failures or unsafe conditions.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: detect execution failures or unsafe conditions.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### safe-state
**Layer:** Governance Layer / FAIL-SAFE CONTROLS  
**Purpose:** Transition the system into a defined safe operating state.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: transition the system into a defined safe operating state.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### execution-stop
**Layer:** Governance Layer / FAIL-SAFE CONTROLS  
**Purpose:** Stop an active operation when a stop condition is met.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: stop an active operation when a stop condition is met.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### shutdown-trigger
**Layer:** Governance Layer / EMERGENCY SHUTDOWN  
**Purpose:** Determine when emergency shutdown criteria have been met.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: determine when emergency shutdown criteria have been met.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### shutdown-execute
**Layer:** Governance Layer / EMERGENCY SHUTDOWN  
**Purpose:** Execute the authorized emergency shutdown procedure.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: execute the authorized emergency shutdown procedure.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### shutdown-recovery
**Layer:** Governance Layer / EMERGENCY SHUTDOWN  
**Purpose:** Restore service from a shutdown state through controlled recovery.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: restore service from a shutdown state through controlled recovery.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### version-create
**Layer:** Governance Layer / VERSION CONTROL  
**Purpose:** Create a traceable version of a governed artifact or capability.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: create a traceable version of a governed artifact or capability.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### version-compare
**Layer:** Governance Layer / VERSION CONTROL  
**Purpose:** Compare versions for functional, policy, and behavioral differences.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: compare versions for functional, policy, and behavioral differences.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### version-rollback
**Layer:** Governance Layer / VERSION CONTROL  
**Purpose:** Restore a previously approved version when rollback criteria are met.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: restore a previously approved version when rollback criteria are met.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### model-test
**Layer:** Governance Layer / MODEL EVALUATION  
**Purpose:** Run defined tests against a model or model configuration.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: run defined tests against a model or model configuration.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### model-score
**Layer:** Governance Layer / MODEL EVALUATION  
**Purpose:** Evaluate model performance against acceptance metrics.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: evaluate model performance against acceptance metrics.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### model-approve
**Layer:** Governance Layer / MODEL EVALUATION  
**Purpose:** Approve a model/configuration for a defined operating scope.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: approve a model/configuration for a defined operating scope.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### behavior-baseline
**Layer:** Governance Layer / DRIFT DETECTION  
**Purpose:** Establish an expected behavioral baseline for monitored operation.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: establish an expected behavioral baseline for monitored operation.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### drift-detect
**Layer:** Governance Layer / DRIFT DETECTION  
**Purpose:** Detect statistically or operationally significant deviation from baseline.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: detect statistically or operationally significant deviation from baseline.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### drift-alert
**Layer:** Governance Layer / DRIFT DETECTION  
**Purpose:** Notify governance/execution systems when drift crosses thresholds.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: notify governance/execution systems when drift crosses thresholds.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### experience-capture
**Layer:** Evolution Engine / EXPERIENCE INGESTION  
**Purpose:** Capture a complete execution episode as structured experience.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: capture a complete execution episode as structured experience.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### experience-normalize
**Layer:** Evolution Engine / EXPERIENCE INGESTION  
**Purpose:** Normalize experience into a consistent machine-readable form.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: normalize experience into a consistent machine-readable form.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### experience-index
**Layer:** Evolution Engine / EXPERIENCE INGESTION  
**Purpose:** Index experience for retrieval, comparison, and learning.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: index experience for retrieval, comparison, and learning.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### knowledge-ingest
**Layer:** Evolution Engine / KNOWLEDGE ACCUMULATION  
**Purpose:** Ingest candidate knowledge into the controlled knowledge pipeline.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: ingest candidate knowledge into the controlled knowledge pipeline.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### knowledge-validate
**Layer:** Evolution Engine / KNOWLEDGE ACCUMULATION  
**Purpose:** Validate knowledge before it becomes trusted operational knowledge.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: validate knowledge before it becomes trusted operational knowledge.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### knowledge-preserve
**Layer:** Evolution Engine / KNOWLEDGE ACCUMULATION  
**Purpose:** Preserve validated knowledge, provenance, and historical versions.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: preserve validated knowledge, provenance, and historical versions.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### metric-collect
**Layer:** Evolution Engine / PERFORMANCE MEASUREMENT  
**Purpose:** Collect defined measurements from system operation.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: collect defined measurements from system operation.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### benchmark-run
**Layer:** Evolution Engine / PERFORMANCE MEASUREMENT  
**Purpose:** Run standardized benchmarks for comparable evaluation.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: run standardized benchmarks for comparable evaluation.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### performance-trend
**Layer:** Evolution Engine / PERFORMANCE MEASUREMENT  
**Purpose:** Analyze performance measurements over time.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: analyze performance measurements over time.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### failure-capture
**Layer:** Evolution Engine / FAILURE ANALYSIS  
**Purpose:** Capture failure conditions, evidence, and affected components.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: capture failure conditions, evidence, and affected components.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### root-cause-analysis
**Layer:** Evolution Engine / FAILURE ANALYSIS  
**Purpose:** Analyze evidence to identify the most supported root causes.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: analyze evidence to identify the most supported root causes.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### failure-pattern
**Layer:** Evolution Engine / FAILURE ANALYSIS  
**Purpose:** Identify recurring failure patterns across incidents.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: identify recurring failure patterns across incidents.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### pattern-search
**Layer:** Evolution Engine / PATTERN DISCOVERY  
**Purpose:** Search accumulated experience for recurring or emerging patterns.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: search accumulated experience for recurring or emerging patterns.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### pattern-correlate
**Layer:** Evolution Engine / PATTERN DISCOVERY  
**Purpose:** Correlate patterns across datasets, capabilities, or time periods.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: correlate patterns across datasets, capabilities, or time periods.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### pattern-validate
**Layer:** Evolution Engine / PATTERN DISCOVERY  
**Purpose:** Test whether a discovered pattern is stable, meaningful, and actionable.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: test whether a discovered pattern is stable, meaningful, and actionable.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### strategy-evaluate
**Layer:** Evolution Engine / STRATEGY REFINEMENT  
**Purpose:** Evaluate a strategy against outcomes, constraints, and objectives.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: evaluate a strategy against outcomes, constraints, and objectives.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### strategy-optimize
**Layer:** Evolution Engine / STRATEGY REFINEMENT  
**Purpose:** Generate and test improvements to an existing strategy.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: generate and test improvements to an existing strategy.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### strategy-version
**Layer:** Evolution Engine / STRATEGY REFINEMENT  
**Purpose:** Version a strategy with provenance and performance history.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: version a strategy with provenance and performance history.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### capability-detect
**Layer:** Evolution Engine / CAPABILITY EXPANSION  
**Purpose:** Identify missing, weak, or newly emerging capabilities.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: identify missing, weak, or newly emerging capabilities.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### capability-design
**Layer:** Evolution Engine / CAPABILITY EXPANSION  
**Purpose:** Define a candidate capability with behavior and acceptance criteria.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: define a candidate capability with behavior and acceptance criteria.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### capability-validate
**Layer:** Evolution Engine / CAPABILITY EXPANSION  
**Purpose:** Test and validate a candidate capability before operational use.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: test and validate a candidate capability before operational use.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### self-assess
**Layer:** Evolution Engine / SELF-EVALUATION  
**Purpose:** Evaluate current system performance and capability health.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: evaluate current system performance and capability health.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### weakness-detect
**Layer:** Evolution Engine / SELF-EVALUATION  
**Purpose:** Identify measurable weaknesses, gaps, or degradation.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: identify measurable weaknesses, gaps, or degradation.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### confidence-calibrate
**Layer:** Evolution Engine / SELF-EVALUATION  
**Purpose:** Calibrate confidence estimates against observed correctness.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: calibrate confidence estimates against observed correctness.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** low-medium  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### architecture-analyze
**Layer:** Evolution Engine / ARCHITECTURE OPTIMIZATION  
**Purpose:** Analyze architecture for bottlenecks, risks, redundancy, and opportunities.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: analyze architecture for bottlenecks, risks, redundancy, and opportunities.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** medium-high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### architecture-optimize
**Layer:** Evolution Engine / ARCHITECTURE OPTIMIZATION  
**Purpose:** Propose and evaluate architectural improvements.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: propose and evaluate architectural improvements.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** medium-high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### architecture-validate
**Layer:** Evolution Engine / ARCHITECTURE OPTIMIZATION  
**Purpose:** Validate architectural changes before release.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: validate architectural changes before release.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** medium-high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### evolution-propose
**Layer:** Evolution Engine / CONTROLLED EVOLUTION  
**Purpose:** Propose a bounded change based on measured evidence.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: propose a bounded change based on measured evidence.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** medium-high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### evolution-simulate
**Layer:** Evolution Engine / CONTROLLED EVOLUTION  
**Purpose:** Test proposed evolution against scenarios and constraints.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: test proposed evolution against scenarios and constraints.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** medium-high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

### evolution-approve
**Layer:** Evolution Engine / CONTROLLED EVOLUTION  
**Purpose:** Authorize a validated evolution for controlled release.  
**Inputs:** current task/request or triggering event; relevant context/state; applicable policies and constraints; required evidence/data; prior skill outputs when applicable  
**Action:** load and validate inputs; retrieve relevant context and evidence; execute the skill-specific operation: authorize a validated evolution for controlled release.; record intermediate state and provenance; produce a deterministic structured result where possible  
**Outputs:** primary result for the requesting component; confidence/uncertainty where applicable; evidence references; validation status; state changes proposed or applied; execution metadata  
**Validation:** schema/input validation; policy and authority check; evidence/provenance check; result consistency check; acceptance criteria check; failure/timeout handling  
**Risk:** high  
**Authority:** depends on operation; execution, approval, override, enforcement, rollback, and shutdown require explicit governed authority  
**Metrics:** success rate; accuracy/correctness where measurable; latency; failure rate; confidence calibration; downstream outcome quality  
**Failure:** missing input; invalid/conflicting evidence; tool failure; timeout; policy violation; insufficient authority; low confidence; unexpected state change  
**Recovery:** do not silently continue on critical failure; return structured failure state; preserve evidence and lineage; retry only when policy permits; escalate or enter safe state when thresholds require  
**Version:** 0.1.0  
**Status:** DRAFT — contract defined; implementation and empirical validation pending

