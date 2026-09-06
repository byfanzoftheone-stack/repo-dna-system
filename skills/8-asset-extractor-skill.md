# Skill 8: Asset Extractor

**Purpose**: Identify, classify, and evaluate reusable code components, libraries, and algorithms that could be extracted, productized, or shared.

**Input**: Source code files, git history, architecture documentation  
**Output**: `07_asset_inventory.json`  
**Time**: 6-10 seconds per repo  
**Confidence**: Medium-High (requires manual validation)

---

## Overview

The Asset Extractor discovers valuable, reusable code within repositories:

1. **Component Identification** — Finds modular, self-contained code
2. **Value Assessment** — Rates components by reusability and business value
3. **Extractability Analysis** — Evaluates effort to extract and publish
4. **Market Potential** — Identifies components with external market value
5. **Duplication Detection** — Finds components duplicated across repos
6. **Library Recommendations** — Suggests which components should become libraries

---

## Asset Categories

### 1. Reusable Components

```json
{
  "name": "AuthenticationManager",
  "type": "class",
  "location": "src/auth/manager.js",
  "size": 340,
  "complexity": 4,
  "dependencies": ["bcrypt", "jsonwebtoken"],
  "test_coverage": 92,
  "reusability_score": 8.5,
  "use_cases": [
    "User authentication",
    "Token management",
    "Session handling"
  ]
}
```

### 2. Utility Functions

```json
{
  "name": "formatDate",
  "type": "function",
  "location": "src/utils/date.js",
  "size": 25,
  "complexity": 2,
  "parameters": 2,
  "reusability_score": 7.2,
  "used_by": ["invoice-system", "report-generator", "ui-components"]
}
```

### 3. Algorithms

```json
{
  "name": "levenshteinDistance",
  "type": "algorithm",
  "location": "src/algorithms/string-matching.js",
  "size": 35,
  "complexity": 3,
  "purpose": "String similarity matching",
  "performance": "O(n*m)",
  "use_cases": ["Search", "Autocomplete", "Spell checker"],
  "reusability_score": 8.8
}
```

### 4. Data Structures

```json
{
  "name": "BinarySearchTree",
  "type": "data_structure",
  "location": "src/structures/bst.js",
  "size": 120,
  "complexity": 5,
  "operations": ["insert", "search", "delete", "traverse"],
  "test_coverage": 88,
  "reusability_score": 7.5
}
```

### 5. Design Patterns

```json
{
  "name": "Observer Pattern",
  "type": "pattern",
  "location": "src/patterns/observer.js",
  "implementation_quality": "high",
  "usage_examples": 3,
  "description": "Event subscription and notification system",
  "reusability_score": 8.2
}
```

### 6. API/Service Integrations

```json
{
  "name": "StripePaymentProcessor",
  "type": "integration",
  "location": "src/integrations/stripe.js",
  "complexity": 6,
  "external_service": "Stripe",
  "features": ["charge", "refund", "subscription"],
  "test_coverage": 85,
  "reusability_score": 8.9,
  "potential_market": "high"
}
```

---

## Reusability Scoring

**Formula**: Combination of factors

```
Score = (Modularity × 0.25) + 
         (Documentation × 0.20) + 
         (TestCoverage × 0.25) + 
         (Complexity × 0.15) + 
         (ApplicabilityRange × 0.15)

Score Range: 1-10
```

**Rating Levels:**
- **9-10**: Excellent — Publish as standalone library
- **7-8**: Very Good — Extract and share internally
- **5-6**: Good — Candidate for extraction
- **3-4**: Fair — Worth considering
- **1-2**: Poor — Not reusable as-is

---

## Output Schema

```json
{
  "metadata": {
    "owner": "string",
    "repo": "string",
    "scanned_at": "ISO-8601 timestamp",
    "total_assets": 127,
    "analysis_version": "1.0.0"
  },
  "summary": {
    "high_value_assets": 12,
    "medium_value_assets": 34,
    "low_value_assets": 81,
    "total_extractable": 46,
    "estimated_library_candidates": 8,
    "internal_duplication": 5
  },
  "components": [
    {
      "id": "auth-manager-001",
      "name": "AuthenticationManager",
      "type": "class",
      "location": "src/auth/manager.js",
      "size_lines": 340,
      "complexity_score": 4,
      "dependencies": ["bcrypt", "jsonwebtoken"],
      "test_coverage": 92,
      "documentation_quality": "good",
      "reusability_score": 8.5,
      "value_rating": "high",
      "extractability": {
        "effort": "medium",
        "effort_hours": 8,
        "blockers": [],
        "can_extract": true
      },
      "use_cases": [
        "User authentication",
        "Token management",
        "Session handling"
      ],
      "internal_usage": 3,
      "recommended_action": "Extract as library"
    }
  ],
  "utilities": [
    {
      "name": "formatDate",
      "type": "function",
      "location": "src/utils/date.js",
      "size_lines": 25,
      "complexity": 2,
      "reusability_score": 7.2,
      "used_count": 15,
      "internal_duplication_count": 2,
      "value_rating": "medium"
    }
  ],
  "algorithms": [
    {
      "name": "levenshteinDistance",
      "type": "algorithm",
      "location": "src/algorithms/string-matching.js",
      "size_lines": 35,
      "complexity": 3,
      "purpose": "String similarity matching",
      "performance": "O(n*m)",
      "use_cases": ["Search", "Autocomplete", "Spell checker"],
      "test_coverage": 88,
      "reusability_score": 8.8,
      "value_rating": "high",
      "market_potential": "high"
    }
  ],
  "data_structures": [
    {
      "name": "BinarySearchTree",
      "type": "data_structure",
      "location": "src/structures/bst.js",
      "size_lines": 120,
      "complexity": 5,
      "operations": ["insert", "search", "delete", "traverse"],
      "test_coverage": 88,
      "reusability_score": 7.5,
      "value_rating": "medium"
    }
  ],
  "integrations": [
    {
      "name": "StripePaymentProcessor",
      "type": "integration",
      "external_service": "Stripe",
      "features": ["charge", "refund", "subscription"],
      "complexity": 6,
      "test_coverage": 85,
      "reusability_score": 8.9,
      "value_rating": "high",
      "market_potential": "high",
      "extractability": {
        "effort": "low",
        "effort_hours": 4,
        "can_extract": true
      }
    }
  ],
  "duplication_analysis": {
    "duplicated_components": 5,
    "duplication_opportunities": [
      {
        "component": "DateFormatting",
        "locations": [
          "src/utils/date.js",
          "src/reporting/formatters.js",
          "src/api/response-formatter.js"
        ],
        "code_duplicated": 45,
        "consolidation_savings": "medium"
      }
    ]
  },
  "library_candidates": [
    {
      "name": "auth-library",
      "core_components": ["AuthenticationManager", "TokenValidator"],
      "total_size": 580,
      "estimated_effort_hours": 16,
      "estimated_effort_days": 2,
      "priority": "high",
      "market_opportunity": "high",
      "reasoning": "Robust, well-tested, general-purpose authentication"
    }
  ],
  "extraction_roadmap": [
    {
      "phase": 1,
      "priority": "high",
      "items": ["AuthenticationManager", "StripePaymentProcessor"],
      "estimated_weeks": 2
    }
  ],
  "recommendations": [
    {
      "priority": "high",
      "asset": "AuthenticationManager",
      "action": "Extract as npm package",
      "expected_benefit": "Reusable in 3+ other projects",
      "effort_hours": 8,
      "roi_score": 9.2
    }
  ]
}
```

---

## Asset Value Matrix

```
        ┌─────────────────────────────────────┐
        │   EXTRACTABILITY vs REUSABILITY     │
        │                                     │
      H │  ⭐ HIGH VALUE                      │
        │  Extract & Publish                  │
    E   │                                     │
    X   │                                     │
    T F │  ✓ MEDIUM VALUE                    │
    R   │  Extract Internally                 │
    A   │                                     │
    C   │                                     │
    T L │  ○ LOW VALUE                        │
        │  Consider Later                     │
        │                                     │
        └─────────────────────────────────────┘
          L    REUSABILITY SCORE    H
```

---

## Implementation Notes

### Detection Methods

1. **Code Structure Analysis**
   - Identify self-contained classes/modules
   - Analyze dependency graph
   - Check for loose coupling

2. **Usage Pattern Analysis**
   - Count internal usage frequency
   - Track across repositories
   - Identify shared patterns

3. **Quality Assessment**
   - Test coverage evaluation
   - Documentation quality
   - Code complexity metrics

4. **Business Value Analysis**
   - Potential market demand
   - Reusability across projects
   - Effort to maintain

### Performance
- **Single repo**: 6-10 seconds
- **Limited by**: Repository size, AST parsing

### Accuracy
- Component detection: 90% (may miss some patterns)
- Reusability scoring: 75% (subjective elements)
- Value assessment: 70% (requires business context)

---

## Use Cases

1. **Productization** — Identify which code could become products
2. **Internal Library Strategy** — Plan internal shared libraries
3. **Open Source** — Find candidates for open sourcing
4. **Cost Reduction** — Consolidate duplicated functionality
5. **Team Efficiency** — Share components across teams
6. **Licensing** — Identify components for commercial licensing

---

## Related Skills

- **Skill 7**: Code Quality Analyzer (evaluates component quality)
- **Skill 6**: Dependency Mapper (identifies dependencies to extract)
- **Skill 2**: README Auditor (assess documentation quality)

