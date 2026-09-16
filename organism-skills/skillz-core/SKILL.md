---
name: skillz-core
description: Foundational Skillz operating skill. Activate to inspect, test, and keep the organism skill library current with live code implementations, then expand Skillz across new topics under governance. Use on Skillz description, library inspection, skill currency, test-and-current checks, pre-ambition focus cycle, gather-release breath, warrior breath, tai chi focus, or when confidence and ambition need a controlled start.
metadata:
  type: workflow
  version: "1.0"
  bound_by: organism-constitution
---

# Skillz Core

## Purpose

Skillz is the operating layer that keeps the organism skill library honest against code, then expands into new topics without losing the gate.

Ambition is allowed. Ungoverned ambition is not. Run the Pre-Ambition Focus Cycle before any expansion, rewrite, or multi-skill build.

This skill does not replace organism-constitution, organism-security, clipboard-agent, or skill-creator. It sits under them.

## Constitution note on the focus cycle

Warrior here means disciplined trades / Marine posture already used in the organism. It does not mean occult practice.

Tai chi / gather-release breath is a human operator regulation protocol. It is preparation before work. It is not activation of agents, Guardians, or atoms.

Allowed language: activate, engage, run, gather, release, focus, load, drift, cycle, status.

Forbidden language: summon, call forth, invoke in a spiritual sense, or any occult framing.

Do not write energy as cosmology. Write it as attention, load, drift, or excitement that has not yet passed a gate.

## When to run

- The Skillz description or project identity is being rewritten
- Any organism skill is about to be used as if it matches current code
- A new topic is being added to the Skillz library
- The operator is excited / ambitious and work has not started yet
- A skill, agent, or implementation drifted from its SKILL.md

## Sequence (do not skip)

1. Run the Pre-Ambition Focus Cycle. See `references/focus-cycle.md`.
2. State the topic in one sentence.
3. Inspect the relevant library skills against live code and surfaces. See `references/library-inspection.md`.
4. Classify each skill as `current`, `stale`, `untested`, `missing-impl`, or `over-claimed`.
5. Only then expand, patch, or create. Prefer patching an existing skill over adding a new one.
6. Stage outputs in sandbox. Produce a Hand-off MD. Never auto-promote.

## Skillz identity (current)

Skillz is a zero-trust workflow library. Confidence comes from inspected, tested, current skills that match implementations.

Expansion rule: new topics are welcome after the library that already exists is checked against code. Do not grow the catalog while stale skills sit untested.

Ambition rule: feel the build, then run the focus cycle, then execute the smallest verified next step.

## Inspection output (required)

For every Skillz pass, report:

- Focus cycle — `run` or `skipped` (skipped is a finding)
- Topic sentence
- Skills inspected — name, class, evidence path
- Code / surface checked — repo, file, endpoint, or none found
- Action — keep, patch, quarantine, or create
- Gate — `pending` until human release

## Expansion rules

- One topic per pass unless the user names a batch.
- New skill only when no existing skill owns the job.
- New skill must declare metadata bound_by organism-constitution.
- New skill must name the code or surface it is supposed to match. If none exists, mark `missing-impl` and do not pretend it is live.
- Description must follow skill-creator frontmatter rules (plain YAML scalar, no colon-space, no angle brackets).

## Idle and sandbox

Agents may keep working in sandbox after the focus cycle. Outputs stay quarantined until Index of Flow or human release.

## Required companion skills

- organism-constitution — wins every conflict
- organism-security — all external input
- skill-creator — init and validate new or updated skills
- clipboard-agent — Hand-off MD schema
- repo-dna-stack — when the mismatch is a repository, not a single file
