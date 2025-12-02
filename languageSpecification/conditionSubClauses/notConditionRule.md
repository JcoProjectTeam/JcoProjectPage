# NOT Condition

The **notConditionRule** defines a condition that can optionally be negated using the NOT operator. It allows inverting the truth value of a predicate.

## EBNF Syntax

```ebnf
notConditionRule ::= [NOT] predicateRule
```

Where:
- **NOT** - Optional negation operator
- **predicateRule** - A base predicate (comparison, range check, null check, etc.)

## Syntax Diagram
![NOT Condition Syntax](/languageSpecification/assets/rules/notConditionRule.png "NOT Condition Syntax Diagram")

## Semantics

A **NOT condition** can appear in two forms:

### 1. Without NOT (Plain Predicate)
```
predicateRule
```
Returns the truth value of the predicate as is.

### 2. With NOT (Negated Predicate)
```
NOT predicateRule
```
Inverts the truth value:
- If predicate is **true** → returns **false**
- If predicate is **false** → returns **true**

### Operator Precedence

In logical expressions:
1. **NOT** (highest priority) - applied first
2. **AND** (medium priority)
3. **OR** (lowest priority)

This means:
- `NOT A AND B` is evaluated as `(NOT A) AND B`
- `NOT A OR B` is evaluated as `(NOT A) OR B`

### Negation Scope

NOT applies **only** to the immediately following predicate:
```jcoql
NOT .value > 10 AND .status = "active"
```
Is interpreted as:
```jcoql
(NOT (.value > 10)) AND (.status = "active")
```

## Used In

The **notConditionRule** is used in:
- **andConditionRule** - As components of AND conditions
- All WHERE clauses (through andConditionRule and orConditionRule)
- All conditional filtering and branching

## Examples

### Example 1: Simple NOT with Comparison
```jcoql
FILTER
CASE WHERE NOT .status = "deleted"
GENERATE BUILD { .id, .name, .status };
```
**Description:** Selects all documents except those with status "deleted".

**Result:** Equivalent to `.status != "deleted"` or `.status <> "deleted"`.

---

### Example 2: NOT with Field Existence
```jcoql
FILTER
CASE WHERE NOT .archived
GENERATE BUILD { .documentId, .title };
```
**Description:** Selects documents where the archived field is false, null, or missing.

**Result:** Keeps all non-archived documents.

---

### Example 3: NOT with NULL Check
```jcoql
FILTER
CASE WHERE NOT .email ISNULL
GENERATE BUILD { .userId, .email };
```
**Description:** Selects documents that have an email address (email is not null).

**Result:** Equivalent to `.email ISNOTNULL`.

---

### Example 4: NOT with Range Condition
```jcoql
FILTER
CASE WHERE NOT (.price >= 100 AND .price <= 500)
GENERATE BUILD { .productName, .price };
```
**Description:** Selects products with price outside the 100-500 range.

**Result:** Keeps products with price < 100 OR price > 500 (De Morgan's law).

---

### Example 5: Multiple NOT Conditions with AND
```jcoql
FILTER
CASE WHERE NOT .suspended AND NOT .deleted AND .active = TRUE
GENERATE BUILD { .accountId, .active };
```
**Description:** Finds accounts that are active, not suspended, and not deleted.

**Result:** All three conditions must be true (active AND not suspended AND not deleted).

---

### Example 6: NOT with OR (De Morgan's Law)
```jcoql
FILTER
CASE WHERE NOT (.status = "draft" OR .status = "archived")
GENERATE BUILD { .documentId, .status };
```
**Description:** Selects documents that are neither draft nor archived.

**Result:** Equivalent to `.status != "draft" AND .status != "archived"`.

---

### Example 7: NOT with Fuzzy Set Membership
```jcoql
FILTER
CASE WHERE NOT #excluded > 0.5
GENERATE BUILD { .name, .excludedScore: #excluded };
```
**Description:** Keeps documents with low membership (≤ 0.5) in the excluded fuzzy set.

**Result:** Inverts fuzzy logic - selects items NOT strongly in the fuzzy set.

---

### Example 8: NOT with Geographic Distance
```jcoql
FILTER
CASE WHERE NOT DISTANCE(center) < 1000
GENERATE BUILD { .locationName, .distance: DISTANCE(center) };
```
**Description:** Finds locations that are NOT close (≥ 1000 meters from center).

**Result:** Equivalent to `DISTANCE(center) >= 1000`.

---

### Example 9: NOT for Data Quality Filtering
```jcoql
FILTER
CASE WHERE NOT .email = "" AND NOT .email ISNULL
GENERATE BUILD { .userId, .email };
```
**Description:** Ensures email is neither empty string nor null (has a valid value).

**Result:** Keeps only documents with meaningful email addresses.

---

### Example 10: Complex Negation with Nested Conditions
```jcoql
FILTER
CASE WHERE NOT (.paymentFailed = TRUE AND .retryCount >= 3)
GENERATE BUILD { 
    .orderId, 
    .paymentFailed, 
    .retryCount,
    .stillRetriable: TRUE
};
```
**Description:** Finds orders that haven't exhausted payment retries (not failed with 3+ retries).

**Result:** Keeps orders where payment didn't fail OR retry count is still < 3.

---


### Understanding NOT Logic
Test with and without NOT to understand behavior:
```jcoql
// Without NOT - what passes?
WHERE .condition

// With NOT - what was filtered before?
WHERE NOT .condition
```

### Simplifying Complex NOT
Break down complex negations using De Morgan's laws:
```jcoql
// Original (complex)
NOT ((.a > 10 AND .b = "X") OR .c = TRUE)

// Apply De Morgan's
NOT (.a > 10 AND .b = "X") AND NOT .c = TRUE

// Apply De Morgan's again
(.a <= 10 OR .b != "X") AND .c = FALSE
```

### Visualizing Results
Add debug fields to see what NOT is filtering:
```jcoql
BUILD {
    .data,
    .originalCondition: (.condition),
    .negatedCondition: (NOT .condition)
}
```

## Issues

- Clarify behavior when predicateRule evaluates to NULL (three-valued logic)
- Document if double negation (NOT NOT) is supported
- Specify precedence when NOT is combined with other operators without parentheses

## References

For the *token list specification* see the [tokenList.md](/languageSpecification/tokenList.md) file.

Related subclauses:
- [orConditionRule.md](./orConditionRule.md) - OR logical conditions
- [andConditionRule.md](./andConditionRule.md) - AND logical conditions
- [predicateRule.md](./predicateRule.md) - Base predicates
- [whereCaseRule.md](../subClauses/whereCaseRule.md) - WHERE clause usage

Base elements:
- [baseElements.md](/languageSpecification/notation/baseElements.md)

Predefined functions:
- [predefinedFunctions.md](/languageSpecification/notation/predefinedFunctions.md)
