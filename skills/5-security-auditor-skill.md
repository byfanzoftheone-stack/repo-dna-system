# Skill 5: Security Auditor

**Purpose**: Scan repositories for security vulnerabilities, misconfigurations, and compliance issues.

**Input**: Repository files, GitHub settings, dependency manifests  
**Output**: `04_security_audit.json`  
**Time**: 5-8 seconds per repo  
**Confidence**: Medium (requires manual review for critical findings)

---

## Overview

The Security Auditor performs automated security scanning across multiple dimensions:

1. **Secret Detection** — Finds hardcoded API keys, tokens, credentials
2. **Dependency Vulnerabilities** — Scans for known CVEs in dependencies
3. **Code Vulnerabilities** — Identifies common security anti-patterns
4. **GitHub Security** — Checks branch protection, 2FA, access controls
5. **Infrastructure Secrets** — Finds exposed AWS keys, credentials in configs
6. **Compliance Issues** — Detects missing security headers, CORS issues

---

## Detection Categories

### 1. Secret Detection

**Patterns Scanned:**
```
- AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY
- GITHUB_TOKEN, GITHUB_PAT
- DATABASE_URL with credentials
- API_KEY patterns
- PRIVATE_KEY, RSA KEY patterns
- JWT secrets in code
- Slack tokens, Discord webhooks
- .env files with sensitive data
```

**Output:**
```json
{
  "secret_type": "aws_key",
  "file_path": "config/production.js",
  "line_number": 42,
  "risk_level": "CRITICAL",
  "exposure": "git_history",
  "recommendation": "Rotate key, use AWS Secrets Manager"
}
```

### 2. Dependency Vulnerabilities

**Data Source**: npm audit, pip audit, bundle audit, cargo audit

**Checks:**
- High/Critical severity CVEs
- Unmaintained dependencies
- Known exploited vulnerabilities
- Deprecated packages

**Output:**
```json
{
  "dependency": "lodash",
  "version": "3.10.1",
  "vulnerability_id": "CVE-2021-23337",
  "severity": "HIGH",
  "description": "Prototype pollution in lodash",
  "fix_version": "4.17.21",
  "exploit_available": true
}
```

### 3. Code Vulnerability Patterns

**Patterns:**
```
- SQL injection vulnerabilities
- XSS vulnerabilities
- Unsafe deserialization
- Command injection risks
- Buffer overflow risks
- Insecure random number generation
- Hardcoded authentication
- Missing input validation
```

### 4. GitHub Security Settings

**Checks:**
- Branch protection enabled
- Require code review
- Require status checks
- Require signed commits
- Enforce admins
- Repository visibility (private/public)
- Two-factor authentication
- Collaborator access levels

### 5. Infrastructure & Configuration Secrets

**Scans:**
- Docker files for secrets
- Kubernetes manifests
- Terraform files
- CloudFormation templates
- .env files
- Configuration files (config.json, settings.py)
- CI/CD files (.github/workflows, .gitlab-ci.yml)

### 6. Compliance Issues

**Checks:**
- License information
- Copyright headers
- Security policy (SECURITY.md)
- Privacy policy
- Terms of service
- Data retention policies

---

## Output Schema

```json
{
  "metadata": {
    "owner": "string",
    "repo": "string",
    "scanned_at": "ISO-8601 timestamp",
    "scan_version": "1.0.0",
    "confidence": 0.75
  },
  "summary": {
    "total_findings": 12,
    "critical": 2,
    "high": 4,
    "medium": 5,
    "low": 1,
    "overall_risk_level": "HIGH"
  },
  "secret_detection": {
    "secrets_found": 2,
    "findings": [
      {
        "type": "aws_key",
        "file": "src/config.js",
        "line": 42,
        "risk": "CRITICAL",
        "exposure": "git_history",
        "age_days": 180
      }
    ]
  },
  "dependency_vulnerabilities": {
    "total_dependencies": 287,
    "vulnerable_packages": 4,
    "findings": [
      {
        "package": "lodash",
        "version": "3.10.1",
        "cve": "CVE-2021-23337",
        "severity": "HIGH",
        "fix_available": true,
        "fix_version": "4.17.21"
      }
    ]
  },
  "code_vulnerabilities": {
    "patterns_found": 6,
    "findings": [
      {
        "type": "sql_injection",
        "file": "src/db.js",
        "line": 156,
        "severity": "HIGH",
        "example": "query('SELECT * FROM users WHERE id = ' + userId)"
      }
    ]
  },
  "github_security": {
    "branch_protection": false,
    "require_code_review": false,
    "require_status_checks": false,
    "require_signed_commits": false,
    "enforce_admins": false,
    "is_private": false,
    "has_2fa": false,
    "findings": [
      {
        "setting": "branch_protection",
        "status": "disabled",
        "recommendation": "Enable branch protection on main"
      }
    ]
  },
  "infrastructure_secrets": {
    "findings": [
      {
        "file": "docker-compose.yml",
        "type": "database_password",
        "risk": "HIGH"
      }
    ]
  },
  "compliance": {
    "has_security_policy": false,
    "has_license": true,
    "has_coc": false,
    "missing_items": ["SECURITY.md", "CODE_OF_CONDUCT.md"]
  },
  "critical_findings": [
    {
      "id": 1,
      "title": "AWS credentials exposed in git history",
      "severity": "CRITICAL",
      "impact": "Account takeover, data breach",
      "remediation": "Rotate credentials, use AWS Secrets Manager, clean git history"
    }
  ],
  "recommendations": [
    {
      "priority": "CRITICAL",
      "action": "Rotate AWS credentials immediately",
      "effort": "15 minutes",
      "impact": "Prevents account compromise"
    }
  ]
}
```

---

## Implementation Notes

### Tools Used
- `git-secrets` — Secret pattern detection
- `npm audit`, `pip audit`, etc. — Dependency scanning
- Pattern matching — Code vulnerability detection
- GitHub API — Security settings checks
- Regex patterns — Configuration scanning

### Performance
- **Single repo**: 5-8 seconds
- **Limited by**: GitHub API rate limits, git history size

### Accuracy Notes
- Secret detection: ~85% precision (some false positives from test data)
- Dependency scanning: ~95% accuracy (depends on package manager data)
- Code patterns: ~70% precision (requires manual review)
- GitHub settings: 100% accuracy (direct API checks)

### False Positives
- Test credentials (intentionally hardcoded)
- Example code with mock keys
- Regex false positives in strings
- Documentation examples with secrets

**Mitigation:**
- Allow .securityignore file for exclusions
- Provide context for each finding
- Recommend manual review for critical issues

---

## Next Steps

1. **Integration**: Add to orchestrator.sh after Skill 4
2. **Enhancement**: Add Snyk integration for better vulnerability data
3. **Automation**: Integrate with GitHub security scanning
4. **Reporting**: Generate security dashboard

---

## Related Skills

- **Skill 6**: Dependency Mapper (detailed dependency analysis)
- **Skill 3.5**: Forensic Auditor (includes security assessment)

