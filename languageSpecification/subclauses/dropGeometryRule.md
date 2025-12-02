# DROP GEOMETRY

The **dropGeometryRule** removes the geometry field (`~geometry`) from resulting documents.

## EBNF Syntax

```ebnf
dropGeometryRule ::= DROPPING GEOMETRY
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

### ✅ Use when:
- **Data export**: Exporting to non-GIS systems
- **Reporting**: Generating textual/tabular reports
- **Aggregations**: Statistical results without spatial component
- **Performance**: Reducing document size for subsequent processing
- **Format conversion**: From GeoJSON to standard JSON

### ❌ Don't use when:
- **Map visualization**: Necessary for cartographic rendering
- **Subsequent spatial analysis**: Other operations will require geometry
- **Maintaining integrity**: Position is an essential part of the data
- **GeoJSON export**: The format requires the geometry field

---

## Interaction with Other Clauses

### With KEEPING GEOMETRY (❌ Conflict)
```jcoql
❌ Not valid:
GENERATE
    KEEPING GEOMETRY
    DROPPING GEOMETRY;    -- Contradictory!
```

### With SETTING GEOMETRY (❌ Useless)
```jcoql
❌ Makes no sense:
GENERATE
    SETTING GEOMETRY POINT (.lat, .lon)
    DROPPING GEOMETRY;    -- Create and then delete?

✅ Better:
GENERATE
    BUILD {
        .name,
        .lat,
        .lon
    };
    -- Without geometry from the start
```

### With BUILD (✅ Common)
```jcoql
✅ Typical pattern:
GENERATE
    BUILD {
        .id,
        .name,
        .attributes
    }
    DROPPING GEOMETRY;
```

### With CHECK FOR (✅ Compatible)
```jcoql
✅ Valido:
GENERATE
    CHECK FOR spatialFuzzySet
    BUILD {
        .id,
        .score: #spatialFuzzySet
    }
    DROPPING GEOMETRY;
```

---

## Common Patterns

### Pattern 1: Geometry → Separate Coordinates
```jcoql
-- Before: document with ~geometry
-- After: document with .lat and .lon

GENERATE
    BUILD {
        .id,
        .name,
        .lat: GEOMETRY_FIELD().coordinates[1],
        .lon: GEOMETRY_FIELD().coordinates[0]
    }
    DROPPING GEOMETRY;
```

### Pattern 2: Spatial Analysis → Non-Spatial Result
```jcoql
-- Uses geometry for calculations, then removes it

JOIN stations AS s
CASE WHERE DISTANCE(s, 5000)
GENERATE
    BUILD {
        .sensorId: .id,
        .nearestStation: s.name,
        .distance: GEODESIC_DISTANCE(.lat, .lon, s.lat, s.lon)
    }
    DROPPING GEOMETRY;
```

### Pattern 3: Geographic Aggregation → Statistics
```jcoql
GROUP BY .region
INTO .items
GENERATE
    BUILD {
        .regionName: .region,
        .itemCount: COUNT(.items),
        .avgValue: AVG(.items.value)
    }
    DROPPING GEOMETRY;
```

### Pattern 4: Fuzzy Spatial → Membership Only
```jcoql
FILTER
CASE WHERE .category = "poi"
GENERATE
    CHECK FOR accessible
    CHECK FOR popular
    BUILD {
        .poiName: .name,
        .accessibility: #accessible,
        .popularity: #popular,
        .overallScore: (0.5 * #accessible + 0.5 * #popular)
    }
    DROPPING GEOMETRY;
```

---

## Detailed Behavior

### Before DROPPING GEOMETRY
```json
{
  "id": "12345",
  "name": "Hotel Milano",
  "rating": 4.5,
  "~geometry": {
    "type": "Point",
    "coordinates": [9.1900, 45.4642]
  }
}
```

### After DROPPING GEOMETRY
```json
{
  "id": "12345",
  "name": "Hotel Milano",
  "rating": 4.5
}
```

---

## Document Size

### Storage Impact

A typical `~geometry` Point field occupies approximately:
- **Point**: ~50-70 bytes
- **LineString**: 50-100 bytes per point
- **Polygon**: 50-100 bytes per point
- **Complex MultiPolygon**: Can reach KB or MB

**Example:**
```json
// With geometry: ~150 bytes
{
  "id": "123",
  "name": "Place",
  "~geometry": {"type": "Point", "coordinates": [9.19, 45.46]}
}

// Without geometry: ~40 bytes
{
  "id": "123",
  "name": "Place"
}
```

**Savings:** ~70% in this example

---

## Alternatives to DROPPING GEOMETRY

### Alternative 1: Don't include ~geometry in BUILD
```jcoql
-- Equivalent to DROPPING GEOMETRY
BUILD {
    .id,
    .name
    -- Non include ~geometry
}
```

### Alternative 2: REMOVE FIELDS
```jcoql
-- Explicit
REMOVE FIELDS [~geometry]
```

### Alternative 3: Selective KEEP
```jcoql
-- List only desired fields
BUILD {
    .campo1,
    .campo2,
    .campo3
}
-- ~geometry automatically excluded
```

---

## Difference between BUILD and DROPPING GEOMETRY

| Approach | Result | Typical Use |
|-----------|-----------|------------|
| **BUILD** without ~geometry | Geometry not included | Building new structure |
| **DROPPING GEOMETRY** | Geometry explicitly removed | Intent clarity |
| **REMOVE FIELDS [~geometry]** | Geometry removed | Part of multiple removals |

```jcoql
-- Three equivalent ways:

-- 1. BUILD (implicito)
BUILD { .id, .name }

-- 2. DROPPING (esplicito)
DROPPING GEOMETRY
BUILD { .id, .name }

-- 3. REMOVE (esplicito)
BUILD { .id, .name }
REMOVE FIELDS [~geometry]
```

---

## Implementation Notes

- **Irreversibility**: Once removed, geometry cannot be recovered in the same document
- **Performance**: O(1) operation, very efficient
- **Pipeline effect**: Documents without geometry cannot be used in subsequent spatial operations
- **GeoJSON compatibility**: Resulting documents are no longer valid GeoJSON (missing mandatory `geometry`)

---

## Warnings and Cautions

### ⚠️ Warning 1: Data Loss
```jcoql
-- Attention: geometry permanently lost
FILTER
GENERATE
    DROPPING GEOMETRY
    BUILD {...};

SAVE AS cleanedData;

-- cleanedData no longer has geographic information!
```

### ⚠️ Warning 2: Spatial Pipelines
```jcoql
-- This will fail:
FILTER
GENERATE
    DROPPING GEOMETRY
    BUILD {...};

JOIN otherCollection AS o
CASE WHERE DISTANCE(o, 500);  -- ❌ Error! No geometry
```

### ✅ Solution: Drop at the End
```jcoql
JOIN otherCollection AS o
CASE WHERE DISTANCE(o, 500)
GENERATE
    BUILD {...}
    DROPPING GEOMETRY;  -- ✅ Drop only at the end
```

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
