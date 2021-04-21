
/*****************************************************************/
/********************* TP01 Compilation 2021 *********************/
/*****************************************************************/
/****************** Made with ❤ by Imed Jaberi ******************/
/**************** <https://www.3imed-jaberi.com> *****************/
/************************* MIT Licensed **************************/
/*****************************************************************/


/* variable declaration */

%{
  int  linesCounter;
  FILE *errorsLogger;
%}

/* regexp declaration aka rules */

NEW_LINE            \n

STRING              ["].*[a-zA-Z0-9 ]*.*["]
ERROR_STRING        ["].*

REAL                [+-]?[0-9]*[.][0-9]*e?[+-]?[0-9]+
ERROR_REAL          [+-]?[0-9]*[.][0-9]*e

INTEGER             [+-]?[0-9]+
ERROR_INTEGER       [+-].*

IDENTIFIER          [a-zA-Z_]+[a-zA-Z0-9]*

COMMENT             [#][ ]*[a-zA-Z0-9]*

KEYWORDS            ("if"|"else"|"while")

/* regexp handlers aka rules handlers */

%%
{NEW_LINE}          { ++linesCounter; }

{REAL}              { printf("REEL : %s \n", yytext); }
{ERROR_REAL}        { fprintf(errorsLogger, "%s *** ligne %d *** exposant attendu\n", yytext, linesCounter); }

{INTEGER}           { printf("ENTIER : %s \n", yytext); }
{ERROR_INTEGER}     { fprintf(errorsLogger, "%s *** ligne %d *** nombre attendue\n", yytext, linesCounter); }

{STRING}            { printf("CHAINE : %s \n", yytext); }
{ERROR_STRING}      { fprintf(errorsLogger, "%s *** ligne %d *** fin de chaine attendue\n", yytext, linesCounter); }

{KEYWORDS}          { printf("MCLEF : %s \n", yytext); }

{IDENTIFIER}        { printf("IDENT : %s \n", yytext); }

{COMMENT}           { printf("COMMENT : %s \n", yytext); }

.                   { printf("caractere incorrect\n"); }
%%

/* end of file handler. when yylex is finished */
int yywrap(){
  return 1;
}

/* behaviour flow */
void main(int argc, char *argv[]){
  /* initialize the line counter variable */
  linesCounter = 1;
  /* initialize the errorsLogger variable by create a file then open it with write and update mode */
  errorsLogger = fopen("analyzer_erros_output.log", "w+");
  /* expect file passed as arg to the program ---> pass it to yyin */
  yyin = fopen(argv[1], "r");
  /* call the lexical analyzer (handler) */
  yylex();
  /* close the errors logger file */
  fclose(errorsLogger);
  /* close the input file */
  fclose(yyin);
}
