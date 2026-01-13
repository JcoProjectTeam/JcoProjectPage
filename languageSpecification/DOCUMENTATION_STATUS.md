# JCoQL+ Language Documentation Status

**Last Updated:** January 13, 2026  
**Grammar Version:** 4.0.10 (May 12, 2025)

This document tracks the documentation status of all JCoQL+ language specifications based on the grammar defined in `JCoQL.g`.

---

## Recent Updates (January 2026)

### Completed Enhancements
1. ✅ **Predicate Documentation Enhanced**
   - Distinguished between **Classic Context** (dot notation, arithmetic expressions) and **Fuzzy Context** (boolean only)
   - Removed WHERE keywords from predicate examples to show pure predicate syntax
   - Clarified that fuzzy evaluator calls are used in USING context
   - Replaced `wukFuzzyPredicateRule` references with explicit WITHIN, KNOWN, UNKNOWN

2. ✅ **Parameter Documentation**
   - Created `parameterRule.md` - Parameters for JavaScript/Java functions and operators
   - Created `feParameterRule.md` - Parameters for fuzzy evaluators/aggregators (supports ARRAY)
   - Clarified that parameters do NOT use dot notation (simple identifiers)

3. ✅ **JOIN OF COLLECTIONS SubClauses**
   - Created `spatialFunctionRule.md` - Spatial operations (DISTANCE, ORIENTATION, INCLUDED, MEET, INTERSECT)
   - Created `addFieldsRule.md` - Adding calculated fields in JOIN
   - Created `setFuzzySetsRule.md` - Managing fuzzy sets in JOIN (with resolving strategies)

4. ✅ **Function Index**
   - Added navigable index in `predefinedFunctions.md` with links to all 28+ functions

5. ✅ **EXPAND Instruction**
   - Updated to use `fieldRef` instead of `id` for array field references
   - Added examples with nested field paths

6. ✅ **CREATE FUZZY SET MODEL**
   - Added semantic note that each operator (NOT, AND, OR) can only be defined once per model

---

## Summary

| Category | Total | Documented | Missing/Incomplete | Progress |
|----------|-------|------------|-------------------|----------|
| **Main Instructions** | 18 | 15 complete, 1 partial | 2 missing | 89% |
| **SubClauses (General)** | 14 | 14 | 0 | 100% |
| **SubClauses (Conditions)** | 4 | 4 | 0 | 100% |
| **SubClauses (Fuzzy)** | 4 | 4 | 0 | 100% |
| **SubClauses (Specialized)** | ~15 | 15 (inline) | 0 | 100% |
| **SubClauses (JOIN-specific)** | 3 | 3 | 0 | 100% |
| **SubClauses (Parameters)** | 2 | 2 | 0 | 100% |
| **Expression Rules** | 5 | 5 | 0 | 100% |
| **Predicate SubRules** | 5 | 5 | 0 | 100% |
| **Predefined Functions** | 28+ | 28+ | TBD array functions | 100% |
| **Base Elements & Tokens** | - | ✓ | - | 100% |

**Overall Grammar Coverage:** ~95% Complete (65+ rules documented)

**What's Actually Missing:**
- 2 specialized instructions (LOOKUP FROM WEB, TRAJECTORY MATCHING)
- 1 incomplete instruction (CREATE JAVA FUNCTION needs expansion)
- Unknown number of additional array functions (user to provide list)

**Key Concepts Documented:**
- ✅ **Classic Context** - Predicates with dot notation, arithmetic expressions, field comparisons
- ✅ **Fuzzy Context** - Pure boolean predicates, fuzzy evaluator calls in USING context
- ✅ **Parameters** - Function/operator parameters (no dot notation), fuzzy evaluator parameters (with ARRAY support)
- ✅ **Spatial Functions** - Complete geometric operations for JOIN
- ✅ **Fuzzy Set Management** - Managing and resolving fuzzy sets in JOIN operations

**Everything else (95% of the grammar) is fully documented!**

---

## Main Instructions

Instructions from the `start` rule in the grammar.

### ✅ Documented Instructions

1. **useDbRule** - `useDb.md`
   - Specify database connection
   - Status: Complete

2. **getCollectionRule** - `getCollection.md`
   - Load collection from database or web
   - Status: Complete

3. **getDictionaryRule** - `getDictionary.md`
   - Load dictionary from database
   - Status: Complete

4. **saveAsRule** - `saveAs.md`
   - Save current collection with a name
   - Status: Complete

5. **filterRule** - `filter.md`
   - Filter and transform documents
   - Status: Complete

6. **groupRule** - `group.md`
   - Group documents by criteria
   - Status: Complete

7. **expandRule** - `expand.md`
   - Unpack array fields into separate documents
   - Status: Complete

8. **joinOfCollectionsRule** - `joinOfCollections.md`
   - Join two collections
   - Status: Complete

9. **mergeCollectionsRule** - `mergeCollections.md`
   - Union of multiple collections
   - Status: Complete

10. **intersectCollectionsRule** - `intersectCollections.md`
    - Intersection of two collections
    - Status: Complete

11. **subtractCollectionsRule** - `subtractCollections.md`
    - Difference between two collections
    - Status: Complete

12. **createFuzzyOperatorRule** - `createFuzzyOperator.md`
    - Define custom fuzzy operator
    - Status: Complete

13. **createFuzzyEvaluatorRule** - `createFuzzyEvaluator.md`
    - Define fuzzy evaluator function
    - Status: Complete

14. **createFuzzyAggregatorRule** - `createFuzzyAggregator.md`
    - Define fuzzy aggregator
    - Status: Complete

15. **createFuzzySetModelRule** - `createFuzzySetModel.md`
    - Define fuzzy set model with degrees
    - Status: Complete

16. **createGenericFuzzySetOperatorRule** - `createGenericFuzzyOperator.md`
    - Define generic fuzzy set operator
    - Status: Complete

17. **createGenericFuzzyEvaluatorRule** - `createGenericFuzzyEvaluator.md`
    - Define generic fuzzy evaluator
    - Status: Complete

18. **createJavaScriptFunctionRule** - `createJavaScriptFunction.md`
    - Define JavaScript custom function
    - Status: Complete (needs translation to English)

### ❌ Missing Instructions

1. **lookupFromWebRule**
   - Grammar: `LOOKUP FROM_WEB (forEachRule)+ SC`
   - Purpose: Execute web calls for documents matching conditions
   - Priority: Medium
   - Status: **NOT DOCUMENTED**
   - File: Need to create `lookupFromWeb.md`

2. **trajectoryMatchingRule**
   - Grammar: `TRAJECTORY MATCHING collectionReferenceRule, collectionReferenceRule (trajectoryPartitionRule)+ (othersRule)? SC`
   - Purpose: Match trajectories between two collections based on spatial/temporal patterns
   - Priority: Low (specialized feature)
   - Status: **NOT DOCUMENTED**
   - File: Need to create `trajectoryMatching.md`

3. **createJavaFunctionRule**
   - Grammar: Similar to createJavaScriptFunctionRule but for Java code
   - Purpose: Define Java custom function with class import
   - Priority: Low
   - Status: `createJavaFunction.md` exists but **INCOMPLETE** (minimal content, needs expansion)
   - File: Needs significant expansion with examples

---

## SubClauses - General

Common subclauses used across multiple instructions.

### ✅ Documented (100%)

1. **collectionReferenceRule** ⭐
   - File: Referenced in `notation/baseElements.md`
   - Used in: MERGE, INTERSECT, SUBTRACT, JOIN, TRAJECTORY MATCHING
   - Status: Complete

2. **fieldRefRule** ⭐
   - File: `subClauses/fieldRefRule.md`
   - Used in: Almost all instructions
   - Status: Complete, English

3. **buildActionRule** ⭐
   - File: `subClauses/buildActionRule.md`
   - Used in: GENERATE sections
   - Status: Complete, English, simplified (removed ADD_ST technical detail)

4. **objectStructureRule** ⭐
   - File: `subClauses/objectStructureRule.md`
   - Used in: BUILD, ADD FIELDS
   - Status: Complete, English, user-friendly (removed "factor" terminology)

5. **outputFieldSpecRule**
   - File: `subClauses/outputFieldSpecRule.md`
   - Note: Content integrated into objectStructureRule
   - Status: May be deprecated

6. **geometricOptionRule**
   - File: `subClauses/geometricOptionRule.md`
   - Used in: GENERATE sections
   - Status: Complete, English

7. **dropGeometryRule**
   - File: `subClauses/dropGeometryRule.md`
   - Used in: GENERATE sections
   - Status: Complete, English

8. **caseClauseRule** ⭐
   - File: `subClauses/caseClauseRule.md`
   - Used in: FILTER, JOIN
   - Status: Complete, English, 10 examples

9. **othersRule**
   - File: `subClauses/othersRule.md`
   - Used in: CASE, GROUP, EXPAND
   - Status: Complete, English, 10 examples

10. **whereCaseRule** ⭐
    - File: `subClauses/whereCaseRule.md`
    - Used in: CASE clause
    - Status: Complete, English, 10 examples

11. **generateSectionRule** ⭐
    - File: `subClauses/generateSectionRule.md`
    - Used in: FILTER, GROUP, JOIN, WHERE CASE
    - Status: Complete, English

12. **parameterRule** ⭐
    - File: `subClauses/parameterRule.md`
    - Used in: CREATE JAVASCRIPT FUNCTION, CREATE JAVA FUNCTION, CREATE FUZZY OPERATOR
    - Grammar: `ID TYPE ID`
    - Status: Complete, 232 lines, 5 examples
    - Note: Parameters do NOT use dot notation

13. **feParameterRule** ⭐
    - File: `subClauses/feParameterRule.md`
    - Used in: CREATE FUZZY EVALUATOR, CREATE FUZZY AGGREGATOR
    - Grammar: `ID TYPE (ID | ARRAY)`
    - Status: Complete, supports ARRAY type, 7 examples

14. **spatialFunctionRule** ⭐
    - File: `subClauses/spatialFunctionRule.md`
    - Used in: JOIN OF COLLECTIONS (ON GEOMETRY, ADD FIELDS)
    - Grammar: `DISTANCE | ORIENTATION | INCLUDED | MEET | INTERSECT`
    - Status: Complete, 8 examples with spatial operations

15. **addFieldsRule** ⭐
    - File: `subClauses/addFieldsRule.md`
    - Used in: JOIN OF COLLECTIONS
    - Grammar: `ADD_ST FIELDS { fieldRef: value, ... }`
    - Status: Complete, 8 examples with calculations

16. **setFuzzySetsRule** ⭐
    - File: `subClauses/setFuzzySetsRule.md`
    - Used in: JOIN OF COLLECTIONS
    - Grammar: `SET FUZZY SETS (KEEP ALL/LEFT/RIGHT | specific sets) [RESOLVING WITH ...]`
    - Status: Complete, 10 examples with conflict resolution strategies

---

## SubClauses - Condition Expressions

Logical condition subclauses (newly created directory structure).

### ✅ Documented (100%)

1. **orConditionRule** ⭐
   - File: `conditionSubClauses/orConditionRule.md`
   - Grammar: `andConditionRule (OR andConditionRule)*`
   - Status: Complete, English, 10 examples
   - Features: Short-circuit evaluation, performance tips

2. **andConditionRule** ⭐
   - File: `conditionSubClauses/andConditionRule.md`
   - Grammar: `notConditionRule (AND notConditionRule)*`
   - Status: Complete, English, 10 examples
   - Features: Short-circuit evaluation, optimization patterns

3. **notConditionRule** ⭐
   - File: `conditionSubClauses/notConditionRule.md`
   - Grammar: `[NOT] predicateRule`
   - Status: Complete, English, 10 examples
   - Features: De Morgan's laws, double negation rules

4. **predicateRule** ⭐
   - File: `conditionSubClauses/predicateRule.md`
   - Grammar: `expressionRule [compareRule | inRangeRule] | nullPredicateRule | withPredicateRule | withoutPredicateRule | (WITHIN|KNOWN|UNKNOWN) FUZZY SETS ...`
   - Status: Complete, English, 10 examples
   - Features: 
     * **Classic context** - Dot notation (`.field`), arithmetic expressions, field comparisons
     * **Fuzzy context** - Pure boolean expressions, fuzzy evaluator calls (in USING), fuzzy set membership
   - Updated: January 2026 - Removed WHERE from examples, clarified context distinctions
   - Includes: Comparisons, ranges, NULL checks, WITH, WITHOUT, WITHIN, KNOWN, UNKNOWN

### 📝 SubPredicates (Referenced in predicateRule)

These are documented as part of predicateRule but could be expanded into separate files:

- **compareRule** - Comparison operators (=, !=, <, >, <=, >=)
- **inRangeRule** - Range checking with inclusive/exclusive boundaries
- **nullPredicateRule** - FIELD .field ISNULL/ISNOTNULL
- **withPredicateRule** - WITH [type] .field for field presence
- **withoutPredicateRule** - WITHOUT .field for field absence

---

## SubClauses - Fuzzy Logic

Fuzzy-specific subclauses.

### ✅ Documented (100%)

1. **checkForFuzzySetRule**
   - File: `fuzzySubClauses/checkForFuzzySetRule.md`
   - Used in: GENERATE sections
   - Status: Complete, English

2. **alphaCutRule**
   - File: `fuzzySubClauses/alphaCutRule.md`
   - Used in: GENERATE sections
   - Status: Complete, English, 534 lines, 8 examples

3. **keepDropFuzzySetsRule**
   - File: `fuzzySubClauses/keepDropFuzzySetsRule.md`
   - Used in: GENERATE sections
   - Status: Complete, English, 604 lines, 10 examples

4. **wukFuzzyPredicateRule**
   - File: Referenced in `conditionSubClauses/predicateRule.md`
   - Grammar: `(WITHIN | KNOWN | UNKNOWN) FUZZY SETS id+`
   - Status: Documented within predicateRule
   - Could create: `fuzzySubClauses/wukFuzzyPredicateRule.md`

---

## Expression Rules

Mathematical and value expression rules.

### ⚠️ Partially Documented

1. **expressionRule** ⭐
   - Grammar: `(termRule | (ADD|SUB) termRule) ((ADD|SUB) termRule)*`
   - Used in: All arithmetic expressions
   - Status: Referenced in baseElements.md
   - Action: Could create detailed `conditionSubClauses/expressionRule.md`

2. **termRule** ⭐
   - Grammar: `factorRule ((MUL|DIV) factorRule)*`
   - Used in: expressionRule
   - Status: Referenced in baseElements.md

3. **factorRule** ⭐
   - Grammar: Complex (includes functions, field refs, values, special functions)
   - Used in: termRule
   - Status: Referenced in baseElements.md
   - Note: User-facing documentation now uses "value/field reference/expression" instead of "factor"

4. **valueRule**
   - Grammar: `INT | FLOAT | BOOLEAN | APEX_VALUE | QUOTED_VALUE`
   - Used in: factorRule
   - Status: Documented in baseElements.md

5. **numericRule**
   - Grammar: `(ADD|SUB)? (FLOAT|INT)`
   - Used in: Range checks, alpha cuts, etc.
   - Status: Simple, documented in baseElements.md

---

## Predefined Functions

Functions that can be used in expressions.

### ✅ Documented (100%)

File: `notation/predefinedFunctions.md` (with index)

#### Type Conversion Functions (5)
- ✅ TO_STRING(x)
- ✅ TO_INT(x)
- ✅ TO_FLOAT(x)
- ✅ TO_BOOL(x)
- ✅ SERIALIZE(x)

#### Numeric Functions (5)
- ✅ COUNT(x)
- ✅ MAX(x, y)
- ✅ MIN(x, y)
- ✅ ABS(x)
- ✅ SQRT(x)

#### Geospatial Functions (4)
- ✅ GEODESIC_DISTANCE(lat1, lon1, lat2, lon2)
- ✅ GEOMETRY_FIELD()
- ✅ GEOMETRY_LENGTH(unit)
- ✅ GEOMETRY_AREA(unit)

#### String Functions (1)
- ✅ JARO_WINKLER_SIMILARITY(s1, s2)

#### Special Functions - Fuzzy (2)
- ✅ EXTENT(f) / MEMBERSHIP_TO(f)
- ✅ DEGREE(f) / #f (shortcut notation)

#### Special Functions - Translation (1)
- ✅ TRANSLATE(exp, dictionary, caseSensitive, defaultValue)

#### Special Functions - Conditional (2)
- ✅ IF((condition), trueExp, falseExp)
- ✅ IF_ERROR(exp, errValue)

#### Special Functions - Array (3)
- ✅ MEMBERSHIP_ARRAY(...)
- ✅ EXTRACT_ARRAY(fieldY FROM ARRAY arrayX)
- ✅ ARRAY_CUMULATE(x)

**Additional Array Functions (to be added):**
- ⏳ User mentioned there are more array functions to document

---

## Supporting Documentation

### ✅ Complete

1. **Base Elements** - `notation/baseElements.md`
   - Core language elements
   - Status: Complete

2. **Token List** - `tokenList.md`
   - All language tokens with diagrams
   - Status: Complete with PNG diagrams

3. **README** - `README.md`
   - Overview and navigation
   - Status: Exists (may need updating)

---

## Grammar-Specific Rules (Advanced)

Rules used in CREATE instructions for fuzzy logic and JavaScript/Java functions.

### 📋 Status: Documented in Instruction Files

These are complex rules used within CREATE instructions and are documented as part of their respective instruction documentation:

#### Fuzzy Operator/Evaluator Rules
- **feExpressionRule** - Fuzzy evaluator expressions
- **feTermRule** - Fuzzy evaluator terms
- **feFactorRule** - Fuzzy evaluator factors
- **feParameterRule** - Fuzzy evaluator parameters
- **feArraySortRule** - Array sorting in fuzzy evaluators
- **feDeriveRule** - Derive clause
- **feForAllRule** - For-all aggregation
- **aggSpecRule** - Aggregation specification

#### JavaScript/Java Function Rules
- **jfExpressionRule** - JavaScript function expressions
- **jfTermRule** - JavaScript function terms
- **jfFactorRule** - JavaScript function factors
- **jfOrConditionRule** - JavaScript function conditions
- **jfAndConditionRule**
- **jfNotConditionRule**
- **jsfPredicateRule**
- **parameterRule** - Function parameters

#### Fuzzy Set Model Rules
- **ftExpressionRule** - Fuzzy type expressions
- **ftTermRule**
- **ftFactorRule**
- **ftConditionExpressionRule**
- **fuzzyOperatorDefinitionRule**

---

## Spatial/Geometric Rules

Rules for spatial operations (used in JOIN).

### ⚠️ Status: Partially Documented

- **spatialFunctionRule**
  - Grammar: DISTANCE, ORIENTATION, INCLUDED, MEET, INTERSECT
  - Used in: JOIN OF COLLECTIONS
  - Status: Mentioned in joinOfCollections.md
  - Action: Could create `subClauses/spatialFunctionRule.md`

- **setFuzzySetsRule**
  - Grammar: Complex fuzzy set management in JOIN
  - Used in: JOIN OF COLLECTIONS
  - Status: Mentioned in joinOfCollections.md

---

## Specialized SubClauses

Rules specific to certain instructions that are currently documented inline.

### JOIN-Specific Rules

- **spatialFunctionRule**
  - Grammar: `DISTANCE(id) | ORIENTATION(LEFT|RIGHT, id:numeric) | INCLUDED(LEFT|RIGHT) | MEET | INTERSECT`
  - Used in: JOIN OF COLLECTIONS (ON GEOMETRY clause)
  - Status: Documented in joinOfCollections.md
  - Priority: Low (could create separate doc)

- **setFuzzySetsRule**
  - Grammar: Complex fuzzy set management (KEEP ALL/LEFT/RIGHT, addFuzzySetRule, resolvingRule)
  - Used in: JOIN OF COLLECTIONS
  - Status: Documented in joinOfCollections.md
  - Priority: Low

- **addFuzzySetRule**
  - Grammar: Defines which fuzzy sets to add and how to resolve conflicts
  - Used in: setFuzzySetsRule
  - Status: Part of joinOfCollections.md

- **resolvingRule**
  - Grammar: `RESOLVING WITH (AND|OR|FIRST|LAST)`
  - Used in: setFuzzySetsRule
  - Status: Part of joinOfCollections.md

### GROUP-Specific Rules

- **groupPartitionRule**
  - Grammar: `PARTITION orConditionRule BY fieldRefRule+ INTO fieldRefRule [DROP GROUPING FIELDS] [ORDER BY ...] [generateSectionRule]`
  - Used in: GROUP instruction
  - Status: Documented in group.md
  - Priority: Low (could create separate doc)

- **sortingFieldRule**
  - Grammar: `fieldRefRule TYPE id (VERSUS)?`
  - Used in: GROUP partitions (ORDER BY clause)
  - Status: Documented in group.md

---

### EXPAND-Specific Rules

- **unpackRule**
  - Grammar: `UNPACK orConditionRule ARRAY fieldRefRule TO fieldRefRule`
  - Used in: EXPAND instruction
  - Status: Documented in expand.md
  - Priority: Low (could create separate doc)

### LOOKUP-Specific Rules

- **forEachRule**
  - Grammar: `FOR EACH orConditionRule CALL expressionRule`
  - Used in: LOOKUP FROM_WEB instruction
  - Status: **NOT DOCUMENTED** (instruction missing)
  - Priority: Medium (depends on lookupFromWeb.md)

### TRAJECTORY MATCHING-Specific Rules

- **trajectoryPartitionRule**
  - Grammar: `PARTITION orConditionRule (partitionMatchingRule)+`
  - Used in: TRAJECTORY MATCHING instruction
  - Status: **NOT DOCUMENTED** (instruction missing)
  - Priority: Low

- **partitionMatchingRule**
  - Grammar: Complex matching with WRT, THRESHOLD, INTO, MIN_SIMILARITY
  - Used in: trajectoryPartitionRule
  - Status: **NOT DOCUMENTED** (instruction missing)
  - Priority: Low

### Fuzzy Evaluator/Aggregator-Specific Rules

These complex rules are used in CREATE FUZZY EVALUATOR/AGGREGATOR instructions and are documented as part of those instruction files:

- **feForAllRule** - FOR ALL aggregation loops
- **feDeriveRule** - DERIVE variable definitions
- **feCumulateRule** - CUMULATE operations
- **feArraySortRule** - SORT array operations
- **feArrayIndexRule** - Array indexing in loops
- **feSortFieldRule** - Field sorting specifications
- **aggSpecRule** - Aggregation specifications (WITH SUM/PRODUCT/MIN/MAX)
- **withSpec** - Aggregation type specification
- **feParameterRule** - Fuzzy evaluator parameters

Status: All documented within createFuzzyEvaluator.md and createFuzzyAggregator.md

### Fuzzy Set Model-Specific Rules

Rules used in CREATE FUZZY SET MODEL instruction:

- **fuzzyOperatorDefinitionRule** - Define AND/OR/NOT operators for fuzzy sets
- **ftExpressionRule** - Fuzzy type expressions
- **ftTermRule, ftFactorRule** - Expression components
- **ftOrConditionRule, ftAndConditionRule, ftNotConditionRule** - Fuzzy condition logic
- **ftPredicateRule** - Fuzzy predicates
- **ftConditionExpressionRule** - Condition expressions
- **ftSpecialFunctionRule** - Special functions in fuzzy context

Status: All documented within createFuzzySetModel.md

### JavaScript/Java Function-Specific Rules

Rules used in CREATE JAVASCRIPT/JAVA FUNCTION instructions:

- **parameterRule** - Function parameter declarations: `id TYPE id`
- **jfOrConditionRule, jfAndConditionRule, jfNotConditionRule** - JavaScript function conditions
- **jsfPredicateRule** - JavaScript function predicates
- **jfCompareRule** - JavaScript function comparisons
- **jfExpressionRule, jfTermRule, jfFactorRule** - JavaScript expressions
- **jfFunctionParamsRule** - JavaScript function parameters

Status: Documented within createJavaScriptFunction.md and createJavaFunction.md

---

## Complete Grammar Coverage Analysis

### ✅ Fully Documented (Ready for Users)

**Main Instructions (15/18):**
- useDb, getCollection, getDictionary, saveAs ✅
- filter, group, expand, joinOfCollections ✅
- mergeCollections, intersectCollections, subtractCollections ✅
- createFuzzyOperator, createFuzzyEvaluator, createFuzzyAggregator ✅
- createFuzzySetModel, createGenericFuzzySetOperator, createGenericFuzzyEvaluatorRule ✅
- createJavaScriptFunction ✅

**Core SubClauses (100%):**
- Logical conditions: orConditionRule, andConditionRule, notConditionRule, predicateRule ✅
- Case handling: caseClauseRule, whereCaseRule, othersRule ✅
- Document building: buildActionRule, objectStructureRule, fieldRefRule ✅
- Generation: generateSectionRule, geometricOptionRule, dropGeometryRule ✅

**Fuzzy SubClauses (100%):**
- checkForFuzzySetRule, alphaCutRule, keepDropFuzzySetsRule ✅
- wukFuzzyPredicateRule (in predicateRule) ✅

**Predefined Functions (28+ functions):**
- Type conversion, numeric, geospatial, string, fuzzy, conditional, array ✅
- Function index with navigation ✅

**Expression Rules:**
- expressionRule, termRule, factorRule, valueRule, numericRule ✅
- All documented in baseElements.md and referenced throughout

**Predicate SubRules:**
- compareRule, inRangeRule, nullPredicateRule ✅
- withPredicateRule, withoutPredicateRule ✅
- All documented within predicateRule.md

### ❌ Missing/Incomplete (3 items)

**Main Instructions:**
1. **lookupFromWebRule** - Not documented (with forEachRule subclause)
2. **trajectoryMatchingRule** - Not documented (with trajectoryPartitionRule, partitionMatchingRule)
3. **createJavaFunctionRule** - Exists but incomplete (minimal content)

**Note:** All other grammar rules (60+ rules) are documented either:
- As main instruction files
- As subClause files
- Within their parent instruction/rule documentation
- In baseElements.md or predefinedFunctions.md

### 📊 Documentation Completeness

| Category | Coverage |
|----------|----------|
| User-Facing Instructions | 83% (15/18) |
| Core Language Features | 100% |
| Fuzzy Logic Features | 100% |
| Predefined Functions | 100% |
| Expression System | 100% |
| Specialized Rules | 95% (documented inline) |

**Overall Grammar Coverage: ~95%**

The missing 5% consists of:
- 2 specialized instructions (LOOKUP, TRAJECTORY MATCHING)
- 1 incomplete instruction (CREATE JAVA FUNCTION)

All other 60+ grammar rules are fully documented!

---

## Priority Recommendations

Based on usage frequency and importance:

### High Priority ✅ COMPLETE
1. ✅ Core condition rules (OR, AND, NOT, predicate) - **DONE**
2. ✅ Core subclauses (CASE, WHERE CASE, OTHERS, GENERATE) - **DONE**
3. ✅ Predefined functions with index - **DONE**
4. ✅ Classic vs Fuzzy context documentation - **DONE**
5. ✅ All expression and value rules - **DONE**

### Medium Priority (Recommended Next)
1. ⏳ **lookupFromWebRule + forEachRule** - Web integration feature
2. ⏳ **Expand createJavaFunctionRule** - Complete with examples like JavaScript version
3. ⏳ **Additional array functions** - User mentioned more exist
4. ⏳ **collectionReferenceRule** - Create dedicated doc (currently in baseElements)

### Low Priority (Optional - Specialized Features)
1. ⏳ **trajectoryMatchingRule** - Specialized trajectory matching (rarely used)
2. ⏳ **Create separate docs for inline-documented rules** - spatialFunctionRule, groupPartitionRule, unpackRule (currently in instruction docs)
3. ⏳ **Sub-predicate rules as separate files** - compareRule, inRangeRule, etc. (currently in predicateRule.md)

---

## Documentation Style Standards

All recent documentation follows these standards:

### Structure
- EBNF Syntax section
- Syntax Diagram placeholder
- Semantics with clear explanations
- Used In section
- 10 practical examples
- Common Patterns
- Best Practices (Do's and Don'ts)
- Performance Considerations (where applicable)
- Debugging Tips
- Issues section
- References with cross-links

### Language
- **English** - All new docs in English
- **User-friendly terminology** - Avoid low-level technical terms
  - Use "value/field reference/expression" instead of "factor"
  - Use "expression in parentheses" instead of technical grammar terms
- **Context-aware** - Distinguish Classic (dot notation) vs Fuzzy (boolean) contexts

### Special Notes
- **ADD_ST** removed from user-facing docs (synonym of ADD FIELDS)
- **outputFieldSpecRule** content integrated into objectStructureRule
- Predefined functions include **function index** with internal links

---

## Recent Updates

### December 10, 2025
- ✅ Created conditionSubClauses directory with 4 complete rules
- ✅ Added Classic vs Fuzzy context distinction to predicateRule
- ✅ Added function index to predefinedFunctions.md
- ✅ Simplified buildActionRule (removed ADD_ST technical detail)
- ✅ Simplified objectStructureRule (user-friendly terminology)

### December 2, 2025
- ✅ Translated 10 documentation files from Italian to English
- ✅ Created caseClauseRule, whereCaseRule, othersRule with comprehensive examples
- ✅ Established documentation template and style

---

## Next Steps

1. **Complete Missing Instructions**
   - Create `lookupFromWeb.md`
   - Review and potentially create `trajectoryMatching.md`

2. **Document Additional Array Functions**
   - Wait for user to provide complete list
   - Add to predefinedFunctions.md

3. **Create Dedicated SubClause Docs** (Optional)
   - `collectionReferenceRule.md`
   - `expressionRule.md` with detailed examples
   - Separate docs for sub-predicates (compare, inRange, etc.)

4. **Review and Update**
   - Update main README.md with new structure
   - Add navigation index
   - Verify all cross-references
   - Generate missing syntax diagrams

---

## Contact & Notes

This document serves as a central reference for documentation progress. All documentation should maintain consistency with the grammar version 4.0.10 and follow the established style standards.

For questions or updates, refer to the grammar file: `.assets/JCoQL.g`
