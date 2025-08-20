# Create Generic Fuzzy Operator instruction

Allows to define generic fuzzy operators for multi-grade fuzzy set models.

A generic fuzzy operator can be used to implement custom NOT, AND, OR, or other operators for fuzzy sets of the same type, using user-defined expressions and parameters.

## EBNF Notation
    createGenericFuzzyOperator ::= CREATE id¹ FUZZY OPERATOR id² 
                                      PARAMETERS param++
                                      [PRECONDITION condition]
                                      ( EVALUATE id³ AS expression
                                          [POLYLINE '[' 
                                          ( '(' n¹, n² ')' )++ 
                                          ']' ] 
                                        )+ 
                                    ;

## Syntax Diagram
![CreateGenericFuzzyOperator instruction Syntax!](/languageSpecification/.assets/images/create_generic_fuzzy_operator.jpg "Create Generic Fuzzy Operator Syntax Diagram") 

## Semantics
* The `id¹` token represents the fuzzy set model (must be declared before).
* The `id²` token represents the operator name.
* The `param` token specifies the parameter, or the list of parameters, that the operator accepts.
* The optional `condition` token, if present, defines a preliminary condition that must be true before the operator is executed.
* Multiple `EVALUATE` clauses can be present, one for each operator or degree.
* The optional `POLYLINE` clause defines the transformation function for the operator result.
* The operator works with non-dot notation for parameters.

## Examples
      CREATE TemperatureModel FUZZY OPERATOR NotTemp
          PARAMETERS temp TYPE FLOAT
          EVALUATE cold AS 1 - cold
          EVALUATE warm AS 1 - warm
          EVALUATE hot AS 1 - hot;

      CREATE WeatherModel FUZZY OPERATOR AndWeather
          PARAMETERS sunny TYPE FLOAT, cloudy TYPE FLOAT
          EVALUATE rainy AS sunny * cloudy;

## Issues

## References
For the *token list specification* see description [tokenList.md](/languageSpecification/tokenList.md) file.
