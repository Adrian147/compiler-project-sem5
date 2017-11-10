# Compilers Project

## Introduction
The Aim of the project is to build a compiler from Scatch using tools such as ML-Lex and ML-Yacc.
A Compiler for a simplified version of C, which creates an Abstract Parse Tree and Translates to JavaScript.

This can be further executed using Node.js or the Web Browser.


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
- lexer.lex     : Lexing tokens for the language
- grammar.grm   : Grammar for the language
- ast.sml       : The abstract syntax tree structure
- translate.sml : Translator to convert the language to JavaScript
- parse.sml     : The driver program that parses and translates the source program

### Compiling the Compiler
```
$ make 
$ ./compiler filename.txt
``` 

### Testing the output
- open `samples/index.html`
- enter file name of the JS file
- Open Dev Console (CTRL + SHIFT + C) for the output

### Contributors
- [Adrian McDonald Tariang](https://github.com/Adrian147) - 111501001
- [Sooraj Tom](https://github.com/soorajtom) - 111501036

### Attributions
- [Course on Compiler Design](https://bitbucket.org/piyush-kurur/compilers/overview)
- Modern Compiler Implementation in ML" by Andrew W. Appel

