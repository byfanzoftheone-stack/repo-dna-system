# Skill 6: Dependency Mapper

**Purpose**: Map and analyze all dependencies, their relationships, versions, and potential conflicts.

**Input**: package.json, Pipfile, Gemfile, Cargo.toml, pom.xml, etc.  
**Output**: `05_dependency_map.json`  
**Time**: 3-5 seconds per repo  
**Confidence**: High (direct from package managers)

---

## Overview

The Dependency Mapper creates a complete dependency graph:

1. **Direct Dependencies** — Packages explicitly listed in manifests
2. **Transitive Dependencies** — Packages required by direct dependencies
3. **Version Analysis** — Detects version conflicts, outdated packages
4. **Circular Dependencies** — Finds problematic dependency cycles
5. **License Compliance** — Identifies incompatible licenses
6. **Supply Chain Risk** — Assesses package health and maintenance

---

## Detection Areas

### 1. Package Manager Detection

**Supported:**
- Node.js: `package.json`, `yarn.lock`, `package-lock.json`
- Python: `requirements.txt`, `Pipfile`, `setup.py`, `pyproject.toml`
- Ruby: `Gemfile`, `Gemfile.lock`
- Rust: `Cargo.toml`, `Cargo.lock`
- Java: `pom.xml`, `build.gradle`
- Go: `go.mod`, `go.sum`
- PHP: `composer.json`, `composer.lock`

### 2. Direct Dependencies

```json
{
  "name": "express",
  "version": "4.18.2",
  "type": "production",
  "purpose": "Web framework",
  "count": 1
}
```

### 3. Transitive Dependencies

```json
{
  "name": "body-parser",
  "version": "1.20.2",
  "type": "transitive",
  "required_by": ["express"],
  "depth": 1
}
```

### 4. Version Conflict Detection

```json
{
  "package": "lodash",
  "requested_versions": ["^3.10.0", "^4.17.21"],
  "conflict_type": "major_version_mismatch",
  "severity": "HIGH",
  "resolution": "Requires manual intervention"
}
```

### 5. Circular Dependencies

```json
{
  "cycle": ["module-a", "module-b", "module-c", "module-a"],
  "severity": "MEDIUM",
  "impact": "Potential runtime errors, harder to test"
}
```

### 6. License Analysis

```json
{
  "package": "lodash",
  "license": "MIT",
  "compatibility": {
    "with_project_license": true,
    "project_license": "MIT",
    "issues": []
  }
}
```

### 7. Supply Chain Health

```json
{
  "package": "express",
  "metrics": {
    "maintenance_score": 92,
    "downloads_per_week": 25000000,
    "last_updated": "2024-01-15",
    "is_maintained": true,
    "is_deprecated": false,
    "security_advisories": 0
  }
}
```

---

## Output Schema

```json
{
  "metadata": {
    "owner": "string",
    "repo": "string",
    "scanned_at": "ISO-8601 timestamp",
    "package_managers": ["npm", "pip"],
    "total_dependencies": 287
  },
  "summary": {
    "direct_count": 42,
    "transitive_count": 245,
    "unique_packages": 287,
    "production_count": 35,
    "dev_count": 7,
    "conflicts": 2,
    "circular_dependencies": 1,
    "outdated_packages": 8
  },
  "direct_dependencies": [
    {
      "name": "express",
      "version": "4.18.2",
      "type": "production",
      "latest_version": "4.18.2",
      "is_outdated": false,
      "purpose": "Web server framework",
      "health": "good"
    }
  ],
  "transitive_dependencies": [
    {
      "name": "body-parser",
      "version": "1.20.2",
      "required_by": ["express"],
      "depth": 1
    }
  ],
  "version_conflicts": [
    {
      "package": "lodash",
      "requested": ["^3.10.0", "^4.17.21"],
      "conflict_type": "major_version",
      "severity": "HIGH"
    }
  ],
  "circular_dependencies": [
    {
      "cycle": ["module-a", "module-b", "module-a"],
      "severity": "MEDIUM"
    }
  ],
  "outdated_packages": [
    {
      "name": "eslint",
      "current": "8.10.0",
      "latest": "8.52.0",
      "major_behind": 0,
      "minor_behind": 42,
      "days_outdated": 180
    }
  ],
  "license_analysis": {
    "project_license": "MIT",
    "licenses_used": ["MIT", "Apache-2.0", "ISC"],
    "incompatible_licenses": [],
    "compliance_score": 100
  },
  "supply_chain": {
    "high_risk_packages": 0,
    "unmaintained_packages": 2,
    "deprecated_packages": 1,
    "packages_with_advisories": 3,
    "recommendations": [
      {
        "package": "old-package",
        "action": "Update or replace",
        "reason": "Package no longer maintained"
      }
    ]
  },
  "dependency_graph": {
    "nodes": 287,
    "edges": 340,
    "graph_depth": 12,
    "most_depended_on": ["lodash", "async", "underscore"]
  }
}
```

---

## Visualization

### Dependency Tree
```
express (4.18.2)
├── body-parser (1.20.2)
│   └── bytes (3.1.2)
├── content-disposition (0.5.4)
├── cookie (0.5.0)
└── finalhandler (1.2.0)
    └── statuses (2.0.1)
```

### Conflict Visualization
```
lodash conflict:
├── express requires: ^4.17.21 ✓
├── underscore requires: ^3.10.0 ✗
└── async requires: ^4.17.20 ✓
```

---

## Implementation Notes

### Tools Used
- `npm list`, `pip show` — Dependency information
- `package-lock.json`, `Pipfile.lock` — Exact versions
- npm registry API — Latest versions, metadata
- License detection — SPDX database

### Performance
- **Single repo**: 3-5 seconds
- **Limited by**: Number of dependencies, API rate limits

### Accuracy
- Direct dependencies: 100%
- Transitive dependencies: 98% (some managed indirectly)
- Version conflicts: 95%
- Circular dependencies: 90% (depends on module structure)

---

## Use Cases

1. **Dependency Audit** — Understand all dependencies in portfolio
2. **Version Planning** — Identify upgrade paths
3. **License Compliance** — Ensure legal compatibility
4. **Security** — Find deprecated/unmaintained packages
5. **Consolidation** — Find duplicate dependencies across projects

---

## Related Skills

- **Skill 5**: Security Auditor (includes dependency vulnerabilities)
- **Skill 7**: Code Quality Analyzer (uses dependency metrics)

