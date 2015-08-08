% ===================================================================

:-thread_local  tlbugger:attributedVars.

%  tlbugger:attributedVars.

:- export(must_not_repeat/1).
:-meta_predicate(must_not_repeat(0)).
must_not_repeat(C):-call(C).

% ===================================================
% 
% no_repeats(:Call) 
%
% Like call/1 but ony succeeds only unique variabes
% 
% logicmoo_mud:  ?- no_repeats(member(X,[3,1,1,1,3,2])).
% X = 3 ;
% X = 1 ;
% X = 2.
% ===================================================




no_repeats_av:-tlbugger:attributedVars.

:- export(no_repeats/1).
:- meta_predicate no_repeats(0).

no_repeats(Call):- tlbugger:old_no_repeats,!, no_repeats_old(Call).
no_repeats(Call):- no_repeats_av,!,no_repeats_av(Call).
no_repeats(Call):- no_repeats_old(Call).


:- export(no_repeats/2).
:- meta_predicate no_repeats(+,0).
no_repeats(Vs,Call):- tlbugger:old_no_repeats,!,no_repeats_old(Vs,Call).
no_repeats(Vs,Call):- no_repeats_av,!,no_repeats_av(Vs,Call).
no_repeats(Vs,Call):- no_repeats_old(Vs,Call).

/*
no_repeats_dif(Vs,Call):- dif(Vs,_), get_attr(Vs,dif,vardif(CONS,_)),!,
  Call,copy_term_nat(Vs,C),nb_setarg(2, CONS, [_-C|CONS]).

*/

% ===================================================
% 
% no_repeats_old([+Vars,]:Call) 
% 
% Like call/1 but ony succeeds on unique free variabes
% 
% logicmoo_mud:  ?- no_repeats( X , member(X-Y,[3-2,1-4,1-5,2-1])).
% X = 3, Y = 2 ;
% X = 1, Y = 4 ;
% X = 2, Y = 1.
% ===================================================
:- export(no_repeats_old/1).
:- meta_predicate no_repeats_old(0).
no_repeats_old(Call):- no_repeats_old(Call,Call).

:- export(no_repeats_old/2).
:- meta_predicate no_repeats_old(+,0).

:-use_module(library(logicmoo/util/rec_lambda)).

memberchk_same(X, [Y|Ys]) :- (   X =@= Y ->  (var(X) -> X==Y ; true) ;   (nonvar(Ys),memberchk_same(X, Ys) )). 

memberchk_pred(Pred, X, [Y|Ys]) :- (   call(Pred,X,Y) -> true ;   (nonvar(Ys),memberchk_pred(Pred, X, Ys) )). 
memberchk_pred_rev(Pred, X, [Y|Ys]) :- (   call(Pred,Y,X) -> true ;   (nonvar(Ys),memberchk_pred_rev(Pred,X, Ys) )). 


no_repeats_old(Vs,Call):- CONS = [_], (Call), hotrace(( \+ memberchk_same(Vs,CONS), copy_term(Vs,CVs), CONS=[_|T], nb_setarg(2, CONS, [CVs|T]))).

mcs_t2(A,B) :- call(lambda(X, [Y|Ys], (   X =@= Y ->  (var(X) -> X==Y ; true) ;   (nonvar(Ys),reenter_lambda(X, Ys) ))),A,B). 
mcs_t(A,B) :- call(lambda(X, [Y|Ys], (   X =@= Y ->  (var(X) -> X==Y ; true) ;   (nonvar(Ys),reenter_lambda(X, Ys) ))),A,B). 


no_repeats_t(Vs,Call):- CONS = [_], (Call), 
  (( \+ call(lambda(X, [Y|Ys], (   X =@= Y ->  (var(X) -> X==Y ; true) ;   (nonvar(Ys),reenter_lambda(X, Ys) ))),Vs,CONS),
       copy_term(Vs,CVs), CONS=[_|T], nb_linkarg(2, CONS, [CVs|T]))).

% 

:- export(no_repeats_u/2).
:- meta_predicate no_repeats_u(+,0).
no_repeats_u(Vs,Call):- CONS = [_], (Call), hotrace((  CONS=[_|T],
    \+ memberchk_pred_rev(subsumes_term,Vs,T), copy_term(Vs,CVs), nb_setarg(2, CONS, [CVs|T]))).



% for dont-care vars
:- export(no_repeats_dc/2).
:- meta_predicate no_repeats_dc(+,0).
no_repeats_dc(Vs,Call):- term_variables(Call,CV),term_variables(Vs,VsL),subtract_eq(CV,VsL,NewVs),no_repeats(NewVs,Call).

subtract_eq([], _, []) :- !.
subtract_eq([A|C], B, D) :-
        memberchk_same(A, B), !,
        subtract_eq(C, B, D).
subtract_eq([A|B], C, [A|D]) :-
        subtract_eq(B, C, D).


% ===================================================
%
%  no_repeats_av/1 - Filter repeats using coroutining
%
% Same as no_repeats(:Call) (so same as call/1 but fitered)
%
% (everytime we see new value.. we add it to was/2 in an attributed variable that we have a refernce in a compound)
% Cehcked via ?- was(AVar,Foo), get_attrs(AVar,ATTRS1), get_attrs(AVar,ATTRS2), ATTRS1==ATTRS2.
%
%  So the variable binding gerts rejected several frames below your code? ( are we nipping away futile bindings?)
% 
% however ..
%     does that mess with anything in code that we are calling?
%  Could some peice of code been required to see some binding to make a side effect come about?
%  
% logicmoo_mud:  ?- no_repeats_av(member(X,[3,1,1,1,3,2])).
% X = 3 ;
% X = 1 ;
% X = 2.
%
% attributed variable verson of getting filtered bindings
% ===================================================
:- export(no_repeats_av/1).
:-meta_predicate(no_repeats_av(0)).
:- export(no_repeats_av/2).
:-meta_predicate(no_repeats_av(+,0)).
:- export(no_repeats_av_l/2).
:-meta_predicate(no_repeats_av_l(+,0)).

no_repeats_av(AVar,Call):- var(AVar),!,
      setup_call_cleanup(
       (was(AVar,iNEVER),asserta(tlbugger:cannot_save_table,Ref),get_attr(AVar,was,varwas(CONS,_))),
        (Call,copy_term_nat(AVar,C),nb_linkarg(2, CONS, [_-C|CONS])),
        (del_attr(AVar,was),erase_safe(tlbugger:cannot_save_table,Ref))).
no_repeats_av(List,Call):- is_list(List),!,no_repeats_av_l(List,Call).
no_repeats_av(Term,Call):-term_variables(Term,List),!,no_repeats_av_l(List,Call).

no_repeats_av(Call):-term_variables(Call,Vs),!,no_repeats_av_l(Vs,Call).

no_repeats_av_l([],Call):-!,Call,!.
no_repeats_av_l([AVar],Call):-!,
   no_repeats_av(AVar,Call).
no_repeats_av_l([AVar|List],Call):-
   no_repeats_av(AVar,no_repeats_av_l(List,Call)).



% =========================================================================
:- meta_predicate succeeds_n_times(0, -).
% =========================================================================

succeeds_n_times(Goal, Times) :-
        Counter = counter(0),
        (   Goal,
            arg(1, Counter, N0),
            N is N0 + 1,
            nb_setarg(1, Counter, N),
            fail
        ;   arg(1, Counter, Times)
        ).



:- export(no_repeats_findall5/5).
:- meta_predicate no_repeats_findall5(+,0,-,-,-).
no_repeats_findall5(Vs,Call,ExitDET,USE,NEW):- 
   (((HOLDER = fa([]),
   Call,arg(1,HOLDER,CONS),
   ((
   ((\+ memberchk_same(Vs,CONS), 
   copy_term(Vs,CVs), 
   append(CONS,[CVs],NEW),
    nb_setarg(1, HOLDER, NEW)))
      ->
       USE=true;
       ((USE=false,CONS=NEW))
       )),
   deterministic(ExitDET))) 
    *-> true;
     (NEW=[],ExitDET=true,USE=false)).

:- export(no_repeats_save/4).
:- meta_predicate no_repeats_save(+,0,-,-).
no_repeats_save(Vs,Call,Saved,USE):-
 SavedHolder = saved(_),
  no_repeats_findall5(Vs,Call,ExitDET,USE,NEW),
  ( ExitDET==true -> (nb_linkarg(1,SavedHolder,NEW),!) ; true),  
  arg(1,SavedHolder,Saved).

:- export(no_repeats_save/2).
:- meta_predicate no_repeats_save(+,0).
no_repeats_save(Vs,Call):-  
  call_cleanup(
   (( no_repeats_save(Vs,Call,SavedList,USE),
      (USE==true -> true ; fail))), 
   (is_list(SavedList) -> writeln(saving(SavedList)) ; writeln(givingup_on(Call)))).
  

:- export(no_repeats_findall_r/5).
:- meta_predicate no_repeats_findall_r(+,0,-,-,-).
no_repeats_findall_r(Vs,Call,CONS,ExitDET,List):- 
   CONS = [ExitDET],
   (Call,once((\+ memberchk_same(Vs,CONS), copy_term(Vs,CVs), CONS=[_|T],List=[CVs|T], nb_linkarg(2, CONS, List)))),
   deterministic(ExitDET).

