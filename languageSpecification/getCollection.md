# Get Collection instruction
Substitutes the *current collection* with a new collection retrieved:
 1. from the Intermediate Results database;
 2. from a NoSQL repository previuosly declared by means of the [Use DB](/languageSpecification/useDb.md) instruction;
 3. from the Internet.  



## EBNF Notation
    getCollection ::= GET COLLECTION ( ID ( AT ID )?  
                              	     | FROM WEB ( APEX_VALUE | QUOTED_VALUE ) )
                       SC 


## Syntax Diagram
![GetCollection instruction Syntax!](/languageSpecification/assets/rules/getCollection.png "Get Collection Syntax Diagram") 


## Semantics
 * If the 1st `ID` token is present, it represents the name of the collection to retrieve.
 * If the 2nd `ID` token is present after the `AT`(@) character, it represents the logical name of the database from which retrieve the collection. Otherwise the collection is retrieved from the Intermediate Results database.
 * If the `FROM WEB` alternative is present, the following `APEX_VALUE` or `QUOTED_VALUE` represents the _URL_ string to retrieve the collection from the Internet.


## Examples
 1. From the Intermediate Results databases:

        GET COLLECTION  WeatherSensors;

 2. From a repository previously declared by means of the Use DB instruction:

        GET COLLECTION  WeatherSensorMeasures@DATA_2021;

 3. From the Internet:

        GET COLLECTION FROM WEB 
            "https://www.dati.lombardia.it/resource/nf78-nj6b.json?$limit=1000000&$where=storico<>'S'";


## Issues
In case the collection cannot be retrieved an empty collection is returned.  
An exception error is raised in case *.2* if the DB is not previously declared by means of the  [Use DB](/languageSpecification/useDb.md) instruction.


## References
For the *token list specification* see description [tokenList.md](/languageSpecification/tokenList.md) file.

