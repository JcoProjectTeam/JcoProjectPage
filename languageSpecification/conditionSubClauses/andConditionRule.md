# AND Condition

The **andConditionRule** defines a logical AND condition that combines multiple NOT conditions. The condition is satisfied **only if all** of the NOT conditions evaluate to true.

## EBNF Syntax

```ebnf
andConditionRule ::= notConditionRule (AND notConditionRule)*
```

Where:
- **notConditionRule** - A condition that can optionally be negated with NOT
- **AND** - Logical AND operator

## Syntax Diagram
![AND Condition Syntax](/languageSpecification/assets/rules/andConditionRule.png "AND Condition Syntax Diagram")

## Semantics

An **AND condition** evaluates multiple NOT conditions from left to right:

- If **all** NOT conditions are **true**, the entire AND condition is **true**
- If **any** NOT condition is **false**, the AND condition is **false**
- Evaluation uses **short-circuit**: stops as soon as a false condition is found

### Evaluation Order

```
condition1 AND condition2 AND condition3
```

1. Evaluates `condition1`
   - If **false** → returns **false** (stops)
   - If **true** → continues to `condition2`
2. Evaluates `condition2`
   - If **false** → returns **false** (stops)
   - If **true** → continues to `condition3`
3. Evaluates `condition3`
   - Returns its result

### Operator Precedence

In logical expressions:
1. **NOT** (highest priority)
2. **AND** (medium priority)
3. **OR** (lowest priority)

This means:
- `A AND B OR C` is evaluated as `(A AND B) OR C`
- `A OR B AND C` is evaluated as `A OR (B AND C)`

## Used In

The **andConditionRule** is used in:
- **orConditionRule** - As a component of OR conditions
- All WHERE clauses (through orConditionRule)
- All conditional filtering and branching

## Examples

### Example 1: Simple AND Between Two Conditions
```jcoql
FILTER
CASE WHERE .price > 50 AND .price < 100
GENERATE BUILD { .name, .price };
```
**Description:** Selects products with price in the range 50-100 (exclusive).

**Result:** Only products with 50 < price < 100 are kept.

---

### Example 2: AND Between Multiple Conditions
```jcoql
FILTER
CASE WHERE .category = "electronics" AND .inStock = TRUE AND .rating >= 4.0
GENERATE BUILD { .name, .category, .rating };
```
**Description:** Selects electronics that are in stock AND have good ratings.

**Result:** All three conditions must be true for a product to be kept.

---

### Example 3: AND with Field Existence Checks
```jcoql
FILTER
CASE WHERE .email ISNOTNULL AND .phone ISNOTNULL AND .address ISNOTNULL
GENERATE BUILD { .name, .email, .phone, .address };
```
**Description:** Keeps only documents with complete contact information (all three fields present).

**Result:** Documents missing any contact field are filtered out.

---

### Example 4: AND with Range and Category Filters
```jcoql
FILTER
CASE WHERE .category = "books" AND .price >= 10 AND .price <= 30 AND .pages > 200
GENERATE BUILD { .title, .price, .pages };
```
**Description:** Finds substantial books (> 200 pages) in a specific price range (10-30).

**Result:** All four conditions must be satisfied.

---

### Example 5: AND with Negation (NOT)
```jcoql
FILTER
CASE WHERE .status = "active" AND NOT .suspended AND .balance > 0
GENERATE BUILD { .accountId, .status, .balance };
```
**Description:** Finds active accounts that are not suspended and have positive balance.

**Result:** Combines affirmative and negative conditions with AND.

---

### Example 6: AND with Geographic Conditions
```jcoql
FILTER
CASE WHERE DISTANCE(center) < 5000 AND .rating >= 4.0 AND .priceRange = "$$"
GENERATE BUILD { .name, .rating, .priceRange, .distance: DISTANCE(center) };
```
**Description:** Finds moderately-priced, well-rated places within 5km.

**Result:** Must satisfy all three criteria: location, rating, and price.

---

### Example 7: AND with Fuzzy Set Membership
```jcoql
FILTER
CASE WHERE #youngPerson > 0.8 AND #highIncome > 0.7 AND .region = "North"
GENERATE BUILD { .name, .youngScore: #youngPerson, .incomeScore: #highIncome, .region };
```
**Description:** Finds young, high-income people in the North region (combining fuzzy and crisp conditions).

**Result:** All conditions must be satisfied, including fuzzy membership thresholds.

---

### Example 8: AND for Data Quality Filtering
```jcoql
FILTER
CASE WHERE .name ISNOTNULL AND .name != "" AND LENGTH(.name) > 2
GENERATE BUILD { .name, .data };
```
**Description:** Ensures name field is present, non-empty, and has meaningful length.

**Result:** Filters out documents with missing, empty, or too-short names.

---

### Example 9: AND with Date Range
```jcoql
FILTER
CASE WHERE .orderDate >= "2024-01-01" AND .orderDate <= "2024-12-31" AND .status = "completed"
GENERATE BUILD { .orderId, .orderDate, .status };
```
**Description:** Finds completed orders within the year 2024.

**Result:** Date must be in range AND status must be completed.

---

### Example 10: Complex Multi-Criteria AND
```jcoql
FILTER
CASE WHERE .customerType = "premium" AND 
           .totalPurchases > 1000 AND 
           .accountAge > 365 AND 
           .complaints = 0 AND
           .emailVerified = TRUE
GENERATE BUILD { 
    .customerId, 
    .customerType,
    .totalPurchases,
    .accountAge,
    .vipEligible: TRUE
};
```
**Description:** Identifies VIP-eligible customers by checking multiple stringent criteria.

**Result:** All five conditions must be true to mark customer as VIP-eligible.

---


### Testing Individual Conditions
Test each AND component separately:
```jcoql
// Test first condition
WHERE condition1
// Then test second
WHERE condition2
// Then combine
WHERE condition1 AND condition2
```

### Counting Progressive Filters
See how many documents pass each stage:
```jcoql
// Stage 1
WHERE condition1  // e.g., 1000 docs
// Stage 2
WHERE condition1 AND condition2  // e.g., 500 docs
// Stage 3
WHERE condition1 AND condition2 AND condition3  // e.g., 100 docs
```

### Identifying Failing Conditions
Add fields to show which conditions pass:
```jcoql
BUILD {
    .data,
    .cond1Pass: (.condition1),
    .cond2Pass: (.condition2),
    .cond3Pass: (.condition3)
}
```

## Issues

- Document behavior when a condition evaluates to NULL
- Clarify if there's a limit on the number of AND conditions
- Specify memory implications for complex AND chains

## References

For the *token list specification* see the [tokenList.md](/languageSpecification/tokenList.md) file.

Related subclauses:
- [orConditionRule.md](./orConditionRule.md) - OR logical conditions
- [notConditionRule.md](./notConditionRule.md) - NOT negation
- [predicateRule.md](./predicateRule.md) - Base predicates
- [whereCaseRule.md](../subClauses/whereCaseRule.md) - WHERE clause usage

Base elements:
- [baseElements.md](/languageSpecification/notation/baseElements.md)

Predefined functions:
- [predefinedFunctions.md](/languageSpecification/notation/predefinedFunctions.md)
