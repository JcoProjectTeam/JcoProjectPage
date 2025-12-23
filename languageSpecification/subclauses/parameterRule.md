# Parameter Declaration (parameterRule)

The `parameterRule` defines how to declare parameters for custom functions and operators in JCoQL+.

---

## EBNF Notation

```
parameterRule ::= ID TYPE ID
```

---

## Syntax Components

- **First ID**: The parameter name (variable name used in the function body)
- **TYPE**: Keyword that separates name from type
- **Second ID**: The data type of the parameter

---

## Semantics

The parameter rule specifies:
1. **Parameter Name**: The identifier used to reference the parameter value within the function
2. **Type Declaration**: The expected data type for validation and documentation

### Supported Data Types

Common types include:
- `FLOAT` - Floating-point numbers
- `INT` - Integer numbers
- `STRING` - Text strings
- `BOOLEAN` - Boolean values (TRUE/FALSE)
- `ARRAY` - Array/list values (only in `feParameterRule`)
- Custom types defined in your application

---

## Usage Context

The `parameterRule` is used in:
- **CREATE JAVASCRIPT FUNCTION** - Define function parameters
- **CREATE JAVA FUNCTION** - Define function parameters
- **CREATE FUZZY OPERATOR** - Define operator parameters
- **CREATE GENERIC FUZZY OPERATOR** - Define operator parameters

For fuzzy evaluators and aggregators, see `feParameterRule` which allows ARRAY types.

---

## Examples

### Example 1: Single Parameter

```jcoql
CREATE JAVASCRIPT FUNCTION DoubleValue 
    PARAMETERS x TYPE FLOAT 
    BODY 
        return x * 2; 
    END BODY;
```

**Parameter**: `x TYPE FLOAT`

---

### Example 2: Multiple Parameters

```jcoql
CREATE JAVASCRIPT FUNCTION CalculateDistance 
    PARAMETERS 
        x1 TYPE FLOAT, 
        y1 TYPE FLOAT, 
        x2 TYPE FLOAT, 
        y2 TYPE FLOAT 
    BODY 
        return Math.sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1)); 
    END BODY;
```

**Parameters**:
- `x1 TYPE FLOAT`
- `y1 TYPE FLOAT`
- `x2 TYPE FLOAT`
- `y2 TYPE FLOAT`

---

### Example 3: Fuzzy Operator with Type Checking

```jcoql
CREATE FUZZY OPERATOR LinearEval 
    PARAMETERS value TYPE FLOAT 
    PRECONDITION value >= 0 AND value <= 100 
    EVALUATE value / 100;
```

**Parameter**: `value TYPE FLOAT`

The `TYPE FLOAT` declaration helps validate that the input is numeric.

---

### Example 4: String Parameter

```jcoql
CREATE JAVASCRIPT FUNCTION ToUpperCase 
    PARAMETERS text TYPE STRING 
    BODY 
        return text.toUpperCase(); 
    END BODY;
```

**Parameter**: `text TYPE STRING`

---

### Example 5: Mixed Types

```jcoql
CREATE JAVASCRIPT FUNCTION RepeatString 
    PARAMETERS 
        text TYPE STRING, 
        count TYPE INT 
    BODY 
        return text.repeat(count); 
    END BODY;
```

**Parameters**:
- `text TYPE STRING`
- `count TYPE INT`

---

## Best Practices

1. **Descriptive Names**: Use clear, meaningful parameter names
   ```jcoql
   // Good
   distance TYPE FLOAT
   
   // Less clear
   d TYPE FLOAT
   ```

2. **Type Consistency**: Match the parameter type to its usage
   ```jcoql
   // Correct
   age TYPE INT
   
   // Incorrect for age (should be INT)
   age TYPE STRING
   ```

3. **Validate in Preconditions**: Use PRECONDITION to validate parameter ranges
   ```jcoql
   PARAMETERS temperature TYPE FLOAT
   PRECONDITION temperature >= -273.15  // Absolute zero check
   ```

4. **Order Matters**: List parameters in logical order
   ```jcoql
   // Logical order
   PARAMETERS startDate TYPE STRING, endDate TYPE STRING
   
   // Less intuitive
   PARAMETERS endDate TYPE STRING, startDate TYPE STRING
   ```

---

## Common Errors

### Error 1: Missing TYPE Keyword
```jcoql
// ❌ Wrong
PARAMETERS x FLOAT

// ✅ Correct
PARAMETERS x TYPE FLOAT
```

### Error 2: Swapped Name and Type
```jcoql
// ❌ Wrong
PARAMETERS FLOAT x

// ✅ Correct
PARAMETERS x TYPE FLOAT
```

### Error 3: Using ARRAY Type
```jcoql
// ❌ Wrong - parameterRule doesn't support ARRAY
PARAMETERS values TYPE ARRAY

// ✅ Use feParameterRule in fuzzy evaluators instead
CREATE FUZZY EVALUATOR ... 
    PARAMETERS values TYPE ARRAY
```

---

## Differences from feParameterRule

| Feature | parameterRule | feParameterRule |
|---------|--------------|-----------------|
| **Syntax** | `ID TYPE ID` | `ID TYPE (ID \| ARRAY)` |
| **ARRAY Support** | ❌ No | ✅ Yes |
| **Used In** | Functions, Operators | Fuzzy Evaluators, Aggregators |

For array parameters in fuzzy evaluators/aggregators, use `feParameterRule`.

---

## See Also

- [feParameterRule](./feParameterRule.md) - Parameter rule for fuzzy evaluators (supports ARRAY)
- [CREATE JAVASCRIPT FUNCTION](../createJavaScriptFunction.md) - JavaScript function creation
- [CREATE JAVA FUNCTION](../createJavaFunction.md) - Java function creation
- [CREATE FUZZY OPERATOR](../createFuzzyOperator.md) - Fuzzy operator creation
- [Base Elements](../notation/baseElements.md) - Basic language elements

---

## References

For the complete token list specification, see [tokenList.md](../tokenList.md).
