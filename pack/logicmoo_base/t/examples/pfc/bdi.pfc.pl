

:- use_module(library(logicmoo_user)).


bel(A1,desire(A2,know(A2,bel(A1,P))))
self(A1),
bel(A1,P)
==>
tell(A1,A2,P).


bel(A1,desire(A2,knowif(A2,P))),
self(A1),
bel(A1,( ~P))
==>
tell(A1,A2,( ~P)).


