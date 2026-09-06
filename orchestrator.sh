#!/bin/bash
# ============================================================================
# REPO DNA SYSTEM — MASTER ORCHESTRATOR v2
# ============================================================================
# Pipeline:
#   1 scout → 2 extractor → 3 README auditor
#     → 5 security → 6 deps → 7 quality → 8 assets → 9 architecture
#     → 3.5 forensic (23 sections) → 4 README.rewrite.md
#
# Usage: ./orchestrator.sh <owner> <repo> [branch]
#
# Outputs stay in dna-extracts/{owner}/{repo}/output/
# Never writes live README.md. Never auto-pushes. Never promotes to Brain.
#
# Termux: curl + jq. python3 used only for forensic 3.5 + README 4.
# ============================================================================

set -euo pipefail

OWNER="${1:?Usage: ./orchestrator.sh <owner> <repo> [branch]}"
REPO="${2:?Usage: ./orchestrator.sh <owner> <repo> [branch]}"
BRANCH="${3:-main}"
TOKEN="${GITHUB_TOKEN:?GITHUB_TOKEN environment variable not set}"

WORK_DIR="${PWD}/dna-extracts/${OWNER}/${REPO}"
OUTPUT_DIR="${WORK_DIR}/output"
LOGS_DIR="${WORK_DIR}/logs"
API="https://api.github.com/repos/${OWNER}/${REPO}"
AUTH_HEADER="Authorization: token ${TOKEN}"
ACCEPT_HEADER="Accept: application/vnd.github+json"
UA_HEADER="User-Agent: repo-dna-orchestrator"

START_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
START_EPOCH=$(date +%s)

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'

log()     { echo -e "${BLUE}[$(date +'%H:%M:%S')]${NC} $1"; }
success() { echo -e "${GREEN}✓${NC} $1"; }
error()   { echo -e "${RED}✗${NC} $1" >&2; }
warn()    { echo -e "${YELLOW}⚠${NC} $1"; }

gh_get() {
  curl -sS -H "$AUTH_HEADER" -H "$ACCEPT_HEADER" -H "$UA_HEADER" "$1"
}

# Decoded file text. Empty on miss. Never prints the path as a secret value.
fetch_text() {
  local path="$1"
  local raw
  raw=$(curl -sS -H "$AUTH_HEADER" -H "Accept: application/vnd.github.raw" -H "$UA_HEADER" \
    "$API/contents/${path}?ref=${BRANCH}") || true
  if echo "$raw" | jq -e '.message' >/dev/null 2>&1; then
    echo ""
    return 0
  fi
  printf '%s' "$raw"
}

json_file() { echo "${OUTPUT_DIR}/$1"; }

setup_directories() {
  mkdir -p "$OUTPUT_DIR" "$LOGS_DIR"
  success "Directories ready at $WORK_DIR"
}

# ============================================================================
# SKILL 1 — Repo Scout (+ one recursive tree cache)
# ============================================================================
skill_1_repo_scout() {
  log "Skill 1: Repo Scout"
  local scout; scout=$(json_file "01_scout_output.json")
  local tree; tree=$(json_file "00_tree.json")

  local repo_meta default_branch
  repo_meta=$(gh_get "$API" || echo "{}")
  default_branch=$(echo "$repo_meta" | jq -r '.default_branch // "main"')

  local tree_json
  tree_json=$(gh_get "$API/git/trees/${BRANCH}?recursive=1" || echo "{}")
  echo "$tree_json" > "$tree"

  local truncated
  truncated=$(echo "$tree_json" | jq -r '.truncated // false')
  if [ "$truncated" = "true" ]; then
    warn "Tree truncated. Not a small repo. Skill 18 recovers with path_filter — not auto-run."
  fi

  local root_files workflows
  root_files=$(echo "$tree_json" | jq '[.tree[]? | select(.path | contains("/") | not) | {name:.path, type:(if .type=="tree" then "dir" else "file" end), size:(.size // 0)}]' 2>/dev/null || echo "[]")
  workflows=$(echo "$tree_json" | jq '[.tree[]? | select(.path | startswith(".github/workflows/") and (.path | test("\\\\.(yml|yaml)$"))) | .path]' 2>/dev/null || echo "[]")

  local evidence='{}'
  local f
  for f in package.json package-lock.json yarn.lock pnpm-lock.yaml requirements.txt pyproject.toml Pipfile Cargo.toml go.mod composer.json pom.xml Dockerfile docker-compose.yml .env.example README.md LICENSE LICENSE.md tsconfig.json vite.config.ts next.config.js next.config.mjs vercel.json netlify.toml; do
    if echo "$tree_json" | jq -e --arg p "$f" '.tree[]? | select(.path==$p)' >/dev/null 2>&1; then
      evidence=$(echo "$evidence" | jq --arg k "$f" --arg v "$f" '.[$k]=$v')
    fi
  done

  jq -n \
    --arg owner "$OWNER" --arg repo "$REPO" --arg branch "$BRANCH" \
    --arg default_branch "$default_branch" \
    --argjson root "$root_files" --argjson evidence "$evidence" --argjson workflows "$workflows" \
    --argjson truncated "$( [ "$truncated" = "true" ] && echo true || echo false )" \
    --argjson private "$(echo "$repo_meta" | jq '.private // false')" \
    --arg desc "$(echo "$repo_meta" | jq -r '.description // ""')" \
    --arg lang "$(echo "$repo_meta" | jq -r '.language // "unknown"')" \
    --argjson size "$(echo "$repo_meta" | jq '.size // 0')" \
    '{
      owner:$owner, repo:$repo, scanned_branch:$branch, default_branch:$default_branch,
      description:$desc, language:$lang, size_kb:$size, private:$private,
      truncated:$truncated,
      file_inventory:{root_files:$root},
      evidence_files:{primary:$evidence, workflows:$workflows},
      timestamp:now|todate,
      scout_status:(if $truncated then "truncated" else "success" end)
    }' > "$scout"

  success "Scout → $scout"
}

# ============================================================================
# SKILL 2 — DNA Extractor (schema 1.1.0, fail-closed)
# ============================================================================
skill_2_dna_extractor() {
  log "Skill 2: DNA Extractor"
  local dna; dna=$(json_file "02_repo_dna.json")
  local tree; tree=$(json_file "00_tree.json")
  local scout; scout=$(json_file "01_scout_output.json")

  local pkg="null"
  if jq -e '.tree[]? | select(.path=="package.json")' "$tree" >/dev/null 2>&1; then
    pkg=$(fetch_text "package.json" | jq '.' 2>/dev/null || echo "null")
  fi

  local runtime="unknown"
  local languages='[]'
  local frameworks='[]'
  local pkg_managers='[]'
  local evidence_paths='[]'

  evidence_paths=$(jq -c '[.evidence_files.primary | to_entries[] | .value]' "$scout" 2>/dev/null || echo '[]')

  if [ "$pkg" != "null" ]; then
    runtime="nodejs"
    languages='[{"name":"JavaScript","primary":true,"evidence":"package.json"}]'
    if jq -e '.tree[]? | select(.path | endswith(".ts") or endswith(".tsx"))' "$tree" >/dev/null 2>&1; then
      languages='[{"name":"TypeScript","primary":true,"evidence":"*.ts"},{"name":"JavaScript","primary":false,"evidence":"package.json"}]'
    fi
    frameworks=$(echo "$pkg" | jq '[((.dependencies // {}) + (.devDependencies // {})) | keys[] | {name:., evidence:"package.json"}]' 2>/dev/null || echo '[]')
    pkg_managers='["npm"]'
    if jq -e '.tree[]? | select(.path=="pnpm-lock.yaml")' "$tree" >/dev/null 2>&1; then pkg_managers='["pnpm"]'; fi
    if jq -e '.tree[]? | select(.path=="yarn.lock")' "$tree" >/dev/null 2>&1; then pkg_managers='["yarn"]'; fi
  elif jq -e '.tree[]? | select(.path=="requirements.txt" or .path=="pyproject.toml")' "$tree" >/dev/null 2>&1; then
    runtime="python"
    languages='[{"name":"Python","primary":true,"evidence":"requirements.txt|pyproject.toml"}]'
    pkg_managers='["pip"]'
  elif jq -e '.tree[]? | select(.path=="go.mod")' "$tree" >/dev/null 2>&1; then
    runtime="go"
    languages='[{"name":"Go","primary":true,"evidence":"go.mod"}]'
    pkg_managers='["go"]'
  elif jq -e '.tree[]? | select(.path=="Cargo.toml")' "$tree" >/dev/null 2>&1; then
    runtime="rust"
    languages='[{"name":"Rust","primary":true,"evidence":"Cargo.toml"}]'
    pkg_managers='["cargo"]'
  fi

  local purpose="unknown"
  if jq -e '.tree[]? | select(.path|test("^(apps|packages|workspaces)/"))' "$tree" >/dev/null 2>&1; then purpose="monorepo"; fi
  if jq -e '.tree[]? | select(.path=="src/routes/index.tsx" or .path=="src/app/page.tsx")' "$tree" >/dev/null 2>&1; then purpose="app"; fi

  local gaps='[]'
  if jq -e '.truncated==true' "$scout" >/dev/null 2>&1; then
    gaps=$(echo "$gaps" | jq '. + [{"category":"tree","issue":"GitHub tree truncated","severity":"warning"}]')
  fi
  if ! jq -e '.tree[]? | select(.path=="README.md" or .path=="README")' "$tree" >/dev/null 2>&1; then
    gaps=$(echo "$gaps" | jq '. + [{"category":"docs","issue":"No README.md in tree","severity":"warning"}]')
  fi

  jq -n \
    --arg owner "$OWNER" --arg repo "$REPO" --arg branch "$BRANCH" \
    --argjson languages "$languages" --argjson frameworks "$frameworks" \
    --arg runtime "$runtime" --argjson pm "$pkg_managers" \
    --argjson evidence "$evidence_paths" --arg purpose "$purpose" \
    --argjson gaps "$gaps" \
    --arg desc "$(jq -r '.description // ""' "$scout")" \
    '{
      metadata: {
        owner:$owner, repo:$repo,
        url:("https://github.com/"+$owner+"/"+$repo),
        extracted_at: now|todate,
        schema_version: "1.1.0",
        default_branch:$branch,
        evidence_paths:$evidence,
        confidence: (if ($evidence|length)>0 then 0.72 else 0.40 end)
      },
      tech_stack: {
        languages:$languages,
        frameworks: ($frameworks | .[0:40]),
        runtime: {type:$runtime, evidence: ($evidence[0] // "tree")},
        package_managers:$pm,
        databases: []
      },
      project_info: {
        name:$repo,
        description:$desc,
        purpose:$purpose,
        maturity: "unknown",
        license: null,
        readme_status: "unknown"
      },
      architecture: {
        entry_points: [],
        core_modules: [],
        structure: "unknown",
        dependencies: {internal:[], external:[]}
      },
      gaps: $gaps
    }' > "$dna"

  success "DNA → $dna"
}

# ============================================================================
# SKILL 3 — README Auditor
# ============================================================================
skill_3_readme_auditor() {
  log "Skill 3: README Auditor"
  local audit; audit=$(json_file "03_readme_audit.json")
  local tree; tree=$(json_file "00_tree.json")
  local status="missing"
  local readme=""

  if jq -e '.tree[]? | select(.path=="README.md")' "$tree" >/dev/null 2>&1; then
    readme=$(fetch_text "README.md")
  fi

  local sections
  sections='{"overview":false,"setup":false,"run":false,"test":false,"api":false,"deployment":false,"environment":false}'

  if [ -n "$readme" ]; then
    status="good"
    local has_setup has_run has_test has_deploy has_overview
    has_overview=$(printf '%s' "$readme" | grep -ciE 'overview|about|introduction' || true)
    has_setup=$(printf '%s' "$readme" | grep -ciE 'setup|installation|prerequisites' || true)
    has_run=$(printf '%s' "$readme" | grep -ciE 'usage|quick start|getting started|^## run' || true)
    has_test=$(printf '%s' "$readme" | grep -ciE 'test|testing' || true)
    has_deploy=$(printf '%s' "$readme" | grep -ciE 'deploy|production|vercel|netlify' || true)
    if [ "${has_setup:-0}" -eq 0 ] || [ "${has_run:-0}" -eq 0 ]; then status="partial"; fi
    sections=$(jq -n \
      --argjson o "${has_overview:-0}" --argjson s "${has_setup:-0}" \
      --argjson r "${has_run:-0}" --argjson t "${has_test:-0}" --argjson d "${has_deploy:-0}" \
      '{overview:($o>0), setup:($s>0), run:($r>0), test:($t>0), api:false, deployment:($d>0), environment:false}')
  fi

  local score=40
  [ "$status" = "partial" ] && score=60
  [ "$status" = "good" ] && score=80

  jq -n --arg owner "$OWNER" --arg repo "$REPO" --arg status "$status" \
    --argjson sections "$sections" --argjson score "$score" \
    '{
      owner:$owner, repo:$repo, readme_status:$status,
      sections_found:$sections, contradictions:[], gaps:[],
      audit_score:$score, timestamp:now|todate
    }' > "$audit"

  # Patch DNA readme_status
  local dna; dna=$(json_file "02_repo_dna.json")
  if [ -f "$dna" ]; then
    jq --arg s "$status" '.project_info.readme_status=$s' "$dna" > "${dna}.tmp" && mv "${dna}.tmp" "$dna"
  fi

  success "README audit → $audit ($status)"
}

# ============================================================================
# SKILL 5 — Security Auditor (paths only — never copies secret values)
# ============================================================================
skill_5_security() {
  log "Skill 5: Security Auditor"
  local out; out=$(json_file "04_security_audit.json")
  local tree; tree=$(json_file "00_tree.json")
  local scout; scout=$(json_file "01_scout_output.json")

  local findings
  findings=$(jq -c '
    [
      .tree[]? | select(.type=="blob") | .path
      | select(
          (test("(^|/)\\.env($|\\.(local|production|development|prod|dev|staging))$")
           and (test("\\.example$|\\.sample$|\\.template$|\\.example\\.") | not))
          or test("(^|/)id_rsa$")
          or test("\\.(pem|p12|pfx)$")
          or test("(^|/)(credentials|secrets|service-account[^/]*)\\.(json|ya?ml)$")
          or test("(^|/)rclone\\.conf$")
          or test("(^|/)auth\\.json$")
        )
      | {type:"secret_file", file:., risk:"CRITICAL", exposure:"tree", note:"path only — value not fetched"}
    ]
  ' "$tree" 2>/dev/null || echo '[]')

  local bloat
  bloat=$(jq -c '
    [
      .tree[]? | select(.type=="tree") | .path
      | select(test("(^|/)(node_modules|\\.next|\\.cache|\\.cargo|\\.npm|__pycache__|\\.venv|vendor)(/|$)"))
      | {type:"committed_bloat", file:., risk:"HIGH", exposure:"tree"}
    ] | unique_by(.file) | .[0:50]
  ' "$tree" 2>/dev/null || echo '[]')

  local compliance
  compliance=$(jq -n \
    --argjson has_sec "$(jq 'any(.tree[]?; .path=="SECURITY.md")' "$tree")" \
    --argjson has_lic "$(jq 'any(.tree[]?; .path=="LICENSE" or .path=="LICENSE.md")' "$tree")" \
    --argjson has_coc "$(jq 'any(.tree[]?; .path=="CODE_OF_CONDUCT.md")' "$tree")" \
    '{has_security_policy:$has_sec, has_license:$has_lic, has_coc:$has_coc,
      missing_items: (
        (if $has_sec then [] else ["SECURITY.md"] end)
        + (if $has_lic then [] else ["LICENSE"] end)
        + (if $has_coc then [] else ["CODE_OF_CONDUCT.md"] end)
      )}')

  local crit; crit=$(echo "$findings" | jq 'length')
  local high; high=$(echo "$bloat" | jq 'length')
  local overall="LOW"
  [ "$high" -gt 0 ] && overall="HIGH"
  [ "$crit" -gt 0 ] && overall="CRITICAL"

  jq -n --arg owner "$OWNER" --arg repo "$REPO" \
    --argjson findings "$findings" --argjson bloat "$bloat" --argjson compliance "$compliance" \
    --arg overall "$overall" --argjson private "$(jq '.private // false' "$scout")" \
    '{
      metadata:{owner:$owner, repo:$repo, scanned_at:now|todate, scan_version:"orch-v2", confidence:0.80},
      summary:{
        total_findings: (($findings|length)+($bloat|length)),
        critical: ($findings|length), high: ($bloat|length), medium:0, low:0,
        overall_risk_level:$overall
      },
      secret_detection:{secrets_found:($findings|length), findings:$findings},
      dependency_vulnerabilities:{total_dependencies:0, vulnerable_packages:0, findings:[], gap:"CVE scan needs lockfile audit — not guessed"},
      code_vulnerabilities:{patterns_found:0, findings:[], gap:"AST not run"},
      github_security:{is_private:$private, findings:[]},
      infrastructure_secrets:{findings:$findings},
      compliance:$compliance,
      critical_findings: $findings,
      recommendations: (
        (if ($findings|length)>0 then [{"priority":"CRITICAL","action":"Quarantine secret paths. Rotate. Do not promote to Brain."}] else [] end)
        + (if ($bloat|length)>0 then [{"priority":"HIGH","action":"Remove committed bloat dirs from git."}] else [] end)
      ),
      gaps: (if ($findings|length)==0 and ($bloat|length)==0 then [] else [] end)
    }' > "$out"

  success "Security → $out ($overall)"
}

# ============================================================================
# SKILL 6 — Dependency Mapper (declared deps only)
# ============================================================================
skill_6_deps() {
  log "Skill 6: Dependency Mapper"
  local out; out=$(json_file "05_dependency_map.json")
  local tree; tree=$(json_file "00_tree.json")

  local managers='[]'
  local direct='[]'
  local lock_present=false

  if jq -e '.tree[]? | select(.path=="package.json")' "$tree" >/dev/null 2>&1; then
    managers=$(echo "$managers" | jq '. + ["npm"]')
    local pkg
    pkg=$(fetch_text "package.json" | jq '.' 2>/dev/null || echo "{}")
    direct=$(echo "$pkg" | jq '
      [(.dependencies // {}) | to_entries[] | {name:.key, version:.value, type:"production", evidence:"package.json"}]
      + [(.devDependencies // {}) | to_entries[] | {name:.key, version:.value, type:"dev", evidence:"package.json"}]
    ' 2>/dev/null || echo '[]')
  fi
  if jq -e '.tree[]? | select(.path=="requirements.txt")' "$tree" >/dev/null 2>&1; then
    managers=$(echo "$managers" | jq '. + ["pip"]')
  fi
  if jq -e '.tree[]? | select(.path=="Cargo.toml")' "$tree" >/dev/null 2>&1; then
    managers=$(echo "$managers" | jq '. + ["cargo"]')
  fi
  if jq -e '.tree[]? | select(.path=="go.mod")' "$tree" >/dev/null 2>&1; then
    managers=$(echo "$managers" | jq '. + ["go"]')
  fi
  if jq -e '.tree[]? | select(.path=="package-lock.json" or .path=="yarn.lock" or .path=="pnpm-lock.yaml" or .path=="Cargo.lock" or .path=="go.sum")' "$tree" >/dev/null 2>&1; then
    lock_present=true
  fi

  jq -n --arg owner "$OWNER" --arg repo "$REPO" \
    --argjson managers "$managers" --argjson direct "$direct" --argjson lock "$lock_present" \
    '{
      metadata:{owner:$owner, repo:$repo, scanned_at:now|todate, package_managers:$managers, total_dependencies:($direct|length)},
      summary:{
        direct_count:($direct|length), transitive_count:0, unique_packages:($direct|length),
        production_count:($direct|map(select(.type=="production"))|length),
        dev_count:($direct|map(select(.type=="dev"))|length),
        conflicts:0, circular_dependencies:0, outdated_packages:0,
        lockfile_present:$lock
      },
      direct_dependencies:$direct,
      transitive_dependencies:[],
      version_conflicts:[],
      circular_dependencies:[],
      gaps: (if $lock then ["Lockfile present — transitive graph not expanded"] else ["No lockfile — transitive GAP"] end)
    }' > "$out"

  success "Deps → $out ($(echo "$direct" | jq 'length') declared)"
}

# ============================================================================
# SKILL 7 — Code Quality (tree metrics only — no invented complexity)
# ============================================================================
skill_7_quality() {
  log "Skill 7: Code Quality"
  local out; out=$(json_file "06_code_quality.json")
  local tree; tree=$(json_file "00_tree.json")

  local files_by_ext zero_byte tests bloat_files
  files_by_ext=$(jq -c '
    [.tree[]? | select(.type=="blob") | (.path | split(".") | last)]
    | group_by(.) | map({ext:.[0], files:length}) | sort_by(-.files) | .[0:20]
  ' "$tree" 2>/dev/null || echo '[]')

  zero_byte=$(jq -c '[.tree[]? | select(.type=="blob" and (.size // 0)==0) | {path, size:0}] | .[0:80]' "$tree" 2>/dev/null || echo '[]')

  tests=$(jq -c '[.tree[]? | select(.type=="blob" and (.path | test("(^|/)(tests?|__tests__)(/|$)|\\.(test|spec)\\.[jt]sx?$"))) | .path] | .[0:80]' "$tree" 2>/dev/null || echo '[]')

  bloat_files=$(jq -c '[.tree[]? | select(.path | test("(^|/)(node_modules|\\.next|\\.cache|\\.cargo|\\.npm|__pycache__)(/|$)")) | .path] | length' "$tree" 2>/dev/null || echo 0)

  local blob_count
  blob_count=$(jq '[.tree[]? | select(.type=="blob")] | length' "$tree")
  local test_count
  test_count=$(echo "$tests" | jq 'length')
  local zero_count
  zero_count=$(echo "$zero_byte" | jq 'length')

  local score=70
  [ "$test_count" -eq 0 ] && score=$((score - 15))
  [ "$zero_count" -gt 0 ] && score=$((score - 10))
  [ "$bloat_files" -gt 0 ] && score=$((score - 15))
  [ "$score" -lt 0 ] && score=0

  local grade="C"
  [ "$score" -ge 90 ] && grade="A"
  [ "$score" -ge 80 ] && [ "$score" -lt 90 ] && grade="B"
  [ "$score" -ge 70 ] && [ "$score" -lt 80 ] && grade="C"
  [ "$score" -ge 60 ] && [ "$score" -lt 70 ] && grade="D"
  [ "$score" -lt 60 ] && grade="F"

  jq -n --arg owner "$OWNER" --arg repo "$REPO" \
    --argjson by_ext "$files_by_ext" --argjson zero "$zero_byte" --argjson tests "$tests" \
    --argjson bloat "$bloat_files" --argjson blobs "$blob_count" \
    --argjson score "$score" --arg grade "$grade" \
    '{
      metadata:{owner:$owner, repo:$repo, scanned_at:now|todate, total_files:$blobs},
      summary:{overall_score:$score, grade:$grade, quality_trend:"unknown"},
      code_metrics:{blob_count:$blobs, files_by_extension:$by_ext},
      complexity:{gap:"Cyclomatic / cognitive complexity needs AST — not measured"},
      test_coverage:{
        overall_coverage:null, test_file_count:($tests|length), test_paths:($tests|.[0:40]),
        gap:"Coverage percent needs a runner — not guessed"
      },
      code_smells:{zero_byte_files:$zero, committed_bloat_entries:$bloat},
      gaps: (
        ["Complexity not measured without AST"]
        + (if ($tests|length)==0 then ["No test files in tree"] else [] end)
        + (if ($zero|length)>0 then ["Zero-byte blobs present"] else [] end)
        + (if $bloat>0 then ["Bloat dirs committed"] else [] end)
      )
    }' > "$out"

  success "Quality → $out (grade $grade)"
}

# ============================================================================
# SKILL 8 — Asset Extractor (paths, not invented class names)
# ============================================================================
skill_8_assets() {
  log "Skill 8: Asset Extractor"
  local out; out=$(json_file "07_asset_inventory.json")
  local tree; tree=$(json_file "00_tree.json")

  local assets zips
  assets=$(jq -c '
    [
      .tree[]? | select(.type=="blob") | .path
      | select(test("(^|/)(components|src/components|src/lib|lib|skills|prompts|public|assets|templates)(/|$)")
               or test("\\.(svg|png|jpg|webp|glb|gltf)$"))
      | {asset_name:(split("/")|last), location:., asset_type:(
          if test("\\.(svg|png|jpg|webp)$") then "image"
          elif test("\\.(glb|gltf)$") then "3d"
          elif test("(^|/)skills/") then "skill-contract"
          elif test("(^|/)prompts/") then "prompt"
          elif test("(^|/)components/") then "component"
          else "source"
          end
        ), evidence:.}
    ] | .[0:80]
  ' "$tree" 2>/dev/null || echo '[]')

  zips=$(jq -c '[.tree[]? | select(.path|test("\\.(zip|tar\\.gz|tgz)$")) | {location:.path, asset_type:"archive"}]' "$tree" 2>/dev/null || echo '[]')

  jq -n --arg owner "$OWNER" --arg repo "$REPO" --argjson assets "$assets" --argjson zips "$zips" \
    '{
      metadata:{owner:$owner, repo:$repo, scanned_at:now|todate, total_assets:($assets|length), analysis_version:"orch-v2"},
      summary:{
        path_inventory:($assets|length), archives:($zips|length),
        high_value_assets:0, gap:"Value scores need human review — not guessed"
      },
      components:$assets,
      archives:$zips,
      recommendations: (if ($zips|length)>0 then
        [{"priority":"HIGH","asset":"archive","action":"Zip-only snapshot is not a product"}]
      else [] end)
    }' > "$out"

  success "Assets → $out"
}

# ============================================================================
# SKILL 9 — Architecture Visualizer
# ============================================================================
skill_9_architecture() {
  log "Skill 9: Architecture Visualizer"
  local out; out=$(json_file "08_architecture.json")
  local txt; txt=$(json_file "08_architecture.txt")
  local tree; tree=$(json_file "00_tree.json")
  local truncated
  truncated=$(jq -r '.truncated // false' "$tree")

  local top
  top=$(jq -c '[.tree[]? | select(.type=="tree" and (.path|contains("/")|not)) | .path] | unique | sort' "$tree")

  local pattern="unknown"
  if jq -e --argjson t "$top" '$t | index("src")' >/dev/null 2>&1; then pattern="layered"; fi
  if jq -e '.tree[]? | select(.path|test("^apps/|^packages/"))' "$tree" >/dev/null 2>&1; then pattern="monorepo"; fi
  if jq -e '.tree[]? | select(.path=="src/routes/index.tsx")' "$tree" >/dev/null 2>&1; then pattern="tanstack-start"; fi
  if jq -e '.tree[]? | select(.path=="src/app/page.tsx" or .path=="app/page.tsx")' "$tree" >/dev/null 2>&1; then pattern="next-app-router"; fi
  if jq -e '.tree[]? | select(.path=="skills" or .path|startswith("skills/"))' "$tree" >/dev/null 2>&1; then
    [ "$pattern" = "unknown" ] && pattern="skill-library"
  fi

  {
    echo "${OWNER}/${REPO}"
    echo "pattern: ${pattern}"
    echo "truncated: ${truncated}"
    echo ""
    echo "$top" | jq -r '.[]' | awk '{print "├── "$0}'
  } > "$txt"

  local ascii
  ascii=$(cat "$txt")

  jq -n --arg owner "$OWNER" --arg repo "$REPO" --arg pattern "$pattern" \
    --argjson top "$top" --arg ascii "$ascii" --argjson truncated "$( [ "$truncated" = "true" ] && echo true || echo false )" \
    '{
      metadata:{owner:$owner, repo:$repo, scanned_at:now|todate, architecture_type:$pattern},
      summary:{top_level_dirs:$top, architectural_pattern:$pattern, truncated:$truncated},
      components: ($top | map({name:., type:"dir", location:., role:"root-dir"})),
      ascii_diagram:$ascii,
      gaps: (if $truncated then ["Tree truncated — architecture is partial"] else [] end)
    }' > "$out"

  success "Architecture → $out ($pattern)"
}

# ============================================================================
# SKILL 3.5 — Forensic 23-section (python3 synthesis from evidence files)
# ============================================================================
skill_3_5_forensic() {
  log "Skill 3.5: Forensic Auditor — 23 sections from evidence"
  local out; out=$(json_file "03.5_forensic_report.json")

  if ! command -v python3 >/dev/null 2>&1; then
    warn "python3 missing — forensic GAP placeholder"
    jq -n --arg o "$OWNER" --arg r "$REPO" \
      '{metadata:{owner:$o, repo:$r, analyzed_at:now|todate, analysis_version:"23-section-protocol-v1", confidence_level:0.2},
        "19_what_is_missing":{"p0_blocking":["python3 missing — cannot synthesize forensic"]},
        "23_executive_verdict":{"what_this_system_really_is":"GAP","commercial_potential":"UNKNOWN","final_maturity_score":0}}' > "$out"
    return 0
  fi

  python3 - "$OUTPUT_DIR" "$OWNER" "$REPO" "$out" <<'PY'
import json, os, sys, datetime
out_dir, owner, repo, dest = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4]

def load(name):
    p = os.path.join(out_dir, name)
    if not os.path.isfile(p):
        return {}
    try:
        with open(p, encoding="utf-8") as f:
            return json.load(f)
    except Exception:
        return {}

scout = load("01_scout_output.json")
dna = load("02_repo_dna.json")
audit = load("03_readme_audit.json")
sec = load("04_security_audit.json")
deps = load("05_dependency_map.json")
qual = load("06_code_quality.json")
assets = load("07_asset_inventory.json")
arch = load("08_architecture.json")
now = datetime.datetime.utcnow().replace(microsecond=0).isoformat() + "Z"

secrets = sec.get("secret_detection", {}).get("findings", [])
bloat = sec.get("summary", {}).get("high", 0)
tests = qual.get("test_coverage", {}).get("test_file_count", 0)
zero = qual.get("code_smells", {}).get("zero_byte_files", [])
truncated = bool(scout.get("truncated") or arch.get("summary", {}).get("truncated"))
workflows = scout.get("evidence_files", {}).get("workflows", [])
has_license = bool(sec.get("compliance", {}).get("has_license"))
direct = deps.get("direct_dependencies", [])
top = arch.get("summary", {}).get("top_level_dirs", [])
pattern = arch.get("summary", {}).get("architectural_pattern", "unknown")
ascii_map = arch.get("ascii_diagram") or "GAP — no architecture diagram"
purpose = (dna.get("project_info") or {}).get("purpose", "unknown")
runtime = ((dna.get("tech_stack") or {}).get("runtime") or {}).get("type", "unknown")
langs = [x.get("name") for x in (dna.get("tech_stack") or {}).get("languages", []) if x.get("name")]
verified = []
if langs:
    verified.append({"name": "languages", "evidence": ",".join(langs)})
if direct:
    verified.append({"name": "declared dependencies", "evidence": f"{len(direct)} from manifests"})
if workflows:
    verified.append({"name": "CI workflows", "evidence": str(workflows[:5])})
if assets.get("components"):
    verified.append({"name": "path assets", "evidence": f"{len(assets.get('components', []))} paths"})

claimed = []
if audit.get("readme_status") in ("partial", "good"):
    claimed.append({
        "claim": "README exists",
        "location_searched": "README.md",
        "reason_unverified": "README claims not cross-checked line-by-line against every blob"
    })

p0, p1, p2, p3 = [], [], [], []
if secrets:
    p0.append("Secret-looking paths in tree — quarantine, rotate, do not promote to Brain")
if truncated:
    p0.append("GitHub tree truncated — recover with path_filter (skill 18), do not treat as a small repo")
if not has_license:
    p1.append("No LICENSE in tree")
if tests == 0:
    p1.append("No test files in tree")
if not workflows:
    p1.append("No .github/workflows in tree")
if zero:
    p1.append(f"{len(zero)} zero-byte blobs")
if bloat:
    p1.append("Committed bloat dirs")
if audit.get("readme_status") == "missing":
    p1.append("README missing")
elif audit.get("readme_status") == "partial":
    p2.append("README partial — setup/run sections weak")
p3.append("Complexity / coverage percent not measured (needs AST / runner)")
p3.append("Transitive deps not expanded")

critical_path = []
step = 1
def add_step(action, outcome, effort="small"):
    global step
    critical_path.append({"step": step, "action": action, "depends_on": [] if step == 1 else [step - 1], "effort": effort, "outcome": outcome})
    step += 1

if secrets:
    add_step("Quarantine secret paths. Rotate. Do not copy values into extracts.", "Secrets off the promote path")
if truncated:
    add_step("Recover tree with path_filter + non-recursive listing.", "Complete file inventory")
if bloat:
    add_step("Strip committed bloat (node_modules / .next / caches) from git.", "Tree is source, not a home directory")
if tests == 0:
    add_step("Add at least one evidenced test path before calling this production-ready.", "Test evidence exists")
add_step("Human gate: README.rewrite.md is not live README.md.", "No auto-push")
add_step("Do not promote this extract to Brain.", "Fail closed")

keep = top[:]
modify = []
if bloat:
    modify.append("remove committed bloat dirs")
deprecate = [z.get("path") for z in zero[:20]]
extract = [a.get("location") for a in (assets.get("components") or [])[:10]]

score = int(qual.get("summary", {}).get("overall_score") or 50)
if secrets:
    score = min(score, 35)
if truncated:
    score = min(score, 45)
maturity = "Prototype"
if score >= 81:
    maturity = "Production-ready"
elif score >= 61:
    maturity = "Pre-production"
elif score >= 41:
    maturity = "Functional"
elif score >= 21:
    maturity = "Experimental"

can_do = []
if langs:
    can_do.append(f"Declared stack: {', '.join(langs)}")
if direct:
    can_do.append(f"{len(direct)} declared packages")
if workflows:
    can_do.append("CI workflow files present")
cannot = []
if tests == 0:
    cannot.append("No test files evidenced")
if secrets:
    cannot.append("Cannot promote — secret paths present")
if truncated:
    cannot.append("Cannot claim complete architecture — tree truncated")

report = {
    "metadata": {
        "owner": owner, "repo": repo, "analyzed_at": now,
        "analysis_version": "23-section-protocol-v1",
        "confidence_level": 0.62 if not truncated else 0.45,
        "note": "Filled from orchestrator evidence files. GAP over guess."
    },
    "1_system_identity": {
        "system_name": repo,
        "apparent_purpose": scout.get("description") or "unknown",
        "actual_purpose": purpose,
        "primary_users": [],
        "primary_workflows": [],
        "major_capabilities": langs,
        "architectural_paradigm": pattern,
        "technology_stack": langs + ([runtime] if runtime != "unknown" else []),
        "runtime_environment": runtime,
        "deployment_model": "unknown",
        "has_ai_agents": any(p in (top or []) for p in ("skills", "agents", "mcp")),
        "has_api": any("api" in (p or "").lower() for p in (top or [])),
        "has_frontend": any(p in (top or []) for p in ("src", "app", "public")),
        "has_backend": runtime in ("nodejs", "python", "go", "rust"),
        "system_definition_paragraph": (
            f"{owner}/{repo} looks like a {pattern} {purpose} on {runtime}. "
            "This sentence is from tree + manifests only."
        ),
    },
    "2_architecture_reconstruction": {
        "user_flow": "GAP without runtime traces",
        "major_subsystems": [{"name": d, "location": d, "purpose": "root dir", "is_functional": True} for d in top],
        "architectural_hierarchy": {"system": {"platform": top}},
    },
    "3_capability_inventory": [
        {"name": d, "description": "root directory present in tree", "category": "INFRASTRUCTURE",
         "maturity_score": 3, "location": d, "evidence": [d]} for d in top
    ],
    "4_asset_extraction": assets.get("components") or [],
    "5_system_lineage": {
        "origin_architecture": pattern,
        "major_changes": [],
        "timeline": "UNKNOWN — commit series not expanded",
        "surviving_components": top,
        "superseded_components": [],
        "experimental_branches": [],
    },
    "6_dependency_graph": {
        "internal_dependencies": [],
        "external_dependencies": [
            {"package": d.get("name"), "version": d.get("version"), "type": d.get("type"), "vulnerability": "UNKNOWN"}
            for d in direct[:80]
        ],
        "circular_dependencies": [],
        "single_points_of_failure": [],
        "critical_dependency_chain": "GAP without import graph",
    },
    "7_data_flow": [],
    "8_ai_agent_analysis": {
        "has_ai_components": any(p in (top or []) for p in ("skills", "agents")),
        "architecture_type": "skill-library" if "skills" in (top or []) else "unknown",
        "agents": [],
        "emergent_behaviors": "GAP",
    },
    "9_security_audit": {
        "authentication": {"status": "UNKNOWN", "method": "not evidenced", "findings": []},
        "authorization": {"status": "UNKNOWN", "method": "not evidenced", "findings": []},
        "secrets_management": {
            "status": "UNSAFE" if secrets else "BASIC",
            "findings": [f.get("file") for f in secrets],
        },
        "exposed_endpoints": [],
        "injection_risks": [],
        "dependency_vulnerabilities": ["CVE scan GAP"],
        "critical_findings": secrets,
    },
    "10_production_readiness": {
        "overall_score": score,
        "maturity_level": maturity,
        "scores": {
            "functionality": score, "error_handling": None, "testing": 20 if tests == 0 else 50,
            "security": 20 if secrets else 60, "scalability": None, "reliability": None,
            "deployment": 50 if workflows else 20, "monitoring": None,
            "documentation": audit.get("audit_score", 40),
        },
        "blockers": p0, "ready_for": [],
    },
    "11_technical_debt": {
        "duplicated_code": [],
        "dead_code": [z.get("path") for z in zero[:40]],
        "unfinished_implementations": [],
        "todos": [],
        "must_fix": p0, "should_fix": p1, "optional": p3,
    },
    "12_duplication_consolidation": [],
    "13_reusability_analysis": [],
    "14_productization_analysis": [],
    "15_business_value": {
        "highest_value_capability": {"name": None, "why": "GAP without product evidence"},
        "highest_value_reusable_asset": {"name": None, "why": "path inventory only"},
        "highest_value_proprietary_workflow": {"name": None, "why": "GAP"},
        "highest_value_ai_capability": {"name": None, "why": "GAP"},
        "highest_value_infrastructure": {"name": None, "why": "GAP"},
        "highest_value_product_opportunity": {"name": None, "why": "UNKNOWN"},
    },
    "16_system_maturity": {
        "architecture": score, "code_quality": score, "functionality": score,
        "security": 20 if secrets else 60, "testing": 20 if tests == 0 else 50,
        "overall_maturity_score": score,
    },
    "17_single_source_of_truth": {"canonical_locations": [], "duplicated_configuration": [], "duplicated_business_logic": []},
    "18_what_actually_exists": {
        "verified_existing": verified,
        "partially_implemented": [],
        "claimed_but_not_verified": claimed,
    },
    "19_what_is_missing": {"p0_blocking": p0, "p1_critical": p1, "p2_important": p2, "p3_optimization": p3},
    "20_critical_path": critical_path,
    "21_architectural_recommendation": {
        "current_architecture": pattern,
        "recommended_architecture": pattern,
        "keep": keep, "modify": modify, "consolidate": [], "extract": extract,
        "deprecate": deprecate, "rebuild": [],
        "reasoning": "Keep what the tree shows. Do not rebuild from a celebration summary.",
    },
    "22_final_system_map": {"ascii_diagram": ascii_map, "system_hierarchy": {"top_level": top}},
    "23_executive_verdict": {
        "what_this_system_really_is": f"{owner}/{repo} — {pattern} {purpose} on {runtime}, from tree evidence.",
        "what_it_can_do_today": can_do or ["Insufficient evidence"],
        "what_it_cannot_do": cannot,
        "most_valuable_assets": extract[:5],
        "biggest_technical_risks": p0 + p1[:3],
        "biggest_missed_opportunities": [],
        "what_should_never_be_deleted": keep[:8],
        "what_should_be_consolidated": [],
        "what_should_be_built_next": [s["action"] for s in critical_path[:3]],
        "commercial_potential": "UNKNOWN",
        "final_maturity_score": score,
    },
}

with open(dest, "w", encoding="utf-8") as f:
    json.dump(report, f, indent=2)
print("forensic keys", len(report))
PY

  success "Forensic → $out (23 sections)"
}

# ============================================================================
# SKILL 4 — README.rewrite.md (never live README.md)
# ============================================================================
skill_4_readme_generator() {
  log "Skill 4: README Generator — README.rewrite.md only"
  local out; out=$(json_file "README.rewrite.md")
  local forensic; forensic=$(json_file "03.5_forensic_report.json")
  local dna; dna=$(json_file "02_repo_dna.json")

  if ! command -v python3 >/dev/null 2>&1; then
    warn "python3 missing — writing stub rewrite"
    cat > "$out" <<EOF
# ${OWNER}/${REPO}

THIS FILE IS README.rewrite.md. It is not live README.md.
Human gate before any replace. No auto-push. No promote to Brain.

python3 missing — cannot render forensic 19–23.
EOF
    success "README stub → $out"
    return 0
  fi

  python3 - "$forensic" "$dna" "$out" "$OWNER" "$REPO" <<'PY'
import json, sys
forensic_path, dna_path, dest, owner, repo = sys.argv[1:6]

def load(p):
    try:
        with open(p, encoding="utf-8") as f:
            return json.load(f)
    except Exception:
        return {}

F = load(forensic_path)
D = load(dna_path)
ident = F.get("1_system_identity") or {}
v = F.get("23_executive_verdict") or {}
m19 = F.get("19_what_is_missing") or {}
m20 = F.get("20_critical_path") or []
m21 = F.get("21_architectural_recommendation") or {}
m22 = F.get("22_final_system_map") or {}
ready = F.get("10_production_readiness") or {}
sec = F.get("9_security_audit") or {}

def bullets(xs):
    xs = xs or []
    if not xs:
        return "- GAP"
    return "\n".join(f"- {x}" for x in xs)

def kv_list(d, key):
    return bullets(d.get(key) or [])

lines = []
a = lines.append
a(f"# {ident.get('system_name') or repo}")
a("")
a("> THIS FILE IS `README.rewrite.md`. It is **not** live `README.md`.")
a("> Human gate before any replace. No auto-push. No promote to Brain.")
a("")
a(ident.get("system_definition_paragraph") or f"{owner}/{repo} — evidence-first DNA extract.")
a("")
a(f"- **Maturity**: {ready.get('maturity_level', 'unknown')}")
a(f"- **Stack**: {', '.join(ident.get('technology_stack') or []) or 'unknown'}")
a(f"- **Pattern**: {ident.get('architectural_paradigm', 'unknown')}")
a(f"- **Analyzed**: {(F.get('metadata') or {}).get('analyzed_at', '')}")
a("")
a("## What This Does")
a("")
a(bullets(v.get("what_it_can_do_today")))
a("")
a("## Architecture")
a("")
a("```")
a(m22.get("ascii_diagram") or "GAP")
a("```")
a("")
a("## Security")
a("")
a(f"Secrets status: {(sec.get('secrets_management') or {}).get('status', 'UNKNOWN')}")
a("")
a(bullets((sec.get('secrets_management') or {}).get('findings')))
a("")
a("Values are not copied. Paths only.")
a("")
a("## Production Readiness")
a("")
a(f"Score: {ready.get('overall_score', 'GAP')} · {ready.get('maturity_level', 'unknown')}")
a("")
a("### Blockers")
a("")
a(bullets(ready.get("blockers")))
a("")
a("## 19. What's Missing")
a("")
a("### P0 blocking")
a(kv_list(m19, "p0_blocking"))
a("")
a("### P1 critical")
a(kv_list(m19, "p1_critical"))
a("")
a("### P2 important")
a(kv_list(m19, "p2_important"))
a("")
a("### P3 optimization")
a(kv_list(m19, "p3_optimization"))
a("")
a("## 20. Critical Path")
a("")
if m20:
    for s in m20:
        a(f"{s.get('step')}. {s.get('action')} — {s.get('outcome', '')}")
else:
    a("- GAP")
a("")
a("## 21. Architectural Recommendation")
a("")
a(f"Current: {m21.get('current_architecture', 'unknown')}")
a("")
a("**Keep**")
a(bullets(m21.get("keep")))
a("")
a("**Modify**")
a(bullets(m21.get("modify")))
a("")
a("**Deprecate**")
a(bullets(m21.get("deprecate")))
a("")
a("**Rebuild**")
a(bullets(m21.get("rebuild") or []))
a("")
a(m21.get("reasoning") or "")
a("")
a("## 22. Final System Map")
a("")
a("```")
a(m22.get("ascii_diagram") or "GAP")
a("```")
a("")
a("## 23. Executive Verdict")
a("")
a(v.get("what_this_system_really_is") or "GAP")
a("")
a("**Can do today**")
a(bullets(v.get("what_it_can_do_today")))
a("")
a("**Cannot do**")
a(bullets(v.get("what_it_cannot_do")))
a("")
a(f"**Commercial potential**: {v.get('commercial_potential', 'UNKNOWN')}")
a(f"**Maturity score**: {v.get('final_maturity_score', 'GAP')}")
a("")
a("---")
a("")
a("Generated by Repo DNA orchestrator v2. Hand-off only. Fail closed.")
a("")

with open(dest, "w", encoding="utf-8") as f:
    f.write("\n".join(lines))
PY

  success "README.rewrite.md → $out (live README.md untouched)"
}

# ============================================================================
# LEDGER
# ============================================================================
ledger_sync() {
  log "Ledger"
  local ledger="${WORK_DIR}/dna_ledger.json"
  local end_time end_epoch duration
  end_time=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
  end_epoch=$(date +%s)
  duration=$((end_epoch - START_EPOCH))
  jq -n \
    --arg owner "$OWNER" \
    --arg repo "$REPO" \
    --arg branch "$BRANCH" \
    --arg started "$START_TIME" \
    --arg ended "$end_time" \
    --argjson dur "$duration" \
    --arg outdir "$OUTPUT_DIR" \
    --argjson skills '["1-scout","2-dna","3-readme-auditor","5-security","6-deps","7-quality","8-assets","9-architecture","3.5-forensic","4-readme-rewrite"]' \
    '{owner:$owner,repo:$repo,branch:$branch,analyzed_at:$started,completed_at:$ended,duration_seconds:$dur,output_dir:$outdir,skills_executed:$skills,status:"complete",promote_to_brain:false,live_readme_rewritten:false,auto_pushed:false}' \
    > "$ledger"
  success "Ledger → $ledger"
}

# ============================================================================
# MAIN
# ============================================================================
main() {
  log "=========================================="
  log "REPO DNA — ORCHESTRATOR v2"
  log "${OWNER}/${REPO} @ ${BRANCH}"
  log "=========================================="

  setup_directories
  skill_1_repo_scout
  skill_2_dna_extractor
  skill_3_readme_auditor
  skill_5_security
  skill_6_deps
  skill_7_quality
  skill_8_assets
  skill_9_architecture
  skill_3_5_forensic
  skill_4_readme_generator
  ledger_sync

  log ""
  success "Complete — local extracts only"
  log "Output: $OUTPUT_DIR"
  log "Hand-off: README.rewrite.md is not live README.md. Not promoted to Brain."
  ls -1 "$OUTPUT_DIR"
}

trap 'error "Orchestrator failed"; exit 1' ERR
main "$@"
