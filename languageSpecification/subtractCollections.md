# Subtract Collections instruction

Performs subtraction between collections.
  
The new current collection keeps documents from the first, excluding those in the second.

## EBNF Notation
    subtractCollections ::= SUBTRACT COLLECTIONS id¹[@id²][AS id³], id¹[@id²][AS id³] ;

## Syntax Diagram
![SubtractCollections instruction Syntax!](/languageSpecification/.assets/images/subtract_collections.jpg "Subtract Collections Syntax Diagram") 

## Semantics
* The `id¹` token represents the collection name.
* The `id²` token represents the database name (optional).
* The `id³` token represents the alias name (optional).
* The operation removes from the first collection all documents that are also present in the second collection.
* The resulting collection becomes the new current collection.
* Only two collections can be specified in this operation.

## Examples
      SUBTRACT COLLECTIONS c1@db1, c2@db2;

## Issues

## References
For the *token list specification* see description [tokenList.md](/languageSpecification/tokenList.md) file.
