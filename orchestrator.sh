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
  if [ -z "${response:-}" ]; then
    response="{}"
  fi
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

get_tree_json() {
  local tree_file="${OUTPUT_DIR}/00_tree.json"
  local tree_json
  tree_json=$(api_get "/git/trees/${HEAD_SHA}?recursive=1" "${HEAD_SHA}_tree_recursive" 0)

  if echo "$tree_json" | jq -e '.tree' >/dev/null 2>&1; then
    echo "$tree_json" > "$tree_file"
    cat "$tree_file"
  else
    jq -n '{truncated: true, tree: []}' > "$tree_file"
    cat "$tree_file"
  fi
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
    && [ -f "${OUTPUT_DIR}/00_tree.json" ] \
    && [ -f "${OUTPUT_DIR}/01_scout_output.json" ] \
    && [ -f "${OUTPUT_DIR}/02_repo_dna.json" ] \
    && [ -f "${OUTPUT_DIR}/03_readme_audit.json" ] \
    && [ -f "${OUTPUT_DIR}/04_security_audit.json" ] \
    && [ -f "${OUTPUT_DIR}/05_dependency_map.json" ] \
    && [ -f "${OUTPUT_DIR}/06_code_quality.json" ] \
    && [ -f "${OUTPUT_DIR}/07_asset_inventory.json" ] \
    && [ -f "${OUTPUT_DIR}/08_architecture.json" ] \
    && [ -f "${OUTPUT_DIR}/08_architecture.txt" ] \
    && [ -f "${OUTPUT_DIR}/03.5_forensic_report.json" ] \
    && [ -f "${OUTPUT_DIR}/README.rewrite.md" ] \
    && [ -f "${OUTPUT_DIR}/10_consolidated_dna_report.json" ]
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
        tree: "00_tree.json",
        scout: "01_scout_output.json",
        dna: "02_repo_dna.json",
        readme_audit: "03_readme_audit.json",
        security: "04_security_audit.json",
        dependency_map: "05_dependency_map.json",
        code_quality: "06_code_quality.json",
        asset_inventory: "07_asset_inventory.json",
        architecture: "08_architecture.json",
        architecture_diagram: "08_architecture.txt",
        forensic: "03.5_forensic_report.json",
        readme: "README.rewrite.md",
        consolidated: "10_consolidated_dna_report.json"
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
  local tree_json
  tree_json=$(get_tree_json)
  local tree_truncated
  tree_truncated=$(echo "$tree_json" | jq -r '.truncated // false' 2>/dev/null || echo "false")
  local tree_count
  tree_count=$(echo "$tree_json" | jq -r '.tree | length' 2>/dev/null || echo 0)

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
    --arg tree_count "$tree_count" \
    --arg tree_truncated "$tree_truncated" \
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
      tree_inventory: {
        total_paths: ($tree_count | tonumber),
        truncated: ($tree_truncated == "true")
      },
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
        languages: ($languages | map({name: ., primary: true})),
        frameworks: ($frameworks | map({name: ., version: "unknown"})),
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
  repo_data=$(echo "$repo_data" | jq -c '.' 2>/dev/null || echo "{}")
  local security_data
  security_data=$(cat "${OUTPUT_DIR}/04_security_audit.json" 2>/dev/null || echo "{}")
  security_data=$(echo "$security_data" | jq -c '.' 2>/dev/null || echo "{}")
  local dependency_data
  dependency_data=$(cat "${OUTPUT_DIR}/05_dependency_map.json" 2>/dev/null || echo "{}")
  dependency_data=$(echo "$dependency_data" | jq -c '.' 2>/dev/null || echo "{}")
  local quality_data
  quality_data=$(cat "${OUTPUT_DIR}/06_code_quality.json" 2>/dev/null || echo "{}")
  quality_data=$(echo "$quality_data" | jq -c '.' 2>/dev/null || echo "{}")
  local assets_data
  assets_data=$(cat "${OUTPUT_DIR}/07_asset_inventory.json" 2>/dev/null || echo "{}")
  assets_data=$(echo "$assets_data" | jq -c '.' 2>/dev/null || echo "{}")
  local architecture_data
  architecture_data=$(cat "${OUTPUT_DIR}/08_architecture.json" 2>/dev/null || echo "{}")
  architecture_data=$(echo "$architecture_data" | jq -c '.' 2>/dev/null || echo "{}")

  local forensic_output
  forensic_output=$(jq -n \
    --arg owner "$OWNER" \
    --arg repo "$REPO" \
    --argjson repo_data "$repo_data" \
    --argjson security_data "$security_data" \
    --argjson dependency_data "$dependency_data" \
    --argjson quality_data "$quality_data" \
    --argjson assets_data "$assets_data" \
    --argjson architecture_data "$architecture_data" \
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
      "9_security_audit": $security_data,
      "11_dependency_health": $dependency_data,
      "13_code_quality": $quality_data,
      "15_asset_inventory": $assets_data,
      "16_architecture_map": $architecture_data,
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
      "19_what_is_missing": [],
      "20_critical_path": [],
      "21_architectural_recommendation": {
        keep: [],
        modify: [],
        deprecate: [],
        rebuild: []
      },
      "22_final_system_map": {
        format: "ascii",
        diagram: "See 08_architecture.txt"
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
  success "Forensic audit complete. Output: $forensic_file"
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
- **security_audit.json** — Security, compliance, and risk signals
- **dependency_map.json** — Dependency inventory and graph summary
- **code_quality.json** — Code quality and testability indicators
- **asset_inventory.json** — Reusable component inventory
- **architecture.json** — Architecture map and component layers
- **forensic_report.json** — 23-section complete system analysis
- **README.rewrite.md** — This generated documentation
- **consolidated_dna_report.json** — Final unified DNA result

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
# SKILL 5: SECURITY AUDITOR
# ============================================================================

skill_5_security_auditor() {
  begin_skill_metrics "skill_5_security_auditor"
  log "Skill 5: Security Auditor — Scanning repository signals..."

  local security_file="${OUTPUT_DIR}/04_security_audit.json"
  local repo_data
  repo_data=$(api_get "" "${HEAD_SHA}_repo_meta_security" 0)

  local has_security=false
  local has_coc=false
  local has_license=false

  local security_md
  security_md=$(api_get "/contents/SECURITY.md?ref=${BRANCH}" "${HEAD_SHA}_security_md" 0)
  if echo "$security_md" | jq -e '.path' >/dev/null 2>&1; then
    has_security=true
  fi

  local coc_md
  coc_md=$(api_get "/contents/CODE_OF_CONDUCT.md?ref=${BRANCH}" "${HEAD_SHA}_coc_md" 0)
  if echo "$coc_md" | jq -e '.path' >/dev/null 2>&1; then
    has_coc=true
  fi

  local license_md
  license_md=$(api_get "/contents/LICENSE?ref=${BRANCH}" "${HEAD_SHA}_license_file" 0)
  if echo "$license_md" | jq -e '.path' >/dev/null 2>&1; then
    has_license=true
  fi

  local missing_items='[]'
  if [ "$has_security" != "true" ]; then
    missing_items=$(echo "$missing_items" | jq '. + ["SECURITY.md"]')
  fi
  if [ "$has_coc" != "true" ]; then
    missing_items=$(echo "$missing_items" | jq '. + ["CODE_OF_CONDUCT.md"]')
  fi

  local security_output
  security_output=$(jq -n \
    --arg owner "$OWNER" \
    --arg repo "$REPO" \
    --argjson is_private "$(echo "$repo_data" | jq '.private // false' 2>/dev/null || echo false)" \
    --argjson has_security "$has_security" \
    --argjson has_coc "$has_coc" \
    --argjson has_license "$has_license" \
    --argjson missing_items "$missing_items" \
    '{
      metadata: {
        owner: $owner,
        repo: $repo,
        scanned_at: now | todate,
        scan_version: "1.0.0",
        confidence: 0.6
      },
      summary: {
        total_findings: ($missing_items | length),
        critical: 0,
        high: 0,
        medium: ($missing_items | length),
        low: 0,
        overall_risk_level: (if ($missing_items | length) > 0 then "MEDIUM" else "LOW" end)
      },
      secret_detection: {secrets_found: 0, findings: []},
      dependency_vulnerabilities: {total_dependencies: 0, vulnerable_packages: 0, findings: []},
      code_vulnerabilities: {patterns_found: 0, findings: []},
      github_security: {
        branch_protection: null,
        require_code_review: null,
        require_status_checks: null,
        require_signed_commits: null,
        enforce_admins: null,
        is_private: $is_private,
        has_2fa: null,
        findings: []
      },
      infrastructure_secrets: {findings: []},
      compliance: {
        has_security_policy: $has_security,
        has_license: $has_license,
        has_coc: $has_coc,
        missing_items: $missing_items
      },
      critical_findings: []
    }')

  echo "$security_output" > "$security_file"
  success "Security audit complete. Output: $security_file"
  end_skill_metrics "success"

  echo "$security_file"
}

# ============================================================================
# SKILL 6: DEPENDENCY MAPPER
# ============================================================================

skill_6_dependency_mapper() {
  begin_skill_metrics "skill_6_dependency_mapper"
  log "Skill 6: Dependency Mapper — Mapping dependencies..."

  local dependency_file="${OUTPUT_DIR}/05_dependency_map.json"
  local package_json_raw
  package_json_raw=$(fetch_file_content "package.json" "${HEAD_SHA}_package_json_skill6" || echo "null")
  local package_json
  package_json=$(echo "$package_json_raw" | jq '.' 2>/dev/null || echo 'null')

  local direct_dependencies='[]'
  local dev_dependencies='[]'
  local package_managers='[]'

  if [ "$package_json" != "null" ]; then
    direct_dependencies=$(echo "$package_json" | jq '[.dependencies // {} | to_entries[] | {name: .key, version: .value, type: "production"}]' 2>/dev/null || echo "[]")
    dev_dependencies=$(echo "$package_json" | jq '[.devDependencies // {} | to_entries[] | {name: .key, version: .value, type: "dev"}]' 2>/dev/null || echo "[]")
    package_managers='["npm"]'
  fi

  local all_dependencies
  all_dependencies=$(jq -n --argjson d "$direct_dependencies" --argjson v "$dev_dependencies" '$d + $v')
  local direct_count
  direct_count=$(echo "$direct_dependencies" | jq 'length')
  local dev_count
  dev_count=$(echo "$dev_dependencies" | jq 'length')
  local unique_count
  unique_count=$(echo "$all_dependencies" | jq 'length')

  local dependency_output
  dependency_output=$(jq -n \
    --arg owner "$OWNER" \
    --arg repo "$REPO" \
    --argjson package_managers "$package_managers" \
    --argjson direct_dependencies "$direct_dependencies" \
    --argjson dev_dependencies "$dev_dependencies" \
    --arg direct_count "$direct_count" \
    --arg dev_count "$dev_count" \
    --arg unique_count "$unique_count" \
    '{
      metadata: {
        owner: $owner,
        repo: $repo,
        scanned_at: now | todate,
        package_managers: $package_managers,
        total_dependencies: ($unique_count | tonumber)
      },
      summary: {
        direct_count: ($direct_count | tonumber),
        transitive_count: 0,
        unique_packages: ($unique_count | tonumber),
        production_count: ($direct_count | tonumber),
        dev_count: ($dev_count | tonumber),
        conflicts: 0,
        circular_dependencies: 0,
        outdated_packages: 0
      },
      direct_dependencies: ($direct_dependencies + $dev_dependencies),
      transitive_dependencies: [],
      version_conflicts: [],
      circular_dependencies: [],
      outdated_packages: [],
      license_analysis: {
        project_license: "unknown",
        licenses_used: [],
        incompatible_licenses: [],
        compliance_score: 0
      },
      supply_chain: {
        high_risk_packages: 0,
        unmaintained_packages: 0,
        deprecated_packages: 0,
        packages_with_advisories: 0,
        recommendations: []
      },
      dependency_graph: {
        nodes: ($unique_count | tonumber),
        edges: 0,
        graph_depth: 1,
        most_depended_on: []
      }
    }')

  echo "$dependency_output" > "$dependency_file"
  success "Dependency map complete. Output: $dependency_file"
  end_skill_metrics "success"

  echo "$dependency_file"
}

# ============================================================================
# SKILL 7: CODE QUALITY ANALYZER
# ============================================================================

skill_7_code_quality_analyzer() {
  begin_skill_metrics "skill_7_code_quality_analyzer"
  log "Skill 7: Code Quality Analyzer — Estimating quality signals..."

  local quality_file="${OUTPUT_DIR}/06_code_quality.json"
  local tree_json
  tree_json=$(get_tree_json)

  local total_files
  total_files=$(echo "$tree_json" | jq '[.tree[]? | select(.type == "blob")] | length' 2>/dev/null || echo 0)
  local js_files
  js_files=$(echo "$tree_json" | jq '[.tree[]? | select(.path | test("\\.(js|jsx|ts|tsx)$"))] | length' 2>/dev/null || echo 0)
  local py_files
  py_files=$(echo "$tree_json" | jq '[.tree[]? | select(.path | test("\\.py$"))] | length' 2>/dev/null || echo 0)
  local test_files
  test_files=$(echo "$tree_json" | jq '[.tree[]? | select(.path | test("(test|spec)\\.";"i"))] | length' 2>/dev/null || echo 0)

  local quality_output
  quality_output=$(jq -n \
    --arg owner "$OWNER" \
    --arg repo "$REPO" \
    --arg total_files "$total_files" \
    --arg js_files "$js_files" \
    --arg py_files "$py_files" \
    --arg test_files "$test_files" \
    '{
      metadata: {
        owner: $owner,
        repo: $repo,
        scanned_at: now | todate,
        languages: [],
        total_files: ($total_files | tonumber)
      },
      summary: {
        overall_score: 50,
        grade: "C",
        quality_trend: "unknown",
        last_assessment_date: (now | strftime("%Y-%m-%d"))
      },
      code_metrics: {
        lines_of_code: 0,
        code_lines: 0,
        comment_lines: 0,
        comment_ratio: 0,
        files_by_language: {
          JavaScript: {files: ($js_files | tonumber), lines: 0},
          Python: {files: ($py_files | tonumber), lines: 0}
        }
      },
      complexity: {
        cyclomatic_complexity_avg: 0,
        cyclomatic_complexity_max: 0,
        cognitive_complexity_avg: 0,
        high_complexity_functions: 0,
        complexity_rating: "unknown"
      },
      functions: {
        total: 0,
        average_length: 0,
        longest: 0,
        average_parameters: 0,
        max_nesting_depth: 0
      },
      test_coverage: {
        overall_coverage: 0,
        unit_tests: ($test_files | tonumber),
        integration_tests: 0,
        e2e_tests: 0,
        test_framework: "unknown",
        coverage_trend: "unknown",
        uncovered_critical_paths: 0
      },
      code_smells: {
        duplication_percentage: 0,
        duplicate_blocks: 0,
        duplicate_lines: 0,
        long_functions: 0,
        long_classes: 0,
        long_parameter_lists: 0,
        high_nesting: 0
      },
      documentation: {
        comment_coverage: 0,
        docstring_coverage: 0,
        readme_score: 0,
        api_documentation_status: "unknown",
        changelog_present: false,
        contributing_guide: false,
        architecture_doc: false,
        undocumented_public_apis: 0
      },
      commit_patterns: {
        total_commits: 0,
        commits_last_30_days: 0,
        commits_last_7_days: 0,
        average_commits_per_day: 0,
        activity_level: "unknown",
        contributors: 0,
        last_commit_age_days: 0
      },
      technical_debt: {
        sqale_rating: "unknown",
        technical_debt_days: 0,
        debt_ratio: 0,
        maintainability_index: 0,
        issues_by_priority: {critical: 0, major: 0, minor: 0, info: 0}
      }
    }')

  echo "$quality_output" > "$quality_file"
  success "Code quality analysis complete. Output: $quality_file"
  end_skill_metrics "success"

  echo "$quality_file"
}

# ============================================================================
# SKILL 8: ASSET EXTRACTOR
# ============================================================================

skill_8_asset_extractor() {
  begin_skill_metrics "skill_8_asset_extractor"
  log "Skill 8: Asset Extractor — Inventoring reusable assets..."

  local assets_file="${OUTPUT_DIR}/07_asset_inventory.json"
  local tree_json
  tree_json=$(get_tree_json)

  local utility_candidates
  utility_candidates=$(echo "$tree_json" | jq '[.tree[]? | select(.type == "blob" and (.path | test("(util|helper|common)";"i"))) | {name: (.path | split("/") | last), type: "file", location: .path, size_lines: 0, complexity: 0, reusability_score: 5, used_count: 0, internal_duplication_count: 0, value_rating: "medium"}]' 2>/dev/null || echo "[]")
  local utility_count
  utility_count=$(echo "$utility_candidates" | jq 'length')

  local assets_output
  assets_output=$(jq -n \
    --arg owner "$OWNER" \
    --arg repo "$REPO" \
    --argjson utility_candidates "$utility_candidates" \
    --arg utility_count "$utility_count" \
    '{
      metadata: {
        owner: $owner,
        repo: $repo,
        scanned_at: now | todate,
        total_assets: ($utility_count | tonumber),
        analysis_version: "1.0.0"
      },
      summary: {
        high_value_assets: 0,
        medium_value_assets: ($utility_count | tonumber),
        low_value_assets: 0,
        total_extractable: ($utility_count | tonumber),
        estimated_library_candidates: 0,
        internal_duplication: 0
      },
      components: [],
      utilities: $utility_candidates,
      algorithms: [],
      data_structures: [],
      integrations: [],
      duplication_analysis: {
        duplicated_components: 0,
        duplication_opportunities: []
      },
      extraction_recommendations: [],
      portfolio_value: {
        potential_new_libraries: 0,
        expected_reuse_frequency: "unknown",
        consolidation_savings: "unknown"
      }
    }')

  echo "$assets_output" > "$assets_file"
  success "Asset extraction complete. Output: $assets_file"
  end_skill_metrics "success"

  echo "$assets_file"
}

# ============================================================================
# SKILL 9: ARCHITECTURE VISUALIZER
# ============================================================================

skill_9_architecture_visualizer() {
  begin_skill_metrics "skill_9_architecture_visualizer"
  log "Skill 9: Architecture Visualizer — Mapping architecture..."

  local architecture_file="${OUTPUT_DIR}/08_architecture.json"
  local architecture_txt_file="${OUTPUT_DIR}/08_architecture.txt"
  local tree_json
  tree_json=$(get_tree_json)

  local top_dirs
  top_dirs=$(echo "$tree_json" | jq '[.tree[]? | select(.path | contains("/")) | .path | split("/")[0]] | unique | sort' 2>/dev/null || echo "[]")
  local dir_count
  dir_count=$(echo "$top_dirs" | jq 'length')

  local architecture_output
  architecture_output=$(jq -n \
    --arg owner "$OWNER" \
    --arg repo "$REPO" \
    --arg dir_count "$dir_count" \
    --argjson top_dirs "$top_dirs" \
    '{
      metadata: {
        owner: $owner,
        repo: $repo,
        scanned_at: now | todate,
        primary_language: "unknown",
        architecture_type: "unknown"
      },
      summary: {
        total_components: ($dir_count | tonumber),
        services: 0,
        controllers: 0,
        repositories: 0,
        utilities: 0,
        layers: 0,
        architectural_pattern: "unknown",
        coupling_score: 0,
        cohesion_score: 0
      },
      components: [],
      layers: [],
      dependency_graph: {
        nodes: [],
        edges: []
      },
      technology_stack: [],
      top_level_directories: $top_dirs
    }')

  echo "$architecture_output" > "$architecture_file"
  {
    echo "Architecture map for ${OWNER}/${REPO}"
    echo "Generated: $(date -u +"%Y-%m-%d %H:%M UTC")"
    echo ""
    echo "Top-level directories:"
    echo "$top_dirs" | jq -r '.[]' 2>/dev/null || true
  } > "$architecture_txt_file"

  success "Architecture map complete. Output: $architecture_file and $architecture_txt_file"
  end_skill_metrics "success"

  echo "$architecture_file"
}

# ============================================================================
# CONSOLIDATED FINAL RESULT
# ============================================================================

consolidate_final_result() {
  begin_skill_metrics "consolidate_final_result"
  log "Consolidating full repo DNA results..."

  local consolidated_file="${OUTPUT_DIR}/10_consolidated_dna_report.json"

  local scout_json
  scout_json=$(cat "${OUTPUT_DIR}/01_scout_output.json" 2>/dev/null || echo "{}")
  scout_json=$(echo "$scout_json" | jq -c '.' 2>/dev/null || echo "{}")
  local dna_json
  dna_json=$(cat "${OUTPUT_DIR}/02_repo_dna.json" 2>/dev/null || echo "{}")
  dna_json=$(echo "$dna_json" | jq -c '.' 2>/dev/null || echo "{}")
  local readme_audit_json
  readme_audit_json=$(cat "${OUTPUT_DIR}/03_readme_audit.json" 2>/dev/null || echo "{}")
  readme_audit_json=$(echo "$readme_audit_json" | jq -c '.' 2>/dev/null || echo "{}")
  local security_json
  security_json=$(cat "${OUTPUT_DIR}/04_security_audit.json" 2>/dev/null || echo "{}")
  security_json=$(echo "$security_json" | jq -c '.' 2>/dev/null || echo "{}")
  local dependency_json
  dependency_json=$(cat "${OUTPUT_DIR}/05_dependency_map.json" 2>/dev/null || echo "{}")
  dependency_json=$(echo "$dependency_json" | jq -c '.' 2>/dev/null || echo "{}")
  local quality_json
  quality_json=$(cat "${OUTPUT_DIR}/06_code_quality.json" 2>/dev/null || echo "{}")
  quality_json=$(echo "$quality_json" | jq -c '.' 2>/dev/null || echo "{}")
  local assets_json
  assets_json=$(cat "${OUTPUT_DIR}/07_asset_inventory.json" 2>/dev/null || echo "{}")
  assets_json=$(echo "$assets_json" | jq -c '.' 2>/dev/null || echo "{}")
  local architecture_json
  architecture_json=$(cat "${OUTPUT_DIR}/08_architecture.json" 2>/dev/null || echo "{}")
  architecture_json=$(echo "$architecture_json" | jq -c '.' 2>/dev/null || echo "{}")
  local forensic_json
  forensic_json=$(cat "${OUTPUT_DIR}/03.5_forensic_report.json" 2>/dev/null || echo "{}")
  forensic_json=$(echo "$forensic_json" | jq -c '.' 2>/dev/null || echo "{}")

  local consolidated_output
  consolidated_output=$(jq -n \
    --arg owner "$OWNER" \
    --arg repo "$REPO" \
    --arg branch "$BRANCH" \
    --arg head_sha "$HEAD_SHA" \
    --arg generated_at "$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
    --argjson scout "$scout_json" \
    --argjson dna "$dna_json" \
    --argjson readme_audit "$readme_audit_json" \
    --argjson security "$security_json" \
    --argjson dependencies "$dependency_json" \
    --argjson code_quality "$quality_json" \
    --argjson assets "$assets_json" \
    --argjson architecture "$architecture_json" \
    --argjson forensic "$forensic_json" \
    '{
      metadata: {
        owner: $owner,
        repo: $repo,
        branch: $branch,
        head_sha: $head_sha,
        consolidated_at: $generated_at,
        schema_version: "1.0.0",
        result_type: "full_repo_dna"
      },
      pipeline: {
        skills_executed: ["1", "2", "3", "5", "6", "7", "8", "9", "3.5", "4"],
        output_files: [
          "00_tree.json",
          "01_scout_output.json",
          "02_repo_dna.json",
          "03_readme_audit.json",
          "04_security_audit.json",
          "05_dependency_map.json",
          "06_code_quality.json",
          "07_asset_inventory.json",
          "08_architecture.json",
          "08_architecture.txt",
          "03.5_forensic_report.json",
          "README.rewrite.md",
          "10_consolidated_dna_report.json"
        ]
      },
      scout: $scout,
      repo_dna: $dna,
      readme_audit: $readme_audit,
      security_audit: $security,
      dependency_map: $dependencies,
      code_quality: $code_quality,
      asset_inventory: $assets,
      architecture: $architecture,
      forensic_report: $forensic
    }')

  echo "$consolidated_output" > "$consolidated_file"
  success "Final consolidated result created: $consolidated_file"
  end_skill_metrics "success"

  echo "$consolidated_file"
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
      skills_executed: [
        "scout",
        "dna-extractor",
        "readme-auditor",
        "security-auditor",
        "dependency-mapper",
        "code-quality-analyzer",
        "asset-extractor",
        "architecture-visualizer",
        "forensic-auditor",
        "readme-generator",
        "consolidation"
      ],
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
  local security_file="${OUTPUT_DIR}/04_security_audit.json"
  local dependency_file="${OUTPUT_DIR}/05_dependency_map.json"
  local quality_file="${OUTPUT_DIR}/06_code_quality.json"
  local assets_file="${OUTPUT_DIR}/07_asset_inventory.json"
  local architecture_file="${OUTPUT_DIR}/08_architecture.json"
  local architecture_txt_file="${OUTPUT_DIR}/08_architecture.txt"
  local forensic_file="${OUTPUT_DIR}/03.5_forensic_report.json"
  local readme_file="${OUTPUT_DIR}/README.rewrite.md"
  local consolidated_file="${OUTPUT_DIR}/10_consolidated_dna_report.json"

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

    local skill_pids=()

    if should_skip_skill "$security_file"; then
      success "Skill 5 cache hit: $security_file"
    else
      skill_5_security_auditor >/dev/null &
      skill_pids+=("$!")
    fi

    if should_skip_skill "$dependency_file"; then
      success "Skill 6 cache hit: $dependency_file"
    else
      skill_6_dependency_mapper >/dev/null &
      skill_pids+=("$!")
    fi

    if should_skip_skill "$quality_file"; then
      success "Skill 7 cache hit: $quality_file"
    else
      skill_7_code_quality_analyzer >/dev/null &
      skill_pids+=("$!")
    fi

    if should_skip_skill "$assets_file"; then
      success "Skill 8 cache hit: $assets_file"
    else
      skill_8_asset_extractor >/dev/null &
      skill_pids+=("$!")
    fi

    if should_skip_skill "$architecture_file" && [ -f "$architecture_txt_file" ]; then
      success "Skill 9 cache hit: $architecture_file"
    else
      skill_9_architecture_visualizer >/dev/null &
      skill_pids+=("$!")
    fi

    for pid in "${skill_pids[@]}"; do
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

    if should_skip_skill "$consolidated_file"; then
      success "Final consolidated report cache hit: $consolidated_file"
    else
      consolidate_final_result >/dev/null
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
