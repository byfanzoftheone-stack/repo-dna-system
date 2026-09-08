# Skill 41: Crystallized Knowledge Miner

**Status**: LIVE · standalone. Not in orchestrator v2. Not promoted to Brain.  
**Input**: a DNA extract dir (`02_repo_dna.json` + `03.5_forensic_report.json`)  
**Output**: `09_crystals.json` (schema `crystal.1.0.0`)  
**Time**: <1s  
**Why separate**: DNA fingerprints a repo. This skill compresses the fingerprint into crystals. Other people run DNA, then this, then keep the crystals. Harvest ingest stays paused.

Replaces the anti-pattern: `harvest.js` auto-POST Railway `/v1/brain/ingest`. That skip gates. This writes files.

## What a crystal is

A short, evidence-backed fact. Not a dump of `package.json`. Not an atom in Brain.

Kinds:

| kind | from |
|---|---|
| IDENTITY | forensic 1 + DNA `project_info` |
| STACK | primary language + runtime + paradigm — not every declared package |
| LAW | forensic 20 critical path (fail-closed steps) |
| GAP | forensic 19 P0/P1 |
| VERDICT | forensic 23 |
| NOISE | forensic “valuable assets” that are platform chrome (`public/__grok`, install tutorials) |

## Run

```bash
# after ./orchestrator.sh owner repo
python3 crystallized-knowledge-miner.py dna-extracts/owner/repo
ls dna-extracts/owner/repo/output/09_crystals.json
```

Needs: `python3` only. No GitHub token. No network.

## Contract

- Evidence paths required. No crystal without a source file.
- GAP over guess. Empty lists stay empty. Do not invent commercial potential.
- Secrets: never copy values. If security findings exist, crystalize **path + type** only.
- `promote_to_brain`: **false**. Always.
- `harvest_ingest`: **false**. Always.
- Family / legacy surfaces stay off crystals (Triple S).
- Do not rewrite live README. Do not auto-push.
- Activate / Engage language only.
- Orchestrator v2 does **not** call this. On purpose.

## Output shape

```json
{
  "schema": "crystal.1.0.0",
  "promote_to_brain": false,
  "harvest_ingest": false,
  "source": {
    "owner": "…",
    "repo": "…",
    "dna_schema": "1.1.0",
    "evidence_paths": ["02_repo_dna.json", "03.5_forensic_report.json"]
  },
  "counts": { "crystals": 0, "noise_flagged": 0 },
  "crystals": []
}
```

Each crystal: `id`, `kind`, `title`, `body`, `evidence`, `confidence`.

## Store

Library stays extract-free. Copy `09_crystals.json` into the **results vault** (`repo-dna-output`), not this repo, if the target tree is private.

## Related

- Skill 0 = DNA synthesis (fingerprint). This = crystals from that fingerprint.
- Skill 22 = knowledge **gaps** (Wave-5 file, never ran). This is not skill 22.
- Skill 17 = harvest fail-closed. This is the miner that obeys it.
