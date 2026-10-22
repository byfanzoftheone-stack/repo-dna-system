#!/usr/bin/env bash
# Validate Repo DNA workflow inputs. Inputs arrive ONLY as arguments/env,
# never pasted into script text, so they cannot become shell commands.
# Usage: validate_inputs.sh <target> <branch>   -> prints "OWNER REPO BRANCH" or exits 1
set -euo pipefail
target="${1-}"
branch="${2-}"
[[ -z "$branch" ]] && branch="main"

if [[ ! "$target" =~ ^[A-Za-z0-9-]{1,39}/[A-Za-z0-9._-]{1,100}$ ]] || [[ "$target" == */. || "$target" == */.. ]]; then
  echo "invalid target: must be owner/repo" >&2
  exit 1
fi
# Conservative git branch rule: letters, digits, . _ - /, no '..', no leading '-' or '/', max 200 chars
if [[ ! "$branch" =~ ^[A-Za-z0-9._/-]{1,200}$ ]] || [[ "$branch" == -* || "$branch" == /* || "$branch" == *..* || "$branch" == */ ]]; then
  echo "invalid branch name" >&2
  exit 1
fi
printf '%s %s %s\n' "${target%%/*}" "${target#*/}" "$branch"
