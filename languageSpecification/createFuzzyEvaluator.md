# Create Fuzzy Evaluator instruction

Create an evaluator that returns a fuzzy value form crips values.


## EBNF Notation
    createFuzzyEvaluator ::= CREATE FUZZY EVALUATOR id¹ 
                                PARAMETERS parameter++
                                [PRECONDITION condition]
                                ( arraySortRule | deriveRule | forAllRule )*  
                                EVALUATE expression
                                [POLYLINE '[' 
                                    ( '(' n¹, n² ')' )++
                                          ']' ]*
                          ;

## Syntax Diagram
![CreateFuzzyEvaluator instruction Syntax!](/languageSpecification/.assets/images/create_fuzzy_evaluator.jpg "Create Fuzzy Evaluator Syntax Diagram") 


## Semantics
* The `id¹` token represents the name assigned to the Fuzzy Evaluator.
* The `parameter` token specifies the parameter, or the list of parameters, that the function accepts.
* The optional `condition` token (see [Base Elements](./notation/baseElements.md)), if present, defines a preliminary condition that must be true before the function is executed.
* The `expression` is the operation that returns the value. if there is no polyline, the return values is limited in the [0,1] range.
* The `n¹` and the `n²` token, if present, compose the polyline or the list of polyline that the evaluator value used to return the fuzzy value.

## Examples
      CREATE FUZZY EVALUATOR linearEval PARAMETERS x TYPE FLOAT EVALUATE x / 10;
      CREATE FUZZY EVALUATOR boundedEval PARAMETERS x TYPE FLOAT PRECONDITION ( x >= 0 AND x <= 10 ) EVALUATE 1 - ABS(x - 5)/5;
      CREATE FUZZY EVALUATOR triangularEval PARAMETERS x TYPE FLOAT EVALUATE x;

## Issues


## References
For the *token list specification* see description [tokenList.md](/languageSpecification/tokenList.md) file.
