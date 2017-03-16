%{
#include <stdio.h>
#include <stdlib.h>
#include "iplpbison.h"

#define YYSTYPE char*

int fileno();

%}
%option noyywrap noinput nounput

VARIABLES [A-Za-z]+
BOOLEEN [0-1]
NEGATION ("~"|"!"|"NOT"|"not"|"NON"|"non")
AND ("ET"|"et"|"Et")


%%
":=" {return AF;}
{AND} {return ET;}
"OU" | "Ou" | "ou" {return OU;}
{NEGATION} {return NON;}
"impl" | "Impl" | "->" {return IMPL;}
"equi" | "Equi" | "<->" { return EQUI;}
";" {return SEP;}
{BOOLEEN} {return BOOL;}
{VARIABLES} {return V;}
\n {}
. {}
<<EOF>> {ECHO; return 0;}
