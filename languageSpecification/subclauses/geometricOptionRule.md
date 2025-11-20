# Geometric Option

The **geometricOptionRule** allows managing the geometry of GeoJSON documents, allowing to keep it, modify it, or create it from scratch during transformations.

## EBNF Syntax

```ebnf
geometricOptionRule ::= KEEPING GEOMETRY
                      | SETTING GEOMETRY (POINT LP fieldRefRule COMMA fieldRefRule RP
                                        | AGGREGATE LP fieldRefRule RP
                                        | fieldRefRule
                                        | TO_POLYLINE LP fieldRefRule RP)
```

## Syntax Diagram
![Geometric Option Syntax](/languageSpecification/assets/rules/geometricOptionRule.png "Geometric Option Syntax Diagram")

## Semantics

The **geometricOptionRule** offers several ways to manage the special `~geometry` field in GeoJSON documents:

### 1. KEEPING GEOMETRY
Keeps the existing geometry in the resulting document without modifications.

```jcoql
KEEPING GEOMETRY
```

### 2. SETTING GEOMETRY POINT
Creates a new Point-type geometry using the specified coordinates.

```jcoql
SETTING GEOMETRY POINT (.latitude, .longitude)
```

### 3. SETTING GEOMETRY AGGREGATE
Aggregates geometries from an array of documents into a single geometry.

```jcoql
SETTING GEOMETRY AGGREGATE (.groupedDocuments)
```

### 4. SETTING GEOMETRY (from field)
Sets the geometry using an existing field that contains a valid geometry.

```jcoql
SETTING GEOMETRY .geometryField
```

### 5. SETTING GEOMETRY TO_POLYLINE
Converts an array of points into a polyline (LineString).

```jcoql
SETTING GEOMETRY TO_POLYLINE (.waypoints)
```

## Used In

The **geometricOptionRule** is used **exclusively** in:
- **generateSectionRule** - As part of the GENERATE section

## Examples

### Example 1: Keep Existing Geometry
```jcoql
FILTER
CASE WHERE .category = "restaurant"
GENERATE
    KEEPING GEOMETRY
    BUILD {
        .name,
        .rating,
        .cuisine
    };
```
**Description:** The restaurant's original geometry is preserved in the resulting document.

---

### Example 2: Create Point from Coordinates
```jcoql
FILTER
GENERATE
    SETTING GEOMETRY POINT (.lat, .lon)
    BUILD {
        .stationName: .name,
        .temperature: .temp
    };
```
**Description:** Creates a GeoJSON Point geometry from lat/lon coordinates.

---

### Example 3: Coordinates from Nested Fields
```jcoql
GENERATE
    SETTING GEOMETRY POINT (.location.coordinates.lat, .location.coordinates.lon)
    BUILD {
        .placeName: .name
    };
```

---

### Example 4: Aggregate Geometries in GROUP
```jcoql
GROUP PARTITION (.district = "Centro")
BY .neighborhood
INTO .places
GENERATE
    SETTING GEOMETRY AGGREGATE (.places)
    BUILD {
        .neighborhoodName: .neighborhood,
        .placeCount: COUNT(.places),
        .avgRating: AVG(.places.rating)
    };
```
**Description:** Combines the geometries of all places in a neighborhood into a single aggregated geometry (typically a GeometryCollection or Polygon).

---

### Example 5: Copy Geometry from a Field
```jcoql
FILTER
GENERATE
    SETTING GEOMETRY .geoShape
    BUILD {
        .id,
        .name,
        .area: GEOMETRY_AREA("KM")
    };
```
**Description:** Uses an existing field that contains a valid geometry.

---

### Example 6: Create Polyline from Array of Points
```jcoql
GROUP BY .routeId
INTO .waypoints
GENERATE
    SETTING GEOMETRY TO_POLYLINE (.waypoints)
    BUILD {
        .routeName: .routeId,
        .length: GEOMETRY_LENGTH("KM"),
        .pointCount: COUNT(.waypoints)
    };
```
**Description:** Converts a sequence of waypoints into a GeoJSON LineString.

---

### Example 7: Combine with Fuzzy Operations
```jcoql
FILTER
CASE WHERE DISTANCE(parking, 500)
GENERATE
    KEEPING GEOMETRY
    CHECK FOR nearParking
    BUILD {
        .venueName: .name,
        .parkingProximity: #nearParking,
        .coordinates: {
            .lat: GEOMETRY_FIELD().coordinates[1],
            .lon: GEOMETRY_FIELD().coordinates[0]
        }
    };
```

---

### Esempio 8: JOIN con Geometria Aggregata
```jcoql
JOIN parks AS p
CASE WHERE INTERSECT(p)
GENERATE
    SETTING GEOMETRY AGGREGATE([~geometry, p.~geometry])
    BUILD {
        .buildingName: .name,
        .parkName: p.name,
        .combinedArea: GEOMETRY_AREA("KM")
    };
```

---

## Supported Geometry Types

### Input (for SETTING GEOMETRY from field)
- **Point** - Single point
- **LineString** - Broken line
- **Polygon** - Polygon
- **MultiPoint** - Set of points
- **MultiLineString** - Set of lines
- **MultiPolygon** - Set of polygons
- **GeometryCollection** - Mixed collection

### AGGREGATE Output
Depends on the aggregated geometries:
- Multiple points → **MultiPoint**
- Multiple lines → **MultiLineString**
- Multiple polygons → **MultiPolygon**
- Mixed types → **GeometryCollection**

### TO_POLYLINE Output
Always **LineString**

---

## Related Geometric Functions

After setting the geometry, predefined functions can be used:

```jcoql
GEOMETRY_FIELD()                    -- Accesses the geometry
GEOMETRY_LENGTH("KM")               -- Length in km
GEOMETRY_AREA("KM")                 -- Area in km²
GEODESIC_DISTANCE(lat1, lon1, lat2, lon2)  -- Geodesic distance
```

### Complete Example with Functions
```jcoql
GENERATE
    SETTING GEOMETRY POINT (.latitude, .longitude)
    BUILD {
        .id,
        .location: GEOMETRY_FIELD(),
        .distanceFromCenter: GEODESIC_DISTANCE(
            .latitude, .longitude,
            45.4642, 9.1900
        )
    };
```

---

## Interaction with Other Special Fields

### With Fuzzy Sets
```jcoql
GENERATE
    KEEPING GEOMETRY
    CHECK FOR closeToMetro
    BUILD {
        .placeName: .name,
        .proximity: #closeToMetro
    }
    KEEP FUZZY SETS [closeToMetro];
```

### With Metadata
```jcoql
GENERATE
    SETTING GEOMETRY POINT (.lat, .lon)
    BUILD {
        .data: .properties,
        .meta: ~metadata,
        .coords: GEOMETRY_FIELD()
    };
```

---

## Implementation Notes

- **GeoJSON order**: `POINT (lon, lat)` - longitude first, latitude second
- **Performance**: `AGGREGATE` on many geometries can be expensive
- **Precision**: Coordinates with 6 decimals (~10cm precision)
- **CRS**: Default reference system is WGS84 (EPSG:4326)

## Issues

- Document the behavior of AGGREGATE with NULL geometries
- Clarify which algorithm AGGREGATE uses to combine different geometries
- Specify size limits for polylines (max points)
- Define how invalid coordinate errors are handled

## References

For the *token list specification* see the [tokenList.md](/languageSpecification/tokenList.md) file.

Parent clause:
- [generateSectionRule.md](./generateSectionRule.md)

Related subclauses:
- [fieldRefRule.md](./fieldRefRule.md)
- [dropGeometryRule.md](./dropGeometryRule.md)

Predefined geometric functions:
- [GEOMETRY_FIELD](/languageSpecification/notation/predefinedFunctions.md#geometry_field)
- [GEOMETRY_LENGTH](/languageSpecification/notation/predefinedFunctions.md#geometry_length)
- [GEOMETRY_AREA](/languageSpecification/notation/predefinedFunctions.md#geometry_area)
- [GEODESIC_DISTANCE](/languageSpecification/notation/predefinedFunctions.md#geodesic_distance)
