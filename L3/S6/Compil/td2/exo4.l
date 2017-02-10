%{
#include <stdio.h>
#include <stdlib.h>

typedef struct deffonction{
char * fonction;
int nbr_arg;
struct deffonction * suivant;
} deffonction;

deffonction* tete_liste;
deffonction* finliste;

int nbarg =0;
char* fct;

void addfonction(char*);
deffonction* present(char*);
void setnbargument(char*, int);
int getnbargument(char*);
void libererliste();

%}

NOTVAR [while|do|if|then|else]
AFFECTATION [":="]
OPERATEUR ["+"|"*"|"-"|"/"]
SEP [";"|" "|":"]|{OPERATEUR}|{AFFECTATION}
TYPE "int"|"bool"|"char"
VAR [a-zA-Z][a-zA-Z0-9\-\_]*

%s DEFINITION UTILISATION FONCTION
%%
<INITIAL>{NOTVAR}|{SEP} {;}
<INITIAL>defun {BEGIN FONCTION;}
<INITIAL>{VAR}"(" {yytext[yyleng-1] ='\0';
if (present(yytext) != NULL){
fct= (char*)malloc(yyleng);
strcpy(fct,yytext);
 BEGIN UTILISATION;};}
<FONCTION>{VAR}"(" {yytext[yyleng-1] ='\0';addfonction(yytext);fct= (char*)malloc(yyleng); strcpy(fct,yytext);BEGIN DEFINITION;}
<DEFINITION>{TYPE} {nbarg++;}
<DEFINITION>")" {setnbargument(fct, nbarg);nbarg=0; BEGIN INITIAL;}
<UTILISATION>{TYPE} {nbarg ++ ;}
<UTILISATION>")" {if(nbarg == getnbargument(fct))
 printf("Utilisation correct de %s\n",fct);
else
printf("utilisation incorrect %s\n", fct);
nbarg=0;
BEGIN INITIAL;
;}

. {;}
<<EOF>> {libererliste(); return(0);}

%%

/****** Liste *******/

int getnbargument(char* fonction){
deffonction * fct = present(fonction);
return fct->nbr_arg;
}

void setnbargument(char* fonction, int nbarg){
deffonction * fct = present(fonction);
fct->nbr_arg = nbarg;
}

deffonction* present(char * var){
deffonction* ret = tete_liste;
while(ret != NULL){
if (!strcmp(ret->fonction, var))
return ret;
ret = ret->suivant;
}
return NULL;
}

void addfonction(char* n_var){
//liste vide
if( tete_liste == NULL){
tete_liste = (deffonction*)malloc(sizeof(struct deffonction));
tete_liste->fonction = (char*) malloc(sizeof(yyleng));
strcpy(tete_liste->fonction,n_var);
finliste=tete_liste;
}
else{
//liste pas vide 
deffonction* element = NULL;
element = present(n_var);
if (element == NULL){
deffonction* new_ele = (deffonction*)malloc(sizeof(struct deffonction));
new_ele->fonction =(char*) malloc(sizeof(yyleng));
strcpy(new_ele->fonction,n_var); ;
new_ele->suivant = NULL;

finliste->suivant = new_ele;
finliste=new_ele;
}
else
printf("redefinision de fonction impossible");
}
}


void libererliste(){
deffonction* curseur;
while(tete_liste != NULL){
curseur = tete_liste;
tete_liste = tete_liste->suivant;
free(curseur);
}
}

int main(int argc, char ** argv){
yylex();
}
