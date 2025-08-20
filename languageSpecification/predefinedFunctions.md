# Predefined Functions in JCoQL

This page lists all predefined functions available in JCoQL, with links to detailed documentation for each function.

| Function | Description                | Link                       |
|----------|----------------------------|----------------------------|
| ABS(x)   | Returns the absolute value | [ABS](./absFunction.md)    |
| MIN(x,y) | Returns the minimum value  | [MIN](./minFunction.md)    |
| MAX(x,y) | Returns the maximum value  | [MAX](./maxFunction.md)    |
| SUM(x,y) | Returns the sum            | [SUM](./sumFunction.md)    |
| AVG(x,y) | Returns the average        | [AVG](./avgFunction.md)    |
| ...      | ...                        | ...                        |

## Example Usage
```jcoql
EVALUATE result AS ABS(x - y)
EVALUATE minVal AS MIN(a, b)
```

## See Also
- [Base Elements](./baseElements.md)
- [Common Clauses](./commonClauses.md)
