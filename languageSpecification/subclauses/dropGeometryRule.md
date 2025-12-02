# DROP GEOMETRY

The **dropGeometryRule** removes the geometry field (`~geometry`) from resulting documents.

## EBNF Syntax

```ebnf
<span style="color: purple">dropGeometryRule</span> ::= DROP GEOMETRY
```

## Syntax Diagram
![Drop Geometry Syntax](/languageSpecification/assets/rules/dropGeometryRule.png "Drop Geometry Syntax Diagram")

## Semantics

The **DROPPING GEOMETRY** command completely removes the special `~geometry` field from the resulting document. This operation is useful when:

- Geometry is no longer needed after spatial processing
- You want to reduce document size
- Only alphanumeric attributes are being extracted
- You want to avoid confusion with geometries that are no longer valid

## Used In

The **dropGeometryRule** is used **exclusively** in:
- **generateSectionRule** - As part of the GENERATE section

## Examples

### Example 1: Simple Removal
```jcoql
FILTER
CASE WHERE .type = "sensor"
GENERATE
    DROPPING GEOMETRY
    BUILD {
        .sensorId: .id,
        .temperature: .temp,
        .humidity: .humid
    };
```
**Description:** Extracts only alphanumeric data, removing the geographic position.

---

### Example 2: After Spatial Calculations
```jcoql
JOIN parks AS p
CASE WHERE DISTANCE(p, 500)
GENERATE
    BUILD {
        .venueName: .name,
        .nearestPark: p.name,
        .distanceMeters: GEODESIC_DISTANCE(.lat, .lon, p.lat, p.lon)
    }
    DROPPING GEOMETRY;
```
**Description:** Calculates the distance and then removes geometries, keeping only the numeric value.

---

### Example 3: Statistical Aggregation
```jcoql
GROUP PARTITION (.city = "Milano")
BY .district
INTO .places
GENERATE
    BUILD {
        .districtName: .district,
        .placeCount: COUNT(.places),
        .avgRating: AVG(.places.rating),
        .totalArea: SUM(.places.area)
    }
    DROPPING GEOMETRY;
```
**Description:** Produces aggregate statistics without geometry.

---

### Example 4: Coordinate Extraction
```jcoql
FILTER
GENERATE
    BUILD {
        .name,
        .latitude: GEOMETRY_FIELD().coordinates[1],
        .longitude: GEOMETRY_FIELD().coordinates[0]
    }
    DROPPING GEOMETRY;
```
**Description:** Extracts coordinates as separate fields, then removes the GeoJSON geometry.

---

### Example 5: With Fuzzy Sets
```jcoql
FILTER
CASE WHERE .active = TRUE
GENERATE
    CHECK FOR goodLocation
    BUILD {
        .placeName: .name,
        .locationScore: #goodLocation
    }
    DROPPING GEOMETRY;
```
**Description:** Keeps only the fuzzy membership degree, removing the original geometry.

---

### Example 6: Complex JOIN
```jcoql
JOIN restaurants AS r
CASE WHERE DISTANCE(r, 1000)
GENERATE
    BUILD {
        .hotelName: .name,
        .restaurantName: r.name,
        .cuisine: r.cuisine,
        .walkingDistance: GEODESIC_DISTANCE(.lat, .lon, r.lat, r.lon),
        .walkingTime: (GEODESIC_DISTANCE(.lat, .lon, r.lat, r.lon) / 80)  -- avg walking speed
    }
    DROPPING GEOMETRY
    KEEP FUZZY SETS [nearbyFood];
```

---

## When to Use DROPPING GEOMETRY


## Implementation Notes

- **Irreversibility**: Once removed, geometry cannot be recovered in the same document
- **Performance**: O(1) operation, very efficient
- **Pipeline effect**: Documents without geometry cannot be used in subsequent spatial operations
- **GeoJSON compatibility**: Resulting documents are no longer valid GeoJSON (missing mandatory `geometry`)

---

## Issues

- Clarify if DROPPING GEOMETRY is necessary or if BUILD without ~geometry is sufficient
- Document behavior when ~geometry does not exist (noop vs error?)
- Specify if it affects other special fields (~fuzzysets, ~metadata)

## References

For the *token list specification* see the [tokenList.md](/languageSpecification/tokenList.md) file.

Parent clause:
- [generateSectionRule.md](./generateSectionRule.md)

Related subclauses:
- [geometricOptionRule.md](./geometricOptionRule.md)
- [buildActionRule.md](./buildActionRule.md)

Special fields:
- [GeoJSON Geometry Field](../assets/geojson-spec.md)
