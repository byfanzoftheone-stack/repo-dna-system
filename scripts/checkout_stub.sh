#!/usr/bin/env bash
# Checkout STUB. Dry-run by default: prints what it would do, calls nothing.
# Live mode needs ALL of: DNA_CHECKOUT_LIVE=1, STRIPE_SECRET_KEY, STRIPE_PRICE_ID_<TIER>,
# CHECKOUT_SUCCESS_URL, CHECKOUT_CANCEL_URL, and human approval (scripts/require_approval.sh).
# The live path is NOT exercised by CI; the owner must test it with a Stripe TEST key first.
# Usage: checkout_stub.sh <pro|team>
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
tier="${1:?usage: checkout_stub.sh <pro|team>}"
[[ "$tier" == "pro" || "$tier" == "team" ]] || { echo "tier must be pro or team" >&2; exit 1; }
upper="$(printf '%s' "$tier" | tr '[:lower:]' '[:upper:]')"
price_var="STRIPE_PRICE_ID_${upper}"
price="${!price_var:-}"
if [[ "${DNA_CHECKOUT_LIVE:-0}" != "1" ]]; then
  echo "[dry-run] would create a Stripe Checkout Session for tier '$tier'"
  echo "[dry-run] price id: ${price:-<unset: $price_var>}; key configured: $([[ -n "${STRIPE_SECRET_KEY:-}" ]] && echo yes || echo no)"
  "$here/audit_log.sh" checkout_dry_run "tier=$tier"
  exit 0
fi
for v in STRIPE_SECRET_KEY "$price_var" CHECKOUT_SUCCESS_URL CHECKOUT_CANCEL_URL; do
  [[ -n "${!v:-}" ]] || { echo "live checkout: $v is not set" >&2; exit 1; }
done
"$here/require_approval.sh" stripe_checkout "create Stripe Checkout Session for tier $tier"
# Secret goes via curl config on stdin so it never appears in argv or logs.
resp="$(printf 'user = "%s:"\n' "$STRIPE_SECRET_KEY" | curl -sS -K - https://api.stripe.com/v1/checkout/sessions \
  -d mode=subscription -d "line_items[0][price]=$price" -d "line_items[0][quantity]=1" \
  --data-urlencode "success_url=$CHECKOUT_SUCCESS_URL" --data-urlencode "cancel_url=$CHECKOUT_CANCEL_URL")"
"$here/audit_log.sh" checkout_session_created "tier=$tier"
jq -r '.url // error("no checkout url in response")' <<<"$resp"
