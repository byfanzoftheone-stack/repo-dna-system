#!/usr/bin/env bash
# Regression test: hostile inputs must be rejected and must NEVER execute.
# Uses no tokens or network. Safe to run anywhere.
set -uo pipefail
cd "$(dirname "$0")/.." || exit 1
V=scripts/validate_inputs.sh
CANARY="$(mktemp -d)/pwned"
pass=0; fail=0
ok()  { pass=$((pass+1)); echo "PASS  $1"; }
bad() { fail=$((fail+1)); echo "FAIL  $1"; }

expect_ok() {
  local out
  if out=$("$V" "$1" "$2" 2>/dev/null) && [[ "$out" == "$3" ]]; then
    ok "accept $1 @ $2"
  else
    bad "accept $1 @ $2 (got '${out:-}')"
  fi
}
expect_reject() {
  if "$V" "$1" "$2" >/dev/null 2>&1; then
    bad "reject $(printf %q "$1") @ $(printf %q "$2")"
  else
    ok "reject $(printf %q "$1") @ $(printf %q "$2")"
  fi
}

expect_ok "octocat/Hello-World" "main" "octocat Hello-World main"
expect_ok "byfanzoftheone-stack/repo-dna-system" "" "byfanzoftheone-stack repo-dna-system main"
expect_ok "a/b.c_d" "feature/x-1.2" "a b.c_d feature/x-1.2"

# Single quotes below are deliberate: payloads must stay literal text.
# shellcheck disable=SC2016
for t in "a/b; touch $CANARY" 'a/b$(touch '"$CANARY"')' 'a/b`touch '"$CANARY"'`' "a/b\" && touch $CANARY && \"" \
         "a" "a/b/c" "../x" "a/.." "" "a/b
touch $CANARY"; do expect_reject "$t" "main"; done
# shellcheck disable=SC2016
for b in "main; touch $CANARY" 'main$(touch '"$CANARY"')' "-x" "/main" "a..b" "main&ref=x" "main?x" "ma in" "main/"; do
  expect_reject "octocat/Hello-World" "$b"
done

if [[ -e "$CANARY" ]]; then
  bad "canary file was created: input executed as code"
else
  ok "no injected command ran"
fi
echo "----"; echo "$pass passed, $fail failed"
[[ $fail -eq 0 ]]
