# The J-Co Query Language Specification

The J-Co QueryLanguage Plus (JCoQL+) is developed in Java using the ANTLR package.  
The following specification describes the syntax and semantics of the JCoQL+, version 4.0.10, 
using both [EBNF Notation](https://en.wikipedia.org/wiki/Extended_Backus%E2%80%93Naur_form) 
and a [Syntax Diagrams](https://en.wikipedia.org/wiki/Syntax_diagram). 

A JCoQL+ script is a list of the following JCoQL+ instructions:
| Instruction | Description |
| -------- | ----------- | 
| **I/O instructions** | |
| [Use DB](/languageSpecification//useDb.md) | Allows to specify which no-SQL repository(ies) to use to get or save collections of documents   |
| [Get Collection](/languageSpecification/getCollection.md) | Retrieves a collection of documents from a repository or from the Internet   | 
| [Get Dictionary](/languageSpecification/getDictionary.md) | Retrieves a dictionary from a repository in order to perfom the **Translate** function (see [GenerateAction](/languageSpecification/generateAction.md))   | 							
| [Save As](/languageSpecification/saveAs.md) | Saves a collection of documents in a repository    |  
| **Menaging Collection** | | 
| [Merge Collections](/languageSpecification/mergeCollections.md) | Merges two or more collections into a single one    | 
| [Intersect Collections](/languageSpecification/intersectCollections.md) | Creates a new collection as the set intersection of two collections   |
| [Subtract Collections](/languageSpecification/subtractCollections.md) | Creates a new collection as the set subtraction of two collections    | 
| **Filter and Trasformation** | | 
| [Filter](/languageSpecification/filter.md) | Filters and transforms documents in the current collection |  
| [Join Of Collections](/languageSpecification/joinOfCollections.md) |  Joins two collections of documents in order to create a new one   |
| **Grouping and Expanding** | |
| [Group](/languageSpecification/group.md) |   Groups documents in the current collection    |
| [Expand](/languageSpecification/expand.md) |  Expands documents with array fields in the current collection       |  
| **External Lenguage Integration**    |
| [Create JavaScript Function](/languageSpecification/createJavaScriptFunction.md) |  Allows to include a **Javascript function script**    |
| [Create Java Function](/languageSpecification/createJavaFunction.md) |  Allows to include a **Java function script**    |
| **Classical Fuzzy Handling** | |
|	[Create Fuzzy Evaluator](/languageSpecification/createFuzzyEvaluator.md) | Defines rules to evaluate Fuzzy Expressions |
|	[Create Fuzzy Operator](/languageSpecification/createFuzzyOperator.md) | Allows to define a Fuzzy Set Operator |
|	[Create Fuzzy Aggregator](/languageSpecification/createFuzzyAggregator.md) |Allows to define a Fuzzy Set Aggregator |
| **Advanced Fuzzy Handling** ||
| [Create Fuzzy Set Model](/languageSpecification/createFuzzySetModel.md) | Defines a multi-grade fuzzy set   |
| [Create generic Fuzzy Set Evaluator](/languageSpecification/createGenericFuzzySetEvaluator.md) | Defines rules to evaluate multi-grade fuzzy expressions   |
| [Create generic Fuzzy Set Operator](/languageSpecification/createGenericFuzzySetOperator.md) | Defines rules to evaluate multi-grade fuzzy operations   |

Here is the complete [EBNF specification of the JCo Query Language](/languageSpecification/JCoQL.g) according to the [ANTLR notation](https://www.antlr.org/).  
Here is the description of all [_reserved words_, _symbols_ and _punctuation_](/languageSpecification/tokenList.md).

** Page currently missing
