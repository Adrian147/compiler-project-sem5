structure Parse : sig val parse : string * int -> Ast.program end =
struct

  structure FooLrVals = FooLrValsFun(structure Token = LrParser.Token)
  structure Lex = FooLexFun(structure Tokens = FooLrVals.Tokens)
  structure FooP = Join(structure ParserData = FooLrVals.ParserData
			structure Lex = Lex
			structure LrParser = LrParser)

      fun value NONE = ""
        | value x    = valOf x

  fun parse (A        ,0) = let
        fun parseerror(s,p1,p2) = ErrorMsg.error p1 s
        val file  = TextIO.stdIn
        fun get _ =  value(TextIO.inputLine(file))

        val lexer    = LrParser.Stream.streamify (Lex.makeLexer get)
        val (ast, _) = FooP.parse(30,lexer,parseerror,())
        val file  = TextIO.closeIn file;
      in
        ast
      end
    | parse (filename, y) =
      let
        val _ = (ErrorMsg.reset(); ErrorMsg.fileName := filename)
        fun parseerror(s,p1,p2) = ErrorMsg.error p1 s

    	  val file = TextIO.openIn filename
    	  fun get _ = TextIO.input file

    	  val lexer    = LrParser.Stream.streamify (Lex.makeLexer get)
    	  val (ast, _) = FooP.parse(30,lexer,parseerror,())
        val file  = TextIO.closeIn file;
      in
        ast
      end
        handle LrParser.ParseError => raise ErrorMsg.Error
end;

fun unitToString () = "()"

fun drive (x :: "-i" :: xs) = let
                                val ast = Parse.parse(x, 0)
                                val jstr= Translate.starttranslate(ast)
                                val out = print(jstr)
                              in
                                drive (x :: "-i" :: xs)
                                (*print "\n/*Generated Code Successfully*/\n"*)
                              end
  | drive (x :: y :: xs) = let
                            val ast = Parse.parse (x, 1)
                            val jstr   = Translate.starttranslate(ast)

                            val fout   = TextIO.openOut y
                            val fwrite = TextIO.output(fout, jstr)
                          in
                            print "\n/*Generated Code Successfully*/\n"
                          end
  | drive [x]       = let
                        val ast = Parse.parse (x, 1)
                        val jstr   = Translate.starttranslate(ast)
                      in
                        print(jstr)
                      end
  | drive _         =   print "Invalid Syntax\n";


val args = CommandLine.arguments()
val out = drive args
