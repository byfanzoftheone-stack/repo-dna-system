#!/usr/bin/env bash
# Append one JSON line to the audit log. Never records secrets.
# Usage: audit_log.sh <event> [key=value ...]
# Log path: DNA_AUDIT_LOG (default ./dna-extracts/audit.log.jsonl)
set -euo pipefail
event="${1:?usage: audit_log.sh <event> [key=value ...]}"
shift || true
log="${DNA_AUDIT_LOG:-${PWD}/dna-extracts/audit.log.jsonl}"
mkdir -p "$(dirname "$log")"
args=(--arg event "$event" --arg at "$(date -u +%Y-%m-%dT%H:%M:%SZ)" --arg actor "${DNA_APPROVED_BY:-${USER:-unknown}}")
fields=""
i=0
for kv in "$@"; do
  k="${kv%%=*}"; v="${kv#*=}"
  [[ "$k" =~ ^[A-Za-z0-9_]{1,40}$ ]] || { echo "audit_log: bad key" >&2; exit 1; }
  # Redact secret-looking keys and token-looking values.
  if [[ "$k" =~ [Tt][Oo][Kk][Ee][Nn]|[Ss][Ee][Cc][Rr][Ee][Tt]|[Pp][Aa][Ss][Ss]|[Kk][Ee][Yy] ]] \
     || [[ "$v" =~ (ghp_|github_pat_|sk_live_|sk_test_|rk_live_|whsec_)[A-Za-z0-9_]+ ]]; then
    v="[REDACTED]"
  fi
  args+=(--arg "f$i" "$v")
  fields+="${fields:+, }\"$k\": \$f$i"
  i=$((i+1))
done
jq -cn "${args[@]}" "{at:\$at, event:\$event, actor:\$actor${fields:+, $fields}}" >> "$log"
