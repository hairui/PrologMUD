% -*-Prolog-*-

:- use_module(library(logicmoo_user)).


at(Obj,NewLoc), 
{(at(Obj,OldLoc), OldLoc\==NewLoc)}
  ==>
  ~at(Obj,OldLoc).

function(P) ==>
  {P1 =.. [P,X,Y],
   P2 =.. [P,X,Z]},
  (P1,{(P2,Y\==Z)} ==> ~P2).
  
==> function(age).

function(Name,Arity) ==>
  {functor(P1,Name,Arity),
   functor(P2,Name,Arity),
   arg(Arity,P1,PV1),
   arg(Arity,P2,PV2),
   N is Arity-1,
   merge(P1,P2,N)},
  (P1,{(P2,PV1\==PV2)} ==> ~P2).


merge(_,_,N) :- N<1.
merge(T1,T2,N) :-
  N>0,
  arg(N,T1,X),
  arg(N,T2,X),
  N1 is N-1,
  merge(T1,T2,N1).



==> function(loves,2).
==> function(governor,3).
==> function(president,1).


