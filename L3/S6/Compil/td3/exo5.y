%{
  #include <stdio.h>
  #include <stdlib.h>

  int yyerror(char*);
  int yylex();

  %}

%start A
%token NUMBER Pl Mo Mu Di Pg Pd
%left Pl Mo
%left Mu Di
%right Pg Pd
%%
A : E {printf("syntaxe reconnue, valeur final: %d \n",$$);}

E : E Pl T {$$ = $1 + $3;/*printf(" %d 43 %d ", $1, $3);*/}
| E Mo T {$$ = $1-$3;/*printf(" %d 44 %d ", $1, $3);*/}
| T {;}
;
T : T Mu F {$$ = $1*$3;/*printf(" %d 42 %d ", $1, $3);*/}
| T Di F {$$ = $1/$3;/*printf(" %d 45 %d ", $1, $3);*/}
| F {$$ = $1;}
;
F : NUMBER {$$=$1;}
| Pg E Pd {$$ = $2;}
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
