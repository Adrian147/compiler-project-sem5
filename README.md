# Compilers Project

## Introduction
The Aim of the project is to build a compiler from Scatch using tools such as ML-Lex and ML-Yacc.

## The language
The language has a coding style that is similar to that of C. 

### Features

* mutable variables of type int and string
* arithmetic operations: + - / * % :=
* boolean operations: > < >= <= != = ! && || 
* if then clause
* if then else clause
* for loop
* while loop
* do while loop
* reading input from user
* printing output to user

## Code files:
- lexer.lex : Lexing tokens for the language
- grammar.grm : Grammar for the language
- ast.sml : The abstract syntax tree structure
- translate.sml : Translator to convert the language to JavaScript
- parse.sml : The driver program that parses and translates the source program
