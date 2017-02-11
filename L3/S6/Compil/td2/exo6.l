%{
#include <stdio.h>
#include <stdlib.h>
#include "environ.h"
#include "bilquad.h"

BILQUAD* liste;
%}

ETIQ [A-Z][A-Z0-9]*
OP [A-Z][a-z]
VAR [A-Za-z][A-Za-z0-9]*
CONST [0-9]*
SEP [" "|\t|":"]*

%s ETIQUETTE OPERATEUR ARG1 ARG2 RESULTAT
%%
<ETIQUETTE,INITIAL>{ETIQ} {printf("lu:%s\n", yytext);}
<ETIQUETTE,INITIAL>":" {BEGIN OPERATEUR;printf("etiquette -> operateur\n");}
<OPERATEUR>{OP} {printf("lu :%s\n", yytext);}
<OPERATEUR>":" {BEGIN ARG1; printf("operateur -> arg1\n");}
<ARG1>{VAR}|{CONST} {printf("lu :%s\n",yytext);}
<ARG1>":" {BEGIN ARG2;printf("arg1 -> arg2 \n");}
<ARG2>{VAR}|{CONST} {printf("lu :%s\n",yytext);}
<ARG2>":" {BEGIN RESULTAT; printf("arg2 -> resultat\n");}
<RESULTAT>{VAR} {printf("lu :%s\n",yytext);}
<RESULTAT>\n {BEGIN ETIQUETTE; printf("resultat -> etiquette\n");}
<ETIQUETTE,RESULTAT><<EOF>> {printf("tout s'est bien déroulé\n"); return 0;}
<OPERATEUR,ARG1,ARG2><<EOF>> {printf("il y eu des erreurs\n");return 0;}
.|\n {}
%%

int main(int argc, char** argv){
yylex();
return 0;
}
