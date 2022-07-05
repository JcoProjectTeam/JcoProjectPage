# Get Dictionary instruction
Retrieves a dictionary from a NoSQL repository in order to perfom the  the **TRANSLATE** function (see [GenerateAction](/languageSpecification/generateAction.md)).


## EBNF Notation
    getDictionary ::= GET DICTIONARY ID AT ID AS ID SC 


## Syntax Diagram
![GetDictionary instruction Syntax!](/languageSpecification/assets/rules/getDictionary.png "Get Dictionary Syntax Diagram") 


## Semantics
 * The 1st `ID` token represents a collection in a NoSQL repository;
 * The 2nd `ID` token, after the `AT`(@) character, represents a NoSQL repository (that should be previously declared by means of the [Use DB](/languageSpecification/useDb.md) instruction);
 * The 3rd `ID` token, after the `AS` keyword, represents the _logical name_ by means the dictionary can be subsequently referenced. 


## Examples
    GET DICTIONARY Dictionary@testDb AS myDictionary;


## Issues
A dictionary is a collection of items where each item is a couple _(key, value)_.   
Every JSON collection of documents can represent a dictionary. A document can represent a dictionary item if it holds two _String fields_ named `key` and `value`. Every other field is ignored.   
If two or more Get Dictionary instructions declare the same dictionary _logical name_, the latest one substitute the previous ones.  
The _keys_ are case-sensitive.  
If two or more dictionary items share the same `key`, only the last loaded `value` is taken. No loading order is guaranteed.  
Contextually to each dictionary loading, a second different dictionary with case-unsensitive _keys_ is loaded. Thus, if two or more items share the same `key`, only the last loaded `value` is taken. No loading order is guaranteed.     


## References
For the *token list specification* see description [tokenList.md](/languageSpecification/tokenList.md) file.

