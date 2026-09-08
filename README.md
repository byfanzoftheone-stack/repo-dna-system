# Repo DNA System

Fingerprint any GitHub repository. Evidence-first. Fail-closed.

**This repo is the library + runner.** It is not a private OS dashboard dashboard. Results are not stored here.

Other people can clone it or call the GitHub Action. You do not need the rest of the organism.

- **Status:** Core pipeline LIVE. Skill 41 miner LIVE (standalone). Skills 10–40 are files, not runs.
- **License:** MIT
- **Results:** local `dna-extracts/` (gitignored) or Action artifacts. Keep fingerprints out of this library.

## What is live (orchestrator v2)

```
1 scout → 2 extractor → 3 README auditor
  → 5 security → 6 deps → 7 quality → 8 assets → 9 architecture
  → 3.5 forensic (23 sections) → 4 README.rewrite.md
```

Skill **0** is synthesis (file exists; skill 2 still writes `02_repo_dna.json`).
Skills **10–40** stay on disk. The orchestrator does not run them.
Skill **41** (crystallized knowledge miner) runs **after** DNA, separately.

```bash
python3 crystallized-knowledge-miner.py dna-extracts/owner/repo
# writes dna-extracts/owner/repo/output/09_crystals.json
# promote_to_brain=false  harvest_ingest=false
```

## What this will not do

- Rewrite the target repo’s live `README.md` (writes `README.rewrite.md` beside the extract)
- Auto-push to the target
- Promote anything into a “brain”
- Copy secret **values** (flags **path + type** only)
- Guess. Missing evidence is a GAP.

## Run on your machine

Needs: `bash`, `curl`, `jq`, `python3`, a GitHub token.

```bash
git clone https://github.com/example-owner/repo-dna-system.git
cd repo-dna-system
export GITHUB_TOKEN=...    # public targets: fine-grained read. private: repo scope
./orchestrator.sh owner repo [branch]
ls dna-extracts/owner/repo/output/
```

Batch:

```bash
# repos.txt lines look like: owner/repo
./batch-runner.sh repos.txt
```

## Run from GitHub Actions (no organism)

From **this** repo: Actions → **Repo DNA** → Run workflow → `owner/repo`.

From **your** repo:

```yaml
jobs:
  dna:
    uses: example-owner/repo-dna-system/.github/workflows/dna.yml@main
    with:
      target: your-login/your-repo
      branch: main
    secrets:
      DNA_GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

Public targets work with the default token. Private targets need a PAT in `DNA_GITHUB_TOKEN`.

Artifacts last 30 days. Copy them into **your** store if you want them to last. Do not open a PR of extracts back into this library — they can describe private trees.

## Output

```
dna-extracts/<owner>/<repo>/
  dna_ledger.json
  output/
    00_tree.json
    01_scout_output.json
    02_repo_dna.json              # schema 1.1.0
    03_readme_audit.json
    04_security_audit.json
    05_dependency_map.json
    06_code_quality.json
    07_asset_inventory.json
    08_architecture.json
    03.5_forensic_report.json     # 23 sections, including 19–23
    README.rewrite.md             # never live README.md
    09_crystals.json              # skill 41 · optional · never Brain
```

## Honest status

| Piece | State |
|---|---|
| Core 1–9 + forensic 19–23 | LIVE in `orchestrator.sh` |
| Skill 41 crystallized-knowledge-miner | LIVE standalone. Not in orchestrator. |
| Wave-4 skills 10–19 | Files. Ran on a 74-repo inventory once; those extracts were **not** stored |
| Wave-5 20–30 / Wave-6 31–40 | Files. Never ran |
| Performance layers | Docs. Not code |
| Extracts in this git tree | **0** (gitignored on purpose) |
| `INDEX.md` numbering | Drifts vs real filenames. **Paths win.** `INDEX_ORCH.md` is the live pipeline map |

## Store results separately

This library stays extract-free so other people can fork it.

Fingerprints from a private portfolio live in a **private** vault: [repo-dna-output](https://github.com/example-owner/repo-dna-output). That vault is not this product. It is not the live operations system.

## Contract

- GAP over guess. Evidence paths required.
- Fail closed. No auto-promote. No live README rewrite. No auto-push.
- Tree fetched once. Truncation is a gap, not a small repo.
