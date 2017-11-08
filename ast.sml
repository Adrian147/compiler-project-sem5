(* The abstract syntax tree for expression *)
structure Ast =
struct

  datatype id = ID of string

  datatype dataType = Int | String

  datatype binOp = Plus | Minus | Times | Divide | Mod
                 | Eq | Neq | Lt | Le | Gt | Ge
                 | And | Or

  datatype uniOp = Neg | UMinus

  (* The abstract syntax for expressions *)
  datatype expr  = Const
                 | Bool
  	             | Op of expr * binOp * expr
                 | Up of uniOp * expr


  (*Allow {Compound statements ?} *)
  datatype statement  = VarAssn of id * binOp * expr
                  |     VarDecl of dataType * id
                  |     While of expr * stmnts
                  |     DoWhile of stmnts * expr
                  |     IFT of expr * stmnts
                  |     IFTE of expr * stmnts * stmnts
                  |     Continue
                  |     Break
  and stmnts = Stmnts of statement list

  datatype program = Program of statement list
  
  fun assign a b = VarAssn(ID(a), Eq, b)
  fun decl   a b = VarDecl(a, b)
  
end



