%{
#include <stdio.h>
#include <stdlib.h>
#include "environ.h"
#include "bilquad.h"

BILQUAD biliste;
int ligne = 1;
char* etiquette;
char* operateur ;
char* arg1 ;
char* arg2 ;
char* resultat ;
int rien;
ENV env;

int intop(char *);
void raz();
%}

ETIQ [A-Z][A-Z0-9]*
OP [A-Z][a-z]
VAR [A-Za-z][A-Za-z0-9]*
CONST [0-9]*
VIDE [" "|\t|]*

%s ETIQUETTE OPERATEUR ARG1 ARG2 RESULTAT
%%
<ETIQUETTE,INITIAL>{ETIQ} {printf("ligne %d: e :%s // ",ligne, yytext);
etiquette = (char*)malloc(sizeof(char));
strcpy(etiquette, yytext);}
<ETIQUETTE,INITIAL>":" {BEGIN OPERATEUR;}
<OPERATEUR>{OP} {printf("o :%s // ", yytext);
operateur = (char*)malloc(sizeof(char)); strcpy(operateur, yytext);}
<OPERATEUR>":" {BEGIN ARG1;}
<ARG1>{VAR}|{CONST} {printf("a1 :%s // ",yytext);
arg1 = Idalloc(); strcpy(arg1,yytext);;}
<ARG1>":" {BEGIN ARG2;}
<ARG2>{VAR}|{CONST} {printf("a2 :%s // ",yytext);
arg2 = Idalloc(); strcpy(arg2, yytext);}
<ARG2>":" {BEGIN RESULTAT;}
<RESULTAT>{VAR} {printf("r :%s // ",yytext);
resultat = Idalloc(); strcpy(resultat, yytext);}
<RESULTAT>\n {BEGIN ETIQUETTE; printf("\n");ligne ++;
if(biliste.debut == NULL)
biliste = creer_bilquad( creer_quad(etiquette,intop( operateur),arg1,arg2,resultat));
else
biliste =concatq(biliste,creer_bilquad(creer_quad(etiquette,intop( operateur),arg1,arg2,resultat)));
raz();}
<ETIQUETTE,RESULTAT><<EOF>> {printf("tout s'est bien déroulé\n");ecrire_bilquad(biliste); return 0;}
<OPERATEUR,ARG1,ARG2><<EOF>> {printf("il y eu des erreurs\n");ecrire_bilquad(biliste);return 0;}
.|\n {}
%%

int intop(char * op){
if(!strcmp(op,"Pl"))
return Pl;
if(!strcmp(op,"Mo"))
return Mo;
if(!strcmp(op,"Mu"))
return Mu;
if(!strcmp(op,"Af"))
return Af;
if(!strcmp(op,"Afc"))
return Afc;
if(!strcmp(op,"Sk"))
return Sk;
if(!strcmp(op,"Jp"))
return Jp;
if(!strcmp(op,"Jz"))
return Jz;
if(!strcmp(op,"St"))
return St;
else{
printf("Operateur non reconnu\n");
return 0;}
}

void raz(){
etiquette = NULL;
operateur = NULL;
arg1 = NULL;
arg2 = NULL;
resultat = NULL;
}

int main(int argc, char** argv){
yylex();
return 0;
}
