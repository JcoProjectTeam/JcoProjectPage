# Merge Collections instruction

Performs the union of the specified collections.

The resulting collection becomes the new current collection and includes all documents from the source collections.

The option REMOVE DUPLICATES eliminates duplicate documents.

## EBNF Notation
    mergeCollections ::= MERGE COLLECTIONS (id¹ [@id²] [AS id³])++
                            [REMOVE DUPLICATES]* ;

## Syntax Diagram
![MergeCollections instruction Syntax!](/languageSpecification/.assets/images/merge_collections.jpg "Merge Collections Syntax Diagram") 

## Semantics
* The `id¹` token represents the collection name.
* The `id²` token represents the database name.
* The `id³` token represents the alias name.
* Multiple collections can be specified, separated by commas.
* The optional `REMOVE DUPLICATES` clause eliminates duplicate documents from the result.
* The merged collection becomes the new current collection.

## Examples
      MERGE COLLECTIONS c1@db1, c2@db2, c3@db3;
      MERGE COLLECTIONS c4@db1, c4@db2, c2@db3 REMOVE DUPLICATES;

## Issues

## References
For the *token list specification* see description [tokenList.md](/languageSpecification/tokenList.md) file.
