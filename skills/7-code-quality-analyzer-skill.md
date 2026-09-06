# Skill 7: Code Quality Analyzer

**Purpose**: Assess code health, complexity, test coverage, and identify technical debt.

**Input**: Source code files, test files, git history  
**Output**: `06_code_quality.json`  
**Time**: 8-12 seconds per repo  
**Confidence**: High (metric-based)

---

## Overview

The Code Quality Analyzer examines code from multiple angles:

1. **Code Metrics** — Lines of code, cyclomatic complexity, maintainability
2. **Test Coverage** — Unit test presence, coverage percentage, test quality
3. **Code Smells** — Duplicated code, long functions, complexity hotspots
4. **Documentation** — Comment coverage, docstring presence, README quality
5. **Commit Patterns** — Git activity, code churn, stability indicators
6. **Technical Debt** — Estimated effort to fix issues, SQALE rating

---

## Metrics Categories

### 1. Code Metrics

**Lines of Code (LOC)**
```json
{
  "total_lines": 15240,
  "code_lines": 11500,
  "comment_lines": 1200,
  "blank_lines": 2540,
  "comment_ratio": 0.094
}
```

**Complexity Metrics**
```json
{
  "cyclomatic_complexity": {
    "average": 3.2,
    "maximum": 18,
    "high_complexity_functions": 12,
    "rating": "B"
  },
  "cognitive_complexity": {
    "average": 2.1,
    "maximum": 14
  }
}
```

**Function Metrics**
```json
{
  "total_functions": 342,
  "average_function_length": 35,
  "longest_function": 142,
  "average_parameters": 2.3,
  "deep_nesting_levels": 5
}
```

### 2. Test Coverage

```json
{
  "coverage_percentage": 68,
  "unit_test_count": 245,
  "integration_test_count": 18,
  "e2e_test_count": 8,
  "coverage_by_file": [
    {
      "file": "src/auth/login.js",
      "coverage": 92,
      "lines_covered": 115,
      "lines_total": 125
    }
  ],
  "test_framework": "jest",
  "coverage_trend": "increasing"
}
```

### 3. Code Smells

**Duplication**
```json
{
  "duplication_percentage": 8.2,
  "duplicate_blocks": 24,
  "duplicate_lines": 945,
  "largest_duplication": 120,
  "files_with_duplication": 8
}
```

**Long Functions**
```json
{
  "functions_over_100_lines": 3,
  "functions_over_200_lines": 1,
  "refactoring_candidates": [
    {
      "file": "src/processing.js",
      "function": "processData",
      "lines": 245,
      "complexity": 16
    }
  ]
}
```

**Long Conditionals**
```json
{
  "conditions_over_5_branches": 7,
  "nested_depth_avg": 2.3,
  "nested_depth_max": 6
}
```

### 4. Documentation Quality

```json
{
  "comment_coverage": 0.094,
  "docstring_coverage": 0.42,
  "readme_quality_score": 75,
  "api_documentation": "partial",
  "changelog_present": true,
  "contributing_guide": true,
  "architecture_doc": false,
  "undocumented_public_apis": 12
}
```

### 5. Commit Patterns

```json
{
  "total_commits": 1247,
  "commits_last_month": 84,
  "commits_last_week": 12,
  "average_commits_per_day": 2.1,
  "commit_frequency": "active",
  "code_churn": {
    "additions_per_commit": 45,
    "deletions_per_commit": 23,
    "stability_score": 0.75
  },
  "contributors": 8,
  "last_commit_age_days": 2
}
```

### 6. Technical Debt

```json
{
  "sqale_rating": "C",
  "technical_debt_days": 18,
  "debt_ratio": 0.15,
  "maintainability_index": 68,
  "issues_by_priority": {
    "critical": 2,
    "major": 8,
    "minor": 24,
    "info": 45
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
    "languages": ["JavaScript", "Python"],
    "total_files": 487
  },
  "summary": {
    "overall_score": 68,
    "grade": "B-",
    "quality_trend": "improving",
    "last_assessment_date": "2026-09-06"
  },
  "code_metrics": {
    "lines_of_code": 15240,
    "code_lines": 11500,
    "comment_lines": 1200,
    "comment_ratio": 0.094,
    "files_by_language": {
      "JavaScript": {
        "files": 120,
        "lines": 8500
      },
      "Python": {
        "files": 45,
        "lines": 4200
      }
    }
  },
  "complexity": {
    "cyclomatic_complexity_avg": 3.2,
    "cyclomatic_complexity_max": 18,
    "cognitive_complexity_avg": 2.1,
    "high_complexity_functions": 12,
    "complexity_rating": "B"
  },
  "functions": {
    "total": 342,
    "average_length": 35,
    "longest": 142,
    "average_parameters": 2.3,
    "max_nesting_depth": 5
  },
  "test_coverage": {
    "overall_coverage": 68,
    "unit_tests": 245,
    "integration_tests": 18,
    "e2e_tests": 8,
    "test_framework": "jest",
    "coverage_trend": "increasing",
    "uncovered_critical_paths": 5
  },
  "code_smells": {
    "duplication_percentage": 8.2,
    "duplicate_blocks": 24,
    "duplicate_lines": 945,
    "long_functions": 3,
    "long_classes": 2,
    "long_parameter_lists": 7,
    "high_nesting": 12
  },
  "documentation": {
    "comment_coverage": 0.094,
    "docstring_coverage": 0.42,
    "readme_score": 75,
    "api_documentation_status": "partial",
    "changelog_present": true,
    "contributing_guide": true,
    "architecture_doc": false,
    "undocumented_public_apis": 12
  },
  "commit_patterns": {
    "total_commits": 1247,
    "commits_last_30_days": 84,
    "commits_last_7_days": 12,
    "average_commits_per_day": 2.1,
    "activity_level": "active",
    "contributors": 8,
    "last_commit_age_days": 2,
    "commit_frequency_trend": "stable"
  },
  "technical_debt": {
    "sqale_rating": "C",
    "estimated_days": 18,
    "debt_ratio": 0.15,
    "maintainability_index": 68,
    "critical_issues": 2,
    "major_issues": 8,
    "minor_issues": 24,
    "total_issues": 34
  },
  "quality_hotspots": [
    {
      "file": "src/processing.js",
      "issues": ["high_complexity", "long_function", "low_test_coverage"],
      "priority": "high",
      "estimated_fix_effort": "4 hours"
    }
  ],
  "recommendations": [
    {
      "priority": "high",
      "issue": "High cyclomatic complexity in processing.js",
      "impact": "Hard to test and maintain",
      "action": "Refactor into smaller functions",
      "estimated_effort": "4 hours"
    }
  ],
  "trend": {
    "quality_improving": true,
    "coverage_trend": "increasing",
    "debt_trend": "decreasing",
    "code_churn": "stable"
  }
}
```

---

## Quality Grades

| Score | Grade | Interpretation |
|-------|-------|-----------------|
| 90-100 | A | Excellent quality, well-maintained |
| 80-89 | B | Good quality, minor issues |
| 70-79 | C | Fair quality, some refactoring needed |
| 60-69 | D | Poor quality, significant debt |
| < 60 | F | Critical issues, needs major work |

---

## Implementation Notes

### Tools Used
- ESLint, Pylint, Rubocop — Linting & complexity
- Istanbul, Coverage.py — Test coverage
- SonarQube — SQALE rating, technical debt
- Git log analysis — Commit patterns
- Regex/AST analysis — Code metrics

### Performance
- **Single repo**: 8-12 seconds
- **Limited by**: Repository size, complexity analysis time

### Accuracy
- Code metrics: 100% (deterministic)
- Complexity: 95% (depends on language parser)
- Test coverage: 100% (from coverage reports)
- Code smells: 85% (some heuristic-based)

---

## Use Cases

1. **Quality Gate** — Enforce minimum quality standards
2. **Risk Assessment** — Identify high-risk areas
3. **Refactoring Priority** — Know where to focus effort
4. **Trend Tracking** — Monitor quality over time
5. **Team Metrics** — Compare quality across repos

---

## Related Skills

- **Skill 6**: Dependency Mapper (includes dependency health)
- **Skill 5**: Security Auditor (includes code vulnerabilities)
- **Skill 8**: Asset Extractor (evaluates reusability)

