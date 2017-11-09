structure Translate = 
struct

fun compileExp(Ast.Const(num)) = Int.toString(num)
	|compileExp(Ast.Id(Ast.ID(x))) = x
	|compileExp(Ast.Bool (x)) = (case x of Ast.TRUE => "true" 
										| Ast.FALSE => "false") 
	|compileExp(Ast.Op(expr1, binOp, expr2)) = let
							val sign = (case binOp of
						 Ast.Plus => "+"
						|Ast.Minus => "-"
						|Ast.Times => "*"
						|Ast.Divide => "/"
						|Ast.Mod => "%"
						|Ast.Eq => "==="
						|Ast.Neq => "!="
						|Ast.Lt => "<"
						|Ast.Le => "<="
						|Ast.Gt => ">"
						|Ast.Ge => ">="
						|Ast.And => "&&"
						|Ast.Or => "||")
							in
							compileExp(expr1) ^ " " ^ sign ^ " " ^ compileExp(expr2)
							end
	|compileExp(Ast.Up (uniop, expr)) = (case uniop of
						 Ast.Neg => "!"
						|Ast.UMinus => "-")
(*	|compileExp _ = "Unknown Error!" *)

fun compileStmntList(x :: xs) = compileStmnt(x) ^ compileStmntList(xs)
   |compileStmntList [] = ""

and compileStmnt(Ast.VarAssn (Ast.ID(x), y)) = x ^ " = " ^ compileExp(y) ^ ";\n"
   |compileStmnt(Ast.VarDecl (x, Ast.ID(y))) = (case x of 
   									Ast.Int => "var " ^ y ^ ";\n"
   								  | Ast.String => "var " ^ y ^ ";\n"
   								  )
	|compileStmnt(Ast.While(exp, stmnts)) = "while(" ^ compileExp(exp) ^ ")\n {\n" ^
											 compileStmntList(stmnts) ^ " \n}\n"
	|compileStmnt(Ast.DoWhile(stmnts, exp)) = "do \n {\n" ^ compileStmntList(stmnts) ^ 
												"\n } while("^ compileExp(exp) ^");\n"
	|compileStmnt(Ast.IFT(exp, stmnts)) = "if(" ^ compileExp(exp) ^ ")\n {\n" ^
												 compileStmntList(stmnts) ^ " \n}\n"
	|compileStmnt(Ast.IFTE(exp, thstmnts, elstmnts)) = "if(" ^ compileExp(exp) ^ ")\n {\n" ^ 
										compileStmntList(thstmnts) ^ " \n}\n" ^	"else\n {" ^
										 compileStmntList(elstmnts) ^ "}"
	|compileStmnt(Ast.Continue) = "continue;"
	|compileStmnt(Ast.Break) = "break;"
(*	|compileStmnt _ = "Unknown Error!"*)
	
(*	|compileStmnt(Ast.Int) = "var "
	|compileStmnt(Ast.String) = "var "*)
	
fun starttranslate((prog)) = case prog of Ast.Program(slist) => compileStmntList(slist) ^ "\n/*Generated Code Successfully*/;
end



val sampleprog = [Ast.VarAssn(Ast.ID("bla"),Ast.Id(Ast.ID("axel")) )];

Translate.compileStmntList(sampleprog);
