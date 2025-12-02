# OTHERS Rule

The **othersRule** specifies what to do with documents that don't match any of the conditions in a CASE clause or other multi-branch structure.

## EBNF Syntax

```ebnf
<span style="color: purple">othersRule</span> ::= (KEEP | DROP) OTHERS
```

## Syntax Diagram
![OTHERS Rule Syntax](/languageSpecification/assets/rules/othersRule.png "OTHERS Rule Syntax Diagram")

## Semantics

The **OTHERS rule** acts as a catch-all clause for documents that don't satisfy any of the preceding conditions. It has two modes:

### KEEP OTHERS
Retains all unmatched documents in the result, keeping them unchanged.

```jcoql
KEEP OTHERS
```

### DROP OTHERS
Removes all unmatched documents from the result.

```jcoql
DROP OTHERS
```

## Used In

The **othersRule** is used in:
- **caseClauseRule** - To handle documents not matching any WHERE case
- **groupRule** - To handle documents not matching any partition
- **expandRule** - To handle documents without matching arrays
- **trajectoryMatchingRule** - To handle trajectories without matches

## Default Behavior

When **othersRule** is **omitted**, the default behavior depends on the context:

| Instruction | Default if OTHERS omitted |
|-------------|---------------------------|
| **FILTER (CASE)** | **DROP** - Unmatched documents are removed |
| **GROUP (PARTITION)** | **DROP** - Unmatched documents are removed |
| **EXPAND** | **DROP** - Documents without arrays are removed |
| **TRAJECTORY MATCHING** | **DROP** - Unmatched trajectories are removed |

**Best Practice:** Always specify KEEP OTHERS or DROP OTHERS explicitly to make intent clear.

## Examples

### Example 1: Filter with KEEP OTHERS
```jcoql
FILTER
CASE
    WHERE .status = "active"
    GENERATE BUILD {
        .id,
        .name,
        .active: TRUE
    };
    
    WHERE .status = "pending"
    GENERATE BUILD {
        .id,
        .name,
        .active: FALSE,
        .pending: TRUE
    };

KEEP OTHERS;
```
**Result:** Documents with status "active" or "pending" are transformed; all other documents (e.g., status="archived") are kept unchanged.

---

### Example 2: Filter with DROP OTHERS
```jcoql
FILTER
CASE
    WHERE .verified = TRUE AND .age >= 18;
    WHERE .verified = TRUE AND .specialPermission = TRUE;

DROP OTHERS;
```
**Result:** Only documents matching one of the conditions are kept; unverified or underage documents are removed.

---

### Example 3: GROUP with KEEP OTHERS
```jcoql
GROUP
PARTITION .region = "North"
BY .city
INTO .items
GENERATE BUILD { .region: "North", .city, .count: COUNT(.items) };

PARTITION .region = "South"
BY .city
INTO .items
GENERATE BUILD { .region: "South", .city, .count: COUNT(.items) };

KEEP OTHERS;
```
**Result:** Documents from "North" and "South" regions are grouped; documents from other regions (East, West) are kept individually.

---

### Example 4: GROUP with DROP OTHERS
```jcoql
GROUP
PARTITION .category = "electronics"
BY .brand
INTO .products
GENERATE BUILD {
    .category: "electronics",
    .brand,
    .totalSales: SUM(.products.sales)
};

PARTITION .category = "furniture"
BY .brand
INTO .products
GENERATE BUILD {
    .category: "furniture",
    .brand,
    .totalSales: SUM(.products.sales)
};

DROP OTHERS;
```
**Result:** Only "electronics" and "furniture" categories are processed; other categories are excluded from results.

---

### Example 5: EXPAND with KEEP OTHERS
```jcoql
EXPAND
UNPACK .type = "order" ARRAY .items TO .item
GENERATE BUILD {
    .orderId: .id,
    .customerId,
    .item
};

KEEP OTHERS;
```
**Result:** Documents with type="order" are expanded; documents with other types are kept unchanged.

---

### Example 6: EXPAND with DROP OTHERS
```jcoql
EXPAND
UNPACK WITH ARRAY .tags ARRAY .tags TO .tag
GENERATE BUILD {
    .documentId: .id,
    .tag
};

DROP OTHERS;
```
**Result:** Only documents with tags array are expanded; documents without tags are removed.

---

### Example 7: Complex Filter - Keep for Safety
```jcoql
FILTER
CASE
    WHERE .dataType = "sensor" AND .value != NULL
    GENERATE BUILD {
        .sensorId: .id,
        .reading: .value,
        .timestamp: .recorded
    };
    
    WHERE .dataType = "manual" AND .entry != NULL
    GENERATE BUILD {
        .entryId: .id,
        .value: .entry,
        .timestamp: .entered
    };

KEEP OTHERS;
```
**Result:** Known data types are transformed; unknown or malformed data is preserved for investigation.

---

### Example 8: Strict Validation - Drop Invalids
```jcoql
FILTER
CASE
    WHERE .email != NULL AND MATCHES(.email, "^[^@]+@[^@]+\\.[^@]+$")
    GENERATE BUILD {
        .userId: .id,
        .email,
        .validated: TRUE
    };
    
    WHERE .phone != NULL AND LENGTH(.phone) >= 10
    GENERATE BUILD {
        .userId: .id,
        .phone,
        .validated: TRUE
    };

DROP OTHERS;
```
**Result:** Only documents with valid email or phone are kept; invalid or incomplete documents are dropped.

---

### Example 9: Multi-Tier Classification
```jcoql
FILTER
CASE
    WHERE .score >= 90
    GENERATE BUILD { .id, .name, .tier: "PLATINUM", .discount: 0.30 };
    
    WHERE .score >= 75
    GENERATE BUILD { .id, .name, .tier: "GOLD", .discount: 0.20 };
    
    WHERE .score >= 50
    GENERATE BUILD { .id, .name, .tier: "SILVER", .discount: 0.10 };
    
    WHERE .score >= 25
    GENERATE BUILD { .id, .name, .tier: "BRONZE", .discount: 0.05 };

KEEP OTHERS;  -- Score < 25: keep as-is (no tier)
```

---

### Example 10: Exception Handling Pattern
```jcoql
FILTER
CASE
    WHERE .processable = TRUE AND .errors = 0
    GENERATE BUILD {
        .id,
        .result: PROCESS(.data),
        .status: "SUCCESS"
    };
    
    WHERE .processable = TRUE AND .errors > 0
    GENERATE BUILD {
        .id,
        .errorCount: .errors,
        .status: "PARTIAL"
    };

KEEP OTHERS;  -- Keep unprocessable for manual review
```

---

## Issues

- Clarify if OTHERS rule can have its own GENERATE transformation
- Document interaction with saveAsRule - are dropped documents lost forever?
- Specify if there's a way to access "dropped" documents for logging/auditing
- Define behavior in nested CASE structures (if supported)

## References

For the *token list specification* see the [tokenList.md](/languageSpecification/tokenList.md) file.

Used in:
- [caseClauseRule.md](./caseClauseRule.md)
- [groupRule.md](/languageSpecification/group.md)
- [expandRule.md](/languageSpecification/expand.md)
- [trajectoryMatchingRule.md](/languageSpecification/trajectoryMatching.md)

Related subclauses:
- [whereCaseRule.md](./whereCaseRule.md)
