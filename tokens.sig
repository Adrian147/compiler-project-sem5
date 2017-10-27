signature TOKENS = 
sig
type pos
type token

val INT: (int) *  pos * pos -> token
val ID: (string) *  pos * pos -> token
val STRING: (string) *  pos * pos -> token
val VAR:  pos * pos -> token
val BREAK:  pos * pos -> token
val OR:  pos * pos -> token
val AND:  pos * pos -> token
val GE:  pos * pos -> token
val GT:  pos * pos -> token
val LE:  pos * pos -> token
val LT:  pos * pos -> token
val NEQ:  pos * pos -> token
val EQ:  pos * pos -> token
val ASSIGN:  pos * pos -> token
val FOR:  pos * pos -> token
val DO:  pos * pos -> token
val WHILE:  pos * pos -> token
val IF:  pos * pos -> token
val THEN:  pos * pos -> token
val ELSE:  pos * pos -> token
val DIVIDE:  pos * pos -> token
val TIMES:  pos * pos -> token
val MINUS:  pos * pos -> token
val PLUS:  pos * pos -> token
val RPAREN:  pos * pos -> token
val LPAREN:  pos * pos -> token
val RBRACE:  pos * pos -> token
val LBRACE:  pos * pos -> token
val COMMA:  pos * pos -> token
val BLANK:  pos * pos -> token
val SEMICOLON:  pos * pos -> token
val EOF:  pos * pos -> token
end
