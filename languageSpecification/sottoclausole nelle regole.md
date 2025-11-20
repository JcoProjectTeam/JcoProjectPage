
---

---

## Componenti di Base e Token

Questa sezione elenca tutti i componenti di base utilizzati nelle regole principali.

### Token Letterali

#### INT
Numero intero.

**Definizione:**
```
INT ::= '0' | DIGIT0 DIGIT*
```

**Esempi:** `0`, `42`, `1000`

---

#### FLOAT
Numero decimale.

**Definizione:**
```
FLOAT ::= DIGIT0 DIGIT* DOT DIGIT+ | '0' DOT DIGIT+
```

**Esempi:** `3.14`, `0.5`, `123.456`

---

#### BOOLEAN
Valore booleano.

**Definizione:**
```
BOOLEAN ::= 'TRUE' | 'FALSE'
```

---

#### APEX_VALUE
Stringa racchiusa tra apici singoli.

**Definizione:**
```
APEX_VALUE ::= '\'' (~'\'')* '\''
```

**Esempi:** `'hello'`, `'Milano'`, `'Via Roma 123'`

---

#### QUOTED_VALUE
Stringa racchiusa tra doppi apici.

**Definizione:**
```
QUOTED_VALUE ::= '"' (~'"')* '"'
```

**Esempi:** `"world"`, `"path/to/file"`, `"SELECT * FROM table"`

---

#### ID
Identificatore (nome di variabile, funzione, collezione, ecc.).

**Definizione:**
```
ID ::= LETTER (LETTER | DIGIT | '_')*
```

**Esempi:** `myCollection`, `fuzzySet1`, `evaluator_name`

---

#### FIELD_NAME
Nome di un campo di un documento.

**Definizione:**
```
FIELD_NAME ::= DOT (LETTER | DIGIT | TILDE | '_')+ 
             | DOT '"' (~'"')* '"'
```

**Esempi:** `.name`, `.coordinates`, `.nested.field`, `."field with spaces"`

---

#### HASH_NAME
Nome hash (per riferimenti speciali).

**Definizione:**
```
HASH_NAME ::= '#' (LETTER | DIGIT | TILDE | '_')+ 
            | '#' '"' (~'"')* '"'
```

**Esempi:** `#id`, `#timestamp`, `#"special field"`

---

### Operatori

#### Operatori Aritmetici

- **ADD** (`+`) - Addizione
- **SUB** (`-`) - Sottrazione
- **MUL** (`*`) - Moltiplicazione
- **DIV** (`/`) - Divisione
- **EXP** (`^`) - Elevamento a potenza

---

#### Operatori di Confronto (comparatorRule)

- **EQ** (`=`) - Uguale
- **NEQ** (`!=`) - Diverso
- **LT** (`<`) - Minore di
- **GT** (`>`) - Maggiore di
- **LE** (`<=`) - Minore o uguale
- **GE** (`>=`) - Maggiore o uguale

---

#### Operatori Logici

- **AND** - Congiunzione logica
- **OR** - Disgiunzione logica
- **NOT** - Negazione logica

---

### Delimitatori

- **LP** `(` - Parentesi tonda aperta
- **RP** `)` - Parentesi tonda chiusa
- **LB** `[` - Parentesi quadra aperta
- **RB** `]` - Parentesi quadra chiusa
- **LBR** `{` - Parentesi graffa aperta
- **RBR** `}` - Parentesi graffa chiusa
- **COMMA** `,` - Virgola
- **COLON** `:` - Due punti
- **SC** `;` - Punto e virgola (fine istruzione)
- **DOT** `.` - Punto
- **AT** `@` - Chiocciola

---

### Parole Chiave per Istruzioni

#### Operazioni su Collezioni
- **GET** - Carica collezione
- **COLLECTION** / **COLLECTIONS** - Riferimento a collezione/i
- **MERGE** - Unione di collezioni
- **INTERSECT** - Intersezione di collezioni
- **SUBTRACT** - Sottrazione di collezioni
- **JOIN** - Join di collezioni
- **FILTER** - Filtra documenti
- **GROUP** - Raggruppa documenti
- **EXPAND** - Espande array
- **SAVE** - Salva risultato
- **USE** - Usa database
- **DB** - Database

---

#### Operazioni Fuzzy
- **FUZZY** - Riferimento a fuzzy sets
- **SET** / **SETS** - Insieme/i
- **ALPHACUT** - Taglio alpha
- **DEFUZZIFY** - Defuzzificazione
- **MEMBERSHIP_TO** / **MEMBERSHIP_OF** - Membership di un elemento
- **MEMBERSHIP_ARRAY** - Array di membership
- **DEGREE** - Grado di appartenenza
- **DEGREES** - Gradi (per fuzzy set model)
- **DERIVED** - Gradi derivati
- **EXTENT** - Estensione di un fuzzy set
- **WITHIN** - Dentro fuzzy sets
- **KNOWN** - Fuzzy set noto
- **UNKNOWN** - Fuzzy set sconosciuto
- **CHECK_FOR** - Verifica fuzzy set
- **USING** - Usa condizione/funzione
- **IF_FAILS** - Se fallisce

---

#### Operazioni Geometriche
- **GEOMETRY** - Geometria
- **KEEPING** - Mantiene
- **SETTING** - Imposta
- **DROPPING** - Elimina
- **POINT** - Punto geometrico
- **AGGREGATE** - Aggrega geometrie
- **TO_POLYLINE** - Converte a polilinea
- **DISTANCE** - Distanza tra geometrie
- **ORIENTATION** - Orientamento
- **INCLUDED** - Inclusione geometrica
- **MEET** - Incontro tra geometrie
- **INTERSECT** / **INTERSECTION** - Intersezione geometrica
- **HOWINCLUDE** - Come è incluso
- **HOWINTERSECT** - Come interseca
- **HOWMEET** - Come incontra

---

#### Condizioni e Controllo Flusso
- **WHERE** - Dove (condizione)
- **CASE** / **CASES** - Casi condizionali
- **IF** - Se (condizionale)
- **IF_ERROR** - Se errore
- **PARTITION** - Partizione
- **OTHERS** - Altri (documenti non corrispondenti)
- **KEEP** - Mantieni
- **DROP** - Elimina
- **REMOVE** - Rimuovi
- **DUPLICATES** - Duplicati

---

#### Trasformazioni e Generazione
- **GENERATE** - Genera nuova struttura
- **BUILD** - Costruisci struttura
- **ADD** / **ADDING** / **ADD_ST** - Aggiungi
- **FIELDS** - Campi
- **FIELD** - Campo
- **AS** - Come (alias)
- **INTO** - In (destinazione)
- **TO** - A (destinazione)
- **FROM_ARRAY** - Da array
- **EXTRACT_ARRAY** - Estrai da array
- **ARRAY** - Array
- **ARRAY_FUNCTION** - Funzione su array (MIN_ARRAY, MAX_ARRAY, AVG_ARRAY, SUM_ARRAY)

---

#### Predicati e Verifiche
- **WITH** - Con (presenza)
- **WITHOUT** - Senza (assenza)
- **ISNULL** - È null
- **ISNOTNULL** - Non è null
- **INRANGE** - In intervallo
- **TRANSLATE** - Traduci usando dizionario

---

#### Funzioni e Operatori Custom
- **CREATE** - Crea
- **FUNCTION** - Funzione
- **OPERATOR** - Operatore
- **EVALUATOR** - Valutatore
- **AGGREGATOR** - Aggregatore
- **MODEL** - Modello
- **JAVASCRIPT** - JavaScript
- **JAVA** - Java
- **PARAMETERS** - Parametri
- **PARAMETER** - Parametro
- **PRECONDITION** - Precondizione
- **BODY** - Corpo funzione
- **END_BODY** - Fine corpo
- **CLASS** - Classe Java
- **IMPORT** - Importa classe
- **TYPE** - Tipo
- **EVALUATE** - Valuta
- **POLYLINE** - Polilinea (trasformazione)

---

#### Aggregazione e Ordinamento
- **BY** - Per (raggruppamento/ordinamento)
- **ORDER** / **SORTED** - Ordina
- **GROUPING** - Raggruppamento
- **AGGREGATE** - Aggrega (anche per geometria)
- **FOR** - Per (iterazione)
- **EACH** - Ogni
- **ALL** - Tutti
- **DERIVE** - Deriva
- **CUMULATE** - Cumula
- **LOCALLY** - Localmente
- **SORT** - Ordina
- **VERSUS** - Verso (ASC/DESC)
- **UNCOMPARABLE** - Incomparabile
- **SUM** - Somma
- **PRODUCT** - Prodotto
- **MINIMUM** - Minimo
- **MAXIMUM** - Massimo

---

#### Posizione e Direzione
- **LEFT** - Sinistra
- **RIGHT** - Destra
- **INPUT** - Input
- **DIRECTION** - Direzione
- **POS** - Posizione

---

#### Web e Database
- **FROM_WEB** - Da web
- **LOOKUP** - Cerca su web
- **CALL** - Chiama
- **SERVER** - Server
- **DEFAULT** - Default
- **DICTIONARY** - Dizionario

---

#### Traiettorie
- **TRAJECTORY** - Traiettoria
- **MATCHING** - Matching
- **WRT** - Rispetto a (With Respect To)
- **THRESHOLD** - Soglia
- **MIN_SIMILARITY** - Similarità minima

---

#### Espansione
- **UNPACK** - Spacchetta array
- **DOCUMENTS** - Documenti

---

#### Risoluzione Conflitti
- **RESOLVING** - Risoluzione
- **FIRST** - Primo
- **LAST** - Ultimo

---

#### Constraint
- **CONSTRAINT** - Vincolo
- **OF** - Di
- **ON** - Su

---

### Funzioni Speciali Predefinite

#### MEMBERSHIP_TO(id)
Restituisce il valore di membership di un fuzzy set.

**Sintassi:** `MEMBERSHIP_TO(fuzzySetName)`

---

#### EXTENT(id)
Restituisce l'estensione di un fuzzy set.

**Sintassi:** `EXTENT(fuzzySetName)`

---

#### DEGREE(id [.field])
Restituisce il grado di un fuzzy set (opzionalmente su un campo specifico).

**Sintassi:** `DEGREE(degreeName)` o `DEGREE(degreeName.field)`

---

#### HASH_NAME [.field]
Riferimento al nome hash del documento.

**Sintassi:** `#fieldName` o `#"field name"`

---

#### MEMBERSHIP_ARRAY(...)
Restituisce un array di membership.

**Sintassi:**
- `MEMBERSHIP_ARRAY(ALL)`
- `MEMBERSHIP_ARRAY(id FROM ARRAY fieldRef)`
- `MEMBERSHIP_ARRAY([id1, id2, ...])`

---

#### EXTRACT_ARRAY(fieldRef FROM ARRAY fieldRef)
Estrae un campo da ogni elemento di un array.

**Sintassi:** `EXTRACT_ARRAY(.field FROM ARRAY .arrayField)`

---

#### IF(condition, thenExpr, elseExpr)
Condizionale ternario.

**Sintassi:** `IF((condition), thenValue, elseValue)`

---

#### IF_ERROR(expr, defaultValue)
Restituisce un valore di default in caso di errore.

**Sintassi:** `IF_ERROR(expression, defaultValue)`

---

#### TRANSLATE(expr, dictionaryId [, caseSensitive [, defaultValue]])
Traduce un valore usando un dizionario.

**Sintassi:** `TRANSLATE(value, dictionaryName, TRUE, "default")`

---

#### MIN_ARRAY, MAX_ARRAY, AVG_ARRAY, SUM_ARRAY
Funzioni di aggregazione su array.

**Sintassi:** 
```
MIN_ARRAY(fieldRef, comparatorId [, fields...])
MAX_ARRAY(.array, myComparator, .field1, .field2)
AVG_ARRAY([expr1, expr2, ...], numericComparator)
SUM_ARRAY(.values, sumOperator)
```

---

#### DISTANCE(id)
Calcola la distanza tra geometrie (in JOIN).

**Sintassi:** `DISTANCE(left)` o `DISTANCE(right)`

---

#### ORIENTATION(left|right [, id: value])
Calcola l'orientamento tra geometrie.

**Sintassi:** `ORIENTATION(LEFT)` o `ORIENTATION(RIGHT, angle: 45)`

---

#### INCLUDED(left|right)
Verifica se una geometria è inclusa nell'altra.

**Sintassi:** `INCLUDED(LEFT)` o `INCLUDED(RIGHT)`

---

### Strutture Composte

#### Object Structure
Definisce la struttura di un oggetto JSON.

**Sintassi:**
```
{ .field1, .field2: expression, .nested: { .subfield } }
```

---

#### Array Literal
Array di valori o espressioni.

**Sintassi:**
```
[value1, value2, expression3]
```

---

#### Range
Intervallo numerico per INRANGE.

**Sintassi:**
```
IN_RANGE [min, max]    // chiuso su entrambi i lati
IN_RANGE (min, max)    // aperto su entrambi i lati
IN_RANGE [min, max)    // chiuso a sinistra, aperto a destra
IN_RANGE (min, max]    // aperto a sinistra, chiuso a destra
```

---

### Fuzzy Set Management

#### DEFUZZIFY
Rimuove tutti i fuzzy sets e mantiene solo i valori defuzzificati.

---

#### DROPPING ALL FUZZY SETS
Elimina tutti i fuzzy sets dai documenti.

---

#### KEEPING ALL FUZZY SETS
Mantiene tutti i fuzzy sets nei documenti.

---

#### DROPPING FUZZY SETS id1, id2, ...
Elimina fuzzy sets specifici.

---

#### KEEPING FUZZY SETS id1, id2, ...
Mantiene solo fuzzy sets specifici.

---

### Polyline Transformation
Trasformazione polilinea per funzioni fuzzy.

**Sintassi:**
```
POLYLINE [(x1, y1), (x2, y2), (x3, y3), ...]
```

Applica una trasformazione lineare a tratti all'output di una funzione fuzzy.

---

### Aggregation Specifications (Fuzzy Evaluator)

#### WITH SUM
Aggrega usando la somma.

#### WITH PRODUCT
Aggrega usando il prodotto.

#### WITH MINIMUM
Aggrega usando il minimo.

#### WITH MAXIMUM
Aggrega usando il massimo.

---

### Special Keywords in Context

#### FOR ALL ... IN ... AGGREGATE
Itera su array e aggrega risultati (fuzzy evaluator/aggregator).

**Sintassi:**
```
FOR ALL item IN arrayName
  LOCALLY expr1 AS var1, expr2 AS var2
  AGGREGATE expr AS result
```

---

#### DERIVE ... AS
Deriva un valore intermedio (fuzzy evaluator).

**Sintassi:**
```
DERIVE expression AS variableName
DERIVE CUMULATE(arrayName) AS cumulativeVar
```

---

#### SORT ... BY ... AS
Ordina array (fuzzy evaluator).

**Sintassi:**
```
SORT item IN array BY item.field TYPE comparatorName AS sortedArray
SORT (i IN arr1, j IN arr2) BY i.field TYPE comp AS (sorted1, sorted2)
```

---

#### EVALUATE
Valuta espressione (fuzzy operator/evaluator).

**Sintassi:**
```
EVALUATE expression
EVALUATE degreeName AS expression
```

---

### Type Specifications

Usato in **PARAMETERS**, **TYPE**, **ORDER BY**:

- Tipi primitivi: `Number`, `String`, `Boolean`, `Date`
- Tipi complessi: `Array`, `Object`, `Geometry`
- Tipi fuzzy: Nome del fuzzy set model
- Tipi custom: Nome di un tipo definito dall'utente

---

### Direction Keywords

#### LEFT
Riferimento alla collezione di sinistra (in JOIN, TRAJECTORY).

#### RIGHT
Riferimento alla collezione di destra (in JOIN, TRAJECTORY).

#### ALL
Tutti gli elementi/fuzzy sets.

---

### Fuzzy Set Model Keywords

#### DEGREES
Definisce i gradi di base del fuzzy set model.

**Sintassi:**
```
DEGREES degree1, degree2, degree3
```

---

#### DERIVED DEGREES
Definisce gradi derivati da espressioni.

**Sintassi:**
```
DERIVED DEGREES derivedDegree1 AS expression1, derivedDegree2 AS expression2
```

---

#### CONSTRAINT
Definisce vincoli sul fuzzy set model.

**Sintassi:**
```
CONSTRAINT condition
```

---

#### OPERATOR
Definisce operatori fuzzy (AND, OR, NOT).

**Sintassi:**
```
OPERATOR AND EVALUATE degreeName AS expression
OPERATOR OR EVALUATE degreeName AS expression
OPERATOR NOT EVALUATE degreeName AS expression
```

---

## Categorie di Componenti

### 1. Identificatori e Riferimenti
- `ID` - Identificatori generici
- `FIELD_NAME` - Nomi di campi
- `HASH_NAME` - Nomi hash
- `fieldRefRule` - Riferimenti a campi
- `collectionReferenceRule` - Riferimenti a collezioni

### 2. Valori Letterali
- `INT`, `FLOAT` - Numeri
- `BOOLEAN` - Booleani
- `APEX_VALUE`, `QUOTED_VALUE` - Stringhe
- `valueRule` - Regola per valori

### 3. Espressioni
- `expressionRule` - Espressioni aritmetiche complete
- `restrictedExpressionRule` - Espressioni senza condizioni
- `jfExpressionRule` - Espressioni per funzioni Java/JavaScript
- `feExpressionRule` - Espressioni per fuzzy evaluator
- `ftExpressionRule` - Espressioni per fuzzy type

### 4. Condizioni
- `orConditionRule` - Condizioni logiche standard
- `jfOrConditionRule` - Condizioni per funzioni
- `usingOrConditionRule` - Condizioni per fuzzy sets
- `ftOrConditionRule` - Condizioni per fuzzy types

### 5. Predicati
- `predicateRule` - Predicati standard
- `nullPredicateRule` - Verifica null
- `withPredicateRule` - Verifica presenza
- `withoutPredicateRule` - Verifica assenza
- `wukFuzzyPredicateRule` - Predicati fuzzy

### 6. Strutture Dati
- `objectStructureRule` - Struttura oggetti JSON
- `arrayFunctionRule` - Funzioni su array
- Delimitatori: `LBR/RBR` (oggetti), `LB/RB` (array), `LP/RP` (espressioni)

### 7. Operatori
- Aritmetici: `ADD`, `SUB`, `MUL`, `DIV`, `EXP`
- Confronto: `EQ`, `NEQ`, `LT`, `GT`, `LE`, `GE`
- Logici: `AND`, `OR`, `NOT`
- Speciali: `INRANGE`, `TYPE`, `AS`, `AT`

### 8. Parole Chiave di Controllo
- Condizionali: `IF`, `WHERE`, `CASE/CASES`
- Iterazione: `FOR`, `EACH`, `ALL`
- Output: `KEEP`, `DROP`, `REMOVE`, `GENERATE`

### 9. Fuzzy Specific
- Sets: `FUZZY`, `SETS`, `DEFUZZIFY`
- Membership: `MEMBERSHIP_TO`, `MEMBERSHIP_ARRAY`, `DEGREE`, `EXTENT`
- Operazioni: `ALPHACUT`, `CHECK_FOR`, `USING`
- Valutazione: `EVALUATE`, `POLYLINE`

### 10. Geometria Specific
- Base: `GEOMETRY`, `POINT`, `POLYLINE`
- Operazioni: `DISTANCE`, `ORIENTATION`, `INCLUDED`, `MEET`, `INTERSECT`
- Funzioni: `AGGREGATE`, `TO_POLYLINE`
- Gestione: `KEEPING`, `SETTING`, `DROPPING`

---

## Vedi Anche

- [Token List](./tokenList.md) - Lista completa dei token
- [Base Elements](./baseElements.md) - Elementi base
- [Predefined Functions](./predefinedFunctions.md) - Funzioni predefinite
- [Clauses Reference](./clausesReference.md) - Riferimento clausole comuni