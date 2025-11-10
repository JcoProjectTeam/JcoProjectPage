# Create Fuzzy Aggregator instruction

> Note: The "CREATE FUZZY OPERATOR" / "CREATE <Generic> FUZZY OPERATOR" and "CREATE FUZZY AGGREGATOR" / "CREATE <Generic> FUZZY AGGREGATOR" constructs are deprecated and will be removed soon — equivalent functionality is available via evaluators (for example: "CREATE FUZZY EVALUATOR" and "CREATE <Generic> FUZZY EVALUATOR").

Create an aggregator tht returns a fuzzy value form crips values.


## EBNF Notation
    createFuzzyAggregator ::= CREATE FUZZY AGGREGATOR id¹ 
                                PARAMETERS parameter++
                                [PRECONDITION condition]
                                [SortRule]
                                (ForAllRule | DeriveRule)**
                                EVALUATE expression
                                [POLYLINE '[' 
                                    ( '(' n¹, n² ')' )++
                                          ']' ]*
                          ;

## Syntax Diagram
![CreateFuzzyAggregator instruction Syntax!](/languageSpecification/.assets/images/create_fuzzy_aggregator.jpg "Create Fuzzy Aggregator Syntax Diagram") 


## Semantics
* The `id¹` token represents the name assigned to the Fuzzy Aggregator.
* The `parameter` token specifies the parameter, or the list of parameters, that the function accepts.
* The optional `condition` token (see [Base Elements](./notation/baseElements.md)), if present, defines a preliminary condition that must be true before the function is executed.
* The `expression` is the operation that returns the value. if ther's no polyline the return values is limited in the [0,1] range
* The `x¹` and the `y¹` token, if present, compose the polyline or the list of polyline that the aggregator value used to return the fuzzy value.

## Examples

## Issues


## References
For the *token list specification* see description [tokenList.md](/languageSpecification/tokenList.md) file.
