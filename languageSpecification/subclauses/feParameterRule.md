# Fuzzy Evaluator Parameter Declaration (feParameterRule)

The `feParameterRule` defines how to declare parameters for fuzzy evaluators and aggregators in JCoQL+. It extends `parameterRule` by supporting array types.

---

## EBNF Notation

```
feParameterRule ::= ID TYPE (ID | ARRAY)
```

---

## Syntax Components

- **ID**: The parameter name (variable name used in the evaluator body)
- **TYPE**: Keyword that separates name from type
- **ID | ARRAY**: The data type - either a standard type (ID) or ARRAY keyword

---

## Semantics

The fuzzy evaluator parameter rule specifies:
1. **Parameter Name**: The identifier used to reference the parameter value
2. **Type Declaration**: The expected data type (scalar or array)

### Supported Data Types

#### Scalar Types
- `FLOAT` - Floating-point numbers
- `INT` - Integer numbers
- `STRING` - Text strings
- `BOOLEAN` - Boolean values
- Custom types defined in your application

#### Array Type
- `ARRAY` - Collection of values (can be processed with FOR ALL, SORT, etc.)

---

## Usage Context

The `feParameterRule` is used exclusively in:
- **CREATE FUZZY EVALUATOR** - Define evaluator parameters
- **CREATE FUZZY AGGREGATOR** - Define aggregator parameters
- **CREATE GENERIC FUZZY EVALUATOR** - Define generic evaluator parameters

For regular functions and operators, use `parameterRule` instead.

---

## Examples

### Example 1: Scalar Parameter (Single Value)

```jcoql
CREATE FUZZY EVALUATOR SimpleEval 
    PARAMETERS value TYPE FLOAT 
    EVALUATE value / 10;
```

**Parameter**: `value TYPE FLOAT` - single numeric value

---

### Example 2: Array Parameter

```jcoql
CREATE FUZZY EVALUATOR ArrayAverage 
    PARAMETERS values TYPE ARRAY 
    FOR ALL item IN values 
        AGGREGATE WITH SUM item AS total 
    EVALUATE total / SIZE(values);
```

**Parameter**: `values TYPE ARRAY` - collection of values

---

### Example 3: Multiple Parameters (Mixed Types)

```jcoql
CREATE FUZZY EVALUATOR WeightedAverage 
    PARAMETERS 
        scores TYPE ARRAY, 
        weight TYPE FLOAT 
    FOR ALL score IN scores 
        AGGREGATE WITH SUM score AS total 
    EVALUATE (total / SIZE(scores)) * weight;
```

**Parameters**:
- `scores TYPE ARRAY` - array to process
- `weight TYPE FLOAT` - scalar multiplier

---

### Example 4: Multiple Array Parameters

```jcoql
CREATE FUZZY EVALUATOR CompareArrays 
    PARAMETERS 
        array1 TYPE ARRAY, 
        array2 TYPE ARRAY 
    FOR ALL val1 IN array1 
        AGGREGATE WITH SUM val1 AS sum1 
    FOR ALL val2 IN array2 
        AGGREGATE WITH SUM val2 AS sum2 
    EVALUATE ABS(sum1 - sum2) / (sum1 + sum2);
```

**Parameters**:
- `array1 TYPE ARRAY`
- `array2 TYPE ARRAY`

---

### Example 5: Array Processing with Sorting

```jcoql
CREATE FUZZY EVALUATOR MedianValue 
    PARAMETERS numbers TYPE ARRAY 
    SORT i IN numbers BY i TYPE FLOAT AS sorted 
    EVALUATE sorted[SIZE(sorted) / 2];
```

**Parameter**: `numbers TYPE ARRAY` - unsorted array

The SORT clause creates `sorted` array for processing.

---

### Example 6: Complex Aggregation

```jcoql
CREATE FUZZY EVALUATOR StdDeviation 
    PARAMETERS values TYPE ARRAY 
    FOR ALL x IN values 
        AGGREGATE WITH SUM x AS sum 
    DERIVE sum / SIZE(values) AS mean 
    FOR ALL x IN values 
        LOCALLY (x - mean) * (x - mean) AS deviation 
        AGGREGATE WITH SUM deviation AS variance 
    EVALUATE SQRT(variance / SIZE(values));
```

**Parameter**: `values TYPE ARRAY`

Complex operations: calculate mean, then variance, then standard deviation.

---

### Example 7: Conditional Array Processing

```jcoql
CREATE FUZZY EVALUATOR PositiveAverage 
    PARAMETERS data TYPE ARRAY 
    FOR ALL value IN data 
        LOCALLY IF((value > 0), value, 0) AS filtered 
        AGGREGATE WITH SUM filtered AS total, 
                  WITH SUM IF((value > 0), 1, 0) AS count 
    EVALUATE IF((count > 0), total / count, 0);
```

**Parameter**: `data TYPE ARRAY`

Only averages positive values using conditional logic.

---

## Array Operations

When using `TYPE ARRAY`, you can leverage these operations:

### FOR ALL - Iterate Over Array
```jcoql
FOR ALL item IN arrayParam 
    AGGREGATE WITH SUM item AS total
```

### SORT - Order Array Elements
```jcoql
SORT x IN arrayParam BY x TYPE FLOAT AS sorted
```

### LOCALLY - Local Variables
```jcoql
FOR ALL x IN arrayParam 
    LOCALLY x * 2 AS doubled 
    AGGREGATE WITH SUM doubled AS total
```

### DERIVE - Compute Intermediate Values
```jcoql
DERIVE SUM(arrayParam) AS total
```

---

## Best Practices

1. **Use Descriptive Names**
   ```jcoql
   // Good
   temperatures TYPE ARRAY
   
   // Less clear
   arr TYPE ARRAY
   ```

2. **Match Type to Usage**
   ```jcoql
   // Use ARRAY for collections
   values TYPE ARRAY
   
   // Use scalar for single values
   threshold TYPE FLOAT
   ```

3. **Validate Array Contents**
   ```jcoql
   PARAMETERS scores TYPE ARRAY
   PRECONDITION SIZE(scores) > 0  // Ensure non-empty
   ```

4. **Combine with Preconditions**
   ```jcoql
   PARAMETERS 
       data TYPE ARRAY, 
       minSize TYPE INT
   PRECONDITION SIZE(data) >= minSize
   ```

---

## Common Patterns

### Pattern 1: Simple Aggregation
```jcoql
PARAMETERS values TYPE ARRAY
FOR ALL v IN values 
    AGGREGATE WITH SUM v AS total
EVALUATE total / SIZE(values)
```

### Pattern 2: Filtered Aggregation
```jcoql
PARAMETERS data TYPE ARRAY
FOR ALL x IN data 
    LOCALLY IF((x > 0), x, 0) AS filtered
    AGGREGATE WITH SUM filtered AS result
EVALUATE result
```

### Pattern 3: Multi-Array Processing
```jcoql
PARAMETERS arr1 TYPE ARRAY, arr2 TYPE ARRAY
FOR ALL a IN arr1 
    AGGREGATE WITH SUM a AS sum1
FOR ALL b IN arr2 
    AGGREGATE WITH SUM b AS sum2
EVALUATE sum1 + sum2
```

---

## Common Errors

### Error 1: Using ARRAY in Regular Functions
```jcoql
// ❌ Wrong - parameterRule doesn't support ARRAY
CREATE JAVASCRIPT FUNCTION ProcessArray 
    PARAMETERS data TYPE ARRAY

// ✅ Use arrays as field references instead
CREATE JAVASCRIPT FUNCTION ProcessArray 
    PARAMETERS fieldName TYPE STRING
    BODY 
        // Access array from document field
        return processArrayField(fieldName);
    END BODY
```

### Error 2: Missing FOR ALL with Arrays
```jcoql
// ❌ Wrong - can't directly use array in expression
PARAMETERS values TYPE ARRAY
EVALUATE values / 10

// ✅ Correct - use FOR ALL to iterate
PARAMETERS values TYPE ARRAY
FOR ALL v IN values 
    AGGREGATE WITH SUM v AS total
EVALUATE total / SIZE(values)
```

### Error 3: Wrong Type Keyword
```jcoql
// ❌ Wrong
PARAMETERS values AS ARRAY

// ✅ Correct
PARAMETERS values TYPE ARRAY
```

---

## Differences from parameterRule

| Feature | feParameterRule | parameterRule |
|---------|----------------|---------------|
| **Syntax** | `ID TYPE (ID \| ARRAY)` | `ID TYPE ID` |
| **ARRAY Support** | ✅ Yes | ❌ No |
| **Array Operations** | FOR ALL, SORT, DERIVE | Not applicable |
| **Used In** | Fuzzy Evaluators/Aggregators | Functions, Operators |
| **Scalar Types** | ✅ Yes | ✅ Yes |

---

## See Also

- [parameterRule](./parameterRule.md) - Parameter rule for functions and operators
- [CREATE FUZZY EVALUATOR](../createFuzzyEvaluator.md) - Fuzzy evaluator creation
- [CREATE FUZZY AGGREGATOR](../createFuzzyAggregator.md) - Fuzzy aggregator creation
- [CREATE GENERIC FUZZY EVALUATOR](../createGenericFuzzyEvaluator.md) - Generic evaluator creation
- [Base Elements](../notation/baseElements.md) - Basic language elements

---

## References

For the complete token list specification, see [tokenList.md](../tokenList.md).
