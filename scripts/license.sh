#!/usr/bin/env bash
# Print the active tier: free | pro | team. Fails closed (exit 1) on a bad key.
# No DNA_LICENSE_KEY -> "free". A present-but-invalid/expired key is an ERROR, never silently free.
# Key format: <base64url(JSON payload)>.<base64url(Ed25519 signature)>
# Payload: {"tier":"pro|team","sub":"customer id","exp":"YYYY-MM-DD"}
# Public key: DNA_LICENSE_PUBKEY_FILE (PEM). The owner keeps the private key offline.
# NOTE: this is an honor/convenience gate on an MIT-licensed tool; see MONETIZATION.md.
set -euo pipefail
key="${DNA_LICENSE_KEY:-}"
[[ -z "$key" ]] && { echo free; exit 0; }
pub="${DNA_LICENSE_PUBKEY_FILE:-}"
[[ -n "$pub" && -f "$pub" ]] || { echo "license: DNA_LICENSE_PUBKEY_FILE not set or missing" >&2; exit 1; }
[[ "$key" =~ ^[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+$ ]] || { echo "license: malformed key" >&2; exit 1; }
tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
b64d() { local s="${1//-/+}"; s="${s//_//}"; while (( ${#s} % 4 )); do s+="="; done; printf '%s' "$s" | base64 -d; }
b64d "${key%%.*}" > "$tmp/payload" 2>/dev/null || { echo "license: malformed payload" >&2; exit 1; }
b64d "${key#*.}" > "$tmp/sig" 2>/dev/null || { echo "license: malformed signature" >&2; exit 1; }
openssl pkeyutl -verify -pubin -inkey "$pub" -rawin -in "$tmp/payload" -sigfile "$tmp/sig" >/dev/null 2>&1 \
  || { echo "license: signature invalid" >&2; exit 1; }
tier="$(jq -r '.tier // empty' "$tmp/payload")"
exp="$(jq -r '.exp // empty' "$tmp/payload")"
[[ "$tier" == "pro" || "$tier" == "team" ]] || { echo "license: unknown tier" >&2; exit 1; }
[[ "$exp" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]] || { echo "license: bad expiry" >&2; exit 1; }
[[ "$exp" < "$(date -u +%Y-%m-%d)" ]] && { echo "license: expired $exp" >&2; exit 1; }
echo "$tier"
