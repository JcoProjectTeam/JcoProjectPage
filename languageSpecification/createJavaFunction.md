
# Create Java Function instruction

Create a Java function that returns a value from parameters.

## EBNF Notation
    createJavaFunction ::= CREATE JAVA FUNCTION id¹ 
                              PARAMETERS parameter**
                              [PRECONDITION condition]
                              CLASS id²
                              [IMPORT " classPath "]
                              CLASS BODY
                                  javaCode
                              END_BODY ;

## Syntax Diagram
![Create Java Function instruction Syntax!](/languageSpecification/.assets/images/create_java_function.jpg "Create Java Function Syntax Diagram")  

## Semantics
* The `id¹` token represents the name assigned to the Java function to create.
* The `parameter` token specifies the parameter, or the list of parameters, that the function accepts.
* The optional `condition` token, if present, defines a preliminary condition that must be true before the function is executed.
* The `id²` token specifies the Java class name.
* The optional `IMPORT` clause allows importing external Java classes.
* The `javaCode` token, located between `CLASS BODY` and `END_BODY`, contains the Java code for the function implementation.

## Examples
    CREATE JAVA FUNCTION CalculateSum 
        PARAMETERS num1 TYPE INT, num2 TYPE INT 
        CLASS MathUtils 
        CLASS BODY 
            public int CalculateSum(int num1, int num2) { return num1 + num2; }
        END_BODY;

    CREATE JAVA FUNCTION CheckAdultAge 
        PARAMETERS age TYPE INT 
        PRECONDITION age >= 0 
        CLASS PersonUtils 
        IMPORT "com.example.Person" 
        CLASS BODY 
            public boolean CheckAdultAge(int age) { return age >= 18; }
        END_BODY;

## Issues

## References
For the *token list specification* see description [tokenList.md](/languageSpecification/tokenList.md) file.
