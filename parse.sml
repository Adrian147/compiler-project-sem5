fun writeFile filename content =
    let val fd = TextIO.openOut filename
        val _ = TextIO.output (fd, content) handle e => (TextIO.closeOut fd; raise e)
        val _ = TextIO.closeOut fd
    in () end

structure Parse : sig val parse : string -> Ast.program end =
struct
  structure FooLrVals = FooLrValsFun(structure Token = LrParser.Token)
  structure Lex = FooLexFun(structure Tokens = FooLrVals.Tokens)
  structure FooP = Join(structure ParserData = FooLrVals.ParserData
			structure Lex = Lex
			structure LrParser = LrParser)
  fun parse filename =
      let val _ = (ErrorMsg.reset(); ErrorMsg.fileName := filename)
	  val file = TextIO.openIn filename
	  fun get _ = TextIO.input file
	  fun parseerror(s,p1,p2) = ErrorMsg.error p1 s
	  val lexer = LrParser.Stream.streamify (Lex.makeLexer get)
	  val (absyn, _) = FooP.parse(30,lexer,parseerror,())
	  val translated = (Translate.starttranslate(absyn))
	  val result = writeFile (filename ^ ".js") translated
       in TextIO.closeIn file;
       absyn
      end handle LrParser.ParseError => raise ErrorMsg.Error
end;

val runcomp = case CommandLine.arguments() of [x] => let val par =  Parse.parse x; in print ("Done!\n") end | _ => print ("No file given! \n")

