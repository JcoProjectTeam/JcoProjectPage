# Save As instruction
Allows to save the *current collection*:
 1. in the Intermediate Results database;
 2. in a NoSQL repository previuosly declared by means of the [Use DB](/languageSpecification/useDb.md) instruction.


## EBNF Notation
    saveAs ::= SAVE AS ID ( AT ID )? SC


## Syntax Diagram
![SaveAs instruction Syntax!](/languageSpecification/assets/rules/saveAs.png "SAVE AS Syntax Diagram") 


## Examples
 1. Save in the Intermediate Results databases:

        SAVE AS WeatherSensors;

 2. Save in a repository previously declared by means of the Use DB instruction:

        SAVE AS WeatherSensorMeasures@DATA_2021;


## Semantics
 * The 1st `ID` token represents the name under which the collection is saved.
 * If the 2nd `ID` token is present after the `AT`(@) character, it represents the repository database where to save the collection. Otherwise the collection is saved in the _Intermediate Results_ database.


## Issues
An exception error is raised in case *.2* if the DB is not previously declared by means of the  [Use DB](/languageSpecification/useDb.md) instruction.


## References
For the *token list specification* see description [tokenList.md](/languageSpecification/tokenList.md) file.
