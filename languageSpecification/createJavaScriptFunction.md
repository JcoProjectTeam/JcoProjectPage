# Create JavaScript Function instruction

Create a Javascript function that returns a value from parameters.


## EBNF Notation
    createJavaScriptFunction ::= CREATE JAVASCRIPT FUNCTION ID¹ 
                                    PARAMETERS param**
                                    [PRECONDITION condition]
                                    BODY
                                        functionScript
                                    END BODY 
                                SC

## Syntax Diagram
![Create JavaScript Function instruction Syntax!](/languageSpecification/.assets/images/create_javascript_function.jpg "Create JavaScript Function Syntax Diagram") 


## Semantics
    * The 'ID¹' token represent the name assigned at the Javascript funtion to create
    * The 'param' token specify the parameter, or the list of parameter, that the function accept
    * The 'condition' token if is present, define a preliminary condition that must be true before the execution of the function
    * the 'functionScript' token between 'BODY' and 'END BODY', contains the Javascript code of the function

## Examples

1. CREATE JAVASCRIPT FUNCTION CalculateSum PARAMETERS num1, num2 BODY return num1 + num2; END BODY;
2. CREATE JAVASCRIPT FUNCTION CheckAdultAge PARAMETERS age PRECONDITION age >= 0 BODY if (age >= 18) return true; else return false; END BODY;

## Issues


## References
For the *token list specification* see description [tokenList.md](/languageSpecification/tokenList.md) file.
