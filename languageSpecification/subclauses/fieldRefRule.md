# Field Reference

The **fieldRefRule** defines how to reference a field of a JSON document, supporting both simple fields and nested fields at arbitrary depth.

## EBNF Syntax

```ebnf
<span style="color: purple">fieldRefRule</span> ::= (FIELD_NAME)+
```

Where `FIELD_NAME` can be:
```ebnf
FIELD_NAME ::= DOT (LETTER | DIGIT | TILDE | '_')+ 
             | DOT '"' (~'"')* '"'
```

## Syntax Diagram
![Field Reference Syntax](/languageSpecification/assets/rules/fieldRefRule.png "Field Reference Syntax Diagram")

## Semantics

A **field reference** always starts with a dot `.` followed by the field name. To access nested fields, multiple field names separated by dots are concatenated.

### Forms of Field Reference

#### 1. Simple Field
```
.nomeCampo
```
Accesses a top-level field of the document.

#### 2. Nested Field
```
.livello1.livello2.livello3
```
Accesses a field within nested sub-objects.

#### 3. Field with Special Name
```
."nome con spazi"
."nome-con-trattini"
."123numerico"
```
Uses quotes for field names that contain spaces, hyphens, or start with numbers.

#### 4. Special Field (with Tilde)
```
~geometry
~fuzzysets
~metadata
```
Accesses special fields of the JCoQL+ system.

## Components

- **DOT** `.` - Dot indicating the beginning of a field reference
- **Field name** - Alphanumeric identifier (can include underscore `_` and tilde `~`)
- **Quoted name** - Name between double quotes for special characters

## Used In

The **fieldRefRule** is one of the most used rules in the language, present in:
- **buildActionRule** - To specify which fields to include/exclude
- **outputFieldSpecRule** - To define output fields
- **geometricOptionRule** - To specify geometric coordinates
- **All conditions** (orConditionRule, andConditionRule, predicateRule)
- **groupRule** - To specify grouping criteria
- **expandRule** - To identify arrays to expand
- **addFieldsRule** - To define new fields
- **Expressions** - In any context where data access is needed

## Examples

### Example 1: Simple Fields
```jcoql
.name
.email
.age
.price
```
**Description:** References to top-level fields.

---

### Example 2: Nested Fields (Dot Notation)
```jcoql
.customer.name
.customer.address.city
.customer.address.geo.coordinates.latitude
```
**Description:** Access to fields through nested sub-objects.

**Example document:**
```json
{
  "customer": {
    "name": "Mario Rossi",
    "address": {
      "city": "Milano",
      "geo": {
        "coordinates": {
          "latitude": 45.4642,
          "longitude": 9.1900
        }
      }
    }
  }
}
```

---

### Example 3: Fields with Special Names
```jcoql
."first name"
."last-name"
."@timestamp"
."123_id"
."field.with.dots"
```
**Description:** Use of quotes for names containing special characters.

**Example document:**
```json
{
  "first name": "Mario",
  "last-name": "Rossi",
  "@timestamp": "2025-01-01T00:00:00Z",
  "123_id": "XYZ",
  "field.with.dots": "value"
}
```

---

### Example 4: System Special Fields
```jcoql
~geometry
~fuzzysets
~metadata
```
**Description:** References to special fields managed by the JCoQL+ system.

---

### Example 5: In WHERE Conditions
```jcoql
WHERE .age > 18 AND .city = "Milano"

WHERE .customer.address.country = "IT"

WHERE ."registration date" > "2024-01-01"
```

---

### Example 6: In BUILD Actions
```jcoql
BUILD {
    .id,
    .customerName: .customer.name,
    .city: .customer.address.city,
    .lat: .customer.address.geo.coordinates.latitude,
    .lon: .customer.address.geo.coordinates.longitude
}
```
**Description:** Extracts nested fields and flattens them in the output structure.

---

### Example 7: In Arithmetic Expressions
```jcoql
BUILD {
    .price,
    .quantity,
    .discount,
    .subtotal: (.price * .quantity),
    .discountAmount: (.price * .quantity * .discount),
    .total: (.price * .quantity * (1 - .discount))
}
```

---

### Example 8: In GROUP BY
```jcoql
GROUP PARTITION (.category = "electronics")
BY .brand
INTO .products
GENERATE
    BUILD {
        .brandName: .brand,
        .productCount: COUNT(.products)
    };
```

---

### Example 9: With Array Elements
```jcoql
EXPAND UNPACK (.type = "order") ARRAY .items TO .item
GENERATE
    BUILD {
        .orderId: .id,
        .itemName: .item.name,
        .itemPrice: .item.price,
        .itemQuantity: .item.quantity
    };
```
**Description:** Accesses elements within expanded arrays.

---

### Example 10: In Geometric Functions
```jcoql
GENERATE
    SETTING GEOMETRY POINT (.location.latitude, .location.longitude)
    BUILD {
        .placeName: .name,
        .coords: {
            .lat: .location.latitude,
            .lon: .location.longitude
        }
    };
```

---
## Issues

- Clarify behavior with arrays: does `.items` return the entire array or what?
- Document if there is a depth limit for nesting
- Specify performance implications of very deep paths
- Define behavior with fields containing null vs missing fields

## References

For the *token list specification* see the [tokenList.md](/languageSpecification/tokenList.md) file.

Used in:
- [buildActionRule.md](./buildActionRule.md)
- [outputFieldSpecRule.md](./outputFieldSpecRule.md)
- [geometricOptionRule.md](./geometricOptionRule.md)
- [predicateRule.md](../conditionExpressionModel/predicateRule.md)

Related tokens:
- [FIELD_NAME token](/languageSpecification/tokenList.md#field_name)
- [DOT token](/languageSpecification/tokenList.md#dot)
