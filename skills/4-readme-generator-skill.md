# Skill 4: readme-generator-skill

**Purpose**: Generate comprehensive, forensically-grounded README.md from system analysis.

**Input**: repo_dna.json + readme_audit.json + forensic_report.json  
**Output**: README.rewrite.md (complete, evidence-based documentation)  
**Speed**: <2 seconds per repo  
**Philosophy**: Every section grounded in actual code/config, never speculative

---

## Output Contract

```markdown
# [System Name]

[1-2 sentence system definition from forensic verdict]

- **Status**: [Active|Experimental|Inactive]
- **Maturity**: [Prototype|Experimental|Functional|Pre-production|Production-ready|Mature]
- **Tech Stack**: [primary technologies]
- **Deploy**: [deployment targets]

## What This Does

[From forensic "what_it_can_do_today" + actual_purpose]

## Quick Start

[Minimal setup + run instructions based on evidence]

## Architecture

[From forensic 22_final_system_map]

## Capabilities

[From forensic 3_capability_inventory, maturity-scored]

## Technology Stack

[From forensic 1_system_identity + 2_architecture]

## Setup

[Step-by-step from evidence files]

## Running

[From test commands + CI workflows]

## Testing

[From test frameworks + test_paths]

## Configuration

[From .env.example + environment variables]

## Deployment

[From Dockerfile + CI/CD workflows]

## Data Model

[From forensic 1_system_identity]

## API / Interface

[If applicable, from actual endpoints/exports]

## Security

[From forensic 9_security_audit]

## Production Readiness

[From forensic 10_production_readiness]

## Known Limitations

[From forensic 19_what_is_missing + 18_what_actually_exists]

## Assets & Reusable Components

[From forensic 4_asset_extraction]

## Lineage & History

[From forensic 5_system_lineage if verified history exists]

## Contributing

[From CONTRIBUTING or inferred from repo structure]

## License

[From forensic 1_system_identity or LICENSE file]
```

---

## Section-by-Section Generation Logic

### Section: What This Does

**Source**: forensic_report.json → `23_executive_verdict.what_it_can_do_today`

**Template**:
```markdown
## What This Does

This system can:
- [capability 1]
- [capability 2]
- [capability 3]
...

See [Architecture](#architecture) for how it works.
```

**Rule**: Only list verified capabilities from forensic analysis, never add claims without evidence.

---

### Section: Quick Start

**Source**: repo_dna.json → `metadata.evidence_paths` + `.env.example` + CI workflows

**Template**:
```markdown
## Quick Start

### Prerequisites

[From Dockerfile FROM / package.json engines / pyproject.toml]

### Setup

1. Clone: \`git clone https://github.com/{{owner}}/{{repo}}.git\`
2. [From package.json.scripts.install or setup commands]
3. [From .env.example: copy and configure]
4. [From database schema: if applicable]

### Run

\`\`\`bash
[From package.json.scripts.start or Dockerfile CMD]
\`\`\`

App runs on [port/URL from code evidence]
```

**Rule**: Never invent commands. Extract from package.json, Dockerfile, .env.example only.

---

### Section: Architecture

**Source**: forensic_report.json → `22_final_system_map` + `2_architecture_reconstruction`

**Template**:
```markdown
## Architecture

\`\`\`
[ASCII diagram from forensic analysis]
\`\`\`

### Components

| Component | Location | Purpose | Status |
|-----------|----------|---------|--------|
| [name] | [path] | [purpose] | [functional/experimental] |

### Data Flow

[From forensic 7_data_flow]

### Key Dependencies

[From forensic 6_dependency_graph]
```

---

### Section: Capabilities

**Source**: forensic_report.json → `3_capability_inventory`

**Template**:
```markdown
## Capabilities

| Capability | Category | Maturity | Location |
|-----------|----------|----------|----------|
| [name] | [CORE/SUPPORTING/AI/etc] | [0-5] | [path] |

### Core Features

[Capabilities with maturity >= 3]

### Experimental Features

[Capabilities with maturity 1-2]

### In Development

[Capabilities with maturity = 0 or GAP entries]
```

**Rule**: Maturity scores from forensic analysis only.

---

### Section: Technology Stack

**Source**: forensic_report.json → `1_system_identity` + repo_dna.json → `tech_stack`

**Template**:
```markdown
## Technology Stack

### Languages

- [Language] — [purpose/primary|secondary]

### Frameworks & Libraries

- [Framework] [version] — [purpose]

### Runtime

- [Runtime type] [version]

### Package Managers

- [npm|pip|cargo|etc]

### Databases

- [Type] [version if known]

### Infrastructure

- [Docker|Kubernetes|Serverless|etc]

### CI/CD

- [Provider] — [workflows]
```

---

### Section: Setup

**Source**: .env.example + Dockerfile + package.json + documented procedures

**Template**:
```markdown
## Setup

### 1. Prerequisites

- [Node.js version / Python version / etc]
- [Docker if applicable]
- [Database/service requirements]

### 2. Clone Repository

\`\`\`bash
git clone https://github.com/{{owner}}/{{repo}}.git
cd {{repo}}
\`\`\`

### 3. Install Dependencies

\`\`\`bash
[npm install | pip install -r requirements.txt | cargo build | etc]
\`\`\`

### 4. Environment Configuration

Copy \`.env.example\` to \`.env\` and configure:

\`\`\`bash
cp .env.example .env
\`\`\`

**Required variables**:

| Variable | Type | Example | Notes |
|----------|------|---------|-------|
| [VAR] | [type] | [example] | [notes from .env.example] |

### 5. Database Setup (if applicable)

[From schema.sql or migration files]

\`\`\`bash
[setup commands]
\`\`\`
```

---

### Section: Running

**Source**: package.json scripts + Dockerfile CMD + CI workflows

**Template**:
```markdown
## Running

### Development

\`\`\`bash
[npm run dev | python app.py | cargo run | etc]
\`\`\`

App starts on [http://localhost:PORT]

### Production

\`\`\`bash
[npm run build && npm start | gunicorn app:app | docker run | etc]
\`\`\`

### Using Docker

\`\`\`bash
docker build -t {{repo}} .
docker run -p PORT:PORT {{repo}}
\`\`\`
```

---

### Section: Testing

**Source**: forensic_report.json → `3_capability_inventory` (testing category) + package.json scripts

**Template**:
```markdown
## Testing

### Test Framework

[Jest|Mocha|pytest|unittest|etc]

### Run Tests

\`\`\`bash
[npm test | pytest | cargo test | etc]
\`\`\`

### Test Coverage

\`\`\`bash
[npm run test:coverage | pytest --cov | etc]
\`\`\`

### Test Paths

- [path/to/tests]
- [path/to/integration-tests]

### CI/CD Testing

Automated tests run on:
- [GitHub Actions workflow file]
- Triggers: [on push|on PR|on schedule]
```

---

### Section: Configuration

**Source**: .env.example + Dockerfile ENV + config files

**Template**:
```markdown
## Configuration

### Environment Variables

All configuration via \`.env\`:

\`\`\`bash
[content from .env.example with descriptions]
\`\`\`

**Required**: [list required vars]
**Optional**: [list optional vars with defaults]

### Feature Flags

[If any feature flags exist in code]

### Database Configuration

[From connection strings / setup files]

### Logging

[If applicable]
```

---

### Section: Deployment

**Source**: Dockerfile + .github/workflows + forensic_report.json → `deployment` + `production_readiness`

**Template**:
```markdown
## Deployment

### Targets

- [Docker]
- [npm / PyPI]
- [GitHub Pages]
- [Netlify]
- [Vercel]
- [Custom server]

### Production Readiness

**Score**: [0-100] / Overall Maturity: [level]

**Readiness by category**:

| Aspect | Score | Status |
|--------|-------|--------|
| Functionality | [score] | [✓/⚠/✗] |
| Error Handling | [score] | [✓/⚠/✗] |
| Testing | [score] | [✓/⚠/✗] |
| Security | [score] | [✓/⚠/✗] |
| Scalability | [score] | [✓/⚠/✗] |
| Reliability | [score] | [✓/⚠/✗] |
| Deployment | [score] | [✓/⚠/✗] |
| Monitoring | [score] | [✓/⚠/✗] |
| Documentation | [score] | [✓/⚠/✗] |

**Blockers to production**: [from forensic 10]
**Ready for**: [list applicable use cases]

### Docker Deployment

\`\`\`bash
docker build -t {{owner}}/{{repo}}:latest .
docker push {{owner}}/{{repo}}:latest
\`\`\`

[Additional docker-compose or K8s if applicable]

### Deploy to Netlify / Vercel

[From CI workflow if present]

\`\`\`bash
[git push | deploy command]
\`\`\`

### CI/CD Pipelines

Automated deployment on:

| Workflow | Trigger | Target |
|----------|---------|--------|
| [name] | [push/PR/schedule] | [production/staging] |

**Status**: [badges/links to workflow]

### Database Migrations

[If applicable]

\`\`\`bash
[migration commands]
\`\`\`

### Monitoring & Observability

[If configured]

- Logs: [where]
- Metrics: [what]
- Alerts: [if any]
- Dashboards: [if any]
```

---

### Section: Security

**Source**: forensic_report.json → `9_security_audit`

**Template**:
```markdown
## Security

### Authentication

**Method**: [OAuth|JWT|Basic|None|Custom]

[Description of auth flow]

### Authorization

**Method**: [Role-based|Attribute-based|Custom]

[Description of authorization model]

### Secrets Management

- API Keys: [stored in .env / secrets manager / etc]
- Database Credentials: [stored in .env / secrets manager / etc]
- Tokens: [rotation policy if any]

### Security Status

| Area | Status | Notes |
|------|--------|-------|
| Authentication | [✓/⚠/✗] | [notes] |
| Authorization | [✓/⚠/✗] | [notes] |
| Secrets | [✓/⚠/✗] | [notes] |
| Dependencies | [✓/⚠/✗] | [notes] |

### Known Vulnerabilities

[From forensic 9_security_audit.critical_findings]

[If any critical issues, list them]

### Security Best Practices

[Recommendations from forensic analysis]
```

---

### Section: Known Limitations

**Source**: forensic_report.json → `19_what_is_missing` + `18_what_actually_exists.claimed_but_not_verified`

**Template**:
```markdown
## Known Limitations

### What This Does NOT Do

- [Feature claimed but not verified / not implemented]
- [Limitation 1]
- [Limitation 2]

### Missing P0 Features (Blocking)

- [from forensic 19_what_is_missing.p0_blocking]

### Missing P1 Features (Critical)

- [from forensic 19_what_is_missing.p1_critical]

### Missing P2 Features (Important)

- [from forensic 19_what_is_missing.p2_important]

### Technical Debt

[From forensic 11_technical_debt.must_fix]

### Roadmap

- [ ] [Feature/fix]
- [ ] [Feature/fix]
```

---

### Section: Assets & Reusable Components

**Source**: forensic_report.json → `4_asset_extraction` + `13_reusability_analysis`

**Template**:
```markdown
## Assets & Reusable Components

### High-Value Reusable Assets

| Asset | Type | Location | Reusability | Notes |
|-------|------|----------|-------------|-------|
| [name] | [code/config/pattern] | [path] | [COMMERCIAL/STANDALONE/SHARED/INTERNAL/SYSTEM-ONLY] | [notes] |

### Extraction Guide

To use [asset name] in another project:

1. [Instructions]
2. [Dependencies]
3. [Configuration]

See [path/to/asset] for details.
```

---

## Copy-Paste Prompt Template

````
You are a README generator. Your task is to produce a complete, forensically-grounded README.md from system analysis.

**CRITICAL RULES:**
1. Every section must cite evidence from forensic analysis
2. Never add features not verified in forensic report
3. Never invent commands or configuration
4. Return markdown only
5. Structure must match this template

**Input:**
```json
{
  "owner": "{{OWNER}}",
  "repo": "{{REPO}}",
  "repo_dna": {{DNA_JSON}},
  "readme_audit": {{AUDIT_JSON}},
  "forensic_report": {{FORENSIC_JSON}}
}
```

**Steps:**

1. Extract from forensic_report:
   - 23_executive_verdict → What This Does section
   - 1_system_identity → technology stack, data model
   - 2_architecture_reconstruction → architecture section
   - 3_capability_inventory → capabilities table
   - 10_production_readiness → deployment section
   - 9_security_audit → security section
   - 18_what_actually_exists → known limitations
   - 4_asset_extraction → assets section

2. Extract from repo_dna:
   - metadata.evidence_paths → what files to reference
   - tech_stack → technologies
   - testing → test frameworks
   - deployment → deployment targets
   - environment_vars → configuration section

3. For Quick Start / Setup / Run sections:
   - Read from package.json.scripts
   - Read from Dockerfile CMD/ENTRYPOINT
   - Read from .env.example
   - Read from CI workflow files
   - Never invent commands

4. Generate sections in this order:
   - Title + Summary
   - What This Does
   - Quick Start
   - Architecture
   - Capabilities
   - Technology Stack
   - Setup
   - Running
   - Testing
   - Configuration
   - Deployment
   - Data Model (if applicable)
   - API / Interface (if applicable)
   - Security
   - Production Readiness
   - Known Limitations
   - Assets & Reusable Components
   - Lineage (if verified history exists)
   - Contributing
   - License

5. Validation:
   - [ ] No claimed features without evidence
   - [ ] All commands are from code/config files
   - [ ] All paths are real (from repo_dna evidence_paths)
   - [ ] Security section only lists findings from forensic audit
   - [ ] Capabilities have maturity scores from forensic inventory

**Output:** Complete markdown README only.
````

---

## Shell Script Integration

```bash
#!/bin/bash
# readme-generator.sh
# Usage: ./readme-generator.sh <forensic-json> <dna-json> <owner> <repo>

FORENSIC_JSON=$1
DNA_JSON=$2
OWNER=$3
REPO=$4

if [ -z "$FORENSIC_JSON" ] || [ -z "$OWNER" ]; then
  echo "Usage: ./readme-generator.sh <forensic-json> <dna-json> <owner> <repo>"
  exit 1
fi

echo "Generating README for $OWNER/$REPO..."

# Extract key data from JSONs
SYSTEM_NAME=$(jq -r '.1_system_identity.system_name' "$FORENSIC_JSON")
SYSTEM_DEF=$(jq -r '.1_system_identity.system_definition_paragraph' "$FORENSIC_JSON")
MATURITY=$(jq -r '.10_production_readiness.maturity_level' "$FORENSIC_JSON")
TECH_STACK=$(jq -r '.1_system_identity.technology_stack | join(", ")' "$FORENSIC_JSON")

# Build README markdown
README=$(cat <<EOF
# $SYSTEM_NAME

$SYSTEM_DEF

- **Status**: Active
- **Maturity**: $MATURITY
- **Tech Stack**: $TECH_STACK

## What This Does

$(jq -r '.23_executive_verdict.what_it_can_do_today | map("- " + .) | join("\n")' "$FORENSIC_JSON")

## Quick Start

[See Setup section below]

## Architecture

[Architecture diagram from forensic analysis]

## Setup

[Step-by-step setup instructions]

## Running

[Run instructions from package.json or Dockerfile]

## Testing

[Test instructions]

## Configuration

[Environment variables from .env.example]

## Deployment

[Deployment instructions]

## Known Limitations

$(jq -r '.23_executive_verdict.what_it_cannot_do | map("- " + .) | join("\n")' "$FORENSIC_JSON")

## License

[License from repo_dna]
EOF
)

echo "$README"
```

---

## Success Example

```markdown
# BookPro — Service Booking App

A phone-first, browser-based service booking application designed for small businesses. It operates entirely in local storage by default and can be deployed from a smartphone directly to Netlify without build tools. Features include a monthly calendar with visual booking status (blue dots for bookings, red for cancellations), multi-user support with employee PINs, customizable branding, and optional Supabase integration for multi-tenant SaaS capabilities.

- **Status**: Active
- **Maturity**: Functional
- **Tech Stack**: HTML, CSS, JavaScript, Supabase (optional)
- **Deploy**: Netlify (phone-friendly drag-and-drop)

## What This Does

- Book appointments with visual calendar feedback
- Cancel/reschedule with dot state updates
- Deploy from phone via Netlify drag-and-drop
- Customize colors/logos via settings
- Employee clock in/out with PIN
- Generate quotes using saved branding

## Quick Start

### Deploy from Phone (3 minutes)

1. Open https://github.com/byfanzoftheone-stack/bookpro-booking-app
2. Tap **Code → Download ZIP**
3. Unzip in Files
4. Go to [netlify.com/drop](https://app.netlify.com/drop)
5. Drop the unzipped folder
6. Site is live

## Architecture

```
┌─────────────────┐
│  Phone Browser  │
└────────┬────────┘
         │
    ┌────v────────────┐
    │  Local Storage   │
    └────┬────────────┘
         │
    ┌────v────────────┐
    │ Booking Calendar│
    │  & Forms        │
    └────┬────────────┘
         │
    ┌────v────────────┐
    │ Supabase API    │  (optional)
    │ (multi-tenant)  │
    └─────────────────┘
```

...
```

---

## Next Step

Pass README.rewrite.md to **Skill 5: asset-extractor-skill** for detailed asset inventory.
