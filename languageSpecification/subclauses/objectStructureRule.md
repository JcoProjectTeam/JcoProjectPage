# Object Structure

The **objectStructureRule** defines the structure of a JSON object, specifying which fields to include and how to value them.

## EBNF Syntax

```ebnf
objectStructureRule ::= '{' outputFieldSpecRule (',' outputFieldSpecRule)* '}'
```

## Syntax Diagram
![Object Structure Syntax](/languageSpecification/assets/rules/objectStructureRule.png "Object Structure Syntax Diagram")

## Semantics

An **object structure** is defined between braces `{ }` and contains a list of field specifications separated by commas.

### Components

- **`LBR`** - Left Brace `{` - Opening brace
- **`outputFieldSpecRule`** - Specification of a single field (can be repeated)
- **`COMMA`** - Comma `,` - Separates field specifications
- **`RBR`** - Right Brace `}` - Closing brace

### Structure

An object can contain:
- **Simple fields**: direct references to existing fields
- **Renamed fields**: field with new name
- **Calculated fields**: fields whose value is calculated from an expression
- **Nested fields**: sub-objects that in turn contain fields

## Used In

The **objectStructureRule** is used in:
- **buildActionRule** - To define structure in BUILD and ADD FIELDS
- **outputFieldSpecRule** - To define nested sub-objects

## Examples

### Example 1: Simple Flat Structure
```jcoql
BUILD {
    .id,
    .name,
    .email
}
```
**Description:** Creates an object with three fields copied from the original document.

---

### Example 2: With Field Renaming
```jcoql
BUILD {
    .productId: .id,
    .productName: .name,
    .unitPrice: .price
}
```
**Description:** Creates an object with renamed fields (id → productId, name → productName, price → unitPrice).

---

### Example 3: With Calculated Expressions
```jcoql
BUILD {
    .orderId: .id,
    .subtotal: .price,
    .tax: (.price * 0.22),
    .total: (.price * 1.22)
}
```
**Description:** Includes calculated fields using arithmetic expressions.

---

### Example 4: Nested Structure
```jcoql
BUILD {
    .customerId: .id,
    .personalInfo: {
        .firstName: .fname,
        .lastName: .lname,
        .age: .age
    },
    .contact: {
        .email: .email,
        .phone: .phone,
        .address: {
            .street: .street,
            .city: .city,
            .zip: .zipCode
        }
    }
}
```
**Description:** Creates a hierarchical structure with multi-level nested objects.

---

### Example 5: With Predefined Functions
```jcoql
BUILD {
    .name,
    .temperature: .temp,
    .tempAbs: ABS(.temp),
    .tempString: TO_STRING(.temp),
    .isHot: (.temp > 30)
}
```
**Description:** Uses predefined functions to transform values.

---

### Example 6: With Fuzzy Set Membership
```jcoql
BUILD {
    .locationName: .name,
    .nearbyScore: #nearParking,
    .qualityScore: #goodRating,
    .combinedScore: (0.6 * #nearParking + 0.4 * #goodRating)
}
```
**Description:** Includes fuzzy set membership degrees in fields.

---

### Example 7: Mixed Complex Structure
```jcoql
BUILD {
    .order: {
        .id: .orderId,
        .date: .orderDate,
        .items: .itemsList,
        .itemCount: COUNT(.itemsList)
    },
    .customer: {
        .name: .customerName,
        .tier: IF(.totalSpent > 1000, "gold", 
                  IF(.totalSpent > 500, "silver", "bronze"))
    },
    .financial: {
        .subtotal: SUM(.itemsList.price),
        .shipping: IF(.subtotal > 50, 0, 5.99),
        .total: (SUM(.itemsList.price) + IF(.subtotal > 50, 0, 5.99))
    },
    .timestamp: .created_at
}
```

---


## Issues

- Define the exact behavior in case of duplicate field names
- Clarify if it is possible to use expressions as dynamic keys
- Document nesting depth limits (if they exist)

## References

For the *token list specification* see the [tokenList.md](/languageSpecification/tokenList.md) file.

Related subclauses:
- [outputFieldSpecRule.md](./outputFieldSpecRule.md)
- [buildActionRule.md](./buildActionRule.md)
- [fieldRefRule.md](./fieldRefRule.md)

Base elements:
- [baseElements.md](/languageSpecification/notation/baseElements.md)
