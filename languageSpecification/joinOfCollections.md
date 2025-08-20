# Join Of Collections instruction

Joins two collections via cartesian product, with optional filtering and transformation.

The first collection is said as *left collection*, and second collection is *right collection*.

Given a couple *(l, r)* where *l* is the alias of a document the left collection, and *r* is the alias of a document from the right collection, the instruction create a new document with the fields *l* and *r* whose value is, respectively, the document *l*, and the document *r*.

## EBNF Notation
    joinOfCollections ::= JOIN OF COLLECTIONS 
                            id¹@id² AS id³, id¹@id² AS id⁴
                            [ON GEOMETRY spatialFunctionRule]*
                            [SET GEOMETRY (INTERSECTION|RIGHT|LEFT|ALL)]*
                            [addFieldsRule]*
                            [setFuzzySetsRule]*
                            [caseClauseRule|generateSectionRule]*
                            [REMOVE DUPLICATES]* ;

## Syntax Diagram
![JoinOfCollections instruction Syntax!](/languageSpecification/.assets/images/join_of_collections.jpg "Join Of Collections Syntax Diagram") 

## Semantics
* The `id¹` token represents the collection name.
* The `id²` token represents the database name.
* The `id³` token represents the alias of the left collection.
* The `id⁴` token represents the alias of the right collection.
* The optional `ON GEOMETRY` clause specifies a spatial condition.
* The optional `SET GEOMETRY` clause specifies the geometry of the new document.
* The optional `addFields` clause adds extra fields to the new document.
* The optional `setFuzzySets` clause sets which fuzzy sets from the source documents to keep.
* The optional `caseClause` or `generateSection` work exactly as for the FILTER instruction.
* The optional `REMOVE DUPLICATES` clause eliminates duplicate documents from the result.

## Examples
      JOIN OF COLLECTIONS coll1@db1 AS ld, coll2@db2 AS rd;
      JOIN OF COLLECTIONS parks@milano AS left, bikes@milano AS right
          ON GEOMETRY INTERSECT
          SET GEOMETRY ALL
          REMOVE DUPLICATES;

## Issues

## References
For the *token list specification* see description [tokenList.md](/languageSpecification/tokenList.md) file.

---
¹ Not covered by the course
