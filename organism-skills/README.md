# Organism Skills

Governed skill library for THE ONE organism, landed here so it survives a wiped
sandbox, a lapsed Railway subscription, or a Grok/GPT thread running out of room —
the same failure mode that lost this material twice before it ever got committed
anywhere. Prior home: a Grok thread + local zip handoffs. This is the first time
any of it has lived in git.

## What's actually here

### `*/` — the 26 governed skills (real, in-scope)

Built collaboratively across a Grok thread. Each is a proper `SKILL.md` (+
`references/`, `scripts/`, or `assets/` where needed) covering organism
governance (`organism-constitution`, `organism-security`), intake/hand-off
(`clipboard-agent`, `clipboard-handoff-packager`), and a slimmed Repo DNA stack
(`repo-discovery`, `repo-dna-extractor`, `readme-auditor`, `readme-bootstrapper`,
`registry-assembler`, `lineage-mapper`, `repo-dna-stack`, `repo-dna-adapter`).

**`repo-dna-adapter` is load-bearing for this repo specifically.** It's a
governance ruling written against this repository's own `orchestrator.sh` and
numbered `skills/` folder (the sibling directory one level up) — it says keep
skills 1-4 conceptually, reject 0, 3.5, 5-9, and 20-30 as duplicative or
unimplementable without telemetry this organism doesn't have. Read it before
treating anything in `../skills/` as a source of truth. See
`HANDOFF-2026-09-15.md` for the original catalog and `catalog.json` for the
machine-readable index.

Status: real, usable, but never yet exercised end-to-end. Treat as the working
set — but verify against actual output the first few times, don't assume.

### `drafts/THE_ONE_SKILL_REGISTRY_v0.1.md` — NOT the same thing (aspirational, unimplemented)

A separate, GPT-generated taxonomy of 153 abstract capabilities (`context-recall`,
`risk-score`, `self-assess`, `drift-detect`, etc.). Every one of the 153 entries
carries near-identical boilerplate — only the name and one-line purpose differ —
and every single one is self-labeled `Status: DRAFT — contract defined;
implementation and empirical validation pending`. None of it is implemented.

Keep it as a north-star vocabulary of capabilities a mature version of this
organism might eventually need. Do not reference it as evidence of built
capability, do not wire it into orchestration, and do not let it get quietly
promoted to "done" the way earlier DNA batch runs were marked complete without
the underlying data existing. If a specific entry from this list is ever
actually built, it graduates by getting a real `SKILL.md` written for it next
to the 26 above — this file doesn't get edited in place to claim it's live.

## Why this split matters

The organism has been burned by exactly this confusion before: checkpoint notes
in `repo-dna-results` claim ~60 repos "complete" with zero bytes of actual data
behind most of them, and two different sessions reported two different official
DNA-extraction counts (33 vs. 74) for the same registry. Keeping "real and
exercised" strictly separate from "drafted and aspirational" is the fix, not a
formality.
