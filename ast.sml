(* The abstract syntax tree for expression *)
structure Ast =
struct

  datatype id = ID of string

  datatype dataType = Int | String

  datatype binOp = Plus | Minus | Times | Divide | Mod
                 | Eq | Neq | Lt | Le | Gt | Ge
                 | And | Or

  datatype uniOp = Neg | UMinus

  datatype boolean = TRUE | FALSE

  (* The abstract syntax for expressions *)
  datatype expr  = Id of id
                 | Const of int
                 | Str of string
                 | Bool of boolean
  	             | Op of expr * binOp * expr
                 | Up of uniOp * expr
                 | Readint of string


  (*Allow {Compound statements ?} *)
  datatype statement  = VarAssn of id * expr
                      | VarDecl of dataType * id
                      | Print of expr
                      | While of expr * statement list
                      | DoWhile of statement list * expr
                      | IFT of expr * statement list
                      | IFTE of expr * statement list * statement list
                      | Forloop of statement * expr * statement * statement list
                      | Func of id * statement list
                      | Call of id
                      | Continue
                      | Break

  datatype program = Program of statement list

end
