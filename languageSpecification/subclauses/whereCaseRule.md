# WHERE CASE

The **whereCaseRule** defines a single conditional branch within a CASE clause, specifying a condition and an optional transformation to apply when the condition is met.

## EBNF Syntax

```ebnf
<span style="color: purple">whereCaseRule</span> ::= WHERE <span style="color: purple">orConditionRule</span> [<span style="color: purple">generateSectionRule</span>]
```

## Syntax Diagram
![WHERE CASE Syntax](/languageSpecification/assets/rules/whereCaseRule.png "WHERE CASE Syntax Diagram")

## Semantics

A **WHERE CASE** represents a single conditional branch that:
1. Evaluates a condition against each document
2. If the condition is **true**, optionally transforms the document via GENERATE
3. If the condition is **false**, moves to the next case or applies OTHERS rule

### Components

- **WHERE** - Keyword that introduces the condition
- **orConditionRule** - Boolean condition that determines if the case matches
- **generateSectionRule** - Optional transformation to apply to matching documents

### Behavior

**With GENERATE:**
```jcoql
WHERE condition GENERATE transformation;
```
- Document matches → transformed according to GENERATE
- Document doesn't match → proceeds to next case

**Without GENERATE:**
```jcoql
WHERE condition;
```
- Document matches → kept unchanged
- Document doesn't match → proceeds to next case

## Used In

The **whereCaseRule** is used **exclusively** in:
- **caseClauseRule** - As one of the conditional branches (at least one required)

## Examples

### Example 1: Simple WHERE with Condition Only
```jcoql
FILTER
CASE
    WHERE .status = "active";
    WHERE .status = "pending" AND .priority = "high";
DROP OTHERS;
```
**Description:** Keeps documents matching either condition without any transformation.

---

### Example 2: WHERE with GENERATE Transformation
```jcoql
FILTER
CASE
    WHERE .temperature > 30
    GENERATE BUILD {
        .id,
        .temp: .temperature,
        .alert: "HIGH_TEMP",
        .timestamp: NOW()
    };
DROP OTHERS;
```
**Description:** Transforms documents that match the temperature condition.

---

### Example 3: Multiple WHERE Cases with Different Transformations
```jcoql
FILTER
CASE
    WHERE .score >= 90
    GENERATE BUILD {
        .studentId: .id,
        .name,
        .grade: "A",
        .honors: TRUE
    };
    
    WHERE .score >= 80
    GENERATE BUILD {
        .studentId: .id,
        .name,
        .grade: "B",
        .honors: FALSE
    };
    
    WHERE .score >= 70
    GENERATE BUILD {
        .studentId: .id,
        .name,
        .grade: "C",
        .honors: FALSE
    };
DROP OTHERS;
```
**Description:** Each WHERE case assigns a different grade based on score.

---

### Example 4: WHERE with Complex Condition
```jcoql
FILTER
CASE
    WHERE (.age >= 18 AND .country = "USA") OR 
          (.age >= 21 AND .country != "USA")
    GENERATE BUILD {
        .name,
        .age,
        .country,
        .eligible: TRUE,
        .checkedAt: NOW()
    };
KEEP OTHERS;
```
**Description:** Complex eligibility check with country-specific age requirements.

---

### Example 5: WHERE with Geometry Operations
```jcoql
FILTER
CASE
    WHERE .type = "point"
    GENERATE
        KEEPING GEOMETRY
        BUILD {
            .id,
            .name,
            .geometryType: "POINT"
        };
    
    WHERE .type = "polygon"
    GENERATE
        KEEPING GEOMETRY
        BUILD {
            .id,
            .name,
            .area: AREA(~geometry),
            .geometryType: "POLYGON"
        };
KEEP OTHERS;
```

---

### Example 6: WHERE with Fuzzy Logic
```jcoql
CREATE FUZZY OPERATOR nearby
PARAMETERS dist TYPE FLOAT
EVALUATE (1000 - dist) / 1000;

FILTER
CASE
    WHERE .distance != NULL AND .distance < 2000
    GENERATE
        CHECK FOR nearby
        ALPHACUT 0.5
        BUILD {
            .locationName: .name,
            .distance,
            .proximity: #nearby,
            .category: "ACCESSIBLE"
        };
    
    WHERE .distance != NULL
    GENERATE BUILD {
        .locationName: .name,
        .distance,
        .category: "FAR"
    };
DROP OTHERS;
```

---

### Example 7: WHERE with Field Existence Checks
```jcoql
FILTER
CASE
    WHERE WITH GEOMETRY ~geometry AND WITH .address
    GENERATE
        KEEPING GEOMETRY
        BUILD {
            .id,
            .address,
            .dataQuality: "COMPLETE"
        };
    
    WHERE WITH GEOMETRY ~geometry
    GENERATE
        KEEPING GEOMETRY
        BUILD {
            .id,
            .dataQuality: "PARTIAL_LOCATION"
        };
    
    WHERE WITH .address
    GENERATE
        DROPPING GEOMETRY
        BUILD {
            .id,
            .address,
            .dataQuality: "PARTIAL_ADDRESS"
        };
KEEP OTHERS;
```

---

### Example 8: WHERE in JOIN Context
```jcoql
JOIN restaurants AS r
CASE
    WHERE DISTANCE(r, 500)
    GENERATE
        BUILD {
            .hotelName: .name,
            .restaurantName: r.name,
            .distance: DISTANCE(r),
            .walkTime: "5 min",
            .proximity: "VERY_CLOSE"
        };
    
    WHERE DISTANCE(r, 1500)
    GENERATE
        BUILD {
            .hotelName: .name,
            .restaurantName: r.name,
            .distance: DISTANCE(r),
            .walkTime: "15 min",
            .proximity: "CLOSE"
        };
DROP OTHERS;
```

---

### Example 9: WHERE with Array Operations
```jcoql
FILTER
CASE
    WHERE WITH ARRAY .tags AND "premium" IN .tags
    GENERATE ADD FIELDS {
        .tier: "PREMIUM",
        .benefits: ["priority", "discount", "support"]
    };
    
    WHERE WITH ARRAY .tags AND "member" IN .tags
    GENERATE ADD FIELDS {
        .tier: "MEMBER",
        .benefits: ["discount"]
    };
    
    WHERE WITH ARRAY .tags
    GENERATE ADD FIELDS {
        .tier: "BASIC",
        .benefits: []
    };
KEEP OTHERS;
```

---

### Example 10: WHERE with Multiple GENERATE Operations
```jcoql
FILTER
CASE
    WHERE .needsEnrichment = TRUE
    GENERATE
        BUILD {
            .id,
            .originalData: .data
        }
        ADD FIELDS {
            .enrichedAt: NOW(),
            .version: 2
        }
        REMOVE FIELDS [.temporary];
KEEP OTHERS;
```

---


### Boolean Result
The `orConditionRule` must evaluate to a boolean:
- **TRUE** → Document matches this case
- **FALSE** → Document moves to next case
- **NULL** → Treated as FALSE

### Examples of Conditions

**Simple comparison:**
```jcoql
WHERE .value > 100
```

**Logical operators:**
```jcoql
WHERE .status = "active" AND .verified = TRUE
WHERE .priority = "high" OR .urgent = TRUE
```

**NULL checks:**
```jcoql
WHERE FIELD .email ISNOTNULL
WHERE .optionalField != NULL
```

**Field existence:**
```jcoql
WHERE WITH .requiredField
WHERE WITHOUT .deprecatedField
```

**Fuzzy predicates:**
```jcoql
WHERE WITHIN FUZZY SETS goodQuality, highValue
WHERE KNOWN FUZZY SETS qualityMetric
```

**Spatial predicates (in JOIN):**
```jcoql
WHERE DISTANCE(other, 1000)
WHERE INTERSECT
```

---

## WHERE Without GENERATE

When GENERATE is omitted, matched documents are **kept unchanged**:

```jcoql
CASE
    WHERE .valid = TRUE;      -- Keep as-is
    WHERE .pending = TRUE;    -- Keep as-is
DROP OTHERS;                   -- Drop invalid
```

This is useful for:
- **Filtering only** (no transformation needed)
- **Validation** (keep valid, drop invalid)
- **Selection** (include certain categories)

---

## WHERE With GENERATE

When GENERATE is present, matched documents are **transformed**:

```jcoql
WHERE condition
GENERATE
    [geometricOptionRule]
    [checkForFuzzySetRule]
    [alphaCutRule]
    (buildActionRule)*
    [keepDropFuzzySetsRule]
    [dropGeometryRule]
```

All GENERATE features are available:
- **BUILD/ADD FIELDS/REMOVE FIELDS** - Structure transformation
- **Geometry management** - KEEPING/SETTING/DROPPING
- **Fuzzy set operations** - CHECK FOR, ALPHACUT, KEEP/DROP
- **Multiple transformations** - Chained BUILD operations

---

## Execution Order in CASE

```jcoql
CASE
    WHERE condition1 GENERATE transform1;  -- Case 1
    WHERE condition2 GENERATE transform2;  -- Case 2
    WHERE condition3 GENERATE transform3;  -- Case 3
KEEP/DROP OTHERS;
```

**For each document:**
1. Evaluate condition1
   - If TRUE → apply transform1 → **DONE** (skip cases 2 and 3)
   - If FALSE → continue to case 2
2. Evaluate condition2
   - If TRUE → apply transform2 → **DONE** (skip case 3)
   - If FALSE → continue to case 3
3. Evaluate condition3
   - If TRUE → apply transform3 → **DONE**
   - If FALSE → apply OTHERS rule

**Key:** First matching case wins, remaining cases are not evaluated for that document.

---



- **Condition complexity:** Keep conditions as simple as possible
- **Short-circuit:** Use AND/OR effectively to minimize expensive checks
- **Field access:** Access fields that likely exist to avoid NULL checks overhead
- **Function calls:** Minimize expensive function calls in conditions

### Optimization Example
```jcoql
-- Less efficient
WHERE COMPLEX_CALCULATION(.data) > 100 AND .status = "active"

-- More efficient (cheap check first)
WHERE .status = "active" AND COMPLEX_CALCULATION(.data) > 100
```

---

## Issues

- Clarify if WHERE condition can reference fields created by previous CASEs (should not be possible due to first-match-wins)
- Document maximum complexity/depth for orConditionRule
- Specify behavior when condition evaluation throws an error
- Define if WHERE can be empty (WHERE TRUE) for catch-all case

## References

For the *token list specification* see the [tokenList.md](/languageSpecification/tokenList.md) file.

Parent clause:
- [caseClauseRule.md](./caseClauseRule.md)

Related subclauses:
- [orConditionRule.md](../conditionExpressionModel/orConditionRule.md)
- [generateSectionRule.md](./generateSectionRule.md)
- [othersRule.md](./othersRule.md)

Condition components:
- [andConditionRule.md](../conditionExpressionModel/andConditionRule.md)
- [notConditionRule.md](../conditionExpressionModel/notConditionRule.md)
- [predicateRule.md](../conditionExpressionModel/predicateRule.md)
