# OR Condition

The **orConditionRule** defines a logical OR condition that combines multiple AND conditions. The condition is satisfied if **at least one** of the AND conditions evaluates to true.

## EBNF Syntax

```ebnf
orConditionRule ::= andConditionRule (OR andConditionRule)*
```

Where:
- **andConditionRule** - An AND logical condition (can contain multiple predicates combined with AND)
- **OR** - Logical OR operator

## Syntax Diagram
![OR Condition Syntax](/languageSpecification/assets/rules/orConditionRule.png "OR Condition Syntax Diagram")

## Semantics

An **OR condition** evaluates multiple AND conditions from left to right:

- If **any** AND condition is **true**, the entire OR condition is **true**
- If **all** AND conditions are **false**, the OR condition is **false**
- Evaluation uses **short-circuit**: stops as soon as a true condition is found

### Evaluation Order

```
condition1 OR condition2 OR condition3
```

1. Evaluates `condition1`
   - If **true** → returns **true** (stops)
   - If **false** → continues to `condition2`
2. Evaluates `condition2`
   - If **true** → returns **true** (stops)
   - If **false** → continues to `condition3`
3. Evaluates `condition3`
   - Returns its result

### Operator Precedence

In logical expressions:
1. **NOT** (highest priority)
2. **AND** (medium priority)
3. **OR** (lowest priority)

This means:
- `A OR B AND C` is evaluated as `A OR (B AND C)`
- Use parentheses for different grouping (not directly supported in current grammar, but AND groups first)

## Used In

The **orConditionRule** is used in:
- **whereCaseRule** - In the WHERE condition of CASE clauses
- **predicateRule** - Can be nested in complex predicates
- All instructions with WHERE clause:
  - filterRule
  - groupRule
  - expandRule
  - joinOfCollectionsRule
  - lookupFromWebRule

## Examples

### Example 1: Simple OR Between Two Conditions
```jcoql
FILTER
CASE WHERE .price < 10 OR .price > 1000
GENERATE BUILD { .name, .price };
```
**Description:** Selects products that are either very cheap (< 10) or very expensive (> 1000).

**Result:** Documents with price = 5 or price = 1500 are kept; documents with price = 500 are filtered out.

---

### Example 2: OR Between Multiple Conditions
```jcoql
FILTER
CASE WHERE .status = "pending" OR .status = "processing" OR .status = "review"
GENERATE BUILD { .orderId, .status };
```
**Description:** Selects orders in any of three active statuses.

**Result:** Only orders with status "pending", "processing", or "review" are kept.

---

### Example 3: OR with Complex AND Conditions
```jcoql
FILTER
CASE WHERE (.category = "electronics" AND .price < 100) OR 
           (.category = "books" AND .price < 20)
GENERATE BUILD { .name, .category, .price };
```
**Description:** Selects cheap electronics (< 100) OR cheap books (< 20).

**Result:** 
- Electronics costing 80 → **kept**
- Books costing 15 → **kept**
- Electronics costing 150 → **filtered out**
- Books costing 25 → **filtered out**

---

### Example 4: OR with Field Existence Checks
```jcoql
FILTER
CASE WHERE .email ISNOTNULL OR .phone ISNOTNULL
GENERATE BUILD { .name, .email, .phone };
```
**Description:** Keeps documents that have at least one contact method (email OR phone).

**Result:** Documents without both email and phone are filtered out.

---

### Example 5: OR with Range Conditions
```jcoql
FILTER
CASE WHERE .temperature < 0 OR .temperature > 35
GENERATE BUILD { .location, .temperature, .alert: "extreme" };
```
**Description:** Selects locations with extreme temperatures (freezing or very hot).

**Result:** 
- temperature = -5 → **kept** (extreme cold)
- temperature = 38 → **kept** (extreme heat)
- temperature = 22 → **filtered out** (normal)

---

### Example 6: OR with Multiple Field Comparisons
```jcoql
FILTER
CASE WHERE .priority = "urgent" OR .daysOpen > 30 OR .customerTier = "premium"
GENERATE BUILD { .ticketId, .priority, .daysOpen, .customerTier };
```
**Description:** Selects support tickets that need attention for any of three reasons.

**Result:** A ticket is kept if it's urgent OR old OR from a premium customer.

---

### Example 7: OR with Fuzzy Set Membership
```jcoql
FILTER
CASE WHERE #youngPerson > 0.7 OR #student > 0.7
GENERATE BUILD { .name, .age, .youngScore: #youngPerson, .studentScore: #student };
```
**Description:** Selects people who are highly young OR highly students (fuzzy logic).

**Result:** Documents with high membership in either fuzzy set are kept.

---

### Example 8: OR Combining Geographic and Attribute Conditions
```jcoql
FILTER
CASE WHERE DISTANCE(current) < 1000 OR .rating > 4.5
GENERATE BUILD { .name, .rating, .distance: DISTANCE(current) };
```
**Description:** Finds places that are either nearby (< 1km) OR highly rated (> 4.5 stars).

**Result:** Shows both close options and excellent distant options.

---

### Example 9: OR with NULL Checks
```jcoql
FILTER
CASE WHERE .discountCode ISNULL OR .discountCode = ""
GENERATE BUILD { .orderId, .originalPrice };
```
**Description:** Finds orders without discount codes (either NULL or empty string).

**Result:** Only orders without valid discount codes are kept.

---

### Example 10: Complex Nested OR Conditions
```jcoql
FILTER
CASE WHERE (.paymentStatus = "pending" AND .daysOverdue > 7) OR
           (.paymentStatus = "failed" AND .retryCount < 3) OR
           .accountSuspended = TRUE
GENERATE BUILD { 
    .accountId, 
    .paymentStatus, 
    .daysOverdue, 
    .retryCount,
    .requiresAction: TRUE
};
```
**Description:** Identifies accounts needing intervention for multiple possible reasons.

**Result:** Accounts matching any of the three complex conditions are flagged for action.

---



### Testing Individual Conditions
Test each OR branch separately to understand behavior:
```jcoql
// Test first condition
WHERE condition1
// Then test second
WHERE condition2
// Then combine
WHERE condition1 OR condition2
```

### Counting Matches
Add a field to see which condition matched:
```jcoql
BUILD {
    .data,
    .matchReason: IF(condition1, "reason1", IF(condition2, "reason2", "unknown"))
}
```

## Issues

- Clarify if parentheses can be used to override AND/OR precedence
- Document maximum number of OR conditions supported
- Specify behavior with NULL values in conditions

## References

For the *token list specification* see the [tokenList.md](/languageSpecification/tokenList.md) file.

Related subclauses:
- [andConditionRule.md](./andConditionRule.md) - AND logical conditions
- [notConditionRule.md](./notConditionRule.md) - NOT negation
- [predicateRule.md](./predicateRule.md) - Base predicates
- [whereCaseRule.md](../subClauses/whereCaseRule.md) - WHERE clause usage

Base elements:
- [baseElements.md](/languageSpecification/notation/baseElements.md)

Predefined functions:
- [predefinedFunctions.md](/languageSpecification/notation/predefinedFunctions.md)
