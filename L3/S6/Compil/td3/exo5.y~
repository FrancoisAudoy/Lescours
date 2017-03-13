%{
  #include <stdio.h>
  #include <stdlib.h>

  int yyerror(char*);
  int yylex();

  %}

%start A
%token NUMBER
%%
A : E'\n' {;}
E : E'+'T {;}
| E'-'T {;}
| T {;}

T : T'*'F {;}
| T'/'F {;}
| F {;}

F : NUMBER {;}
| '('E')'
;
%%

int yyerror(char *s){
  fprintf(stderr," *** ERROR: %s\n",s);
  return 0;
}

int main(int argc, char ** argv){
  yyparse();
  return 0;
}
