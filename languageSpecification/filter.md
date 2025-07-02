# Filter instruction

Filters and/or transforms documents in the current collection.


## EBNF Notation

    filter ::=  FILTER 
                (
                    ((CASE | CASES) WHERE conditionRule [generateSectionRule] )+  
                                [(KEEP | DROP ) OTHERS]
                    |  generateSectionRule
                )
                [REMOVE DUPLICATES]
            ;

## Syntax Diagram
![Filter instruction Syntax!](/languageSpecification/assets/rules/filter.jpg "Filter Syntax Diagram") 


## Semantics


## Examples


## Issues


## References
For the *token list specification* see description [tokenList.md](/languageSpecification/tokenList.md) file.
