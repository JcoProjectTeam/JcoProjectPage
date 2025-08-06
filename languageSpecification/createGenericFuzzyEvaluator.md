# Create Generic Fuzzy Evaluator instruction

Allows to define fuzzy evaluators according to a specific multi-grade fuzzy set model defined in advance.

It works similarly to the previous CREATE FUZZY EVALUATOR, evaluating at the end each independent degree of the specified multi-grade fuzzy set model.

There must be present an EVALUATE clause for each independent degree defined in the specified multi-grade fuzzy set model.

Once calculated, independent degrees must satisfy the constraint of the multi-grade fuzzy set model.

## EBNF Notation
    createGenericFuzzyEvaluator ::= CREATE id¹ FUZZY EVALUATOR id² 
                                        PARAMETERS param**
                                        [PRECONDITION condition]
                                        ( arraySortClause
                                        | deriveClause  
                                        | forAllClause )*
                                        ( EVALUATE id¹ AS expression
                                            [POLYLINE '[' 
                                                ( '(' n¹, n² ')' )++
                                                ']' 
                                            ]*  
                                        )+
                                                ;

## Syntax Diagram
![CreateGenericFuzzyEvaluator instruction Syntax!](/languageSpecification/.assets/images/create_generic_fuzzy_evaluator.jpg "Create Generic Fuzzy Evaluator Syntax Diagram") 

## Semantics
* The `id¹` token represents the fuzzy set model. Must be declared before.
* The `id²` token represents the evaluator name.
* The `param` token specifies the parameter, or the list of parameters, that the evaluator accepts.
* The optional `condition` token, if present, defines a preliminary condition that must be true before the evaluator is executed.
* The optional `arraySortClause`, `deriveClause`, and `forAllClause` provide additional processing capabilities.
* Multiple `EVALUATE` clauses must be present, one for each independent degree defined in the multi-grade fuzzy set model.
* The optional `POLYLINE` clause defines the transformation function for the evaluation result.
* The evaluator works with non-dot notation for parameters.

## Examples
      CREATE TemperatureModel FUZZY EVALUATOR TempEval 
          PARAMETERS temp TYPE FLOAT
          EVALUATE cold AS (30 - temp) / 10
          EVALUATE warm AS 1 - ABS(temp - 25) / 15
          EVALUATE hot AS (temp - 20) / 15;

## Issues

## References
For the *token list specification* see description [tokenList.md](/languageSpecification/tokenList.md) file.
