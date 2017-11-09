structure Translate = 
struct

fun compileStmntList(x :: xs) = compileStmnt(x) :: compileStmntList(xs)
   |compileStmntList [] = ""

and compileStmnt(Ast.VarAssn (x, y)) = x ^ " = " ^ compileStmnt(y) ^ ";\n"
   |compileStmnt(Ast.VarDecl (x, y) = (case x of 
   									Ast.Int => "var " ^ y ^ ";\n"
   								  | Ast.String => "var " ^ y ^ ";\n"
   								  )
	|compileStmnt(Ast.While(exp, stmnts)) = "while(" ^ compileStmnt(exp) ^ ")\n {\n" compileStmntList(stmnts) " \n}\n"
	|compileStmnt(Ast.DoWhile(stmnts, exp)) = "do \n {\n" ^ compileStmntList(stmnts) ^ "\n } while("^ compileStmnt(exp) ^");\n"
	|compileStmnt(Ast.IFT(exp, stmnts)) = "if(" ^ compileStmnt(exp) ^ ")\n {\n" compileStmntList(stmnts) " \n}\n"
	|compileStmnt(Ast.IFTE(exp, thstmnts, elstmnts)) = "if(" ^ compileStmnt(exp) ^ ")\n {\n" ^ 
										compileStmntList(thstmnts) ^ " \n}\n" ^	"else\n {" ^ compileStmntList(elstmnts) ^ "}"
	|compileStmnt(Ast.Continue) = "continue;"
	|compileStmnt(Ast.Break) = "break;"
	
	|compileStmnt(Ast.Const(num)) = Int.toString(num)
	|compileStmnt(Ast.Bool (x)) = (case x of "TRUE" => "true" | "FALSE" => "false")
	|compileStmnt(Ast.Op(expr1, binOp, expr2) = let
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
							expr1 ^ " " ^ sign ^ " " ^ expr2
							end
	|compileStmnt(Ast.Neg) = "!"
	|compileStmnt(Ast.UMinus) = "-"
	|compileStmnt(Ast.Int) = "var "
	|compileStmnt(Ast.Strint) = "var "
	
end
