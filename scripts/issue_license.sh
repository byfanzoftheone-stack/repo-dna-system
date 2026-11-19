#!/usr/bin/env bash
# OWNER-ONLY, offline: sign a license key. Never run on a shared machine; never commit the private key.
# Usage: issue_license.sh <private_key.pem> <pro|team> <customer-id> <YYYY-MM-DD expiry>
# Generate a keypair once:  openssl genpkey -algorithm ed25519 -out license_private.pem
#                           openssl pkey -in license_private.pem -pubout -out license_public.pem
set -euo pipefail
priv="${1:?private key}"; tier="${2:?tier}"; sub="${3:?customer id}"; exp="${4:?expiry}"
[[ "$tier" == "pro" || "$tier" == "team" ]] || { echo "tier must be pro or team" >&2; exit 1; }
[[ "$exp" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]] || { echo "expiry must be YYYY-MM-DD" >&2; exit 1; }
tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
jq -cn --arg t "$tier" --arg s "$sub" --arg e "$exp" '{tier:$t,sub:$s,exp:$e}' | tr -d '\n' > "$tmp/payload"
openssl pkeyutl -sign -inkey "$priv" -rawin -in "$tmp/payload" -out "$tmp/sig"
b64e() { base64 -w0 "$1" | tr '+/' '-_' | tr -d '='; }
printf '%s.%s\n' "$(b64e "$tmp/payload")" "$(b64e "$tmp/sig")"
