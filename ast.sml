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
  datatype expr  = Const of int
  	           | Op of expr * binOp * expr
               | Up of uniOp * expr

  datatype program = Program of statement list

  datatype statement  = VarAssn of id * Eq * expr
                  |     VarDecl of dataType * id
                  |     While of expr * statement
                  |     Do of expr * statement
                  |     IFT of expr * statement
                  |     IFTH of expr * statement * statement
                  |     Continue
                  |     Break
end


fun assign a b = VarAssn(ID(a), Eq, b)
fun decl   a b = VarDecl(a, b)
