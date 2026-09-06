#!/bin/bash

# ============================================================================
# REPO DNA SYSTEM — BATCH RUNNER
# ============================================================================
# Purpose: Run orchestrator on multiple repositories and generate summary report
#
# Usage: ./batch-runner.sh <repos-file> [max-concurrent]
#
# Input Format (repos.txt):
#   byfanzoftheone-stack/bookpro-booking-app
#   byfanzoftheone-stack/fanzo-avatar
#   ...
#
# Output:
#   - dna-extracts/summary/batch_report.json
#   - dna-extracts/summary/batch_report.csv
#   - dna-extracts/summary/batch_log.txt
#
# ============================================================================

set -euo pipefail

# Configuration
REPOS_FILE="${1:?Usage: ./batch-runner.sh <repos-file> [max-concurrent]}"
MAX_CONCURRENT="${2:-1}"
TOKEN="${GITHUB_TOKEN:?GITHUB_TOKEN environment variable not set}"

# Output directories
SUMMARY_DIR="${PWD}/dna-extracts/summary"
LOG_FILE="${SUMMARY_DIR}/batch_log.txt"
RESULTS_FILE="${SUMMARY_DIR}/.results.tmp"

# Create directories FIRST before anything else
mkdir -p "$SUMMARY_DIR"
rm -f "$LOG_FILE" "$RESULTS_FILE"
touch "$LOG_FILE" "$RESULTS_FILE"

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

# ============================================================================
# UTILITY FUNCTIONS
# ============================================================================

log() {
  local msg="$1"
  local timestamp=$(date -u +"%Y-%m-%d %H:%M:%S UTC")
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
  
  TOTAL_REPOS=$(grep -c . "$REPOS_FILE" || true)
  
  success "Loaded $TOTAL_REPOS repositories"
  log ""
}

analyze_repo() {
  local repo_full="$1"
  local owner=$(echo "$repo_full" | cut -d'/' -f1)
  local repo=$(echo "$repo_full" | cut -d'/' -f2)
  
  log "Analyzing: $repo_full"
  
  if ./orchestrator.sh "$owner" "$repo" main 2>>"$LOG_FILE" >/dev/null; then
    success "✓ $repo_full"
    echo "$repo_full|success" >> "$RESULTS_FILE"
  else
    error "✗ $repo_full"
    echo "$repo_full|failed" >> "$RESULTS_FILE"
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
  
  # Extract metrics with safe defaults
  local tech_stack=$(jq -r '.tech_stack.languages[0].name // "unknown"' "$dna_file" 2>/dev/null || echo "unknown")
  local readme_status=$(jq -r '.readme_status // "unknown"' "$audit_file" 2>/dev/null || echo "unknown")
  local maturity=$(jq -r '.["10_production_readiness"].maturity_level // "unknown"' "$forensic_file" 2>/dev/null || echo "unknown")
  local security=$(jq -r '.["9_security_audit"].critical_findings | length' "$forensic_file" 2>/dev/null || echo "0")
  
  echo "$tech_stack|$readme_status|$maturity|$security"
}

generate_batch_report() {
  log ""
  log "Generating batch report..."
  
  local report_file="${SUMMARY_DIR}/batch_report.json"
  local csv_file="${SUMMARY_DIR}/batch_report.csv"
  local batch_end=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
  local batch_end_epoch=$(date +%s)
  local batch_duration=$((batch_end_epoch - BATCH_START_EPOCH))
  
  # Build repositories array for JSON report
  local repos_json="["
  local csv_header="owner,repo,status,tech_stack,readme_status,maturity,security_findings"
  local csv_content="$csv_header"
  
  local first=true
  if [ -f "$RESULTS_FILE" ]; then
    while IFS='|' read -r repo_full status; do
      [ -z "$repo_full" ] && continue
      
      local owner=$(echo "$repo_full" | cut -d'/' -f1)
      local repo=$(echo "$repo_full" | cut -d'/' -f2)
      
      if [ "$status" = "success" ]; then
        ((SUCCESSFUL++))
        
        local metrics=$(extract_repo_metrics "$owner" "$repo")
        IFS='|' read -r tech_stack readme_status maturity security <<< "$metrics"
        
        # Add to JSON
        if [ "$first" = false ]; then
          repos_json+=","
        fi
        repos_json+="{\"owner\":\"$owner\",\"repo\":\"$repo\",\"status\":\"success\",\"tech_stack\":\"$tech_stack\",\"readme_status\":\"$readme_status\",\"maturity\":\"$maturity\",\"security_findings\":$security}"
        first=false
        
        # Add to CSV
        csv_content+=$'\n'"$owner,$repo,success,$tech_stack,$readme_status,$maturity,$security"
      else
        ((FAILED++))
        
        if [ "$first" = false ]; then
          repos_json+=","
        fi
        repos_json+="{\"owner\":\"$owner\",\"repo\":\"$repo\",\"status\":\"failed\"}"
        first=false
        
        csv_content+=$'\n'"$owner,$repo,failed,n/a,n/a,n/a,n/a"
      fi
    done < "$RESULTS_FILE"
  fi
  
  repos_json+="]"
  
  # Write JSON report
  jq -n \
    --arg batch_run "$BATCH_START" \
    --arg batch_end "$batch_end" \
    --arg total "$TOTAL_REPOS" \
    --arg successful "$SUCCESSFUL" \
    --arg failed "$FAILED" \
    --arg duration "$batch_duration" \
    --argjson repos "$repos_json" \
    '{
      batch_run_at: $batch_run,
      completed_at: $batch_end,
      total_repos: ($total | tonumber),
      successful: ($successful | tonumber),
      failed: ($failed | tonumber),
      duration_seconds: ($duration | tonumber),
      repositories: $repos
    }' > "$report_file"
  
  success "Batch report created: $report_file"
  
  # Write CSV report
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
  log ""
  log "Output Files:"
  echo "  ${SUMMARY_DIR}/batch_report.json"
  echo "  ${SUMMARY_DIR}/batch_report.csv"
  echo "  ${SUMMARY_DIR}/batch_log.txt"
  log ""
  
  local batch_end=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
  log "Completed at: $batch_end"
}

# ============================================================================
# MAIN
# ============================================================================

main() {
  log "=========================================="
  log "REPO DNA SYSTEM — BATCH RUNNER"
  log "=========================================="
  
  log "Batch Start: $BATCH_START"
  log "Repos File: $REPOS_FILE"
  log "Max Concurrent: $MAX_CONCURRENT"
  log ""
  
  load_repos
  
  log "Processing $TOTAL_REPOS repositories..."
  log ""
  
  # Process each repo
  local i=0
  while IFS= read -r repo_full; do
    [ -z "$repo_full" ] && continue
    
    analyze_repo "$repo_full" &
    
    # Limit concurrent processes
    ((i++))
    if [ $((i % MAX_CONCURRENT)) -eq 0 ]; then
      wait
    fi
  done < "$REPOS_FILE"
  
  # Wait for remaining background jobs
  wait
  
  log ""
  generate_batch_report
  print_summary
  
  # Cleanup
  rm -f "$RESULTS_FILE"
}

# ============================================================================
# ERROR HANDLING
# ============================================================================

trap 'error "Batch runner failed"; exit 1' ERR

# Run main
main "$@"
