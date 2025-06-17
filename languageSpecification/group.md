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


## Examples


## Issues


## References
For the *token list specification* see description [tokenList.md](/languageSpecification/tokenList.md) file.
