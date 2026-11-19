#!/usr/bin/env bash
# Human-approval gate for anything that spends money, publishes, or sends outbound messages.
# Default DENY (exit 3). Approval is explicit, per action, and logged:
#   DNA_APPROVE=<action> DNA_APPROVED_BY=<your name> scripts/require_approval.sh <action> "<what will happen>"
# Automation must not set these on a human's behalf.
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
action="${1:?usage: require_approval.sh <action> <description>}"
desc="${2:-}"
if [[ "${DNA_APPROVE:-}" == "$action" && -n "${DNA_APPROVED_BY:-}" ]]; then
  "$here/audit_log.sh" approval_granted "action=$action" "description=$desc"
  exit 0
fi
"$here/audit_log.sh" approval_denied "action=$action" "description=$desc"
echo "approval required for '$action': $desc" >&2
echo "re-run with DNA_APPROVE=$action DNA_APPROVED_BY=<name> after reviewing." >&2
exit 3
