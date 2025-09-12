# Base Elements of JCoQL

This page explains the fundamental building blocks of the JCoQL language grammar.

## Elements

| Element      | EBNF Syntax Example                | Description                                      |
|--------------|------------------------------------|--------------------------------------------------|
| condition    | (AND, OR, NOT, ... expressions)    | Logical or fuzzy condition for filtering.         |
| parameters   | id TYPE type                       | List of input variables for functions/operators.  |
| fieldRef     | .fieldName or ."field name"        | Reference to a field in a document.               |
| value        | INT, FLOAT, BOOLEAN, APEX_VALUE    | Literal values used in expressions.               |
| comparator   | =, !=, <, >, <=, >=                | Comparison operators.                            |

## Example
```jcoql
WHERE (.score > 5 AND .active = TRUE)
PARAMETERS x TYPE FLOAT, y TYPE INT
```

## See Also
- [Common Clauses](./commonClauses.md)
- [Funzioni Predefinite](./predefinedFunctions.md)
