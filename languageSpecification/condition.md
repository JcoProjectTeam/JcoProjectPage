# Pre Condition Rule instruction

The **PRECONDITION** clause specifies a logical condition that must be met before executing the instruction.


## EBNF Notation
  
preconditionRule ::= 
                'PRECONDITION' ['NOT']?
                ( identifier | stringLiteral | numberLiteral | '(' preconditionRule ')' )
                ( ( '=' | '!=' | '<' | '>' | '<=' | '>=' )
                    ( identifier | stringLiteral| numberLiteral ) | 
                    'IN_RANGE' ('(' | '[') numberLiteral ',' numberLiteral (')' | ']')
                )?
                ( ( 'AND' | 'OR' ) ['NOT']?
                    ( identifier | stringLiteral | numberLiteral | '(' preconditionRule ')')
                    (( '=' | '!=' | '<' | '>' | '<=' | '>=' )
                        ( identifier | stringLiteral | numberLiteral )
                        | 
                        'IN_RANGE' ('(' | '[') numberLiteral ',' numberLiteral (')' | ']')
                    )
                )*


