# Spatial Function Rule (spatialFunctionRule)

The `spatialFunctionRule` defines spatial operations and geometric relationships used in JOIN operations.

---

## EBNF Notation

```
spatialFunctionRule ::= DISTANCE LP ID RP [comparatorRule numericRule]
                      | ORIENTATION LP (LEFT | RIGHT) [COMMA ID COLON numericRule] RP
                      | INCLUDED LP (LEFT | RIGHT) RP
                      | MEET
                      | INTERSECT
```

---

## Syntax Components

- **DISTANCE(ID)**: Calculates the distance between geometries
- **ORIENTATION(LEFT|RIGHT)**: Checks orientation relationship
- **INCLUDED(LEFT|RIGHT)**: Checks if one geometry is included in another
- **MEET**: Checks if geometries meet (touch at boundaries)
- **INTERSECT**: Checks if geometries intersect

---

## Semantics

Spatial functions are used in JOIN OF COLLECTIONS to:
1. **Filter** join results based on geometric relationships (in `ON GEOMETRY` clause)
2. **Add fields** containing spatial calculations (in `ADD FIELDS` clause)

### Available Spatial Functions

#### 1. DISTANCE
Calculates the geodesic distance between the geometries of the two documents.

- **Returns**: Distance value (in meters by default)
- **Optional Comparison**: Can include a comparator and threshold value
- **Usage**: `DISTANCE(aliasName)` or `DISTANCE(aliasName) < 1000`

#### 2. ORIENTATION
Checks the orientation relationship between geometries.

- **LEFT**: Check if left geometry is positioned left of right geometry
- **RIGHT**: Check if right geometry is positioned right of left geometry
- **Optional Tolerance**: Can specify angle tolerance with `ID:numeric`
- **Usage**: `ORIENTATION(LEFT)` or `ORIENTATION(RIGHT, tolerance:45)`

#### 3. INCLUDED
Checks if one geometry is spatially included within another.

- **LEFT**: Check if left geometry is included in right geometry
- **RIGHT**: Check if right geometry is included in left geometry
- **Usage**: `INCLUDED(LEFT)` or `INCLUDED(RIGHT)`

#### 4. MEET
Checks if the geometries meet (touch at boundaries but don't overlap).

- **Returns**: Boolean (true if geometries meet)
- **Usage**: `MEET`

#### 5. INTERSECT
Checks if the geometries intersect (have any spatial overlap).

- **Returns**: Boolean (true if geometries intersect)
- **Usage**: `INTERSECT`

---



The `spatialFunctionRule` is used in:
- **JOIN OF COLLECTIONS** - `ON GEOMETRY` clause to filter by spatial relationships
- **JOIN OF COLLECTIONS** - `ADD FIELDS` clause via `insertFieldRule` to add spatial data

---

## Examples

### Example 1: Filter by Distance

```jcoql
JOIN OF COLLECTIONS parks AS left, restaurants AS right
    ON GEOMETRY DISTANCE(left) < 500
    GENERATE BUILD {.park: left, .restaurant: right};
```

**Explanation**: Only join parks and restaurants that are within 500 meters of each other.

---

### Example 2: Filter by Intersection

```jcoql
JOIN OF COLLECTIONS zones AS z, buildings AS b
    ON GEOMETRY INTERSECT
    GENERATE BUILD {.zone: z, .building: b};
```

**Explanation**: Only join zones and buildings that spatially intersect.

---

### Example 3: Filter by Inclusion

```jcoql
JOIN OF COLLECTIONS districts AS d, shops AS s
    ON GEOMETRY INCLUDED(RIGHT)
    GENERATE BUILD {.district: d, .shop: s};
```

**Explanation**: Only join when the shop (right) is included within the district (left).

---

### Example 4: Add Distance as Field

```jcoql
JOIN OF COLLECTIONS stations AS sta, hotels AS hot
    ADD FIELDS {
        .distanceToStation: DISTANCE(sta)
    }
    GENERATE BUILD {
        .hotel: hot,
        .nearestStation: sta,
        .distance: .distanceToStation
    };
```

**Explanation**: Add the calculated distance as a field in the result.

---

### Example 5: Orientation Check

```jcoql
JOIN OF COLLECTIONS roads AS r1, roads AS r2
    ON GEOMETRY ORIENTATION(LEFT)
    GENERATE BUILD {.road1: r1, .road2: r2};
```

**Explanation**: Join roads where r1 is oriented to the left of r2.

---

### Example 6: Meet Condition

```jcoql
JOIN OF COLLECTIONS parcels AS p1, parcels AS p2
    ON GEOMETRY MEET
    GENERATE BUILD {.parcel1: p1, .parcel2: p2};
```

**Explanation**: Join adjacent parcels that share a boundary.

---

### Example 7: Multiple Spatial Conditions

```jcoql
JOIN OF COLLECTIONS neighborhoods AS n, parks AS p
    ON GEOMETRY INTERSECT
    ON GEOMETRY DISTANCE(n) < 1000
    ADD FIELDS {
        .parkDistance: DISTANCE(n),
        .isAdjacent: MEET
    }
    GENERATE BUILD {
        .neighborhood: n,
        .park: p,
        .distance: .parkDistance,
        .adjacent: .isAdjacent
    };
```

**Explanation**: Multiple spatial filters and calculations in one join.

---

### Example 8: Distance with Comparison

```jcoql
JOIN OF COLLECTIONS hospitals AS h, schools AS s
    ON GEOMETRY DISTANCE(h) <= 2000
    GENERATE BUILD {
        .hospital: h.name,
        .school: s.name,
        .within2km: TRUE
    };
```

**Explanation**: Filter by distance threshold using comparison operator.

---


The default distance unit is **meters**. For other units, use conversion:

```jcoql
// Kilometers
ON GEOMETRY DISTANCE(left) < 5000  // 5 km in meters

// Miles (approximate)
ON GEOMETRY DISTANCE(left) < 1609  // 1 mile in meters
```

---

## See Also

- [JOIN OF COLLECTIONS](../joinOfCollections.md) - Main JOIN instruction
- [addFieldsRule](./addFieldsRule.md) - Adding calculated fields
- [insertFieldRule](./insertFieldRule.md) - Field insertion in JOIN
- [Geometric Options](./geometricOptionRule.md) - Geometry handling

---

## References

For the complete token list specification, see [tokenList.md](../tokenList.md).
