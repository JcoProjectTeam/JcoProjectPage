# KEEP/DROP FUZZY SETS

The **keepDropFuzzySetsRule** manages which fuzzy sets to keep or remove in the special `~fuzzysets` field of resulting documents.

## EBNF Syntax

```ebnf
<span style="color: purple">keepDropFuzzySetsRule</span> ::= (KEEP | DROP) FUZZY SETS '[' ID ( ',' ID)* ']'
```

## Syntax Diagram
![Keep Drop Fuzzy Sets Syntax](/languageSpecification/assets/rules/keepDropFuzzySetsRule.png "Keep Drop Fuzzy Sets Syntax Diagram")

## Semantics

This clause allows you to control the content of the `~fuzzysets` field in resulting documents, choosing which membership degrees to keep or remove.

### Two Modes

#### 1. KEEP FUZZY SETS [...]
Keeps **only** the specified fuzzy sets, removing all others.

```jcoql
KEEP FUZZY SETS [fuzzySet1, fuzzySet2]
```

#### 2. DROP FUZZY SETS [...]
Removes the specified fuzzy sets, keeping all others.

```jcoql
DROP FUZZY SETS [fuzzySet1, fuzzySet2]
```

### Components

- **KEEP** / **DROP** - Operation mode
- **FUZZY SETS** - Keywords
- **LB** / **RB** - Square brackets `[` and `]`
- **ID** - Fuzzy set name (can be repeated)
- **COMMA** - Separates multiple fuzzy set names

## Used In

The **keepDropFuzzySetsRule** is used **exclusively** in:
- **generateSectionRule** - As part of the GENERATE section

## Examples

### Example 1: KEEP Specific Fuzzy Sets
```jcoql
CREATE FUZZY OPERATOR nearParking ...;
CREATE FUZZY OPERATOR goodService ...;
CREATE FUZZY OPERATOR affordable ...;
CREATE FUZZY OPERATOR hasWifi ...;

FILTER
GENERATE
    CHECK FOR nearParking, goodService, affordable, hasWifi
    BUILD {
        .name,
        .parking: #nearParking,
        .service: #goodService
    }
    KEEP FUZZY SETS [nearParking, goodService];
```

**Before KEEP:**
```json
{
  "name": "Hotel Central",
  "parking": 0.8,
  "service": 0.9,
  "~fuzzysets": {
    "nearParking": 0.8,
    "goodService": 0.9,
    "affordable": 0.6,
    "hasWifi": 1.0
  }
}
```

**After KEEP FUZZY SETS [nearParking, goodService]:**
```json
{
  "name": "Hotel Central",
  "parking": 0.8,
  "service": 0.9,
  "~fuzzysets": {
    "nearParking": 0.8,
    "goodService": 0.9
  }
}
```

---

### Example 2: DROP Unnecessary Fuzzy Sets
```jcoql
CREATE FUZZY OPERATOR tempQuality ...;
CREATE FUZZY OPERATOR internalCheck ...;
CREATE FUZZY OPERATOR debugMetric ...;

FILTER
GENERATE
    CHECK FOR tempQuality, internalCheck, debugMetric
    BUILD {
        .stationId: .id,
        .quality: #tempQuality
    }
    DROP FUZZY SETS [internalCheck, debugMetric];
```

**Description:** Removes fuzzy sets used only for internal verification, keeping the one relevant for the user.

---

### Example 3: Keep Only Final Fuzzy Set
```jcoql
CREATE FUZZY OPERATOR criterion1 ...;
CREATE FUZZY OPERATOR criterion2 ...;
CREATE FUZZY OPERATOR criterion3 ...;
CREATE FUZZY AGGREGATOR overallScore ...;

FILTER
GENERATE
    CHECK FOR criterion1, criterion2, criterion3
    -- Calcola score aggregato
    CHECK FOR overallScore USING (criterion1, criterion2, criterion3)
    ALPHACUT 0.6
    BUILD {
        .itemName: .name,
        .finalScore: #overallScore
    }
    KEEP FUZZY SETS [overallScore];
```

**Description:** Keeps only the final aggregated score, removing intermediate criteria.

---

### Example 4: DROP for Privacy
```jcoql
CREATE FUZZY OPERATOR publicScore ...;
CREATE FUZZY OPERATOR sensitiveMetric ...;
CREATE FUZZY OPERATOR internalRanking ...;

FILTER
GENERATE
    CHECK FOR publicScore, sensitiveMetric, internalRanking
    BUILD {
        .userId: .id,
        .score: #publicScore
    }
    DROP FUZZY SETS [sensitiveMetric, internalRanking];
```

**Description:** Removes sensitive metrics before public export.

---

### Example 5: JOIN with Fuzzy Set Management
```jcoql
JOIN hotels AS h
CASE WHERE DISTANCE(h, 2000)
GENERATE
    CHECK FOR walkable, goodValue
    BUILD {
        .attraction: .name,
        .hotel: h.name,
        .walkability: #walkable,
        .value: #goodValue,
        .combinedScore: (#walkable * 0.6 + #goodValue * 0.4)
    }
    KEEP FUZZY SETS [walkable, goodValue]
    DROPPING GEOMETRY;
```

---

### Esempio 6: GROUP con Aggregation
```jcoql
GROUP BY .category
INTO .items
GENERATE
    CHECK FOR itemQuality
    CHECK FOR categoryRelevance
    BUILD {
        .category,
        .itemCount: COUNT(.items),
        .avgQuality: AVG_ARRAY(MEMBERSHIP_ARRAY(itemQuality FROM ARRAY .items))
    }
    KEEP FUZZY SETS [categoryRelevance];
```

**Description:** Keeps only the category relevance, not that of individual items.

---

### Example 7: Multi-Stage Processing
```jcoql
-- Stage 1: Calculate all fuzzy sets
FILTER
GENERATE
    CHECK FOR fs1, fs2, fs3, fs4, fs5
    BUILD {...};
SAVE AS intermediate;

-- Stage 2: Keep only necessary ones
GET COLLECTION intermediate;
FILTER
GENERATE
    BUILD {...}
    KEEP FUZZY SETS [fs1, fs3];
```

---

### Example 8: Cleanup After Multi-Grade
```jcoql
CREATE FUZZY SET MODEL multiGrade
DEGREES low, medium, high;

CREATE GENERIC FUZZY OPERATOR temp FOR multiGrade ...;

FILTER
GENERATE
    CHECK FOR temp
    BUILD {
        .stationId: .id,
        .dominantLevel: IF(#temp.high > 0.7, "HOT",
                          IF(#temp.medium > 0.5, "WARM", "COLD"))
    }
    DROP FUZZY SETS [temp];
```

**Description:** After extracting categorical information, removes the fuzzy degrees.

---



### See all fuzzy sets
```jcoql
-- Without KEEP/DROP
BUILD {
    .id,
    .allFuzzySets: ~fuzzysets
}
```

### Verify what gets kept
```jcoql
KEEP FUZZY SETS [fs1, fs2]
BUILD {
    .id,
    .keptSets: ~fuzzysets,
    .fs1Present: (#fs1 != NULL),
    .fs3Present: (#fs3 != NULL)  -- Should be FALSE
}
```

---

## Issues

- Clarify behavior when fuzzy set in KEEP/DROP doesn't exist
- Document if it's possible to KEEP/DROP fuzzy sets from multi-grade models
- Specify if the order of fuzzy sets in the list matters
- Define behavior with fuzzy sets already present before CHECK FOR

## References

For the *token list specification* see the [tokenList.md](/languageSpecification/tokenList.md) file.

Parent clause:
- [generateSectionRule.md](../subClauses/generateSectionRule.md)

Related fuzzy clauses:
- [checkForFuzzySetRule.md](./checkForFuzzySetRule.md)
- [alphaCutRule.md](./alphaCutRule.md)

Fuzzy instructions:
- [createFuzzyOperator.md](/languageSpecification/createFuzzyOperator.md)
- [createFuzzyEvaluator.md](/languageSpecification/createFuzzyEvaluator.md)

Fuzzy functions:
- [MEMBERSHIP_ARRAY function](/languageSpecification/notation/predefinedFunctions.md#membership_array)
