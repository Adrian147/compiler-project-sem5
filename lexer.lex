structure Tokens = Tokens

type pos = int
type svalue = Tokens.svalue
type ('a,'b) token = ('a,'b) Tokens.token
type lexresult     = (svalue,pos) token

val lineNum = ErrorMsg.lineNum
val linePos = ErrorMsg.linePos
fun err(p1,p2) = ErrorMsg.error p1

fun eof() = let val pos = hd(!linePos) in Tokens.EOF(pos,pos) end

%%
%header (functor FooLexFun(structure Tokens: Foo_TOKENS));
%%

\n	            => (lineNum := !lineNum+1; linePos := yypos :: !linePos; continue());
"break"	        => (Tokens.BREAK(yypos, yypos + 5));
"continue"	    => (Tokens.CONTINUE(yypos, yypos + 8));
"||"	        => (Tokens.OR(yypos, yypos + 2));
"&&"	        => (Tokens.AND(yypos, yypos + 2));
"~"	            => (Tokens.UMINUS(yypos, yypos + 1));
"!"	            => (Tokens.NEG(yypos, yypos + 1));
">="	        => (Tokens.GE(yypos, yypos + 2));
">"	            => (Tokens.GT(yypos, yypos + 1));
"<="	        => (Tokens.LE(yypos, yypos + 2));
"<"	            => (Tokens.LT(yypos, yypos + 1));
"!="	        => (Tokens.NEQ(yypos, yypos + 2));
"="	            => (Tokens.EQ(yypos, yypos + 1));
":="	        => (Tokens.ASSIGN(yypos, yypos + 2));
"do"	        => (Tokens.DO(yypos, yypos+2));
"while"	        => (Tokens.WHILE(yypos, yypos+5));
"if"	        => (Tokens.IF(yypos, yypos+2));
"then"	        => (Tokens.THEN(yypos, yypos+4));
"else"	        => (Tokens.ELSE(yypos, yypos+4));
"end"           => (Tokens.END(yypos, yypos+3));
"true"	        => (Tokens.TRUE(yypos, yypos+4));
"false"	        => (Tokens.FALSE(yypos, yypos+4));
"/"	            => (Tokens.DIVIDE(yypos, yypos + 1));
"*"	            => (Tokens.TIMES(yypos, yypos + 1));
"-"	            => (Tokens.MINUS(yypos, yypos + 1));
"+"	            => (Tokens.PLUS(yypos, yypos + 1));
"%"	            => (Tokens.MOD(yypos, yypos + 1));
";"	            => (Tokens.SEMICOLON(yypos,yypos+1));
"EOF"	        => (Tokens.EOF(yypos, yypos+3));
" "		        => (continue());
[0-9]+			=> (Tokens.NUM(valOf(Int.fromString(yytext)), yypos, yypos + (size yytext)));
[a-z][a-z0-9_]* => (Tokens.ID(yytext, yypos, yypos + (size yytext)));
.               => (ErrorMsg.error yypos ("illegal character " ^ yytext); continue());

