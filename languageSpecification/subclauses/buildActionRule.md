# BUILD Action

The **buildActionRule** defines how to build or modify the structure of resulting documents. It allows creating new structures, adding fields, or removing existing fields.

## EBNF Syntax

```ebnf
buildActionRule ::= BUILD objectStructureRule
                  | ADD_ST FIELDS objectStructureRule
                  | REMOVE FIELDS LBR fieldRefRule (COMMA fieldRefRule)* RBR
```

## Syntax Diagram
![BUILD Action Syntax](/languageSpecification/assets/rules/buildActionRule.png "BUILD Action Syntax Diagram")

## Semantics

The **buildActionRule** offers three operating modes:

### 1. BUILD - Build from Scratch
Creates a new document structure, **completely replacing** the existing one with the specified fields.

**Syntax:**
```
BUILD { field1, field2: expression, ... }
```

### 2. ADD FIELDS - Add Fields
Adds new fields to the existing document **without removing** already present fields. If a specified field already exists, it is overwritten.

**Syntax:**
```
ADD FIELDS { newField1: expression, newField2, ... }
```

**Note:** `ADD_ST` and `ADD FIELDS` are synonyms in the grammar.

### 3. REMOVE FIELDS - Remove Fields
Removes specific fields from the document, keeping all others.

**Syntax:**
```
REMOVE FIELDS [.field1, .field2, .field3]
```

## Subclauses

### objectStructureRule
Defines the structure of a JSON object with the syntax:

```ebnf
objectStructureRule ::= LBR outputFieldSpecRule (COMMA outputFieldSpecRule)* RBR
```

Each field can be:
- **Simple field**: `.fieldname` - copies the field as is
- **Field with rename**: `.newName: .oldName` - renames the field
- **Field with expression**: `.result: (.price * 1.22)` - calculates a new value
- **Field with sub-object**: `.address: { .street, .city, .zip }` - nested structure

## Used In

The **buildActionRule** is used exclusively within:
- **generateSectionRule** - As part of the GENERATE transformation

Therefore indirectly in all instructions that use GENERATE:
- filterRule
- groupRule
- joinOfCollectionsRule
- whereCaseRule
- groupPartitionRule

## Examples

### Example 1: BUILD - Building New Structure
```jcoql
FILTER
CASE WHERE .score >= 60
GENERATE
    BUILD {
        .studentId: .id,
        .fullName: .name,
        .finalGrade: .score,
        .passed: TRUE,
        .graduationYear: 2025
    };
```
**Result:** Creates documents with **only** the 5 specified fields, removing all other original fields.

---

### Example 2: ADD FIELDS - Adding Fields
```jcoql
FILTER
CASE WHERE .price > 0
GENERATE
    ADD FIELDS {
        .priceWithVAT: (.price * 1.22),
        .discount: IF(.price > 100, 0.10, 0.05),
        .category: "electronics"
    };
```
**Result:** Keeps all original fields and adds the 3 new calculated fields.

---

### Example 3: REMOVE FIELDS - Removing Fields
```jcoql
FILTER
CASE WHERE .public = TRUE
GENERATE
    REMOVE FIELDS [.internalId, .privateNotes, .password, .ssn];
```
**Result:** Removes sensitive fields, keeping all other document fields.

---

### Example 4: Multiple BUILD Actions
```jcoql
GROUP PARTITION (.region = "North")
BY .city
INTO .sales
GENERATE
    BUILD {
        .cityName: .city,
        .totalSales: SUM(.sales.amount)
    }
    ADD FIELDS {
        .averageOrder: AVG(.sales.amount),
        .orderCount: COUNT(.sales),
        .topCustomer: MAX(.sales.customerName)
    };
```
**Result:** First builds the base structure with 2 fields, then adds 3 calculated fields.

---

### Example 5: Nested Structures
```jcoql
FILTER
GENERATE
    BUILD {
        .order: {
            .id: .orderId,
            .date: .orderDate,
            .total: .amount
        },
        .customer: {
            .name: .customerName,
            .email: .customerEmail,
            .address: {
                .street: .street,
                .city: .city,
                .zip: .zipCode
            }
        },
        .status: .orderStatus
    };
```
**Result:** Creates a hierarchical structure with nested objects.

---

### Example 6: With Complex Expressions
```jcoql
FILTER
CASE WHERE .temperature != NULL
GENERATE
    BUILD {
        .stationId,
        .tempCelsius: .temperature,
        .tempFahrenheit: ((.temperature * 9/5) + 32),
        .tempKelvin: (.temperature + 273.15),
        .category: IF(.temperature > 30, "hot",
                      IF(.temperature > 20, "warm",
                         IF(.temperature > 10, "cool", "cold"))),
        .measurement: {
            .value: .temperature,
            .unit: "°C",
            .timestamp: .recorded_at
        }
    };
```

---

## Implementation Notes

- **BUILD** always creates a new structure: even special fields (like `~geometry`, `~fuzzysets`) are removed unless explicitly included
- **ADD FIELDS** preserves special fields automatically
- **REMOVE FIELDS** can also remove special fields if specified (e.g., `REMOVE FIELDS [~geometry]`)
- Expressions in fields can use any predefined or user-defined function
- You can concatenate multiple `buildActionRule` in a single GENERATE section


## Issues

- Clarify behavior when using `REMOVE FIELDS` after `BUILD` (fields to remove might not exist)
- Document performance implications of BUILD vs ADD FIELDS vs REMOVE FIELDS
- Specify how duplicate fields are handled in `objectStructureRule`

## References

For the *token list specification* see the [tokenList.md](/languageSpecification/tokenList.md) file.

Related subclauses:
- [objectStructureRule.md](./objectStructureRule.md)
- [outputFieldSpecRule.md](./outputFieldSpecRule.md)
- [fieldRefRule.md](./fieldRefRule.md)
- [generateSectionRule.md](./generateSectionRule.md)

Predefined functions usable in expressions:
- [predefinedFunctions.md](/languageSpecification/notation/predefinedFunctions.md)
