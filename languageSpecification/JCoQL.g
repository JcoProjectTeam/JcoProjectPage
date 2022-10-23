/* ****************************************
**** Parser JCo-QL Antlr Specification ****
**** V. 4.0 - 20.07.2022               ****
**************************************** */

grammar JCoQL;

/* ******************************
**** Syntax rules definition ****
****************************** */
start
  :
    ( getCollectionRule
    | saveAsRule
    | joinOfCollectionsRule
    | filterRule
    | groupRule
    | expandRule
    | mergeCollectionsRule
    | intersectCollectionsRule
    | subtractCollectionsRule
    | useDbRule
    | trajectoryMatchingRule
    | createFuzzyOperatorRule
    | createJavaScriptFunctionRule
    | getDictionaryRule
    | lookupFromWebRule
    )* EOF
  ;


// *******************
// Sintax Elements
// *******************
collectionReferenceRule
  :
    ID (  AT ID )? (  AS ID )?
  ;


fieldRefRule
  :
    ( FIELD_NAME  )+
  ;


buildActionRule
  :
    BUILD 
      objectStructureRule
  ;


objectStructureRule
  :
    LBR 
      outputFieldSpecRule 
        ( COMMA outputFieldSpecRule )* 
    RBR
  ;


outputFieldSpecRule
  :
    fieldRefRule 
      ( COLON ( objectStructureRule
              | factorRule  )         )?
  ;


geometricOptionRule
  :
    KEEPING GEOMETRY
  | DROPPING GEOMETRY
  | SETTING GEOMETRY  ( POINT LP fieldRefRule COMMA fieldRefRule RP
                      | AGGREGATE LP fieldRefRule RP
                      | fieldRefRule
                      | TO_POLYLINE LP fieldRefRule RP  )
  ;


caseClauseRule
  :
    CASE 
      ( whereCaseRule )+ 
      ( othersRule  )?
  ;


othersRule
  :
    ( KEEP
    | DROP  ) OTHERS
  ;


whereCaseRule
  :
    WHERE orConditionRule 
      ( generateSectionRule )?
  ;


generateSectionRule
  :
    GENERATE 
      ( geometricOptionRule )? 
      ( checkForFuzzySetRule  )? 
      ( alphaCutRule  )? 
      ( buildActionRule )? 
      ( keepDropFuzzySetsRule )?
      ( dropGeometryRule )?
  ;


orConditionRule
  :
    andConditionRule 
      ( OR andConditionRule )*
  ;


andConditionRule
  :
    notConditionRule 
      ( AND notConditionRule  )*
  ;


notConditionRule
  :
    ( NOT )? predicateRule
  ;


predicateRule
  :
    expressionRule  ( compareRule
                    | inRangeRule )?
  | nullPredicateRule
  | withPredicateRule
  | withoutPredicateRule
  | wukFuzzyPredicateRule
  ;


compareRule
  :
    comparatorRule expressionRule
  ;


inRangeRule
  :
    INRANGE 
      ( LB  | LP  ) 
        numericRule COMMA numericRule 
      ( RP  | RB  )
  ;


nullPredicateRule
  :
    FIELD fieldRefRule 
      ( ISNULL |  ISNOTNULL )
  ;


wukFuzzyPredicateRule
  :
    ( WITHIN |  KNOWN | UNKNOWN ) 
      FUZZY SETS ID 
          ( COMMA ID  )*
  ;


withoutPredicateRule
  :
    WITHOUT fieldRefRule 
        ( COMMA fieldRefRule  )*
  ;


withPredicateRule
  :
    WITH ( ID | ARRAY | GEOMETRY )? 
      fieldRefRule 
        ( COMMA fieldRefRule  )*
  ;


expressionRule
  :
    ( termRule |  ( ADD | SUB ) termRule ) 
      ( ( ADD | SUB ) termRule  )*
  ;


termRule
  :
    factorRule 
      ( ( MUL | DIV ) factorRule  )*
  ;


factorRule
  :
    LP orConditionRule RP
  | fieldRefRule
  | valueRule
  | ID LP ( functionParamsRule  )? RP
  | specialFunctionRule
  ;


valueRule
  :
    INT
  | FLOAT
  | APEX_VALUE
  | QUOTED_VALUE
  | BOOLEAN
  ;


specialFunctionRule
  :
    MEMBERSHIP_OF LP ID RP
  | IF_ERROR LP restrictedExpressionRule COMMA valueRule RP
  | TRANSLATE LP restrictedExpressionRule COMMA ID (  COMMA BOOLEAN ( COMMA ( APEX_VALUE
                                                                            | QUOTED_VALUE  ) )?  )? RP
  | arrayFunctionRule
  ;


arrayFunctionRule
  :
    ( ARRAY_FUNCTION  ) LP 
      ( fieldRefRule
      | LB restrictedExpressionRule ( COMMA restrictedExpressionRule  )* RB ) 
      COMMA ID 
      ( COMMA ( fieldRefRule (  COMMA fieldRefRule  )*
              | DOCUMENTS COMMA 
                  fieldRefRule (  COMMA fieldRefRule  )*  ) 
      )? 
    RP
  ;


restrictedExpressionRule
  :
    ( restrictedTermRule |  ( ADD | SUB ) restrictedTermRule  ) 
      ( ( ADD | SUB ) restrictedTermRule  )*
  ;


restrictedTermRule
  :
    restrictedFactorRule 
      ( ( MUL | DIV ) restrictedFactorRule  )*
  ;


restrictedFactorRule
  :
    LP restrictedExpressionRule RP
  | fieldRefRule
  | valueRule
  | ID LP ( functionParamsRule  )? RP
  | specialFunctionRule
  ;


functionParamsRule
  :
    restrictedExpressionRule 
      ( COMMA restrictedExpressionRule  )*
  ;


comparatorRule
  :
    ( EQ
    | NEQ
    | LT
    | GT
    | LE
    | GE  )
  ;


numericRule
  :
    ( ADD | SUB )? 
    ( FLOAT | INT )
  ;


checkForFuzzySetRule
  :
    CHECK_FOR FUZZY SET ID 
          USING usingOrConditionRule 
      ( COMMA FUZZY SET ID 
          USING usingOrConditionRule  )*
  ;


usingOrConditionRule
  :
    usingAndConditionRule 
      ( OR usingAndConditionRule  )*
  ;


usingAndConditionRule
  :
    usingNotConditionRule 
      ( AND usingNotConditionRule )*
  ;


usingNotConditionRule
  :
    ( NOT )? usingPredicateRule
  ;


usingPredicateRule
  :
    LP usingOrConditionRule RP
  | ID (  LP (  functionParamsRule  )? RP )?
  | IF_FAILS LP usingOrConditionRule COMMA numericRule RP
  ;


alphaCutRule
  :
    ALPHACUT numericRule ON ID 
      ( COMMA numericRule ON ID )*
  ;


keepDropFuzzySetsRule
  :
    DEFUZZIFY
  | KEEPING ALL FUZZY SETS
  | DROPPING FUZZY SETS ID (  COMMA ID  )*
  | KEEPING FUZZY SETS ID ( COMMA ID  )*
  ;


dropGeometryRule 
  :
	  DROPPING GEOMETRY																								
  ;


addFieldsRule
  :
    ADD_ST FIELDS LBR 
      fieldRefRule COLON insertFieldRule 
        ( COMMA fieldRefRule COLON insertFieldRule  )* 
    RBR
  ;


insertFieldRule
  :
    spatialFunctionRule
  | restrictedFactorRule
  ;


spatialFunctionRule
  :
    DISTANCE LP ID RP ( comparatorRule numericRule  )?
  | AREA LP ID RP ( comparatorRule numericRule  )?
  | ORIENTATION LP 
      ( LEFT |  RIGHT ) ( COMMA ID COLON numericRule  )? 
    RP
  | INCLUDED LP 
      ( LEFT | RIGHT  ) 
    RP
  | MEET
  | INTERSECT
  ;


setFuzzySetsRule
  :
    SET FUZZY SETS 
      ( KEEP  ( ALL ( resolvingRule )?
              | LEFT
              | RIGHT )
      | addFuzzySetRule ( COMMA addFuzzySetRule )* (  resolvingRule )?  
      )
  ;


resolvingRule
  :
    RESOLVING WITH (  AND
    | OR
    | FIRST
    | LAST  )
  ;


addFuzzySetRule
  :
    ( LEFT |  RIGHT ) ( ALL | ID (  AS ID )?  )
  | HOWINCLUDE LP ( LEFT |  RIGHT ) RP AS ID
  | HOWMEET LP (  LEFT |  RIGHT ) RP AS ID
  | HOWINTERSECT LP RP AS ID
  ;


// ************************
// Instructions
// ************************

getCollectionRule
  :
    GET COLLECTION 
      ( ID (  AT ID )?
      | FROM WEB (  APEX_VALUE |  QUOTED_VALUE  ) ) 
    SC
  ;


getDictionaryRule
  :
    GET DICTIONARY ID 
      AT ID AS ID 
    SC
  ;


saveAsRule
  :
    SAVE AS ID 
      ( AT ID )? 
    SC
  ;


lookupFromWebRule
  :
    LOOKUP FROM WEB 
      ( forEachRule )+ 
    SC
  ;


forEachRule
  :
    FOR EACH orConditionRule 
      CALL expressionRule
  ;


joinOfCollectionsRule
  :
    JOIN OF COLLECTIONS 
        collectionReferenceRule COMMA collectionReferenceRule 
      ( ON GEOMETRY spatialFunctionRule )? 
      ( SET GEOMETRY 
        ( INTERSECTION
        | RIGHT
        | LEFT
        | ALL ) )? 
      ( addFieldsRule     )? 
      ( setFuzzySetsRule  )? 
      ( caseClauseRule    )? 
      ( REMOVE DUPLICATES )? 
    SC
  ;


filterRule
  :
    FILTER caseClauseRule 
      ( REMOVE DUPLICATES )? 
    SC
  ;


groupRule
  :
    GROUP 
      ( groupPartitionRule )+ 
      ( othersRule  )? 
    SC
  ;


groupPartitionRule
  :
    PARTITION orConditionRule 
      BY fieldRefRule 
        ( COMMA fieldRefRule )* 
      INTO fieldRefRule 
      ( DROP GROUPING FIELDS  )? 
      ( ORDER BY sortingFieldRule 
          ( COMMA sortingFieldRule  )* 
        ( KEEP UNCOMPARABLE )?  )? 
      ( generateSectionRule )?
  ;


sortingFieldRule
  :
    fieldRefRule TYPE ID (  VERSUS  )?
  ;


expandRule
  :
    EXPAND 
      ( unpackRule  )+ 
      ( othersRule  )? 
    SC
  ;


unpackRule
  :
    UNPACK orConditionRule 
      ARRAY fieldRefRule 
      TO fieldRefRule
  ;


mergeCollectionsRule
  :
    MERGE COLLECTIONS 
      collectionReferenceRule 
      ( COMMA collectionReferenceRule )+ 
      ( REMOVE DUPLICATES )? 
    SC
  ;


intersectCollectionsRule
  :
    INTERSECT COLLECTIONS 
      collectionReferenceRule COMMA collectionReferenceRule 
    SC
  ;


subtractCollectionsRule
  :
    SUBTRACT COLLECTIONS 
      collectionReferenceRule COMMA collectionReferenceRule 
    SC
  ;


useDbRule
  :
    USE 
      DB          ( ID |  APEX_VALUE  ) ( AS (  ID |  APEX_VALUE  ) )? 
      ( COMMA DB  ( ID |  APEX_VALUE  ) ( AS (  ID |  APEX_VALUE  ) )?  )* 
      ON  ( DEFAULT SERVER
          | SERVER (  ID |  APEX_VALUE  ) ( ( ID |  APEX_VALUE  ) )?  ) 
    SC
  ;


trajectoryMatchingRule
  :
    TRAJECTORY MATCHING 
        collectionReferenceRule COMMA collectionReferenceRule 
      ( trajectoryPartitionRule )+ 
      ( othersRule  )? 
    SC
  ;


trajectoryPartitionRule
  :
    PARTITION orConditionRule 
      ( partitionMatchingRule )+
  ;


partitionMatchingRule
  :
    MATCHING fieldRefRule 
      WRT fieldRefRule 
      THRESHOLD LP ID RP numericRule 
      ( WHERE orConditionRule )? 
      INTO fieldRefRule 
      ( ADDING fieldRefRule TO INPUT  )? 
      ( MIN_SIMILARITY numericRule  )?
  ;


parameterRule
  :
    ID TYPE ID
  ;


createJavaScriptFunctionRule
  :
    CREATE_JF ID 
      PARAMETERS parameterRule 
        ( COMMA parameterRule )* 
      ( PRECONDITION jfOrConditionRule  )? 
      BODY 
        { /* java script code */ }
      END_BODY 
    SC
  ;


createFuzzyOperatorRule
  :
    CREATE_FO ID 
      PARAMETERS parameterRule 
        ( COMMA parameterRule )* 
      ( PRECONDITION jfOrConditionRule  )? 
      EVALUATE jfExpressionRule 
      POLYLINE LB 
        LP numericRule COMMA numericRule RP 
        ( COMMA LP numericRule COMMA numericRule RP )* 
      RB 
    SC
  ;


jfOrConditionRule
  :
    jfAndConditionRule 
      ( OR jfAndConditionRule )*
  ;


jfAndConditionRule
  :
    jfNotConditionRule 
      ( AND jfNotConditionRule  )*
  ;


jfNotConditionRule
  :
    ( NOT )? jsfPredicateRule
  ;


jsfPredicateRule
  :
    jfExpressionRule (  jfCompareRule
    | inRangeRule )?
  ;


jfCompareRule
  :
    comparatorRule jfExpressionRule
  ;


jfExpressionRule
  :
    ( jfTermRule
    | ( ADD | SUB ) jfTermRule  ) 
    ( ( ADD | SUB ) jfTermRule  )*
  ;


jfTermRule
  :
    jfFactorRule 
      ( ( MUL | DIV ) jfFactorRule  )*
  ;


jfFactorRule
  :
    LP jfOrConditionRule RP
  | INT
  | FLOAT
  | APEX_VALUE
  | QUOTED_VALUE
  | ID (  LP (  jfFunctionParamsRule  )? RP )?
  ;


jfFunctionParamsRule
  :
    jfExpressionRule 
      ( COMMA jfExpressionRule  )*
  ;


// ********************
// Token Defintion 
// ********************

fragment LETTER         :  'A' . . 'Z' | 'a' . . 'z';
fragment DIGIT0         :  '1' . . '9';
fragment DIGIT          :  '0' . . '9';
fragment WS             :  ( ' ' | '\t' | '\r' | '\n' )+;

AND             :  'AND';
OR              :  'OR';
NOT             :  'NOT';
ADDING          :  'ADDING';
ADD_ST          :  'ADD';
AGGREGATE       :  'AGGREGATE';
ALL             :  'ALL';
ALPHACUT        :  'ALPHACUT';
AREA            :  'AREA';
ARRAY           :  'ARRAY';
ARRAY_FUNCTION  :  ( 'MIN' | 'MAX' | 'AVG' | 'SUM' ) '_ARRAY';
AS              :  'AS';
BODY            :  'BODY';
END_BODY        :  'END' WS 'BODY';
BOOLEAN         :  'TRUE' | 'FALSE';
BUILD           :  'BUILD';
BY              :  'BY';
CALL            :  'CALL';
CASE            :  'CASE';
CHECK_FOR       :  'CHECK' WS 'FOR';
COLLECTION      :  'COLLECTION';
COLLECTIONS     :  'COLLECTIONS';
CREATE_FO       :  'CREATE' WS 'FUZZY' WS 'OPERATOR';
CREATE_JF       :  'CREATE' WS 'JAVASCRIPT' WS 'FUNCTION';
DB              :  'DB';
DEFAULT         :  'DEFAULT';
DEFUZZIFY       :  'DEFUZZIFY';
DICTIONARY      :  'DICTIONARY';
DIRECTION       :  'DIRECTION';
DISTANCE        :  'DISTANCE';
DOCUMENTS       :  'DOCUMENTS';
DROP            :  'DROP';
DROPPING        :  'DROPPING';
DUPLICATES      :  'DUPLICATES';
EACH            :  'EACH';
EXPAND          :  'EXPAND';
EVALUATE        :  'EVALUATE';
FIELD           :  'FIELD';
FIELDS          :  'FIELDS';
FILTER          :  'FILTER';
FIRST           :  'FIRST';
FOR             :  'FOR';
FROM            :  'FROM';
FUZZY           :  'FUZZY';
GENERATE        :  'GENERATE';
GEOMETRY        :  'GEOMETRY';
GET             :  'GET';
GROUP           :  'GROUP';
GROUPING        :  'GROUPING';
HOWINCLUDE      :  'HOW_INCLUDE';
HOWINTERSECT    :  'HOW_INTERSECT';
HOWMEET         :  'HOW_MEET';
IF_ERROR        :  'IF_ERROR';
IF_FAILS        :  'IF_FAILS';
INCLUDED        :  'INCLUDED';
INPUT           :  'INPUT';
INRANGE         :  'IN_RANGE';
INTERSECT       :  'INTERSECT';
INTERSECTION    :  'INTERSECTION';
INTO            :  'INTO';
ISNULL          :  'IS' WS 'NULL';
ISNOTNULL       :  'IS' WS 'NOT' WS 'NULL';
JOIN            :  'JOIN';
KEEP            :  'KEEP';
KEEPING         :  'KEEPING';
KNOWN           :  'KNOWN';
LAST            :  'LAST';
LEFT            :  'LEFT';
LOOKUP          :  'LOOKUP';
MATCHING        :  'MATCHING';
MEET            :  'MEET';
MEMBERSHIP_OF   :  'MEMBERSHIP_OF';
MERGE           :  'MERGE';
MIN_SIMILARITY  :  'MIN' WS 'SIMILARITY';
OF              :  'OF';
ON              :  'ON';
ORIENTATION     :  'ORIENTATION';
OTHERS          :  'OTHERS';
ORDER           :  'ORDER' | 'SORTED';
PARAMETERS      :  'PARAMETERS';
PARTITION       :  'PARTITION';
POINT           :  'POINT';
POLYLINE        :  'POLYLINE';
PRECONDITION    :  'PRECONDITION';
RESOLVING       :  'RESOLVING';
RIGHT           :  'RIGHT';
REMOVE          :  'REMOVE';
SAVE            :  'SAVE';
SERVER          :  'SERVER';
SET             :  'SET';
SETS            :  'SETS';
SETTING         :  'SETTING';
SUBTRACT        :  'SUBTRACT';
TO              :  'TO';
TO_POLYLINE     :  'TO_POLYLINE';
THRESHOLD       :  'THRESHOLD';
TRANSLATE       :  'TRANSLATE';
TRAJECTORY      :  'TRAJECTORY';
TYPE            :  'TYPE';
UNCOMPARABLE    :  'UNCOMPARABLE';
UNKNOWN         :  'UNKNOWN';
UNPACK          :  'UNPACK';
USE             :  'USE';
USING           :  'USING';
VERSUS          :  'DESC' | 'ASC';
WEB             :  'WEB';
WHERE           :  'WHERE';
WITH            :  'WITH';
WITHIN          :  'WITHIN';
WITHOUT         :  'WITHOUT';
WRT             :  'WRT';

INT             :  '0' | DIGIT0 DIGIT*;
FLOAT           :  DIGIT0 DIGIT* DOT DIGIT+ | '0' DOT DIGIT+;
ID              :  LETTER ( LETTER | DIGIT | '_' )*;
FIELD_NAME      :  DOT ( LETTER | DIGIT | TILDE | '_' )+ | DOT '"' ( ~( '"' ) )* '"';

AT              :  '@';
EQ              :  '=';
NEQ             :  '!=';
LE              :  '<=';
GE              :  '>=';
LT              :  '<';
GT              :  '>';
DOT             :  '.';
ADD             :  '+';
SUB             :  '-';
MUL             :  '*';
DIV             :  '/';
COMMA           :  ',';
COLON           :  ':';
SC              :  ';';
LP              :  '(';
RP              :  ')';
LB              :  '[';
RB              :  ']';
LBR             :  '{';
RBR             :  '}';
APEX            :  '\'';
QUOTE           :  '"';
TILDE           :  '~';

WHITE_SPACES    :  WS;
APEX_VALUE      :  '\'' ( ~( '\'' ) )* '\'';
QUOTED_VALUE    :  '"' ( ~( '"' ) )* '"';
COMMENT         :   '//' ~('\n'|'\r')* '\r'? '\n'                       
                |   '/*' ( options {  greedy = false; } : . )* '*/'     
                ;

SCAN_ERROR      :  . ;
