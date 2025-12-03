# Predicates

The **predicateRule** defines a base predicate used in conditions. A predicate is an expression that evaluates to true or false and can take multiple forms: comparisons, range checks, null checks, field presence checks, and fuzzy set predicates.

## EBNF Syntax

```ebnf
predicateRule ::= expressionRule [compareRule | inRangeRule]
                | nullPredicateRule
                | withPredicateRule
                | withoutPredicateRule
                | wukFuzzyPredicateRule
```

Where:
- **expressionRule** - An arithmetic or field expression, optionally followed by a comparison or range check
- **compareRule** - A comparison operator with another expression (e.g., `= value`, `> 10`)
- **inRangeRule** - A range check (e.g., `INRANGE [0, 100]`)
- **nullPredicateRule** - NULL check (e.g., `FIELD .email ISNULL`)
- **withPredicateRule** - Field presence check (e.g., `WITH .address`)
- **withoutPredicateRule** - Field absence check (e.g., `WITHOUT .tempData`)
- **wukFuzzyPredicateRule** - Fuzzy set membership check (e.g., `WITHIN FUZZY SETS setA, setB`)

## Syntax Diagram
![Predicate Syntax](/languageSpecification/assets/rules/predicateRule.png "Predicate Syntax Diagram")

## Semantics

A **predicate** is a boolean expression that can take one of five forms:

### 1. Expression with Comparison
```ebnf
expressionRule compareRule
```
Compares an expression with another value using a comparison operator.

**Examples:**
- `.price > 100` - price greater than 100
- `.name = "John"` - name equals "John"
- `.quantity <= .threshold` - quantity at most threshold value
- `(.total * 1.22) >= 1000` - calculated value comparison

### 2. Expression with Range Check
```ebnf
expressionRule inRangeRule
```
Checks if an expression falls within a specified range.

**Examples:**
- `.age INRANGE [18, 65]` - age between 18 and 65 (inclusive)
- `.temperature INRANGE (0, 100)` - temperature between 0 and 100 (exclusive)
- `.score INRANGE [60, 100)` - score from 60 (inclusive) to 100 (exclusive)

### 3. NULL Check
```ebnf
nullPredicateRule
```
Checks if a field is null or not null.

**Syntax:**
```
FIELD fieldRef ISNULL
FIELD fieldRef ISNOTNULL
```

**Examples:**
- `FIELD .email ISNULL` - email field is null
- `FIELD .description ISNOTNULL` - description field is not null

### 4. Field Presence Check
```ebnf
withPredicateRule
```
Checks if one or more fields exist in the document.

**Syntax:**
```
WITH [type] fieldRef (, fieldRef)*
```

Where `type` can be:
- **ID** - field must be an identifier
- **ARRAY** - field must be an array
- **GEOMETRY** - field must be a geometry object

**Examples:**
- `WITH .address` - document has address field
- `WITH .email, .phone` - document has both email and phone
- `WITH ARRAY .items` - document has items field and it's an array
- `WITH GEOMETRY .location` - document has location field and it's a geometry

### 5. Field Absence Check
```ebnf
withoutPredicateRule
```
Checks if one or more fields do NOT exist in the document.

**Syntax:**
```
WITHOUT fieldRef (, fieldRef)*
```

**Examples:**
- `WITHOUT .deletedAt` - document doesn't have deletedAt field
- `WITHOUT .tempData, .cacheData` - document has neither tempData nor cacheData

### 6. Fuzzy Set Membership
```ebnf
wukFuzzyPredicateRule
```
Checks membership in fuzzy sets.

**Syntax:**
```
(WITHIN | KNOWN | UNKNOWN) FUZZY SETS id (, id)*
```

**Examples:**
- `WITHIN FUZZY SETS youngPerson` - document has membership > 0 in youngPerson set
- `KNOWN FUZZY SETS priceRange` - document has calculated membership in priceRange set
- `UNKNOWN FUZZY SETS temperatureCategory` - document has NOT been evaluated for temperatureCategory

## Used In

The **predicateRule** is used in:
- **notConditionRule** - As the base element that can be negated
- All WHERE clauses (through notConditionRule → andConditionRule → orConditionRule)
- All conditional filtering and branching

## Examples

### Example 1: Simple Comparison Predicate
```jcoql
FILTER
CASE WHERE .price > 100
GENERATE BUILD { .name, .price };
```
**Description:** Uses expression with comparison operator.

**Result:** Keeps products with price greater than 100.

---

### Example 2: Field Equality Predicate
```jcoql
FILTER
CASE WHERE .category = "electronics"
GENERATE BUILD { .productId, .category };
```
**Description:** Compares field value to a string literal.

**Result:** Selects only electronics products.

---

### Example 3: Range Predicate
```jcoql
FILTER
CASE WHERE .age INRANGE [18, 65]
GENERATE BUILD { .name, .age };
```
**Description:** Checks if age falls within working-age range.

**Result:** Keeps people aged 18-65 (inclusive).

---

### Example 4: NULL Check Predicate
```jcoql
FILTER
CASE WHERE FIELD .email ISNOTNULL
GENERATE BUILD { .userId, .email };
```
**Description:** Ensures email field exists and is not null.

**Result:** Filters out documents with missing or null email.

---

### Example 5: WITH Field Presence Predicate
```jcoql
FILTER
CASE WHERE WITH .address, .phone
GENERATE BUILD { .customerId, .address, .phone };
```
**Description:** Ensures document has both address and phone fields.

**Result:** Keeps only documents with complete contact information.

---

### Example 6: WITHOUT Field Absence Predicate
```jcoql
FILTER
CASE WHERE WITHOUT .deletedAt
GENERATE BUILD { .documentId, .data };
```
**Description:** Selects non-deleted documents (those without deletedAt field).

**Result:** Filters out soft-deleted documents.

---

### Example 7: WITH Type-Specific Predicate
```jcoql
FILTER
CASE WHERE WITH ARRAY .items
GENERATE BUILD { .orderId, .itemCount: COUNT(.items) };
```
**Description:** Ensures items field exists AND is an array type.

**Result:** Filters out documents where items is missing or not an array.

---

### Example 8: Fuzzy Set Membership Predicate
```jcoql
FILTER
CASE WHERE WITHIN FUZZY SETS youngPerson, student
GENERATE BUILD { .name, .youngScore: #youngPerson, .studentScore: #student };
```
**Description:** Checks if document has membership in fuzzy sets (membership > 0).

**Result:** Keeps documents that belong to at least one of the specified fuzzy sets.

---

### Example 9: Complex Expression with Comparison
```jcoql
FILTER
CASE WHERE (.price * 1.22) > 1000
GENERATE BUILD { 
    .productName, 
    .basePrice: .price,
    .priceWithTax: (.price * 1.22)
};
```
**Description:** Compares a calculated expression (price with tax) to a threshold.

**Result:** Selects products whose taxed price exceeds 1000.

---

### Example 10: Multiple Field Comparison
```jcoql
FILTER
CASE WHERE .actualValue >= .targetValue
GENERATE BUILD { 
    .metricName, 
    .actual: .actualValue,
    .target: .targetValue,
    .achieved: TRUE
};
```
**Description:** Compares two field values from the same document.

**Result:** Identifies metrics that met or exceeded their targets.

---


### Test Individual Predicates
```jcoql
// Test comparison
WHERE .value > 100

// Test range
WHERE .value INRANGE [0, 100]

// Test existence
WHERE WITH .field
```

### Visualize Predicate Results
```jcoql
BUILD {
    .data,
    .predicateResult: (.value > 100),
    .inRange: (.value INRANGE [0, 100])
}
```

### Handle Missing Fields Safely
```jcoql
// Safe: check existence first
WHERE WITH .optionalField AND .optionalField > 0

// Unsafe: may fail if field doesn't exist
WHERE .optionalField > 0
```

## Issues

- Clarify behavior when comparing NULL values
- Document if expressions can be used in all predicate types
- Specify precedence when multiple predicate forms are possible
- Document maximum nesting depth for expressions in predicates

## References

For the *token list specification* see the [tokenList.md](/languageSpecification/tokenList.md) file.

Related subclauses:
- [orConditionRule.md](./orConditionRule.md) - OR logical conditions
- [andConditionRule.md](./andConditionRule.md) - AND logical conditions
- [notConditionRule.md](./notConditionRule.md) - NOT negation
- [compareRule.md](./compareRule.md) - Comparison operators
- [inRangeRule.md](./inRangeRule.md) - Range checks
- [nullPredicateRule.md](./nullPredicateRule.md) - NULL checks
- [withPredicateRule.md](./withPredicateRule.md) - Field presence
- [withoutPredicateRule.md](./withoutPredicateRule.md) - Field absence
- [wukFuzzyPredicateRule.md](../fuzzySubClauses/wukFuzzyPredicateRule.md) - Fuzzy predicates

Base elements:
- [baseElements.md](/languageSpecification/notation/baseElements.md)

Predefined functions:
- [predefinedFunctions.md](/languageSpecification/notation/predefinedFunctions.md)
