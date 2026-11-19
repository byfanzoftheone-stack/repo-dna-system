# Governance

Rule: **a human approves anything that spends money, publishes, or sends a message to another person.** Automation (including AI agents) drafts; humans send.

## Guardrails that exist in code
| Control | Where | Behavior |
|---|---|---|
| Approval gate | `scripts/require_approval.sh` | Default deny (exit 3). Needs `DNA_APPROVE=<action>` and `DNA_APPROVED_BY=<name>` per command. Used by the live checkout path. |
| Audit log | `scripts/audit_log.sh` | Append-only JSONL at `dna-extracts/audit.log.jsonl` (gitignored): scans, batches, approvals, denials, checkout. Secret-looking keys and token-looking values are redacted. |
| No secrets in code | `.env.example`, `.gitignore` | Placeholders only; `.env` and `*.pem` ignored. Stripe key is passed to curl via stdin, never argv or logs. |
| Rate limit / quota | `scripts/rate_limit.sh`, `batch-runner.sh` | Free tier: daily scan cap and batch-size cap; paid license lifts them. |
| Fail closed | `orchestrator.sh`, `scripts/license.sh` | Unreadable repo -> exit 2, no output. Bad/expired license -> exit 1. |
| Tests | `tests/test_governance.sh` | Run in CI on every push. |

## Rules for humans and agents
1. No deploys, posts, emails, charges or payouts without the approval gate and a named approver.
2. Never commit `.env`, private keys, tokens or customer data. Run a secret scan before pushing.
3. Pricing, legal terms and public claims are owner decisions; drafts stay marked DRAFT until approved.
4. Marketing may only claim what the README "Honest status" table says runs.
5. Review `audit.log.jsonl` monthly; investigate any `approval_denied` you did not expect.

## Known gaps
- Audit log is local and not tamper-evident; ship it to external storage if customers require it.
- Approval is env-var based (honor system), not an identity-verified workflow.
- Quota counts local logs; it does not stop a determined user.
