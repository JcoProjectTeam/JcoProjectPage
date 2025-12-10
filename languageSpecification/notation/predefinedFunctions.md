# Predefined Functions

JCoQL+ provides a comprehensive set of predefined functions that can be used in expressions. Functions are divided into two categories:

1. **Standard Functions** - Use regular function call syntax: `FUNCTION_NAME(parameters)`
2. **Special Functions** - Have unique notation or syntax (e.g., `#fuzzySet`, `EXTRACT_ARRAY(field FROM ARRAY source)`)

---

## Function Index

### Standard Functions

#### Type Conversion Functions
- [TO_STRING(x)](#to_stringx) - Convert value to string
- [TO_INT(x)](#to_intx) - Convert value to integer
- [TO_FLOAT(x)](#to_floatx) - Convert value to float
- [TO_BOOL(x)](#to_boolx) - Convert value to boolean
- [SERIALIZE(x)](#serializex) - Serialize value to string

#### Numeric Functions
- [COUNT(x)](#countx) - Count elements
- [MAX(x, y)](#maxx-y) - Maximum of two values
- [MIN(x, y)](#minx-y) - Minimum of two values
- [ABS(x)](#absx) - Absolute value
- [SQRT(x)](#sqrtx) - Square root

#### Geospatial Functions
- [GEODESIC_DISTANCE(lat1, lon1, lat2, lon2)](#geodesic_distancelat1-lon1-lat2-lon2) - Distance between coordinates
- [GEOMETRY_FIELD()](#geometry_field) - Get ~geometry field value
- [GEOMETRY_LENGTH(unit)](#geometry_lengthunit) - Get geometry length
- [GEOMETRY_AREA(unit)](#geometry_areaunit) - Get geometry area

#### String Functions
- [JARO_WINKLER_SIMILARITY(s1, s2)](#jaro_winkler_similaritys1-s2) - String similarity measure

### Special Functions

#### Fuzzy Set Membership
- [EXTENT(f) / MEMBERSHIP_TO(f)](#extentf--membership_tof) - Get fuzzy membership degree
- [DEGREE(f) / #f](#degreef--f-shortcut) - Get fuzzy membership (shortcut notation)

#### Translation and Dictionary
- [TRANSLATE(exp, dictionary, caseSensitive, defaultValue)](#translateexp-dictionary-casesensitive--defaultvalue) - Translate using dictionary

#### Conditional Functions
- [IF((condition), trueExp, falseExp)](#ifcondition-trueexp-falseexp) - Conditional expression
- [IF_ERROR(exp, errValue)](#if_errorexp-errvalue) - Error handling

#### Array Functions
- [MEMBERSHIP_ARRAY(...)](#membership_arrayall--membership_arrayf1-f2---membership_arrayf-from-array-source) - Extract membership arrays
- [EXTRACT_ARRAY(fieldY FROM ARRAY arrayX)](#extract_arrayfieldy-from-array-arrayx) - Extract field values from array
- [ARRAY_CUMULATE(x)](#array_cumulatex) - Sum array values

---

## Standard Functions

These functions use standard call syntax and can be used in any expression context.

### Type Conversion Functions

Functions for converting values between different data types.

#### TO_STRING(x)
Converts parameter `x` into its string representation.

**Returns:**
- String representation of the value
- Empty string for sub-documents and arrays

**Examples:**
```jcoql
BUILD {
    .id: TO_STRING(.numericId),           // 123 → "123"
    .label: TO_STRING(.value),            // Any value to string
    .formatted: TO_STRING(.price)         // 99.99 → "99.99"
}
```

---

#### TO_INT(x)
Converts parameter `x` into an integer value.

**Returns:**
- Integer representation of the value
- `0` if conversion is not applicable

**Examples:**
```jcoql
BUILD {
    .quantity: TO_INT(.qtyString),        // "42" → 42
    .rounded: TO_INT(.floatValue),        // 42.7 → 42
    .parsed: TO_INT("123")                // "123" → 123
}
```

---

#### TO_FLOAT(x)
Converts parameter `x` into a floating-point value.

**Returns:**
- Float representation of the value
- `0.0` if conversion is not applicable

**Examples:**
```jcoql
BUILD {
    .price: TO_FLOAT(.priceString),       // "99.99" → 99.99
    .decimal: TO_FLOAT(.intValue),        // 42 → 42.0
    .value: TO_FLOAT("3.14")              // "3.14" → 3.14
}
```

---

#### TO_BOOL(x)
Converts parameter `x` into a boolean value.

**Returns:**
- `TRUE` for:
  - Numbers not equal to 0
  - Non-empty strings
  - Non-null values
- `FALSE` for:
  - Zero (0)
  - Empty strings
  - Null values

**Examples:**
```jcoql
BUILD {
    .active: TO_BOOL(.statusFlag),        // 1 → TRUE, 0 → FALSE
    .hasValue: TO_BOOL(.field),           // "text" → TRUE, "" → FALSE
    .enabled: TO_BOOL(.count)             // 5 → TRUE, 0 → FALSE
}
```

---

#### SERIALIZE(x)
Serializes parameter `x` into its string representation.

**Returns:**
- String serialization of the value (typically JSON format)

**Examples:**
```jcoql
BUILD {
    .serialized: SERIALIZE(.document),    // Object → JSON string
    .arrayStr: SERIALIZE(.items)          // Array → JSON string
}
```

---

### Numeric Functions

Functions for mathematical operations and numeric computations.

#### COUNT(x)
Counts the elements of parameter `x`.

**Returns:**
- `0` if x is null
- `1` if x is not an array
- Array length if x is an array

**Examples:**
```jcoql
BUILD {
    .itemCount: COUNT(.items),            // [1,2,3] → 3
    .hasValue: COUNT(.field),             // single value → 1
    .isEmpty: COUNT(.optional)            // null → 0
}
```

---

#### MAX(x, y)
Returns the maximum value between parameters `x` and `y`.

**Returns:**
- The larger of the two numeric values
- `null` if any parameter is not a number

**Examples:**
```jcoql
BUILD {
    .maxPrice: MAX(.price1, .price2),     // MAX(100, 150) → 150
    .highest: MAX(.value, 0),             // Ensure non-negative
    .bestScore: MAX(.scoreA, .scoreB)
}
```

---

#### MIN(x, y)
Returns the minimum value between parameters `x` and `y`.

**Returns:**
- The smaller of the two numeric values
- `null` if any parameter is not a number

**Examples:**
```jcoql
BUILD {
    .minStock: MIN(.stock1, .stock2),     // MIN(5, 3) → 3
    .lowest: MIN(.value, 100),            // Cap at maximum
    .bestTime: MIN(.timeA, .timeB)
}
```

---

#### ABS(x)
Returns the absolute value of parameter `x`.

**Returns:**
- Absolute (non-negative) value of x
- `null` if parameter is not a number

**Examples:**
```jcoql
BUILD {
    .absValue: ABS(.temperature),         // ABS(-5) → 5
    .distance: ABS(.diff),                // ABS(-10) → 10
    .magnitude: ABS(.offset)              // ABS(7) → 7
}
```

---

#### SQRT(x)
Returns the square root of parameter `x`.

**Returns:**
- Square root of x
- `null` if parameter is not a number

**Examples:**
```jcoql
BUILD {
    .sqrtArea: SQRT(.area),               // SQRT(25) → 5.0
    .standardDev: SQRT(.variance),
    .euclidean: SQRT(.sumSquares)
}
```

---

### Geospatial Functions

Functions for working with geographic coordinates and geometry objects.

#### GEODESIC_DISTANCE(lat1, lon1, lat2, lon2)
Returns the geodesic distance between two lat-long coordinate pairs.

**Parameters:**
- `lat1`, `lon1` - First point coordinates (latitude, longitude)
- `lat2`, `lon2` - Second point coordinates (latitude, longitude)

**Returns:**
- Distance in meters
- `null` if any parameter is not a number

**Examples:**
```jcoql
BUILD {
    .distance: GEODESIC_DISTANCE(.lat1, .lon1, .lat2, .lon2),
    .distanceKm: (GEODESIC_DISTANCE(.lat1, .lon1, .lat2, .lon2) / 1000),
    .travelDist: GEODESIC_DISTANCE(45.464, 9.188, 45.478, 9.234)
}
```

---

#### GEOMETRY_FIELD()
Returns the value of the special `~geometry` field from the current document.

**Returns:**
- The geometry object stored in `~geometry`
- Typically contains GeoJSON geometry

**Examples:**
```jcoql
BUILD {
    .geom: GEOMETRY_FIELD(),              // Get geometry object
    .hasGeometry: (GEOMETRY_FIELD() != null)
}
```

---

#### GEOMETRY_LENGTH(unit)
Returns the length of the geometry in the `~geometry` field (if applicable).

**Parameters:**
- `unit` - Unit of measurement:
  - `"M"` - Meters
  - `"KM"` - Kilometers
  - `"ML"` - Miles

**Returns:**
- Length in specified unit
- Applicable to LineString and Polygon geometries
- `null` if geometry doesn't have length

**Examples:**
```jcoql
BUILD {
    .pathLength: GEOMETRY_LENGTH("KM"),   // Length in kilometers
    .roadLengthMiles: GEOMETRY_LENGTH("ML"),
    .perimeterMeters: GEOMETRY_LENGTH("M")
}
```

---

#### GEOMETRY_AREA(unit)
Returns the area of the geometry in the `~geometry` field (if applicable).

**Parameters:**
- `unit` - Unit of measurement:
  - `"M"` - Square meters
  - `"KM"` - Square kilometers
  - `"ML"` - Square miles

**Returns:**
- Area in specified unit
- Applicable to Polygon geometries
- `null` if geometry doesn't have area

**Examples:**
```jcoql
BUILD {
    .surfaceArea: GEOMETRY_AREA("KM"),    // Area in sq. kilometers
    .parkAreaM2: GEOMETRY_AREA("M"),      // Area in sq. meters
    .landAreaMiles: GEOMETRY_AREA("ML")   // Area in sq. miles
}
```

---

### String Functions

Functions for string operations and comparisons.

#### JARO_WINKLER_SIMILARITY(s1, s2)
Returns the Jaro-Winkler similarity between two strings.

**Parameters:**
- `s1`, `s2` - Two strings to compare

**Returns:**
- Similarity value between 0.0 (completely different) and 1.0 (identical)
- The function is **case-insensitive**
- `null` if any parameter is not a string

**Examples:**
```jcoql
BUILD {
    .nameSimilarity: JARO_WINKLER_SIMILARITY(.name1, .name2),
    .isMatch: (JARO_WINKLER_SIMILARITY(.text1, .text2) > 0.8),
    .score: JARO_WINKLER_SIMILARITY("Martha", "Marhta")  // → 0.96
}
```

**Common Use Cases:**
- Fuzzy name matching
- Detecting typos
- Record linkage
- Data deduplication

---

## Special Functions with Special Notation

These functions have unique syntax and are used in specific contexts.

### Fuzzy Set Membership Functions

#### EXTENT(f) / MEMBERSHIP_TO(f)
Returns the membership degree of a document to fuzzy set `f`. Returns null if membership has not been evaluated.

**Syntax:**
```jcoql
EXTENT(fuzzySetName)
MEMBERSHIP_TO(fuzzySetName)  -- Deprecated, use EXTENT or #
```

**Example:**
```jcoql
BUILD {
    .hotness: EXTENT(hotTemperature),
    .proximity: MEMBERSHIP_TO(nearParking)
}
```

---

#### DEGREE(f) / #f (Shortcut)
Returns the membership degree of a document to fuzzy set `f`. For multi-grade fuzzy sets, use `DEGREE(f.d)` or `#f.d` to access specific degree `d`.

**Syntax:**
```jcoql
DEGREE(fuzzySetName)           -- Simple fuzzy set
#fuzzySetName                  -- Shortcut notation

DEGREE(fuzzySetName.degreeName)  -- Multi-grade fuzzy set
#fuzzySetName.degreeName         -- Shortcut notation
```

**Examples:**
```jcoql
BUILD {
    -- Simple fuzzy set
    .hotness: DEGREE(hotTemperature),
    .hotnessShortcut: #hotTemperature,
    
    -- Multi-grade fuzzy set
    .tempLow: DEGREE(temperature.low),
    .tempMedium: #temperature.medium,
    .tempHigh: #temperature.high
}
```

---

### Translation and Dictionary Functions

#### TRANSLATE(exp, dictionary, caseSensitive [, defaultValue])
Translates a string using a loaded dictionary (see GET DICTIONARY instruction).

**Syntax:**
```jcoql
TRANSLATE(expression, dictionaryName, caseSensitive)
TRANSLATE(expression, dictionaryName, caseSensitive, defaultValue)
```

**Parameters:**
- `expression` - Expression that evaluates to a string
- `dictionaryName` - Name of a loaded dictionary
- `caseSensitive` - Boolean: true for case-sensitive, false for case-insensitive
- `defaultValue` - Optional: returned if no translation is found (otherwise null)

**Examples:**
```jcoql
BUILD {
    .translatedName: TRANSLATE(.countryCode, countriesDict, FALSE),
    .categoryName: TRANSLATE(.categoryId, categories, TRUE, "Unknown")
}
```

---

### Conditional Functions

#### IF((condition), trueExp, falseExp)
Returns `trueExp` if condition is true, otherwise returns `falseExp`.

**Syntax:**
```jcoql
IF((condition), valueIfTrue, valueIfFalse)
```

**Examples:**
```jcoql
BUILD {
    .grade: IF(.score >= 60, "PASS", "FAIL"),
    .discount: IF(.price > 100, 0.10, 0.05),
    .category: IF(.temp > 30, "hot",
                  IF(.temp > 20, "warm",
                     IF(.temp > 10, "cool", "cold")))
}
```

---

#### IF_ERROR(exp, errValue)
Returns the value of expression `exp`. If any error arises, returns `errValue` instead.

**Syntax:**
```jcoql
IF_ERROR(expression, valueIfError)
```

**Examples:**
```jcoql
BUILD {
    .safeValue: IF_ERROR(.riskyField, 0),
    .price: IF_ERROR(TO_FLOAT(.priceString), 0.0),
    .division: IF_ERROR(.numerator / .denominator, NULL)
}
```

---

### Array Extraction Functions

#### MEMBERSHIP_ARRAY(ALL) / MEMBERSHIP_ARRAY(f1, f2, ...) / MEMBERSHIP_ARRAY(f FROM ARRAY source)

Returns arrays of membership values from fuzzy sets.

**Syntax:**
```jcoql
MEMBERSHIP_ARRAY(ALL)                    -- All memberships in ~fuzzysets
MEMBERSHIP_ARRAY(f1, f2, ...)            -- Specific fuzzy sets
MEMBERSHIP_ARRAY(f FROM ARRAY source)     -- Fuzzy set f from array elements
```

**Examples:**
```jcoql
BUILD {
    -- All memberships
    .allMemberships: MEMBERSHIP_ARRAY(ALL),
    
    -- Specific fuzzy sets
    .selectedMemberships: MEMBERSHIP_ARRAY(fs1, fs2, fs3),
    
    -- From array
    .groupMemberships: MEMBERSHIP_ARRAY(quality FROM ARRAY .items)
}
```

---

#### EXTRACT_ARRAY(fieldY FROM ARRAY arrayX)
Creates a new array from source `arrayX` with the values of field `fieldY` from each element.

**Syntax:**
```jcoql
EXTRACT_ARRAY(fieldName FROM ARRAY sourceArray)
```

**Examples:**
```jcoql
BUILD {
    .allPrices: EXTRACT_ARRAY(.price FROM ARRAY .items),
    .allNames: EXTRACT_ARRAY(.name FROM ARRAY .products),
    .coordinates: EXTRACT_ARRAY(.lat FROM ARRAY .locations)
}
```

---

#### ARRAY_CUMULATE(x)
Sums the numeric values of an array. Returns 0 if not applicable.

**Syntax:**
```jcoql
ARRAY_CUMULATE(array)
```

**Examples:**
```jcoql
BUILD {
    .totalPrice: ARRAY_CUMULATE(.prices),
    .sumQuantities: ARRAY_CUMULATE(.quantities)
}
```

---

## Function Categories Summary

| Category | Functions | Use Cases |
|----------|-----------|-----------|
| **Type Conversion** | TO_STRING, TO_INT, TO_FLOAT, TO_BOOL, SERIALIZE | Data normalization, format conversion |
| **Numeric** | COUNT, MAX, MIN, ABS, SQRT | Statistical calculations, comparisons |
| **Geospatial** | GEODESIC_DISTANCE, GEOMETRY_* | Distance calculations, spatial analysis |
| **String** | JARO_WINKLER_SIMILARITY | Name matching, fuzzy string comparison |
| **Fuzzy** | EXTENT, DEGREE, MEMBERSHIP_TO, MEMBERSHIP_ARRAY | Fuzzy set operations, membership access |
| **Conditional** | IF, IF_ERROR | Control flow, error handling |
| **Array** | EXTRACT_ARRAY, ARRAY_CUMULATE | Array manipulation, aggregation |
| **Translation** | TRANSLATE | Dictionary-based mapping |

---

## See Also
- [Base Elements](./baseElements.md) - Fundamental language components
- [Common Clauses](./commonClauses.md) - Reusable clause patterns
- [createFuzzyOperator](/languageSpecification/createFuzzyOperator.md) - Define custom fuzzy operators
- [generateSectionRule](/languageSpecification/subClauses/generateSectionRule.md) - Where functions are typically used
