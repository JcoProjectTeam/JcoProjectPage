# KEEP/DROP FUZZY SETS

The **keepDropFuzzySetsRule** manages which fuzzy sets to keep or remove in the special `~fuzzysets` field of resulting documents.

## EBNF Syntax

```ebnf
keepDropFuzzySetsRule ::= (KEEP | DROP) FUZZY SETS LB ID (COMMA ID)* RB
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

## When to Use KEEP vs DROP

### Use KEEP when:
✅ **Few relevant fuzzy sets**
```jcoql
-- 10 fuzzy sets calculated, 2 relevant
KEEP FUZZY SETS [relevant1, relevant2]
```

✅ **Public Export/APIs**
```jcoql
-- Show only public metrics
KEEP FUZZY SETS [userScore, productRating]
```

✅ **Clean final document**
```jcoql
-- Only fuzzy sets for display
KEEP FUZZY SETS [displayMetric]
```

### Use DROP when:
✅ **Many relevant fuzzy sets, few to remove**
```jcoql
-- 10 fuzzy sets, 2 debug
DROP FUZZY SETS [debugMetric1, debugMetric2]
```

✅ **Remove internal metrics**
```jcoql
-- Remove intermediate calculations
DROP FUZZY SETS [tempCalc1, tempCalc2]
```

✅ **Incremental cleanup**
```jcoql
-- Remove progressively
DROP FUZZY SETS [noLongerNeeded]
```

---

## Interaction with Other Clauses

### With CHECK FOR
```jcoql
CHECK FOR fs1, fs2, fs3
KEEP FUZZY SETS [fs1, fs2]
```
**Result:** fs3 is calculated but not stored in `~fuzzysets`.

### With ALPHACUT
```jcoql
CHECK FOR fs1, fs2
ALPHACUT 0.5
KEEP FUZZY SETS [fs1]
```
**Order:**
1. CHECK FOR calculates membership
2. ALPHACUT filters documents
3. KEEP selects fuzzy sets to keep

### With BUILD
```jcoql
BUILD {
    .id,
    .score: #relevantFS
}
KEEP FUZZY SETS [relevantFS]
```
**Note:** Even if `#relevantFS` is used in BUILD, KEEP is necessary to maintain it in `~fuzzysets`.

---

## Common Patterns

### Pattern 1: Only Final Result
```jcoql
CHECK FOR intermediate1, intermediate2
-- Calculate final
CHECK FOR finalScore
KEEP FUZZY SETS [finalScore]
```

### Pattern 2: Privacy-Safe Export
```jcoql
CHECK FOR publicMetric, privateMetric
BUILD {...}
DROP FUZZY SETS [privateMetric]
```

### Pattern 3: Debugging → Production
```jcoql
-- Development:
CHECK FOR feature1, feature2, debugMetric
BUILD {...}
-- All fuzzy sets visible

-- Production:
CHECK FOR feature1, feature2, debugMetric
BUILD {...}
DROP FUZZY SETS [debugMetric]
```

### Pattern 4: Selective Aggregation
```jcoql
GROUP BY .group
INTO .items
GENERATE
    CHECK FOR itemMetric
    CHECK FOR groupMetric
    BUILD {...}
    KEEP FUZZY SETS [groupMetric]
```

---

## Effect on ~fuzzysets Field

### Document with all fuzzy sets
```json
{
  "id": "123",
  "~fuzzysets": {
    "fs1": 0.8,
    "fs2": 0.6,
    "fs3": 0.9,
    "fs4": 0.4
  }
}
```

### KEEP FUZZY SETS [fs1, fs3]
```json
{
  "id": "123",
  "~fuzzysets": {
    "fs1": 0.8,
    "fs3": 0.9
  }
}
```

### DROP FUZZY SETS [fs2, fs4]
```json
{
  "id": "123",
  "~fuzzysets": {
    "fs1": 0.8,
    "fs3": 0.9
  }
}
```

**Identical result** in this case!

---

## Access After KEEP/DROP

### With KEEP
```jcoql
KEEP FUZZY SETS [fs1, fs2]
BUILD {
    .id,
    .membership1: #fs1,         -- ✅ OK
    .membership2: #fs2,         -- ✅ OK
    .membership3: #fs3,         -- ⚠️ Null (not in ~fuzzysets)
    .all: ~fuzzysets            -- Contains only fs1 and fs2
}
```

### With DROP
```jcoql
DROP FUZZY SETS [fs3]
BUILD {
    .id,
    .membership1: #fs1,         -- ✅ OK
    .membership2: #fs2,         -- ✅ OK
    .membership3: #fs3,         -- ⚠️ Null (removed)
    .all: ~fuzzysets            -- Contains fs1 and fs2
}
```

---

## Execution Order in GENERATE

```jcoql
GENERATE
    1. [geometricOptionRule]      -- Manages geometry
    2. [checkForFuzzySetRule]     -- Calculates membership
    3. [alphaCutRule]             -- Filters by membership
    4. (buildActionRule)*         -- Builds structure
    5. [keepDropFuzzySetsRule]    -- ← Cleans ~fuzzysets
    6. [dropGeometryRule]         -- Removes geometry
```

**Implication:** `keepDropFuzzySetsRule` acts **after** BUILD, therefore:
- `#fuzzySet` in BUILD works even if fuzzy set will be removed
- Cleanup of `~fuzzysets` happens as the last step

---

## Limitations

### ❌ Cannot combine KEEP and DROP
```jcoql
❌ Not valid:
KEEP FUZZY SETS [fs1, fs2]
DROP FUZZY SETS [fs3]
```

**Solution:** Choose one or the other.

### ❌ Cannot KEEP uncalculated fuzzy sets
```jcoql
CHECK FOR fs1, fs2
KEEP FUZZY SETS [fs1, fs2, fs3]  -- ❌ fs3 doesn't exist!
```

### ❌ Cannot use wildcards
```jcoql
❌ Not supported:
KEEP FUZZY SETS [fs*]
KEEP FUZZY SETS [ALL EXCEPT fs1]
```

---

## Best Practices

### ✅ Do's

1. **Keep only necessary fuzzy sets**
   ```jcoql
   KEEP FUZZY SETS [userVisibleMetric]
   ```

2. **Document why you keep/remove**
   ```jcoql
   -- Keep only public-facing scores
   KEEP FUZZY SETS [publicScore]
   ```

3. **Use KEEP for whitelist, DROP for blacklist**
   ```jcoql
   -- Few relevant: KEEP
   -- Many relevant: DROP
   ```

4. **Coordinate with BUILD**
   ```jcoql
   BUILD {
       .score: #fuzzySet1,
       .other: #fuzzySet2
   }
   KEEP FUZZY SETS [fuzzySet1, fuzzySet2]
   ```

### ❌ Don'ts

1. **Don't remove still-used fuzzy sets**
   ```jcoql
   ❌ DROP FUZZY SETS [needed]
      -- But then #needed is used later!
   ```

2. **Don't use KEEP/DROP without CHECK FOR**
   ```jcoql
   ❌ KEEP FUZZY SETS [fs1]
      -- But fs1 was never calculated!
   ```

3. **Don't overload ~fuzzysets unnecessarily**
   ```jcoql
   ❌ CHECK FOR fs1, fs2, ..., fs20
      -- Without KEEP/DROP, all remain
   ```

---

## Performance and Storage

### Storage Impact
Each fuzzy set in `~fuzzysets` takes:
- Fuzzy set name: ~10-50 bytes
- Membership value: 8 bytes (float)
- **Total per fuzzy set:** ~20-60 bytes

**Example:**
```json
// 10 fuzzy sets = ~200-600 bytes extra
{
  "~fuzzysets": {
    "fs1": 0.8,
    "fs2": 0.6,
    ...
    "fs10": 0.3
  }
}
```

### Optimization
```jcoql
-- Before: 10 fuzzy sets = ~500 bytes extra
CHECK FOR fs1, fs2, ..., fs10

-- After: 2 fuzzy sets = ~100 bytes extra
KEEP FUZZY SETS [fs1, fs2]
```

**Savings:** ~80% storage on `~fuzzysets`

---

## Debugging

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
