#!/bin/bash

# ============================================================================
# REPO DNA SYSTEM — BATCH RUNNER
# ============================================================================

set -euo pipefail

# Configuration
REPOS_FILE="${1:?Usage: ./batch-runner.sh <repos-file> [max-concurrent|auto]}"
MAX_CONCURRENT_INPUT="${2:-auto}"
TOKEN="${GITHUB_TOKEN:?GITHUB_TOKEN environment variable not set}"
RATE_CHECK_EVERY="${DNA_RATE_CHECK_EVERY:-5}"

# Output directories
SUMMARY_DIR="${PWD}/dna-extracts/summary"
LOG_FILE="${SUMMARY_DIR}/batch_log.txt"
RESULTS_FILE="${SUMMARY_DIR}/.results.tmp"
REPO_JSONL_FILE="${SUMMARY_DIR}/.repos_entries.jsonl"

mkdir -p "$SUMMARY_DIR"
rm -f "$LOG_FILE" "$RESULTS_FILE" "$REPO_JSONL_FILE"
touch "$LOG_FILE" "$RESULTS_FILE" "$REPO_JSONL_FILE"

# Timestamps
BATCH_START=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
BATCH_START_EPOCH=$(date +%s)

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Tracking
TOTAL_REPOS=0
SUCCESSFUL=0
FAILED=0
REPOS_STARTED=0

resolve_initial_concurrency() {
  if [ "$MAX_CONCURRENT_INPUT" != "auto" ]; then
    echo "$MAX_CONCURRENT_INPUT"
    return
  fi

  local cpu
  cpu=$(getconf _NPROCESSORS_ONLN 2>/dev/null || echo 2)

  if [ "$cpu" -lt 2 ]; then
    echo 1
  elif [ "$cpu" -gt 8 ]; then
    echo 8
  else
    echo "$cpu"
  fi
}

MAX_CONCURRENT="$(resolve_initial_concurrency)"
CURRENT_CONCURRENCY="$MAX_CONCURRENT"

log() {
  local msg="$1"
  local timestamp
  timestamp=$(date -u +"%Y-%m-%d %H:%M:%S UTC")
  echo -e "${BLUE}[$timestamp]${NC} $msg" | tee -a "$LOG_FILE"
}

success() {
  echo -e "${GREEN}✓${NC} $1" | tee -a "$LOG_FILE"
}

error() {
  echo -e "${RED}✗${NC} $1" | tee -a "$LOG_FILE"
}

warn() {
  echo -e "${YELLOW}⚠${NC} $1" | tee -a "$LOG_FILE"
}

load_repos() {
  log "Loading repository list..."

  if [ ! -f "$REPOS_FILE" ]; then
    error "Repos file not found: $REPOS_FILE"
    exit 1
  fi

  TOTAL_REPOS=$(grep -Ec '^[[:space:]]*[^#[:space:]]' "$REPOS_FILE" || true)
  success "Loaded $TOTAL_REPOS repositories"
  log ""
}

check_rate_limit_remaining() {
  local rate_json
  rate_json=$(curl -s -H "Authorization: token ${TOKEN}" https://api.github.com/rate_limit 2>/dev/null || echo "{}")
  echo "$rate_json" | jq -r '.resources.core.remaining // 0' 2>/dev/null || echo 0
}

adjust_concurrency() {
  local remaining
  remaining=$(check_rate_limit_remaining)

  local next="$MAX_CONCURRENT"
  if [ "$remaining" -le 300 ]; then
    next=1
  elif [ "$remaining" -le 1200 ]; then
    next=2
  elif [ "$remaining" -le 2500 ]; then
    next=4
  fi

  if [ "$next" -gt "$MAX_CONCURRENT" ]; then
    next="$MAX_CONCURRENT"
  fi

  if [ "$next" -ne "$CURRENT_CONCURRENCY" ]; then
    CURRENT_CONCURRENCY="$next"
    warn "Adjusted concurrency to $CURRENT_CONCURRENCY (rate remaining: $remaining)"
  fi
}

analyze_repo() {
  local repo_full="$1"
  local owner
  owner=$(echo "$repo_full" | cut -d'/' -f1)
  local repo
  repo=$(echo "$repo_full" | cut -d'/' -f2)

  local start_epoch
  start_epoch=$(date +%s)

  log "Analyzing: $repo_full"

  if ./orchestrator.sh "$owner" "$repo" main 2>>"$LOG_FILE" >/dev/null; then
    local end_epoch
    end_epoch=$(date +%s)
    local duration=$((end_epoch - start_epoch))

    local run_metrics="dna-extracts/${owner}/${repo}/logs/metrics/run_metrics.json"
    local api_calls=0
    local cache_hits=0
    local cache_misses=0

    if [ -f "$run_metrics" ]; then
      api_calls=$(jq -r '.api_calls // 0' "$run_metrics" 2>/dev/null || echo 0)
      cache_hits=$(jq -r '.cache_hits // 0' "$run_metrics" 2>/dev/null || echo 0)
      cache_misses=$(jq -r '.cache_misses // 0' "$run_metrics" 2>/dev/null || echo 0)
    fi

    success "✓ $repo_full (${duration}s)"
    echo "$repo_full|success|$duration|$api_calls|$cache_hits|$cache_misses" >> "$RESULTS_FILE"
  else
    local end_epoch
    end_epoch=$(date +%s)
    local duration=$((end_epoch - start_epoch))

    error "✗ $repo_full (${duration}s)"
    echo "$repo_full|failed|$duration|0|0|0" >> "$RESULTS_FILE"
  fi
}

extract_repo_metrics() {
  local owner="$1"
  local repo="$2"
  local output_dir="dna-extracts/${owner}/${repo}/output"

  if [ ! -d "$output_dir" ]; then
    echo "n/a|n/a|n/a|n/a"
    return
  fi

  local dna_file="${output_dir}/02_repo_dna.json"
  local audit_file="${output_dir}/03_readme_audit.json"
  local forensic_file="${output_dir}/03.5_forensic_report.json"

  local tech_stack
  tech_stack=$(jq -r '.tech_stack.languages[0].name // "unknown"' "$dna_file" 2>/dev/null || echo "unknown")
  local readme_status
  readme_status=$(jq -r '.readme_status // "unknown"' "$audit_file" 2>/dev/null || echo "unknown")
  local maturity
  maturity=$(jq -r '.["10_production_readiness"].maturity_level // "unknown"' "$forensic_file" 2>/dev/null || echo "unknown")
  local security
  security=$(jq -r '.["9_security_audit"].critical_findings | length' "$forensic_file" 2>/dev/null || echo "0")

  echo "$tech_stack|$readme_status|$maturity|$security"
}

calculate_percentile() {
  local percentile="$1"
  mapfile -t values < <(awk -F'|' '$2=="success" && $3 ~ /^[0-9]+$/ {print $3}' "$RESULTS_FILE" | sort -n)

  local count=${#values[@]}
  if [ "$count" -eq 0 ]; then
    echo 0
    return
  fi

  local rank=$(( (percentile * count + 99) / 100 ))
  if [ "$rank" -lt 1 ]; then
    rank=1
  fi
  if [ "$rank" -gt "$count" ]; then
    rank="$count"
  fi

  echo "${values[$((rank - 1))]}"
}

generate_batch_report() {
  log ""
  log "Generating batch report..."

  local report_file="${SUMMARY_DIR}/batch_report.json"
  local csv_file="${SUMMARY_DIR}/batch_report.csv"
  local batch_end
  batch_end=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
  local batch_end_epoch
  batch_end_epoch=$(date +%s)
  local batch_duration=$((batch_end_epoch - BATCH_START_EPOCH))

  local csv_header="owner,repo,status,duration_seconds,api_calls,cache_hits,cache_misses,tech_stack,readme_status,maturity,security_findings"
  local csv_content="$csv_header"

  local total_api_calls=0
  local total_cache_hits=0
  local total_cache_misses=0

  while IFS='|' read -r repo_full status duration api_calls cache_hits cache_misses; do
    [ -z "$repo_full" ] && continue

    local owner
    owner=$(echo "$repo_full" | cut -d'/' -f1)
    local repo
    repo=$(echo "$repo_full" | cut -d'/' -f2)

    total_api_calls=$((total_api_calls + api_calls))
    total_cache_hits=$((total_cache_hits + cache_hits))
    total_cache_misses=$((total_cache_misses + cache_misses))

    if [ "$status" = "success" ]; then
      SUCCESSFUL=$((SUCCESSFUL + 1))

      local metrics
      metrics=$(extract_repo_metrics "$owner" "$repo")
      IFS='|' read -r tech_stack readme_status maturity security <<< "$metrics"

      jq -n \
        --arg owner "$owner" \
        --arg repo "$repo" \
        --arg status "success" \
        --arg duration "$duration" \
        --arg api_calls "$api_calls" \
        --arg cache_hits "$cache_hits" \
        --arg cache_misses "$cache_misses" \
        --arg tech_stack "$tech_stack" \
        --arg readme_status "$readme_status" \
        --arg maturity "$maturity" \
        --arg security "$security" \
        '{
          owner: $owner,
          repo: $repo,
          status: $status,
          duration_seconds: ($duration | tonumber),
          api_calls: ($api_calls | tonumber),
          cache_hits: ($cache_hits | tonumber),
          cache_misses: ($cache_misses | tonumber),
          tech_stack: $tech_stack,
          readme_status: $readme_status,
          maturity: $maturity,
          security_findings: ($security | tonumber)
        }' >> "$REPO_JSONL_FILE"

      csv_content+=$'\n'"$owner,$repo,success,$duration,$api_calls,$cache_hits,$cache_misses,$tech_stack,$readme_status,$maturity,$security"
    else
      FAILED=$((FAILED + 1))

      jq -n \
        --arg owner "$owner" \
        --arg repo "$repo" \
        --arg status "failed" \
        --arg duration "$duration" \
        '{
          owner: $owner,
          repo: $repo,
          status: $status,
          duration_seconds: ($duration | tonumber)
        }' >> "$REPO_JSONL_FILE"

      csv_content+=$'\n'"$owner,$repo,failed,$duration,0,0,0,n/a,n/a,n/a,n/a"
    fi
  done < "$RESULTS_FILE"

  local p50
  p50=$(calculate_percentile 50)
  local p95
  p95=$(calculate_percentile 95)

  local failure_rate="0"
  if [ "$TOTAL_REPOS" -gt 0 ]; then
    failure_rate=$(awk -v f="$FAILED" -v t="$TOTAL_REPOS" 'BEGIN { printf "%.4f", f/t }')
  fi

  local cache_hit_rate="0"
  local total_cache_ops=$((total_cache_hits + total_cache_misses))
  if [ "$total_cache_ops" -gt 0 ]; then
    cache_hit_rate=$(awk -v h="$total_cache_hits" -v t="$total_cache_ops" 'BEGIN { printf "%.4f", h/t }')
  fi

  local repos_json
  repos_json=$(jq -s '.' "$REPO_JSONL_FILE" 2>/dev/null || echo "[]")

  jq -n \
    --arg batch_run "$BATCH_START" \
    --arg batch_end "$batch_end" \
    --arg total "$TOTAL_REPOS" \
    --arg successful "$SUCCESSFUL" \
    --arg failed "$FAILED" \
    --arg duration "$batch_duration" \
    --arg p50 "$p50" \
    --arg p95 "$p95" \
    --arg failure_rate "$failure_rate" \
    --arg api_calls "$total_api_calls" \
    --arg cache_hits "$total_cache_hits" \
    --arg cache_misses "$total_cache_misses" \
    --arg cache_hit_rate "$cache_hit_rate" \
    --arg max_concurrency "$MAX_CONCURRENT" \
    --arg final_concurrency "$CURRENT_CONCURRENCY" \
    --argjson repos "$repos_json" \
    '{
      batch_run_at: $batch_run,
      completed_at: $batch_end,
      total_repos: ($total | tonumber),
      successful: ($successful | tonumber),
      failed: ($failed | tonumber),
      duration_seconds: ($duration | tonumber),
      performance_summary: {
        p50_repo_duration_seconds: ($p50 | tonumber),
        p95_repo_duration_seconds: ($p95 | tonumber),
        failure_rate: ($failure_rate | tonumber),
        api_calls: ($api_calls | tonumber),
        cache_hits: ($cache_hits | tonumber),
        cache_misses: ($cache_misses | tonumber),
        cache_hit_rate: ($cache_hit_rate | tonumber),
        initial_max_concurrency: ($max_concurrency | tonumber),
        final_concurrency: ($final_concurrency | tonumber)
      },
      repositories: $repos
    }' > "$report_file"

  success "Batch report created: $report_file"

  echo -e "$csv_content" > "$csv_file"
  success "CSV report created: $csv_file"
}

print_summary() {
  log ""
  log "=========================================="
  success "BATCH ANALYSIS COMPLETE"
  log "=========================================="
  log ""
  log "Summary:"
  echo "  Total Repositories: $TOTAL_REPOS"
  echo "  Successful: ${GREEN}$SUCCESSFUL${NC}"
  echo "  Failed: ${RED}$FAILED${NC}"
  echo "  Initial Max Concurrency: $MAX_CONCURRENT"
  echo "  Final Concurrency: $CURRENT_CONCURRENCY"
  log ""
  log "Output Files:"
  echo "  ${SUMMARY_DIR}/batch_report.json"
  echo "  ${SUMMARY_DIR}/batch_report.csv"
  echo "  ${SUMMARY_DIR}/batch_log.txt"
  log ""

  local batch_end
  batch_end=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
  log "Completed at: $batch_end"
}

main() {
  log "=========================================="
  log "REPO DNA SYSTEM — BATCH RUNNER"
  log "=========================================="

  log "Batch Start: $BATCH_START"
  log "Repos File: $REPOS_FILE"
  log "Max Concurrent Input: $MAX_CONCURRENT_INPUT"
  log "Resolved Max Concurrent: $MAX_CONCURRENT"
  log ""

  load_repos

  log "Processing $TOTAL_REPOS repositories..."
  log ""

  local active_jobs=0

  while IFS= read -r repo_full; do
    [ -z "$repo_full" ] && continue
    if [[ "$repo_full" =~ ^[[:space:]]*# ]]; then
      continue
    fi

    while [ "$active_jobs" -ge "$CURRENT_CONCURRENCY" ]; do
      wait -n || true
      active_jobs=$((active_jobs - 1))
    done

    analyze_repo "$repo_full" &
    active_jobs=$((active_jobs + 1))
    REPOS_STARTED=$((REPOS_STARTED + 1))

    if [ "$RATE_CHECK_EVERY" -gt 0 ] && [ $((REPOS_STARTED % RATE_CHECK_EVERY)) -eq 0 ]; then
      adjust_concurrency
    fi
  done < "$REPOS_FILE"

  while [ "$active_jobs" -gt 0 ]; do
    wait -n || true
    active_jobs=$((active_jobs - 1))
  done

  log ""
  generate_batch_report
  print_summary

  rm -f "$RESULTS_FILE" "$REPO_JSONL_FILE"
}

trap 'error "Batch runner failed"; exit 1' ERR

main "$@"
