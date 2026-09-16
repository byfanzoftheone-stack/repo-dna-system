# Termux batch notes

## Tools required

- bash
- curl
- jq
- GITHUB_TOKEN in the environment (fine-grained, repo read)

## Fast path that is real

1. Build repos.txt from GitHub list (already done in sandbox inventory).
2. Scout each repo with scripts/scout-repo.sh.
3. Cache scout JSON under artifacts/repo-dna-registry/scout/<owner>__<repo>.json
4. Re-scout only when default_branch sha changed.
5. DNA extract only after scout succeeds.

## Concurrency

Use xargs -P 4 on Termux. Higher caps hit API rate limits on a phone hotspot.

## Do not

- Clone every repo by default
- Run 30 skills per repo
- Treat inventory as index.json
