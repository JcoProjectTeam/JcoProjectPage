# CHECK FOR Fuzzy Set

The **checkForFuzzySetRule** verifies the membership of a document to one or more fuzzy sets, calculating membership degrees and handling any failures in the evaluation.

## EBNF Syntax

```ebnf
checkForFuzzySetRule ::= CHECK FOR ID (COMMA ID)* 
                          [IF_FAILS (KEEP | DROP)]
```

## Syntax Diagram
![Check For Fuzzy Set Syntax](/languageSpecification/assets/rules/checkForFuzzySetRule.png "Check For Fuzzy Set Syntax Diagram")

## Semantics

The **CHECK FOR** clause evaluates the membership of a document to one or more fuzzy sets previously defined through fuzzy operators or fuzzy evaluators. For each verified fuzzy set, the membership degree (value between 0 and 1) is calculated and stored in the special `~fuzzysets` field.

### Components

- **CHECK FOR** - Keyword that introduces the verification
- **ID** - Name of the fuzzy set to verify (can be repeated)
- **COMMA** - Separates multiple fuzzy set names
- **IF_FAILS** - Optional clause to handle failures
  - **KEEP** - Keeps the document even if evaluation fails (membership = 0)
  - **DROP** - Removes the document if evaluation fails

### Default Behavior

If **IF_FAILS** is not specified:
- Default behavior: **KEEP** (keeps document with membership 0)
- The fuzzy set is still added to `~fuzzysets` with value 0

## Used In

The **checkForFuzzySetRule** is used **exclusively** in:
- **generateSectionRule** - As part of the GENERATE section

## Examples

### Example 1: Single Fuzzy Set
```jcoql
CREATE FUZZY OPERATOR hotTemperature
PARAMETERS temp TYPE FLOAT
EVALUATE (temp - 25) / 10;

FILTER
CASE WHERE .temperature != NULL
GENERATE
    CHECK FOR hotTemperature
    BUILD {
        .stationId: .id,
        .temp: .temperature,
        .hotness: #hotTemperature
    };
```
**Description:** Checks each station for the `hotTemperature` fuzzy set and includes the membership degree in the result.

---

### Example 2: Multiple Fuzzy Sets
```jcoql
CREATE FUZZY OPERATOR closeLocation
PARAMETERS dist TYPE FLOAT
EVALUATE (1000 - dist) / 1000;

CREATE FUZZY OPERATOR goodRating
PARAMETERS rating TYPE FLOAT
EVALUATE (rating - 3) / 2;

FILTER
GENERATE
    CHECK FOR closeLocation, goodRating
    BUILD {
        .name,
        .proximity: #closeLocation,
        .quality: #goodRating,
        .overallScore: (0.6 * #closeLocation + 0.4 * #goodRating)
    };
```
**Description:** Verifies two fuzzy sets simultaneously and calculates a combined score.

---

### Example 3: With IF_FAILS KEEP (Default)
```jcoql
CREATE FUZZY OPERATOR affordable
PARAMETERS price TYPE FLOAT
PRECONDITION price > 0
EVALUATE (100 - price) / 100;

FILTER
GENERATE
    CHECK FOR affordable IF_FAILS KEEP
    BUILD {
        .productName: .name,
        .price,
        .affordability: #affordable
    };
```
**Description:** If the precondition fails (price ≤ 0), the document is kept with `#affordable = 0`.

---

### Example 4: With IF_FAILS DROP
```jcoql
CREATE FUZZY OPERATOR validMeasurement
PARAMETERS value TYPE FLOAT
PRECONDITION value >= 0 AND value <= 100
EVALUATE 1.0;

FILTER
GENERATE
    CHECK FOR validMeasurement IF_FAILS DROP
    BUILD {
        .sensorId: .id,
        .measurement: .value
    };
```
**Description:** Removes all documents with measurements out of range (value < 0 or > 100).

---

### Example 5: Chain Multiple Checks
```jcoql
CREATE FUZZY OPERATOR nearParking
...

CREATE FUZZY OPERATOR nearMetro
...

CREATE FUZZY OPERATOR goodAmenities
...

FILTER
GENERATE
    CHECK FOR nearParking
    CHECK FOR nearMetro
    CHECK FOR goodAmenities
    ALPHACUT 0.3
    BUILD {
        .placeName: .name,
        .parking: #nearParking,
        .metro: #nearMetro,
        .amenities: #goodAmenities,
        .accessibility: (#nearParking + #nearMetro) / 2
    };
```
**Description:** Verifies three fuzzy sets and applies an alpha-cut to filter results with low membership.

---

### Example 6: With Fuzzy Evaluator on Array
```jcoql
CREATE FUZZY EVALUATOR hasIncreasingTrend
PARAMETERS data TYPE ARRAY
EVALUATE
    -- logica per determinare trend crescente
    ...;

GROUP BY .stockSymbol
INTO .dailyPrices
GENERATE
    CHECK FOR hasIncreasingTrend IF_FAILS DROP
    BUILD {
        .symbol: .stockSymbol,
        .trendStrength: #hasIncreasingTrend,
        .recommendation: IF(#hasIncreasingTrend > 0.7, "BUY", "HOLD")
    };
```

---

### Example 7: Conditional Verification with JOIN
```jcoql
JOIN restaurants AS r
CASE WHERE DISTANCE(r, 1000)
GENERATE
    CHECK FOR walkableDistance, highRating
    BUILD {
        .hotelName: .name,
        .restaurantName: r.name,
        .walkability: #walkableDistance,
        .quality: #highRating,
        .combined: (#walkableDistance * 0.6 + #highRating * 0.4)
    }
    KEEP FUZZY SETS [walkableDistance, highRating];
```

---

## Issues

- Clarify if CHECK FOR can be used outside GENERATE
- Document behavior with already calculated fuzzy sets (recalculation vs reuse?)
- Specify evaluation order with multiple CHECK FOR
- Define limits on the number of fuzzy sets that can be verified simultaneously

## References

For the *token list specification* see the [tokenList.md](/languageSpecification/tokenList.md) file.

Parent clause:
- [generateSectionRule.md](../subClauses/generateSectionRule.md)

Related fuzzy instructions:
- [createFuzzyOperator.md](/languageSpecification/createFuzzyOperator.md)
- [createFuzzyEvaluator.md](/languageSpecification/createFuzzyEvaluator.md)
- [createGenericFuzzySetOperator.md](/languageSpecification/createGenericFuzzySetOperator.md)

Other fuzzy clauses:
- [alphaCutRule.md](./alphaCutRule.md)
- [keepDropFuzzySetsRule.md](./keepDropFuzzySetsRule.md)

Special functions:
- [DEGREE function](/languageSpecification/notation/predefinedFunctions.md#degree)
- [EXTENT function](/languageSpecification/notation/predefinedFunctions.md#extent)
