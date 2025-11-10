# Filter instruction

Filters and/or transforms documents in the current collection.

The FILTER instruction allows you to select documents based on conditions and optionally transform them using generation rules.

## EBNF Notation

    filter ::=  FILTER 
                (
                    (CASES | CASE) 
                        (WHERE condition [generateSection] )+  
                        [(KEEP | DROP) OTHERS]
                |  generateSection
                )
                [REMOVE DUPLICATES] ;

## Syntax Diagram
![Filter instruction Syntax!](/languageSpecification/.assets/images/filter.jpg "Filter Syntax Diagram") 

## Semantics

* The `FILTER` instruction selects and optionally transforms documents from the current collection according to one or more conditional clauses.
* The `condition` token defines the logical or fuzzy expression used to match documents (see [Base Elements](./notation/baseElements.md)).
* The optional `generateSection` (see [Base Elements](./notation/baseElements.md)) clause can transform matching documents by:
  - Building new document structures
  - Adding or removing fields
  - Applying geometric transformations
  - Managing fuzzy sets
  
* Multiple `WHERE` clauses can be specified to define different filtering/transformation rules.
* The optional `(KEEP | DROP) OTHERS` clause determines what happens to documents that don't match any WHERE condition:
  - `KEEP OTHERS`: Non-matching documents are kept in the result
  - `DROP OTHERS`: Non-matching documents are excluded from the result
* When only `generateSection` is specified (without WHERE clauses), the transformation applies to all documents in the collection.
* The optional `REMOVE DUPLICATES` clause eliminates duplicate documents from the result.
* The filtered/transformed collection becomes the new current collection.

## Examples

      FILTER CASE 
          WHERE (.score > 5) 
          KEEP OTHERS;

      FILTER CASE 
          WHERE (.category = "premium") 
              GENERATE BUILD {.id, .name, .discounted: .price * 0.9}
          WHERE (.category = "standard")
              GENERATE BUILD {.id, .name, .price}
          DROP OTHERS;

      FILTER CASE 
          WHERE (.active = TRUE AND .score IS NOT NULL) 
              GENERATE BUILD {.user, .normalized: .score / 100}
          KEEP OTHERS
          REMOVE DUPLICATES;

      FILTER GENERATE BUILD {.id, .name, .created};

## Issues

## References
For the *token list specification* see description [tokenList.md](/languageSpecification/tokenList.md) file.
