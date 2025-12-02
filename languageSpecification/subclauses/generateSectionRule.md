# GENERATE Section

The **GENERATE section** is a fundamental subclause used in multiple JCoQL+ instructions to transform and generate new document structures. It allows you to specify how resulting documents should be built, which fuzzy sets to verify, how to manage geometry, and other transformation operations.

## EBNF Syntax

```ebnf
<span style="color: purple">generateSectionRule</span> ::= GENERATE 
                          [<span style="color: purple">geometricOptionRule</span>]
                          [<span style="color: purple">checkForFuzzySetRule</span>]
                          [<span style="color: purple">alphaCutRule</span>]
                          (<span style="color: purple">buildActionRule</span>)*
                          [<span style="color: purple">keepDropFuzzySetsRule</span>]
                          [<span style="color: purple">dropGeometryRule</span>]
```

## Diagramma di Sintassi
![GENERATE Section Syntax](/languageSpecification/assets/rules/generateSectionRule.png "GENERATE Section Syntax Diagram")

## Semantics

The **GENERATE section** is composed of a series of **optional** subclauses, of which **at least one must be specified**. Each subclause has a specific purpose:

### GENERATE Section Subclauses

1. **geometricOptionRule** - Manages geometries in resulting documents
   - `KEEPING GEOMETRY` - Keeps existing geometry
   - `SETTING GEOMETRY POINT` - Sets a new point geometry
   - `SETTING GEOMETRY AGGREGATE` - Aggregates geometries
   - `SETTING GEOMETRY TO_POLYLINE` - Converts to polyline

2. **checkForFuzzySetRule** - Verifies fuzzy set membership
   - `CHECK FOR fuzzySetName` - Checks if a document belongs to a fuzzy set
   - Allows specifying `IF_FAILS` conditions to handle failures

3. **alphaCutRule** - Applies alpha-cut to fuzzy sets
   - `ALPHACUT alpha` - Filters documents based on membership level
   - Used to select only documents with membership above the alpha threshold

4. **buildActionRule** - Builds document structure (can be repeated)
   - `BUILD {...}` - Builds a new structure from scratch
   - `ADD FIELDS {...}` - Adds new fields to existing structure
   - `REMOVE FIELDS [...]` - Removes specific fields

5. **keepDropFuzzySetsRule** - Manages which fuzzy sets to keep or drop
   - `KEEP FUZZY SETS [...]` - Keeps only specified fuzzy sets
   - `DROP FUZZY SETS [...]` - Drops specified fuzzy sets

6. **dropGeometryRule** - Removes geometry from documents
   - `DROPPING GEOMETRY` - Removes the geometry field

### Order and Priority

Subclauses can be specified in any order, but are applied in this logical order:
1. Geometry management (keeping/setting)
2. Fuzzy set verification
3. Alpha-cut application
4. Document structure building
5. Fuzzy set management (keep/drop)
6. Final geometry removal

**Note:** `buildActionRule` can be repeated multiple times (indicated by `*` in the syntax).

## Used In

The **GENERATE section** is used in the following main instructions:
- **filterRule** - To transform documents during filtering
- **groupRule** - To define the structure of grouped documents
- **joinOfCollectionsRule** - To build resulting documents from join
- **whereCaseRule** - Within CASE clauses for conditional transformations
- **groupPartitionRule** - For each grouping partition

## Examples

### Example 1: Simple Structure Building
```jcoql
FILTER
CASE WHERE .score > 80
GENERATE
    BUILD {
        .studentName,
        .finalScore: .score,
        .passed: TRUE
    };
```

### Example 2: With Geometry and Fuzzy Set Management
```jcoql
FILTER
CASE WHERE .temperature > 20
GENERATE
    KEEPING GEOMETRY
    CHECK FOR hotWeather
    ALPHACUT 0.5
    BUILD {
        .stationId,
        .temp: .temperature,
        .fuzzyDegree: #hotWeather
    };
```

### Example 3: Multiple BUILD Actions
```jcoql
GROUP PARTITION (.category = "electronics")
BY .brand
INTO .products
GENERATE
    BUILD {
        .brandName: .brand,
        .itemCount: COUNT(.products)
    }
    ADD FIELDS {
        .averagePrice: AVG(.products.price),
        .topProduct: MAX(.products.rating)
    }
    DROPPING GEOMETRY;
```

### Example 4: With Complete Fuzzy Set Management
```jcoql
JOIN parkingAreas AS p
CASE WHERE DISTANCE(p, 500)
GENERATE
    SETTING GEOMETRY POINT (.latitude, .longitude)
    CHECK FOR nearParking
    BUILD {
        .locationName: .name,
        .parkingName: p.name,
        .distanceMeters: GEODESIC_DISTANCE(.lat, .lon, p.lat, p.lon),
        .proximity: #nearParking
    }
    KEEP FUZZY SETS [nearParking]
    DROP OTHERS;
```

## Implementation Notes

- **At least one subclause is required**: If you specify `GENERATE` without any subclause, an error is generated
- **Multiple BUILDs**: You can specify multiple `BUILD` / `ADD FIELDS` / `REMOVE FIELDS` actions that are applied in sequence
- **Geometry compatibility**: You cannot specify `SETTING GEOMETRY` and `DROPPING GEOMETRY` simultaneously
- **Fuzzy set management**: `KEEP FUZZY SETS` and `DROP FUZZY SETS` are mutually exclusive

## Issues

- Clarify behavior when `BUILD` is used multiple times in sequence
- Document the interaction between `ALPHACUT` and `CHECK FOR` when used together
- Specify default behavior when no geometry management is specified

## References

For the *token list specification* see the [tokenList.md](/languageSpecification/tokenList.md) file.

For related subclauses:
- [geometricOptionRule.md](./geometricOptionRule.md)
- [checkForFuzzySetRule.md](../fuzzySubClauses/checkForFuzzySetRule.md)
- [alphaCutRule.md](../fuzzySubClauses/alphaCutRule.md)
- [buildActionRule.md](./buildActionRule.md)
- [keepDropFuzzySetsRule.md](../fuzzySubClauses/keepDropFuzzySetsRule.md)
- [dropGeometryRule.md](./dropGeometryRule.md)

For instructions that use GENERATE:
- [filter.md](/languageSpecification/filter.md)
- [group.md](/languageSpecification/group.md)
