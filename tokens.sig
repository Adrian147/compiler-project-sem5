signature TOKENS = 
sig
type pos
type token

val NUM:        (int) *  pos * pos -> token
val ID:         (string) *  pos * pos -> token
val BREAK:      pos * pos -> token
val CONTINUE:   pos * pos -> token
val OR:         pos * pos -> token
val AND:        pos * pos -> token
val UMINUS:     pos * pos -> token
val NEG:        pos * pos -> token
val GE:         pos * pos -> token
val GT:         pos * pos -> token
val LE:         pos * pos -> token
val LT:         pos * pos -> token
val NEQ:        pos * pos -> token
val EQ:         pos * pos -> token
val ASSIGN:     pos * pos -> token
val DO:         pos * pos -> token
val WHILE:      pos * pos -> token
val IF:         pos * pos -> token
val THEN:       pos * pos -> token
val ELSE:       pos * pos -> token
val END:        pos * pos -> token
val TRUE:       pos * pos -> token
val FALSE:      pos * pos -> token
val DIVIDE:     pos * pos -> token
val TIMES:      pos * pos -> token
val MINUS:      pos * pos -> token
val PLUS:       pos * pos -> token
val MOD:        pos * pos -> token
val SEMICOLON:  pos * pos -> token
val EOF:        pos * pos -> token
end
