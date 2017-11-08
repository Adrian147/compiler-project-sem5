structure Tokens = Tokens
type pos = int
type lexresult = Tokens.token

val lineNum = ErrorMsg.lineNum
val linePos = ErrorMsg.linePos
fun err(p1,p2) = ErrorMsg.error p1

fun eof() = let val pos = hd(!linePos) in Tokens.EOF(pos,pos) end

%%
%header (functor FooLexFun(structure Tokens: Foo_TOKENS));
%%

\n	=> (lineNum := !lineNum+1; linePos := yypos :: !linePos; continue());
","	=> (Tokens.COMMA(yypos,yypos+1));
";"	=> (Tokens.SEMICOLON(yypos,yypos+1));
"IF"    => (Tokens.IF(yypos,yypos+2));
"BREAK"	=> (Tokens.BREAK(yypos, yypos+5));
"OR"	=> (Tokens.OR(yypos, yypos+2));
"AND"	=> (Tokens.AND(yypos, yypos+3));
"GE"	=> (Tokens.GE(yypos, yypos+2));
"GT"	=> (Tokens.GT(yypos, yypos+2));
"LE"	=> (Tokens.LE(yypos, yypos+2));
"LT"	=> (Tokens.LT(yypos, yypos+2));
"NEQ"	=> (Tokens.NEQ(yypos, yypos+3));
"EQ"	=> (Tokens.EQ(yypos, yypos+2));
"ASSIGN"	=> (Tokens.ASSIGN(yypos, yypos+6));
"FOR"	=> (Tokens.FOR(yypos, yypos+3));
"DO"	=> (Tokens.DO(yypos, yypos+2));
"WHILE"	=> (Tokens.WHILE(yypos, yypos+5));
"IF"	=> (Tokens.IF(yypos, yypos+2));
"THEN"	=> (Tokens.THEN(yypos, yypos+4));
"ELSE"	=> (Tokens.ELSE(yypos, yypos+4));
"DIVIDE"	=> (Tokens.DIVIDE(yypos, yypos+6));
"TIMES"	=> (Tokens.TIMES(yypos, yypos+5));
"MINUS"	=> (Tokens.MINUS(yypos, yypos+5));
"PLUS"	=> (Tokens.PLUS(yypos, yypos+4));
")"		=> (Tokens.RPAREN(yypos, yypos+1));
"("		=> (Tokens.LPAREN(yypos, yypos+1));
"{"		=> (Tokens.LBRACE(yypos, yypos+1));
"}"		=> (Tokens.RBRACE(yypos, yypos+1));
"EOF"	=> (Tokens.EOF(yypos, yypos+3));
[0-9]+			=> (Tokens.INT(valOf(Int.fromString(yytext)), yypos, yypos + (size yytext)));
[a-z][a-z0-9_]* => (Tokens.ID(yytext, yypos, yypos + (size yytext)));
" "		=> (continue());
.       => (ErrorMsg.error yypos ("illegal character " ^ yytext); continue());

