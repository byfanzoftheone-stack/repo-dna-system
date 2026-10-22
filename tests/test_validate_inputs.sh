#!/usr/bin/env bash
# Regression test: hostile inputs must be rejected and must NEVER execute.
set -uo pipefail
cd "$(dirname "$0")/.."
V=scripts/validate_inputs.sh
CANARY="$(mktemp -d)/pwned"
pass=0; fail=0
ok()  { pass=$((pass+1)); echo "PASS  $1"; }
bad() { fail=$((fail+1)); echo "FAIL  $1"; }

expect_ok() { out=$("$V" "$1" "$2" 2>/dev/null) && [[ "$out" == "$3" ]] && ok "accept $1 @ $2" || bad "accept $1 @ $2 (got '$out')"; }
expect_reject() { if "$V" "$1" "$2" >/dev/null 2>&1; then bad "reject $1 @ $2"; else ok "reject $(printf %q "$1") @ $(printf %q "$2")"; fi; }

expect_ok "octocat/Hello-World" "main" "octocat Hello-World main"
expect_ok "byfanzoftheone-stack/repo-dna-system" "" "byfanzoftheone-stack repo-dna-system main"
expect_ok "a/b.c_d" "feature/x-1.2" "a b.c_d feature/x-1.2"

for t in "a/b; touch $CANARY" 'a/b$(touch '"$CANARY"')' 'a/b`touch '"$CANARY"'`' "a/b\" && touch $CANARY && \"" \
         "a" "a/b/c" "../x" "a/.." "" "a/b
touch $CANARY"; do expect_reject "$t" "main"; done
for b in "main; touch $CANARY" 'main$(touch '"$CANARY"')' "-x" "/main" "a..b" "main&ref=x" "main?x" "ma in" "main/"; do
  expect_reject "octocat/Hello-World" "$b"; done

[[ -e "$CANARY" ]] && bad "canary file was created: input executed as code" || ok "no injected command ran"
echo "----"; echo "$pass passed, $fail failed"; [[ $fail -eq 0 ]]
