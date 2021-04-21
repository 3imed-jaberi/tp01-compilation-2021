#!/bin/bash

# clean up the dir.
rm -rf analyzer_erros_output.log *.c *.exe *.out

# execut the lexical analyzer.
flex tp01.l

# make a program using the lex output file.
gcc lex.yy.c -o tp01

# run the c program with passing the input file as arg.
./tp01 input.txt
