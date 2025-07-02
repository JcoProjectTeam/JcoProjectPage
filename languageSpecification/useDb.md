# Use DB instruction
Allows to specify which no-SQL repository(ies) to use by the [Get Collection](/languageSpecification/getCollection.md), [Save As](/languageSpecification/saveAs.md) or [Get Dictionary](/languageSpecification/getDictionary.md) instructions.


## EBNF Notation
	useDb ::= USE DB (id¹ | apex_value) [AS (id² | apex_value)] 
        		( COMMA DB (id¹ | apex_value) [AS (id² | apex_value)] )*
		    ON ( DEFAULT SERVER 
		       | SERVER (id³ | apex_value) [ (id⁴ | apex_value)] )
		    SC
  

## Syntax Diagram
![UseDb instruction Syntax!](/languageSpecification/.assets/images/use_db.jpg "Use DB Syntax Diagram") 


## Semantics
With a Use DB instruction can be declared more NoSQL Databases from the same server.  
* The `id¹` specifies the name of the Database to be used
* The `id²`specifies the alias of the name of the database specified in `id¹`
* The `id³` specifies the server name where the database is contained
* The `id³` specifies the server url where the database is contained


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

