%{
  #include <stdio.h>
  #include <stdlib.h>

  int yyerror(char*);
  int yylex();

  %}

%start A
%token ET OU NON IMPL EQUI AF V BOOL SEP
%left ET
%left OU EQUI
%right IMPL 
%left NON

%%

A: C {}
;

E: E ET E {printf("ET\n");}
| E OU E {printf("OU\n");}
| T {}
;

T: T IMPL F {printf("IMPLICATION\n");}
| T EQUI F {printf("EQUIVALENCE\n");}
| F {}
;

F : NON V {printf("NEGATION\n");}
| V {printf("VAR \n");}
| BOOL {printf("BOOL \n");}
;

Ca: V AF E {printf("Af\n");}
| E {}
;

C : Ca SEP C {}
| Ca {}
;


%%

int yyerror(char *s){
  fprintf(stderr,"****** ERROR : %s\n", s);
  return 0;
}

int main(int argc, char ** argv){
  yyparse();
  return 0;
}
