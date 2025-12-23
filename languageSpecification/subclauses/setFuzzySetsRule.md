# Set Fuzzy Sets Rule (setFuzzySetsRule)

The `setFuzzySetsRule` manages which fuzzy sets from the source collections are kept in the result of a JOIN OF COLLECTIONS operation.

---

## EBNF Notation

```
setFuzzySetsRule ::= SET FUZZY SETS (KEEP (ALL [resolvingRule] | LEFT | RIGHT)
                                    | addFuzzySetRule (COMMA addFuzzySetRule)* [resolvingRule])
```

---

## Syntax Components

- **SET FUZZY SETS**: Keywords to start the fuzzy set management clause
- **KEEP ALL**: Keep all fuzzy sets from both collections
- **KEEP LEFT**: Keep only fuzzy sets from the left collection
- **KEEP RIGHT**: Keep only fuzzy sets from the right collection
- **addFuzzySetRule**: Specify individual fuzzy sets to include
- **resolvingRule**: Define how to resolve conflicts when both collections have same fuzzy set name

---

## Semantics

When joining two collections that contain fuzzy sets, you can:
1. **Keep all** fuzzy sets from both collections
2. **Keep only from one side** (LEFT or RIGHT)
3. **Selectively choose** specific fuzzy sets from each collection
4. **Resolve conflicts** when fuzzy set names overlap

### Conflict Resolution
When both collections have a fuzzy set with the same name, use `resolvingRule` to specify:
- **AND**: Combine using fuzzy AND operator
- **OR**: Combine using fuzzy OR operator
- **FIRST**: Keep the one from the left collection
- **LAST**: Keep the one from the right collection

---


The `setFuzzySetsRule` is used exclusively in:
- **JOIN OF COLLECTIONS** - To manage fuzzy sets in the joined result

---

## Examples

### Example 1: Keep All Fuzzy Sets

```jcoql
JOIN OF COLLECTIONS restaurants AS r, reviews AS rev
    SET FUZZY SETS KEEP ALL
    GENERATE BUILD {
        .restaurant: r,
        .review: rev
    };
```

**Explanation**: Keeps all fuzzy sets from both restaurants and reviews collections.

---

### Example 2: Keep Only Left Fuzzy Sets

```jcoql
JOIN OF COLLECTIONS zones AS z, buildings AS b
    SET FUZZY SETS KEEP LEFT
    GENERATE BUILD {
        .zone: z,
        .building: b
    };
```

**Explanation**: Only keeps fuzzy sets from the zones (left) collection.

---

### Example 3: Keep Only Right Fuzzy Sets

```jcoql
JOIN OF COLLECTIONS areas AS a, poi AS p
    SET FUZZY SETS KEEP RIGHT
    GENERATE BUILD {
        .area: a,
        .poi: p
    };
```

**Explanation**: Only keeps fuzzy sets from the poi (right) collection.

---

### Example 4: Keep All with Conflict Resolution (AND)

```jcoql
JOIN OF COLLECTIONS coll1 AS c1, coll2 AS c2
    SET FUZZY SETS KEEP ALL RESOLVING WITH AND
    GENERATE BUILD {
        .left: c1,
        .right: c2
    };
```

**Explanation**: Keeps all fuzzy sets; when names conflict, combines them using AND operator.

---

### Example 5: Keep All with Conflict Resolution (OR)

```jcoql
JOIN OF COLLECTIONS events AS e1, events AS e2
    SET FUZZY SETS KEEP ALL RESOLVING WITH OR
    GENERATE BUILD {
        .event1: e1,
        .event2: e2
    };
```

**Explanation**: Keeps all fuzzy sets; when names conflict, combines them using OR operator.

---

### Example 6: Keep All with FIRST Priority

```jcoql
JOIN OF COLLECTIONS primary AS p, secondary AS s
    SET FUZZY SETS KEEP ALL RESOLVING WITH FIRST
    GENERATE BUILD {
        .primary: p,
        .secondary: s
    };
```

**Explanation**: In case of conflict, keeps the fuzzy set from the left (primary) collection.

---

### Example 7: Selective Fuzzy Sets from Left

```jcoql
JOIN OF COLLECTIONS restaurants AS r, zones AS z
    SET FUZZY SETS LEFT quality, LEFT priceRange AS price
    GENERATE BUILD {
        .restaurant: r,
        .zone: z
    };
```

**Explanation**: Keeps specific fuzzy sets (`quality` and `priceRange`) from the left collection, renaming `priceRange` to `price`.

---

### Example 8: Selective Fuzzy Sets from Both Sides

```jcoql
JOIN OF COLLECTIONS hotels AS h, attractions AS a
    SET FUZZY SETS 
        LEFT comfort,
        LEFT price,
        RIGHT popularity,
        RIGHT accessibility
    GENERATE BUILD {
        .hotel: h,
        .attraction: a
    };
```

**Explanation**: Selects specific fuzzy sets from both collections.

---

### Example 9: Rename Fuzzy Sets

```jcoql
JOIN OF COLLECTIONS products AS p, sellers AS s
    SET FUZZY SETS
        LEFT quality AS productQuality,
        RIGHT rating AS sellerRating
    GENERATE BUILD {
        .product: p,
        .seller: s
    };
```

**Explanation**: Renames fuzzy sets during the join for clarity.

---

### Example 10: Special Fuzzy Functions

```jcoql
JOIN OF COLLECTIONS parks AS p, events AS e
    SET FUZZY SETS
        HOWINCLUDE(LEFT) AS parkIncludesEvent,
        HOWINTERSECT() AS spatialOverlap
    GENERATE BUILD {
        .park: p,
        .event: e
    };
```

**Explanation**: Creates new fuzzy sets based on spatial relationships.

---


### HOWINCLUDE
Measures the degree to which one geometry includes another.

```jcoql
SET FUZZY SETS HOWINCLUDE(LEFT) AS leftIncludesRight
```

### HOWMEET
Measures the degree to which geometries meet (touch at boundaries).

```jcoql
SET FUZZY SETS HOWMEET(LEFT) AS geometriesMeet
```

### HOWINTERSECT
Measures the degree of spatial intersection.

```jcoql
SET FUZZY SETS HOWINTERSECT() AS spatialIntersection
```

---

## See Also

- [JOIN OF COLLECTIONS](../joinOfCollections.md) - Main JOIN instruction
- [Fuzzy Set Check](../fuzzySubClauses/checkForFuzzySetRule.md) - Checking fuzzy sets
- [Alpha Cut](../fuzzySubClauses/alphaCutRule.md) - Fuzzy set thresholding
- [Keep/Drop Fuzzy Sets](../fuzzySubClauses/keepDropFuzzySetsRule.md) - Managing fuzzy sets in GENERATE

---

## References

For the complete token list specification, see [tokenList.md](../tokenList.md).
