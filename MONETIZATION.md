# Monetization plan (DRAFT: every price and claim needs owner approval)

## What the product is
Repo DNA fingerprints any GitHub repository: languages, package managers, frameworks, README quality, all from evidence, failing closed when it cannot read the repo. Today it is a bash library plus a GitHub Action. Only skills 1-4 run (see README "Honest status"). Sell what runs, not the roadmap.

## Who pays
- Consultants and agencies auditing client codebases before a bid or handover.
- Engineering leads / platform teams inventorying many repos (batch scans).
- Acquirers and due-diligence reviewers who need evidence-only, non-invented reports.

## Pricing tiers (PLACEHOLDERS, owner decides)
| Tier | Price | Includes |
|---|---|---|
| Free (MIT) | $0 | Single scans, batches up to `DNA_FREE_BATCH_LIMIT` (5), `DNA_FREE_DAILY_SCANS` (25/day) |
| Pro | $[X]/month | Unlimited scans, batches of any size, email support |
| Team | $[Y]/month | Pro for a team, priority support, onboarding call, custom report template |

## Revenue paths (ordered by effort)
1. **Paid audits**: run the tool, hand-review, deliver a one-off report. Needs no new code; start here.
2. **Pro/Team licenses**: signed keys (see "Licensing" below), invoiced manually first, Stripe later.
3. **Hosted runner / GitHub App**: not built. Only pursue once 3+ paying customers ask.
4. **Sponsorship / support contracts** for the MIT library.

## Licensing (built)
`scripts/license.sh` verifies an Ed25519-signed key; `scripts/issue_license.sh` creates one (owner-only, offline). Without a key the tool runs as Free. An invalid or expired key is an error, never silently free.
Honest limit: the code is MIT, so this is a convenience gate and an honor system. Anyone can fork and remove it. The value you sell is support, trust, reports and convenience, not secrecy.

`scripts/checkout_stub.sh` is a Stripe Checkout stub: dry-run by default; live mode requires env vars plus explicit human approval and has NOT been exercised against Stripe.

## Launch checklist (owner actions)
- [ ] Decide prices and tier limits; replace `[X]`/`[Y]`.
- [ ] Generate a license keypair offline; keep the private key off GitHub; distribute the public key (e.g. a `license_public.pem` you publish).
- [ ] Choose a payment path: manual invoice first, or create a Stripe account, make Products/Prices, test with TEST keys.
- [ ] Add a LICENSE/terms note for paid tiers and a refund policy; get legal review.
- [ ] Replace `example-owner` placeholders in README with the real repo owner.
- [ ] Add an independent security review (SECURITY.md lists none yet).
- [ ] Review `LAUNCH.md` drafts and post them yourself.
- [ ] Find 3 design-partner users before building more features.
