# Create Fuzzy Set Model instruction

Allows for defining a new multigrade fuzzy set model.

It is possible to define derived degrees and validating constraint.

It is also define how to calculate the basic NOT, AND and OR operators according to the predicates:

• NOT x
• x AND y   
• x OR y

Where x is the actual multigrade fuzzyset and y is another multigrade fuzzy set of the same type. For further operators a generic FUZZY EVALUATOR must be used.

## EBNF Notation
    createFuzzySetModel ::= CREATE FUZZY SET MODEL id¹
                                DEGREES (id²)**
                                [DERIVED DEGREES (id³ AS expression)**]
                                [CONSTRAINT condition⁴]
                                ( OPERATOR (NOT | AND | OR)
                                  ( EVALUATE id⁴ AS expression )+ )* ;

## Syntax Diagram
![CreateFuzzySetModel instruction Syntax!](/languageSpecification/.assets/images/create_fuzzy_set_model.jpg "Create Fuzzy Set Model Syntax Diagram") 

## Semantics
* The `id¹` token represents the name of the new multigrade fuzzy set model.
* The `id²` token represents the independent degree name.
* The `id³` token represents the derived degree name with calculating expression.
* The `condition⁴` token represents the constraint that must be held for valid multigrade degree.
* The `id⁴` token represents the independent degree name.
* Multiple independent degrees can be defined, separated by commas.
* Optional derived degrees can be calculated from independent degrees using expressions.
* Optional constraint validates the consistency of the multigrade fuzzy set.
* Optional operator definitions specify how NOT, AND, and OR operations work for this model.

## Examples
      CREATE FUZZY SET MODEL TemperatureModel
          DEGREES cold, warm, hot
          CONSTRAINT (cold + warm + hot = 1)
          OPERATOR NOT
              EVALUATE cold AS 1 - cold
              EVALUATE warm AS 1 - warm  
              EVALUATE hot AS 1 - hot;
              
      CREATE FUZZY SET MODEL WeatherModel
          DEGREES sunny, cloudy
          DERIVED DEGREES rainy AS 1 - (sunny + cloudy)
          CONSTRAINT (sunny + cloudy + rainy = 1);

## Issues

## References
For the *token list specification* see description [tokenList.md](/languageSpecification/tokenList.md) file.
