# List of tokens of the JCo Query Language

| Token | Definition |
| ----- | ---------- | 
| **Macro** | |
| LETTER 	| \['A'..'Z' \| 'a'..'z'\] |
| DIGIT0	| \['1'..'9'\] |
| DIGIT  	| \['0'..'9'\] |
| WS 		| \[ ' '  \|  '\t'  \|  '\r'  \|  '\n'  \]+  |
| **Boolean Operators** | | 
| AND | 'AND' |
| OR  | 'OR' |
| NOT | 'NOT' |
| **Reserved Words** | |
| ADDING			| 'ADDING'|
| ADD_ST  	 		| 'ADD'|
| AGGREGATE 	    | 'AGGREGATE'|
| ALL         	  	| 'ALL'|
| ALPHACUT			| 'ALPHACUT'|
| AREA				| 'AREA'|
| ARRAY   	      	| 'ARRAY'|
| ARRAY_FUNCTION	| ( 'MIN' \| 'MAX' \| 'AVG' \| 'SUM') '_ARRAY' |
| AS        	    | 'AS'|
| BODY				| 'BODY' | 
| END_BODY			| 'END' WS 'BODY' |
| BOOLEAN 	      	| 'TRUE' \| 'FALSE'|
| BUILD 			| 'BUILD'|
| BY          	  	| 'BY'|
| CALL          	| 'CALL'|
| CASE          	| 'CASE'|
| CHECK_FOR			| 'CHECK' WS 'FOR'|
| COLLECTION  	  	| 'COLLECTION'|
| COLLECTIONS   	| 'COLLECTIONS'|
| CREATE_FO			| 'CREATE' WS 'FUZZY' WS 'OPERATOR'|
| CREATE_JF			| 'CREATE' WS 'JAVASCRIPT' WS 'FUNCTION'|
| DB      	      	| 'DB'|
| DEFAULT			| 'DEFAULT'|
| DEFUZZIFY			| 'DEFUZZIFY'|
| DICTIONARY		| 'DICTIONARY'|
| DIRECTION			| 'DIRECTION'|
| DISTANCE			| 'DISTANCE'|
| DOCUMENTS			| 'DOCUMENTS'|
| DROP  	        | 'DROP'|
| DROPPING      	| 'DROPPING'|
| DUPLICATES  	  	| 'DUPLICATES'|
| EACH				| 'EACH'|
| EXPAND    	    | 'EXPAND'|
| EVALUATE			| 'EVALUATE'|
| FIELD				| 'FIELD'|
| FIELDS			| 'FIELDS'|
| FILTER    	    | 'FILTER'|
| FIRST	  	      	| 'FIRST'|
| FOR				| 'FOR'|
| FROM				| 'FROM'|
| FUZZY				| 'FUZZY'|
| GENERATE			| 'GENERATE'|
| GEOMETRY  	    | 'GEOMETRY'|
| GET         	 	| 'GET'|
| GROUP         	| 'GROUP'|
| GROUPING	      	| 'GROUPING'|
| HOWINCLUDE		| 'HOW_INCLUDE'|
| HOWINTERSECT		| 'HOW_INTERSECT'|
| HOWMEET			| 'HOW_MEET'|
| IF_ERROR			| 'IF_ERROR'|
| IF_FAILS			| 'IF_FAILS'|
| INCLUDED    	  	| 'INCLUDED'|
| INPUT		      	| 'INPUT'|
| INRANGE		    | 'IN_RANGE'|
| INTERSECT			| 'INTERSECT'|
| INTERSECTION	 	| 'INTERSECTION'|
| INTO	          	| 'INTO'|
| ISNULL			| 'IS' WS 'NULL'|
| ISNOTNULL			| 'IS' WS 'NOT' WS 'NULL'|
| JOIN      	    | 'JOIN'|
| KEEP        		| 'KEEP'|
| KEEPING  	    	| 'KEEPING'|
| KNOWN				| 'KNOWN'|
| LAST  		    | 'LAST'|
| LEFT	    	    | 'LEFT'|
| LOOKUP	 		| 'LOOKUP'|
| MATCHING		  	| 'MATCHING'|
| MEET    	    	| 'MEET'|
| MEMBERSHIP_OF 	| 'MEMBERSHIP_OF'|	
| MERGE         	| 'MERGE'|
| MIN_SIMILARITY	| 'MIN' WS 'SIMILARITY'|
| OF        		| 'OF'|
| ON       	  		| 'ON'|
| ORIENTATION 	 	| 'ORIENTATION'|
| OTHERS			| 'OTHERS'|
| ORDER				| 'ORDER' \| 'SORTED'|
| PARAMETERS		| 'PARAMETERS'|
| PARTITION 		| 'PARTITION'|
| POINT				| 'POINT'|
| POLYLINE			| 'POLYLINE'|
| PRECONDITION		| 'PRECONDITION'|
| RESOLVING			| 'RESOLVING'|
| RIGHT     		| 'RIGHT'|
| REMOVE    		| 'REMOVE'|
| SAVE        		| 'SAVE'|
| SERVER     		| 'SERVER'|
| SET      	  		| 'SET'|
| SETS          	| 'SETS'|
| SETTING  	    	| 'SETTING'|
| SUBTRACT  		| 'SUBTRACT'|
| TO          		| 'TO'|
| TO_POLYLINE 		| 'TO_POLYLINE'|
| THRESHOLD 		| 'THRESHOLD'|
| TRANSLATE			| 'TRANSLATE'|
| TRAJECTORY 		| 'TRAJECTORY'|
| TYPE				| 'TYPE'|
| UNCOMPARABLE		| 'UNCOMPARABLE'|
| UNKNOWN			| 'UNKNOWN'|
| UNPACK	    	| 'UNPACK'|
| USE     	    	| 'USE'|
| USING     		| 'USING'|
| VERSUS      		| 'DESC' \| 'ASC'|
| WEB				| 'WEB'|
| WHERE	        	| 'WHERE'|
| WITH  	    	| 'WITH'|
| WITHIN  	    	| 'WITHIN'|
| WITHOUT   		| 'WITHOUT'|
| WRT           	| 'WRT'|
| ------------- | ---------------|
| INT			| \[ '0' \| DIGIT0 DIGIT* ] |
| FLOAT     	| \[DIGIT0 DIGIT* DOT DIGIT+ \| '0' DOT DIGIT+] | 
| ID			| LETTER \[ LETTER \| DIGIT \| '\_' \]* |
| FIELD_NAME	| \[ DOT \[LETTER \| DIGIT \| '\_']+ )  \| DOT QUOTE \[~QUOTE]* QUOTE \| DOT '~geometry'  \| DOT '~fuzzysets'  \| '~geometry'] |
| **Puntuaction** | |
| AT    | '@' |
| EQ    | '=' |
| NEQ   | '!=' |
| LE    | '<=' |
| GE    | '>=' |
| LT    | '<' |
| GT    | '>' |
| DOT   | '.' |
| ADD   | '+' |
| SUB   | '-' |
| MUL   | '\*' |
| DIV   | '\\' |
| COMMA | ',' |
| COLON | ':' |
| SC    | ';' |
| LP    | '(' |
| RP    | ')' |
| LB    | '\[' |
| RB    | ']' |
| LBR   | '{' |
| RBR   | '}' |
| APEX  | '\'' |
| QUOTE | '"' |
| SLASH | '/' |
| TILDE | '~' |
| ------------- | ---------------|
| WHITE_SPACES | WS | 
| APEX_VALUE |  APEX \[~APEX) \]* APEX |
| QUOTED_VALUE |  QUOTE \[~QUOTE \]* QUOTE |
| COMMENT  |   '//' _whatever in Java style_ |
| COMMENT  |   '/*' _whatever in Java style_ '\*/' |
