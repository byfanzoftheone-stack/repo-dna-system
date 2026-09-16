# Copilot → Organism alias map

## Keep / merge

| Copilot file | Organism target | Action |
|---|---|---|
| skills/1-repo-scout-skill.md | repo-discovery | Merge API steps into discovery if missing |
| skills/2-dna-extractor-skill.md | repo-dna-extractor | Keep evidence-path rule; keep organism output shape |
| skills/3-readme-auditor-skill.md | readme-auditor | Already covered |
| skills/4-readme-generator-skill.md | readme-bootstrapper | Rename generator → rewrite file only |
| batch-runner.sh / orchestrator.sh | repo-dna-stack/scripts | Slim to curl+jq Termux |
| repo_dna.schema.json | repo-dna-extractor/references | Translate, do not replace organism keys |
| DNA_PERFORMANCE_OPTIMIZATION.md | stack notes | Keep parallel + cache ideas only |

## Quarantine / do not skill-ify

| Copilot file | Why |
|---|---|
| skills/0-repository-dna-skill.md | Duplicate orchestrator |
| skills/3.5-forensic-auditor-skill.md | Overlaps organism-security + discovery |
| skills/5-security-auditor-skill.md | organism-security already owns this |
| skills/6-dependency-mapper-skill.md | Fold into lineage-mapper later |
| skills/7-code-quality-analyzer-skill.md | No evidence runner; speculative |
| skills/8-asset-extractor-skill.md | Already in discovery key_files |
| skills/9-architecture-visualizer-skill.md | Output art, not DNA |
| DNA_BLIND_SPOTS_ANALYSIS.md | Requires telemetry the organism does not have |
| DNA_V2_COMPLETE_ARCHITECTURE.md | 19+11 skill fantasy; conflicts with constitution |
| Skills 20-30 | Runtime/team/Slack/Jira — fail closed |

## Name collisions

Do not create skills named `repo-scout-skill`, `dna-extractor-skill`, or `readme-generator-skill`. Those names stay aliases only.
