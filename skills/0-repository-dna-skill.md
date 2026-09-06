# Skill 0: Repository DNA (Core Synthesis Skill)

**Purpose**: Synthesize intelligence from all 8 analysis skills into unified, actionable intelligence reports.

**Input**: Individual skill outputs (JSON files from Skills 1-8)  
**Output**: `02_repo_dna.json` + Executive Summary  
**Time**: 2-3 seconds (synthesis only, after all skills run)  
**Confidence**: High (deterministic aggregation + intelligent synthesis)

---

## Overview

The Repository DNA Skill is the **synthesis engine** that unifies insights from all 8 specialized skills into a comprehensive genetic fingerprint of any codebase.

Think of it as the **cortex** that takes input from 8 specialized organs (Scout, README, Forensic, Security, Dependencies, Quality, Assets, Architecture) and creates a unified intelligence picture.

---

## Input Data Model

```json
{
  "skill_1_scout": {
    "fileCount": 342,
    "languages": ["JavaScript", "Python", "Markdown"],
    "primaryLanguage": "JavaScript",
    "repoType": "web-application",
    "size_mb": 45.2
  },
  
  "skill_2_readme": {
    "qualityScore": 72,
    "completeness": 0.68,
    "missingSections": ["API Documentation", "Troubleshooting"],
    "readability": "good"
  },
  
  "skill_3_forensic": {
    "patterns_found": 34,
    "antiPatterns": 12,
    "codeSmells": 23,
    "risks": ["tight_coupling", "low_modularity"],
    "insights": ["heavy_framework_dependency", "good_separation_of_concerns"]
  },
  
  "skill_4_security": {
    "secretsFound": 2,
    "vulnerabilities": {
      "critical": 1,
      "high": 3,
      "medium": 8,
      "low": 15
    },
    "complianceIssues": ["missing_security_headers"],
    "grade": "B+"
  },
  
  "skill_5_dependency": {
    "totalDependencies": 47,
    "outdated": 8,
    "vulnerableDependencies": 5,
    "licenseCompliance": "compliant",
    "supplyChainHealth": 0.78
  },
  
  "skill_6_quality": {
    "overallScore": 72,
    "complexity": 3.4,
    "testCoverage": 68,
    "technicalDebt": 18,
    "debtDays": 288
  },
  
  "skill_7_assets": {
    "extractableAssets": 12,
    "highValueAssets": 5,
    "reusabilityScore": 7.8,
    "duplications": 3,
    "extractionEffort": "medium"
  },
  
  "skill_8_architecture": {
    "pattern": "layered_mvc",
    "layers": 4,
    "components": 42,
    "couplingScore": 0.62,
    "cohesionScore": 0.78
  }
}
```

---

## Synthesis Algorithm

### Phase 1: Normalization
Convert all skill outputs to standardized scores (0-100):

```javascript
const normalize = (skillData) => {
  return {
    scout: normalizeScout(skillData.skill_1),
    readme: normalizeReadme(skillData.skill_2),
    forensic: normalizeForensic(skillData.skill_3),
    security: normalizeSecurity(skillData.skill_4),
    dependency: normalizeDependency(skillData.skill_5),
    quality: normalizeQuality(skillData.skill_6),
    assets: normalizeAssets(skillData.skill_7),
    architecture: normalizeArchitecture(skillData.skill_8)
  };
};
```

### Phase 2: Dimension Analysis
Analyze 9 key dimensions:

```javascript
const analyzeDimensions = (normalizedData) => {
  return {
    // 1. Code Quality Dimension (40% weight)
    quality: {
      score: (quality.overallScore * 0.4) + (forensic.patterns * 0.3) + (architecture.cohesion * 0.3),
      status: "good|fair|poor",
      trend: "improving|stable|declining"
    },
    
    // 2. Security Dimension (25% weight)
    security: {
      score: (security.grade * 0.6) + (dependency.vulnerabilities * 0.25) + (forensic.risks * 0.15),
      status: "secure|caution|at-risk",
      threats: ["secrets_found", "outdated_deps", ...]
    },
    
    // 3. Maintenance Dimension (20% weight)
    maintenance: {
      score: (quality.testCoverage * 0.4) + (readme.completeness * 0.3) + (quality.complexity * 0.3),
      status: "easy|moderate|difficult",
      burden: "light|medium|heavy"
    },
    
    // 4. Reusability Dimension (15% weight)
    reusability: {
      score: assets.reusabilityScore,
      extractableCount: assets.extractableAssets,
      opportunities: assets.duplications
    },
    
    // 5. Scalability Dimension (20% weight)
    scalability: {
      score: (architecture.cohesion * 0.5) + (quality.complexity * 0.3) + (dependency.health * 0.2),
      status: "scalable|moderate|constrained",
      bottlenecks: ["tight_coupling", ...]
    },
    
    // 6. Documentation Dimension (15% weight)
    documentation: {
      score: readme.qualityScore,
      completeness: readme.completeness,
      readability: readme.readability,
      gaps: readme.missingSections
    },
    
    // 7. Modularity Dimension (18% weight)
    modularity: {
      score: architecture.cohesionScore,
      components: architecture.components,
      couplingLevel: architecture.couplingScore,
      refactoringNeeded: couplingScore > 0.7
    },
    
    // 8. Dependency Health Dimension (12% weight)
    dependencies: {
      score: dependency.supplyChainHealth,
      outdated: dependency.outdated,
      vulnerableCount: dependency.vulnerableDependencies,
      licenseCompliance: dependency.licenseCompliance
    },
    
    // 9. Architectural Pattern Dimension (10% weight)
    architecture: {
      pattern: architecture.pattern,
      maturity: "mature|evolving|experimental",
      alignment: "aligned|misaligned|evolving"
    }
  };
};
```

### Phase 3: Risk Assessment
Identify and score risks:

```javascript
const assessRisks = (dimensions) => {
  return {
    critical: [
      // Security threats, data loss risks, compliance issues
    ],
    high: [
      // Technical debt > 2 weeks, coupling > 0.8, test coverage < 30%
    ],
    medium: [
      // Outdated dependencies, missing documentation sections
    ],
    low: [
      // Code style issues, non-critical patterns
    ]
  };
};
```

### Phase 4: Synthesis to DNA Report
Combine all dimensions into unified intelligence:

```javascript
const synthesizeDNA = (dimensions, risks) => {
  return {
    overallScore: calculateWeightedScore(dimensions),
    grade: scoreToGrade(overallScore),
    healthStatus: deriveHealthStatus(dimensions, risks),
    keyFindings: extractKeyFindings(dimensions),
    recommendations: generateRecommendations(dimensions, risks),
    actionPriorities: rankActions(dimensions, risks)
  };
};
```

---

## Output Schema

```json
{
  "metadata": {
    "owner": "string",
    "repo": "string",
    "scanned_at": "ISO-8601 timestamp",
    "dna_version": "2.0",
    "skills_used": [1, 2, 3, 4, 5, 6, 7, 8],
    "synthesis_time_ms": 1250
  },
  
  "executive_summary": {
    "overall_score": 72,
    "grade": "C+",
    "health_status": "stable",
    "maintenance_burden": "medium",
    "security_posture": "B+",
    "readiness": {
      "production": true,
      "scaling": "medium-readiness",
      "refactoring": "needed-soon"
    }
  },
  
  "dimensions": {
    "quality": {
      "score": 72,
      "status": "good",
      "complexity": 3.4,
      "details": "Well-structured with some technical debt"
    },
    "security": {
      "score": 78,
      "status": "secure",
      "threats": ["outdated_dependencies"],
      "details": "Good practices, 1 secret found, fix immediately"
    },
    "maintenance": {
      "score": 68,
      "status": "moderate",
      "test_coverage": 68,
      "details": "Good documentation, moderate test coverage"
    },
    "reusability": {
      "score": 78,
      "extractable_components": 12,
      "high_value": 5,
      "details": "Several reusable components identified"
    },
    "scalability": {
      "score": 71,
      "status": "moderate",
      "bottlenecks": ["tight_coupling_in_core"],
      "details": "Can scale with some refactoring"
    },
    "documentation": {
      "score": 72,
      "completeness": 68,
      "gaps": ["API_docs", "architecture_guide"],
      "details": "README good, missing API documentation"
    },
    "modularity": {
      "score": 78,
      "coupling": 0.62,
      "components": 42,
      "details": "Well-modularized with reasonable coupling"
    },
    "dependencies": {
      "score": 75,
      "outdated": 8,
      "vulnerabilities": 5,
      "compliance": "compliant",
      "details": "Supply chain health good, update 8 packages"
    },
    "architecture": {
      "pattern": "layered_mvc",
      "maturity": "mature",
      "alignment": "aligned",
      "details": "Clear layered architecture, well-executed"
    }
  },
  
  "key_findings": [
    {
      "finding": "Good foundational architecture",
      "impact": "high",
      "source": ["architecture", "modularity"]
    },
    {
      "finding": "Technical debt accumulating (18 days estimated)",
      "impact": "high",
      "source": ["quality", "forensic"]
    },
    {
      "finding": "Security: 1 secret detected, needs immediate remediation",
      "impact": "critical",
      "source": ["security"]
    },
    {
      "finding": "12 reusable assets identified for extraction",
      "impact": "medium",
      "source": ["assets"]
    }
  ],
  
  "risks": {
    "critical": [
      {
        "issue": "Hardcoded API key found",
        "severity": 10,
        "location": "src/config/secrets.js:42",
        "action": "Rotate immediately, move to environment"
      }
    ],
    "high": [
      {
        "issue": "Test coverage below 70%",
        "severity": 8,
        "locations": ["src/services/", "src/utils/"],
        "action": "Add unit tests for untested modules"
      },
      {
        "issue": "3 outdated critical dependencies",
        "severity": 7,
        "packages": ["express@4.17", "lodash@4.17"],
        "action": "Update to latest versions, test thoroughly"
      }
    ],
    "medium": [
      {
        "issue": "Tight coupling in authentication module",
        "severity": 6,
        "locations": ["src/auth/"],
        "action": "Extract shared concerns, reduce dependencies"
      }
    ]
  },
  
  "recommendations": [
    {
      "priority": "immediate",
      "category": "security",
      "action": "Remove hardcoded secrets from codebase",
      "effort": "2 hours",
      "impact": "high"
    },
    {
      "priority": "immediate",
      "category": "dependencies",
      "action": "Update 8 outdated packages",
      "effort": "4 hours",
      "impact": "medium"
    },
    {
      "priority": "this-week",
      "category": "testing",
      "action": "Increase test coverage to 80%+",
      "effort": "16 hours",
      "impact": "high"
    },
    {
      "priority": "this-month",
      "category": "documentation",
      "action": "Add API documentation and architecture guide",
      "effort": "12 hours",
      "impact": "medium"
    },
    {
      "priority": "next-sprint",
      "category": "refactoring",
      "action": "Reduce coupling in auth module",
      "effort": "24 hours",
      "impact": "high"
    },
    {
      "priority": "backlog",
      "category": "assets",
      "action": "Extract and open-source 5 high-value components",
      "effort": "32 hours",
      "impact": "medium"
    }
  ],
  
  "action_priorities": {
    "immediate": [
      {
        "action": "Fix security issue (hardcoded secret)",
        "effort": "2h",
        "impact": "critical"
      }
    ],
    "this-week": [
      {
        "action": "Update outdated dependencies",
        "effort": "4h",
        "impact": "high"
      },
      {
        "action": "Increase test coverage",
        "effort": "16h",
        "impact": "high"
      }
    ],
    "this-month": [
      {
        "action": "Add API documentation",
        "effort": "12h",
        "impact": "medium"
      },
      {
        "action": "Refactor auth module",
        "effort": "24h",
        "impact": "high"
      }
    ]
  },
  
  "scorecard": {
    "overall": 72,
    "by_dimension": {
      "quality": 72,
      "security": 78,
      "maintenance": 68,
      "reusability": 78,
      "scalability": 71,
      "documentation": 72,
      "modularity": 78,
      "dependencies": 75,
      "architecture": 85
    },
    "trend": "stable",
    "last_analysis": "2026-09-06",
    "previous_score": 70,
    "change": "+2 points"
  },
  
  "comparative_insights": {
    "vs_industry_average": {
      "quality": "+5 points above average",
      "security": "at average",
      "maintenance": "-3 points below average",
      "overall": "+2 points above average"
    },
    "vs_similar_projects": {
      "comparable_repos": 12,
      "percentile": 65,
      "strengths": ["architecture", "modularity"],
      "weaknesses": ["documentation", "test_coverage"]
    }
  },
  
  "narrative_summary": {
    "opening": "BookPro is a well-architected web application with solid foundations in modularity and security practices. The layered MVC pattern is clearly implemented and the codebase demonstrates good separation of concerns.",
    
    "strengths": [
      "Strong architectural foundation (layered MVC, 85/100)",
      "Good modularity and component organization (78/100)",
      "Security-conscious design with comprehensive auditing",
      "Excellent dependency management (compliant licenses)",
      "12 reusable components identified for extraction"
    ],
    
    "challenges": [
      "Accumulating technical debt (18 days estimated work)",
      "1 hardcoded secret detected requiring immediate remediation",
      "Test coverage below optimal (68%, target 85%)",
      "Documentation gaps (missing API docs and architecture guide)",
      "Tight coupling in authentication module limiting scalability"
    ],
    
    "opportunities": [
      "Extract and open-source 5 high-value components",
      "Consolidate duplicate utility functions",
      "Reduce complexity in core services through refactoring",
      "Improve test coverage and add integration tests",
      "Create comprehensive architecture documentation"
    ],
    
    "outlook": "With targeted effort on immediate security fixes and technical debt reduction, BookPro can reach A-grade status within 2-3 months. The solid architecture provides a strong foundation for scaling and evolution. Focus should be on: (1) Security remediation, (2) Test coverage improvement, (3) Dependency updates, (4) Documentation enhancement."
  },
  
  "next_analysis": {
    "recommended_timing": "2 weeks",
    "focus_areas": [
      "Verify security issue remediation",
      "Track test coverage improvement",
      "Monitor dependency updates"
    ],
    "tracking_metrics": {
      "security_issues": 1,
      "test_coverage": 68,
      "technical_debt": 18,
      "outdated_deps": 8
    }
  }
}
```

---

## DNA Score Calculation

### Overall Score Formula

```
Overall Score = 
  (Quality × 0.25) +
  (Security × 0.20) +
  (Maintenance × 0.15) +
  (Modularity × 0.15) +
  (Scalability × 0.12) +
  (Documentation × 0.08) +
  (Dependencies × 0.03) +
  (Architecture × 0.02)

Score Range: 0-100
Grade: F(0-20), D(20-40), C(40-60), B(60-80), A(80-100)
```

### Grade Mapping

```
Score   Grade   Status
80-100  A       Excellent - Production ready, low maintenance
70-79   B       Good - Solid foundation, minor improvements
60-69   C       Fair - Functional but needs attention
50-59   D       Poor - Significant issues to address
0-49    F       Critical - Requires immediate intervention
```

---

## Use Cases

### 1. Executive Briefing
Use `executive_summary` + `narrative_summary`:
- 2-minute overview for leadership
- Key metrics and status
- Top recommendations

### 2. Technical Debt Planning
Use `risks` + `recommendations` + `action_priorities`:
- Prioritized work items
- Effort estimates
- Impact assessments

### 3. Onboarding New Developer
Use `narrative_summary` + `key_findings`:
- High-level understanding
- Critical issues to know about
- Architecture overview

### 4. Portfolio Analysis
Use `scorecard` + `comparative_insights`:
- Rank repos in portfolio
- Identify outliers
- Track trends over time

### 5. Compliance Reporting
Use `risks` + `security` dimension + `audit_trail`:
- Security posture documentation
- Compliance issues identified
- Remediation tracking

---

## Real-World Example

**Repository**: BookPro Booking Application  
**Overall Score**: 72 (C+ Grade)

**Key Outputs**:
```json
{
  "immediate_actions": [
    "Remove hardcoded secret from src/config/secrets.js",
    "Update express and lodash packages"
  ],
  
  "this_week": [
    "Add 15+ unit tests to reach 80% coverage",
    "Create API documentation"
  ],
  
  "this_month": [
    "Refactor authentication module to reduce coupling",
    "Extract 5 reusable components"
  ],
  
  "bottom_line": "Solid project with good architecture. Fix security issue immediately. Invest in testing and documentation. Should reach A-grade within 2-3 months."
}
```

---

## Performance & Accuracy

### Synthesis Time
- **Scout data**: 0.1s
- **README audit**: 0.2s
- **Forensic analysis**: 0.3s
- **Security audit**: 0.3s
- **Dependency map**: 0.2s
- **Code quality**: 0.3s
- **Asset extraction**: 0.2s
- **Architecture analysis**: 0.3s
- **Synthesis**: 0.2s
- **Total**: ~2.3 seconds

### Accuracy Factors
- Confidence: **High** (deterministic aggregation)
- Data quality: Depends on quality of input skill outputs
- Contextual accuracy: **90%+** (rule-based synthesis)
- Actionability: **95%+** (recommendations are specific and ranked)

---

## Related Skills

- **Skill 1-8**: Provide input data
- **All Skills**: Synthesized together into DNA

---

## Summary

The Repository DNA Skill transforms specialized analysis into **actionable intelligence**. It answers:

✅ **"What's the overall health?"** → Overall score + grade  
✅ **"What should we fix first?"** → Action priorities  
✅ **"Are we secure?"** → Security dimension + risks  
✅ **"Can we scale?"** → Scalability dimension + bottlenecks  
✅ **"What's our technical debt?"** → Maintenance dimension + recommendations  
✅ **"How does this compare?"** → Comparative insights  
✅ **"What's the roadmap?"** → Next analysis + tracking metrics

