# Common Clauses in JCoQL

This page describes clauses that are reused across multiple JCoQL instructions, such as `DROP OTHERS` and `KEEP OTHERS`.

## Clauses Overview

| Clause         | Used In                | Description                                                                 |
|----------------|------------------------|-----------------------------------------------------------------------------|
| DROP OTHERS    | EXPAND, GROUP, CASE    | Removes documents that do not match the specified condition or partition.    |
| KEEP OTHERS    | EXPAND, GROUP, CASE    | Keeps documents that do not match the specified condition or partition.      |
| REMOVE DUPLICATES | MERGE, JOIN, FILTER | Removes duplicate documents from the result.                                |

## Fuzzy World vs Logical-Mathematical World
- In fuzzy instructions, these clauses may affect fuzzy set membership or aggregation.
- In logical-mathematical instructions, they act as filters or selectors for data.

## Subclauses
- **caseClause**: Used for conditional logic, often with KEEP/DROP OTHERS.
- **othersRule**: Specifies what to do with unmatched documents (KEEP/DROP).
- **condition**: Logical or fuzzy condition for filtering or partitioning.
- **parameters**: List of input variables for functions or operators.

## Example Usage
```jcoql
EXPAND UNPACK (.type = "user") ARRAY .hobbies TO .hobby KEEP OTHERS;
GROUP PARTITION (.score > 5) BY .user INTO .group DROP OTHERS;
```

## See Also
- [Elementi Base del JCoQL](./baseElements.md)
- [Funzioni Predefinite](./predefinedFunctions.md)
