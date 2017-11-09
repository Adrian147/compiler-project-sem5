structure Translate = 
struct

fun compileExp(Ast.Const(num)) = Int.toString(num)
(*	|compileExp(Ast.Bool (x)) = (case x of "TRUE" => "true" | "FALSE" => "false") *)
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
						|Ast.Ge => ">=")
							in
							compileExp(expr1) ^ " " ^ sign ^ " " ^ compileExp(expr2)
							end
	|compileExp(Ast.Up (uniop, expr)) = (case uniop of
						 Ast.Neg => "!"
						|Ast.UMinus => "-")

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
	
	
(*	|compileStmnt(Ast.Int) = "var "
	|compileStmnt(Ast.String) = "var "*)
	
end
