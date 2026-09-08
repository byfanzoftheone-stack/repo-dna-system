# Skill 9: Architecture Visualizer

**Purpose**: Map system architecture, identify components, visualize relationships, and detect architectural patterns.

**Input**: Source code structure, import statements, configuration files  
**Output**: `08_architecture_diagram.txt` + `08_architecture.json`  
**Time**: 7-11 seconds per repo  
**Confidence**: High (based on code structure)

---

## Overview

The Architecture Visualizer creates a comprehensive understanding of how systems are structured:

1. **Component Identification** — Finds all major modules/services
2. **Dependency Mapping** — Traces imports and relationships
3. **Pattern Recognition** — Identifies architectural patterns
4. **Data Flow Analysis** — Maps data movement through system
5. **Technology Stack** — Catalogs all technologies used
6. **Layering Analysis** — Identifies architectural tiers

---

## Component Types

### 1. Services/Modules

```json
{
  "name": "AuthService",
  "type": "service",
  "location": "src/services/auth",
  "files": 8,
  "size_lines": 450,
  "role": "Authentication & authorization",
  "exports": ["login", "logout", "verify", "refresh"],
  "dependencies": ["database", "crypto", "jwt"]
}
```

### 2. Controllers/Routes

```json
{
  "name": "UserController",
  "type": "controller",
  "location": "src/controllers/user.js",
  "endpoints": [
    "GET /users",
    "POST /users",
    "PUT /users/:id",
    "DELETE /users/:id"
  ],
  "dependencies": ["UserService", "AuthMiddleware"]
}
```

### 3. Data Access Layer

```json
{
  "name": "UserRepository",
  "type": "repository",
  "location": "src/repositories/user.js",
  "methods": ["findById", "findAll", "create", "update", "delete"],
  "database": "PostgreSQL",
  "tables": ["users"]
}
```

### 4. Utilities & Helpers

```json
{
  "name": "StringUtils",
  "type": "utility",
  "location": "src/utils/string.js",
  "functions": ["capitalize", "slugify", "truncate"],
  "used_by": 12
}
```

### 5. Middleware/Interceptors

```json
{
  "name": "AuthMiddleware",
  "type": "middleware",
  "location": "src/middleware/auth.js",
  "functions": ["authenticate", "authorize", "validateToken"]
}
```

---

## Architectural Patterns

### Monolith
```
┌─────────────────────────────────┐
│      Single Application         │
├─────────────────────────────────┤
│  Controllers  │  Services       │
│  Middleware   │  Repositories   │
│  Utils        │  Models         │
└─────────────────────────────────┘
        └─── Database ───┘
```

### Microservices
```
┌──────────────┐  ┌──────────────┐  ┌──────────────┐
│  Auth Svc    │  │  User Svc    │  │  Order Svc   │
├──────────────┤  ├──────────────┤  ├──────────────┤
│  DB: Auth    │  │  DB: Users   │  │  DB: Orders  │
└──────────────┘  └──────────────┘  └──────────────┘
       │                  │                  │
       └──────────────────┼──────────────────┘
                    API Gateway
```

### Layered (MVC)
```
┌─────────────────┐
│  Presentation   │ (Controllers, Views)
├─────────────────┤
│  Application    │ (Services, Middleware)
├─────────────────┤
│  Domain         │ (Models, Business Logic)
├─────────────────┤
│  Persistence    │ (Repositories, DAOs)
├─────────────────┤
│  Infrastructure │ (Database, APIs)
└─────────────────┘
```

### Event-Driven
```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐
│  Producer   │────▶│ Message Bus  │────▶│  Consumer   │
│  (Service)  │     │  (Kafka/RMQ) │     │  (Service)  │
└─────────────┘     └──────────────┘     └─────────────┘
```

---

## Output Schema

```json
{
  "metadata": {
    "owner": "string",
    "repo": "string",
    "scanned_at": "ISO-8601 timestamp",
    "primary_language": "JavaScript",
    "architecture_type": "monolith|microservices|layered"
  },
  "summary": {
    "total_components": 42,
    "services": 8,
    "controllers": 12,
    "repositories": 6,
    "utilities": 16,
    "layers": 4,
    "architectural_pattern": "layered_mvc",
    "coupling_score": 0.62,
    "cohesion_score": 0.78
  },
  "components": [
    {
      "id": "auth-service",
      "name": "AuthService",
      "type": "service",
      "location": "src/services/auth.js",
      "size_lines": 450,
      "role": "Authentication and authorization",
      "responsibilities": [
        "User login/logout",
        "Token generation/validation",
        "Permission checking"
      ],
      "dependencies": [
        "database",
        "crypto",
        "jwt-library"
      ],
      "dependents": [
        "UserController",
        "OrderController",
        "AuthMiddleware"
      ],
      "complexity": 6,
      "test_coverage": 88
    }
  ],
  "layers": [
    {
      "name": "Presentation",
      "tier": 1,
      "components": ["UserController", "OrderController"],
      "responsibilities": "HTTP endpoints, request handling"
    },
    {
      "name": "Application",
      "tier": 2,
      "components": ["AuthService", "UserService", "OrderService"],
      "responsibilities": "Business logic, orchestration"
    },
    {
      "name": "Domain",
      "tier": 3,
      "components": ["User", "Order", "Product"],
      "responsibilities": "Domain models, entities"
    },
    {
      "name": "Persistence",
      "tier": 4,
      "components": ["UserRepository", "OrderRepository"],
      "responsibilities": "Data access, queries"
    }
  ],
  "dependency_graph": {
    "nodes": [
      {
        "id": "auth-service",
        "label": "AuthService",
        "type": "service",
        "layer": "application"
      }
    ],
    "edges": [
      {
        "from": "UserController",
        "to": "AuthService",
        "type": "depends",
        "strength": "strong"
      }
    ]
  },
  "technology_stack": [
    {
      "category": "Runtime",
      "technologies": ["Node.js 18.x"]
    },
    {
      "category": "Framework",
      "technologies": ["Express.js"]
    },
    {
      "category": "Database",
      "technologies": ["PostgreSQL", "Redis"]
    },
    {
      "category": "Message Queue",
      "technologies": ["RabbitMQ"]
    },
    {
      "category": "Caching",
      "technologies": ["Redis"]
    }
  ],
  "data_flow": [
    {
      "flow_id": "user-login",
      "trigger": "POST /auth/login",
      "steps": [
        "UserController receives request",
        "AuthService validates credentials",
        "UserRepository queries database",
        "JWT token generated",
        "Response sent to client"
      ],
      "components_involved": [
        "UserController",
        "AuthService",
        "UserRepository",
        "Database"
      ]
    }
  ],
  "communication_patterns": [
    {
      "type": "REST",
      "usage_count": 34,
      "examples": ["GET /users", "POST /orders"]
    },
    {
      "type": "Message Queue",
      "usage_count": 8,
      "broker": "RabbitMQ"
    }
  ],
  "risks": [
    {
      "issue": "Tight coupling",
      "components": ["UserController", "UserService"],
      "severity": "medium",
      "recommendation": "Extract interface, reduce direct dependencies"
    },
    {
      "issue": "Circular dependency",
      "components": ["ServiceA", "ServiceB"],
      "severity": "high",
      "recommendation": "Refactor to extract common dependency"
    }
  ],
  "quality_metrics": {
    "coupling_score": 0.62,
    "cohesion_score": 0.78,
    "modularity_index": 0.71,
    "architectural_debt": "medium",
    "scalability_readiness": "medium"
  },
  "recommendations": [
    {
      "priority": "high",
      "area": "Separation of Concerns",
      "current_state": "Tightly coupled services",
      "recommendation": "Extract business logic from controllers",
      "effort": "medium",
      "benefit": "Improved testability and reusability"
    }
  ]
}
```

---

## ASCII Diagram Example

```
┌─────────────────────────────────────────────────────────┐
│              SampleApp Booking App Architecture           │
└─────────────────────────────────────────────────────────┘

                    ┌──────────────┐
                    │  API Client  │
                    └──────┬───────┘
                           │ HTTP/REST
                    ┌──────▼───────┐
                    │ API Gateway  │
                    └──────┬───────┘
          ┌─────────────────┼─────────────────┐
          │                 │                 │
    ┌─────▼────┐      ┌─────▼────┐     ┌─────▼────┐
    │ Auth Svc │      │User Svc  │     │Order Svc │
    ├──────────┤      ├──────────┤     ├──────────┤
    │ • Login  │      │ • Profile│     │ • Create │
    │ • Verify │      │ • Update │     │ • Status │
    │ • Token  │      │ • Delete │     │ • Cancel │
    └─────┬────┘      └─────┬────┘     └─────┬────┘
          │                 │                 │
          └─────────────────┼─────────────────┘
                            │
                    ┌───────▼─────────┐
                    │  Cache (Redis)  │
                    └─────────────────┘
                            │
                    ┌───────▼──────────┐
                    │  Database (PG)   │
                    └──────��───────────┘
```

---

## Pattern Detection

### Pattern Recognition Algorithm
1. Analyze directory structure
2. Examine import/dependency patterns
3. Identify communication styles (REST, messaging, etc.)
4. Classify component types
5. Match against known architectural patterns

### Detected Patterns
- **Monolithic** — All code in single codebase
- **Microservices** — Independent services, separate databases
- **Layered/MVC** — Clear separation by tier
- **Event-Driven** — Async message-based communication
- **CQRS** — Separate read/write models
- **Hexagonal** — Domain-centered architecture

---

## Implementation Notes

### Tools Used
- AST parsing — Code structure analysis
- Dependency resolution — Import tracking
- Directory analysis — Module organization
- Pattern matching — Architecture recognition
- Graph algorithms — Dependency visualization

### Performance
- **Single repo**: 7-11 seconds
- **Limited by**: Repository size, import complexity

### Accuracy
- Component detection: 92%
- Pattern recognition: 85% (requires manual validation)
- Dependency mapping: 95%
- Data flow tracing: 80%

---

## Use Cases

1. **System Understanding** — New team members learn architecture
2. **Refactoring Planning** — Identify where to decouple
3. **Technology Migration** — Plan modularization
4. **Performance Optimization** — Find bottlenecks
5. **Documentation** — Generate architecture diagrams
6. **Risk Assessment** — Identify coupling risks

---

## Related Skills

- **Skill 8**: Asset Extractor (identifies extractable components)
- **Skill 7**: Code Quality Analyzer (includes complexity metrics)
- **Skill 6**: Dependency Mapper (detailed dependency analysis)

