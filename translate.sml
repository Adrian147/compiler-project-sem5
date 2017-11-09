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
end
