% ===================================================================
% File 'logicmoo_util_library.pl'
% Purpose: To load the logicmoo libraries as needed
% Maintainers: Douglas Miles/Annie Ogborn/Kino Coursey
% Contact: $Author: dmiles $@users.sourceforge.net ;
% Version: 'logicmoo_util_library.pl' 1.0.0
% Revision:  $Revision: 1.7 $
% Revised At:   $Date: 2002/07/11 21:57:28 $
% ===================================================================
:-swi_module(logicmoo_util_library,
        [dynamic_transparent/1,
         upcase_atom_safe/2,
         get_module_of/2,
         call_n_times/2,
         % concat_atom_safe/3,
         makeArgIndexes/1,
         contains_singletons/1,
         doall/1,
         atom_concat_safe/3,
         exists_file_safe/1,
         exists_directory_safe/1,
         eraseall/2,
         time_file_safe/2,
         
         subst/4,
         predsubst/3,
         wsubst/4,
         remove_dupes/2,
         get_functor/2,
         get_functor/3,
         functor_h/2,
         functor_h/3,
         flatten_set/2,
         at_start/1,
         in_thread_and_join/1,
         in_thread_and_join/2,               
         make_list/3,
         throw_if_true_else_fail/2,
         if_file_exists/1,
         multi_transparent/1]).


% this is a backwards compatablity block for SWI-Prolog 6.6.6
:- dynamic(double_quotes_was_lib/1).
:- multifile(double_quotes_was_lib/1).
:- current_prolog_flag(double_quotes,WAS),asserta(double_quotes_was_lib(WAS)).
:- retract(double_quotes_was_lib(WAS)),set_prolog_flag(double_quotes,WAS).
:- current_prolog_flag(double_quotes,WAS),asserta(double_quotes_was_lib(WAS)).
:- set_prolog_flag(double_quotes,string).


% :- ensure_loaded(logicmoo_util_bugger_new).
:- ensure_loaded(logicmoo_util_bugger_catch).
:- '@'( ensure_loaded(logicmoo_util_bugger), 'user').

% :-user_use_module((logicmoo_util_strings)).
% :-user_use_module((logicmoo_util_ctx_frame)).

lastMember2(_E,List):-var(List),!,fail.
lastMember2(E,[H|List]):-lastMember2(E,List);E=H.

is_true(B):-B==true.
is_true(B):-is_proof(B).

is_proof(P):-compound(P),functor(P,ftProofFn,_).

safe_univ(Call,List):-hotrace(safe_univ0(Call,List)),!.

safe_univ0(M:Call,[N:L|List]):- nonvar(M),nonvar(N),!,safe_univ0(Call,[L|List]).
safe_univ0(Call,[M:L|List]):- nonvar(M),!,safe_univ(Call,[L|List]).
safe_univ0(M:Call,[L|List]):- nonvar(M),!,safe_univ(Call,[L|List]).
safe_univ0(Call,[L|List]):- not(is_list(Call)),sanity(atom(L);compound(Call)), Call =..[L|List],!,warn_bad_functor(L).
safe_univ0([L|List],[L|List]):- var(List),atomic(Call),!,grtrace,Call =.. [L|List],warn_bad_functor(L).
safe_univ0(Call,[L|List]):- sanity(atom(L);compound(Call)),ccatch(Call =.. [L|List],E,(dumpST,'format'('~q~n',[E=safe_univ(Call,List)]))),warn_bad_functor(L).

:- swi_export(append_term/3).
append_term(T,I,HEAD):-atom(T),HEAD=..[T,I],!.
append_term(Call,E,CallE):-var(Call), must(compound(CallE)),CallE=..ListE,append(List,[E],ListE),Call=..List.
append_term(Call,E,CallE):-must(compound(Call)), Call=..List, append(List,[E],ListE), CallE=..ListE.



% What would be a good way to describe the manipulations?
% Function: maptree func expr many
% Try applying Lisp function func to various sub-expressions of expr. 
% Initially, call func with expr itself as an argument. 
% If this returns an expression which is not equal to expr, apply func again 
% until eventually it does return expr with no changes. Then, if expr is a function call, 
% recursively apply func to each of the arguments. This keeps going until no 
% changes occur anywhere in the expression; this final expression is returned by maptree. 
% Note that, unlike simplification rules, func functions may not make destructive changes to expr. 
% If a third argument many is provided, it is an integer which says how many times func may be applied; 
% the default, as described above, is infinitely many times.
:- meta_predicate(maptree(2,+,-)).
:-swi_export(maptree/3).
maptree(Pred,I,O):- call(Pred,I,O),!.
maptree(_ ,I,O):- ( \+ compound(I) ),!, must(I=O).
maptree(Pred,[F|IL],LIST):- is_list([F|IL]), (maplist(maptree(Pred),[F|IL],LIST)),!.
maptree(Pred,I,O):- I=..[F|IL], (maplist(maptree(Pred),[F|IL],[FO|OL])),
   (atom(FO)-> O=..[FO|OL] ; must((nop(maptree(I)),O=..[F,FO|OL]))).

:- swi_export(disjuncts_to_list/3).
disjuncts_to_list(Var,[Var]):-is_ftVar(Var),!.
disjuncts_to_list(true,[]).
disjuncts_to_list([],[]).
disjuncts_to_list('v'(A,B),ABL):-!,
  disjuncts_to_list(A,AL),
  disjuncts_to_list(B,BL),
  append(AL,BL,ABL).
disjuncts_to_list([A|B],ABL):-!,
  disjuncts_to_list(A,AL),
  disjuncts_to_list(B,BL),
  append(AL,BL,ABL).
disjuncts_to_list((A;B),ABL):-!,
  disjuncts_to_list(A,AL),
  disjuncts_to_list(B,BL),
  append(AL,BL,ABL).
disjuncts_to_list(Lit,[Lit]).

:- swi_export(conjuncts_to_list/2).
conjuncts_to_list(Var,[Var]):-is_ftVar(Var),!.
conjuncts_to_list(true,[]).
conjuncts_to_list([],[]).
conjuncts_to_list('&'(A,B),ABL):-!,
  conjuncts_to_list(A,AL),
  conjuncts_to_list(B,BL),
  append(AL,BL,ABL).
conjuncts_to_list([A|B],ABL):-!,
  conjuncts_to_list(A,AL),
  conjuncts_to_list(B,BL),
  append(AL,BL,ABL).
conjuncts_to_list((A,B),ABL):-!,
  conjuncts_to_list(A,AL),
  conjuncts_to_list(B,BL),
  append(AL,BL,ABL).
conjuncts_to_list(Lit,[Lit]).


:- swi_export(pred_juncts_to_list/3).
pred_juncts_to_list(_,Var,[Var]):-is_ftVar(Var),!.
pred_juncts_to_list(_,true,[]).
pred_juncts_to_list(_,[],[]).
pred_juncts_to_list(F,AB,ABL):-AB=..[F,A,B],!,
  pred_juncts_to_list(A,AL),
  pred_juncts_to_list(B,BL),
  append(AL,BL,ABL).
pred_juncts_to_list(F,AB,AL):-AB=..[F,A],!,
  pred_juncts_to_list(A,AL).
pred_juncts_to_list(F,AB,ABL):-AB=..[F,A|ABB],
  pred_juncts_to_list(A,AL),
  B=..[F|ABB],
  pred_juncts_to_list(B,BL),
  append(AL,BL,ABL).
pred_juncts_to_list([A|B],ABL):-!,
  pred_juncts_to_list(A,AL),
  pred_juncts_to_list(B,BL),
  append(AL,BL,ABL).
pred_juncts_to_list(Lit,[Lit]).


:- swi_export(list_to_conjuncts/2).
list_to_conjuncts(I,O):-list_to_conjuncts((,),I,O).

:- swi_export(list_to_conjuncts/3).
list_to_conjuncts(_,V,V):-not(compound(V)),!.
list_to_conjuncts(_,[],true).
list_to_conjuncts(OP,[H],HH):-list_to_conjuncts(OP,H,HH).
list_to_conjuncts(OP,[H|T],Body):-!,
    list_to_conjuncts(OP,H,HH),
    list_to_conjuncts(OP,T,TT),
    conjoin_op(OP,HH,TT,Body).
list_to_conjuncts(_,H,H).

conjoin(A,B,C):-A==B,!,C=A.
conjoin(A,B,(A,B)):- (var(A);var(B)),!.
conjoin((A1,A),B,(A1,C)):-!,conjoin(A,B,C).
conjoin(true,C,C):-!.
conjoin(C,true,C):-!.
conjoin(A,B,(A,B)).

%= conjoin_op(OP,+Conjunct1,+Conjunct2,?Conjunction).
%= arg4 is a simplified expression representing the conjunction of
%= args 2 and 3.

conjoin_op(_,TRUE,X,X) :- TRUE==true, !.
conjoin_op(_,X,X,TRUE) :- TRUE==true, !.
conjoin_op(_,X,Y,Z) :- X==Y,Z=X,!.
conjoin_op(OP,C1,C2,C):-C =..[OP,C1,C2].

% =================================================================================
% Utils
% =================================================================================


read_each_term(S,CMD,Vs):- atom_string(W,S),atom_to_memory_file(W,MF),
 call_cleanup((open_memory_file(MF,read,Stream,[free_on_close(true)]),     
      findall(CMD-Vs,(
       repeat,
       catch((clpfd:read_term(Stream,CMD,[double_quotes(string),variable_names(Vs)])),_,CMD=end_of_file),
       (CMD==end_of_file->!;true)),Results)),
  free_memory_file(MF)),!,
  ((member(CMD-Vs,Results),CMD\==end_of_file)*->true;catch((clpfd:read_term_from_atom(W,CMD,[double_quotes(string),variable_names(Vs)])),_,fail)).




:- swi_export(each_subterm/2).
each_subterm(B, A):- (compound(B), arg(_, B, C), each_subterm(C, A));A=B.

:- swi_export(each_subterm/3).
each_subterm(A,Pred,B):- call( Pred,A,B).
each_subterm(A,Pred,O):- 
   compound(A),
   once(  A=[H|T] ;  A=..[H|T] ),
   (each_subterm(H,Pred,O);
     each_subterm(T,Pred,O)).



:-dynamic(argNumsTracked/3).
:-dynamic(argNFound/3).
% :-index(argNFound(1,1,1)).

makeArgIndexes(CateSig):-functor_catch(CateSig,F,_),makeArgIndexes(CateSig,F),!.
makeArgIndexes(CateSig,F):- argNumsTracked(F,Atom,Number),arg(Number,CateSig,Arg),user:nonvar(Arg),
     %%Number<10,user:nonvar(Arg),atom_number(Atom,Number),
     assert_if_new(argNFound(F,Atom,Arg)),fail.
makeArgIndexes(_NEW,_F).

flatten_dedupe(Percepts0,Percepts):-
   flatten([Percepts0],Percepts1),remove_dupes(Percepts1,Percepts).

% :- ensure_loaded(logicmoo_util_bugger).

proccess_status(_,exited(called(Det,Goal)),called(Goal2)):- Det = true,!,must_det(Goal=Goal2).
proccess_status(ID,exited(called(Det,Goal)),called(Goal2)):- dmsg(nondet_proccess_status(ID,exited(called(Det,Goal)),called(Goal2))),!,must_det(Goal=Goal2).
proccess_status(ID,true,Want):- dmsg(proccess_status(ID,true,Want)),!.
proccess_status(ID,false,Want):- dmsg(failed_proccess_status(ID,false,Want)),!,fail.
proccess_status(ID,exception(Status),Want):- dmsg(exception(Status, ID,false,Want)),!,throw(Status).
proccess_status(ID,exited(Other),Want):-dmsg(wierd_proccess_status(ID,exited(Other),Want)),!.

:- meta_predicate in_thread_and_join(0).
in_thread_and_join(Goal):-thread_create((Goal,deterministic(Det),thread_exit(called(Det,Goal))),ID,[detatched(false)]),thread_join(ID,Status),show_call(proccess_status(ID,Status,called(Goal))).
:- meta_predicate in_thread_and_join(0,+).
in_thread_and_join(Goal,Status):-thread_create(Goal,ID,[]),thread_join(ID,Status).


% ===================================================================
% Substitution based on Pred
% ===================================================================

% Usage: predsubst(+Fml,+Pred,?FmlSk)

predsubst(A,Pred, D):- 
      ccatch(hotrace(nd_predsubst(A,Pred,D)),_,fail),!.
predsubst(A,_B,A).

nd_predsubst(  Var, Pred,SUB ) :- call(Pred,Var,SUB).
nd_predsubst(  Var, _,Var ) :- var(Var),!.
nd_predsubst(  P, Pred, P1 ) :- functor_catch(P,_,N),nd_predsubst1( Pred, P, N, P1 ).

nd_predsubst1( _,  P, 0, P  ).
nd_predsubst1( Pred,  P, N, P1 ) :- N > 0, P =.. [F|Args], 
            nd_predsubst2( Pred,  Args, ArgS ),
            nd_predsubst2( Pred, [F], [FS] ),  
            univ_term(P1 , [FS|ArgS]).


nd_predsubst2( _, [], [] ).
nd_predsubst2( Pred, [A|As], [Sk|AS] ) :- call(Pred,A,Sk), !, nd_predsubst2( Pred, As, AS).
nd_predsubst2( Pred, [A|As], [A|AS]  ) :- var(A), !, nd_predsubst2( Pred, As, AS).
nd_predsubst2( Pred, [A|As], [Ap|AS] ) :- nd_predsubst( A,Pred,Ap ),nd_predsubst2( Pred, As, AS).
nd_predsubst2( _, L, L ).


% ===================================================================
% Substitution based on +PRED
% ===================================================================
/*
% Usage: subst(+Pred,+Fml,+X,+Sk,?FmlSk)

pred_subst(Pred,A,B,C,D):-  ccatch(hotrace(nd_pred_subst(Pred,A,B,C,D)),E,(dumpST,dmsg(E:nd_pred_subst(Pred,A,B,C,D)),fail)),!.
pred_subst(_,A,_B,_C,A).

nd_pred_subst(Pred,  Var, VarS,SUB,SUB ) :- call(Pred, Var,VarS),!.
nd_pred_subst(_Pred,  Var, _,_,Var ) :- var(Var),!.

nd_pred_subst(Pred,  P, X,Sk, P1 ) :- functor(P,_,N),nd_pred_subst1(Pred, X, Sk, P, N, P1 ).

nd_pred_subst1(_Pred, _,  _, P, 0, P  ).
nd_pred_subst1(Pred, X, Sk, P, N, P1 ) :- N > 0, univ_term(P , [F|Args]), 
            nd_pred_subst2(Pred, X, Sk, Args, ArgS ),
            nd_pred_subst2(Pred, X, Sk, [F], [FS] ),
            univ_term(P1 , [FS|ArgS]).

nd_pred_subst2(_, _,  _, [], [] ).
nd_pred_subst2(Pred, X, Sk, [A|As], [Sk|AS] ) :- call(Pred, X , A), !, nd_pred_subst2(Pred, X, Sk, As, AS).
nd_pred_subst2(Pred, X, Sk, [A|As], [A|AS]  ) :- var(A), !, nd_pred_subst2(Pred, X, Sk, As, AS).
nd_pred_subst2(Pred, X, Sk, [A|As], [Ap|AS] ) :- nd_pred_subst(Pred, A,X,Sk,Ap ),nd_pred_subst2(Pred, X, Sk, As, AS).
nd_pred_subst2(_, _X, _Sk, L, L ).

*/

% -- CODEBLOCK
% Usage: pred_subst(+Pred,+Fml,+X,+Sk,?FmlSk)
:- swi_export(pred_subst/5).

pred_subst( Pred, P,       X,Sk,       P1    ) :- call(Pred,P,X),!,must( Sk=P1),!.
pred_subst(_Pred, P,       _,_ ,       P1    ) :- is_ftVar(P),!, must(P1=P),!.
pred_subst( Pred,[P|Args], X,Sk,    [P1|ArgS]) :- !, pred_subst(Pred,P,X,Sk,P1),!, must(pred_subst( Pred, Args,X, Sk, ArgS )),!.
pred_subst( Pred, P,       X,Sk,       P1    ) :- compound(P),!, P =..Args, pred_subst( Pred, Args,X, Sk, ArgS ),!, must(P1 =..ArgS),!.
pred_subst(_Pred ,P,       _, _,       P     ).

% dcgPredicate(M,F,A,P).

univ_safe(P,[L|L1]):- nonvar(P), must_det((var(L);atom(L))),!,debugOnError(( P=..[L|L1] )).
univ_safe(P,L):- must_det(is_list(L)),debugOnError((P=..L)).

% ===================================================================
% Substitution based on ==
% ===================================================================

% Usage: subst(+Fml,+X,+Sk,?FmlSk)

:-moo_hide_childs(subst/4).

subst(A,B,C,D):-  hotrace((ccatch(hotrace(nd_subst(A,B,C,D)),E,(dumpST,dmsg(E:nd_subst(A,B,C,D)),fail)))),!.
subst(A,_B,_C,A).

nd_subst(  Var, VarS,SUB,SUB ) :- Var==VarS,!.
nd_subst(  Var, _,_,Var ) :- var(Var),!.

nd_subst(  P, X,Sk, P1 ) :- functor(P,_,N),nd_subst1( X, Sk, P, N, P1 ).

nd_subst1( _,  _, P, 0, P  ).
nd_subst1( X, Sk, P, N, P1 ) :- N > 0, univ_term(P , [F|Args]), 
            nd_subst2( X, Sk, Args, ArgS ),
            nd_subst2( X, Sk, [F], [FS] ),  
            univ_term(P1 , [FS|ArgS]).

nd_subst2( _,  _, [], [] ).
nd_subst2( X, Sk, [A|As], [Sk|AS] ) :- X == A, !, nd_subst2( X, Sk, As, AS).
nd_subst2( X, Sk, [A|As], [A|AS]  ) :- var(A), !, nd_subst2( X, Sk, As, AS).
nd_subst2( X, Sk, [A|As], [Ap|AS] ) :- nd_subst( A,X,Sk,Ap ),nd_subst2( X, Sk, As, AS).
nd_subst2( _X, _Sk, L, L ).

univ_term(P1,[FS|ArgS]):- compound(FS),!,append_term(FS,ArgS,P1).
univ_term(P1,[FS|ArgS]):- univ_safe(P1 , [FS|ArgS]).


wsubst(A,B,C,D):- 
      ccatch(hotrace(weak_nd_subst(A,B,C,D)),_,fail),!.
wsubst(A,_B,_C,A).

weak_nd_subst(  Var, VarS,SUB,SUB ) :- nonvar(Var),Var=VarS,!.
weak_nd_subst(        P, X,Sk,        P1 ) :- functor_catch(P,_,N),weak_nd_subst1( X, Sk, P, N, P1 ).

weak_nd_subst1( _,  _, P, 0, P  ).

weak_nd_subst1( X, Sk, P, N, P1 ) :- N > 0, P =.. [F|Args], weak_nd_subst2( X, Sk, Args, ArgS ),
            weak_nd_subst2( X, Sk, [F], [FS] ),
            univ_term(P1 , [FS|ArgS]).

weak_nd_subst2( _,  _, [], [] ).
weak_nd_subst2( X, Sk, [A|As], [Sk|AS] ) :- nonvar(A), X = A, !, weak_nd_subst2( X, Sk, As, AS).
weak_nd_subst2( X, Sk, [A|As], [A|AS]  ) :- var(A), !, weak_nd_subst2( X, Sk, As, AS).
weak_nd_subst2( X, Sk, [A|As], [Ap|AS] ) :- weak_nd_subst( A,X,Sk,Ap ),weak_nd_subst2( X, Sk, As, AS).
weak_nd_subst2( _X, _Sk, L, L ).


make_list(E,1,[E]):-!.
make_list(E,N,[E|List]):- M1 is N - 1, make_list(E,M1,List),!.

:- swi_export(flatten_set/2).
flatten_set(L,S):-flatten([L],F),list_to_set(F,S),!.
%flatten_set(Percepts0,Percepts):- flatten([Percepts0],Percepts1),remove_dupes(Percepts1,Percepts).

remove_dupes(In,Out):-remove_dupes(In,Out,[]).

remove_dupes([],[],_):-!.
remove_dupes([I|In],Out,Shown):-member(I,Shown),!,remove_dupes(In,Out,Shown).
remove_dupes([I|In],[I|Out],Shown):-remove_dupes(In,Out,[I|Shown]).

functor_h(Obj,F):- functor_h(Obj,F,_),!.
get_functor(Obj,FO):-call((must(functor_h(Obj,F,_)),!,FO=F)).
get_functor(Obj,FO,AO):-call((must(functor_h(Obj,F,A)),!,FO=F,AO=A)).

functor_h(Obj,F,A):- var(Obj),trace_or_throw(var_functor_h(Obj,F,A)).
functor_h(Obj,F,A):-var(Obj),!,(number(A)->functor(Obj,F,A);((current_predicate(F/A);throw(var_functor_h(Obj,F,A))))).
functor_h(Obj,F,A):- (Obj = '$VAR'(_)),trace_or_throw(var_functor_h(Obj,F,A)).
functor_h([L|Ist],F,A):- is_list([L|Ist]),!,var(F),L=F,length(Ist,A).
functor_h(F//A,F,Ap2):-number(A),!,Ap2 is A+2,( atom(F) ->  true ; current_predicate(F/Ap2)).
functor_h(F/A,F,A):-number(A),!,( atom(F) ->  true ; current_predicate(F/A)).
functor_h(':'(_,Obj),F,A):-nonvar(Obj),!,functor_h(Obj,F,A).
functor_h(M:_,F,A):- atom(M),!, ( M=F -> current_predicate(F/A) ; current_predicate(M:F/A)).
functor_h(':-'(Obj),F,A):-!,functor_h(Obj,F,A).
functor_h(':-'(Obj,_),F,A):-!,functor_h(Obj,F,A).
functor_h(Obj,F,0):- string(Obj),!,must_det(atom_string(F,Obj)).
functor_h(Obj,Obj,0):-not(compound(Obj)),!.
functor_h(Obj,F,A):-functor(Obj,F,A).


:- swi_export((do_expand_args/3)).
:- dynamic_multifile_exported((argsQuoted/1)).

do_expand_args(_,Term,Term):- compound(Term),functor(Term,F,_),argsQuoted(F),!.
do_expand_args(Exp,Term,Out):- compound(Term),!,do_expand_args_c(Exp,Term,Out).
do_expand_args(_,Term,Term).

do_expand_args_c(Exp,[L|IST],Out):- !,do_expand_args_l(Exp,[L|IST],Out).
do_expand_args_c(Exp,Term,Out):- Term=..[P|ARGS],do_expand_args_pa(Exp,P,ARGS,Out).

do_expand_args_pa(Exp,Exp,ARGS,Out):- !,member(Out,ARGS).
do_expand_args_pa(Exp,P,ARGS,Out):- do_expand_args_l(Exp,ARGS,EARGS), Out=..[P|EARGS].

do_expand_args_l(_,A,A):- var(A),!.
do_expand_args_l(_,[],[]):- !.
do_expand_args_l(Exp,[A|RGS],[E|ARGS]):- do_expand_args(Exp,A,E),do_expand_args_l(Exp,RGS,ARGS).



% :- moo_hide_childs(functor_safe/2).
% :- moo_hide_childs(functor_safe/3).


:- meta_predicate call_n_times(+,0).
call_n_times(0,_Goal):-!.
call_n_times(1,Goal):-!,Goal.
call_n_times(N,Goal):-doall((between(2,N,_),once(Goal))),Goal.


:- meta_predicate at_start(0).
:-dynamic(at_started/1).
at_start(Goal):-
	copy_term(Goal,Named),
	numbervars(Named,0,_,[attvar(bind),singletons(true)]),
	copy_term(Named,Named2),
        (    at_started(Named)
	->
	     true
	;
	     ccatch(
		 (assert(at_started(Named2)),debugOnFailure0((Goal))),
		 E,
		 (retractall(at_started(Named2)),trace_or_throw(E)))
	).


:- swi_export(list_to_set_safe/2).
list_to_set_safe(A,A):-(var(A);atomic(A)),!.
list_to_set_safe([A|AA],BB):- (not(not(lastMember2(A,AA))) -> list_to_set_safe(AA,BB) ; (list_to_set_safe(AA,NB),BB=[A|NB])),!.


% TODO remove this next line
% :-ensure_loaded(logicmoo_util_bugger).
% and replace with...


term_parts(A,[A]):- not(compound(A)),!.
term_parts([A|L],TERMS):-!,term_parts_l([A|L],TERMS).
term_parts(Comp,[P/A|TERMS]):- functor_catch(Comp,P,A), Comp=..[P|List],term_parts_l(List,TERMS).

term_parts_l(Var,[open(Var),Var]):-var(Var),!.
term_parts_l([],[]):-!.
term_parts_l([A|L],TERMS):-!,term_parts(A,AP),term_parts_l(L,LP),append(AP,LP,TERMS).
term_parts_l(Term,[open(Term)|TERMS]):-term_parts(Term,TERMS),!.

pred_term_parts(Pred,A,[A]):- call(Pred,A),!.
pred_term_parts(_Pred,A,[]):-not(compound(A)),!.
pred_term_parts(Pred,[A|L],TERMS):-!,pred_term_parts_l(Pred,[A|L],TERMS),!.
pred_term_parts(Pred,Comp,TERMS):-Comp=..[P,A|List],pred_term_parts_l(Pred,[P,A|List],TERMS),!.
pred_term_parts(_,_Term,[]).

pred_term_parts_l(_,NV,[]):-NV==[],!.
pred_term_parts_l(Pred,[A|L],TERMS):-!,pred_term_parts(Pred,A,AP),pred_term_parts_l(Pred,L,LP),append(AP,LP,TERMS),!.
pred_term_parts_l(Pred,Term,TERMS):-pred_term_parts(Pred,Term,TERMS),!.
pred_term_parts_l(_,_Term,[]).

throw_if_true_else_fail(T,E):- once(hotrace(T)),trace_or_throw(throw_if_true_else_fail(E:T)).

list_retain(PL,Pred,Result):- throw_if_true_else_fail(not(is_list(PL)),list_retain(PL,Pred,Result)).
list_retain([],_Pred,[]):-!.
list_retain([R|List],Pred,[R|Retained]):- call(Pred,R),!, list_retain(List,Pred,Retained).
list_retain([_|List],Pred,Retained):- list_retain(List,Pred,Retained).

:- swi_export(identical_member/2).
identical_member(X,[Y|_])  :-
	X == Y,
	!.
identical_member(X,[_|L]) :-
	'identical_member'(X,L).

:- swi_export(delete_eq/3).
:- swi_export(pred_delete/4).
delete_eq(A,B,C):-pred_delete(==,A,B,C).
pred_delete(_,[], _, []).
pred_delete(Pred,[A|C], B, D) :-
        (    call(Pred,A,B)
        ->  pred_delete(Pred,C, B, D)
        ;   D=[A|E],
            pred_delete(Pred,C, B, E)
        ).



:-swi_export(doall/1).
:- meta_predicate doall(0).
doall(M:C):-!, M:ignore(M:(C,fail)).
doall(C):-ignore((C,fail)).

% =================================================================================
% Loader Utils
% =================================================================================


dynamic_load_pl(PLNAME):-consult(PLNAME),!.

dynamic_load_pl(PLNAME):- % unload_file(PLNAME),
   open(PLNAME, read, In, []),
   repeat,
   line_count(In,Lineno),
   % double_quotes(_DQBool)
   Options = [variables(_Vars),variable_names(_VarNames),singletons(_Singletons),comment(_Comment)],
   catchvv((read_term(In,Term,[syntax_errors(error)|Options])),E,(dmsg(E),fail)),
   load_term(Term,[line_count(Lineno),file(PLNAME),stream(In)|Options]),
   Term==end_of_file,
   close(In).

load_term(E,_Options):- E == end_of_file, !.
load_term(Term,Options):-catchvv(load_term2(Term,Options),E,(dmsg(error(load_term(Term,Options,E))),throw_safe(E))).

load_term2(':-'(Term),Options):-!,load_dirrective(Term,Options),!.
load_term2(:-(H,B),Options):-!,load_assert(H,B,Options).
load_term2(Fact,Options):-!,load_assert(Fact,true,Options).

load_assert(H,B,_Options):-assert((H:-B)),!.

load_dirrective(include(PLNAME),_Options):- (atom_concat_safe(Key,'.pl',PLNAME) ; Key=PLNAME),!, dynamic_load_pl(Key).
load_dirrective(CALL,_Options):- CALL=..[module,M,_Preds],!,module(M),call(CALL).
load_dirrective(Term,_Options):-!,Term.

% =====================================================================================================================
:- swi_export((call_no_cuts/1)).
% =====================================================================================================================
:- meta_predicate call_no_cuts(0).
:- module_transparent call_no_cuts/1.
call_no_cuts((A,B)):-!,(call_no_cuts(A),call_no_cuts(B)).
call_no_cuts((A;B)):-!,(call_no_cuts(A);call_no_cuts(B)).
call_no_cuts((A->B)):-!,(call_no_cuts(A)->call_no_cuts(B)).
call_no_cuts((A->B;C)):-!,(call_no_cuts(A)->call_no_cuts(B);call_no_cuts(C)).
call_no_cuts(M:CALL):-atom(M),!,functor(CALL,F,A),functor(C,F,A),must(once(not(not(clause_safe(C,_))))),!,clause_safe(CALL,TEST),debugOnError(TEST).
call_no_cuts(CALL):-functor(CALL,F,A),functor(C,F,A),must(once(not(not(clause_safe(C,_))))),!,clause_safe(CALL,TEST),debugOnError(TEST).


% this is a backwards compatablity block for SWI-Prolog 6.6.6
:- current_prolog_flag(double_quotes,WAS),asserta(double_quotes_was_lib(WAS)).

:- module_predicates_are_exported.
:- all_module_predicates_are_transparent(logicmoo_util_library).

logicmoo_library_file_loaded.
