#!/usr/bin/env bash
# End-to-end test against a local fake GitHub API (no network, no real token).
# Proves: outputs match known truth, nothing is invented, and unreadable
# repos fail closed instead of producing a "successful" empty scan.
set -uo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)" || exit 1
WORK="$(mktemp -d)"
PORTFILE="$WORK/port"
python3 "$ROOT/tests/fixture_api.py" "$PORTFILE" &
SERVER_PID=$!
trap 'kill "$SERVER_PID" 2>/dev/null; rm -rf "$WORK"' EXIT
for _ in $(seq 50); do [[ -s "$PORTFILE" ]] && break; sleep 0.1; done
DNA_API_BASE="http://127.0.0.1:$(cat "$PORTFILE")"
export DNA_API_BASE
export GITHUB_TOKEN="fixture-not-a-real-token"
export DNA_INCREMENTAL_MODE=0

pass=0; fail=0
check() { # check <description> <jq filter that must be true> <file>
  if jq -e "$2" "$3" >/dev/null 2>&1; then pass=$((pass+1)); echo "PASS  $1"
  else fail=$((fail+1)); echo "FAIL  $1"; echo "      filter: $2"; fi
}
run() { (cd "$WORK" && "$ROOT/orchestrator.sh" "$1" "$2" main >"$WORK/$2.log" 2>&1); }

# --- Node fixture: TypeScript + yarn + express/vite ---
run fixture node-app; rc=$?
[[ $rc -eq 0 ]] && { pass=$((pass+1)); echo "PASS  node-app run exits 0"; } || { fail=$((fail+1)); echo "FAIL  node-app exit $rc"; tail -5 "$WORK/node-app.log"; }
D="$WORK/dna-extracts/fixture/node-app/output"
check "node: head sha recorded"            '.metadata.head_sha == "'"$(printf 'a%.0s' {1..40})"'"' "$D/02_repo_dna.json"
check "node: primary language TypeScript"  '.tech_stack.languages[0] == {"name":"TypeScript","primary":true,"evidence":"GitHub languages API (9000 bytes)"}' "$D/02_repo_dna.json"
check "node: JavaScript second, not primary" '.tech_stack.languages[1].name == "JavaScript" and .tech_stack.languages[1].primary == false' "$D/02_repo_dna.json"
check "node: yarn detected, not npm"       '.tech_stack.package_managers == ["yarn"]' "$D/02_repo_dna.json"
check "node: runtime nodejs"               '.tech_stack.runtime.type == "nodejs"' "$D/02_repo_dna.json"
check "node: frameworks exactly express+vite" '[.tech_stack.frameworks[].name] | sort == ["express","vite"]' "$D/02_repo_dna.json"
check "node: lodash listed as dependency, not framework" '[.architecture.dependencies.external[].name] | index("lodash") != null' "$D/02_repo_dna.json"
check "node: no fabricated confidence"     '.metadata | has("confidence") | not' "$D/02_repo_dna.json"
check "node: scout status success"         '.scout_status == "success"' "$D/01_scout_output.json"
check "node: README score measured (4/7)"  '.audit_score == 57' "$D/03_readme_audit.json"
check "node: forensic marked placeholder"  '.metadata.status == "placeholder" and ."10_production_readiness".overall_score == null' "$D/03.5_forensic_report.json"

# --- Python fixture: no package.json, must not claim npm ---
run fixture py-tool; rc=$?
[[ $rc -eq 0 ]] && { pass=$((pass+1)); echo "PASS  py-tool run exits 0"; } || { fail=$((fail+1)); echo "FAIL  py-tool exit $rc"; }
D="$WORK/dna-extracts/fixture/py-tool/output"
check "py: language Python"                '[.tech_stack.languages[].name] == ["Python"]' "$D/02_repo_dna.json"
check "py: package manager pip only (no npm)" '.tech_stack.package_managers == ["pip"]' "$D/02_repo_dna.json"
check "py: runtime python"                 '.tech_stack.runtime.type == "python"' "$D/02_repo_dna.json"
check "py: no frameworks invented"         '.tech_stack.frameworks == []' "$D/02_repo_dna.json"
check "py: missing README audited as missing, score 0" '.readme_status == "missing" and .audit_score == 0' "$D/03_readme_audit.json"

# --- Unreadable repo: must fail closed ---
run fixture does-not-exist; rc=$?
[[ $rc -eq 2 ]] && { pass=$((pass+1)); echo "PASS  missing repo exits 2 (fail closed)"; } || { fail=$((fail+1)); echo "FAIL  missing repo exit $rc (want 2)"; }
check "missing: run_status failed"         '.status == "failed"' "$WORK/dna-extracts/fixture/does-not-exist/run_status.json"
if [[ -e "$WORK/dna-extracts/fixture/does-not-exist/output/02_repo_dna.json" ]]; then
  fail=$((fail+1)); echo "FAIL  missing: DNA output was written anyway"
else
  pass=$((pass+1)); echo "PASS  missing: no DNA output written"
fi

echo "----"; echo "$pass passed, $fail failed"
[[ $fail -eq 0 ]]
