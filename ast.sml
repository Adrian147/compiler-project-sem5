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

  datatype declaration = VarDecl of dataType * id

  datatype statement = (*Sum tin wong*)

  and coreStatement = VarAssn of id * expr
                  |   While of expr * statement
                  |   Do of expr * statement
                  |   IfT of expr * statement
                  |   IFTH of expr * statement * statement
                  |   Continue
                  |   Break
end
