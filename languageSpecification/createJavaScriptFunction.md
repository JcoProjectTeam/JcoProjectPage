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
* The `parameter` token specifies the parameter, or the list of parameters, that the function accepts. See [parameterRule](./subClauses/parameterRule.md) for parameter declaration syntax. **Note:** Parameters do NOT use dot notation - they are simple identifiers (e.g., `x TYPE FLOAT`, not `.x TYPE FLOAT`).
* The optional `condition` token (see [Base Elements](./notation/baseElements.md)), if present, defines a preliminary condition that must be true before the function is executed.
* The `functionScript` token, located between `BODY` and `END BODY`, contains the JavaScript code for the function.


## Examples

    CREATE JAVASCRIPT FUNCTION CalculateSum 
        PARAMETERS num1 TYPE FLOAT, num2 TYPE FLOAT 
        BODY return num1 + num2; END BODY;
        
    CREATE JAVASCRIPT FUNCTION CheckAdultAge 
        PARAMETERS age TYPE INT 
        PRECONDITION age >= 0 
        BODY if (age >= 18) return true; else return false; END BODY;

**Note:** Parameter names (num1, num2, age) do NOT use dot notation. They are simple identifiers that will be used as variable names in the function body.

## Issues


## References
For the *token list specification* see description [tokenList.md](/languageSpecification/tokenList.md) file.
