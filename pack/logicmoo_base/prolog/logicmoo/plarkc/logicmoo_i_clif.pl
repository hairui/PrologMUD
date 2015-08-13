/** <module> special module hooks into the logicmoo engine allow
%   clif syntax to be recocogized via our CycL/KIF handlers 
% 
% Logicmoo Project: A LarKC Server written in Prolog
% Maintainer: Douglas Miles
% Dec 13, 2035
%
*/


% this defines a recogniser for clif syntax
is_clif(all(_,X)):-cwc,compound(X),!,is_clif(X).
is_clif(forall(_,X)):-cwc,compound(X),!.
is_clif(CLIF):-cwc,
  VVs = v(if,iff,clif_forall,all,exists), % implies,equiv,forall
   (var(CLIF)-> (arg(_,VVs,F),functor(CLIF,F,2));
     compound(CLIF),functor(CLIF,F,2),arg(_,VVs,F)).

% we ensure we are in "pfc" consultation mode
:- file_begin(pfc).

% whenever we know about clif we'll use the prolog forward chainging system
(clif(CLIF)=> 
   ({ kif_to_boxlog(CLIF,HORN),
     boxlog_to_pfc(HORN,PFC)},
      % this consequent asserts the new rules
      PFC)).

% we create syntax listeners for [if,iff,clif_forall,all,exists]/2s
({is_clif(CLIF)}=>
  (CLIF/is_clif(CLIF) => clif(CLIF))).

:- if(if_defined(pfc_examples,true)).

:- wdmsg(pfc_trace).
:- pfc_trace.

% if two like each other then they are love compatable
clif(
 forall(a,forall(b,
    if( (likes(a,b)  & likes(b,a)), 
     love_compatable(a,b))))).

% if people are love compatable then they must like each other
clif(
  forall(a,forall(b,
   if(love_compatable(a,b), 
    (likes(a,b)  & likes(b,a)))))).

 
/*

  the two clauses above will have the effect... 

[
% if A is not love compatable with B .. yet B likes A.. we must conclude A must not like B back.
 (not(likes(A, B)):-not(love_compatable(A, B)), likes(B, A)),
% if A is not love compatable with B .. yet A likes B.. we must conclude B must not like A back.
 (not(likes(B, A)):-not(love_compatable(A, B)), likes(A, B)),
% if A and B like each other both ways then they are love compatable
 (love_compatable(A, B):-likes(A, B), likes(B, A))
 ]

and

 [
% if A and B must not be love compatable since A does not like B
   (not(love_compatable(A, B)):-not(likes(A, B))),
% if A and B must not be love compatable since B does not like A
   (not(love_compatable(A, B)):-not(likes(B, A))),
% obviously A likes B .. since they are love compatable
   (likes(A, B):-love_compatable(A, B)),
% obviously B likes A .. after all they are love compatable
   (likes(B, A):-love_compatable(A, B))
 ]


*/


% this uses biconditional implicatature 
clif(
 forall(a,forall(b,
  iff(scrap_compatable(a,b),
    (dislikes(a,b)  & dislikes(b,a)))))).

/*
  canonicalizes to..

 
  [

% A and B will not scrap becasue it takes two to tango and A doesnt dislike B
          (not(scrap_compatable(A, B)):-not(dislikes(A, B))),
% A and B will not scrap becasue it takes B doent dislike A (like above)
          (not(scrap_compatable(A, B)):-not(dislikes(B, A))),
% Since we can prove A and B  dislike each other we can prove they are scrap compatable
          (scrap_compatable(A, B):-dislikes(A, B), dislikes(B, A)),
%  A dislikes B  when we prove A and B are scrap compatable somehow  (this was due to the biconditional implicatature)
          (dislikes(A, B):-scrap_compatable(A, B)),
%  B dislikes A  when we prove A and B are scrap compatable
          (dislikes(B, A):-scrap_compatable(A, B))
  ]

*/

% alice likes bill
  likes(alice,bill).

% also she likes ted
  likes(alice,ted).

% we take as a given that bill does not like alice (why?)
  not(likes(bill,alice)).

% we take as a given that bill and ted dislike each other (dont blame the woman!)
 dislikes(bill,ted).
 dislikes(ted,bill).

% we support also SUMO language 
% (yes we are reading and atom.. which contains parens so we read it as sexprs
% thank you triska for showing us this neat hack ! )

clif('

(<=>
  (dislikes ?A ?B)
  (not
      (likes ?A ?B)))

').

/*
% interestingly this canonicallizes to ... 

        [ 
% A does not dislike B when A like B
	  (not(dislikes(A, B)):-likes(A, B)),
% A does not like B when A dislikes B
          (not(likes(A, B)):-dislikes(A, B)),
% A does dislikes B when we can somehow prove A not liking B
          (dislikes(A, B):-not(likes(A, B)))
        ].

% NOTE: somehow we avoid this trap! 
  likes(A,B) :- not(dislikes(A,B)).

 Though it a bit of a red herring due the the fact not(disliking(..)) in our system means 
  you have "proven by some means that not disliking is true"
    .. such means would include likes(N3, O3) .. and it does above.
   but still not sure if this is by crook.

*/


/*
 The above assertions forward chain to these side-effects... 

not(love_compatable(bill, alice)).
not(love_compatable(alice, bill)).
scrap_compatable(ted, bill).
scrap_compatable(bill, ted).


?- pfc_get_support(not(love_compatable(bill, alice))   ,Why).

 O = (not(likes(bill, alice)), pt(not(likes(bill, alice)), rhs([not(love_compatable(bill, alice))]))) ;
 O = (u, u).   % TODO fix this error


*/

% break to the debugger
:- wdmsg("press Ctrl-D to resume.").
:- break.

:- endif.


