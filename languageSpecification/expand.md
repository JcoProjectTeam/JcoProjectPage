# Expand instruction

Extracts new documents from field arrays.

It is possible to define different UNPACK condition.

If the condition is met, and the document contains the array field specified in *fieldRef¹*, for each value in the array a new document is created with fields of the source document and an extra field as specified in *fieldRef²* that holds the value in the array.

The final KEEP/DROP options works as for the Case Clause.

## EBNF Notation
    expand ::= EXPAND 
                (UNPACK condition 
                    ARRAY (id¹)+
                    TO (id²)+ )+                          
                [(KEEP | DROP) OTHERS] ;

## Syntax Diagram
![Expand instruction Syntax!](/languageSpecification/.assets/images/expand.jpg "Expand Syntax Diagram") 

## Semantics
* The `condition` token defines when the unpack operation should be applied.
* The `id¹` token specifies the array field to be unpacked (must be an array field).
* The `id²` token specifies the name of the field in the new document holding the single array value.
* Multiple UNPACK clauses can be defined for different conditions and array fields.
* The optional `(KEEP | DROP) OTHERS` clause works as for the Case Clause to handle documents that don't match any UNPACK condition.
* For each value in the specified array, a new document is created containing all fields from the source document plus the new field with the single array value.

## Examples
      EXPAND 
          UNPACK (.type = "user") ARRAY .hobbies TO .hobby
          KEEP OTHERS;
      
      EXPAND 
          UNPACK (.category = "product") ARRAY .tags TO .tag
          UNPACK (.category = "service") ARRAY .features TO .feature
          DROP OTHERS;

## Issues

## References
For the *token list specification* see description [tokenList.md](/languageSpecification/tokenList.md) file.
