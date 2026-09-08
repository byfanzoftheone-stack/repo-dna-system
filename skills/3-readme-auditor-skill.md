# Skill 3: readme-auditor-skill

**Purpose**: Audit README quality and completeness against repo DNA.

**Input**: repo_dna.json from Skill 2  
**Output**: readme_audit.json with status + gaps + recommendations  
**Speed**: <1 second per repo

---

## Input Contract

```json
{
  "owner": "string",
  "repo": "string",
  "repo_dna": "{ full DNA from Skill 2 }",
  "readme_content": "string (raw markdown or null)"
}
```

## Output Contract

```json
{
  "owner": "string",
  "repo": "string",
  "readme_status": "missing | partial | stale | good",
  "sections_found": {
    "overview": true,
    "setup": true,
    "run": true,
    "test": true,
    "api": true,
    "deployment": true,
    "environment": true
  },
  "contradictions": [
    {
      "section": "string",
      "readme_claims": "string",
      "dna_shows": "string",
      "severity": "critical | warning | info"
    }
  ],
  "gaps": [
    {
      "category": "string",
      "missing_section": "string",
      "impact": "string",
      "severity": "critical | warning | info"
    }
  ],
  "recommendations": [
    "string"
  ],
  "audit_score": "0-100",
  "timestamp": "ISO 8601"
}
```

---

## Classification Logic

### Status: `missing`
- No README.md found in repo root

### Status: `partial`
- README exists but missing 3+ critical sections:
  - Project Overview / What this is
  - How to Set Up / Prerequisites
  - How to Run / Usage
  - How to Test
  - Environment Variables / Configuration
  - Deployment instructions
  - API documentation (if applicable)

### Status: `stale`
- README exists but contradicts DNA:
  - Claims framework version that doesn't match package.json
  - Claims runtime that contradicts Dockerfile
  - Claims features that don't exist in code
  - Missing documented features
  - Deprecated commands in setup section

### Status: `good`
- README exists
- Contains all critical sections
- Aligns with DNA
- Is recently updated (< 6 months)
- Provides clear setup/run/test path

---

## Audit Rules

### Rule 1: Section Detection
Look for headers (H1-H3) matching:
- Overview: "Overview", "About", "What is", "Introduction"
- Setup: "Setup", "Installation", "Prerequisites", "Requirements"
- Run: "Usage", "Quick Start", "Run", "Getting Started"
- Test: "Test", "Testing", "Development"
- API: "API", "Endpoints", "Interface"
- Deploy: "Deploy", "Deployment", "Production"
- Environment: "Environment", "Configuration", ".env", "Secrets"

### Rule 2: Contradiction Detection
Compare README claims against DNA:
```
README says:    "Node.js 16+"
DNA shows:      "engines.node": "18.x" in package.json
Status:         STALE — contradicts package.json
Severity:       WARNING
```

### Rule 3: Confidence in Contradictions
Only flag contradictions where DNA confidence >= 0.7

### Rule 4: Gap Severity
- `critical`: blocks user from running/deploying project
- `warning`: reduces developer experience but doesn't block
- `info`: nice-to-have documentation

---

## Audit Steps

### Step 1: Check README Existence
```json
{
  "readme_exists": true,
  "readme_path": "README.md",
  "readme_length_chars": 2847
}
```

### Step 2: Detect Sections
Parse README headers and classify into categories.

### Step 3: Compare Against DNA
```
For each documented feature/capability:
  IF claimed in README
  AND not found in DNA evidence
  THEN flag as STALE/UNVERIFIED

For each discovered capability in DNA:
  IF not documented in README
  THEN add to gaps (severity=warning)
```

### Step 4: Extract Test Commands
Look for:
- Code blocks with `npm test`, `pytest`, `cargo test`, etc.
- Links to CI workflows
- Test documentation

### Step 5: Calculate Score
```
base_score = 50

sections_found = count(true values in sections_found)
sections_found_score = sections_found * 10  // max 70

contradictions_count = count(severity >= warning)
contradictions_penalty = contradictions_count * 5  // max -25

gaps_count = count(severity >= critical or warning)
gaps_penalty = gaps_count * 2  // max -30

audit_score = max(0, base_score + sections_found_score - contradictions_penalty - gaps_penalty)
```

### Step 6: Generate Recommendations
```
If status == "missing":
  "Generate README.md using Skill 5"
  
If status == "partial":
  "Add [section] to README"
  "Add environment variables documentation"
  "Document test command"
  
If status == "stale":
  "Update runtime version claim (currently says X, package.json shows Y)"
  "Remove deprecated commands"
  "Add newly discovered capabilities"
  
If status == "good":
  "Keep README current by syncing with DNA each quarter"
  "Consider adding architecture diagram"
```

---

## Copy-Paste Prompt Template

````
You are a README auditor. Your task is to assess README quality by comparing claims against repository DNA.

**Critical Rules:**
1. Only flag contradictions if DNA confidence >= 0.7
2. Never invent sections that don't exist
3. Distinguish between "missing" (no README) and "partial" (incomplete README)
4. Focus on user-blocking gaps (setup, run, test, deploy)
5. Return valid JSON only

**Input:**
```json
{
  "owner": "{{OWNER}}",
  "repo": "{{REPO}}",
  "repo_dna": {{DNA_JSON}},
  "readme_content": "{{README_MD or null}}"
}
```

**Steps:**

1. **Check README Existence**
   - If null → status = "missing"
   - If exists, continue to step 2

2. **Detect README Sections**
   Parse headers (# ## ###) and classify:
   - "Overview" / "About" / "What is" → overview section
   - "Setup" / "Installation" / "Prerequisites" → setup section
   - "Usage" / "Quick Start" / "Run" / "Getting Started" → run section
   - "Test" / "Testing" / "Development" → test section
   - "API" / "Endpoints" / "Interface" → api section
   - "Deploy" / "Deployment" / "Production" → deployment section
   - "Environment" / "Configuration" / ".env" → environment section

3. **Compare README Against DNA**
   For each section found:
     - Verify claims against DNA evidence paths
     - If README claims "Node 16+" but DNA shows "18.x" → flag as STALE
     - If README claims framework not in dependencies → flag as STALE
     - If README commands differ from test scripts in package.json → flag as STALE

4. **Identify Gaps**
   For each critical section NOT found:
     - If missing Setup → add gap: critical (user can't run project)
     - If missing Run → add gap: critical (user can't use project)
     - If missing Test → add gap: warning (but dev experience suffers)
     - If missing Deployment → add gap: info (if not a deployable app)
     - If missing Environment vars → add gap: warning (if .env.example exists)

5. **Classify Status**
   - status = "missing" if no README
   - status = "partial" if README exists but missing 3+ critical sections
   - status = "stale" if README exists but has contradictions with DNA
   - status = "good" if README complete + aligned + updated recently

6. **Calculate Audit Score**
   - Start: 50
   - +10 per section found (max 70)
   - -5 per contradiction (max -25)
   - -2 per gap (max -30)
   - Result: 0-100

7. **Generate Recommendations**
   - If "missing": "Generate README.md using Skill 5 (readme-generator-skill)"
   - If "partial": List specific sections to add
   - If "stale": List specific contradictions to fix
   - If "good": Optional: "Consider adding architecture diagram"

**Output:** Valid JSON matching output schema

**Validation:**
- [ ] readme_status is one of: missing, partial, stale, good
- [ ] sections_found has 7 boolean values
- [ ] contradictions is array of objects with (section, readme_claims, dna_shows, severity)
- [ ] gaps is array of objects with (category, missing_section, impact, severity)
- [ ] audit_score is 0-100
- [ ] timestamp is ISO 8601

**Return:** JSON output only.
````

---

## Shell Script

```bash
#!/bin/bash
# readme-auditor.sh
# Usage: ./readme-auditor.sh <dna-json-file> <owner> <repo>

DNA_FILE=$1
OWNER=$2
REPO=$3
TOKEN=${GITHUB_TOKEN}

if [ -z "$DNA_FILE" ] || [ -z "$OWNER" ] || [ -z "$REPO" ]; then
  echo "Usage: ./readme-auditor.sh <dna-json-file> <owner> <repo>"
  exit 1
fi

API="https://api.github.com/repos/${OWNER}/${REPO}"

echo "Auditing README for $OWNER/$REPO..."

# Fetch README
README=$(curl -s -H "Authorization: token ${TOKEN}" "$API/contents/README.md" | jq -r '.content' | base64 -d 2>/dev/null)

if [ -z "$README" ]; then
  STATUS="missing"
  SECTIONS="{\"overview\": false, \"setup\": false, \"run\": false, \"test\": false, \"api\": false, \"deployment\": false, \"environment\": false}"
else
  STATUS="good"
  # Simple section detection
  OVERVIEW=$(echo "$README" | grep -i -c "overview\|about\|introduction" || echo 0)
  SETUP=$(echo "$README" | grep -i -c "setup\|installation\|prerequisites" || echo 0)
  RUN=$(echo "$README" | grep -i -c "usage\|quick start\|run\|getting started" || echo 0)
  TEST=$(echo "$README" | grep -i -c "test\|testing" || echo 0)
  DEPLOY=$(echo "$README" | grep -i -c "deploy\|production" || echo 0)
  
  if [ "$SETUP" -eq 0 ] || [ "$RUN" -eq 0 ] || [ "$TEST" -eq 0 ]; then
    STATUS="partial"
  fi
  
  SECTIONS=$(jq -n \
    --arg overview "$OVERVIEW" \
    --arg setup "$SETUP" \
    --arg run "$RUN" \
    --arg test "$TEST" \
    --arg deploy "$DEPLOY" \
    '{
      overview: ($overview | tonumber > 0),
      setup: ($setup | tonumber > 0),
      run: ($run | tonumber > 0),
      test: ($test | tonumber > 0),
      deployment: ($deploy | tonumber > 0)
    }')
fi

# Build audit JSON
AUDIT=$(jq -n \
  --arg owner "$OWNER" \
  --arg repo "$REPO" \
  --arg status "$STATUS" \
  --argjson sections "$SECTIONS" \
  '{
    owner: $owner,
    repo: $repo,
    readme_status: $status,
    sections_found: $sections,
    contradictions: [],
    gaps: [],
    audit_score: (50),
    timestamp: now | todate
  }')

echo "$AUDIT" | jq .
```

---

## Success Example

```json
{
  "owner": "example-owner",
  "repo": "example-app",
  "readme_status": "good",
  "sections_found": {
    "overview": true,
    "setup": true,
    "run": true,
    "test": false,
    "api": false,
    "deployment": true,
    "environment": false
  },
  "contradictions": [],
  "gaps": [
    {
      "category": "testing",
      "missing_section": "Test",
      "impact": "No guidance on running test suite",
      "severity": "info"
    },
    {
      "category": "configuration",
      "missing_section": "Environment Variables",
      "impact": "Supabase keys not documented",
      "severity": "warning"
    }
  ],
  "recommendations": [
    "Add Testing section with `npm test` command",
    "Document required environment variables from .env.example",
    "Add sample .env.local configuration"
  ],
  "audit_score": 75,
  "timestamp": "2026-09-06T16:30:00Z"
}
```

---

## Next Step

Pass README audit output + repo DNA to **Skill 3.5: forensic-auditor-skill** for full system analysis.
