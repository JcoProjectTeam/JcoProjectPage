# ALPHACUT

The **alphaCutRule** applies an alpha-cut to documents based on their membership degrees in fuzzy sets, filtering those with membership below the specified threshold.

## EBNF Syntax

```ebnf
alphaCutRule ::= ALPHACUT numericRule [WITHIN LB ID (COMMA ID)* RB]
```

## Syntax Diagram
![Alpha Cut Syntax](/languageSpecification/assets/rules/alphaCutRule.png "Alpha Cut Syntax Diagram")

## Semantics

The **alpha-cut** is a fundamental operation of fuzzy logic that converts a fuzzy set into a crisp (classical) set by selecting only elements with membership degree greater than or equal to an alpha threshold.

### Components

- **ALPHACUT** - Keyword
- **numericRule** - Alpha value (threshold) between 0 and 1
  - `0.0` = includes all documents
  - `1.0` = includes only documents with perfect membership
- **WITHIN [...] ** - Optional: specifies which fuzzy sets to apply the alpha-cut to
  - If omitted, applies to **all** fuzzy sets in the `~fuzzysets` field

### Behavior

A document passes the alpha-cut if:
- **Without WITHIN**: At least one fuzzy set has membership ≥ alpha
- **With WITHIN**: At least one of the specified fuzzy sets has membership ≥ alpha

Documents that do not meet the condition are **eliminated** from the result.

## Used In

The **alphaCutRule** is used **exclusively** in:
- **generateSectionRule** - As part of the GENERATE section

## Examples

### Example 1: Simple Alpha-Cut
```jcoql
CREATE FUZZY OPERATOR hotTemperature
PARAMETERS temp TYPE FLOAT
EVALUATE (temp - 20) / 15;

FILTER
CASE WHERE .temperature != NULL
GENERATE
    CHECK FOR hotTemperature
    ALPHACUT 0.5
    BUILD {
        .stationId: .id,
        .temp: .temperature,
        .hotness: #hotTemperature
    };
```
**Description:** Keeps only stations with membership `hotTemperature ≥ 0.5` (temperature ≥ 27.5°C).

**Filtering example:**
- Station A: temp=30°C → membership=0.67 → **KEPT**
- Station B: temp=25°C → membership=0.33 → **ELIMINATED**
- Station C: temp=35°C → membership=1.00 → **KEPT**

---

### Example 2: Alpha-Cut with WITHIN (Specific Fuzzy Sets)
```jcoql
CREATE FUZZY OPERATOR nearParking ...;
CREATE FUZZY OPERATOR goodService ...;
CREATE FUZZY OPERATOR affordable ...;

FILTER
GENERATE
    CHECK FOR nearParking, goodService, affordable
    ALPHACUT 0.7 WITHIN [nearParking, goodService]
    BUILD {
        .name,
        .parking: #nearParking,
        .service: #goodService,
        .price: #affordable
    };
```
**Description:** Keeps only places where **at least one** between `nearParking` or `goodService` has membership ≥ 0.7. The `affordable` fuzzy set does not influence the alpha-cut.

**Filtering example:**
- Place A: parking=0.8, service=0.3, affordable=0.2 → **KEPT** (parking ≥ 0.7)
- Place B: parking=0.5, service=0.9, affordable=0.8 → **KEPT** (service ≥ 0.7)
- Place C: parking=0.4, service=0.6, affordable=1.0 → **ELIMINATED** (none ≥ 0.7)

---

### Example 3: Very Selective Alpha-Cut
```jcoql
FILTER
GENERATE
    CHECK FOR highQuality
    ALPHACUT 0.9
    BUILD {
        .productName: .name,
        .quality: #highQuality
    };
```
**Description:** Filters very aggressively, keeping only products with quality ≥ 0.9 (top 10% fuzzy).

---

### Example 4: Alpha-Cut After Multiple Fuzzy Sets
```jcoql
CREATE FUZZY OPERATOR accessible ...;
CREATE FUZZY OPERATOR safe ...;
CREATE FUZZY OPERATOR popular ...;

FILTER
GENERATE
    CHECK FOR accessible, safe, popular
    ALPHACUT 0.4
    BUILD {
        .placeName: .name,
        .accessibility: #accessible,
        .safety: #safe,
        .popularity: #popular,
        .averageScore: (#accessible + #safe + #popular) / 3
    };
```
**Description:** Keeps places where **at least one** among accessible, safe, or popular has membership ≥ 0.4.

---

### Example 5: Progressive Alpha-Cut
```jcoql
-- First phase: coarse filter
FILTER
CASE WHERE .category = "restaurant"
GENERATE
    CHECK FOR goodLocation
    ALPHACUT 0.3
    BUILD {...};

SAVE AS candidates;

-- Second phase: fine filter
GET COLLECTION candidates;
FILTER
GENERATE
    CHECK FOR excellentReviews
    ALPHACUT 0.8
    BUILD {...};
```
**Description:** Application of alpha-cut in successive phases to progressively refine results.

---

### Example 6: Combined with IF_FAILS
```jcoql
CREATE FUZZY OPERATOR validData
PARAMETERS value TYPE FLOAT
PRECONDITION value != NULL AND value > 0
EVALUATE 1.0;

FILTER
GENERATE
    CHECK FOR validData IF_FAILS DROP
    CHECK FOR qualityMetric
    ALPHACUT 0.6 WITHIN [qualityMetric]
    BUILD {
        .id,
        .value,
        .quality: #qualityMetric
    };
```
**Description:** First eliminates invalid data (IF_FAILS DROP), then applies alpha-cut on quality.

---

### Example 7: Alpha-Cut in JOIN
```jcoql
JOIN hotels AS h
CASE WHERE DISTANCE(h, 2000)
GENERATE
    CHECK FOR walkableDistance, goodValue
    ALPHACUT 0.6
    BUILD {
        .attraction: .name,
        .hotel: h.name,
        .walkability: #walkableDistance,
        .value: #goodValue
    };
```
**Description:** Keeps only attraction-hotel pairs with at least one criterion ≥ 0.6.

---

### Example 8: Multi-Grade Fuzzy Set
```jcoql
CREATE FUZZY SET MODEL temperature
DEGREES cold, warm, hot;

CREATE GENERIC FUZZY OPERATOR tempEval FOR temperature
...

FILTER
GENERATE
    CHECK FOR tempEval
    ALPHACUT 0.5 WITHIN [tempEval]
    BUILD {
        .stationId: .id,
        .coldDegree: #tempEval.cold,
        .warmDegree: #tempEval.warm,
        .hotDegree: #tempEval.hot
    };
```
**Description:** With multi-grade fuzzy sets, the alpha-cut considers the maximum degree among all degrees.

---


## Common Alpha Values

| Alpha | Interpretation | Typical Use |
|-------|----------------|------------|
| **0.0** | All documents | No filtering (useless) |
| **0.1-0.3** | Very low membership accepted | Initial filter, exploration |
| **0.4-0.6** | Moderate membership | General use, balanced |
| **0.7-0.8** | High membership | Quality results |
| **0.9-1.0** | Very high membership | Maximum selection, top results |

### Choosing the Alpha Value

```jcoql
-- Exploration: more results, less precise
ALPHACUT 0.3

-- Balanced: precision/recall compromise
ALPHACUT 0.5

-- Selection: few results, very precise
ALPHACUT 0.8
```

---


### Multi-Stage Filtering
```jcoql
-- Stage 1: Coarse filter
GET COLLECTION places;
FILTER
GENERATE
    CHECK FOR basicQuality
    ALPHACUT 0.3
    BUILD {...};
SAVE AS stage1;

-- Stage 2: Fine filter
GET COLLECTION stage1;
FILTER
GENERATE
    CHECK FOR detailedQuality
    ALPHACUT 0.8
    BUILD {...};
```

### Dynamic Alpha (Not Supported - Workaround)
```jcoql
-- Not supported: ALPHACUT .dynamicThreshold

-- Workaround: use WHERE
CHECK FOR quality
BUILD {...}
WHERE #quality >= .userThreshold;
```

---

## Issues

- Clarify if WITHIN supports OR between groups: `WITHIN [a,b] OR [c,d]`
- Document behavior with fuzzy sets not present in WITHIN
- Specify if alpha can be an expression or only a literal
- Define behavior with multi-grade fuzzy sets (which degree to use?)

## References

For the *token list specification* see the [tokenList.md](/languageSpecification/tokenList.md) file.

Parent clause:
- [generateSectionRule.md](../subClauses/generateSectionRule.md)

Related fuzzy clauses:
- [checkForFuzzySetRule.md](./checkForFuzzySetRule.md)
- [keepDropFuzzySetsRule.md](./keepDropFuzzySetsRule.md)

Fuzzy functions:
- [DEGREE function](/languageSpecification/notation/predefinedFunctions.md#degree)
- [MEMBERSHIP_ARRAY function](/languageSpecification/notation/predefinedFunctions.md#membership_array)
