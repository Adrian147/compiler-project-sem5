structure Translate =
struct
	fun p_tab 0 = ""
		| p_tab n = "    " ^ p_tab(n - 1)

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
					|	Ast.UMinus => "-") ^ compileExp(expr)

		| compileExp(Ast.Readint (prmpt)) = "parseInt(prompt(" ^ prmpt ^ "))"
		(*	| compileExp _ = "Unknown Error!" *)

	fun compileStmntList ((x :: xs), ltab)  =
	    p_tab(ltab) ^ compileStmnt(x, ltab) ^ ";\n" ^ compileStmntList(xs, ltab)

	  |	compileStmntList ([], _) 	            = ""

	and compileStmnt(Ast.VarAssn(Ast.ID(x), y), ltab) =
				x ^ " = " ^ compileExp(y)

    | compileStmnt(Ast.VarDecl (x, Ast.ID(y)), ltab) =
				(case x of Ast.Int => "var " ^ y
   							 | Ast.String => "var " ^ y)

		| compileStmnt(Ast.Print(expr), _) = "console.log(" ^ compileExp(expr) ^ ")"

	  | compileStmnt(Ast.While(exp, stmnts), ltab) =
				"while(" ^ compileExp(exp) ^ ") {\n" ^ compileStmntList(stmnts, ltab + 1) ^
				p_tab(ltab) ^ "}"

		| compileStmnt(Ast.DoWhile(stmnts, exp), ltab) =
				"do {\n" ^ compileStmntList(stmnts, ltab + 1) ^ p_tab(ltab) ^ "} while(" ^
				 compileExp(exp) ^ ")"

		| compileStmnt(Ast.IFT(exp, stmnts), ltab) =
				"if(" ^ compileExp(exp) ^ ") {\n" ^ compileStmntList(stmnts, ltab + 1) ^
				p_tab(ltab) ^ "}"

		| compileStmnt(Ast.IFTE(exp, thstmnts, elstmnts), ltab) =
				"if(" ^ compileExp(exp) ^ ") {\n" ^	compileStmntList(thstmnts, ltab + 1) ^
				p_tab(ltab) ^ "} else {\n" ^ compileStmntList(elstmnts, ltab + 1) ^
				p_tab(ltab) ^ "}"

		| compileStmnt(Ast.Forloop(s1, expr, s2, slist), ltab) = "for(" ^
				compileStmnt(s1, ltab + 1) ^ "; " ^ compileExp(expr) ^ "; " ^
				compileStmnt(s2, ltab + 1) ^ ") {\n" ^ compileStmntList(slist, ltab + 1) ^
				p_tab(ltab) ^ "}"

		| compileStmnt(Ast.Continue, _) = "continue"

		| compileStmnt(Ast.Func (Ast.ID(fname), stmnts), ltab) =
		 		"function " ^ fname ^ "() {\n" ^ compileStmntList(stmnts, ltab + 1) ^ "}"

		| compileStmnt(Ast.Call (Ast.ID(fname)), _) = fname ^ "()"
		| compileStmnt(Ast.Break, _) = "break"
		(*| compileStmnt(Ast.Readstr (prmpt)) = "(prompt(" ^ prmpt ^ "))" *)
 		(*	|compileStmnt _ = "Unknown Error!"*)

		(*	|compileStmnt(Ast.Int) = "var "
				|compileStmnt(Ast.String) = "var "*)

	fun starttranslate((prog)) =
			case prog of Ast.Program(slist) => compileStmntList(slist, 0);
end
