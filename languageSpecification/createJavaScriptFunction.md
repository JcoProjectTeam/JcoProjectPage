# Create JavaScript Function instruction

Create a Javascript function that returns a value from parameters.


## EBNF Notation
    createJavaScriptFunction ::= CREATE JAVASCRIPT FUNCTION id¹ 
                                    PARAMETERS parameter**
                                    [PRECONDITION condition]
                                    BODY
                                        functionScript
                                    END BODY 
                                ;

## Syntax Diagram
![Create JavaScript Function instruction Syntax!](/languageSpecification/.assets/images/create_javascript_function.jpg "Create JavaScript Function Syntax Diagram") 


## Semantics

* The `id¹` token represents the name assigned to the JavaScript function to create.
* The `parameter` token specifies the parameter, or the list of parameters, that the function accepts. See [parameterRule](./subclauses/parameterRule.md ) for parameter declaration syntax.
* The optional `condition` token (see [Base Elements](./notation/baseElements.md)), if present, defines a preliminary condition that must be true before the function is executed.
* The `functionScript` token, located between `BODY` and `END BODY`, contains the JavaScript code for the function.


## Examples

    CREATE JAVASCRIPT FUNCTION CalculateSum PARAMETERS num1, num2 BODY return num1 + num2; END BODY;
    CREATE JAVASCRIPT FUNCTION CheckAdultAge PARAMETERS age PRECONDITION age >= 0 BODY if (age >= 18) return true; else return false; END BODY;

## Issues


## References
For the *token list specification* see description [tokenList.md](/languageSpecification/tokenList.md) file.
