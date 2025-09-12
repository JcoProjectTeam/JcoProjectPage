# Intersect Collections instruction

Performs the intersection of two collections.

The new current collection keeps only those documents present in both source collection.

## EBNF Notation
    intersectCollections ::= INTERSECT COLLECTIONS id¹[@id²][AS id³], id¹[@id²][AS id³] ;

## Syntax Diagram
![IntersectCollections instruction Syntax!](/languageSpecification/.assets/images/intersect_collections.jpg "Intersect Collections Syntax Diagram") 

## Semantics
* The `id¹` token represents the collection name.                
* The `id²` token represents the database name (optional).
* The `id³` token represents the alias name (optional).
* The operation keeps only documents that are present in both collections.
* The resulting collection becomes the new current collection.
* Only two collections can be specified in this operation.

## Examples
      INTERSECT COLLECTIONS c1@db1, c2@db2;

## Issues

## References
For the *token list specification* see description [tokenList.md](/languageSpecification/tokenList.md) file.
