#!/usr/bin/env bash
# Daily scan quota, counted from the audit log. Exit 4 when exceeded.
# Free tier: DNA_FREE_DAILY_SCANS (default 25). Paid tiers (valid license): unlimited.
# Usage: rate_limit.sh   (call before a scan)
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
log="${DNA_AUDIT_LOG:-${PWD}/dna-extracts/audit.log.jsonl}"
tier="$("$here/license.sh")" || exit 1
[[ "$tier" != "free" ]] && exit 0
limit="${DNA_FREE_DAILY_SCANS:-25}"
[[ "$limit" =~ ^[0-9]+$ ]] || { echo "DNA_FREE_DAILY_SCANS must be an integer" >&2; exit 1; }
today="$(date -u +%Y-%m-%d)"
used=0
if [[ -f "$log" ]]; then
  used=$(jq -r --arg d "$today" 'select(.event=="scan_start" and (.at|startswith($d))) | 1' "$log" 2>/dev/null | wc -l | tr -d ' ')
fi
if (( used >= limit )); then
  echo "rate limit: free tier allows $limit scans/day (used $used). See MONETIZATION.md for paid tiers." >&2
  exit 4
fi
