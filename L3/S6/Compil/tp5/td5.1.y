%{
#include  <stdio.h>
#include  <ctype.h>

int yylex();
void yyerror(const char*);

int line = 1;
%}

%error-verbose

%start start
%token Not And Or Imp Equiv Var True False Def

%left And
%left Or Imp Equiv
%nonassoc Not
%%

start: Progr ;

Progr : Instr_List Expr

Instr_List : %empty 
            | Instr_List Instr
Instr : Affect ';'
       | Func_Def ';'
Affect : Var '=' Expr 
Func_Def : Def Var '(' Arg_L ')' '=' Expr
Arg_L : %empty
      | Var
      | Arg_L ',' Var
Expr_L : %empty
       | Expr
       | Expr_L ',' Expr
Expr : True | False
     | Var
     | Var '(' Expr_L ')'
     | Expr And Expr
     | Expr Or Expr
     | Expr Imp Expr
     | Expr Equiv Expr
     | Not Expr
     | '(' Expr ')'

%%

void yyerror(const char *s){
  fprintf( stderr, "Erreur l%d: %s\n", line, s );
}

int main(int argn, char **argv){
  yyparse();
}
