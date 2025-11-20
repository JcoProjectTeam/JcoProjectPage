# Regole del Grammar JCoQL - Riferimento Completo

Questo documento elenca tutte le regole definite nel grammar JCoQL, evidenziando quali regole sono comuni e riutilizzate in più istruzioni.

---

## Regole delle Istruzioni Principali

### start
Regola principale del parser che elenca tutte le istruzioni disponibili.

**Definizione:**
```
start ::= (useDbRule | getCollectionRule | getDictionaryRule | lookupFromWebRule | 
           saveAsRule | mergeCollectionsRule | intersectCollectionsRule | 
           subtractCollectionsRule | filterRule | joinOfCollectionsRule | 
           trajectoryMatchingRule | groupRule | expandRule | 
           createJavaScriptFunctionRule | createJavaFunctionRule | 
           createFuzzyOperatorRule | createFuzzyAggregatorRule | 
           createFuzzyEvaluatorRule | createFuzzySetModelRule | 
           createGenericFuzzySetOperatorRule | createGenericFuzzyEvaluatorRule)* EOF
```

---

### useDbRule
Specifica il database da utilizzare.

**Tipo:** Istruzione di configurazione  
**Comune:** No

---

### getCollectionRule
Carica una collezione dal database o dal web.

**Tipo:** Istruzione di caricamento  
**Comune:** No

---

### getDictionaryRule
Carica un dizionario dal database.

**Tipo:** Istruzione di caricamento  
**Comune:** No

---

### saveAsRule
Salva la collezione corrente con un nome specifico.

**Tipo:** Istruzione di salvataggio  
**Comune:** No

---

### lookupFromWebRule
Esegue chiamate web per ogni documento che soddisfa una condizione.

**Tipo:** Istruzione di integrazione web  
**Comune:** No

---

### mergeCollectionsRule
Unisce multiple collezioni.

**Tipo:** Istruzione di operazione su collezioni  
**Comune:** No  
**Usa regole comuni:** collectionReferenceRule

---

### intersectCollectionsRule
Calcola l'intersezione di due collezioni.

**Tipo:** Istruzione di operazione su collezioni  
**Comune:** No  
**Usa regole comuni:** collectionReferenceRule

---

### subtractCollectionsRule
Sottrae una collezione da un'altra.

**Tipo:** Istruzione di operazione su collezioni  
**Comune:** No  
**Usa regole comuni:** collectionReferenceRule

---

### filterRule
Filtra e/o trasforma documenti nella collezione corrente.

**Tipo:** Istruzione di trasformazione  
**Comune:** No  
**Usa regole comuni:** caseClauseRule, generateSectionRule, othersRule

---

### joinOfCollectionsRule
Unisce due collezioni tramite prodotto cartesiano con filtri opzionali.

**Tipo:** Istruzione di operazione su collezioni  
**Comune:** No  
**Usa regole comuni:** collectionReferenceRule, caseClauseRule, generateSectionRule, addFieldsRule, setFuzzySetsRule

---

### groupRule
Raggruppa documenti in base a criteri.

**Tipo:** Istruzione di aggregazione  
**Comune:** No  
**Usa regole comuni:** orConditionRule, fieldRefRule, generateSectionRule, othersRule

---

### expandRule
Espande array in documenti separati.

**Tipo:** Istruzione di trasformazione  
**Comune:** No  
**Usa regole comuni:** orConditionRule, fieldRefRule, othersRule

---

### trajectoryMatchingRule
Confronta traiettorie tra due collezioni.

**Tipo:** Istruzione specializzata  
**Comune:** No  
**Usa regole comuni:** collectionReferenceRule, orConditionRule, fieldRefRule, othersRule

---

### createJavaScriptFunctionRule
Crea una funzione JavaScript personalizzata.

**Tipo:** Istruzione di definizione funzione  
**Comune:** No  
**Usa regole comuni:** parameterRule, jfOrConditionRule

---

### createJavaFunctionRule
Crea una funzione Java personalizzata.

**Tipo:** Istruzione di definizione funzione  
**Comune:** No  
**Usa regole comuni:** parameterRule, jfOrConditionRule

---

### createFuzzyOperatorRule
Crea un operatore fuzzy personalizzato.

**Tipo:** Istruzione fuzzy  
**Comune:** No  
**Usa regole comuni:** parameterRule, jfOrConditionRule, jfExpressionRule, numericRule

---

### createFuzzyEvaluatorRule
Crea un valutatore fuzzy.

**Tipo:** Istruzione fuzzy  
**Comune:** No  
**Usa regole comuni:** feParameterRule, jfOrConditionRule, feExpressionRule, numericRule

---

### createFuzzyAggregatorRule
Crea un aggregatore fuzzy.

**Tipo:** Istruzione fuzzy  
**Comune:** No  
**Usa regole comuni:** feParameterRule, jfOrConditionRule, feExpressionRule, numericRule

---

### createFuzzySetModelRule
Definisce un modello di fuzzy set multi-grado.

**Tipo:** Istruzione fuzzy  
**Comune:** No  
**Usa regole comuni:** jfOrConditionRule, ftExpressionRule

---

### createGenericFuzzySetOperatorRule
Crea un operatore fuzzy generico per un modello specifico.

**Tipo:** Istruzione fuzzy  
**Comune:** No  
**Usa regole comuni:** parameterRule, jfOrConditionRule, jfExpressionRule, numericRule

---

### createGenericFuzzyEvaluatorRule
Crea un valutatore fuzzy generico per un modello specifico.

**Tipo:** Istruzione fuzzy  
**Comune:** No  
**Usa regole comuni:** feParameterRule, jfOrConditionRule, feExpressionRule, numericRule

---

## Regole Comuni e Condivise

Queste regole sono utilizzate da multiple istruzioni e rappresentano i blocchi costruttivi fondamentali del linguaggio.

---

### collectionReferenceRule ⭐ COMUNE
Riferimento a una collezione con database e alias opzionali.

**Definizione:**
```
collectionReferenceRule ::= ID [AT ID] [AS ID]
```

**Usata in:**
- mergeCollectionsRule
- intersectCollectionsRule
- subtractCollectionsRule
- joinOfCollectionsRule
- trajectoryMatchingRule

---

### fieldRefRule ⭐ COMUNE
Riferimento a un campo di un documento.

**Definizione:**
```
fieldRefRule ::= (FIELD_NAME)+
```

**Usata in:**
- Praticamente tutte le istruzioni che operano su documenti
- buildActionRule
- outputFieldSpecRule
- geometricOptionRule
- Tutte le condizioni
- groupRule
- expandRule
- addFieldsRule

---

### buildActionRule ⭐ COMUNE
Definisce come costruire la struttura di output dei documenti.

**Definizione:**
```
buildActionRule ::= BUILD objectStructureRule
                  | ADD_ST FIELDS objectStructureRule
                  | REMOVE FIELDS LBR fieldRefRule (COMMA fieldRefRule)* RBR
```

**Usata in:**
- generateSectionRule (quindi indirettamente in FILTER, GROUP, JOIN)

---

### objectStructureRule ⭐ COMUNE
Specifica la struttura di un oggetto JSON.

**Definizione:**
```
objectStructureRule ::= LBR outputFieldSpecRule (COMMA outputFieldSpecRule)* RBR
```

**Usata in:**
- buildActionRule
- outputFieldSpecRule

---

### outputFieldSpecRule ⭐ COMUNE
Specifica un campo nell'output con possibile trasformazione.

**Definizione:**
```
outputFieldSpecRule ::= fieldRefRule [COLON (objectStructureRule | factorRule)]
```

**Usata in:**
- objectStructureRule

---

### geometricOptionRule ⭐ COMUNE
Gestisce la geometria nei documenti risultanti.

**Definizione:**
```
geometricOptionRule ::= KEEPING GEOMETRY
                      | SETTING GEOMETRY (POINT LP fieldRefRule COMMA fieldRefRule RP
                                        | AGGREGATE LP fieldRefRule RP
                                        | fieldRefRule
                                        | TO_POLYLINE LP fieldRefRule RP)
```

**Usata in:**
- generateSectionRule

---

### dropGeometryRule ⭐ COMUNE
Rimuove la geometria dai documenti.

**Definizione:**
```
dropGeometryRule ::= DROPPING GEOMETRY
```

**Usata in:**
- generateSectionRule

---

### caseClauseRule ⭐ COMUNE
Definisce clausole condizionali multiple.

**Definizione:**
```
caseClauseRule ::= (CASES | CASE) (whereCaseRule)+ [othersRule]
```

**Usata in:**
- filterRule
- joinOfCollectionsRule

---

### othersRule ⭐ COMUNE
Specifica cosa fare con documenti non corrispondenti.

**Definizione:**
```
othersRule ::= (KEEP | DROP) OTHERS
```

**Usata in:**
- caseClauseRule
- groupRule
- expandRule
- trajectoryMatchingRule

---

### whereCaseRule ⭐ COMUNE
Clausola WHERE con optional generate section.

**Definizione:**
```
whereCaseRule ::= WHERE orConditionRule [generateSectionRule]
```

**Usata in:**
- caseClauseRule

---

### generateSectionRule ⭐ COMUNE
Trasforma documenti generando nuove strutture.

**Definizione:**
```
generateSectionRule ::= GENERATE 
                          [geometricOptionRule]
                          [checkForFuzzySetRule]
                          [alphaCutRule]
                          (buildActionRule)*
                          [keepDropFuzzySetsRule]
                          [dropGeometryRule]
```

**Usata in:**
- filterRule
- groupRule
- joinOfCollectionsRule
- whereCaseRule
- groupPartitionRule

---

### orConditionRule ⭐ COMUNE
Condizione logica con OR.

**Definizione:**
```
orConditionRule ::= andConditionRule (OR andConditionRule)*
```

**Usata in:**
- Tutte le istruzioni con WHERE
- predicateRule
- filterRule
- groupRule
- expandRule
- joinOfCollectionsRule
- lookupFromWebRule

---

### andConditionRule ⭐ COMUNE
Condizione logica con AND.

**Definizione:**
```
andConditionRule ::= notConditionRule (AND notConditionRule)*
```

**Usata in:**
- orConditionRule

---

### notConditionRule ⭐ COMUNE
Condizione logica con NOT opzionale.

**Definizione:**
```
notConditionRule ::= [NOT] predicateRule
```

**Usata in:**
- andConditionRule

---

### predicateRule ⭐ COMUNE
Predicato di base per condizioni.

**Definizione:**
```
predicateRule ::= expressionRule [compareRule | inRangeRule]
                | nullPredicateRule
                | withPredicateRule
                | withoutPredicateRule
                | wukFuzzyPredicateRule
```

**Usata in:**
- notConditionRule

---

### compareRule ⭐ COMUNE
Regola di confronto tra espressioni.

**Definizione:**
```
compareRule ::= comparatorRule expressionRule
```

**Usata in:**
- predicateRule

---

### inRangeRule ⭐ COMUNE
Verifica se un valore è in un intervallo.

**Definizione:**
```
inRangeRule ::= INRANGE (LB | LP) numericRule COMMA numericRule (RP | RB)
```

**Usata in:**
- predicateRule
- jsfPredicateRule

---

### nullPredicateRule ⭐ COMUNE
Verifica se un campo è NULL o NOT NULL.

**Definizione:**
```
nullPredicateRule ::= FIELD fieldRefRule (ISNULL | ISNOTNULL)
```

**Usata in:**
- predicateRule

---

### wukFuzzyPredicateRule ⭐ COMUNE
Predicati fuzzy (WITHIN, KNOWN, UNKNOWN).

**Definizione:**
```
wukFuzzyPredicateRule ::= (WITHIN | KNOWN | UNKNOWN) FUZZY SETS ID (COMMA ID)*
```

**Usata in:**
- predicateRule

---

### withoutPredicateRule ⭐ COMUNE
Verifica assenza di campi.

**Definizione:**
```
withoutPredicateRule ::= WITHOUT fieldRefRule (COMMA fieldRefRule)*
```

**Usata in:**
- predicateRule

---

### withPredicateRule ⭐ COMUNE
Verifica presenza di campi.

**Definizione:**
```
withPredicateRule ::= WITH [(ID | ARRAY | GEOMETRY)] fieldRefRule (COMMA fieldRefRule)*
```

**Usata in:**
- predicateRule

---

### expressionRule ⭐ COMUNE
Espressione aritmetica.

**Definizione:**
```
expressionRule ::= (termRule | (ADD | SUB) termRule) ((ADD | SUB) termRule)*
```

**Usata in:**
- predicateRule
- compareRule
- Tutte le espressioni matematiche

---

### termRule ⭐ COMUNE
Termine in un'espressione (moltiplicazioni/divisioni).

**Definizione:**
```
termRule ::= factorRule ((MUL | DIV) factorRule)*
```

**Usata in:**
- expressionRule

---

### factorRule ⭐ COMUNE
Fattore in un'espressione.

**Definizione:**
```
factorRule ::= (LP orConditionRule RP
              | fieldRefRule
              | valueRule
              | ID LP [functionParamsRule] RP
              | specialFunctionRule
              | LB factorRule (COMMA factorRule)* RB) [EXP factorRule]
```

**Usata in:**
- termRule
- outputFieldSpecRule

---

### specialFunctionRule ⭐ COMUNE
Funzioni speciali predefinite.

**Definizione:**
```
specialFunctionRule ::= MEMBERSHIP_TO LP ID RP
                      | EXTENT LP ID RP
                      | DEGREE LP ID [FIELD_NAME] RP
                      | HASH_NAME [FIELD_NAME]
                      | MEMBERSHIP_ARRAY LP (ALL | ID FROM_ARRAY fieldRefRule | LB ID (COMMA ID)* RB) RP
                      | EXTRACT_ARRAY LP fieldRefRule FROM_ARRAY fieldRefRule RP
                      | IF LP LP orConditionRule RP COMMA restrictedExpressionRule COMMA restrictedExpressionRule RP
                      | IF_ERROR LP restrictedExpressionRule COMMA valueRule RP
                      | TRANSLATE LP restrictedExpressionRule COMMA ID [COMMA BOOLEAN [COMMA (APEX_VALUE | QUOTED_VALUE)]] RP
                      | arrayFunctionRule
```

**Usata in:**
- factorRule
- restrictedFactorRule
- ftFactorRule

---

### valueRule ⭐ COMUNE
Valori letterali.

**Definizione:**
```
valueRule ::= INT | FLOAT | BOOLEAN | APEX_VALUE | QUOTED_VALUE
```

**Usata in:**
- factorRule
- restrictedFactorRule
- feFactorRule

---

### arrayFunctionRule ⭐ COMUNE
Funzioni su array (MIN_ARRAY, MAX_ARRAY, AVG_ARRAY, SUM_ARRAY).

**Definizione:**
```
arrayFunctionRule ::= (ARRAY_FUNCTION) LP (fieldRefRule | LB restrictedExpressionRule (COMMA restrictedExpressionRule)* RB) 
                      COMMA ID [COMMA (fieldRefRule (COMMA fieldRefRule)* | DOCUMENTS COMMA fieldRefRule (COMMA fieldRefRule)*)] RP
```

**Usata in:**
- specialFunctionRule

---

### restrictedExpressionRule ⭐ COMUNE
Espressione ristretta (senza condizioni).

**Definizione:**
```
restrictedExpressionRule ::= (restrictedTermRule | (ADD | SUB) restrictedTermRule) ((ADD | SUB) restrictedTermRule)*
```

**Usata in:**
- specialFunctionRule
- arrayFunctionRule
- functionParamsRule

---

### restrictedTermRule ⭐ COMUNE
Termine ristretto.

**Definizione:**
```
restrictedTermRule ::= restrictedFactorRule ((MUL | DIV) restrictedFactorRule)*
```

**Usata in:**
- restrictedExpressionRule

---

### restrictedFactorRule ⭐ COMUNE
Fattore ristretto.

**Definizione:**
```
restrictedFactorRule ::= (LP restrictedExpressionRule RP
                        | fieldRefRule
                        | valueRule
                        | ID LP [functionParamsRule] RP
                        | specialFunctionRule
                        | LB restrictedFactorRule (COMMA restrictedFactorRule)* RB) [EXP restrictedFactorRule]
```

**Usata in:**
- restrictedTermRule

---

### functionParamsRule ⭐ COMUNE
Parametri per chiamate a funzioni.

**Definizione:**
```
functionParamsRule ::= restrictedExpressionRule (COMMA restrictedExpressionRule)*
```

**Usata in:**
- factorRule
- restrictedFactorRule
- usingPredicateRule

---

### comparatorRule ⭐ COMUNE
Operatori di confronto.

**Definizione:**
```
comparatorRule ::= (EQ | NEQ | LT | GT | LE | GE)
```

**Usata in:**
- compareRule
- jfCompareRule
- spatialFunctionRule

---

### numericRule ⭐ COMUNE
Valore numerico con segno opzionale.

**Definizione:**
```
numericRule ::= [ADD | SUB] (FLOAT | INT)
```

**Usata in:**
- inRangeRule
- checkForFuzzySetRule
- alphaCutRule
- usingPredicateRule
- spatialFunctionRule
- Tutte le regole fuzzy

---

### checkForFuzzySetRule ⭐ COMUNE (Fuzzy)
Verifica fuzzy sets con condizioni.

**Definizione:**
```
checkForFuzzySetRule ::= CHECK_FOR [ID] FUZZY SET ID USING usingOrConditionRule 
                         (COMMA [ID] FUZZY SET ID USING usingOrConditionRule)*
```

**Usata in:**
- generateSectionRule

---

### usingOrConditionRule ⭐ COMUNE (Fuzzy)
Condizione OR per fuzzy sets.

**Definizione:**
```
usingOrConditionRule ::= usingAndConditionRule (OR usingAndConditionRule)*
```

**Usata in:**
- checkForFuzzySetRule
- usingPredicateRule

---

### usingAndConditionRule ⭐ COMUNE (Fuzzy)
Condizione AND per fuzzy sets.

**Definizione:**
```
usingAndConditionRule ::= usingNotConditionRule (AND usingNotConditionRule)*
```

**Usata in:**
- usingOrConditionRule

---

### usingNotConditionRule ⭐ COMUNE (Fuzzy)
Condizione NOT per fuzzy sets.

**Definizione:**
```
usingNotConditionRule ::= [NOT] usingPredicateRule
```

**Usata in:**
- usingAndConditionRule

---

### usingPredicateRule ⭐ COMUNE (Fuzzy)
Predicato per fuzzy sets.

**Definizione:**
```
usingPredicateRule ::= LP usingOrConditionRule RP
                     | ID [LP [functionParamsRule] RP]
                     | IF_FAILS LP usingOrConditionRule COMMA numericRule RP
```

**Usata in:**
- usingNotConditionRule

---

### alphaCutRule ⭐ COMUNE (Fuzzy)
Applica alpha-cut ai fuzzy sets.

**Definizione:**
```
alphaCutRule ::= ALPHACUT numericRule ON ID [FIELD_NAME] (COMMA numericRule ON ID [FIELD_NAME])*
```

**Usata in:**
- generateSectionRule

---

### keepDropFuzzySetsRule ⭐ COMUNE (Fuzzy)
Gestisce quali fuzzy sets mantenere.

**Definizione:**
```
keepDropFuzzySetsRule ::= DEFUZZIFY
                        | DROPPING ALL FUZZY SETS
                        | KEEPING ALL FUZZY SETS
                        | DROPPING FUZZY SETS ID (COMMA ID)*
                        | KEEPING FUZZY SETS ID (COMMA ID)*
```

**Usata in:**
- generateSectionRule

---

### addFieldsRule ⭐ COMUNE
Aggiunge campi durante un JOIN.

**Definizione:**
```
addFieldsRule ::= ADD_ST FIELDS LBR fieldRefRule COLON insertFieldRule 
                  (COMMA fieldRefRule COLON insertFieldRule)* RBR
```

**Usata in:**
- joinOfCollectionsRule

---

### insertFieldRule
Specifica un campo da inserire.

**Definizione:**
```
insertFieldRule ::= spatialFunctionRule | restrictedFactorRule
```

**Usata in:**
- addFieldsRule

---

### spatialFunctionRule ⭐ COMUNE (Geometria)
Funzioni spaziali per geometrie.

**Definizione:**
```
spatialFunctionRule ::= DISTANCE LP ID RP [comparatorRule numericRule]
                      | ORIENTATION LP (LEFT | RIGHT) [COMMA ID COLON numericRule] RP
                      | INCLUDED LP (LEFT | RIGHT) RP
                      | MEET
                      | INTERSECT
```

**Usata in:**
- insertFieldRule
- joinOfCollectionsRule

---

### setFuzzySetsRule ⭐ COMUNE (Fuzzy)
Gestisce fuzzy sets in un JOIN.

**Definizione:**
```
setFuzzySetsRule ::= SET FUZZY SETS (KEEP (ALL [resolvingRule] | LEFT | RIGHT)
                                    | addFuzzySetRule (COMMA addFuzzySetRule)* [resolvingRule])
```

**Usata in:**
- joinOfCollectionsRule

---

### resolvingRule (Fuzzy)
Risolve conflitti tra fuzzy sets.

**Definizione:**
```
resolvingRule ::= RESOLVING WITH (AND | OR | FIRST | LAST)
```

**Usata in:**
- setFuzzySetsRule

---

### addFuzzySetRule (Fuzzy)
Aggiunge fuzzy sets al risultato.

**Definizione:**
```
addFuzzySetRule ::= (LEFT | RIGHT) (ALL | ID [AS ID])
                  | HOWINCLUDE LP (LEFT | RIGHT) RP AS ID
                  | HOWMEET LP (LEFT | RIGHT) RP AS ID
                  | HOWINTERSECT LP RP AS ID
```

**Usata in:**
- setFuzzySetsRule

---

### parameterRule ⭐ COMUNE
Definisce parametri per funzioni.

**Definizione:**
```
parameterRule ::= ID TYPE ID
```

**Usata in:**
- createJavaScriptFunctionRule
- createJavaFunctionRule
- createFuzzyOperatorRule
- createGenericFuzzySetOperatorRule

---

### feParameterRule ⭐ COMUNE (Fuzzy)
Parametri per fuzzy evaluator/aggregator.

**Definizione:**
```
feParameterRule ::= ID TYPE (ID | ARRAY)
```

**Usata in:**
- createFuzzyEvaluatorRule
- createFuzzyAggregatorRule
- createGenericFuzzyEvaluatorRule

---

### groupPartitionRule
Definisce una partizione in GROUP.

**Definizione:**
```
groupPartitionRule ::= PARTITION orConditionRule BY fieldRefRule (COMMA fieldRefRule)* INTO fieldRefRule 
                       [DROP GROUPING FIELDS] 
                       [ORDER BY sortingFieldRule (COMMA sortingFieldRule)* [KEEP UNCOMPARABLE]]
                       [generateSectionRule]
```

**Usata in:**
- groupRule

---

### sortingFieldRule
Specifica ordinamento per GROUP.

**Definizione:**
```
sortingFieldRule ::= fieldRefRule TYPE ID [VERSUS]
```

**Usata in:**
- groupPartitionRule

---

### unpackRule
Definisce come espandere array in EXPAND.

**Definizione:**
```
unpackRule ::= UNPACK orConditionRule ARRAY fieldRefRule TO fieldRefRule
```

**Usata in:**
- expandRule

---

### forEachRule
Iterazione per LOOKUP FROM WEB.

**Definizione:**
```
forEachRule ::= FOR EACH orConditionRule CALL expressionRule
```

**Usata in:**
- lookupFromWebRule

---

### trajectoryPartitionRule
Partizione per TRAJECTORY MATCHING.

**Definizione:**
```
trajectoryPartitionRule ::= PARTITION orConditionRule (partitionMatchingRule)+
```

**Usata in:**
- trajectoryMatchingRule

---

### partitionMatchingRule
Regola di matching per traiettorie.

**Definizione:**
```
partitionMatchingRule ::= MATCHING fieldRefRule WRT fieldRefRule THRESHOLD LP ID RP numericRule 
                          [WHERE orConditionRule] INTO fieldRefRule 
                          [ADDING fieldRefRule TO INPUT] [MIN_SIMILARITY numericRule]
```

**Usata in:**
- trajectoryPartitionRule

---

## Regole per Funzioni Java/JavaScript

### jfOrConditionRule ⭐ COMUNE
Condizione OR per precondizioni funzioni.

**Definizione:**
```
jfOrConditionRule ::= jfAndConditionRule (OR jfAndConditionRule)*
```

**Usata in:**
- createJavaScriptFunctionRule
- createJavaFunctionRule
- createFuzzyOperatorRule
- createFuzzyEvaluatorRule
- createFuzzyAggregatorRule
- createFuzzySetModelRule
- createGenericFuzzySetOperatorRule
- createGenericFuzzyEvaluatorRule

---

### jfAndConditionRule
Condizione AND per funzioni.

**Definizione:**
```
jfAndConditionRule ::= jfNotConditionRule (AND jfNotConditionRule)*
```

**Usata in:**
- jfOrConditionRule

---

### jfNotConditionRule
Condizione NOT per funzioni.

**Definizione:**
```
jfNotConditionRule ::= [NOT] jsfPredicateRule
```

**Usata in:**
- jfAndConditionRule

---

### jsfPredicateRule
Predicato per funzioni.

**Definizione:**
```
jsfPredicateRule ::= jfExpressionRule [jfCompareRule | inRangeRule]
```

**Usata in:**
- jfNotConditionRule

---

### jfCompareRule
Confronto in funzioni.

**Definizione:**
```
jfCompareRule ::= comparatorRule jfExpressionRule
```

**Usata in:**
- jsfPredicateRule

---

### jfExpressionRule ⭐ COMUNE
Espressione in funzioni Java/JavaScript.

**Definizione:**
```
jfExpressionRule ::= (jfTermRule | (ADD | SUB) jfTermRule) ((ADD | SUB) jfTermRule)*
```

**Usata in:**
- createFuzzyOperatorRule
- createGenericFuzzySetOperatorRule
- jsfPredicateRule
- jfCompareRule
- jfFactorRule

---

### jfTermRule
Termine in espressioni funzioni.

**Definizione:**
```
jfTermRule ::= jfFactorRule ((MUL | DIV) jfFactorRule)*
```

**Usata in:**
- jfExpressionRule

---

### jfFactorRule
Fattore in espressioni funzioni.

**Definizione:**
```
jfFactorRule ::= (LP jfOrConditionRule RP
                | INT | FLOAT | APEX_VALUE | QUOTED_VALUE
                | IF LP LP jfOrConditionRule RP COMMA jfExpressionRule COMMA jfExpressionRule RP
                | ID [LP [jfFunctionParamsRule] RP]) [EXP jfFactorRule]
```

**Usata in:**
- jfTermRule

---

### jfFunctionParamsRule
Parametri per funzioni in espressioni.

**Definizione:**
```
jfFunctionParamsRule ::= jfExpressionRule (COMMA jfExpressionRule)*
```

**Usata in:**
- jfFactorRule

---

## Regole per Fuzzy Evaluator/Aggregator

### feExpressionRule ⭐ COMUNE (Fuzzy)
Espressione in fuzzy evaluator.

**Definizione:**
```
feExpressionRule ::= (feTermRule | (ADD | SUB) feTermRule) ((ADD | SUB) feTermRule)*
```

**Usata in:**
- createFuzzyEvaluatorRule
- createFuzzyAggregatorRule
- createGenericFuzzyEvaluatorRule
- feForAllRule
- feDeriveRule
- aggSpecRule

---

### feTermRule
Termine in fuzzy evaluator.

**Definizione:**
```
feTermRule ::= feFactorRule ((MUL | DIV) feFactorRule)*
```

**Usata in:**
- feExpressionRule

---

### feFactorRule
Fattore in fuzzy evaluator.

**Definizione:**
```
feFactorRule ::= (LP feExpressionRule RP
                | valueRule | POS
                | IF_ERROR LP feExpressionRule COMMA valueRule RP
                | IF LP LP jfOrConditionRule RP COMMA feExpressionRule COMMA feExpressionRule RP
                | ID [feArrayRefRule | LP feFunctionParamsRule RP]) [EXP feFactorRule]
```

**Usata in:**
- feTermRule

---

### feFunctionParamsRule
Parametri per funzioni fuzzy.

**Definizione:**
```
feFunctionParamsRule ::= feExpressionRule (COMMA feExpressionRule)*
```

**Usata in:**
- feFactorRule

---

### feArrayRefRule
Riferimento array in fuzzy evaluator.

**Definizione:**
```
feArrayRefRule ::= LB (feExpressionRule) RB [fieldRefRule]
```

**Usata in:**
- feFactorRule

---

### feForAllRule
Iterazione FOR ALL in fuzzy aggregator.

**Definizione:**
```
feForAllRule ::= FOR ALL ID IN ID [LB feExpressionRule COMMA feExpressionRule RB] 
                 [LOCALLY feExpressionRule AS ID (COMMA feExpressionRule AS ID)*] 
                 AGGREGATE aggSpecRule (COMMA aggSpecRule)*
```

**Usata in:**
- createFuzzyEvaluatorRule
- createFuzzyAggregatorRule
- createGenericFuzzyEvaluatorRule

---

### feDeriveRule
Deriva valori in fuzzy evaluator.

**Definizione:**
```
feDeriveRule ::= DERIVE (feExpressionRule | feCumulateRule) AS ID
```

**Usata in:**
- createFuzzyEvaluatorRule
- createFuzzyAggregatorRule
- createGenericFuzzyEvaluatorRule

---

### feCumulateRule
Cumula valori.

**Definizione:**
```
feCumulateRule ::= CUMULATE LP ID RP
```

**Usata in:**
- feDeriveRule

---

### feArraySortRule
Ordina array in fuzzy evaluator.

**Definizione:**
```
feArraySortRule ::= SORT (feArrayIndexRule BY feSortFieldRule (COMMA feSortFieldRule)* AS ID
                         | LP feArrayIndexRule (COMMA feArrayIndexRule)+ RP BY feSortFieldRule 
                           (COMMA feSortFieldRule)* AS LP ID (COMMA ID)+ RP)
```

**Usata in:**
- createFuzzyEvaluatorRule
- createFuzzyAggregatorRule
- createGenericFuzzyEvaluatorRule

---

### feArrayIndexRule
Indice array per sorting.

**Definizione:**
```
feArrayIndexRule ::= ID IN ID
```

**Usata in:**
- feArraySortRule

---

### feSortFieldRule
Campo di ordinamento fuzzy.

**Definizione:**
```
feSortFieldRule ::= ID [fieldRefRule] TYPE ID [VERSUS]
```

**Usata in:**
- feArraySortRule

---

### aggSpecRule
Specifica aggregazione.

**Definizione:**
```
aggSpecRule ::= [withSpec] feExpressionRule AS ID
```

**Usata in:**
- feForAllRule

---

### withSpec
Tipo di aggregazione.

**Definizione:**
```
withSpec ::= WITH (SUM | PRODUCT | MINIMUM | MAXIMUM)
```

**Usata in:**
- aggSpecRule

---

## Regole per Fuzzy Set Model

### fuzzyOperatorDefinitionRule
Definisce operatori per fuzzy set model.

**Definizione:**
```
fuzzyOperatorDefinitionRule ::= OPERATOR (OR | AND | NOT) (EVALUATE ID AS ftConditionExpressionRule)+
```

**Usata in:**
- createFuzzySetModelRule

---

### ftExpressionRule
Espressione in fuzzy type.

**Definizione:**
```
ftExpressionRule ::= (ftTermRule | (ADD | SUB) ftTermRule) ((ADD | SUB) ftTermRule)*
```

**Usata in:**
- createFuzzySetModelRule
- ftFactorRule
- ftFunctionParamsRule

---

### ftTermRule
Termine in fuzzy type.

**Definizione:**
```
ftTermRule ::= ftFactorRule ((MUL | DIV) ftFactorRule)*
```

**Usata in:**
- ftExpressionRule

---

### ftFactorRule
Fattore in fuzzy type.

**Definizione:**
```
ftFactorRule ::= LP ftExpressionRule RP
               | ftValueRule | ID
               | ID LP [ftFunctionParamsRule] RP
               | specialFunctionRule
```

**Usata in:**
- ftTermRule

---

### ftValueRule
Valore in fuzzy type.

**Definizione:**
```
ftValueRule ::= INT | FLOAT
```

**Usata in:**
- ftFactorRule
- ftConditionFactorRule

---

### ftFunctionParamsRule
Parametri funzioni fuzzy type.

**Definizione:**
```
ftFunctionParamsRule ::= ftExpressionRule (COMMA ftExpressionRule)*
```

**Usata in:**
- ftFactorRule

---

### ftOrConditionRule
Condizione OR fuzzy type.

**Definizione:**
```
ftOrConditionRule ::= ftAndConditionRule (OR ftAndConditionRule)*
```

**Usata in:**
- ftSpecialFunctionRule

---

### ftAndConditionRule
Condizione AND fuzzy type.

**Definizione:**
```
ftAndConditionRule ::= ftNotConditionRule (AND ftNotConditionRule)*
```

**Usata in:**
- ftOrConditionRule

---

### ftNotConditionRule
Condizione NOT fuzzy type.

**Definizione:**
```
ftNotConditionRule ::= [NOT] ftPredicateRule
```

**Usata in:**
- ftAndConditionRule

---

### ftPredicateRule
Predicato fuzzy type.

**Definizione:**
```
ftPredicateRule ::= ftConditionExpressionRule [comparatorRule ftConditionExpressionRule]
```

**Usata in:**
- ftNotConditionRule

---

### ftConditionExpressionRule
Espressione condizionale fuzzy type.

**Definizione:**
```
ftConditionExpressionRule ::= (ftConditionTermRule | (ADD | SUB) ftConditionTermRule) 
                              ((ADD | SUB) ftConditionTermRule)*
```

**Usata in:**
- fuzzyOperatorDefinitionRule
- ftPredicateRule
- ftConditionFactorRule
- ftSpecialFunctionRule
- ftConditionFunctionParamsRule

---

### ftConditionTermRule
Termine condizionale fuzzy type.

**Definizione:**
```
ftConditionTermRule ::= ftConditionFactorRule ((MUL | DIV) ftConditionFactorRule)*
```

**Usata in:**
- ftConditionExpressionRule

---

### ftConditionFactorRule
Fattore condizionale fuzzy type.

**Definizione:**
```
ftConditionFactorRule ::= LP ftConditionExpressionRule RP
                        | ftConditionValueRule
                        | ID FIELD_NAME
                        | ID LP [ftConditionFunctionParamsRule] RP
                        | ftSpecialFunctionRule
```

**Usata in:**
- ftConditionTermRule

---

### ftConditionValueRule
Valore condizionale fuzzy type.

**Definizione:**
```
ftConditionValueRule ::= INT | FLOAT
```

**Usata in:**
- ftConditionFactorRule

---

### ftConditionFunctionParamsRule
Parametri funzioni condizionali.

**Definizione:**
```
ftConditionFunctionParamsRule ::= ftConditionExpressionRule (COMMA ftConditionExpressionRule)*
```

**Usata in:**
- ftConditionFactorRule

---

### ftSpecialFunctionRule
Funzione speciale IF in fuzzy type.

**Definizione:**
```
ftSpecialFunctionRule ::= IF LP LP ftOrConditionRule RP COMMA ftConditionExpressionRule 
                          COMMA ftConditionExpressionRule RP
```

**Usata in:**
- ftConditionFactorRule

---

## Riepilogo Regole Comuni

### Regole Usate da 5+ Istruzioni

1. **fieldRefRule** - Usata in quasi tutte le istruzioni
2. **orConditionRule** - Usata in FILTER, GROUP, EXPAND, JOIN, LOOKUP, TRAJECTORY
3. **generateSectionRule** - Usata in FILTER, GROUP, JOIN
4. **numericRule** - Usata in tutte le regole fuzzy e spaziali
5. **collectionReferenceRule** - Usata in MERGE, INTERSECT, SUBTRACT, JOIN, TRAJECTORY
6. **parameterRule** - Usata in tutte le CREATE FUNCTION/OPERATOR
7. **jfOrConditionRule** - Usata in tutte le CREATE FUNCTION/OPERATOR per preconditions

### Regole del Mondo Fuzzy

- checkForFuzzySetRule
- alphaCutRule
- keepDropFuzzySetsRule
- setFuzzySetsRule
- wukFuzzyPredicateRule
- feExpressionRule (e famiglia fe*)
- ftExpressionRule (e famiglia ft*)
- fuzzyOperatorDefinitionRule

### Regole Geometriche

- geometricOptionRule
- dropGeometryRule
- spatialFunctionRule

### Regole di Controllo Flusso

- caseClauseRule
- othersRule
- whereCaseRule
- generateSectionRule

---

---

