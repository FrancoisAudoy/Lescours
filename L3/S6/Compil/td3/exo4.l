%{
#include <stdio.h>
#include <stdlib.h>
#include "exo5.h"

int fileno();

%}
%option noyywrap noinput nounput
SEP [ \t\n]

%%
"+" {/*printf("%s",yytext);*/return Pl;}
"-" {/*printf("%s",yytext);*/return Mo;}
"*" {/*printf("%s",yytext);*/return Mu;}
"/" {/*printf("%s",yytext);*/return Di;}
[0-9]+ {yylval = atoi(yytext);return NUMBER;}
"(" {return Pg;}
")" {return Pd;}
. {;}
<<EOF>> {return 0;}
%%

