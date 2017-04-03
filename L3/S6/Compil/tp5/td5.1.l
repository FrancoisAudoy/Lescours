%{
#include  "td5.1bison.h"

extern int line;
%}


%%
def             return     Def;
not             return     Not;
and             return     And;
or              return     Or;
-\>             return     Imp;
\<-\>           return     Equiv;
0               return     False;
1               return     True;
=               return     *yytext;
;               return     *yytext;
\(              return     *yytext;
\)              return     *yytext;
,               return     *yytext;
[a-z][a-z0-9]*  return     Var;
.               ;
\n              line++;
%%
int yywrap(){
	return    1;
}
