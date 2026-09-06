# Skill 2: dna-extractor-skill

**Purpose**: Extract complete repository DNA from evidence files.

**Input**: Scout output + tier_1_critical file contents  
**Output**: Full `repo_dna.json` conforming to schema v1.1.0  
**Speed**: <1 second per repo  
**Rule**: Every fact must have an evidence path. Unknown = `GAP:` entry (never guess).

---

## Input Contract

```json
{
  "scout_output": "{ scout result from Skill 1 }",
  "file_contents": {
    "package.json": "{ parsed JSON or null }",
    "pyproject.toml": "{ raw text or null }",
    "Cargo.toml": "{ raw text or null }",
    "Dockerfile": "{ raw text or null }",
    "README.md": "{ raw text or null }",
    ".env.example": "{ raw text or null }",
    "main workflow YAML": "{ raw text or null }"
  }
}
```

## Output Contract

Valid JSON matching `repo_dna.schema.json` v1.1.0 with evidence paths for every claim.

---

## Extraction Rules

### Rule 1: Evidence Paths
Every key in the output must have a corresponding `evidence_paths` reference:
```json
{
  "frameworks": [
    {
      "name": "express",
      "version": "4.18.2",
      "evidence": "package.json#dependencies.express"
    }
  ]
}
```

### Rule 2: No Guessing
If uncertain, use a `GAP:` entry in the `gaps` array:
```json
{
  "gaps": [
    {
      "category": "runtime",
      "issue": "GAP: Node version not specified in package.json or .nvmrc",
      "severity": "warning"
    }
  ]
}
```

### Rule 3: Confidence Calculation
```
confidence = (total_facts_with_evidence / total_facts) * 0.8 + 0.2
Min 0.0, Max 1.0
```

### Rule 4: Language Detection
Read from:
- `package.json` → JavaScript/TypeScript
- `pyproject.toml` or `setup.py` → Python
- `Cargo.toml` → Rust
- `go.mod` → Go
- `pom.xml` → Java
- `Dockerfile` → detect RUN/FROM commands

---

## Extraction Steps

### Step 1: Parse Metadata
```json
{
  "metadata": {
    "owner": "from scout",
    "repo": "from scout",
    "url": "https://github.com/{owner}/{repo}",
    "default_branch": "from scout",
    "extracted_at": "now (ISO 8601)",
    "schema_version": "1.1.0",
    "evidence_paths": [
      "package.json",
      "Dockerfile",
      ".env.example",
      "README.md"
    ],
    "confidence": "calculated (0.0-1.0)"
  }
}
```

### Step 2: Extract Tech Stack

**From `package.json`:**
```
languages: ["JavaScript", "TypeScript" (if tsconfig found)]
frameworks: [name, version from dependencies + devDependencies]
runtime: "nodejs", version from "engines.node"
package_managers: ["npm"] (infer from package.json presence)
```

**From `Dockerfile`:**
```
Analyze FROM statement:
  FROM node:18-alpine → runtime: nodejs, version: 18
  FROM python:3.11 → runtime: python, version: 3.11
  FROM rust:latest → runtime: rust, version: latest
```

**From `pyproject.toml`:**
```
languages: ["Python"]
frameworks: [from dependencies section]
runtime: "python", version from [build-system] or [tool.poetry]
```

### Step 3: Extract Project Info

**From `README.md` (first 200 chars):**
```
description: first sentence or opening paragraph
purpose: infer from description + structure
```

**From `package.json`:**
```
name, version, description, license, keywords
```

**Status Inference:**
- If last commit < 6 months ago → active
- If last commit > 2 years ago → inactive
- If archived flag set → archived
- Otherwise → unknown

### Step 4: Extract Architecture

**Entry Points:**
- `package.json.main` or `package.json.bin` → CLI/lib entry
- `src/index.ts` or `src/main.ts` → app entry
- `Dockerfile.CMD` or `Dockerfile.ENTRYPOINT` → runtime entry

**Core Modules:**
- List `src/` subdirectories as modules
- For each, identify exports/purpose from code comments or file structure

**Dependencies:**
- External: parse `package.json.dependencies` + `devDependencies`
- Internal: find `import from ../` patterns in tier_1 files

### Step 5: Extract Deployment

**Targets:**
- If `Dockerfile` exists → docker
- If `package.json.scripts.build` → npm/nodejs
- If `pyproject.toml` → pip/pypi
- If `.github/workflows/deploy.yml` → github-pages/github-actions

**CI/CD:**
- Find workflow files in `.github/workflows/`
- Parse provider (github-actions, circle-ci, travis, etc.)

**Environment Vars:**
- From `.env.example` or `.env.sample`
- Parse KEY=VALUE lines, record as required=true if in `.env.example`

### Step 6: Extract Testing

**Frameworks:**
- From `package.json.devDependencies`: jest, mocha, vitest, etc.
- From `pyproject.toml`: pytest, unittest, etc.

**Test Paths:**
- `test/`, `tests/`, `__tests__/`, `spec/`
- List found directories

**Test Commands:**
- From `package.json.scripts`: `npm test`, `npm run test:*`
- From CI workflow files

### Step 7: Build Gaps Array

For every missing critical field, add a gap:
```json
{
  "category": "testing",
  "issue": "GAP: No test framework detected",
  "severity": "warning"
}
```

---

## Copy-Paste Prompt Template

````
You are a DNA extractor. Your task is to parse repository evidence files and produce a complete, schema-compliant DNA extract.

**Critical Rules:**
1. EVERY fact must cite an evidence path (e.g., "package.json#dependencies.express")
2. Never guess. If uncertain, add a GAP: entry
3. Return valid JSON only
4. Validate against repo_dna.schema.json v1.1.0

**Input:**
```json
{
  "scout_output": {{SCOUT_JSON}},
  "file_contents": {
    "package.json": {{PACKAGE_JSON}},
    "pyproject.toml": {{PYPROJECT or null}},
    "Cargo.toml": {{CARGO or null}},
    "Dockerfile": {{DOCKERFILE or null}},
    "README.md": {{README or null}},
    ".env.example": {{ENV_EXAMPLE or null}}
  }
}
```

**Steps:**

1. **Extract Metadata**
   - owner, repo, url, default_branch from scout
   - extracted_at = now
   - schema_version = "1.1.0"
   - evidence_paths = list all files you will read
   - confidence = (facts_with_evidence / total_facts) * 0.8 + 0.2

2. **Extract Tech Stack**
   - Parse package.json → languages, frameworks, runtime, package_managers
   - Parse Dockerfile (if present) → runtime version from FROM
   - Parse Cargo.toml or pyproject.toml if present
   - Every entry needs evidence path

3. **Extract Project Info**
   - name, description from package.json or README
   - purpose: infer from type of repo (lib/app/tool/service/framework)
   - license: from package.json or LICENSE file
   - maturity: infer from last commit date or package.json version

4. **Extract Architecture**
   - entry_points: identify main/bin/src entry files
   - core_modules: list src/ subdirectories + their purposes
   - structure: flat/layered/modular/microservices/monorepo
   - dependencies: parse package.json dependencies + devDependencies

5. **Extract Deployment**
   - targets: docker (if Dockerfile), npm/pypi (if package managers), github-pages (if .github/pages)
   - ci_cd: find .github/workflows files
   - environment_vars: parse .env.example into array

6. **Extract Testing**
   - frameworks: infer from devDependencies (jest, mocha, pytest, etc.)
   - coverage_tool: if any coverage config found
   - test_commands: from package.json.scripts
   - test_paths: find test/, tests/, __tests__/ directories

7. **Build Gaps Array**
   - For each missing critical field, add gap object
   - severity: info/warning/critical
   - Mark with "GAP:" prefix

**Output:** Valid JSON conforming to repo_dna.schema.json v1.1.0

**Validation Checklist:**
- [ ] All string fields are non-empty or null
- [ ] All arrays have at least one item or are empty []
- [ ] confidence is a number between 0.0 and 1.0
- [ ] timestamp is ISO 8601
- [ ] JSON validates against schema
- [ ] No guessing: every fact has evidence_path

**Return:** JSON output only, no markdown fencing.
````

---

## Shell Script (Termux-friendly)

```bash
#!/bin/bash
# dna-extractor.sh
# Usage: ./dna-extractor.sh <scout-json> <owner> <repo> [branch]

SCOUT_JSON=$1
OWNER=$2
REPO=$3
BRANCH=${4:-main}
TOKEN=${GITHUB_TOKEN}

if [ -z "$SCOUT_JSON" ] || [ -z "$OWNER" ] || [ -z "$REPO" ]; then
  echo "Usage: ./dna-extractor.sh <scout-json> <owner> <repo> [branch]"
  exit 1
fi

API="https://api.github.com/repos/${OWNER}/${REPO}"

# Read files from scout output
echo "Extracting DNA for $OWNER/$REPO..."

# Fetch evidence files
PACKAGE_JSON=$(curl -s -H "Authorization: token ${TOKEN}" "$API/contents/package.json?ref=$BRANCH" | jq -r '.content' | base64 -d 2>/dev/null || echo "null")
DOCKERFILE=$(curl -s -H "Authorization: token ${TOKEN}" "$API/contents/Dockerfile?ref=$BRANCH" | jq -r '.content' | base64 -d 2>/dev/null || echo "null")
README=$(curl -s -H "Authorization: token ${TOKEN}" "$API/contents/README.md?ref=$BRANCH" | jq -r '.content' | base64 -d 2>/dev/null || echo "null")
ENV_EXAMPLE=$(curl -s -H "Authorization: token ${TOKEN}" "$API/contents/.env.example?ref=$BRANCH" | jq -r '.content' | base64 -d 2>/dev/null || echo "null")

# Extract tech stack
if [ "$PACKAGE_JSON" != "null" ]; then
  LANGUAGES="[\"JavaScript\"]"
  PACKAGE_MANAGER="npm"
  FRAMEWORKS=$(echo "$PACKAGE_JSON" | jq '.dependencies, .devDependencies | keys' 2>/dev/null || echo "[]")
else
  LANGUAGES="[]"
  FRAMEWORKS="[]"
  PACKAGE_MANAGER="unknown"
fi

# Build minimal DNA JSON
DNA=$(jq -n \
  --arg owner "$OWNER" \
  --arg repo "$REPO" \
  --arg branch "$BRANCH" \
  --argjson languages "$LANGUAGES" \
  --argjson frameworks "$FRAMEWORKS" \
  --arg pm "$PACKAGE_MANAGER" \
  '{
    metadata: {
      owner: $owner,
      repo: $repo,
      url: "https://github.com/\($owner)/\($repo)",
      default_branch: $branch,
      extracted_at: now | todate,
      schema_version: "1.1.0",
      confidence: 0.65
    },
    tech_stack: {
      languages: [{"name": "JavaScript", "primary": true}],
      frameworks: [],
      runtime: {type: "nodejs"},
      package_managers: [$pm]
    },
    project_info: {
      name: $repo,
      purpose: "unknown"
    },
    gaps: [
      {category: "testing", issue: "GAP: test framework not detected", severity: "warning"}
    ]
  }')

echo "$DNA" | jq .
```

---

## Success Example

```json
{
  "metadata": {
    "owner": "byfanzoftheone-stack",
    "repo": "termux-toolkit",
    "url": "https://github.com/byfanzoftheone-stack/termux-toolkit",
    "default_branch": "main",
    "extracted_at": "2026-09-06T16:20:00Z",
    "schema_version": "1.1.0",
    "evidence_paths": [
      "package.json",
      "Dockerfile",
      ".env.example",
      "README.md"
    ],
    "confidence": 0.78
  },
  "tech_stack": {
    "languages": [
      {
        "name": "JavaScript",
        "primary": true,
        "evidence": "package.json exists"
      },
      {
        "name": "TypeScript",
        "primary": false,
        "evidence": "tsconfig.json exists"
      }
    ],
    "frameworks": [
      {
        "name": "express",
        "version": "4.18.2",
        "evidence": "package.json#dependencies.express"
      }
    ],
    "runtime": {
      "type": "nodejs",
      "version": "18.x",
      "evidence": "package.json#engines.node"
    },
    "package_managers": ["npm"]
  },
  "project_info": {
    "name": "termux-toolkit",
    "description": "Toolkit for Android Termux environment",
    "purpose": "tool",
    "maturity": "active",
    "license": "MIT",
    "readme_status": "good"
  },
  "architecture": {
    "entry_points": [
      {
        "type": "cli",
        "path": "bin/cli.js",
        "description": "Command-line interface entry point"
      }
    ],
    "core_modules": [
      {
        "name": "config",
        "path": "src/config",
        "purpose": "Configuration management",
        "exports": ["loadConfig", "validateConfig"]
      }
    ],
    "structure": "modular",
    "dependencies": {
      "external": [
        {
          "name": "express",
          "version": "4.18.2",
          "type": "runtime"
        }
      ]
    }
  },
  "deployment": {
    "targets": ["docker", "npm"],
    "ci_cd": {
      "provider": "github-actions",
      "workflows": [".github/workflows/test.yml", ".github/workflows/build.yml"]
    },
    "environment_vars": [
      {
        "name": "NODE_ENV",
        "required": true,
        "evidence": ".env.example#NODE_ENV"
      }
    ]
  },
  "testing": {
    "frameworks": ["jest"],
    "test_commands": ["npm test", "npm run test:coverage"],
    "test_paths": ["test/", "__tests__/"]
  },
  "gaps": [
    {
      "category": "deployment",
      "issue": "GAP: No deployment target URL documented in README",
      "severity": "info"
    }
  ]
}
```

---

## Next Step

Pass this DNA output to **Skill 3: readme-auditor-skill** to assess README quality.
