# Predefined Functions in JCoQL+

This page lists all predefined functions available in JCoQL+, divided into **regular functions** and **special functions** with special notation.

---

## Regular Predefined Functions

These are functions that can be used in expressions with standard function call syntax: `FUNCTION_NAME(parameters)`.

### Type Conversion Functions

| Function | Parameters | Returns | Description |
|----------|-----------|---------|-------------|
| **TO_STRING(x)** | any | string | Converts the parameter x into its string value. Empty string for sub-documents and arrays. |
| **TO_INT(x)** | any | integer | Converts the parameter x into its integer value. Returns 0 if not applicable. |
| **TO_FLOAT(x)** | any | float | Converts the parameter x into its float value. Returns 0 if not applicable. |
| **TO_BOOL(x)** | any | boolean | Converts the parameter x into its boolean value. Numbers ≠ 0 are True. Non-empty values are True. |
| **SERIALIZE(x)** | any | string | Serializes the parameter x into a string representation. |

**Examples:**
```jcoql
BUILD {
    .id: TO_STRING(.numericId),
    .price: TO_FLOAT(.priceString),
    .quantity: TO_INT(.qtyString),
    .active: TO_BOOL(.statusFlag)
}
```

---

### Numeric Functions

| Function | Parameters | Returns | Description |
|----------|-----------|---------|-------------|
| **COUNT(x)** | any | integer | Counts the elements of parameter x: 0 if null, 1 if not an array, array length if array. |
| **MAX(x, y)** | numeric, numeric | numeric | Returns the maximum between x and y. Null if any parameter is not a number. |
| **MIN(x, y)** | numeric, numeric | numeric | Returns the minimum between x and y. Null if any parameter is not a number. |
| **ABS(x)** | numeric | numeric | Returns the absolute value of x. Null if parameter is not a number. |
| **SQRT(x)** | numeric | numeric | Returns the square root of x. Null if parameter is not a number. |

**Examples:**
```jcoql
BUILD {
    .itemCount: COUNT(.items),
    .maxPrice: MAX(.price1, .price2),
    .minStock: MIN(.stock1, .stock2),
    .absValue: ABS(.temperature),
    .sqrtArea: SQRT(.area)
}
```

---

### Geospatial Functions

| Function | Parameters | Returns | Description |
|----------|-----------|---------|-------------|
| **GEODESIC_DISTANCE(lat1, lon1, lat2, lon2)** | float×4 | float | Returns the geodesic distance in meters between two lat-long coordinate pairs. Null if any parameter is not a number. |
| **GEOMETRY_FIELD()** | none | geometry | Returns the value of the `~geometry` field from the current document. |
| **GEOMETRY_LENGTH(unit)** | string | float | Returns the length of geometry in the `~geometry` field (if applicable). Unit can be 'M' (meters), 'KM' (kilometers), or 'ML' (miles). |
| **GEOMETRY_AREA(unit)** | string | float | Returns the area of geometry in the `~geometry` field (if applicable). Unit can be 'M' (square meters), 'KM' (square kilometers), or 'ML' (square miles). |

**Examples:**
```jcoql
BUILD {
    .distance: GEODESIC_DISTANCE(.lat1, .lon1, .lat2, .lon2),
    .geom: GEOMETRY_FIELD(),
    .pathLength: GEOMETRY_LENGTH("KM"),
    .surfaceArea: GEOMETRY_AREA("KM")
}
```

---

### String Functions

| Function | Parameters | Returns | Description |
|----------|-----------|---------|-------------|
| **JARO_WINKLER_SIMILARITY(s1, s2)** | string, string | float | Returns the Jaro-Winkler similarity between two strings (0-1). Case-insensitive. Null if any parameter is not a string. |

**Examples:**
```jcoql
BUILD {
    .nameSimilarity: JARO_WINKLER_SIMILARITY(.name1, .name2),
    .match: IF(JARO_WINKLER_SIMILARITY(.text1, .text2) > 0.8, "MATCH", "NO MATCH")
}
```

---

### Array Functions

Documentation for array functions coming soon:
- **MIN_ARRAY(array)** - Returns minimum value from array
- **MAX_ARRAY(array)** - Returns maximum value from array
- **AVG_ARRAY(array)** - Returns average value from array
- **SUM_ARRAY(array)** - Returns sum of array values

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
