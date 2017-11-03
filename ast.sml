(* The abstract syntax tree for expression *)

structure Ast =
struct

  type id = string

  datatype dataType = Int | Float | String

  datatype binOp = Plus | Minus | Times | Divide | Mod
                 | Eq | Neq | Lt | Le | Gt | Ge
                 | And | Or

  datatype uniOp = Neg | UMinus

  (* The abstract syntax for expressions *)
  datatype expr  = Const 
                 | Bool
  	             | Op of expr * binOp * expr
                 | Up of uniOp * expr

  datatype program = Program of statement list
  
  
  (*Allow {Compound statements ?} *)
  datatype statement  = VarAssn of id * Eq * expr
                  |     VarDecl of dataType * id
                  |     While of expr * statement
                  |     DoWhile of statement * expr
                  |     IFT of expr * statement
                  |     IFTE of expr * statement * statement
                  |     Continue
                  |     Break
end


fun assign a b = VarAssn(ID(a), Eq, b)
fun decl   a b = VarDecl(a, b)
