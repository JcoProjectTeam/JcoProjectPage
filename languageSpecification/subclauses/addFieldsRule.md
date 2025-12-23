# Add Fields Rule (addFieldsRule)

The `addFieldsRule` allows adding calculated or derived fields during a JOIN OF COLLECTIONS operation.

---

## EBNF Notation

```
addFieldsRule ::= ADD_ST FIELDS LBR fieldRefRule COLON insertFieldRule 
                  (COMMA fieldRefRule COLON insertFieldRule)* RBR
```

---

## Syntax Components

- **ADD_ST FIELDS**: Keywords to start the add fields clause
- **LBR / RBR**: Left and right braces `{ }`
- **fieldRefRule**: The name of the new field to add (e.g., `.distance`, `.orientation`)
- **COLON**: Separator between field name and value
- **insertFieldRule**: The value or calculation for the field (spatial function or expression)

---

## Semantics

The `ADD FIELDS` clause in JOIN operations:
1. **Creates new fields** in the joined document before other transformations
2. **Calculates values** from spatial functions or expressions
3. **Makes values available** for use in subsequent GENERATE clauses

### Field Values
Fields can be calculated using:
- **Spatial functions**: `DISTANCE`, `ORIENTATION`, `INCLUDED`, `MEET`, `INTERSECT`
- **Expressions**: Any valid restricted expression (field references, calculations, functions)

---


The `addFieldsRule` is used exclusively in:
- **JOIN OF COLLECTIONS** - To add calculated fields to joined documents

---

## Examples

### Example 1: Add Distance Field

```jcoql
JOIN OF COLLECTIONS parks AS p, restaurants AS r
    ADD FIELDS {
        .distanceToRestaurant: DISTANCE(p)
    }
    GENERATE BUILD {
        .parkName: p.name,
        .restaurantName: r.name,
        .distance: .distanceToRestaurant
    };
```

**Explanation**: Adds a `.distanceToRestaurant` field containing the distance between park and restaurant geometries.

---

### Example 2: Multiple Spatial Fields

```jcoql
JOIN OF COLLECTIONS zones AS z, buildings AS b
    ADD FIELDS {
        .dist: DISTANCE(z),
        .intersects: INTERSECT,
        .meets: MEET
    }
    GENERATE BUILD {
        .zone: z.name,
        .building: b.name,
        .distance: .dist,
        .overlaps: .intersects,
        .adjacent: .meets
    };
```

**Explanation**: Adds three spatial relationship fields for analysis.

---

### Example 3: Expression-Based Fields

```jcoql
JOIN OF COLLECTIONS orders AS o, products AS p
    ADD FIELDS {
        .totalPrice: o.quantity * p.price,
        .discountedPrice: o.quantity * p.price * 0.9
    }
    GENERATE BUILD {
        .order: o.id,
        .product: p.name,
        .total: .totalPrice,
        .withDiscount: .discountedPrice
    };
```

**Explanation**: Adds calculated price fields using expressions.

---

### Example 4: Orientation Information

```jcoql
JOIN OF COLLECTIONS roads AS r1, roads AS r2
    ADD FIELDS {
        .leftOriented: ORIENTATION(LEFT),
        .roadDistance: DISTANCE(r1)
    }
    WHERE .leftOriented = TRUE
    GENERATE BUILD {
        .road1: r1.name,
        .road2: r2.name,
        .distance: .roadDistance
    };
```

**Explanation**: Adds orientation check and uses it in WHERE condition.

---

### Example 5: Inclusion Check

```jcoql
JOIN OF COLLECTIONS districts AS d, shops AS s
    ADD FIELDS {
        .shopIncluded: INCLUDED(RIGHT),
        .dist: DISTANCE(d)
    }
    WHERE .shopIncluded = TRUE
    GENERATE BUILD {
        .district: d.name,
        .shop: s.name,
        .distanceFromCenter: .dist
    };
```

**Explanation**: Checks if shop is within district and adds distance.

---

### Example 6: Field References from Both Collections

```jcoql
JOIN OF COLLECTIONS customers AS c, orders AS o
    ADD FIELDS {
        .customerAge: c.age,
        .orderYear: TO_INT(SUBSTRING(o.date, 0, 4)),
        .yearDiff: TO_INT(SUBSTRING(o.date, 0, 4)) - c.birthYear
    }
    GENERATE BUILD {
        .customer: c.name,
        .order: o.id,
        .ageAtOrder: .yearDiff
    };
```

**Explanation**: Adds fields combining data from both left and right collections.

---

### Example 7: Conditional Field Values

```jcoql
JOIN OF COLLECTIONS stations AS s, hotels AS h
    ADD FIELDS {
        .dist: DISTANCE(s),
        .category: IF((.dist < 500), 'near', 'far')
    }
    GENERATE BUILD {
        .hotel: h.name,
        .station: s.name,
        .distance: .dist,
        .proximity: .category
    };
```

**Explanation**: Uses conditional logic to categorize distance.

---

### Example 8: Multiple Calculations

```jcoql
JOIN OF COLLECTIONS warehouses AS w, deliveries AS d
    ADD FIELDS {
        .baseDistance: DISTANCE(w),
        .travelTime: DISTANCE(w) / 50,  // km/h average speed
        .fuel: DISTANCE(w) * 0.08,      // liters per km
        .cost: DISTANCE(w) * 0.08 * 1.5 // fuel cost
    }
    GENERATE BUILD {
        .warehouse: w.name,
        .delivery: d.address,
        .distance: .baseDistance,
        .estimatedTime: .travelTime,
        .fuelNeeded: .fuel,
        .estimatedCost: .cost
    };
```

**Explanation**: Chains multiple calculations based on distance.

---



Use clear, descriptive names with dot notation:

```jcoql
ADD FIELDS {
    .distanceInMeters: DISTANCE(left),
    .isNearby: IF((DISTANCE(left) < 1000), TRUE, FALSE),
    .spatialRelation: INTERSECT,
    .calculatedPrice: left.quantity * right.price
}
```

---

## See Also

- [JOIN OF COLLECTIONS](../joinOfCollections.md) - Main JOIN instruction
- [spatialFunctionRule](./spatialFunctionRule.md) - Spatial functions reference
- [insertFieldRule](./insertFieldRule.md) - Field insertion specification
- [fieldRefRule](./fieldRefRule.md) - Field reference syntax

---

## References

For the complete token list specification, see [tokenList.md](../tokenList.md).
