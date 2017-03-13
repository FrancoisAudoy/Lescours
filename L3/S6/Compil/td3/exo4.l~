%{
#include <stdio.h>
#include <stdlib.h>
#include "exo5.h"

%}

%%
[0-9]+ {return NUMBER;}
.|\n {return *yytext;}
<<EOF>> {return '\n';}
%%

