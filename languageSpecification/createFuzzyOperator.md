# Create Fuzzy Operator instruction

> Note: The "CREATE FUZZY OPERATOR" / "CREATE <Generic> FUZZY OPERATOR" and "CREATE FUZZY AGGREGATOR" / "CREATE <Generic> FUZZY AGGREGATOR" constructs are deprecated and will be removed soon — equivalent functionality is available via evaluators (for example: "CREATE FUZZY EVALUATOR" and "CREATE <Generic> FUZZY EVALUATOR").

Create an operator tht returns a fuzzy value form crips values.


## EBNF Notation
    createFuzzyOperator ::= CREATE FUZZY OPERATOR id¹ 
                                PARAMETERS parameter++
                                [PRECONDITION condition]
                                EVALUATE expression
                                [POLYLINE '[' 
                                    ( '(' n¹, n² ')' )++
                                          ']' ]*
                          ;

## Syntax Diagram
![CreateFuzzyOperator instruction Syntax!](/languageSpecification/.assets/images/create_fuzzy_operator.jpg "Create Fuzzy Operator Syntax Diagram") 


## Semantics
* The `id¹` token represents the name assigned to the Fuzzy Operator.
* The `parameter` token specifies the parameter, or the list of parameters, that the function accepts.
* The optional `condition` token, if present, defines a preliminary condition that must be true before the function is executed.
* The `expression` is the operation that returns the value. if ther's no polyline the return values is limited in the [0,1] range
* The `x¹` and the `y¹` token, if present, compose the polyline or the list of polyline that the operator value used to return the fuzzy value.

## Examples
      CREATE FUZZY OPERATOR linearEval PARAMETERS x TYPE FLOAT EVALUATE x / 10;
      CREATE FUZZY OPERATOR boundedEval PARAMETERS x TYPE FLOAT PRECONDITION ( x >= 0 AND x <= 10 ) EVALUATE 1 - ABS(x - 5)/5;
      CREATE FUZZY OPERATOR triangularEval PARAMETERS x TYPE FLOAT EVALUATE x POLYLINE[ (0,0), (5,1), (10,0) ];

## Issues


## References
For the *token list specification* see description [tokenList.md](/languageSpecification/tokenList.md) file.
