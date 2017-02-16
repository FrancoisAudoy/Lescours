%{
 #include <stdio.h>
  int yylex();
  int yyerror(char*);

  %}

%start A
%%
A : S'\n' {;}
S : 'a'S'b' {;}
| 'a''b' {;}
;
%%

int yylex(){
  char c = getchar();
  if (c == EOF) return('\0');
  return c;
}
int yyerror(char *s){
  fprintf(stderr, "*** ERROR %s\n",s);
  return 0;
}

int main(int argc, char **argv){
  yyparse();
  return 0;
}
