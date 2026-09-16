#!/usr/bin/env bash
# Scout one GitHub repo via REST. Termux-safe. No clone.
# Usage: scout-repo.sh <owner> <repo> [branch]
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
if command -v python3 >/dev/null 2>&1; then
  exec python3 "$DIR/scout-repo.py" "$@"
fi
echo "python3 required (jq is not installed in this environment)" >&2
exit 127
