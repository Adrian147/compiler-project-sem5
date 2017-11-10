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
	fun p_tab 0 = ""
  	| p_tab n = "    " ^ p_tab(n - 1)

		fun compileStmntList ((x :: xs),ltab) =
	 			p_tab(ltab) ^ compileStmnt(x, ltab) ^ compileStmntList(xs, ltab)

   	  |	compileStmntList ([], 			 _) = ""

		and compileStmnt(Ast.VarAssn (Ast.ID(x), y), _) =
			 		x ^ " = " ^ compileExp(y) ^ ";\n"

    | compileStmnt(Ast.VarDecl (x, Ast.ID(y)), _) =
				(case x of Ast.Int => "var " ^ y ^ ";\n"
   							 | Ast.String => "var " ^ y ^ ";\n"
   							 )

		| compileStmnt(Ast.Print(expr), _) = "console.log(" ^ compileExp(expr) ^ ");\n"

	  | compileStmnt(Ast.While(exp, stmnts), ltab) =
			"while(" ^ compileExp(exp) ^ ") {\n" ^ compileStmntList(stmnts, ltab + 1)
						^ p_tab(ltab) ^"}\n"

		| compileStmnt(Ast.DoWhile(stmnts, exp), ltab) =
				"do {\n" ^ compileStmntList(stmnts, ltab + 1) ^ p_tab(ltab) ^
						"} while("^ compileExp(exp) ^
						");\n"

		| compileStmnt(Ast.IFT(exp, stmnts), ltab) =
				"if(" ^ compileExp(exp) ^ ") {\n" ^ compileStmntList(stmnts, ltab + 1) ^
						p_tab(ltab) ^ "}\n"

		| compileStmnt(Ast.IFTE(exp, thstmnts, elstmnts), ltab) =
				"if(" ^ compileExp(exp) ^ ") {\n" ^	compileStmntList(thstmnts, ltab + 1) ^
						p_tab(ltab) ^ "} else {\n" ^ compileStmntList(elstmnts, ltab + 1) ^
						p_tab(ltab) ^ "}\n"

		| compileStmnt(Ast.Forloop(s1, expr, s2, slist), ltab) =
		     "for(" ^ compileStmnt(s1, 0) ^ compileExp(expr) ^
				"; " ^ compileStmnt(s2, 0) ^ ") {\n" ^ compileStmntList(slist, ltab + 1) ^
				p_tab(ltab) ^ " }\n"

		| compileStmnt(Ast.Continue, _) = "continue;\n"

		| compileStmnt(Ast.Break, _) = "break;\n"
		(*| compileStmnt(Ast.Readstr (prmpt)) = "(prompt(" ^ prmpt ^ "))" *)
 		(*	|compileStmnt _ = "Unknown Error!"*)

		(*	|compileStmnt(Ast.Int) = "var "
				|compileStmnt(Ast.String) = "var "*)

	fun starttranslate((prog)) =
			case prog of Ast.Program(slist) => compileStmntList(slist, 0);
end
