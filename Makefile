PHONY:
	mllex lexer.lex
	mlyacc grammar.grm
	mlton compiler.mlb
