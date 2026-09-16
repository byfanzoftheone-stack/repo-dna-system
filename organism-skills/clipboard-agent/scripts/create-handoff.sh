#!/data/data/com.termux/files/usr/bin/bash
# create-handoff.sh — Pokeball CAPTURE → Key Card format
# Bound by organism-constitution. Status is ALWAYS pending.

set -euo pipefail

INTAKE_DIR="${IOF_INTAKE_DIR:-$HOME/storage/downloads/IOF/clipboard/pending}"
mkdir -p "$INTAKE_DIR"

if [ -t 0 ]; then
  echo "No stdin. Usage: echo \"text\" | bash $HOME/create-handoff.sh \"title\""
  echo "         or: termux-clipboard-get | bash $HOME/create-handoff.sh \"title\""
  exit 1
fi

CONTENT=$(cat)
[ -z "$CONTENT" ] && { echo "Empty content"; exit 1; }

TITLE="${1:-Clipboard capture}"
TIMESTAMP=$(date -Iseconds)
SHORT_HASH=$(echo -n "$CONTENT$TIMESTAMP" | md5sum 2>/dev/null | cut -c1-8 || echo "manual")
ID="handoff-$(date +%Y%m%d-%H%M%S)-$SHORT_HASH"
FILEPATH="$INTAKE_DIR/$ID.md"

CATEGORY="other"
echo "$CONTENT" | grep -qiE 'atom|brain|warehouse|iof|constitution|gate|handoff' && CATEGORY="system"
echo "$CONTENT" | grep -qiE 'architecture|schema|component|panel|diagram' && CATEGORY="architecture"
echo "$CONTENT" | grep -qiE 'theory|principle|integrity|compound|gestalt' && CATEGORY="theory"
echo "$CONTENT" | grep -qiE 'build|code|script|function|component|refinery|blueprint|contract' && CATEGORY="build"

# Key Card format — standard, pasteable, gate-ready
cat > "$FILEPATH" << EOM
---
# KEY CARD — THE ONE Hand-off
id: $ID
timestamp: $TIMESTAMP
source: clipboard
platform: termux
category: $CATEGORY
confidence: 0.80
security_flags: []
session_id: 
status: pending
lineage:
  - organism-constitution
  - clipboard-agent
  - key-card
  - create-handoff.sh
---

# $TITLE

## Content

$CONTENT

## Governance

- Format: Key Card
- Status: pending
- Must pass gates before any promotion
- Must receive explicit human release before promotion
- Never auto-promoted

## Next

Gate 1 (Lint) → Gate 2 (Plan) → Gate 3 (Sandbox) → Gate 4 (Security) → Gate 5 (Human) → Gate 6 (Release)
EOM

echo ""
echo "✓ Key Card captured (pending)"
echo "  ID:   $ID"
echo "  Path: $FILEPATH"
echo ""
echo "Status: pending — Key Card format"
echo "Ready for gates. Nothing promoted."
echo ""
