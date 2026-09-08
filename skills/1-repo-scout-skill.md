# Skill 1: repo-scout-skill

**Purpose**: Discover and map repository structure without cloning.

**Speed**: <2 seconds per repo  
**Termux-safe**: GitHub REST API only, no heavy deps

---

## Input Contract

```json
{
  "owner": "string",
  "repo": "string",
  "target_branch": "string (optional, defaults to default_branch)"
}
```

## Output Contract

```json
{
  "owner": "string",
  "repo": "string",
  "scanned_branch": "string",
  "file_inventory": {
    "root_files": ["string"],
    "key_directories": {
      "src": ["string"],
      "lib": ["string"],
      "test": ["string"],
      "tests": ["string"],
      ".github": ["string"],
      "docs": ["string"]
    }
  },
  "evidence_files": {
    "primary": {
      "package.json": "path or null",
      "pyproject.toml": "path or null",
      "Cargo.toml": "path or null",
      "pom.xml": "path or null",
      "go.mod": "path or null",
      "Dockerfile": "path or null",
      "docker-compose.yml": "path or null",
      ".env.example": "path or null",
      "README.md": "path or null",
      ".gitignore": "path or null"
    },
    "workflows": ["string (workflow file paths)"],
    "prompts": ["string (prompt file paths if present)"],
    "agents": ["string (agent file paths if present)"]
  },
  "directory_structure": {
    "description": "Top-level folder names and estimated depths",
    "root_dirs": ["string"],
    "nesting_depth": "number"
  },
  "files_to_read_next": {
    "tier_1_critical": ["string (highest priority files for DNA extraction)"],
    "tier_2_important": ["string"],
    "tier_3_optional": ["string"]
  },
  "timestamp": "ISO 8601",
  "scout_status": "success | partial | error"
}
```

---

## How To Use This Skill

### Copy-Paste Prompt Template

````
You are a repo scout. Your task is to discover the structure of a GitHub repository.

**Input:**
```json
{
  "owner": "{{OWNER}}",
  "repo": "{{REPO}}",
  "target_branch": "{{BRANCH or 'main'}}"
}
```

**Steps:**

1. **Fetch repo metadata** using GitHub REST API `/repos/{owner}/{repo}`
   - Extract: default_branch, visibility, description
   - Record: full URL

2. **Map root files** using `/repos/{owner}/{repo}/contents?ref={branch}`
   - List all files in root directory
   - Record: filename + type (file/dir)

3. **Locate evidence files** (check these paths in order):
   - `package.json`, `pyproject.toml`, `Cargo.toml`, `pom.xml`, `go.mod`
   - `Dockerfile`, `docker-compose.yml`
   - `.env.example`, `README.md`, `.gitignore`
   
4. **Find workflows** by listing `/repos/{owner}/{repo}/contents/.github/workflows?ref={branch}`
   - Record: all `.yml`/`.yaml` file paths
   
5. **Search for prompts and agents** (check these paths):
   - `prompts/`, `agents/`, `.github/copilot/`, `docs/prompts/`
   - List any `.md` or `.txt` files found

6. **Map key directories** (do shallow scan):
   - `src/`, `lib/`, `test/`, `tests/`, `docs/`, `.github/`
   - Use `/repos/{owner}/{repo}/contents/{dir}?ref={branch}`
   - List top-level files/folders in each

7. **Identify tier-1 critical files** for next skill:
   - Files that reveal tech stack, entry points, dependencies
   - Example: `package.json`, `main.ts`, `setup.py`, `Dockerfile`

**Output:** Valid JSON matching the Output Contract above.

**Error Handling:**
- If a file/directory doesn't exist, use `null` or omit the key
- If rate-limited, note it in scout_status: "rate_limited"
- Never guess; always verify via API

**Return:** Complete JSON output only.
````

### Shell Command (Termux-friendly)

```bash
#!/bin/bash
# repo-scout.sh
# Usage: ./repo-scout.sh <owner> <repo> [branch]

OWNER=$1
REPO=$2
BRANCH=${3:-main}
TOKEN=${GITHUB_TOKEN}

if [ -z "$OWNER" ] || [ -z "$REPO" ]; then
  echo "Usage: ./repo-scout.sh <owner> <repo> [branch]"
  exit 1
fi

API="https://api.github.com/repos/${OWNER}/${REPO}"
AUTH_HEADER="Authorization: token ${TOKEN}"

echo "Scouting $OWNER/$REPO..."

# Get repo metadata
REPO_META=$(curl -s -H "$AUTH_HEADER" "$API")
DEFAULT_BRANCH=$(echo "$REPO_META" | jq -r '.default_branch')
BRANCH=${BRANCH:-$DEFAULT_BRANCH}

# Get root files
ROOT_FILES=$(curl -s -H "$AUTH_HEADER" "$API/contents?ref=$BRANCH" | jq '[.[] | {name: .name, type: .type}]')

# Check for evidence files
EVIDENCE_FILES="{}"
for file in package.json pyproject.toml Cargo.toml pom.xml go.mod Dockerfile docker-compose.yml .env.example README.md .gitignore; do
  EXISTS=$(curl -s -H "$AUTH_HEADER" "$API/contents/$file?ref=$BRANCH" | jq 'select(.message == null) | .path')
  if [ ! -z "$EXISTS" ] && [ "$EXISTS" != "null" ]; then
    EVIDENCE_FILES=$(echo "$EVIDENCE_FILES" | jq --arg key "$file" --arg val "$EXISTS" '.[$key] = $val')
  fi
done

# Get workflows
WORKFLOWS=$(curl -s -H "$AUTH_HEADER" "$API/contents/.github/workflows?ref=$BRANCH" 2>/dev/null | jq '[.[] | select(.name | endswith(".yml") or endswith(".yaml")) | .path]' || echo "[]")

# Build output JSON
OUTPUT=$(jq -n \
  --arg owner "$OWNER" \
  --arg repo "$REPO" \
  --arg branch "$BRANCH" \
  --argjson root_files "$ROOT_FILES" \
  --argjson evidence "$EVIDENCE_FILES" \
  --argjson workflows "$WORKFLOWS" \
  '{
    owner: $owner,
    repo: $repo,
    scanned_branch: $branch,
    file_inventory: {root_files: $root_files},
    evidence_files: {primary: $evidence, workflows: $workflows},
    timestamp: now | todate,
    scout_status: "success"
  }')

echo "$OUTPUT" | jq .
```

---

## Validation Checklist

- [ ] `owner` and `repo` are non-empty strings
- [ ] `scanned_branch` matches input or default
- [ ] `evidence_files.primary` contains at least 5 null/value pairs
- [ ] `files_to_read_next.tier_1_critical` has 3-10 paths
- [ ] `timestamp` is ISO 8601
- [ ] `scout_status` is one of: success, partial, error
- [ ] All file paths are strings or null (never empty strings)
- [ ] JSON validates against output schema

## Success Example

```json
{
  "owner": "example-owner",
  "repo": "termux-toolkit",
  "scanned_branch": "main",
  "file_inventory": {
    "root_files": [
      "package.json",
      "README.md",
      "Dockerfile",
      ".gitignore",
      "src",
      "test"
    ]
  },
  "evidence_files": {
    "primary": {
      "package.json": "package.json",
      "pyproject.toml": null,
      "Cargo.toml": null,
      "pom.xml": null,
      "go.mod": null,
      "Dockerfile": "Dockerfile",
      "docker-compose.yml": null,
      ".env.example": null,
      "README.md": "README.md",
      ".gitignore": ".gitignore"
    },
    "workflows": [".github/workflows/test.yml", ".github/workflows/publish.yml"],
    "prompts": [],
    "agents": []
  },
  "files_to_read_next": {
    "tier_1_critical": [
      "package.json",
      "Dockerfile",
      "src/index.ts",
      ".github/workflows/test.yml"
    ],
    "tier_2_important": [
      "README.md",
      "src/cli.ts",
      ".gitignore"
    ],
    "tier_3_optional": [
      "test/basic.test.ts"
    ]
  },
  "timestamp": "2026-09-06T16:15:00Z",
  "scout_status": "success"
}
```

---

## Next Step

Once scout completes, pass the output to **Skill 2: dna-extractor-skill** which reads the tier_1_critical files and builds the full repo DNA.
