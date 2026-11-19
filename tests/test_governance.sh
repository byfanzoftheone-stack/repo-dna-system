#!/usr/bin/env bash
# Offline tests for licensing, audit log redaction, approval gate, rate limit, checkout stub.
# Uses a throwaway keypair; no network, no real secrets.
set -uo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)" || exit 1
S="$ROOT/scripts"
W="$(mktemp -d)"; trap 'rm -rf "$W"' EXIT
export DNA_AUDIT_LOG="$W/audit.jsonl"
unset DNA_LICENSE_KEY DNA_APPROVE DNA_APPROVED_BY DNA_CHECKOUT_LIVE STRIPE_SECRET_KEY
pass=0; fail=0
ok()  { pass=$((pass+1)); echo "PASS  $1"; }
bad() { fail=$((fail+1)); echo "FAIL  $1"; }
expect() { # expect <desc> <expected-rc> cmd...
  local d="$1" want="$2"; shift 2
  "$@" >"$W/out" 2>"$W/err"; local rc=$?
  [[ $rc -eq $want ]] && ok "$d" || bad "$d (rc=$rc want=$want)"
}

openssl genpkey -algorithm ed25519 -out "$W/priv.pem" 2>/dev/null
openssl pkey -in "$W/priv.pem" -pubout -out "$W/pub.pem" 2>/dev/null
export DNA_LICENSE_PUBKEY_FILE="$W/pub.pem"

expect "no key -> free" 0 "$S/license.sh"; [[ "$(cat "$W/out")" == free ]] && ok "tier is free" || bad "tier is free"
good="$("$S/issue_license.sh" "$W/priv.pem" pro cust-1 2099-01-01)"
DNA_LICENSE_KEY="$good" "$S/license.sh" >"$W/out" 2>&1; [[ "$(cat "$W/out")" == pro ]] && ok "valid key -> pro" || bad "valid key -> pro"
exp="$("$S/issue_license.sh" "$W/priv.pem" pro cust-1 2000-01-01)"
expect "expired key fails closed" 1 env DNA_LICENSE_KEY="$exp" "$S/license.sh"
expect "garbage key fails closed" 1 env DNA_LICENSE_KEY="not-a-key" "$S/license.sh"
openssl genpkey -algorithm ed25519 -out "$W/other.pem" 2>/dev/null
forged="$("$S/issue_license.sh" "$W/other.pem" team evil 2099-01-01)"
expect "key signed by other private key rejected" 1 env DNA_LICENSE_KEY="$forged" "$S/license.sh"
tampered="$(jq -cn '{tier:"team",sub:"x",exp:"2099-01-01"}' | tr -d '\n' | base64 -w0 | tr '+/' '-_' | tr -d '=').${good#*.}"
expect "tampered payload rejected" 1 env DNA_LICENSE_KEY="$tampered" "$S/license.sh"
expect "key without pubkey fails closed" 1 env -u DNA_LICENSE_PUBKEY_FILE DNA_LICENSE_KEY="$good" "$S/license.sh"

"$S/audit_log.sh" demo "note=hello" "api_token=ghp_abcdefghijklmnop" "msg=sk_live_abc123"
jq -e '.note=="hello" and .api_token=="[REDACTED]" and .msg=="[REDACTED]"' "$DNA_AUDIT_LOG" >/dev/null && ok "audit redacts secrets" || bad "audit redacts secrets"
grep -q 'ghp_\|sk_live' "$DNA_AUDIT_LOG" && bad "no secret text in audit log" || ok "no secret text in audit log"

expect "approval denied by default" 3 "$S/require_approval.sh" publish_post "post"
expect "approval for other action denied" 3 env DNA_APPROVE=other DNA_APPROVED_BY=me "$S/require_approval.sh" publish_post "post"
expect "approval granted explicitly" 0 env DNA_APPROVE=publish_post DNA_APPROVED_BY=me "$S/require_approval.sh" publish_post "post"
jq -e 'select(.event=="approval_denied")' "$DNA_AUDIT_LOG" >/dev/null && ok "denial audited" || bad "denial audited"

: > "$DNA_AUDIT_LOG"
for _ in 1 2 3; do "$S/audit_log.sh" scan_start target=a/b; done
expect "free quota exceeded -> exit 4" 4 env DNA_FREE_DAILY_SCANS=3 "$S/rate_limit.sh"
expect "under quota ok" 0 env DNA_FREE_DAILY_SCANS=4 "$S/rate_limit.sh"
expect "paid license bypasses quota" 0 env DNA_FREE_DAILY_SCANS=1 DNA_LICENSE_KEY="$good" "$S/rate_limit.sh"

expect "checkout dry-run makes no call" 0 env STRIPE_SECRET_KEY=sk_test_x "$S/checkout_stub.sh" pro
grep -q 'sk_test_x' "$W/out" "$W/err" && bad "checkout does not print key" || ok "checkout does not print key"
expect "live checkout without config fails" 1 env DNA_CHECKOUT_LIVE=1 "$S/checkout_stub.sh" pro
expect "live checkout without approval blocked" 3 env DNA_CHECKOUT_LIVE=1 STRIPE_SECRET_KEY=sk_test_x STRIPE_PRICE_ID_PRO=price_x CHECKOUT_SUCCESS_URL=https://e/s CHECKOUT_CANCEL_URL=https://e/c "$S/checkout_stub.sh" pro

printf 'a/1\na/2\na/3\n' > "$W/repos3.txt"
expect "batch over free limit denied (exit 4)" 4 env GITHUB_TOKEN=x DNA_FREE_BATCH_LIMIT=2 bash -c "cd '$W' && '$ROOT/batch-runner.sh' repos3.txt 1"

echo "----"; echo "$pass passed, $fail failed"; [[ $fail -eq 0 ]]
