
:- use_module(library(logicmoo_user)).

:-file_begin(pfc).

tCol(tFly).
tCol(tCanary).
tCol(tPenguin).
tCol(tBird).

genls(tCanary,tBird).
genls(tPenguin,tBird).


% chilly is a penguin.
tPenguin(iChilly).

:-mpred_test((tBird(iChilly))).


% tweety is a canary.
tCanary(iTweety).

:-mpred_test((tBird(iTweety))).


% birds fly by default.
(mdefault(( tBird(X) ==> tFly(X)))).

:-mpred_test((isa(I,tFly),I=iChilly)).

:-mpred_test((tFly(iTweety))).
:-mpred_test((tFly(iChilly))).


% penguins do  ~ tFly.
tPenguin(X) ==>  ~(tFly(X)).

:-mpred_test((\+ tFly(iChilly))).
:-mpred_test(( ~(tFly(iChilly)))).



