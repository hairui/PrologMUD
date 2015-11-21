/* Part of LogicMOO Base Logicmoo Debug Tools
% ===================================================================
% File '$FILENAME.pl'
% Purpose: An Implementation in SWI-Prolog of certain debugging tools
% Maintainer: Douglas Miles
% Contact: $Author: dmiles $@users.sourceforge.net ;
% Version: '$FILENAME.pl' 1.0.0
% Revision: $Revision: 1.1 $
% Revised At:  $Date: 2002/07/11 21:57:28 $
% Licience: LGPL
% ===================================================================
*/

:- module(mpred_pfc, [
  call_u/1,fix_mp/2,
  show_if_debug/1,
  set_user_abox/1,
  get_user_abox/1,
  get_source_ref/1,
  get_source_ref1/1,
  is_source_ref1/1,
  mpred_remove1/2,
  check_never_assert/1,check_never_retract/1,
  why_was_true/1,
  mpred_fwc0/1,
  with_no_mpred_trace_exec/1,
  mpred_set_default/2,
  mpred_ain/1,mpred_ain/1,mpred_ain/2,ain/2,
  action_is_undoable/1,
  mpred_assumption/1,mpred_assumptions/2,mpred_axiom/1,bagof_or_nil/3,bases_union/2,brake/1,build_rhs/2,
  build_neg_test/4,build_rule/3,build_code_test/3,
  build_trigger/4,
  defaultmpred_select/1,fc_eval_action/2,
  foreachl_do/2,get_next_fact/1,
  justification/2,justifications/2,
  mpred_BC/1,
  mpred_BC_CACHE/1,
  mpred_CALL/1,mpred_CALL/2,mpred_CALL/3,mpred_CALL_MI/3,
  mpred_halt/0,mpred_halt/1,mpred_halt/2,
  mpred_ain_db_to_head/2,mpred_ain_actiontrace/2,mpred_trace_op/2,mpred_add_support/2,mpred_ain_trigger_reprop/2,
  mpred_ain_by_type/2,
  mpred_prompt_ask/2,
  mpred_CALL_MI/3,mpred_BC_w_cache/1,
  ain_fast/1,
  ain_fast/2,
  setup_mpred_ops/0,
  mpred_assert_w_support/2,mpred_asserta_w_support/2,mpred_assertz_w_support/2,mpred_basis_list/2,mpred_bt_pt_combine/3,mpred_child/2,mpred_children/2,
  mpred_classifyFacts/4,mpred_collect_supports/1,mpred_unhandled_command/3,mpred_compile_rhs_term/2,mpred_conjoin/3,mpred_connective/1,
  mpred_database_item/1,mpred_database_term/2,
  mpred_db_type/2,mpred_set_default/2,mpred_define_bc_rule/3,mpred_descendant/2,
  mpred_descendants/2,mpred_enqueue/2,mpred_error/1,mpred_error/2,mpred_eval_lhs/2,mpred_eval_rhs/2,mpred_fact/1,
  mpred_fact/2,mpred_facts/1,mpred_facts/2,mpred_facts/3,mpred_fwc/1,mpred_get_support/2,lookup_u/1,lookup_u/2,
  mpred_literal/1,mpred_load/1,mpred_make_supports/1,mpred_ain_object/1,mpred_aina/2,mpred_ainz/2,
  mpred_negated_literal/1,mpred_negation/2,mpred_nf/2,mpred_nf1_negation/2,mpred_nf_negation/2,mpred_nf_negations/2,mpred_notrace/0,mpred_nowatch/0,
  mpred_nospy/0,mpred_nospy/1,mpred_nospy/3,mpred_positive_literal/1,mpred_post/2,pp_qu/0,mpred_undo_action/1,
  mpred_rem_support/2,mpred_remove_old_version/1,mpred_remove_supports/1,mpred_remove_supports_quietly/1,mpred_reset/0,mpred_retract/1,mpred_retract_i_or_warn/1,mpred_retract_supported_relations/1,
  mpred_retract_type/2,mpred_select_justification_node/3,mpred_set_warnings/1,mpred_pp_db_justifications/2,
  mpred_spy/1,mpred_spy/2,mpred_spy/3,mpred_step/0,mpred_support_relation/1,mpred_supported/1,mpred_supported/2,
  mpred_trace/0,mpred_trace/1,mpred_trace/2,mpred_trace_maybe_print/3,mpred_trace_maybe_break/3,mpred_trace_exec/0,mpred_trace_op/3,
  mpred_trace_op/2,mpred_trace_msg/1,mpred_trace_msg/2,mpred_trigger_key/2,mpred_trigger_key/2,mpred_undo/1,mpred_unfwc/1,
  mpred_unfwc_check_triggers/1,mpred_union/3,mpred_unique_u/1,mpred_untrace/0,mpred_untrace/1,mpred_warn/0,mpred_warn/1,
  mpred_warn/2,mpred_watch/0,well_founded_0/2,mpred_why/0,mpred_why/1,mpred_whyBrouse/2,mpred_handle_why_command/3,
  nompred_warn/0,pfcl_do/1,pp_DB/0,pp_db_facts/0,pp_db_facts/1,pp_db_facts/2,pp_db_items/1,
  pp_db_rules/0,pp_db_supports/0,pp_db_triggers/0,mpred_load/1,process_rule/3,
  remove_if_unsupported/1,remove_selection/1,mpred_withdraw1/2,

  mpred_run/0,mpred_test/1,mpred_test_fok/1,

  call_u/1,call_uU/1,asserta_u/1,assert_u/1,assertz_u/1,retract_u/1,retractall_u/1,clause_u/2,clause_u/3,get_user_abox/1,lookup_u/1,

          call_in_mi/1,get_search_mode/3,mpred_rem_support_if_exists/2,get_tms_mode/2,call_uU/1,

  stop_trace/1,with_mpred_trace_exec/1,
  select_next_fact/1,supporters_list/2,triggerSupports/2,trigger_trigger/3,well_founded/1,well_founded_list/2,
  do_assumpts/2,mpred_do_fcnt/2,mpred_do_fcpt/2,mpred_fwc1/1,mpred_do_rule/1,mpred_descendant1/3,mpred_eval_rhs1/2,mpred_nf1/2,
  mpred_post1/2,mpred_withdraw/1,mpred_withdraw/2,mpred_remove/1,
  mpred_remove/2,
  mpred_pp_db_justification1/2,mpred_pp_db_justifications2/3,mpred_spy1/3,
  mpred_unfwc1/1,mpred_why1/1,mpred_blast/1,trigger_trigger1/2  ]).

 :- meta_predicate 
      get_user_abox(-),
      each_E(:,+,+),
      pfcl_do(0),
      mpred_get_support(+,-),
      mpred_fact(?,0),
      mpred_test(+),
      mpred_test_fok(+),
      mpred_CALL_MI(1,-,+),
      mpred_CALL(1,-,+),
      mpred_CALL(1,+),
      mpred_CALL(+),
      mpred_BC(+),
      mpred_BC_CACHE(+),
      foreachl_do(0,-),
      fc_eval_action(0,-),
      clause_u(+,+,-),
      call_u(+),
      call_uU(+),
      brake(0),
      with_no_mpred_trace_exec(0),
      with_mpred_trace_exec(0),
      with_search_mode(+,0),
      bagof_or_nil(?,^,-).

:- thread_local(t_l:user_abox/1).

set_user_abox(M):- wdmsg(set_user_abox(M)),
 setup_mpred_support(M),
 ('$set_source_module'(_,M),'$module'(_,M)),
   retractall(t_l:user_abox(_M)),asserta(t_l:user_abox(M)).

:- module_transparent((setup_mpred_support)/1).

:- dynamic(lmcache:mpred_abox_module/1).
setup_mpred_support(M):- lmcache:mpred_abox_module(M),!.
setup_mpred_support(M):-
 must(atom(M)),
 asserta(lmcache:mpred_abox_module(M)),
   add_import_module(M,mpred_pfc,end),
   forall(mpred_database_term(F/A,_),
     (functor(P,F,A),must(\+ (predicate_property(M:P,imported_from(W)),
      wdmsg(predicate_property(P,imported_from(W))),
        W\==logicmoo_user,W\==user)))),
  forall(mpred_database_term(F/A,_),(M:dynamic(M:F/A),
        M:discontiguous(M:F/A),
        M:multifile(M:F/A))),!.

 



% =================================================
% ==============  UTILS BEGIN        ==============
% =================================================


setup_mpred_ops:-
          op(500,fx,'-'),
          op(300,fx,'~'),
          op(1050,xfx,('==>')),
          op(1050,xfx,'<==>'),
          op(1050,xfx,('<-')),
          op(1100,fx,('==>')),
          op(1150,xfx,('::::')),
          op(500,fx,user:'-'),
          op(300,fx,user:'~'),
          op(1050,xfx,(user:'==>')),
          op(1050,xfx,user:'<==>'),
          op(1050,xfx,(user:'<-')),
          op(1100,fx,(user:'==>')),
          op(1150,xfx,(user:'::::')).
:- setup_mpred_ops.


%% get_source_ref( :TermU) is semidet.
%
% Get Source Ref.
%
:- module_transparent((get_source_ref)/1).
get_source_ref(O):- current_why(U),(U=(_,_)->O=U;O=(U,ax)),!.
get_source_ref(O):- get_source_ref1(U),(U=(_,_)->O=U;O=(U,ax)),!.


%% get_source_ref1(+Mt) is semidet.
%
% Get Source Ref Secondary Helper.
%
:- module_transparent((get_source_ref1)/1).
% get_source_ref1(_):- fail,check_context_module,fail.
get_source_ref1(M):- current_why(M),!.
get_source_ref1(mfl(M,F,L)):- get_user_abox(M), source_location(F,L),!.
get_source_ref1(M):- (get_user_abox(M)->true;(atom(M)->(module_property(M,class(_)),!);(var(M),module_property(M,class(_))))),!.
get_source_ref1(mfl(M,F,L)):- get_user_abox(M), current_source_file(F:L),!.
get_source_ref1(mfl(M,F,_L)):- get_user_abox(M), current_source_file(F),!.
get_source_ref1(mfl(M,_,_L)):- get_user_abox(M),!.
get_source_ref1(M):- (get_user_abox(M)->true;(atom(M)->(module_property(M,class(_)),!);(var(M),module_property(M,class(_))))),!.
get_source_ref1(M):- 
 (get_user_abox(M) -> !;
 (atom(M)->(module_property(M,class(_)),!);
    mpred_error(no_source_ref(M)))).

is_source_ref1(_).

%% get_user_abox(-Ctx) is det.
%
% ABox is an "assertion component" Prolog Module
% within a knowledge base.
%
% not just user modules
get_user_abox(C):- t_l:user_abox(C),!.
get_user_abox(C):- '$set_source_module'(C,C),C\==user,C\==logicmoo_user,!.
%get_user_abox(C):- '$set_source_module'(C,C),!,setup_mpred_support(C).
get_user_abox(baseKB):-!.
get_user_abox(_U). % implicit :-nonvar(U).



fix_mp(MP ,M:P):- strip_module(MP,_,P),get_user_abox(M),current_predicate(_,M:P),!.
fix_mp(M:P,M:P):- current_predicate(_,M:P),!.
fix_mp(MP ,M:P):- strip_module(MP,_,P),get_user_abox(M).

body_true(true):-!.
body_true(avar(_,AVS)):-nonvar(AVS),attr_bind(AVS).

%:- if(\+ current_prolog_flag(umt_local,false)).

listing_u(P):-call_u(listing(P)).

assert_u(MP):- fix_mp(MP,M:P),assert(M:P).
asserta_u(MP):- fix_mp(MP,M:P),asserta(M:P).
assertz_u(MP):- fix_mp(MP,M:P),assertz(M:P).
retract_u(M:(H:-B)):- atom(M),!, clause_u(H,B,R),erase(R).

retract_u((H:-B)):-!, clause_u(H,B,R),erase(R).
retract_u(H0):- strip_module(H0,_,H),!, clause_u(H,true,R),erase(R).
retractall_u(H):- forall(clause_u(H,_,R),erase(R)).
clause_u(H,B):- clause_u(H,B,_).

clause_u(_:H,B,R):- !, get_user_abox(M), M:clause(H,B,R).
clause_u(H,B,R):- get_user_abox(M), M:clause(M:H,B,R).

lookup_u(Trigger):-  clause_u(Trigger,B),call(B).
lookup_u(Trigger,Ref):-  clause_u(Trigger,B,Ref),call(B).

call_u(mpred_BC(G0)):-nonvar(G0),!,call_u(G0).
call_u(call_u(G0)):-nonvar(G0),!,call_u(G0).
call_u(G0):-
  strip_module(G0,_,G),functor(G,F,A),
  mpred_BC_CACHE(G),
  (memberchk(F/A,[(',')/2])->
  mpred_CALL(call_u,G);
  call_uU(G0)).

call_uU(G0):-
  strip_module(G0,WM,G),
  get_user_abox(U),  
  must(current_predicate(_,U:G)->(CALL=U:G);(current_predicate(_,WM:G0)->CALL=WM:G0; fail)),
 '$set_source_module'(S,U),
 '$module'(M,U),
  call_cleanup(CALL,
     ('$set_source_module'(_,S),'$module'(_,M))).


%:- else.
/*
listing_u(P):- (listing(P)).
assert_u(A):- assert(A).
asserta_u(A):- asserta(A).
assertz_u(A):- assertz(A).
retract_u((H:-B)):-!, clause_u(H,B,R),erase(R).
retract_u(H):-!, clause_u(H,true,R),erase(R).
retractall_u(H):- forall(clause_u(H,_,R),erase(R)).
clause_u(H,B):- clause_u(H,B,_).
clause_u(H,B,R):- clause(H,B,R).
call_u(G):- G.
*/
%:- endif.

%% each_E(+P2,+HT,+S) semidet.
%
% Call P(E,S). each Element in the list.
%
each_E(P,HV,S):- var(HV),!,apply(P,[HV|S]).
each_E(P,M:HT,S) :- !,must_be(atom,M),M:each_E(P,HT,S).
each_E(P,[H|T],S) :- !, apply(P,[H|S]), each_E(P,T,S).
each_E(P,(H,T),S) :- !,call_u(each_E(P,H,S)), each_E(P,T,S).
each_E(P,H,S) :- apply(P,[H|S]).


% =================================================
% ==============  UTILS END          ==============
% =================================================

:- style_check(+singleton).
%   File   : mpred_syntax.pl
%   Author : Tim Finin, finin@prc.unisys.com
%   Purpose: syntactic sugar for Pfc - operator definitions and term expansions.

:- op(500,fx,'-').
:- op(300,fx,'~').
:- op(1050,xfx,('==>')).
:- op(1050,xfx,'<==>').
:- op(1050,xfx,('<-')).
:- op(1100,fx,('==>')).
:- op(1150,xfx,('::::')).



:- use_module(library(lists)).



:- dynamic(mpred_te/0).
:- multifile(user:term_expansion/2).
:- dynamic(user:term_expansion/2).
user:term_expansion(I,O):-mpred_te->mpred_te(I,O).

mpred_te((P==>Q),(:- mpred_ain((P==>Q)))).
%mpred_te((P==>Q),(:- mpred_ain(('<-'(Q,P))))).  % speed-up attempt
mpred_te(('<-'(P,Q)),(:- mpred_ain(('<-'(P,Q))))). 
mpred_te((P<==>Q),(:- mpred_ain((P<==>Q)))).
mpred_te((RuleName :::: Rule),(:- mpred_ain((RuleName :::: Rule)))).
mpred_te((==>P),(:- mpred_ain(P))).


%  predicates to examine the state of mpred_


pp_qu:- call_u(listing(que/1)).

%   File   : mpred_core.pl
%   Author : Tim Finin, finin@prc.unisys.com
%   Updated: 10/11/87, ...
%            4/2/91 by R. McEntire: added calls to valid_dbref as a
%                                   workaround for the Quintus 3.1
%                                   bug in the recorded database.
%   Purpose: core Pfc predicates.


% ============================================
% % initialization of global assertons 
% ============================================

%%   mpred_set_default(P,Q) is det.
%
%  if there is any fact unifying with P, 
% via lookup_u/1 then do 
%  nothing, else assert_u Q.
%
mpred_set_default(GeneralTerm,Default):-
  clause_u(GeneralTerm,true) -> true ; assert_u(Default).

%  tms is one of {none,local,cycles} and controles the tms alg.
% :- mpred_set_default(tms(_),tms(cycles)).

% Pfc Search strategy. sm(X) where P is one of {direct,depth,breadth}
% :- must(mpred_set_default(sm(_), sm(direct))).



%% mpred_ainz(+G, ?S) is semidet.
%
% PFC Ainz.
%
mpred_ainz(G):-mpred_ain(G).
mpred_ainz(G,S):-mpred_ain(G,S).

%% mpred_aina(+G, ?S) is semidet.
%
% PFC Aina.
%
mpred_aina(G):-mpred_ain(G).
mpred_aina(G,S):-mpred_ain(G,S).

%%  mpred_ain(P,S) 
%
%  asserts P into the dataBase with support from S.
%
%  mpred_ain/2 and mpred_post/2 are the proper ways to add new clauses into the
%  database and have forward reasoning done.
%
mpred_ain(P):- get_source_ref(UU),mpred_ain(P,UU),!.

%%  ain(P,S) 
%
%  asserts P into the dataBase with support from S.
%
ain(P,S):- mpred_ain(P,S).


mpred_ain(P,S):- 
  if_defined_else(to_addable_form_wte(assert,P,P0),P0=P)  -> 
  each_E(mpred_post1,P0,[S]),
  mpred_run.
%mpred_ain(_,_).
mpred_ain(P,S):- mpred_warn("mpred_ain(~p,~p) failed",[P,S]).



ain_fast(P):- get_source_ref(UU), ain_fast(P,UU).
ain_fast(P,S):- 
  each_E(mpred_post1,P,[S]),
  mpred_run.


%% mpred_post(+Ps,+S) 
%
% tries to assert a fact or set of fact to the database.  For
% each fact (or the singleton) mpred_post1 is called. It always succeeds.
%
mpred_post(P, S):- 
   if_defined_else(to_addable_form_wte(assert,P,P0),P=P0), 
   each_E(mpred_post1,P0,[S]).


%% mpred_post1(+P,+S) is det.
%
% tries to add a fact to the database, and, if it succeeded,
% adds an entry to the Pfc queue for subsequent forward chaining.
% It always succeeds.
%
mpred_post1(    P,   S):- if_defined_else(fixed_negations(P,P0),fail),!, mpred_post1( P0,   S).
% TODO - ODD THIS WAS EVEN NEEDED?
mpred_post1(  ~ P,   S):- nonvar(P),doall(mpred_remove(P,S)),mpred_undo(\+P),fail.
mpred_post1( \+ P,   S):- nonvar(P),!, mpred_withdraw(P, S),!.
mpred_post1(P,S):- 
  %  db mpred_ain_db_to_head(P,P2),
  % mpred_remove_old_version(P),
  mpred_add_support(P,S),
  mpred_unique_u(P),
  assert_u(P),
  mpred_trace_op(add,P,S),
  !,
  mpred_enqueue(P,S),
  !.

mpred_post1(_,_).
% mpred_post1(P,S):-  mpred_warn("mpred_ain(~p,~p) failed",[P,S]).

 
%% get_mpred_current_db(-Db) is semidet.
%
% PFC Current Database.
%
% (was nothing)
%
get_mpred_current_db(Db):-lookup_u(mpred_current_db(Db)),!.
get_mpred_current_db(true).
 
%%  mpred_ain_db_to_head(+P,-NewP) is semidet.
%
% takes a fact P or a conditioned fact
%  (P:-C) and adds the Db context.
% 
mpred_ain_db_to_head(P,NewP):-
  lookup_u(mpred_current_db(Db)),
  (Db=true        -> NewP = P;
   P=(Head:-Body) -> NewP = (Head:- (Db,Body));
   otherwise      -> NewP = (P:- Db)).




%% mpred_unique_u(+P) is semidet.
%
% is true if there is no assertion P in the prolog db.
%
mpred_unique_u((Head:-Tail)):- !, \+ clause_u(Head,Tail).
mpred_unique_u(P):- !, \+ clause_u(P,true).


get_search_mode(_P,_S,Mode):- t_l:mpred_search_mode(Mode),!.
get_search_mode(_P,_S,Mode):- lookup_u(sm(Mode)),!.
get_search_mode(_P,_S,Mode):- must(Mode=direct),!.


:- thread_local(t_l:mpred_search_mode/1).

%% with_search_mode(+Mode,:Goal) is semidet.
%
% Temporariliy changes to forward chaining search mode while running the Goal
%
with_search_mode(Mode,Goal):- w_tl(t_l:mpred_search_mode(Mode),Goal).

%% mpred_enqueue(+P,+S) is det.
%
% PFC Enqueue P for forward chaining
%
mpred_enqueue(P,S):-
  (get_search_mode(P,S,Mode)
    -> (Mode=direct  -> mpred_fwc(P) ;
	Mode=depth   -> mpred_asserta_w_support(que(P),S) ;
	Mode=breadth -> mpred_assert_w_support(que(P),S) ;
	true         -> mpred_error("Unrecognized sm mode: ~p", Mode))
     ; mpred_error("No sm mode")).


%% mpred_remove_old_version( :TermIdentifier) is semidet.
%
% if there is a rule of the form Identifier ::: Rule then delete it.
%
mpred_remove_old_version((Identifier::::Body)):-
  % this should never happen.
  var(identifier),
  !,
  mpred_warn("variable used as an  rule name in ~p :::: ~p",
          [Identifier,Body]).

  
mpred_remove_old_version((Identifier::::Body)):-
  nonvar(Identifier),
  clause_u((Identifier::::OldBody),_),
  \+(Body=OldBody),
  mpred_withdraw((Identifier::::OldBody)),
  !.
mpred_remove_old_version(_).



% mpred_run compute the deductive closure of the current database. 
% How this is done depends on the searching mode:
%    direct -  mpred_fwc has already done the job.
%    depth or breadth - use the queue mechanism.

% mpred_run :- lookup_u(sm(direct)),!.
% mpred_run :- repeat, \+ mpred_step, !.
mpred_run:-
%  (\+ lookup_u(sm(direct))),
  mpred_step,
  mpred_run.
mpred_run.


% mpred_step removes one entry from the queue and reasons from it.


mpred_step:-  
  % if hs/1 is true, reset it and fail, thereby stopping inferencing.
  lookup_u(hs(Was)),
  mpred_retract(hs(Was)),
  mpred_trace_msg('Stopping on: ~p',[hs(Was)]),
  !, 
  fail.

mpred_step:-
  % draw immediate conclusions from the next fact to be considered.
  % fails iff the queue is empty.
  get_next_fact(P),
  pfcl_do(mpred_fwc(P)),
  !.

get_next_fact(P):-
  %identifies the nect fact to mpred_fwc from and removes it from the queue.
  select_next_fact(P),
  remove_selection(P).

remove_selection(P):-
  lookup_u(que(P)),
  must(mpred_retract(que(P))),
  mpred_remove_supports_quietly(que(P)),
  !.
remove_selection(P):-
  brake(format("~Nmpred_:get_next_fact - selected fact not on Queue: ~p",
               [P])).


% select_next_fact(P) identifies the next fact to reason from.  
% It tries the user defined predicate first and, failing that, 
%  the default mechanism.

select_next_fact(P):- 
  lookup_u(mpred_select_hook(P)),
  !.  
select_next_fact(P):- 
  defaultmpred_select(P),
  !.  

% the default selection predicate takes the item at the froint of the queue.
defaultmpred_select(P):- lookup_u(que(P)),!.

% mpred_halt stops the forward chaining.
mpred_halt:-  mpred_halt(anonymous(mpred_halt)).

mpred_halt(Format,Args):- format_to_message(Format,Args,Info), mpred_halt(Info).

mpred_halt(Now):-
  mpred_trace_msg("New halt signal ",[Now]),
  (lookup_u(hs(Was)) -> 
       mpred_warn("mpred_halt finds halt signal already set to: ~p ",[Was])
     ; assert_u(hs(Now))).


stop_trace(Info):- notrace((tracing,leash(+all),dtrace(dmsg(Info)))),!,rtrace.
stop_trace(Info):- dtrace(dmsg(Info)).


% 
%  predicates for manipulating triggers
% 


mpred_ain_trigger_reprop(PT,Support):-
  PT = pt(Trigger,Body),!,
  mpred_mark_as(Support,p,Trigger,pfcPosTrigger),
  mpred_trace_msg('~N~n\tAdding positive~n\t\ttrigger: ~p~n\t\tbody: ~p~n\t Support: ~p~n',[Trigger,Body,Support]),
  mpred_assert_w_support(PT,Support),
  copy_term(PT,Tcopy),
  mpred_BC(Trigger),
  mpred_eval_lhs(Body,(Trigger,Tcopy)),
  fail.

mpred_ain_trigger_reprop(nt(Trigger,Test,Body),Support):-
  copy_term(Trigger,TriggerCopy),
  NT = nt(TriggerCopy,Test,Body),!,
  mpred_mark_as(Support,p,Trigger,pfcNegTrigger),
  mpred_trace_msg('~N~n\tAdding negative~n\t\ttrigger: ~p~n\t\ttest: ~p~n\t\tbody: ~p~n\t Support: ~p~n',[Trigger,Test,Body,Support]),  
  mpred_assert_w_support(NT,Support),
  %stop_trace(mpred_assert_w_support(NT,Support)),
  \+ call_u(Test),
  mpred_eval_lhs(Body,((\+Trigger),NT)).

mpred_ain_trigger_reprop(BT,Support):-
  BT = bt(Trigger,Body),!, trace,
  % if_defined_else(attvar_op(assertz_if_new,((Trigger:-mpred_bc_only(Trigger)))),true),!,
  assert_if_new((Trigger:-mpred_bc_only(Trigger))),
  mpred_mark_as(Support,p,Trigger,pfcBcTrigger),
  % if_defined_else(import_to_user(Trigger),true), 
  mpred_trace_msg('~N~n\tAdding backwards~n\t\ttrigger: ~p~n\t\tbody: ~p~n\t Support: ~p~n',[Trigger,Body,Support]),
  mpred_assert_w_support(BT,Support),
  mpred_bt_pt_combine(Trigger,Body,Support).

mpred_ain_trigger_reprop(X,Support):-
  mpred_warn("Unrecognized trigger to mpred_ain_trigger_reprop: ~p\n~~p~n",[X,Support]).


mpred_bt_pt_combine(Head,Body,Support):- 
  %  a backward trigger (bt) was just added with head and Body and support Support
  %  find any pt''s with unifying heads and add the instantied bt body.
  lookup_u(pt(Head,Body)),
  mpred_eval_lhs(Body,Support),
  fail.
mpred_bt_pt_combine(_,_,_):- !.



% 
%  predicates for manipulating action traces.
% 

mpred_ain_actiontrace(Action,Support):- 
  % adds an action trace and it''s support.
  mpred_add_support(actn(Action),Support).

mpred_undo_action(actn(A)):-
  lookup_u(do_and_undo(A,M)),
  call_u(M),
  !.


%%  mpred_retract(X) is det.
%
%  predicates to remove Pfc facts, triggers, action traces, and queue items
%  from the database.
%
mpred_retract(X):- 
  %  retract an arbitrary thing.
  mpred_db_type(X,Type),!,
  mpred_retract_type(Type,X),
  !.

mpred_retract_type(fact(_FT),X):-   
  %  db mpred_ain_db_to_head(X,X2), retract_u(X2). 
  % stop_trace(mpred_retract_type(fact(_FT),X)),
  (retract_u(X) 
   *-> mpred_unfwc(X) ; (mpred_unfwc(X),!,fail)).

mpred_retract_type(rule,X):- 
  %  db  mpred_ain_db_to_head(X,X2),  retract_u(X2).
  (retract_u(X)
      *-> mpred_unfwc(X) ; (mpred_unfwc(X),!,fail)).

mpred_retract_type(trigger,X):- 
  retract_u(X)
    -> mpred_unfwc(X)
     ; mpred_warn("Trigger not found to retract_u: ~p",[X]).

mpred_retract_type(action,X):- mpred_undo_action(X).
  

%%  mpred_ain_object(X) 
%
% adds item P to some database
%
mpred_ain_object(X):-
  % what type of P do we have?
  mpred_db_type(X,Type),
  % call the appropriate predicate.
  mpred_ain_by_type(Type,X).

mpred_ain_by_type(fact(_FT),X):- 
  mpred_unique_u(X), 
  assert_u(X),!.
mpred_ain_by_type(rule,X):- 
  mpred_unique_u(X), 
  assert_u(X),!.
mpred_ain_by_type(trigger,X):- 
  assert_u(X).
mpred_ain_by_type(action,_ZAction):- !.


  

%%  mpred_withdraw(P).
%  removes support S from P and checks to see if P is still supported.
%  If it is not, then the fact is retreactred from the database and any support
%  relationships it participated in removed.

mpred_withdraw(Ps):- get_source_ref(UU),mpred_withdraw(Ps,UU).

%%  mpred_withdraw(P,S) is det.
% removes support S from P and checks to see if P is still supported.
%  If it is not, then the fact is retreactred from the database and any support
%  relationships it participated in removed.
mpred_withdraw(Ps,S):- each_E(mpred_withdraw1,Ps,[S]).
mpred_withdraw1(P,S):-
  mpred_trace_msg('~N~n\tRemoving~n\t\tsupport: ~p~n\t\tfrom: ~p~n',[S,P]),
  mpred_rem_support(P,S)
     -> remove_if_unsupported(P)
      ; mpred_warn("mpred_withdraw/2 Could not find support ~p to remove from fact ~p",
                [S,P]).

%%  mpred_remove(+P) is det.
% 
%  mpred_remove is like mpred_withdraw, but if P is still in the DB after removing the
%  user''s support, it is retracted by more forceful means (e.ax. remove).
% 
mpred_remove(P):- get_source_ref(UU), mpred_remove(P,UU).
mpred_remove(P,S):- each_E(mpred_remove1,P,[S]).

mpred_remove1(P,S):-
  mpred_withdraw(P,S),
  call_u(P)
     -> mpred_blast(P) 
      ; true.


% 
%  mpred_blast(+F) retracts fact F from the DB and removes any dependent facts
% 

mpred_blast(F):- 
  mpred_remove_supports(F),
  mpred_undo(F).


% removes any remaining supports for fact F, complaining as it goes.

mpred_remove_supports(F):- 
  mpred_rem_support(F,S),
  mpred_warn("~p was still supported by ~p",[F,S]),
  fail.
mpred_remove_supports(_).

mpred_remove_supports_quietly(F):- 
  mpred_rem_support(F,_),
  fail.
mpred_remove_supports_quietly(_).

%% mpred_undo(X) undoes X.
%
% - a positive or negative trigger.
% - an action by finding a method and successfully executing it.
% - or a random fact, printing out the trace, if relevant.
%
mpred_undo(actn(A)):-  
  % undo an action by finding a method and successfully executing it.
  !,
  mpred_undo_action(actn(A)).

mpred_undo(pt(Key,Head,Body)):-  
  % undo a positive trigger.
  %
  !,
  (show_success(retract_u(pt(Key,Head,Body)))
    -> mpred_unfwc(pt(Head,Body))
     ; mpred_warn("Trigger not found to undo: ~p",[pt(Head,Body)])).

mpred_undo(pt(Head,Body)):- fail,
  % undo a positive trigger.
  %
  !,
  (show_success(retract_u(pt(Head,Body)))
    -> mpred_unfwc(pt(Head,Body))
     ; mpred_warn("Trigger not found to undo: ~p",[pt(Head,Body)])).

mpred_undo(nt(Head,Condition,Body)):-  
  % undo a negative trigger.
  !,
  (show_success(retract_u(nt(Head,Condition,Body)))
    -> mpred_unfwc(nt(Head,Condition,Body))
     ; mpred_warn("Trigger not found to undo: ~p",[nt(Head,Condition,Body)])).

mpred_undo(Fact):-
  % undo a random fact, printing out the trace, if relevant.
  retract_u(Fact),
  mpred_trace_op(rem,Fact),
  mpred_unfwc(Fact).
  


%%  mpred_unfwc(+P) 
%
% "un-forward-chains" from fact P.  That is, fact P has just
%  been removed from the database, so remove all support relations it
%  participates in and check the things that they support to see if they
%  should stayuser in the database or should also be removed.
%
mpred_unfwc(F):- 
  mpred_retract_supported_relations(F),
  mpred_unfwc1(F).

mpred_unfwc1(F):-
  mpred_unfwc_check_triggers(F),
  % is this really the right place for mpred_run<?
  mpred_run.


mpred_unfwc_check_triggers(F):-
  mpred_db_type(F,fact(_FT)),
  copy_term(F,Fcopy),
  lookup_u(nt(Fcopy,Condition,Action)),
  \+ call_u(Condition),
  mpred_eval_lhs(Action,((\+F),nt(F,Condition,Action))),
  fail.
mpred_unfwc_check_triggers(_).

mpred_retract_supported_relations(Fact):-
  mpred_db_type(Fact,Type),
  (Type=trigger -> mpred_rem_support_if_exists(P,(_,Fact))
                ; mpred_rem_support_if_exists(P,(Fact,_))),
  must(nonvar(P)),
  remove_if_unsupported(P),
  fail.
mpred_retract_supported_relations(_).



%  remove_if_unsupported(+Ps) checks to see if all Ps are supported and removes
%  it from the DB if they are not.
remove_if_unsupported(P):- 
   mpred_supported(P) -> true ;  mpred_undo(P).




%%  mpred_fwc(+X) is det.
%
% forward chains from a fact or a list of facts X.
% 
mpred_fwc(Ps):- each_E(mpred_fwc0,Ps,[]).
:- module_transparent((mpred_fwc0)/1).
mpred_fwc0(Fact):- mpred_fwc1(Fact).
% mpred_fwc0(Fact):- loop_check(mpred_fwc1(Fact),true).

%% mpred_fwc1(+P) is det.
%
% forward chains for a single fact.
%
mpred_fwc1(Fact):-
  mpred_do_rule(Fact),
  copy_term(Fact,F),
  % check positive triggers
  mpred_do_fcpt(Fact,F),
  % check negative triggers
  mpred_do_fcnt(Fact,F).


% 
%  mpred_ain_rule_if_rule(P) does some special, built in forward chaining if P is
%  a rule.
%  

mpred_do_rule((P==>Q)):-  
  !,  
  process_rule(P,Q,(P==>Q)).
mpred_do_rule((Name::::P==>Q)):- 
  !,  
  process_rule(P,Q,(Name::::P==>Q)).
mpred_do_rule((P<==>Q)):- 
  !, 
  process_rule(P,Q,(P<==>Q)), 
  process_rule(Q,P,(P<==>Q)).
mpred_do_rule((Name::::P<==>Q)):- 
  !, 
  process_rule(P,Q,((Name::::P<==>Q))), 
  process_rule(Q,P,((Name::::P<==>Q))).

mpred_do_rule(('<-'(P,Q))):-
  !,
  mpred_define_bc_rule(P,Q,('<-'(P,Q))).

mpred_do_rule(_).


mpred_do_fcpt(Fact,F):- 
  lookup_u(pt(F,Body)),
  mpred_trace_msg('~N~n\tFound positive trigger: ~p~n\t\tbody: ~p~n',
		[F,Body]),
  mpred_eval_lhs(Body,(Fact,pt(F,Body))),
  fail.

%mpred_do_fcpt(Fact,F):- 
%  lookup_u(pt(presently(F),Body)),
%  mpred_eval_lhs(Body,(presently(Fact),pt(presently(F),Body))),
%  fail.

mpred_do_fcpt(_,_).

mpred_do_fcnt(_ZFact,F):-
  NT = nt(F,Condition,Body),
  SPFT = spft(X,F1,NT),
  lookup_u(SPFT),
   mpred_trace_msg('~N~n\tFound negative trigger: ~p~n\t\tcond: ~p~n\t\tbody: ~p~n\tSupport: ~p~n',
                 [F,Condition,Body,SPFT]),
  call_u(Condition),
  mpred_withdraw(X,(F2,NT)),
  must(F1=F2),
  fail.
mpred_do_fcnt(_,_).


% 
%  mpred_define_bc_rule(+Head,+Body,+Parent_rule) - defines a backeard
%  chaining rule and adds the corresponding bt triggers to the database.
% 

mpred_define_bc_rule(Head,_ZBody,Parent_rule):-
  (\+ mpred_literal(Head)),
  mpred_warn("Malformed backward chaining rule.  ~p not atomic.",[Head]),
  mpred_error("rule: ~p",[Parent_rule]),
  !,
  fail.

mpred_define_bc_rule(Head,Body,Parent_rule):-
  get_source_ref1(U),
  copy_term(Parent_rule,Parent_ruleCopy),
  build_rhs(Head,Rhs),
  foreachl_do(mpred_nf(Body,Lhs),
          (build_trigger(Parent_ruleCopy,Lhs,rhs(Rhs),Trigger),
           mpred_ain(bt(Head,Trigger),(Parent_ruleCopy,U)))).
 



% 
%  eval something on the LHS of a rule.
% 

 
mpred_eval_lhs((Test->Body),Support):- 









  !, 
  (call_u(Test) -> mpred_eval_lhs(Body,Support)),
  !.

mpred_eval_lhs(rhs(X),Support):-
  !,
  mpred_eval_rhs(X,Support),
  !.

mpred_eval_lhs(X,Support):-
  mpred_db_type(X,trigger),
  !,
  mpred_ain_trigger_reprop(X,Support),
  !.

%mpred_eval_lhs(snip(X),Support):- 
%  snip(Support),
%  mpred_eval_lhs(X,Support).

mpred_eval_lhs(X,_):-
  mpred_warn("Unrecognized item found in trigger body, namely ~p.",[X]).


% 
%  eval something on the RHS of a rule.
% 

mpred_eval_rhs([],_):- !.
mpred_eval_rhs([Head|Tail],Support):- 
  mpred_eval_rhs1(Head,Support),
  mpred_eval_rhs(Tail,Support).


mpred_eval_rhs1({Action},Support):-
 % evaluable Prolog code.
 !,
 fc_eval_action(Action,Support).

mpred_eval_rhs1(P,_ZSupport):-
 % predicate to remove.
 mpred_negated_literal(P),
 !,
 mpred_withdraw(P).

mpred_eval_rhs1([X|Xrest],Support):-
 % embedded sublist.
 !,
 mpred_eval_rhs([X|Xrest],Support).

mpred_eval_rhs1(Assertion,Support):-
 % an assertion to be added.
 mpred_post1(Assertion,Support).


mpred_eval_rhs1(X,_):-
  mpred_warn("Malformed rhs of a rule: ~p",[X]).



%% fc_eval_action(+Action,+Support)
%
%  evaluate an action found on the rhs of a rule.
% 

fc_eval_action(Action,Support):-
  call_u(Action), 
  (action_is_undoable(Action) 
     -> mpred_ain_actiontrace(Action,Support) 
      ; true).


% 
%  
% 

trigger_trigger(Trigger,Body,_ZSupport):-
 trigger_trigger1(Trigger,Body).
trigger_trigger(_,_,_).


%trigger_trigger1(presently(Trigger),Body):-
%  !,
%  copy_term(Trigger,TriggerCopy),
%  mpred_BC(Trigger),
%  mpred_eval_lhs(Body,(presently(Trigger),pt(presently(TriggerCopy),Body))),
%  fail.

trigger_trigger1(Trigger,Body):-
  copy_term(Trigger,TriggerCopy),
  mpred_BC(Trigger),
  mpred_eval_lhs(Body,(Trigger,pt(TriggerCopy,Body))),
  fail.



%%  mpred_BC(F) is det.
% 
%  is true iff F is a fact available for forward chaining 
%  (or from the backchaining store)
%  Note that this has the side effect of catching unsupported facts and
%  assigning them support from God.
% 
mpred_BC(P):-mpred_CALL(mpred_BC_w_cache, P).
mpred_BC_w_cache(P):- mpred_BC_CACHE(P),mpred_CALL(P).
mpred_BC_CACHE(P0):-  strip_module(P0,_,P),
 ignore((
  % trigger any bc rules.
  lookup_u(bt(P,Trigger)),
  must(mpred_get_support(bt(P,Trigger),S)),
  mpred_eval_lhs(Trigger,S),
  fail)).

mpred_CALL(F):- mpred_CALL(mpred_CALL, Cut, F), (var(Cut)->true;(Cut=cut(Cut)->(!,Cut);call_u(Cut))).
mpred_CALL(How,F):- mpred_CALL(How, Cut, F), (var(Cut)->true;(Cut=cut(Cut)->(!,Cut);call_u(Cut))).
mpred_CALL(How,SCut, F):- 
  %  this is probably not advisable due to extreme inefficiency.
  var(F) ->  mpred_fact(F) ;
  predicate_property(F,built_in) -> F ;
  call_in_mi(F) -> mpred_CALL_MI(How,SCut,F) ;
  predicate_property(F,number_of_clauses(_)) -> 
     (clause_u(F,Condition),mpred_CALL(How,Cut,Condition),(var(Cut)->true;(Cut=cut(Cut)->(!,Cut);call_u(Cut))));
  predicate_property(F,built_in) -> F ;
  mpred_CALL_MI(How,SCut,F).

call_in_mi((_,_)).
call_in_mi((_;_)).
call_in_mi((_->_)).
call_in_mi((_*->_)).
call_in_mi((!)).

mpred_CALL_MI(_How, cut(true), !):- !.
mpred_CALL_MI(How, Cut, (P1,P2)):- !, mpred_CALL(How, Cut, P1), mpred_CALL(How, Cut, P2).
mpred_CALL_MI(How, Cut, (P1;P2)):- !, mpred_CALL(How, Cut, P1); mpred_CALL(How, Cut, P2).
mpred_CALL_MI(How, Cut, (P1->P2)):- !, mpred_CALL(How, Cut, P1)-> mpred_CALL(How, Cut, P2).
mpred_CALL_MI(How, Cut, (P1*->P2)):- !, mpred_CALL(How, Cut, P1)*-> mpred_CALL(How, Cut, P2).
mpred_CALL_MI(_How,_, F):- 
  %  we really need to check for system predicates as well.
  must(current_predicate(_,M:F)),!, M:F.




%% action_is_undoable(?A) 
%
% an action is action_is_undoable if there exists a method for undoing it.
%
action_is_undoable(A):- lookup_u(do_and_undo(A,_)).



%% mpred_nf(+In,-Out)
% 
% maps the LHR of a Pfc rule In to one normal form 
%  Out.  It also does certmpred_ain optimizations.  Backtracking into this
%  predicate will produce additional clauses.
%

mpred_nf(LHS,List):-
  mpred_nf1(LHS,List2),
  mpred_nf_negations(List2,List).


%%  mpred_nf1(+In,-Out) 
%
% maps the LHR of a Pfc rule In to one normal form
%  Out.  Backtracking into this predicate will produce additional clauses.

% handle a variable.

mpred_nf1(P,[P]):- var(P), !.

% these next two rules are here for upward compatibility and will go 
% away eventually when the P/Condition form is no longer used anywhere.

mpred_nf1(P/Cond,[(\+P)/Cond]):- mpred_negated_literal(P), !.

mpred_nf1(P/Cond,[P/Cond]):-  mpred_literal(P), !.

%  handle a negated form

mpred_nf1(NegTerm,NF):-
  mpred_negation(NegTerm,Term),
  !,
  mpred_nf1_negation(Term,NF).

%  disjunction.

mpred_nf1((P;Q),NF):- 
  !,
  (mpred_nf1(P,NF) ;   mpred_nf1(Q,NF)).


%  conjunction.

mpred_nf1((P,Q),NF):-
  !,
  mpred_nf1(P,NF1),
  mpred_nf1(Q,NF2),
  append(NF1,NF2,NF).

mpred_nf1([P|Q],NF):-
  !,
  mpred_nf1(P,NF1),
  mpred_nf1(Q,NF2),
  append(NF1,NF2,NF).


%  handle a random literal.

mpred_nf1(P,[P]):- 
  mpred_literal(P), 
  !.

% mpred_nf1(Term,[Term]):- mpred_warn("mpred_nf Accepting ~p",[Term]),!.


%=% shouldn''t we have something to catch the rest as errors?
mpred_nf1(Term,[Term]):-
  mpred_warn("mpred_nf doesn't know how to normalize ~p",[Term]),!,trace,fail.


%% mpred_nf1_negation(+P, ?NF) is semidet.
%
% is true if NF is the normal form of \+P.
%
mpred_nf1_negation((P/Cond),[(\+(P))/Cond]):- !.

mpred_nf1_negation((P;Q),NF):-
  !,
  mpred_nf1_negation(P,NFp),
  mpred_nf1_negation(Q,NFq),
  append(NFp,NFq,NF).

mpred_nf1_negation((P,Q),NF):- 
  % this code is not correct! twf.
  !,
  mpred_nf1_negation(P,NF) 
  ;
  (mpred_nf1(P,Pnf),
   mpred_nf1_negation(Q,Qnf),
   append(Pnf,Qnf,NF)).

mpred_nf1_negation(P,[\+P]).


%%  mpred_nf_negations(List2,List) is det.
%
% sweeps through List2 to produce List,
%  changing -{...} to {\+...}
% % ? is this still needed? twf 3/16/90

%% mpred_nf_negations( :TermX, :TermX) is semidet.
%
% PFC Normal Form Negations.
%
mpred_nf_negations(X,X) :- !.  % I think not! twell_founded_0 3/27/90

mpred_nf_negations([],[]).

mpred_nf_negations([H1|T1],[H2|T2]):-
  mpred_nf_negation(H1,H2),
  mpred_nf_negations(T1,T2).


%% mpred_nf_negation(+X, ?X) is semidet.
%
% PFC Normal Form Negation.
%
mpred_nf_negation(Form,{\+ X}):- 
  nonvar(Form),
  Form=(-({X})),
  !.
mpred_nf_negation(X,X).


 
%%  build_rhs(+Conjunction,-Rhs)
% 

build_rhs(X,[X]):- 
  var(X),
  !.

build_rhs((A,B),[A2|Rest]):- 
  !, 
  mpred_compile_rhs_term(A,A2),
  build_rhs(B,Rest).

build_rhs(X,[X2]):-
   mpred_compile_rhs_term(X,X2).


mpred_compile_rhs_term(_Sup,P,P):-is_ftVar(P),!.
mpred_compile_rhs_term(Sup,(P/C),((P0:-C0))) :- !,mpred_compile_rhs_term(Sup,P,P0),build_code_test(Sup,C,C0),!.
mpred_compile_rhs_term(Sup,I,O):- if_defined_else(to_addable_form_wte(mpred_compile_rhs_term,I,O),I=O), must(\+ \+ mpred_mark_as(Sup,p,O,pfcRHS)),!.

mpred_compile_rhs_term((P/C),((P:-C))):- !.
mpred_compile_rhs_term(P,P).



%% mpred_negation(+N, ?P) is semidet.
%
%  is true if N is a negated term and P is the term
%  with the negation operator stripped.
%
mpred_negation(P,_):- is_ftVar(P),!,fail.
mpred_negation((\+(P)),P).
mpred_negation((-P),P).



%% mpred_negated_literal(+P) is semidet.
%
% PFC Negated Literal.
%
mpred_negated_literal(P):- 
  mpred_negation(P,Q),
  mpred_positive_literal(Q).

mpred_literal(X):- mpred_negated_literal(X),!.
mpred_literal(X):- mpred_positive_literal(X),!.
mpred_literal(X):- is_ftVar(X),!.

mpred_positive_literal(X):-   is_ftNonvar(X),
  get_functor(X,F,_), 
  \+ mpred_connective(F),
  !.


%% mpred_connective(+VALUE1) is semidet.
%
% PFC Connective.
%
mpred_connective(';').
mpred_connective(',').
mpred_connective('/').
mpred_connective('|').
mpred_connective(('==>')).
mpred_connective(('<-')).
mpred_connective('<==>').

mpred_connective('-').
% mpred_connective('~').
mpred_connective('\\+').


%% process_rule(+Lhs, ?Rhs, ?Parent_rule) is semidet.
%
% Process Rule.
%
process_rule(Lhs,Rhs,Parent_rule):-
  get_source_ref1(U),
  copy_term(Parent_rule,Parent_ruleCopy),
  build_rhs(Rhs,Rhs2),
  foreachl_do(mpred_nf(Lhs,Lhs2), 
          build_rule(Lhs2,rhs(Rhs2),(Parent_ruleCopy,U))).


%% build_rule(+Lhs, ?Rhs, ?Support) is semidet.
%
% Build Rule.
%
build_rule(Lhs,Rhs,Support):-
  copy_term(Support,WS),
  mpred_mark_as(WS,p,Lhs,pfcLHS),
  build_trigger(WS,Lhs,Rhs,Trigger),
  cyclic_break((Lhs,Rhs,WS,Trigger)),
  mpred_eval_lhs(Trigger,Support).

build_trigger(WS,[],Consequent,ConsequentO):-
   build_consequent(WS,Consequent,ConsequentO).

build_trigger(WS,[V|Triggers],Consequent,pt(V,X)):-
  var(V),
  !, 
  build_trigger(WS,Triggers,Consequent,X).

build_trigger(WS,[(T1/Test)|Triggers],Consequent,nt(T2,Test2,X)):-
  mpred_negation(T1,T2),
  !, 
  build_neg_test(WS,T2,Test,Test2),
  build_trigger(WS,Triggers,Consequent,X).

build_trigger(WS,[(T1)|Triggers],Consequent,nt(T2,Test,X)):-
  mpred_negation(T1,T2),
  !,
  build_neg_test(WS,T2,true,Test),
  build_trigger(WS,Triggers,Consequent,X).

build_trigger(WS,[{Test}|Triggers],Consequent,(Test->X)):-
  !,
  build_trigger(WS,Triggers,Consequent,X).

build_trigger(WS,[T/Test|Triggers],Consequent,pt(T,X)):-
  !, 
  build_code_test(WS, Test,Test2),
  build_trigger(WS,[{Test2}|Triggers],Consequent,X).


%build_trigger(WS,[snip|Triggers],Consequent,snip(X)):-
%  !,
%  build_trigger(WS,Triggers,Consequent,X).

build_trigger(WS,[T|Triggers],Consequent,pt(T,X)):-
  !, 
  build_trigger(WS,Triggers,Consequent,X).

% 
%  build_neg_test(WS,+,+,-).
% 
%  builds the test used in a negative trigger (nt/3).  This test is a
%  conjunction of the check than no matching facts are in the db and any
%  additional test specified in the rule attached to this - term.
% 

build_neg_test(WS,T,Testin,Testout):-
  build_code_test(WS,Testin,Testmid),
  %% 
  mpred_conjoin((call_u(T)),Testmid,Testout).



%% check_never_assert(+Pred) is semidet.
%
% Check Never Assert.
%
check_never_assert(Pred):- notrace((( copy_term_and_varnames(Pred,Pred_2),call_u(never_assert_u(Pred_2,Why)),
  Pred=@=Pred_2,trace_or_throw(never_assert_u(Pred,Why))))),fail.
check_never_assert(Pred):- notrace(ignore(( copy_term_and_varnames(Pred,Pred_2),call_u(never_assert_u(Pred_2)),Pred=@=Pred_2,trace_or_throw(never_assert_u(Pred))))).

%% check_never_retract(+Pred) is semidet.
%
% Check Never Retract.
%
check_never_retract(Pred):- hotrace(ignore(( copy_term_and_varnames(Pred,Pred_2),call_u(never_retract_u(Pred_2,Why)),Pred=@=Pred_2,trace_or_throw(never_retract_u(Pred,Why))))).


:- export(mpred_mark_as_ml/4).

%% mpred_mark_as_ml(+Sup, ?PosNeg, ?Type, ?P) is semidet.
%
% PFC Mark Converted To Ml.
%
mpred_mark_as_ml(Sup,PosNeg,Type,P):- mpred_mark_as(Sup,PosNeg,P,Type).


%% pos_2_neg(+P, ?P) is semidet.
%
% pos  Extended Helper Negated.
%
pos_2_neg(p,n):-!.
pos_2_neg(n,p):-!.
pos_2_neg(P,~(P)).


%% mpred_mark_as(+VALUE1, ?VALUE2, :TermP, ?VALUE4) is semidet.
%
% PFC Mark Converted To.
%
mpred_mark_as(_,_,P,_):- is_ftVar(P),!.
mpred_mark_as(Sup,Pos,\+(P),Type):- pos_2_neg(Pos,Neg),!,mpred_mark_as(Sup,Neg,P,Type).
mpred_mark_as(Sup,Pos,~(P),Type):- pos_2_neg(Pos,Neg),!,mpred_mark_as(Sup,Neg,P,Type).
mpred_mark_as(Sup,Pos,-(P),Type):- pos_2_neg(Pos,Neg),!,mpred_mark_as(Sup,Neg,P,Type).
mpred_mark_as(Sup,Pos,not(P),Type):- pos_2_neg(Pos,Neg),!,mpred_mark_as(Sup,Neg,P,Type).
mpred_mark_as(Sup,PosNeg,[P|PL],Type):- is_list([P|PL]), !,must_maplist(mpred_mark_as_ml(Sup,PosNeg,Type),[P|PL]).
mpred_mark_as(Sup,PosNeg,( P / CC ),Type):- !, mpred_mark_as(Sup,PosNeg,P,Type),mpred_mark_as(Sup,PosNeg,( CC ),pfcCallCode).
mpred_mark_as(Sup,PosNeg,'{}'(  CC ), _Type):- mpred_mark_as(Sup,PosNeg,( CC ),pfcCallCode).
mpred_mark_as(Sup,PosNeg,( A , B), Type):- !, mpred_mark_as(Sup,PosNeg,A, Type),mpred_mark_as(Sup,PosNeg,B, Type).
mpred_mark_as(Sup,PosNeg,( A ; B), Type):- !, mpred_mark_as(Sup,PosNeg,A, Type),mpred_mark_as(Sup,PosNeg,B, Type).
mpred_mark_as(Sup,PosNeg,( A ==> B), Type):- !, mpred_mark_as(Sup,PosNeg,A, Type),mpred_mark_as(Sup,PosNeg,B, pfcRHS).
mpred_mark_as(Sup,PosNeg,( B <- A), Type):- !, mpred_mark_as(Sup,PosNeg,A, Type),mpred_mark_as(Sup,PosNeg,B, pfcRHS).
%mpred_mark_as(_Sup,_PosNeg,( _ :- _ ),_Type):-!.
mpred_mark_as(Sup,PosNeg,( P :- CC ),Type):- !, mpred_mark_as(Sup,PosNeg,P,Type),mpred_mark_as(Sup,PosNeg,( CC ),pfcCallCode).
mpred_mark_as(Sup,PosNeg,P,Type):-get_functor(P,F,A),ignore(mpred_mark_fa_as(Sup,PosNeg,P,F,A,Type)),!.




%% mpred_mark_fa_as(+Sup, ?PosNeg, ?P, ?F, ?A, ?Type) is semidet.
%
% PFC Mark Functor-arity Converted To.
%
% mpred_mark_fa_as(_,_,_,'\=',2,_):- trace.
mpred_mark_fa_as(_Sup,_PosNeg,_P,isa,_,_):- !.
mpred_mark_fa_as(_Sup,_PosNeg,_P,t,_,_):- !.
mpred_mark_fa_as(_Sup,_PosNeg,_P,argIsa,N,_):- !,must(N=3).
mpred_mark_fa_as(_Sup,_PosNeg,_P,arity,N,_):- !,must(N=2).
mpred_mark_fa_as(_Sup,_PosNeg,_P,mpred_mark,N,_):- !,must(N=4).
mpred_mark_fa_as(_Sup,_PosNeg,_P,mpred_isa,N,_):- must(N=2).
mpred_mark_fa_as(_Sup,_PosNeg,_P,'[|]',N,_):- trace,must(N=2).
mpred_mark_fa_as(_Sup,_PosNeg,_P,_:mpred_isa,N,_):- must(N=2).
mpred_mark_fa_as(Sup, PosNeg,_P,F,A,Type):- really_mpred_mark(Sup,Type,PosNeg,F,A),!.

really_mpred_mark(Sup,Type,PosNeg,F,A):- \+ current_predicate(_:make_declared_now/1),!,dmsg(really_mpred_mark(Sup,Type,PosNeg,F,A)),!.
really_mpred_mark(_  ,Type,PosNeg,F,A):- call_u(mpred_mark(Type,PosNeg,F,A)),!.
really_mpred_mark(Sup,Type,PosNeg,F,A):- 
  MARK = mpred_mark(Type,PosNeg,F,A),
  check_never_assert(MARK),
  with_no_mpred_trace_exec(with_search_mode(direct,ain_fast(MARK,(s(Sup),ax)))).
  % with_no_mpred_trace_exec(with_search_mode(direct,mpred_fwc1(MARK,(s(Sup),ax)))),!.
   

%% fa_to_p(+F, ?A, ?P) is semidet.
%
% Functor-arity Converted To Pred.
%
fa_to_p(F,A,P):-integer(A),atom(F),functor(P,F,A),( P \= call_u(_) ),( P \= '$VAR'(_)).
  

%% build_code_test(+WS, ?Test, ?TestO) is semidet.
%
% Build Code Test.
%
% this just strips away any currly brackets.
%
build_code_test(_Support,Test,TestO):-is_ftVar(Test),!,must(is_ftNonvar(Test)),TestO=call_u(Test).
build_code_test(WS,{Test},TestO) :- !,build_code_test(WS,Test,TestO).
build_code_test(WS,Test,TestO):- code_sentence_op(Test),Test=..[F|TestL],must_maplist(build_code_test(WS),TestL,TestLO),TestO=..[F|TestLO],!.
build_code_test(WS,Test,Test):- must(mpred_mark_as(WS,p,Test,pfcCallCode)),!.
build_code_test(_,Test,Test).


%% code_sentence_op( :TermVar) is semidet.
%
% Code Sentence Oper..
%
code_sentence_op(Var):-is_ftVar(Var),!,fail.
code_sentence_op(rhs(_)).
code_sentence_op(~(_)).
code_sentence_op(-(_)).
code_sentence_op(-(_)).
code_sentence_op(\+(_)).
code_sentence_op(call_u(_)).
code_sentence_op(call_u(_,_)).
code_sentence_op(Test):-predicate_property(Test,meta_predicate(PP)),predicate_property(Test,built_in),  \+ (( arg(_,PP,N), N\=0)).


%% all_closed(+C) is semidet.
%
% All Closed.
%
all_closed(C):- \+is_ftCompound(C)->true;(functor(C,_,A),A>1,\+((arg(_,C,Arg),is_ftVar(Arg)))),!.


%% build_consequent(+Support, +TestIn, -TestOut) is semidet.
%
% Build Consequent.
%
build_consequent(_      ,Test,Test):- is_ftVar(Test),!.
build_consequent(_      ,Test,TestO):-is_ftVar(Test),!,TestO=added(Test).
build_consequent(WS,rhs(Test),rhs(TestO)) :- !,build_consequent(WS,Test,TestO).
build_consequent(WS,Test,TestO):- code_sentence_op(Test),Test=..[F|TestL],
   maplist(build_consequent(WS),TestL,TestLO),TestO=..[F|TestLO],!.
build_consequent(WS,Test,Test):-must(mpred_mark_as(WS,p,Test,pfcCreates)),!.
build_consequent(_ ,Test,Test).


%% mpred_db_type(+VALUE1, ?Type) is semidet.
%
% PFC Database Type.
%
%  simple typeing for Pfc objects
%
mpred_db_type(Var,Type):- var(Var),!, Type=fact(_FT).
mpred_db_type(~_,Type):- !, Type=fact(_FT).
mpred_db_type(('==>'(_,_)),Type):- !, Type=rule.
mpred_db_type(('<==>'(_,_)),Type):- !, Type=rule.
mpred_db_type(('<-'(_,_)),Type):- !, Type=rule.
mpred_db_type(pt(_,_,_),Type):- !, Type=trigger.
mpred_db_type(pt(_,_),Type):- !, Type=trigger.
mpred_db_type(nt(_,_,_),Type):- !,  Type=trigger.
mpred_db_type(bt(_,_),Type):- !,  Type=trigger.
mpred_db_type(actn(_),Type):- !, Type=action.
mpred_db_type((('::::'(_,X))),Type):- !, mpred_db_type(X,Type).
mpred_db_type(((':'(_,X))),Type):- !, mpred_db_type(X,Type).
mpred_db_type(_,fact(_FT)):-
  %  if it''s not one of the above, it must be a fact!
  !.

mpred_assert_w_support(P,Support):- 
  (mpred_clause_u(P) ; assert_u(P)),
  !,
  mpred_add_support(P,Support).

mpred_asserta_w_support(P,Support):-
  (mpred_clause_u(P) ; asserta_u(P)),
  !,
  mpred_add_support(P,Support).

mpred_assertz_w_support(P,Support):-
  (mpred_clause_u(P) ; assertz_u(P)),
  !,
  mpred_add_support(P,Support).



%% mpred_clause_u(+Head) is semidet.
%
% PFC Clause For Internal Interface.
%
mpred_clause_u((Head:- Body)):-
  !,
  copy_term((Head:-Body),(Head_copy:-Body_copy)),
  clause_u(Head,Body),
  variant(Head,Head_copy),
  variant(Body,Body_copy).

mpred_clause_u(Head):-
  % find a unit clause identical to Head by finding one which unifies,
  % and then checking to see if it is identical
  copy_term(Head,Head_copy),
  clause_u(Head_copy,true),
  variant(Head,Head_copy).



%% foreachl_do(+Binder, ?Body) is semidet.
%
% Foreachl Do.
%
foreachl_do(Binder,Body):- Binder,pfcl_do(Body),fail.
foreachl_do(_,_).


%% pfcl_do(+X) is semidet.
%
% executes P once and always succeeds.
%
pfcl_do(X):- X,!.
pfcl_do(_).


%% mpred_union(L1,L2,L3) is semidet.
%
%  true if set L3 is the result of appending sets
%  L1 and L2 where sets are represented as simple lists.
%
mpred_union([],L,L).
mpred_union([Head|Tail],L,Tail2):-  
  memberchk(Head,L),
  !,
  mpred_union(Tail,L,Tail2).
mpred_union([Head|Tail],L,[Head|Tail2]):-  
  mpred_union(Tail,L,Tail2).


%  mpred_conjoin(+Conjunct1,+Conjunct2,?Conjunction).
%  arg3 is a simplified expression representing the conjunction of
%  args 1 and 2.

mpred_conjoin(true,X,X):- !.
mpred_conjoin(X,true,X):- !.
mpred_conjoin(C1,C2,(C1,C2)).



%   File   : pfcdb.pl
%   Author : Tim Finin, finin@prc.unisys.com
%   Author :  Dave Matuszek, dave@prc.unisys.com
%   Author :  Dan Corpron
%   Updated: 10/11/87, ...
%   Purpose: predicates to manipulate a Pfc database (e.ax. save,
% 	restore, reset, etc.)

%% mpred_database_term(:PI, -TYPE) is nondet.
%
% is true iff F/A is something that Pfc adds to
% the database and should not be present in an empty Pfc database
%
:- dynamic(mpred_database_term/2).
% mined from program database      
mpred_database_term(do_and_undo/2,rule).
mpred_database_term(('::::')/2,rule).
mpred_database_term((<-)/2,rule).
mpred_database_term((<==>)/2,rule).
mpred_database_term((==>)/2,rule).
mpred_database_term((==>)/1,fact(_)).
mpred_database_term((~)/1,fact(_)).
% forward/backward chaining database
mpred_database_term(spft/3,support).
mpred_database_term(nt/3,trigger).
mpred_database_term(pt/2,trigger).
mpred_database_term(bt/2,trigger).
% transient state
mpred_database_term(actn/1,state).
mpred_database_term(que/1,state).
mpred_database_term(hs/1,state).
% forward/backward settings
mpred_database_term(mpred_current_db/1,setting).
mpred_database_term(mpred_select_hook/1,setting).
mpred_database_term(tms/1,setting).
mpred_database_term(sm/1,setting). 
% debug settings
mpred_database_term(mpred_is_tracing_pred/1,debug).
mpred_database_term(mpred_is_tracing_exec/0,debug).
mpred_database_term(mpred_is_spying_pred/2,debug).
mpred_database_term(mpred_warnings/1,debug).
mpred_database_term(why_buffer/2,debug).


%% mpred_reset() is det.
%
% removes all forward chaining rules and justifications from db.
%
mpred_reset:- 
  SPFT = spft(P,_ZF,_ZTrigger),
  lookup_u(SPFT),
  mpred_retract_i_or_warn(P),
  mpred_retract_i_or_warn(SPFT),
  fail.
mpred_reset:-
  mpred_database_item(T),!,
  mpred_warn("Couldn't full mpred_reset: ~p.~n",[T]), must(pp_DB),!,
  mpred_error("Pfc database not empty after mpred_reset, e.ax., ~p.~n",[T]),!.
mpred_reset:- mpred_trace_msg("Reset DB complete").

% true if there is some Pfc crud still in the database.
mpred_database_item(P):-
  mpred_database_term(F/A,Type),
  Type\=debug,
  Type\=setting,
  functor(H,F,A),
  clause_u(H,B), 
  B\= _:loop_check_nr(_),
  B\=@=(cwc, neg_in_code(_G)),
  \+ ( B= H),
  ((B== true)-> P=H; P=(H:B)).


mpred_retract_i_or_warn(X):- retract_u(X), !.
mpred_retract_i_or_warn(spft(P,T,mfl(M,F,A))):- nonvar(A),!,mpred_retract_i_or_warn(spft(P,T,mfl(M,F,_))).
mpred_retract_i_or_warn(spft(P,mfl(M,F,A),T)):- nonvar(A),!,mpred_retract_i_or_warn(spft(P,mfl(M,F,_),T)).
mpred_retract_i_or_warn(spft(P,T,mfl(M,A,F))):- nonvar(A),!,mpred_retract_i_or_warn(spft(P,T,mfl(M,_,F))).
mpred_retract_i_or_warn(spft(P,mfl(M,A,F),T)):- nonvar(A),!,mpred_retract_i_or_warn(spft(P,mfl(M,_,F),T)).
mpred_retract_i_or_warn(SPFT):- \+ \+ SPFT = spft(\+ _,_,_),!.
mpred_retract_i_or_warn(X):- 
  mpred_warn("Couldn't retract_u ~p.~n",[X]),!.
mpred_retract_i_or_warn(X):- 
  mpred_warn("Couldn't retract_u ~p.~n",[X]),
  (debugging(dmiles)->rtrace(retract_u(X));true),!.




%   File   : pfcdebug.pl
%   Author : Tim Finin, finin@prc.unisys.com
%   Author :  Dave Matuszek, dave@prc.unisys.com
%   Updated:
%   Purpose: provides predicates for examining the database and debugginh 
%   for Pfc.

%:- mpred_set_default(baseKB:mpred_warnings(_), baseKB:mpred_warnings(true)).
%  tms is one of {none,local,cycles} and controles the tms alg.
%:- baseKB:mpred_set_default(tms(_), tms(cycles)).


%  mpred_fact(P) is true if fact P was asserted into the database via add.

mpred_fact(P):- mpred_fact(P,true).

%  mpred_fact(P,C) is true if fact P was asserted into the database via
%  add and contdition C is satisfied.  For example, we might do:
%  
%   mpred_fact(X,mpred_userFact(X))
% 

mpred_fact(P,C):- 
  mpred_get_support(P,_),
  mpred_db_type(P,fact(_FT)),
  call_u(C).

%  mpred_facts(-ListofPmpred_facts) returns a list of facts added.

mpred_facts(L):- mpred_facts(_,true,L).

mpred_facts(P,L):- mpred_facts(P,true,L).

%  mpred_facts(Pattern,Condition,-ListofPmpred_facts) returns a list of facts added.

%% mpred_facts(+P, ?C, ?L) is semidet.
%
% PFC Facts.
%
mpred_facts(P,C,L):- setof(P,mpred_fact(P,C),L).


%% brake(+X) is semidet.
%
% Brake.
%
brake(X):-  X, break.


% 
%  predicates providing a simple tracing facility
% 

% this is here for upward compat. - should go away eventually.
mpred_trace_op(Add,P):-   
  mpred_trace_op(Add,P,(o,o)).


mpred_trace_op(Add,P,S):-  
   mpred_trace_maybe_print(Add,P,S),
   mpred_trace_maybe_break(Add,P,S).
   

mpred_trace_maybe_print(Add,P,S):-
  \+ lookup_u(mpred_is_tracing_pred(P)) -> true;
  (
   (to_u(S,U)
       -> wdmsg("~NOP: ~p (~p) ~p",[Add,U,P])
        ; wdmsg("~NOP: ~p (:) ~p~N\tSupported By: ~p",[Add,P,S]))),!.

to_u(S,U):-S=(U,U),!.
to_u(S,U):-S=(U,ax),!.

mpred_trace_maybe_break(Add,P,_ZS):-
  \+ lookup_u(mpred_is_spying_pred(P,Add)) -> true;
   (wdmsg("~NBreaking on ~p(~p)",[Add,P]),
    break).
   



mpred_trace:- mpred_trace(_).

mpred_trace(Form):-
  assert_u(mpred_is_tracing_pred(Form)).

%% get_mpred_is_tracing(:PRED) is semidet.
%
% PFC If Is A Tracing.
%
get_mpred_is_tracing(Form):- clause_u(mpred_is_tracing_pred(Form),B),!,call(B).
get_mpred_is_tracing(_):- lookup_u(mpred_is_tracing_exec) ; t_l:mpred_debug_local.

%% mpred_trace(+Form, ?Condition) is semidet.
%
% PFC Trace.
%
mpred_trace(Form,Condition):- 
  assert_u((mpred_is_tracing_pred(Form):- Condition)).

mpred_spy(Form):- mpred_spy(Form,[add,rem],true).

mpred_spy(Form,Modes):- mpred_spy(Form,Modes,true).

mpred_spy(Form,[add,rem],Condition):-
  !,
  mpred_spy1(Form,add,Condition),
  mpred_spy1(Form,mpred_withdraw,Condition).

mpred_spy(Form,Mode,Condition):-
  mpred_spy1(Form,Mode,Condition).

mpred_spy1(Form,Mode,Condition):-
  assert_u((mpred_is_spying_pred(Form,Mode):- Condition)).

mpred_nospy:- mpred_nospy(_,_,_).

mpred_nospy(Form):- mpred_nospy(Form,_,_).

mpred_nospy(Form,Mode,Condition):- 
  clause_u(mpred_is_spying_pred(Form,Mode), Condition, Ref),
  erase(Ref),
  fail.
mpred_nospy(_,_,_).

mpred_notrace:- mpred_untrace.
mpred_untrace:- mpred_untrace(_).
mpred_untrace(Form):- retractall_u(mpred_is_tracing_pred(Form)).

% needed:  mpred_trace_rule(Name)  ...


% if the correct flag is set, trace exection of Pfc
mpred_trace_msg(Info):- notrace(((lookup_u(mpred_is_tracing_exec);tracing)->in_cmt(wdmsg(Info));true)).
mpred_trace_msg(Format,Args):- notrace((format_to_message(Format,Args,Info),mpred_trace_msg(Info))).

mpred_warn(Info):- notrace((lookup_u(mpred_warnings(true));tracing) -> wdmsg(warn(mpred,Info)) ; mpred_trace_msg('WARNING/PFC: ~p',[Info])),
                (debugging(mpred)->trace;true).
mpred_warn(Format,Args):- notrace((format_to_message(Format,Args,Info),mpred_warn(Info))).

mpred_error(Info):- notrace(tracing -> wdmsg(error(pfc,Info)) ; mpred_warn(error(Info))).
mpred_error(Format,Args):- notrace((format_to_message(Format,Args,Info),mpred_error(Info))).


mpred_watch:- assert_u(mpred_is_tracing_exec).
mpred_trace_exec:- assert_u(mpred_is_tracing_exec).

mpred_nowatch:-  retractall_u(mpred_is_tracing_exec).

%% with_mpred_trace_exec( +P) is semidet.
%
% Using Trace exec.
%
with_mpred_trace_exec(P):- get_user_abox(M),
   w_tl(t_l:mpred_debug_local,w_tl(M:mpred_is_tracing_exec, must(show_if_debug(P)))).

%% with_mpred_trace_exec( +P) is semidet.
%
% Without Trace exec.
%
with_no_mpred_trace_exec(P):- get_user_abox(M),
   wno_tl(t_l:mpred_debug_local,wno_tl(M:mpred_is_tracing_exec, must(show_if_debug(P)))).

%% show_if_debug( :GoalA) is semidet.
%
% Show If Debug.
%
:- meta_predicate(show_if_debug(0)).
% show_if_debug(A):- !,show_call(why,A).
show_if_debug(A):- get_mpred_is_tracing(A) -> show_call(A) ; A.

:- thread_local(t_l:mpred_debug_local/0).

%% mpred_is_silient is det.
%
% If Is A Silient.
%
mpred_is_silient :- ( \+ t_l:mpred_debug_local, \+ lookup_u(mpred_is_tracing_exec), \+ lookup_u(mpred_is_tracing_pred(_)), 
  current_prolog_flag(debug,false), is_release) ,!.


%% mpred_test(+P) is semidet.
%
% PFC Test.
%
mpred_test(_):- (compiling; current_prolog_flag(xref,true)),!.
mpred_test(G):- mpred_is_silient,!, with_no_mpred_trace_exec(must(mpred_test_fok(G))).
mpred_test(G):- with_mpred_trace_exec(must(mpred_test_fok(G))).

why_was_true(P):- mpred_why(P),!.
why_was_true(P):- dmsg(justfied_true(P)),!.

mpred_test_fok(\+ G):-!, ( \+ call_u(G) -> wdmsg(passed_mpred_test(\+ G)) ; (wdmsg(failed_mpred_test(\+ G)),!,ignore(why_was_true(G)),!,fail)).
mpred_test_fok(G):- (call_u(G) -> sanity(why_was_true(G)) ; (wdmsg(failed_mpred_test(G)),!,fail)).


mpred_load_term(:- module(_,L)):-!, call_u(maplist(export,L)).
mpred_load_term(:- TermO):- call_u(TermO).
mpred_load_term(TermO):-mpred_ain_object(TermO).

mpred_load(PLNAME):- % unload_file(PLNAME),
   open(PLNAME, read, In, []),
   repeat,
   line_count(In,_Lineno),
   % double_quotes(_DQBool)
   Options = [variables(_Vars),variable_names(VarNames),singletons(_Singletons),comment(_Comment)],
   catchv((read_term(In,Term,[syntax_errors(error)|Options])),E,(dmsg(E),fail)),
   b_setval('$variable_names',VarNames),expand_term(Term,TermO),mpred_load_term(TermO),
   Term==end_of_file,
   close(In).

% 
%  These control whether or not warnings are printed at all.
%    mpred_warn.
%    nompred_warn.
% 
%  These print a warning message if the flag mpred_warnings is set.
%    mpred_warn(+Message)
%    mpred_warn(+Message,+ListOfArguments)
% 

mpred_warn:- 
  retractall_u(mpred_warnings(_)),
  assert_u(mpred_warnings(true)).

nompred_warn:-
  retractall_u(mpred_warnings(_)),
  assert_u(mpred_warnings(false)).
 

%%  mpred_set_warnings(+TF) is det.
%   true = sets flag to cause Pfc warning messages to print.
%   false = sets flag to cause Pfc warning messages not to print.
% 
mpred_set_warnings(True):- 
  retractall_u(mpred_warnings(_)),
  assert_u(mpred_warnings(True)).
mpred_set_warnings(false):- 
  retractall_u(mpred_warnings(_)).

%   File   : pfcjust.pl
%   Author : Tim Finin, finin@prc.unisys.com
%   Author :  Dave Matuszek, dave@prc.unisys.com
%   Updated:
%   Purpose: predicates for accessing Pfc justifications.
%   Status: more or less working.
%   Bugs:

%  *** predicates for exploring supports of a fact *****


:- use_module(library(lists)).

justification(F,J):- supporters_list(F,J).

justifications(F,Js):- bagof(J,justification(F,J),Js).



%%  mpred_basis_list(+P,-L)
%
%  is true iff L is a list of "base" facts which, taken
%  together, allows us to deduce P.  A mpred "based on" list fact is an axiom (a fact 
%  added by the user or a raw Prolog fact (i.e. one w/o any support))
%  or an assumption.
%
mpred_basis_list(F,[F]):- (mpred_axiom(F) ; mpred_assumption(F)),!.

mpred_basis_list(F,L):-
  % i.e. (reduce 'append (map 'mpred_basis_list (justification f)))
  justification(F,Js),
  bases_union(Js,L).


%%  bases_union(+L1,+L2).
%
%  is true if list L2 represents the union of all of the 
%  facts on which some conclusion in list L1 is based.
%
bases_union([],[]).
bases_union([X|Rest],L):-
  mpred_basis_list(X,Bx),
  bases_union(Rest,Br),
  mpred_union(Bx,Br,L).
	
mpred_axiom(F):- 
  mpred_get_support(F,(_,ax)).

%% mpred_assumption(P)
% 
%  an mpred_assumption is a failed goal, i.e. were assuming that our failure to 
%  prove P is a proof of not(P)
%
mpred_assumption(P):- mpred_negation(P,_).
   

%% mpred_assumptions( +X, +AsSet) is semidet.
%
% true if AsSet is a set of assumptions which underly X.
%
mpred_assumptions(X,[X]):- mpred_assumption(X).
mpred_assumptions(X,[]):- mpred_axiom(X).
mpred_assumptions(X,L):-
  justification(X,Js),
  do_assumpts(Js,L).


%% do_assumpts(+Set1,?Set2) is semidet.
%
% Assumptions Secondary Helper.
%
do_assumpts([],[]).
do_assumpts([X|Rest],L):-
  mpred_assumptions(X,Bx),
  do_assumpts(Rest,Br),
  mpred_union(Bx,Br,L).  


%  mpred_proofTree(P,T) the proof tree for P is T where a proof tree is
%  of the form
% 
%      [P , J1, J2, ;;; Jn]         each Ji is an independent P justifier.
%           ^                         and has the form of
%           [J11, J12,... J1n]      a list of proof trees.


%% mpred_child(+P,?Q) is semidet.
%
% is true iff P is an immediate justifier for Q.
%
mpred_child(P,Q):-
  mpred_get_support(Q,(P,_)).

mpred_child(P,Q):-
  mpred_get_support(Q,(_,Trig)),
  mpred_db_type(Trig,trigger),
  mpred_child(P,Trig).


%% mpred_children(+P, ?L) is semidet.
%
% PFC Children.
%
mpred_children(P,L):- bagof(C,mpred_child(P,C),L).



%% mpred_descendant(+P, ?Q) is semidet.
%
% mpred_descendant(P,Q) is true iff P is a justifier for Q.
%
mpred_descendant(P,Q):- 
   mpred_descendant1(P,Q,[]).


%% mpred_descendant1(+P, ?Q, ?Seen) is semidet.
%
% PFC Descendant Secondary Helper.
%
mpred_descendant1(P,Q,Seen):-
  mpred_child(X,Q),
  (\+ member(X,Seen)),
  (P=X ; mpred_descendant1(P,X,[X|Seen])).
  

%% mpred_descendants(+P, ?L) is semidet.
%
% PFC Descendants.
%
mpred_descendants(P,L):- 
  bagof(Q,mpred_descendant1(P,Q,[]),L).

bagof_or_nil(T,G,B):- (bagof(T,G,B) *-> true; B=[]).

% 
%  predicates for manipulating support relationships
% 

%  mpred_add_support(+Fact,+Support)
mpred_add_support(P,(Fact,Trigger)):-
 % (Trigger= nt(F,Condition,Action) -> 
 %   (mpred_trace_msg('~N~n\tAdding mpred_do_fcnt via support~n\t\ttrigger: ~p~n\t\tcond: ~p~n\t\taction: ~p~n\t from: ~p~N',
 %     [F,Condition,Action,mpred_add_support(P,(Fact,Trigger))]));true),
  assert_u(spft(P,Fact,Trigger)).

mpred_get_support(P,(Fact,Trigger)):-
      lookup_u(spft(P,Fact,Trigger)).


mpred_rem_support_if_exists(P,(Fact,Trigger)):-
 SPFT = spft(P,Fact,Trigger),
  lookup_u(SPFT),
  once(mpred_retract_i_or_warn(SPFT)).



mpred_rem_support(P,(Fact,Trigger)):-
  mpred_retract_i_or_warn(spft(P,Fact,Trigger)).


mpred_collect_supports(Tripples):-
  bagof_or_nil(Tripple, mpred_support_relation(Tripple), Tripples).

mpred_support_relation((P,F,T)):-
  lookup_u(spft(P,F,T)).

mpred_make_supports((P,S1,S2)):- 
  mpred_add_support(P,(S1,S2)),
  (mpred_ain_object(P); true),
  !.

%%  mpred_trigger_key(+Trigger,-Key) 
% 
%  Arg1 is a trigger.  Key is the best term to index it on.
% 
%  Get a key from the trigger that will be used as the first argument of
%  the trigger base clause that stores the trigger.

mpred_trigger_key(X,X):- var(X), !.
mpred_trigger_key(pt(Key,_),Key).
mpred_trigger_key(pk(Key,_,_),Key).
mpred_trigger_key(nt(Key,_,_),Key).
mpred_trigger_key(Key,Key).

% For chart parser
mpred_trigger_key(chart(word(W),_ZL),W):- !.
mpred_trigger_key(chart(stem([Char1|_ZRest]),_ZL),Char1):- !.
mpred_trigger_key(chart(Concept,_ZL),Concept):- !.
mpred_trigger_key(X,X).



%%%%%%%%%%%%%%%%%% 99999999999999999999999999999999999999999999

%%%%%%%%%%%%%%%%%% 99999999999999999999999999999999999999999999

%% pp_DB is semidet.
%
% Pretty Print All.
%
pp_DB:-
 must_det_l((
  pp_db_facts,
  pp_db_rules,
  pp_db_triggers,
  pp_db_supports)).

%  pp_db_facts ...

pp_db_facts:- ignore(pp_db_facts(_,true)).

pp_db_facts(Pattern):- pp_db_facts(Pattern,true).

pp_db_facts(P,C):-
  mpred_facts(P,C,L),
  mpred_classifyFacts(L,User,Pfc,_ZRule),
  format("~N~nUser added facts:",[]),
  pp_db_items(User),
  format("~N~nPfc added facts:",[]),
  pp_db_items(Pfc).

%  printitems clobbers it''s arguments - beware!


pp_db_items(Var):-var(Var),!,format("~N  ~p",[Var]).
pp_db_items([]):-!.
pp_db_items([H|T]):- !,
  % numbervars(H,0,_),
  format("~N  ~p",[H]),
  nonvar(T),pp_db_items(T).
pp_db_items(Var):-format("~N  ~p",[Var]).

mpred_classifyFacts([],[],[],[]).

mpred_classifyFacts([H|T],User,Pfc,[H|Rule]):-
  mpred_db_type(H,rule),
  !,
  mpred_classifyFacts(T,User,Pfc,Rule).

mpred_classifyFacts([H|T],[H|User],Pfc,Rule):-
  get_source_ref(UU),
  mpred_get_support(H,UU),
  !,
  mpred_classifyFacts(T,User,Pfc,Rule).

mpred_classifyFacts([H|T],User,[H|Pfc],Rule):-
  mpred_classifyFacts(T,User,Pfc,Rule).

pp_db_rules:-
 format("~NRules...~n",[]),
  bagof_or_nil((P==>Q),clause_u((P==>Q),true),R1),
  pp_db_items(R1),
  bagof_or_nil((P<==>Q),clause_u((P<==>Q),true),R2),
  pp_db_items(R2),
  bagof_or_nil((P<-Q),clause_u((P<-Q),true),R3),
  pp_db_items(R3).

pp_db_triggers:-
  format("~NPositive triggers...~n",[]),
  bagof_or_nil(pt(T,B),lookup_u(pt(T,B)),Pts),
  pp_db_items(Pts),
  format("~NNegative triggers...~n",[]),
  bagof_or_nil(nt(A,B,C),lookup_u(nt(A,B,C)),Nts),
  pp_db_items(Nts),
  format("~NGoal triggers...~n",[]),
  bagof_or_nil(bt(A,B),lookup_u(bt(A,B)),Bts),
  pp_db_items(Bts).

pp_db_supports:- 
  % temporary hack.
  format("~NSupports...~n",[]),
  setof((P >= S), mpred_get_support(P,S),L),
  pp_db_items(L),!.
pp_db_supports:- bagof_or_nil((P =< S),mpred_get_support(P,S),Bts),pp_db_items(Bts),!.

%   File   : mpred_why.pl
%   Author : Tim Finin, finin@prc.unisys.com
%   Updated:
%   Purpose: predicates for interactively exploring Pfc justifications.

% ***** predicates for brousing justifications *****

:- use_module(library(lists)).

pp_why:-mpred_why.

mpred_why:- 
  lookup_u(why_buffer(P,_)),
  mpred_why(P).

pp_why(A):-mpred_why(A).

mpred_why(N):-
  number(N),
  !,
  lookup_u(why_buffer(P,Js)),
  mpred_handle_why_command(N,P,Js).

mpred_why(M:P):-atom(M),!,mpred_why(P).
mpred_why(P):-
  justifications(P,Js),
  retractall_u(why_buffer(_,_)),
  assert_u(why_buffer(P,Js)),
  mpred_whyBrouse(P,Js).

mpred_why1(P):-
  justifications(P,Js),
  mpred_whyBrouse(P,Js).

% non-interactive
mpred_whyBrouse(P,Js):- 
   must(notrace(in_cmt((mpred_pp_db_justifications(P,Js))))), !.

% Interactive
mpred_whyBrouse(P,Js):-
  mpred_pp_db_justifications(P,Js),
  mpred_prompt_ask(' >> ',Answer),
  mpred_handle_why_command(Answer,P,Js).

mpred_handle_why_command(q,_,_):- !.
mpred_handle_why_command(h,_,_):- 
  !,
  format("~N
Justification Brouser Commands:
 q   quit.
 N   focus on Nth justification.
 N.M brouse step M of the Nth justification
 user   up a level ~n",
  []).

mpred_handle_why_command(N,_ZP,Js):-
  float(N),
  !,
  mpred_select_justification_node(Js,N,Node),
  mpred_why1(Node).

mpred_handle_why_command(u,_,_):-
  % u=up
  !.

mpred_unhandled_command(N,_,_):-
  integer(N),
  !,
  format("~N~p is a yet unimplemented command.",[N]),
  fail.

mpred_unhandled_command(X,_,_):-
 format("~N~p is an unrecognized command, enter h. for help.",[X]),
 fail.
  
mpred_pp_db_justifications(P,Js):-
 must(notrace(( format("~NJustifications for ~p:",[P]),
  mpred_pp_db_justification1(Js,1)))).

mpred_pp_db_justification1([],_).

mpred_pp_db_justification1([J|Js],N):-
  % show one justification and recurse.
  nl,
  mpred_pp_db_justifications2(J,N,1),
  N2 is N+1,
  mpred_pp_db_justification1(Js,N2).

mpred_pp_db_justifications2([],_,_).

mpred_pp_db_justifications2([C|Rest],JustNo,StepNo):- 
 (StepNo==1->fmt('~N~n',[]);true),
  copy_term(C,CCopy),
  numbervars(CCopy,0,_),
  format("~N    ~p.~p ~p",[JustNo,StepNo,CCopy]),
  StepNext is 1+StepNo,
  mpred_pp_db_justifications2(Rest,JustNo,StepNext).

mpred_prompt_ask(Info,Ans):-
  format("~N~p",[Info]),
  read(Ans).

mpred_select_justification_node(Js,Index,Step):-
  JustNo is integer(Index),
  nth1(JustNo,Js,Justification),
  StepNo is 1+ integer(Index*10 - JustNo*10),
  nth1(StepNo,Justification,Step).


%%  mpred_supported(+P) is semidet.
%
%  succeeds if P is "supported". What this means
%  depends on the TMS mode selected.
%
mpred_supported(P):- 
  get_tms_mode(P,Mode),
  mpred_supported(Mode,P).

get_tms_mode(_P,Mode):- lookup_u(tms(Mode)),!.
get_tms_mode(_P,Mode):- must(Mode=local).

%%  mpred_supported(+TMS,+P) is semidet.
%
%  succeeds if P is "supported". What this means
%  depends on the TMS mode supplied.
%
mpred_supported(local,P):- !, mpred_get_support(P,_).
mpred_supported(cycles,P):-  !, well_founded(P).
mpred_supported(_,_):- true.


%% well_founded(+Fact) is semidet.
%
% a fact is well founded if it is supported by the user
%  or by a set of facts and a rules, all of which are well founded.
% 
well_founded(Fact):- each_E(well_founded_0,Fact,[_]).

well_founded_0(F,_):-
  % supported by user (mpred_axiom) or an "absent" fact (mpred_assumption).
  (mpred_axiom(F) ; mpred_assumption(F)),
  !.

well_founded_0(F,Descendants):-
  % first make sure we aren't in a loop.
  (\+ memberchk(F,Descendants)),
  % find a justification.
  supporters_list(F,Supporters),
  % all of whose members are well founded.
  well_founded_list(Supporters,[F|Descendants]),
  !.

%%  well_founded_list(+List,-Decendants) is det.
%
% simply maps well_founded over the list.
%
well_founded_list([],_).
well_founded_list([X|Rest],L):-
  well_founded_0(X,L),
  well_founded_list(Rest,L).

%% supporters_list(+F,-ListofSupporters) is det.
%
% where ListOfSupports is a list of the
% supports for one justification for fact F -- i.e. a list of facts which,
% together allow one to deduce F.  One of the facts will typically be a rule.
% The supports for a user-defined fact are: [u].
%
supporters_list(F,[Fact|MoreFacts]):-
  mpred_get_support(F,(Fact,Trigger)),
  triggerSupports(Trigger,MoreFacts).

triggerSupports(uWas(_),[]):-!.
triggerSupports(U,[(U)]):- get_source_ref1(U),!.
triggerSupports(U,[uWas(U)]):- get_source_ref((U1,U2)),member(U,[U1,U2]).
triggerSupports(Trigger,[Fact|MoreFacts]):-
  mpred_get_support(Trigger,(Fact,AnotherTrigger)),
  triggerSupports(AnotherTrigger,MoreFacts).

:-module_transparent(mpred_ain/1).
:-module_transparent(mpred_aina/1).
:-module_transparent(mpred_ainz/1).
:-module_transparent(logicmoo_util_database:ain/1).
:-module_transparent(logicmoo_util_database:aina/1).
:-module_transparent(logicmoo_util_database:ainz/1).
:-multifile(logicmoo_util_database:ain/1).
:-multifile(logicmoo_util_database:aina/1).
:-multifile(logicmoo_util_database:ainz/1).

:-asserta_new((logicmoo_util_database:ainz(G):- !, call(mpred_pfc:mpred_ainz,G))).
:-asserta_new((logicmoo_util_database:ain(G):- !, call(mpred_pfc:mpred_ain,G))).
:-asserta_new((logicmoo_util_database:aina(G):- !, call(mpred_pfc:mpred_aina,G))).

% :- mpred_set_default(mpred_warnings(_), mpred_warnings(true)).
:- asserta_new(mpred_warnings(true)).


:- module_transparent((mpred_clause_u)/1).
:- module_transparent((mpred_remove1)/2).
:- module_transparent((mpred_te)/2).
:- module_transparent((mpred_te)/0).
:- module_transparent((mpred_current_db)/1).
:- module_transparent((listing_u)/1).
:- module_transparent((mpred_test_fok)/1).
:- module_transparent((mpred_test)/1).
:- module_transparent((set_user_abox)/1).
:- module_transparent((get_user_abox)/1).
:- module_transparent((get_source_ref1)/1).
:- module_transparent((get_source_ref)/1).
:- module_transparent((setup_mpred_ops)/0).
:- module_transparent((mpred_load_term)/1).
:- module_transparent((call_u)/1).
:- module_transparent((mpred_BC)/1).
:- module_transparent((mpred_BC_w_cache)/1).
:- module_transparent((justifications)/2).
:- module_transparent((ain_fast)/2).
:- module_transparent((ain_fast)/1).
:- module_transparent((call_s2)/1).
:- module_transparent((call_s)/1).
:- module_transparent((clauseq_s)/3).
:- module_transparent((clause_s)/3).
:- module_transparent((assertz_s)/1).
:- module_transparent((asserta_s)/1).
:- module_transparent((lookq_s)/2).
:- module_transparent((lookq_s)/1).
:- module_transparent((lookup_s)/2).
:- module_transparent((lookup_s)/1).
:- module_transparent((retract_s)/1).
:- module_transparent((clause_s)/2).
:- module_transparent((retractall_s)/1).
:- module_transparent((assert_s)/1).
:- module_transparent((listing_s)/1).
:- module_transparent((fix_mp)/2).
:- module_transparent((why_was_true)/1).
:- module_transparent((mpred_is_silient)/0).
:- module_transparent((get_mpred_is_tracing)/1).
:- module_transparent((triggerSupports)/2).
:- module_transparent((supporters_list)/2).
:- module_transparent((well_founded_list)/2).
:- module_transparent((well_founded_0)/2).
:- module_transparent((well_founded)/1).
:- module_transparent((mpred_supported)/2).
:- module_transparent((get_tms_mode)/2).
:- module_transparent((mpred_supported)/1).
:- module_transparent((mpred_select_justification_node)/3).
:- module_transparent((mpred_prompt_ask)/2).
:- module_transparent((mpred_pp_db_justifications2)/3).
:- module_transparent((mpred_pp_db_justification1)/2).
:- module_transparent((mpred_pp_db_justifications)/2).
:- module_transparent((mpred_unhandled_command)/3).
:- module_transparent((mpred_handle_why_command)/3).
:- module_transparent((mpred_whyBrouse)/2).
:- module_transparent((mpred_why1)/1).
:- module_transparent((mpred_why)/1).
:- module_transparent((mpred_why)/0).
:- module_transparent((pp_db_supports)/0).
:- module_transparent((pp_db_triggers)/0).
:- module_transparent((pp_db_rules)/0).
:- module_transparent((mpred_classifyFacts)/4).
:- module_transparent((pp_db_items)/1).
:- module_transparent((pp_db_facts)/2).
:- module_transparent((pp_db_facts)/1).
:- module_transparent((pp_db_facts)/0).
:- module_transparent((pp_DB)/0).
:- module_transparent((mpred_trigger_key)/2).
:- module_transparent((mpred_make_supports)/1).
:- module_transparent((mpred_support_relation)/1).
:- module_transparent((mpred_collect_supports)/1).
:- module_transparent((mpred_rem_support)/2).
:- module_transparent((mpred_rem_support_if_exists)/2).
:- module_transparent((mpred_add_support)/2).
:- module_transparent((mpred_descendants)/2).
:- module_transparent((mpred_descendant1)/3).
:- module_transparent((mpred_descendant)/2).
:- module_transparent((mpred_children)/2).
:- module_transparent((mpred_child)/2).
:- module_transparent((do_assumpts)/2).
:- module_transparent((mpred_assumptions)/2).
:- module_transparent((mpred_assumption)/1).
:- module_transparent((mpred_axiom)/1).
:- module_transparent((bases_union)/2).
:- module_transparent((mpred_basis_list)/2).
:- module_transparent((justification)/2).
:- module_transparent((mpred_set_warnings)/1).
:- module_transparent((nompred_warn)/0).
:- module_transparent((mpred_warn)/0).
:- module_transparent((mpred_load)/1).
:- module_transparent((mpred_nowatch)/0).
:- module_transparent((mpred_trace_exec)/0).
:- module_transparent((mpred_watch)/0).
:- module_transparent((mpred_error)/2).
:- module_transparent((mpred_error)/1).
:- module_transparent((mpred_warn)/2).
:- module_transparent((mpred_warn)/1).
:- module_transparent((mpred_trace_msg)/2).
:- module_transparent((mpred_trace_msg)/1).
:- module_transparent((mpred_untrace)/1).
:- module_transparent((mpred_untrace)/0).
:- module_transparent((mpred_notrace)/0).
:- module_transparent((mpred_nospy)/3).
:- module_transparent((mpred_nospy)/1).
:- module_transparent((mpred_nospy)/0).
:- module_transparent((mpred_spy1)/3).
:- module_transparent((mpred_spy)/3).
:- module_transparent((mpred_spy)/2).
:- module_transparent((mpred_spy)/1).
:- module_transparent((mpred_trace)/2).
:- module_transparent((mpred_trace)/1).
:- module_transparent((mpred_trace)/0).
:- module_transparent((mpred_trace_maybe_break)/3).
:- module_transparent((mpred_trace_maybe_print)/3).
:- module_transparent((mpred_trace_op)/3).
:- module_transparent((mpred_trace_op)/2).
:- module_transparent((mpred_facts)/3).
:- module_transparent((mpred_facts)/2).
:- module_transparent((mpred_facts)/1).
:- module_transparent((mpred_fact)/1).
:- module_transparent((mpred_retract_i_or_warn)/1).
:- module_transparent((mpred_database_item)/1).
:- module_transparent((mpred_reset)/0).
:- module_transparent((mpred_database_term)/2).
:- module_transparent(lmcache:(mpred_abox_module)/1).
:- module_transparent((mpred_conjoin)/3).
:- module_transparent((mpred_union)/3).
:- module_transparent((mpred_assertz_w_support)/2).
:- module_transparent((mpred_asserta_w_support)/2).
:- module_transparent((mpred_assert_w_support)/2).
:- module_transparent((mpred_db_type)/2).
:- module_transparent((build_consequent)/3).
:- module_transparent((all_closed)/1).
:- module_transparent((code_sentence_op)/1).
:- module_transparent((build_code_test)/3).
:- module_transparent((fa_to_p)/3).
:- module_transparent((really_mpred_mark)/5).
:- module_transparent((mpred_mark_fa_as)/6).
:- module_transparent((mpred_mark_as)/4).
:- module_transparent((pos_2_neg)/2).
:- module_transparent((mpred_mark_as_ml)/4).
:- module_transparent((check_never_retract)/1).
:- module_transparent((check_never_assert)/1).
:- module_transparent((build_neg_test)/4).
:- module_transparent((build_trigger)/4).
:- module_transparent((build_rule)/3).
:- module_transparent((process_rule)/3).
:- module_transparent((mpred_connective)/1).
:- module_transparent((mpred_positive_literal)/1).
:- module_transparent((mpred_literal)/1).
:- module_transparent((mpred_negated_literal)/1).
:- module_transparent((mpred_negation)/2).
:- module_transparent((mpred_compile_rhs_term)/2).
:- module_transparent((mpred_compile_rhs_term)/3).
:- module_transparent((build_rhs)/2).
:- module_transparent((mpred_nf_negation)/2).
:- module_transparent((mpred_nf_negations)/2).
:- module_transparent((mpred_nf1_negation)/2).
:- module_transparent((mpred_nf1)/2).
:- module_transparent((mpred_nf)/2).
:- module_transparent((action_is_undoable)/1).
:- module_transparent((call_in_mi)/1).
:- module_transparent((trigger_trigger1)/2).
:- module_transparent((trigger_trigger)/3).
:- module_transparent((mpred_eval_rhs1)/2).
:- module_transparent((mpred_eval_rhs)/2).
:- module_transparent((mpred_eval_lhs)/2).
:- module_transparent((mpred_define_bc_rule)/3).
:- module_transparent((mpred_do_fcnt)/2).
:- module_transparent((mpred_do_fcpt)/2).
:- module_transparent((mpred_do_rule)/1).
:- module_transparent((mpred_fwc1)/1).
:- module_transparent((mpred_fwc)/1).
:- module_transparent((remove_if_unsupported)/1).
:- module_transparent((mpred_retract_supported_relations)/1).
:- module_transparent((mpred_unfwc_check_triggers)/1).
:- module_transparent((mpred_unfwc1)/1).
:- module_transparent((mpred_unfwc)/1).
:- module_transparent((mpred_undo)/1).
:- module_transparent((mpred_remove_supports_quietly)/1).
:- module_transparent((mpred_remove_supports)/1).
:- module_transparent((mpred_blast)/1).
:- module_transparent((mpred_remove)/2).
:- module_transparent((mpred_remove)/1).
:- module_transparent((mpred_withdraw1)/2).
:- module_transparent((mpred_withdraw)/2).
:- module_transparent((mpred_withdraw)/1).
:- module_transparent((mpred_ain_by_type)/2).
:- module_transparent((mpred_ain_object)/1).
:- module_transparent((mpred_retract_type)/2).
:- module_transparent((mpred_retract)/1).
:- module_transparent((mpred_undo_action)/1).
:- module_transparent((mpred_ain_actiontrace)/2).
:- module_transparent((mpred_bt_pt_combine)/3).
:- module_transparent((mpred_ain_trigger_reprop)/2).
:- module_transparent((stop_trace)/1).
:- module_transparent((mpred_halt)/1).
:- module_transparent((mpred_halt)/2).
:- module_transparent((mpred_halt)/0).
:- module_transparent((defaultmpred_select)/1).
:- module_transparent((select_next_fact)/1).
:- module_transparent((remove_selection)/1).
:- module_transparent((get_next_fact)/1).
:- module_transparent((mpred_step)/0).
:- module_transparent((mpred_run)/0).
:- module_transparent((mpred_remove_old_version)/1).
:- module_transparent((mpred_enqueue)/2).
:- module_transparent((get_search_mode)/3).
:- module_transparent((mpred_unique_u)/1).
:- module_transparent((mpred_ain_db_to_head)/2).
:- module_transparent((mpred_post1)/2).
:- module_transparent((mpred_post)/2).
:- module_transparent((mpred_ain)/2).
:- module_transparent((ain)/2).
:- module_transparent((mpred_aina)/2).
:- module_transparent((mpred_ainz)/2).
:- module_transparent((mpred_set_default)/2).
:- module_transparent((pp_qu)/0).
:- module_transparent((lookup_u)/2).
:- module_transparent((lookup_u)/1).
:- module_transparent((clause_u)/2).
:- module_transparent((retractall_u)/1).
:- module_transparent((retract_u)/1).
:- module_transparent((assertz_u)/1).
:- module_transparent((asserta_u)/1).
:- module_transparent((assert_u)/1).
:- module_transparent((call_uU)/1).
:- module_transparent((clause_u)/3).
:- module_transparent((mpred_BC_CACHE)/1).
:- module_transparent((mpred_CALL)/1).
:- module_transparent((mpred_get_support)/2).



:- source_location(S,_),prolog_load_context(module,M),
 forall(source_file(M:H,S),ignore((functor(H,F,A),
   \+ mpred_database_term(F/A,_),
   F\=='$mode',
   F\=='$pldoc',
   ignore(((\+ atom_concat('$',_,F),\+ mpred_database_term(F/A,_),export(F/A)))),
   \+ predicate_property(M:H,transparent),
   format('~N:- module_transparent((~q)/~q).~n',[F,A]),
   M:module_transparent(M:F/A)))).


:- forall(mpred_database_term(F/A,_),abolish(mpred_pfc:F/A)).


%% mpred_pfc_file is det.
%
% PFC Forward Chaining File.
%
mpred_pfc_file. 



% local_testing
end_of_file.

:- must(mpred_reset).

:- get_user_abox(M),dynamic((M:current_ooZz/1,M:default_ooZz/1,M:if_mooZz/2)).

:- mpred_trace.
:- mpred_watch.


% this should have been ok
% (if_mooZz(Missing,Create) ==> ((\+ Missing/(Missing\==Create), \+ Create , \+ ~(Create)) ==> Create)).
:- ((mpred_ain((if_mooZz(Missing,Create) ==> 
 ( ( \+ Missing/(Missing\=@=Create)) ==> Create))))).

:- mpred_ain((default_ooZz(X) ==> if_mooZz(current_ooZz(_),current_ooZz(X)))).

:- mpred_ain(default_ooZz(booZz)).

:- mpred_test(current_ooZz(booZz)).

% :- pp_DB.

:- (mpred_ain(current_ooZz(fooZz))).

:- mpred_test(\+current_ooZz(booZz)).

:- (mpred_ain(\+ current_ooZz(fooZz))).

:- mpred_test(current_ooZz(booZz)).

:- (mpred_withdraw( default_ooZz(booZz) )).

:- listing([current_ooZz,default_ooZz]).

:- mpred_test( \+current_ooZz(booZz)).

:- mpred_ain(~ current_ooZz(fooZz)).

% :- pp_DB.

:- mpred_test(~current_ooZz(fooZz)).

:- mpred_ain(default_ooZz(booZz)).

:- mpred_test(current_ooZz(booZz)).

:- mpred_reset.

