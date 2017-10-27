(* The abstract syntax tree for expression *)

structure Ast =
struct

type ID = string

datatype DataType = Int | Float | String;

datatype BinOp = Plus | Minus | Times | Divide 
               | EQ | NEQ | LT | LE | GT | GE
               | AND | OR;

datatype UniOp = NEG | UMinus

(* The abstract syntax for expressions *)
datatype Expr  = Const of int
	           | Op    of Expr * BinOp * Expr;

datatype Assignment  = VarAssn of ID * Expr
                     | FunAssn of Function * ID list
end
