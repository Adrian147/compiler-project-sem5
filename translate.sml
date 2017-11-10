structure Translate =
struct

	fun compileExp(Ast.Const(num))    = Int.toString(num)
	  | compileExp(Ast.Str(x))        = x
		| compileExp(Ast.Id(Ast.ID(x))) = x
		| compileExp(Ast.Bool (x))      =
				(case x of Ast.TRUE => "true"
								 | Ast.FALSE => "false")
		| compileExp(Ast.Op(expr1, binOp, expr2)) =
				let
					val sign = (case binOp of
							Ast.Plus => "+"
						|	Ast.Minus => "-"
						|	Ast.Times => "*"
						|	Ast.Divide => "/"
						|	Ast.Mod => "%"
						|	Ast.Eq => "==="
						|	Ast.Neq => "!="
						|	Ast.Lt => "<"
						|	Ast.Le => "<="
						|	Ast.Gt => ">"
						|	Ast.Ge => ">="
						|	Ast.And => "&&"
						|	Ast.Or => "||")
					in
						compileExp(expr1) ^ " " ^ sign ^ " " ^ compileExp(expr2)
					end
		| compileExp(Ast.Up (uniop, expr)) =
				(case uniop of
						Ast.Neg => "!"
					|	Ast.UMinus => "-")
		| compileExp(Ast.Readint (prmpt)) = "parseInt(prompt(" ^ prmpt ^ "))"
		(*	| compileExp _ = "Unknown Error!" *)

	fun compileStmntList (x :: xs) = compileStmnt(x) ^ ";\n" ^ compileStmntList(xs)
	  |	compileStmntList [] 			 = ""

	and compileStmnt(Ast.VarAssn (Ast.ID(x), y)) =
				x ^ " = " ^ compileExp(y) 
    | compileStmnt(Ast.VarDecl (x, Ast.ID(y))) =
				(case x of Ast.Int => "var " ^ y 
   							 | Ast.String => "var " ^ y 
   							 )
		| compileStmnt(Ast.Print(expr)) = "console.log(" ^ compileExp(expr) ^ ")"
	  | compileStmnt(Ast.While(exp, stmnts)) =
				"while(" ^ compileExp(exp) ^ ")\n {\n" ^ compileStmntList(stmnts) ^
				" \n}\n"
		| compileStmnt(Ast.DoWhile(stmnts, exp)) =
				"do \n {\n" ^ compileStmntList(stmnts) ^"\n } while("^ compileExp(exp) ^
				");\n"
		| compileStmnt(Ast.IFT(exp, stmnts)) =
				"if(" ^ compileExp(exp) ^ ")\n {\n" ^ compileStmntList(stmnts) ^ " \n}\n"
		| compileStmnt(Ast.IFTE(exp, thstmnts, elstmnts)) =
				"if(" ^ compileExp(exp) ^ ")\n {\n" ^	compileStmntList(thstmnts) ^
				" \n}\n" ^	"else\n {" ^ compileStmntList(elstmnts) ^ "}"
		| compileStmnt(Ast.Forloop(s1, expr, s2, slist)) = "for(" ^ compileStmnt(s1) ^ " ; " ^ compileExp(expr) ^
												 " ; " ^ compileStmnt(s2) ^ " )\n { " ^ compileStmntList(slist) ^ " }\n"
		| compileStmnt(Ast.Continue) = "continue"
		| compileStmnt(Ast.Break) = "break"
		(*| compileStmnt(Ast.Readstr (prmpt)) = "(prompt(" ^ prmpt ^ "))" *)
 		(*	|compileStmnt _ = "Unknown Error!"*)

		(*	|compileStmnt(Ast.Int) = "var "
				|compileStmnt(Ast.String) = "var "*)

	fun starttranslate((prog)) =
			case prog of Ast.Program(slist) => compileStmntList(slist) ^
																				"\n/*Code Generated Successfully*/\n";
end
