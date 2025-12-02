# CASE Clause

The **caseClauseRule** defines multiple conditional clauses that allow documents to be processed differently based on various conditions. It's similar to a switch-case or if-elseif-else structure in programming languages.

## EBNF Syntax

```ebnf
caseClauseRule ::= (CASES | CASE) (<span style="color: purple">whereCaseRule</span>)+ [<span style="color: purple">othersRule</span>]
```

## Syntax Diagram
![CASE Clause Syntax](/languageSpecification/assets/rules/caseClauseRule.png "CASE Clause Syntax Diagram")

## Semantics

The **CASE clause** allows you to define multiple conditional branches, each with its own condition and optional transformation. Documents are evaluated against each case in order, and the first matching case is applied.

### Components

- **CASE** / **CASES** - Keywords that introduce the clause (synonyms)
- **whereCaseRule** - One or more WHERE conditions with optional GENERATE (at least one required)
- **othersRule** - Optional clause to handle documents that don't match any case

### Evaluation Order

Cases are evaluated **sequentially** in the order they appear:
1. First `WHERE` condition is checked
2. If it matches, the document is processed (with optional GENERATE transformation)
3. If it doesn't match, the next `WHERE` is checked
4. If no cases match, `othersRule` determines the behavior (KEEP or DROP)

### Default Behavior

If **othersRule** is not specified:
- Default behavior: **DROP** (documents not matching any case are removed)

## Used In

The **caseClauseRule** is used in:
- **filterRule** - To filter and transform documents with multiple conditions
- **joinOfCollectionsRule** - To define join conditions and transformations

## Examples

### Example 1: Simple CASE with Multiple Conditions
```jcoql
FILTER
CASE 
    WHERE .temperature > 30
    GENERATE BUILD { .id, .temp: .temperature, .status: "HOT" };
    
    WHERE .temperature > 20
    GENERATE BUILD { .id, .temp: .temperature, .status: "WARM" };
    
    WHERE .temperature > 10
    GENERATE BUILD { .id, .temp: .temperature, .status: "COOL" };

KEEP OTHERS;
```
**Description:** Classifies temperature readings into categories. First matching condition wins.

**Example evaluation:**
- Document with temp=35°C → matches first WHERE → status="HOT"
- Document with temp=25°C → matches second WHERE → status="WARM"
- Document with temp=5°C → no match → kept as-is (KEEP OTHERS)

---

### Example 2: CASE with DROP OTHERS (Default)
```jcoql
FILTER
CASE
    WHERE .age >= 18 AND .country = "USA"
    GENERATE BUILD { .name, .age, .eligible: TRUE };
    
    WHERE .age >= 21 AND .country != "USA"
    GENERATE BUILD { .name, .age, .eligible: TRUE };

DROP OTHERS;
```
**Description:** Keeps only documents meeting eligibility criteria, drops all others.

---

### Example 3: CASE without GENERATE (Filter Only)
```jcoql
FILTER
CASES
    WHERE .status = "active";
    WHERE .status = "pending" AND .priority = "high";

DROP OTHERS;
```
**Description:** Keeps documents matching either condition without transformation.

---

### Example 4: Complex Transformations per Case
```jcoql
FILTER
CASE
    WHERE .type = "premium"
    GENERATE
        BUILD {
            .customerId: .id,
            .level: "PREMIUM",
            .discount: 0.20,
            .benefits: ["free shipping", "priority support", "extended warranty"]
        };
    
    WHERE .type = "standard" AND .purchases > 10
    GENERATE
        BUILD {
            .customerId: .id,
            .level: "LOYAL",
            .discount: 0.10,
            .benefits: ["free shipping"]
        };
    
    WHERE .type = "standard"
    GENERATE
        BUILD {
            .customerId: .id,
            .level: "STANDARD",
            .discount: 0.05,
            .benefits: []
        };

KEEP OTHERS;
```
**Description:** Different transformations based on customer type and behavior.

---

### Example 5: CASE with Geometry Management
```jcoql
FILTER
CASE
    WHERE .category = "restaurant"
    GENERATE
        KEEPING GEOMETRY
        BUILD {
            .name,
            .category,
            .type: "POI"
        };
    
    WHERE .category = "park"
    GENERATE
        SETTING GEOMETRY AGGREGATE (.boundaries)
        BUILD {
            .name,
            .category,
            .area: AREA(~geometry),
            .type: "AREA"
        };
    
    WHERE .category = "route"
    GENERATE
        SETTING GEOMETRY TO_POLYLINE (.waypoints)
        BUILD {
            .name,
            .category,
            .length: LENGTH(~geometry),
            .type: "LINE"
        };

DROP OTHERS;
```
**Description:** Different geometry handling for different spatial feature types.

---

### Example 6: CASE in JOIN
```jcoql
JOIN hotels AS h
CASE
    WHERE DISTANCE(h, 500)
    GENERATE
        KEEPING GEOMETRY
        BUILD {
            .attraction: .name,
            .hotel: h.name,
            .distance: DISTANCE(h),
            .proximity: "VERY_CLOSE"
        };
    
    WHERE DISTANCE(h, 1500)
    GENERATE
        KEEPING GEOMETRY
        BUILD {
            .attraction: .name,
            .hotel: h.name,
            .distance: DISTANCE(h),
            .proximity: "CLOSE"
        };
    
    WHERE DISTANCE(h, 3000)
    GENERATE
        KEEPING GEOMETRY
        BUILD {
            .attraction: .name,
            .hotel: h.name,
            .distance: DISTANCE(h),
            .proximity: "WALKABLE"
        };

DROP OTHERS;
```
**Description:** Creates different join results based on distance ranges.

---

### Example 7: Nested Conditions with Complex Logic
```jcoql
FILTER
CASE
    WHERE .verified = TRUE AND .rating >= 4.5 AND .reviews > 100
    GENERATE
        BUILD {
            .id,
            .name,
            .badge: "TRUSTED_EXCELLENT",
            .featured: TRUE,
            .priority: 1
        };
    
    WHERE .verified = TRUE AND .rating >= 4.0
    GENERATE
        BUILD {
            .id,
            .name,
            .badge: "TRUSTED",
            .featured: TRUE,
            .priority: 2
        };
    
    WHERE .rating >= 4.0 AND .reviews > 50
    GENERATE
        BUILD {
            .id,
            .name,
            .badge: "POPULAR",
            .featured: FALSE,
            .priority: 3
        };
    
    WHERE .rating >= 3.0
    GENERATE
        BUILD {
            .id,
            .name,
            .badge: "STANDARD",
            .featured: FALSE,
            .priority: 4
        };

KEEP OTHERS;
```

---

### Example 8: CASE with Fuzzy Logic
```jcoql
CREATE FUZZY OPERATOR highQuality
PARAMETERS rating TYPE FLOAT
EVALUATE (rating - 3.0) / 2.0;

CREATE FUZZY OPERATOR expensive
PARAMETERS price TYPE FLOAT
EVALUATE (price - 50) / 100;

FILTER
CASE
    WHERE .price != NULL AND .rating != NULL
    GENERATE
        CHECK FOR highQuality, expensive
        ALPHACUT 0.7 WITHIN [highQuality]
        BUILD {
            .name,
            .quality: #highQuality,
            .priceLevel: #expensive,
            .category: "HIGH_END"
        };
    
    WHERE .price != NULL AND .rating != NULL
    GENERATE
        CHECK FOR highQuality, expensive
        BUILD {
            .name,
            .quality: #highQuality,
            .priceLevel: #expensive,
            .category: "STANDARD"
        };

DROP OTHERS;
```
**Description:** Different fuzzy processing based on data availability.

---

### Example 9: Multiple CASES with Field Checks
```jcoql
FILTER
CASE
    WHERE WITH GEOMETRY .location AND .type = "physical"
    GENERATE
        KEEPING GEOMETRY
        BUILD { .id, .name, .hasLocation: TRUE };
    
    WHERE WITH ARRAY .coordinates AND .type = "physical"
    GENERATE
        SETTING GEOMETRY POINT (.coordinates[0], .coordinates[1])
        BUILD { .id, .name, .hasLocation: TRUE };
    
    WHERE WITHOUT ~geometry
    GENERATE
        DROPPING GEOMETRY
        BUILD { .id, .name, .hasLocation: FALSE };

KEEP OTHERS;
```

---

### Example 10: Priority-Based Processing
```jcoql
FILTER
CASE
    WHERE .urgent = TRUE AND .status = "pending"
    GENERATE
        BUILD {
            .ticketId: .id,
            .priority: 1,
            .queueTime: NOW(),
            .handler: "express_team"
        };
    
    WHERE .priority = "high" AND .status = "pending"
    GENERATE
        BUILD {
            .ticketId: .id,
            .priority: 2,
            .queueTime: NOW(),
            .handler: "priority_team"
        };
    
    WHERE .status = "pending"
    GENERATE
        BUILD {
            .ticketId: .id,
            .priority: 3,
            .queueTime: NOW(),
            .handler: "standard_team"
        };
    
    WHERE .status = "on_hold"
    GENERATE
        BUILD {
            .ticketId: .id,
            .priority: 99,
            .queueTime: .originalQueueTime,
            .handler: "review_team"
        };

DROP OTHERS;  -- Completed or cancelled tickets
```

---


## Issues

- Clarify behavior when GENERATE modifies fields used in subsequent WHERE conditions (should not happen due to first-match-wins)
- Document performance characteristics with very large numbers of cases (100+)
- Specify if there's a recommended maximum number of cases
- Define behavior if same transformation is needed for multiple conditions (better to use OR in single WHERE?)

## References

For the *token list specification* see the [tokenList.md](/languageSpecification/tokenList.md) file.

Related subclauses:
- [whereCaseRule.md](./whereCaseRule.md)
- [othersRule.md](./othersRule.md)
- [generateSectionRule.md](./generateSectionRule.md)
- [orConditionRule.md](../conditionExpressionModel/orConditionRule.md)

Used in:
- [filter.md](/languageSpecification/filter.md)
- [joinOfCollections.md](/languageSpecification/joinOfCollections.md)
