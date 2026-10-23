# Security Policy

## Reporting a vulnerability

Please **do not open a public issue** for security problems.

Report privately through GitHub: **Security → Report a vulnerability** on this
repository (private vulnerability reporting). Include what you found, how to
reproduce it, and what an attacker could do with it.

- Acknowledgement target: within 3 business days
- Status update target: within 10 business days
- Credit is given in the fix notes unless you ask otherwise

## Scope

In scope: this repository's workflows (`.github/workflows/`), `orchestrator.sh`,
`batch-runner.sh`, and everything under `scripts/`.

Out of scope: the repositories Repo DNA scans, and the private results vault.

## What this tool is designed to do and not do

- Reads target repositories through the GitHub API. It **never pushes to or
  rewrites** a target repository.
- Workflow inputs (`target`, `branch`) are passed as data through environment
  variables and checked by `scripts/validate_inputs.sh` before any use.
  `tests/test_validate_inputs.sh` proves hostile inputs are rejected and never
  executed; CI runs it on every push and pull request.
- The optional vault push token (`DNA_VAULT_TOKEN`) is only available to the
  separate `vault` job, never to the job that runs the scan.
- Third-party actions are pinned to full commit SHAs.
- If a target cannot be read, the scan fails closed (exit 2) and writes no DNA output.

## Known limits

- Repo DNA has not had an independent security review or penetration test.
- Skills 10–40 are documentation files, not executed code (see README).

## Fixed issues

| Date | Issue | Fix |
|---|---|---|
| 2026-10-22 | Workflow inputs were placed directly into shell script text (script-injection pattern), found by an outside audit | Inputs moved to env vars, strict validation, regression tests (PR #3) |
| 2026-10-22 | Unreadable targets produced a "successful" scan with default values | Fail-closed check on the head commit, fixture test proves it |
