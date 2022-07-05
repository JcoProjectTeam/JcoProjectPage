# Use DB instruction
Allows to specify which no-SQL repository(ies) to use by the [Get Collection](/languageSpecification/getCollection.md), [Save As](/languageSpecification/saveAs.md) or [Get Dictionary](/languageSpecification/getDictionary.md) instructions.


## EBNF Notation
	useDb ::= USE DB (ID | APEX_VALUE) (AS (ID | APEX_VALUE))? 
        		( COMMA DB (ID | APEX_VALUE) (AS (ID | APEX_VALUE))? )*
		    ON ( DEFAULT SERVER 
		       | SERVER (ID | APEX_VALUE) ( (ID | APEX_VALUE))? )
		    SC
  

## Syntax Diagram
![UseDb instruction Syntax!](/languageSpecification/assets/rules/useDb.png "Use DB Syntax Diagram") 


## Semantics
With a Use DB instruction can be declared more NoSQL Databases from the same server.  
A database name can be and `ID` or `APEX_VALUE`, and it is possible to associate to it an alias after the `AS` keyword.  
A server can be the one from `DEFAULT` (defined in the properties of the J-Co platform), or defined by a logical name followed, possibly, by the address to retrieve it.


## Examples
	USE DB JCoTestDb, DB 'JCoDataBase2' AS myDb  
		ON SERVER MongoDB 'http://127.0.0.1:27017';

	USE DB Test  
		ON SERVER jcods 'http://127.0.0.1:17017';

	USE DB sourceDb, DB targetDb  
		ON DEFAULT SERVER;
  

## Issues
An exception error is raised in case the same DB is specified two or more times.


## References
For the *token list specification* see description [tokenList.md](/languageSpecification/tokenList.md) file.

