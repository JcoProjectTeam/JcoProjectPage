# The J-Co Language Specification

The J-Co Language is developed in Java using the ANTLR package.  
The following specification describes the syntax and semantics of the J-Co langauge, 
using both [EBNF Notation](https://en.wikipedia.org/wiki/Extended_Backus%E2%80%93Naur_form) 
and a [Syntax Diagrams](https://en.wikipedia.org/wiki/Syntax_diagram). 

A J-Co language script is a list of the following Jco instructions.
| Instruction | Description |
| -------- | ----------- | 
| **I/O instructions** | |
| [Use DB](/languageSpecification//useDb.md) | Allows to specify which no-SQL repository(ies) to use to get or save collections of documents   |
| [Get Collection](/languageSpecification/getCollection.md) | Retrieves a collection of documents from a repository or from the Internet   | 
| [Get Dictionary](/languageSpecification/getDictionary.md) | Retrieves a dictionary from a repository in order to perfom the **Translate** function (see [GenerateAction](/languageSpecification/generateAction.md))   | 							
| [Save As](/languageSpecification/saveAs.md) | Saves a collection of documents in a repository    |  
| **Definition instructions** | |
|	[Create Fuzzy Operator](/languageSpecification/createFuzzyOperator.md) | Allows to define a **Fuzzy Operator**    |
| [Create JavaScript Function](/languageSpecification/createJavaScriptFunction.md) |  Allows to include a **Javascript function script**    |
| **Transformation instructions** | |
| [Filter](/languageSpecification/filter.md) | Filters and transforms documents in the current collection |  
| [Group](/languageSpecification/group.md) |   Groups documents in the current collection    |
| [Expand](/languageSpecification/expand.md) |  Expands documents with array fields in the current collection       |  
| **Associative instructions** | | 
| [Join Of Collections](/languageSpecification/joinOfCollections.md) |  Joins two collections of documents in order to create a new one   |
| [Merge Collections](/languageSpecification/mergeCollections.md) | Merges two or more collections into a single one    | 
| [Intersect Collections](/languageSpecification/intersectCollections.md) | Creates a new collection as the set intersection of two collections   |
| [Subtract Collections](/languageSpecification/subtractCollections.md) | Creates a new collection as the set subtraction of two collections    | 
| **Spatial instructions** ||
| [Spatial Join Of Collections](/languageSpecification/spatialJoin.md) | Joins two collections of documents according to their spatial fields in order to create a new one    |

Here is the complete [EBNF specification of the Jco Language](/languageSpecification/GecoLanguage.bnf).  
Here is the description of all [_reserved words_, _symbols_ and _punctuation_](/languageSpecification/tokenList.md).
