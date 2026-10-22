# Repo DNA System

Fingerprint any GitHub repository. Evidence-first. Fail-closed.

**This repo is the library + runner.** It is not a private OS dashboard dashboard. Results are not stored here.

Other people can clone it or call the GitHub Action. You do not need the rest of the organism.

- **Status:** Skills 1, 2, 3 and 4 run in `orchestrator.sh`; 3.5 forensic is a labeled placeholder. Skill 41 miner runs standalone. Skills 5–40 are files, not runs. See [Honest status](#honest-status).
- **Proof:** CI runs offline end-to-end tests on every push — see [Verification](#verification).
- **License:** MIT
- **Results:** local `dna-extracts/` (gitignored) or Action artifacts. Keep fingerprints out of this library.

## What is live (orchestrator v2)

```
1 scout → 2 extractor → 3 README auditor
  → 3.5 forensic (placeholder, labeled) → 4 README.rewrite.md
```

| Skill | What it really does today |
|---|---|
| 1 scout | Lists root files, checks 10 evidence files, lists workflows. `scout_status` is `empty` if nothing was found |
| 2 extractor | Languages from the GitHub languages API (bytes), package managers and runtime from root manifests, frameworks from `package.json`. Anything not determined is listed in `gaps` |
| 3 README auditor | Keyword match for 7 standard sections; `audit_score` = percent found |
| 3.5 forensic | **Placeholder.** Scores are `null` and `status` is `placeholder` until the 23-section analysis is built |
| 4 README rewrite | Writes `README.rewrite.md` beside the extract. Never touches the target |

If the branch head commit cannot be read (missing repo, private without token, API error), the run **fails closed**: exit code 2, `run_status.json` says `failed`, and no DNA output is written.

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
| Skills 1, 2, 3, 4 | LIVE in `orchestrator.sh`, covered by offline fixture tests |
| Skill 3.5 forensic (23 sections) | Placeholder only. Outputs `null` scores, labeled `placeholder` |
| Skills 5–9 (security, deps, quality, assets, architecture) | Files. **Not** run by the orchestrator |
| Skill 41 crystallized-knowledge-miner | LIVE standalone. Not in orchestrator. |
| Wave-4 skills 10–19 | Files. Ran on a 74-repo inventory once; those extracts were **not** stored |
| Wave-5 20–30 / Wave-6 31–40 | Files. Never ran |
| Performance layers | Docs. Not code |
| Extracts in this git tree | **0** (gitignored on purpose) |
| `INDEX.md` numbering | Drifts vs real filenames. **Paths win.** `INDEX_ORCH.md` is the live pipeline map |

## Verification

Run locally, no network or token needed:

```bash
bash tests/test_validate_inputs.sh        # hostile workflow inputs are rejected, never executed
bash tests/test_orchestrator_fixtures.sh  # end-to-end scan against a local fake GitHub API
```

The fixture test checks known truth: correct primary language, `yarn` not `npm` when `yarn.lock` exists,
`pip` (and no `npm`) for a Python repo, frameworks vs plain dependencies, measured README score,
placeholder labeling, and fail-closed behavior for an unreadable repo.
CI (`.github/workflows/ci.yml`) runs both suites plus ShellCheck on every push and pull request.

### Correction (2026-10-22)

Before this date, `02_repo_dna.json` was largely hardcoded: every repo was recorded as
`languages: "detected"`, `package_managers: ["npm"]`, `frameworks: []`, `gaps: []`, `confidence: 0.70`,
and README/forensic scores were a fixed `50`. A scan that could not read the repo still reported success.
Fingerprints produced before this fix should not be trusted for those fields. Found during an outside audit.

## Store results separately

This library stays extract-free so other people can fork it.

Fingerprints from a private portfolio live in a **private** vault: [repo-dna-output](https://github.com/example-owner/repo-dna-output). That vault is not this product. It is not the live operations system.

## Contract

- GAP over guess. Evidence paths required.
- Fail closed. No auto-promote. No live README rewrite. No auto-push.
- Root listing only today (no full tree fetch yet). Deeper files are not inspected.
