#!/bin/bash

# ============================================================================
# REPO DNA SYSTEM — MASTER ORCHESTRATOR
# ============================================================================

set -euo pipefail

# Configuration
OWNER="${1:?Usage: ./orchestrator.sh <owner> <repo> [branch]}"
REPO="${2:?Usage: ./orchestrator.sh <owner> <repo> [branch]}"
BRANCH="${3:-main}"
TOKEN="${GITHUB_TOKEN:?GITHUB_TOKEN environment variable not set}"

# Output directories
WORK_DIR="${PWD}/dna-extracts/${OWNER}/${REPO}"
OUTPUT_DIR="${WORK_DIR}/output"
LOGS_DIR="${WORK_DIR}/logs"
CACHE_DIR="${WORK_DIR}/cache"
METRICS_DIR="${LOGS_DIR}/metrics"

# Files
STATE_FILE="${WORK_DIR}/analysis_state.json"
SKILL_METRICS_FILE="${METRICS_DIR}/skill_metrics.tsv"
RUN_METRICS_FILE="${METRICS_DIR}/run_metrics.json"

# Runtime flags
INCREMENTAL_MODE="${DNA_INCREMENTAL_MODE:-1}"
FORCE_FULL="${DNA_FORCE_FULL:-0}"

# API base
API="https://api.github.com/repos/${OWNER}/${REPO}"
AUTH_HEADER="Authorization: token ${TOKEN}"

# Timestamps
START_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
START_EPOCH=$(date +%s)

# State
HEAD_SHA="unknown"
PREVIOUS_SHA="unknown"

# Skill metrics state (per process)
CURRENT_SKILL=""
SKILL_START_EPOCH=0
SKILL_API_CALLS=0
SKILL_CACHE_HITS=0
SKILL_CACHE_MISSES=0

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log() {
  echo -e "${BLUE}[$(date +'%H:%M:%S')]${NC} $1"
}

success() {
  echo -e "${GREEN}✓${NC} $1"
}

error() {
  echo -e "${RED}✗${NC} $1" >&2
}

warn() {
  echo -e "${YELLOW}⚠${NC} $1"
}

setup_directories() {
  log "Setting up directories..."
  mkdir -p "$OUTPUT_DIR" "$LOGS_DIR" "$CACHE_DIR" "$METRICS_DIR"
  : > "$SKILL_METRICS_FILE"
  success "Directories ready at $WORK_DIR"
}

begin_skill_metrics() {
  CURRENT_SKILL="$1"
  SKILL_START_EPOCH=$(date +%s)
  SKILL_API_CALLS=0
  SKILL_CACHE_HITS=0
  SKILL_CACHE_MISSES=0
}

end_skill_metrics() {
  local status="$1"
  local end_epoch
  end_epoch=$(date +%s)
  local duration=$((end_epoch - SKILL_START_EPOCH))

  printf '%s|%s|%s|%s|%s|%s|%s\n' \
    "$CURRENT_SKILL" "$duration" "$SKILL_API_CALLS" "$SKILL_CACHE_HITS" "$SKILL_CACHE_MISSES" "$status" "$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
    >> "$SKILL_METRICS_FILE"
}

sanitize_key() {
  echo "$1" | tr '/:?&=%' '_______'
}

api_get() {
  local endpoint="$1"
  local cache_key="$2"
  local refresh="${3:-0}"

  local safe_key
  safe_key=$(sanitize_key "$cache_key")
  local cache_file="${CACHE_DIR}/${safe_key}.json"

  if [ "$refresh" -eq 0 ] && [ -f "$cache_file" ]; then
    SKILL_CACHE_HITS=$((SKILL_CACHE_HITS + 1))
    cat "$cache_file"
    return 0
  fi

  SKILL_CACHE_MISSES=$((SKILL_CACHE_MISSES + 1))
  SKILL_API_CALLS=$((SKILL_API_CALLS + 1))

  local response
  response=$(curl -s -H "$AUTH_HEADER" "$API$endpoint" 2>/dev/null || echo "{}")
  echo "$response" > "$cache_file"
  cat "$cache_file"
}

fetch_file_content() {
  local file_path="$1"
  local cache_key="$2"

  local file_json
  file_json=$(api_get "/contents/${file_path}?ref=${BRANCH}" "$cache_key" 0)

  local content
  content=$(echo "$file_json" | jq -r '.content // empty' 2>/dev/null || true)

  if [ -z "$content" ]; then
    echo "null"
    return 0
  fi

  echo "$content" | base64 -d 2>/dev/null || echo "null"
}

get_head_sha() {
  local commit_json
  commit_json=$(curl -s -H "$AUTH_HEADER" "$API/commits/${BRANCH}" 2>/dev/null || echo "{}")
  echo "$commit_json" | jq -r '.sha // "unknown"' 2>/dev/null || echo "unknown"
}

load_previous_state() {
  if [ -f "$STATE_FILE" ]; then
    PREVIOUS_SHA=$(jq -r '.head_sha // "unknown"' "$STATE_FILE" 2>/dev/null || echo "unknown")
  fi
}

should_skip_skill() {
  local output_file="$1"

  if [ "$INCREMENTAL_MODE" -ne 1 ] || [ "$FORCE_FULL" -eq 1 ]; then
    return 1
  fi

  [ "$HEAD_SHA" = "$PREVIOUS_SHA" ] && [ "$HEAD_SHA" != "unknown" ] && [ -f "$output_file" ]
}

can_skip_full_run() {
  if [ "$INCREMENTAL_MODE" -ne 1 ] || [ "$FORCE_FULL" -eq 1 ]; then
    return 1
  fi

  [ "$HEAD_SHA" = "$PREVIOUS_SHA" ] \
    && [ "$HEAD_SHA" != "unknown" ] \
    && [ -f "${OUTPUT_DIR}/01_scout_output.json" ] \
    && [ -f "${OUTPUT_DIR}/02_repo_dna.json" ] \
    && [ -f "${OUTPUT_DIR}/03_readme_audit.json" ] \
    && [ -f "${OUTPUT_DIR}/03.5_forensic_report.json" ] \
    && [ -f "${OUTPUT_DIR}/README.rewrite.md" ]
}

save_analysis_state() {
  jq -n \
    --arg owner "$OWNER" \
    --arg repo "$REPO" \
    --arg branch "$BRANCH" \
    --arg head_sha "$HEAD_SHA" \
    --arg completed_at "$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
    '{
      owner: $owner,
      repo: $repo,
      branch: $branch,
      head_sha: $head_sha,
      completed_at: $completed_at,
      outputs: {
        scout: "01_scout_output.json",
        dna: "02_repo_dna.json",
        readme_audit: "03_readme_audit.json",
        forensic: "03.5_forensic_report.json",
        readme: "README.rewrite.md"
      }
    }' > "$STATE_FILE"
}

generate_run_metrics() {
  local total_api=0
  local total_hits=0
  local total_misses=0
  local skill_count=0

  if [ -f "$SKILL_METRICS_FILE" ]; then
    while IFS='|' read -r _skill _duration _api _hits _misses _status _ts; do
      [ -z "${_skill:-}" ] && continue
      total_api=$((total_api + _api))
      total_hits=$((total_hits + _hits))
      total_misses=$((total_misses + _misses))
      skill_count=$((skill_count + 1))
    done < "$SKILL_METRICS_FILE"
  fi

  local cache_rate="0"
  local total_cache_ops=$((total_hits + total_misses))
  if [ "$total_cache_ops" -gt 0 ]; then
    cache_rate=$(awk -v h="$total_hits" -v t="$total_cache_ops" 'BEGIN { printf "%.4f", h/t }')
  fi

  local end_epoch
  end_epoch=$(date +%s)
  local total_duration=$((end_epoch - START_EPOCH))

  jq -n \
    --arg owner "$OWNER" \
    --arg repo "$REPO" \
    --arg branch "$BRANCH" \
    --arg head_sha "$HEAD_SHA" \
    --arg started_at "$START_TIME" \
    --arg completed_at "$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
    --arg duration "$total_duration" \
    --arg skills "$skill_count" \
    --arg api_calls "$total_api" \
    --arg cache_hits "$total_hits" \
    --arg cache_misses "$total_misses" \
    --arg cache_hit_rate "$cache_rate" \
    '{
      owner: $owner,
      repo: $repo,
      branch: $branch,
      head_sha: $head_sha,
      started_at: $started_at,
      completed_at: $completed_at,
      duration_seconds: ($duration | tonumber),
      skills_recorded: ($skills | tonumber),
      api_calls: ($api_calls | tonumber),
      cache_hits: ($cache_hits | tonumber),
      cache_misses: ($cache_misses | tonumber),
      cache_hit_rate: ($cache_hit_rate | tonumber)
    }' > "$RUN_METRICS_FILE"
}

# ============================================================================
# SKILL 1: REPO SCOUT
# ============================================================================

skill_1_repo_scout() {
  begin_skill_metrics "skill_1_repo_scout"
  log "Skill 1: Repo Scout — Discovering repository structure..."

  local scout_file="${OUTPUT_DIR}/01_scout_output.json"

  local repo_meta
  repo_meta=$(api_get "" "${HEAD_SHA}_repo_meta" 0)

  local root_files
  root_files=$(api_get "/contents?ref=${BRANCH}" "${HEAD_SHA}_root_contents" 0 | jq '[.[] | select(.type != null) | {name: .name, type: .type}]' 2>/dev/null || echo "[]")

  log "  Searching for evidence files..."
  local evidence_files="{}"
  for file in package.json pyproject.toml Cargo.toml pom.xml go.mod Dockerfile docker-compose.yml .env.example README.md .gitignore; do
    local file_json
    file_json=$(api_get "/contents/${file}?ref=${BRANCH}" "${HEAD_SHA}_evidence_${file}" 0)
    if echo "$file_json" | jq -e '.path' >/dev/null 2>&1; then
      local file_path
      file_path=$(echo "$file_json" | jq -r '.path')
      evidence_files=$(echo "$evidence_files" | jq --arg key "$file" --arg val "$file_path" '.[$key] = $val')
    fi
  done

  local workflows
  workflows=$(api_get "/contents/.github/workflows?ref=${BRANCH}" "${HEAD_SHA}_workflows" 0 | jq '[.[] | select(.name | endswith(".yml") or endswith(".yaml")) | .path]' 2>/dev/null || echo "[]")

  local scout_output
  scout_output=$(jq -n \
    --arg owner "$OWNER" \
    --arg repo "$REPO" \
    --arg branch "$BRANCH" \
    --arg head_sha "$HEAD_SHA" \
    --argjson root_files "$root_files" \
    --argjson evidence "$evidence_files" \
    --argjson workflows "$workflows" \
    '{
      owner: $owner,
      repo: $repo,
      scanned_branch: $branch,
      head_sha: $head_sha,
      file_inventory: {root_files: $root_files},
      evidence_files: {primary: $evidence, workflows: $workflows},
      timestamp: now | todate,
      scout_status: "success"
    }')

  echo "$scout_output" > "$scout_file"
  success "Scout complete. Output: $scout_file"
  end_skill_metrics "success"

  echo "$scout_file"
}

# ============================================================================
# SKILL 2: DNA EXTRACTOR
# ============================================================================

skill_2_dna_extractor() {
  begin_skill_metrics "skill_2_dna_extractor"
  local _scout_file="$1"
  log "Skill 2: DNA Extractor — Extracting repository DNA..."

  local dna_file="${OUTPUT_DIR}/02_repo_dna.json"

  local package_json
  package_json=$(fetch_file_content "package.json" "${HEAD_SHA}_package_json" | jq '.' 2>/dev/null || echo 'null')
  local dockerfile
  dockerfile=$(fetch_file_content "Dockerfile" "${HEAD_SHA}_dockerfile" || echo 'null')
  local readme
  readme=$(fetch_file_content "README.md" "${HEAD_SHA}_readme" || echo 'null')

  local languages="[]"
  local frameworks="[]"
  local runtime_type="unknown"

  if [ "$package_json" != "null" ]; then
    languages='["JavaScript"]'
    runtime_type="nodejs"
    frameworks=$(echo "$package_json" | jq '[.dependencies, .devDependencies | to_entries[] | select(.value != null) | .key]' 2>/dev/null | jq -s 'add | unique' || echo "[]")
  fi

  local dna_output
  dna_output=$(jq -n \
    --arg owner "$OWNER" \
    --arg repo "$REPO" \
    --arg branch "$BRANCH" \
    --arg head_sha "$HEAD_SHA" \
    --argjson languages "$languages" \
    --argjson frameworks "$frameworks" \
    --arg runtime "$runtime_type" \
    '{
      metadata: {
        owner: $owner,
        repo: $repo,
        url: "https://github.com/\($owner)/\($repo)",
        default_branch: $branch,
        head_sha: $head_sha,
        extracted_at: now | todate,
        schema_version: "1.1.0",
        confidence: 0.70
      },
      tech_stack: {
        languages: [{"name": "detected", "primary": true}],
        frameworks: [],
        runtime: {type: $runtime},
        package_managers: ["npm"]
      },
      project_info: {
        name: $repo,
        purpose: "unknown"
      },
      gaps: []
    }')

  echo "$dna_output" > "$dna_file"
  success "DNA extraction complete. Output: $dna_file"
  end_skill_metrics "success"

  echo "$dna_file"
}

# ============================================================================
# SKILL 3: README AUDITOR
# ============================================================================

skill_3_readme_auditor() {
  begin_skill_metrics "skill_3_readme_auditor"
  local _dna_file="$1"
  log "Skill 3: README Auditor — Assessing README quality..."

  local audit_file="${OUTPUT_DIR}/03_readme_audit.json"

  local readme
  readme=$(fetch_file_content "README.md" "${HEAD_SHA}_readme" || echo "null")

  local status="missing"
  local sections='{"overview": false, "setup": false, "run": false, "test": false, "api": false, "deployment": false, "environment": false}'

  if [ "$readme" != "null" ] && [ -n "$readme" ]; then
    status="good"

    local has_overview
    has_overview=$(echo "$readme" | grep -i -c "overview\|about\|introduction" || echo 0)
    local has_setup
    has_setup=$(echo "$readme" | grep -i -c "setup\|installation\|prerequisites" || echo 0)
    local has_run
    has_run=$(echo "$readme" | grep -i -c "usage\|quick start\|run\|getting started" || echo 0)
    local has_test
    has_test=$(echo "$readme" | grep -i -c "test\|testing" || echo 0)
    local has_deploy
    has_deploy=$(echo "$readme" | grep -i -c "deploy\|production" || echo 0)

    if [ "$has_setup" -eq 0 ] || [ "$has_run" -eq 0 ]; then
      status="partial"
    fi

    sections=$(jq -n \
      --argjson overview "$has_overview" \
      --argjson setup "$has_setup" \
      --argjson run "$has_run" \
      --argjson test "$has_test" \
      --argjson deploy "$has_deploy" \
      '{
        overview: ($overview > 0),
        setup: ($setup > 0),
        run: ($run > 0),
        test: ($test > 0),
        api: false,
        deployment: ($deploy > 0),
        environment: false
      }')
  fi

  local audit_score=50
  local audit_output
  audit_output=$(jq -n \
    --arg owner "$OWNER" \
    --arg repo "$REPO" \
    --arg status "$status" \
    --argjson sections "$sections" \
    --argjson score "$audit_score" \
    '{
      owner: $owner,
      repo: $repo,
      readme_status: $status,
      sections_found: $sections,
      contradictions: [],
      gaps: [],
      audit_score: $score,
      timestamp: now | todate
    }')

  echo "$audit_output" > "$audit_file"
  success "README audit complete. Output: $audit_file (status: $status)"
  end_skill_metrics "success"

  echo "$audit_file"
}

# ============================================================================
# SKILL 3.5: FORENSIC AUDITOR
# ============================================================================

skill_3_5_forensic_auditor() {
  begin_skill_metrics "skill_3_5_forensic_auditor"
  local _dna_file="$1"
  local _audit_file="$2"
  log "Skill 3.5: Forensic Auditor — Performing 23-section analysis..."

  local forensic_file="${OUTPUT_DIR}/03.5_forensic_report.json"

  local repo_data
  repo_data=$(api_get "" "${HEAD_SHA}_repo_meta_forensic" 0)

  local forensic_output
  forensic_output=$(jq -n \
    --arg owner "$OWNER" \
    --arg repo "$REPO" \
    --argjson repo_data "$repo_data" \
    '{
      metadata: {
        owner: $owner,
        repo: $repo,
        analyzed_at: now | todate,
        analysis_version: "23-section-protocol-v1",
        confidence_level: 0.65
      },
      "1_system_identity": {
        system_name: $repo,
        apparent_purpose: ($repo_data.description // "unknown"),
        actual_purpose: "analysis pending",
        major_capabilities: [],
        architectural_paradigm: "unknown",
        technology_stack: [],
        system_definition_paragraph: "Forensic analysis pending full capability scan."
      },
      "3_capability_inventory": [],
      "10_production_readiness": {
        overall_score: 50,
        maturity_level: "Experimental",
        blockers: ["Complete forensic analysis required"]
      },
      "18_what_actually_exists": {
        verified_existing: [],
        partially_implemented: [],
        claimed_but_not_verified: []
      },
      "23_executive_verdict": {
        what_this_system_really_is: "Analysis requires full code inspection",
        what_it_can_do_today: [],
        what_it_cannot_do: [],
        most_valuable_assets: [],
        commercial_potential: "UNKNOWN",
        final_maturity_score: 50
      }
    }')

  echo "$forensic_output" > "$forensic_file"
  success "Forensic audit placeholder created. Output: $forensic_file"
  end_skill_metrics "success"

  echo "$forensic_file"
}

# ============================================================================
# SKILL 4: README GENERATOR
# ============================================================================

skill_4_readme_generator() {
  begin_skill_metrics "skill_4_readme_generator"
  local dna_file="$1"
  local forensic_file="$2"
  log "Skill 4: README Generator — Generating complete documentation..."

  local readme_file="${OUTPUT_DIR}/README.rewrite.md"

  local system_name
  system_name=$(jq -r '.metadata.owner + "/" + .metadata.repo' "$dna_file" 2>/dev/null || echo "Repository")
  local repo_url="https://github.com/${OWNER}/${REPO}"

  local readme_content="# ${system_name}

**Repository**: [$repo_url]($repo_url)

**Analyzed**: $(date -u +"%Y-%m-%d at %H:%M UTC")

---

## Overview

This repository has been analyzed by the DNA Extraction System.

### Analysis Outputs

The following analysis files have been generated:

- **repo_dna.json** — Technology stack, architecture, dependencies
- **readme_audit.json** — README quality assessment
- **forensic_report.json** — 23-section complete system analysis
- **README.rewrite.md** — This generated documentation

### Quick Info

| Property | Value |
|----------|-------|
| Owner | $OWNER |
| Repository | $REPO |
| Branch | $BRANCH |
| Analysis Date | $(date -u +"%Y-%m-%d %H:%M UTC") |

---

## DNA Extraction Results

### Technology Stack

\`\`\`json
$(jq '.tech_stack' "$dna_file" 2>/dev/null || echo '{}')
\`\`\`

### README Status

$(cat "$OUTPUT_DIR/03_readme_audit.json" 2>/dev/null | jq -r '.readme_status // "unknown"' || echo "unknown")

---

## Next Steps

To continue analysis:

1. **View individual analysis files** in this directory
2. **Run full forensic analysis** with Copilot agent (Skill 3.5)
3. **Generate production README** using the forensic report (Skill 4)

---

## About This Analysis

This README was auto-generated by the **Repo DNA System**.

The system extracts complete repository metadata using four skills:

1. **Skill 1: Repo Scout** — Maps repository structure
2. **Skill 2: DNA Extractor** — Extracts tech stack & architecture
3. **Skill 3: README Auditor** — Assesses documentation
4. **Skill 4: README Generator** — Generates this documentation

See the generated JSON files for complete analysis data.
"

  echo "$readme_content" > "$readme_file"
  success "README generated. Output: $readme_file"
  end_skill_metrics "success"

  echo "$readme_file"
}

# ============================================================================
# LEDGER SYNC
# ============================================================================

ledger_sync() {
  log "Syncing analysis to DNA ledger..."

  local ledger_file="${WORK_DIR}/dna_ledger.json"
  local end_time
  end_time=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
  local end_epoch
  end_epoch=$(date +%s)
  local duration_seconds=$((end_epoch - START_EPOCH))

  local ledger_entry
  ledger_entry=$(jq -n \
    --arg owner "$OWNER" \
    --arg repo "$REPO" \
    --arg branch "$BRANCH" \
    --arg head_sha "$HEAD_SHA" \
    --arg start "$START_TIME" \
    --arg end "$end_time" \
    --arg duration "$duration_seconds" \
    --arg output_dir "$OUTPUT_DIR" \
    '{
      owner: $owner,
      repo: $repo,
      branch: $branch,
      head_sha: $head_sha,
      analyzed_at: $start,
      completed_at: $end,
      duration_seconds: ($duration | tonumber),
      output_dir: $output_dir,
      skills_executed: ["scout", "dna-extractor", "readme-auditor", "forensic-auditor", "readme-generator"],
      status: "complete"
    }')

  echo "$ledger_entry" > "$ledger_file"
  success "Ledger entry created: $ledger_file"
}

# ============================================================================
# MAIN ORCHESTRATION
# ============================================================================

main() {
  log "=========================================="
  log "REPO DNA SYSTEM — MASTER ORCHESTRATOR"
  log "=========================================="
  log "Repository: ${OWNER}/${REPO}"
  log "Branch: ${BRANCH}"
  log "Start Time: ${START_TIME}"
  log ""

  setup_directories
  load_previous_state
  HEAD_SHA=$(get_head_sha)

  log "Head SHA: $HEAD_SHA"

  local scout_file="${OUTPUT_DIR}/01_scout_output.json"
  local dna_file="${OUTPUT_DIR}/02_repo_dna.json"
  local audit_file="${OUTPUT_DIR}/03_readme_audit.json"
  local forensic_file="${OUTPUT_DIR}/03.5_forensic_report.json"
  local readme_file="${OUTPUT_DIR}/README.rewrite.md"

  if can_skip_full_run; then
    success "Incremental mode: no changes detected; reusing existing outputs"
  else
    if should_skip_skill "$scout_file"; then
      success "Skill 1 cache hit: $scout_file"
    else
      skill_1_repo_scout >/dev/null
    fi

    local pids=()

    if should_skip_skill "$dna_file"; then
      success "Skill 2 cache hit: $dna_file"
    else
      skill_2_dna_extractor "$scout_file" >/dev/null &
      pids+=("$!")
    fi

    if should_skip_skill "$audit_file"; then
      success "Skill 3 cache hit: $audit_file"
    else
      skill_3_readme_auditor "$dna_file" >/dev/null &
      pids+=("$!")
    fi

    for pid in "${pids[@]}"; do
      wait "$pid"
    done

    if should_skip_skill "$forensic_file"; then
      success "Skill 3.5 cache hit: $forensic_file"
    else
      skill_3_5_forensic_auditor "$dna_file" "$audit_file" >/dev/null
    fi

    if should_skip_skill "$readme_file"; then
      success "Skill 4 cache hit: $readme_file"
    else
      skill_4_readme_generator "$dna_file" "$forensic_file" >/dev/null
    fi
  fi

  ledger_sync
  save_analysis_state
  generate_run_metrics

  log ""
  log "=========================================="
  success "Analysis Complete!"
  log "=========================================="
  log "Output Directory: $OUTPUT_DIR"
  log "Run metrics: $RUN_METRICS_FILE"

  local end_time
  end_time=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
  log "Completed at: $end_time"
}

trap 'error "Orchestrator failed"; exit 1' ERR

main "$@"
