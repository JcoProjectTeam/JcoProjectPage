# Output Field Specification

The **outputFieldSpecRule** defines how to specify a single field in the output structure of a document, allowing to copy, rename, or calculate the value of a field.

## EBNF Syntax

```ebnf
outputFieldSpecRule ::= fieldRefRule [ ':' (objectStructureRule | factorRule)]
```

## Syntax Diagram
![Output Field Spec Syntax](/languageSpecification/assets/rules/outputFieldSpecRule.png "Output Field Spec Syntax Diagram")

## Semantics

A **field specification** can take three forms:

### 1. Simple Field (Copy)
```
.nomeCampo
```
Copies the field with the same name from the source document.

### 2. Field with Nested Object
```
.nomeCampo: { .campo1, .campo2, ... }
```
Creates a sub-object assigning it to the specified field.

### 3. Field with Expression (Computed)
```
.nomeCampo: espressione
```
Calculates the field value using an expression.

## Components

- **fieldRefRule** - Field reference (e.g., `.name`, `.address.city`)
- **COLON** - Colon `:` - Separates the field name from its definition
- **objectStructureRule** - A sub-object structure (recursive)
- **factorRule** - An expression that calculates the field value

## Used In

The **outputFieldSpecRule** is used in:
- **objectStructureRule** - As an element of an object's field list

## Examples

### Example 1: Simple Fields
```jcoql
BUILD {
    .id,
    .name,
    .email
}
```
**Description:** Three fields copied directly from the source document.

---

### Example 2: Field Rename
```jcoql
BUILD {
    .customerId: .id,
    .fullName: .name
}
```
**Description:** 
- `.customerId` takes the value of `.id`
- `.fullName` takes the value of `.name`

---

### Example 3: Calculated Field with Arithmetic Expression
```jcoql
BUILD {
    .price,
    .quantity,
    .total: (.price * .quantity)
}
```
**Description:** `.total` is calculated by multiplying price by quantity.

---

### Example 4: Field with Sub-Object
```jcoql
BUILD {
    .orderId: .id,
    .customer: {
        .name: .customerName,
        .email: .customerEmail
    }
}
```
**Description:** `.customer` is a nested object containing name and email.

---

### Example 5: Expressions with Predefined Functions
```jcoql
BUILD {
    .rawValue: .temperature,
    .absoluteValue: ABS(.temperature),
    .stringValue: TO_STRING(.temperature),
    .roundedValue: TO_INT(.temperature)
}
```
**Description:** Uses predefined conversion functions.

---

### Example 6: Conditional Expressions
```jcoql
BUILD {
    .score,
    .grade: IF(.score >= 90, "A",
               IF(.score >= 80, "B",
                  IF(.score >= 70, "C",
                     IF(.score >= 60, "D", "F")))),
    .passed: (.score >= 60)
}
```
**Description:** Uses `IF` to calculate the letter grade and passed/failed status.

---

### Example 7: With Fuzzy Set Membership
```jcoql
BUILD {
    .placeName: .name,
    .proximityDegree: #nearbyParking,
    .qualityDegree: #goodService,
    .overallScore: (0.6 * #nearbyParking + 0.4 * #goodService)
}
```
**Description:** Includes membership degrees and calculates a weighted score.

---

### Example 8: Complex Nested Structures
```jcoql
BUILD {
    .id,
    .profile: {
        .personal: {
            .name: .fullName,
            .age: .age,
            .birthYear: (2025 - .age)
        },
        .contact: {
            .email: .email,
            .phone: .phoneNumber,
            .hasPhone: (.phoneNumber != NULL)
        }
    },
    .metadata: {
        .created: .createdAt,
        .modified: .updatedAt,
        .version: 1
    }
}
```
**Description:** Creates a multi-level hierarchy with simple, calculated, and conditional fields.

---

### Example 9: With Array Functions
```jcoql
BUILD {
    .productName: .name,
    .prices: .priceHistory,
    .minPrice: MIN_ARRAY(.priceHistory),
    .maxPrice: MAX_ARRAY(.priceHistory),
    .avgPrice: AVG_ARRAY(.priceHistory),
    .priceCount: COUNT(.priceHistory)
}
```
**Description:** Applies aggregation functions on arrays.

---

### Example 10: References to Nested Fields
```jcoql
BUILD {
    .customerName: .customer.name,
    .customerCity: .customer.address.city,
    .customerZip: .customer.address.zipCode,
    .shippingSameAsBilling: (.shipping.address.city = .customer.address.city)
}
```
**Description:** Accesses deeply nested fields in the source document.

---



### Error 1: Colon Syntax
```jcoql
❌ .newName .oldName        -- Missing colon
✅ .newName: .oldName       -- Correct
```

### Error 2: Non-Existent Field
```jcoql
❌ .result: .nonExistentField   -- Will result in null
✅ .result: IF_ERROR(.field, 0) -- Handles the error
```

### Error 3: Incompatible Type
```jcoql
❌ .sum: (.textField + .number)  -- May fail
✅ .sum: (TO_FLOAT(.textField) + .number)  -- Explicit conversion
```

---

## Issues

- Clarify the behavior when an expression fails (error vs null)
- Document operator precedences in complex expressions
- Specify complexity limits for nested expressions

## References

For the *token list specification* see the [tokenList.md](/languageSpecification/tokenList.md) file.

Related subclauses:
- [fieldRefRule.md](./fieldRefRule.md)
- [objectStructureRule.md](./objectStructureRule.md)
- [factorRule.md](../conditionExpressionModel/factorRule.md)

Predefined functions:
- [predefinedFunctions.md](/languageSpecification/notation/predefinedFunctions.md)

Base elements:
- [baseElements.md](/languageSpecification/notation/baseElements.md)
