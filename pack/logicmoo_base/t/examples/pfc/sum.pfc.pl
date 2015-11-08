% -*-Prolog-*-

:- use_module(library(logicmoo_user)).

% this Pfc example shows how to maintain a sum.	
% Given a set of asssertions matching value(N), this rule
% will maintain an assertion sum(S) where S is the sum of all of the values.


value(X) ==> {addToSum(X)}.

fcUndoMethod(addToSum(X), subFromSum(X)).

addToSum(X) :-
  retract(sum(S)),
  !,
  NewS is X+S,
  assert(sum(NewS)).
addToSum(X) :- assert(sum(X)).
  
subFromSum(X) :-
  retract(sum(S)),
  NewS is S-X,
  assert(sum(NewS)),
  !.
subFromSum(X) :- 
  format('~n I can''t find a sum to subtract ~w from.',[X]).




