# Save As instruction
Allows to save the *current collection*:
 1. in the Intermediate Results database;
 2. in a NoSQL repository previuosly declared by means of the [Use DB](/languageSpecification/useDb.md) instruction.


## EBNF Notation
    saveAs ::= SAVE AS id¹ [ @ id² ] ;


## Syntax Diagram
![SaveAs instruction Syntax!](/languageSpecification/.assets/images/save_as.jpg "Group Syntax Diagram") 


## Examples
 1. Save in the Intermediate Results databases:

        SAVE AS WeatherSensors;

 2. Save in a repository previously declared by means of the Use DB instruction:

        SAVE AS WeatherSensorMeasures@DATA_2021;


## Semantics
 * The `id¹` token represents the name under which the collection is saved.
 * The `id²` token if is present after the `AT`(@) character, it represents the repository database where to save the collection. Otherwise the collection is saved in the _Intermediate Results_ database.


## Issues
An exception error is raised in case *.2* if the DB is not previously declared by means of the  [Use DB](/languageSpecification/useDb.md) instruction.


## References
For the *token list specification* see description [tokenList.md](/languageSpecification/tokenList.md) file.
