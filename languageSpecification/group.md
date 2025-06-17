# Group instruction

Groups documents of the current collection into one, with an array of the originals.


## EBNF Notation

    group ::= ( GROUP 
                PARTITION condition² 
                    BY field¹** 
                    INTO field²
                    [ DROP GROUPING FIELDS ]
              [ ORDER BY field³**
                [ KEEP UNCOMPARABLE ] ]
              [ GENERATE SECTION ] )+
              [ ( KEEP | DROP ) OTHERS ]
            SC       

## Syntax Diagram
![Group instruction Syntax!](/languageSpecification/.assets/images/group_.jpg "Group Syntax Diagram") 


## Semantics
* The `PARTITION` token followed by a `condition` defines criteria to partition the data before grouping.
* The `BY` token, followed by one or more `field`, specifies the fields used to perform the grouping operation.
* The `INTO` token defines the new field to store the result of the grouping.
* The optional `DROP GROUPING FIELDS` token specifies whether to exclude the original grouping fields from the final result.
* The optional `ORDER BY` clause sorts the grouped data based on specified fields.
* The optional `KEEP UNCOMPARABLE` token ensures that entries that cannot be compared remain in the result.
* The `GENERATE SECTION` clause indicates the actions to perform after grouping, including selectively `KEEP` or `DROP` certain fields.
* The optional `KEEP | DROP OTHERS` directive specifies whether to retain or discard fields not explicitly mentioned in the grouping instruction.

## Examples


## Issues


## References
For the *token list specification* see description [tokenList.md](/languageSpecification/tokenList.md) file.
