# Group instruction

Groups documents of the current collection into one, with an array of the originals.


## EBNF Notation

    group ::=  GROUP 
                ( PARTITION condition² 
                    BY field¹** 
                    INTO field²
                    [ DROP GROUPING FIELDS ]
                  [ ORDER BY field³** [ KEEP UNCOMPARABLE ] ]
                  [ generateSectionRule ] )+
                [ ( KEEP | DROP ) OTHERS ]
            ;      

## Syntax Diagram
![Group instruction Syntax!](/languageSpecification/.assets/images/group_.jpg "Group Syntax Diagram") 


## Semantics
* The `PARTITION` token followed by a `condition` (see [Base Elements](./notation/baseElements.md)) defines criteria to partition the data before grouping.
* The `BY` token, followed by one or more `field`, specifies the fields used to perform the grouping operation.
* The `INTO` token defines the new field to store the result of the grouping.
* The optional `DROP GROUPING FIELDS` token specifies whether to exclude the original grouping fields from the final result.
* The optional `ORDER BY` clause sorts the grouped data based on specified fields.
* The optional `KEEP UNCOMPARABLE` token ensures that entries that cannot be compared remain in the result.
* The `GENERATE SECTION` (see [Base Elements](./notation/baseElements.md)) clause indicates the actions to perform after grouping, including selectively `KEEP` or `DROP` certain fields.
* The optional `KEEP | DROP OTHERS` directive specifies whether to retain or discard fields not explicitly mentioned in the grouping instruction.

## Examples
    1. GROUP PARTITION TRUE BY category INTO categoryGroup;
    2. GROUP PARTITION TRUE BY region, product INTO salesGroup DROP GROUPING FIELDS ORDER BY product KEEP UNCOMPARABLE;
    3. GROUP PARTITION TRUE BY salesRep INTO repTotals GENERATE SECTION KEEP repTotals, saleDate DROP OTHERS;
    4. GROUP PARTITION saleDate >= '2025-01-01' BY region, product INTO regionalProductGroup DROP GROUPING FIELDS ORDER BY     region, product KEEP UNCOMPARABLE GENERATE SECTION KEEP regionalProductGroup, saleDate DROP OTHERS;

## Issues


## References
For the *token list specification* see description [tokenList.md](/languageSpecification/tokenList.md) file.
