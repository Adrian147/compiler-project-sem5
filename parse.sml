structure Parse : sig val parse : string -> Ast.program end =
struct

  structure FooLrVals = FooLrValsFun(structure Token = LrParser.Token)
  structure Lex = FooLexFun(structure Tokens = FooLrVals.Tokens)
  structure FooP = Join(structure ParserData = FooLrVals.ParserData
			structure Lex = Lex
			structure LrParser = LrParser)


  fun parse filename =
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

val args = CommandLine.arguments()
fun unitToString () = "()"

fun drive (x :: "-i" :: xs) = let
                                val ast = Parse.parse x
                                val jstr= Translate.starttranslate(ast)
                                val out = print(jstr)
                              in
                                drive (x :: "-i" :: xs)
                                (*print "\n/*Generated Code Successfully*/\n"*)
                              end
  | drive (x :: y :: xs) = let
                            val ast = Parse.parse x
                            val jstr   = Translate.starttranslate(ast)

                            val fout   = TextIO.openOut y
                            val fwrite = TextIO.output(fout, jstr)
                          in
                            print "\n/*Generated Code Successfully*/\n"
                          end
  | drive [x]       = let
                        val b = Parse.parse x
                      in
                        print "\n/*Generated Code Successfully*/\n"
                      end
  | drive _         =   print "Invalid Syntax\n";
