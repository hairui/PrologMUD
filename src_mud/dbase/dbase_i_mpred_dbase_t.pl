/** <module> dbase_i_mpred_dbase_t
% Provides a prolog dabase in these predicates...
%
%  dbase_t/N
%  hybridRule/2
%  
%
% Logicmoo Project PrologMUD: A MUD server written in Prolog
% Maintainer: Douglas Miles
% Dec 13, 2035
%
*/

:- include(logicmoo('vworld/moo_header.pl')).

% ========================================
% is_holds_true/is_holds_false
% ========================================

:- dbase_mod(M),dynamic_multifile_exported((
          % M:dbase_t/1,
          % M:dbase_t/2,
          M:dbase_t/3,
          M:dbase_t/4,
          M:dbase_t/5,
          M:dbase_t/6,
          M:dbase_t/7,
          M:dbase_t/8,
          M:dbase_t/9,
          M:dbase_t/10,
          M:dbase_t/11)).

:- dbase_mod(M),dynamic_multifile_exported((
          % M:holds_t/1,
          M:holds_t/2,
          M:holds_t/3,
          M:holds_t/4,
          M:holds_t/5,
          M:holds_t/6,
          M:holds_t/7,
          M:holds_t/8,
          M:holds_t/9,
          M:holds_t/10,
          M:holds_t/11)).


:-swi_export((dbase_t/1,hasInstance/2)).
:- dynamic_multifile_exported((
         % dbase_t/1,
         % dbase_t/2,
          dbase_t/3,
          dbase_t/4,
          dbase_t/5,
          dbase_t/6,
          dbase_t/7,
          asserted_dbase_t/1,
          asserted_dbase_t/2,
          asserted_dbase_t/3,
          asserted_dbase_t/4,
          asserted_dbase_t/5,
          asserted_dbase_t/6,
          asserted_dbase_t/7,
          assertion_f/1,
          assertion_t/1,
          asserted_dbase_f/1,
          asserted_dbase_f/2,
          asserted_dbase_f/3,
          asserted_dbase_f/4,
          asserted_dbase_f/5,
          asserted_dbase_f/6,
          asserted_dbase_f/7,
          dbase_f/1,
          dbase_f/2,
          dbase_f/3,
          dbase_f/4,
          dbase_f/5,
          dbase_f/6,
          dbase_f/7)).




% ================================================================================
% begin holds_t
% ================================================================================


dbase_t(C,I):- trace_or_throw(dbase_t(C,I)),hasInstance(C,I). % ,fail,loop_check_term(isa_backchaing(I,C),hasInstance(C,I),fail).

%dbase_t([P|LIST]):- !,dbase_plist_t(P,LIST).
%dbase_t(naf(CALL)):-!,not(dbase_t(CALL)).
%dbase_t(not(CALL)):-!,dbase_f(CALL).
dbase_t(CALL):- into_plist_arities(3,10,CALL,[P|LIST]),dbase_plist_t(P,LIST).
dbase_plist_t(P,[]):-!,dbase_t(P).
dbase_plist_t(P,LIST):-var(P),!,is_list(LIST),CALL=..[dbase_t,P|LIST],debugOnError((CALL)).
dbase_plist_t(dbase_t,[P|LIST]):-!, dbase_plist_t(P,LIST).
dbase_plist_t(mpred_prop,[C,I]):-!,ground(I:C),mpred_prop(C,I).
dbase_plist_t(mudIsa,[I,C]):-!,hasInstance(C,I).
dbase_plist_t(P,_):-never_dbase_mpred(P),!,fail.
dbase_plist_t(P,[L|IST]):-is_holds_true(P),!,dbase_plist_t(L,IST).
dbase_plist_t(P,LIST):-is_holds_false(P),!,dbase_f(LIST).
dbase_plist_t(P,LIST):- CALL=..[dbase_t,P|LIST],call(CALL),debugOnError((CALL)).

loop_check_mpred(Call):- !, fail,not(thlocal:infInstanceOnly(_)),loop_check_local(ireq(Call),fail).
% loop_check_mpred(Call):-loop_check_local(call_mpred(dbase_t,Call),fail).

dbase_t(P,A1,A2,A3,A4,A5,A6,A7):- loop_check_mpred(dbase_t(P,A1,A2,A3,A4,A5,A6,A7)).
dbase_t(P,A1,A2,A3,A4,A5,A6):- loop_check_mpred(dbase_t(P,A1,A2,A3,A4,A5,A6)).
dbase_t(P,A1,A2,A3,A4,A5):- loop_check_mpred(dbase_t(P,A1,A2,A3,A4,A5)).
dbase_t(P,A1,A2,A3,A4):- loop_check_mpred(dbase_t(P,A1,A2,A3,A4)).
dbase_t(P,A1,A2,A3):- loop_check_mpred(dbase_t(P,A1,A2,A3)).
dbase_t(P,A1,A2):- loop_check_mpred(dbase_t(P,A1,A2)).

isCycPredArity_ignoreable(F,A):- ignore(mpred_prop(F,cycPred(A))),ignore(mpred_arity(F,A)).

which_t(dac(d,a_notnow,c,no_fallback)).

holds_t(P,A1,A2,A3,A4,A5,A6,A7):- isCycPredArity_ignoreable(P,7),which_t(DBS),(call_which_t(DBS,P,A1,A2,A3,A4,A5,A6,A7);call_mt_t(DBS,P,A1,A2,A3,A4,A5,A6,A7,_,_);assertion_t([P,A1,A2,A3,A4,A5,A6,A7])).
holds_t(P,A1,A2,A3,A4,A5,A6):- isCycPredArity_ignoreable(P,6),which_t(DBS),(call_which_t(DBS,P,A1,A2,A3,A4,A5,A6);call_mt_t(DBS,P,A1,A2,A3,A4,A5,A6,_,_)).
holds_t(P,A1,A2,A3,A4,A5):- isCycPredArity_ignoreable(P,5),which_t(DBS),(call_which_t(DBS,P,A1,A2,A3,A4,A5);call_mt_t(DBS,P,A1,A2,A3,A4,A5,_,_)).
holds_t(P,A1,A2,A3,A4):- isCycPredArity_ignoreable(P,4),which_t(DBS),(call_which_t(DBS,P,A1,A2,A3,A4);call_mt_t(DBS,P,A1,A2,A3,A4,_,_)).
holds_t(P,A1,A2,A3):- isCycPredArity_ignoreable(P,3),which_t(DBS),(call_which_t(DBS,P,A1,A2,A3);call_mt_t(DBS,P,A1,A2,A3,_,_)).
%holds_t(P,A1,A2):- hotrace(holds_relaxed_t(P,A1,A2)).
holds_t(P,A1,A2):- isCycPredArity_ignoreable(P,2),which_t(DBS),(call_which_t(DBS,P,A1,A2);call_mt_t(DBS,P,A1,A2,_,_)).
holds_t(P,A1):- isCycPredArity_ignoreable(P,1),which_t(DBS),(call_which_t(DBS,P,A1);call_mt_t(DBS,P,A1,_,_)).


% holds_relaxed_t(P,A1,A2):-var(A1),var(A2),!,dbase_t(P,A1,A2).
holds_relaxed_t(P,A1,A2):-
  isCycPredArity_ignoreable(P,2),which_t(DBS),
      relax_term(P,PR,A1,R1,A2,R2),
         holds_relaxed_0_t(DBS,PR,R1,R2).

holds_relaxed_0_t(DBS,P,A1,A2):- call_which_t(DBS,P,A1,A2).
holds_relaxed_0_t(DBS,P,A1,A2):- call_mt_t(DBS,P,A1,A2,_,_).

/*
holds_relaxed_0_t(dac(_,a,_,_),P,A1,A2):- assertion_t([P,A1,A2]).
holds_relaxed_0_t(dac(d,_,_,_),P,A1,A2):- dbase_t(P,A1,A2).
holds_relaxed_0_t(dac(_,_,_,h),P,A1,A2):- call_which_t(DBS,P,A1,A2).
holds_relaxed_0_t(DBS,P,A1,A2):- call_mt_t(DBS,P,A1,A2,_,_).
holds_relaxed_0_t(_DBS,P,A1,A2):- ground((P,A1)), TEMPL=..[P,T1,_],dbase_t(argSingleValueDefault,TEMPL,2,A2),req(isa(A1,T1)),!.
*/

holds_t([AH,P|LIST]):- is_holds_true(AH),!,holds_plist_t(P,LIST).
holds_t([AH,P|LIST]):- is_holds_false(AH),!,holds_f_p2(P,LIST).
holds_t([P|LIST]):- !,holds_plist_t(P,LIST).
holds_t(not(CALL)):- !, holds_f(CALL).
holds_t(CALL):- '=..'(CALL,PLIST),holds_t(PLIST).

holds_plist_t(P,LIST):- apply(holds_t,[P|LIST]).



:-op(0,fx,((decl_mpred_hybrid))).
:-swi_export((decl_mpred_hybrid)/1).
:-swi_export((decl_mpred_hybrid)/2).
:-swi_export((decl_mpred_hybrid)/3).
:-swi_export((decl_mpred_hybrid)/4).

:-op(0,fx,decl_mpred_hybrid).

:-meta_predicate_transparent(decl_mpred_hybrid(+)).
:-meta_predicate_transparent(decl_mpred_hybrid(+,+)).
:-meta_predicate_transparent(decl_mpred_hybrid(+,+,+)).


decl_mpred_hybrid(M):- with_pi(M,decl_mpred_hybrid).
decl_mpred_hybrid(F,A):-
     decl_mpred(F,A),
     decl_mpred_pi(F),
     functor_h(F,FF,_),
     must_det((mpred_arity(FF,AR),decl_mpred_mfa(_,F,AR),
     decl_mpred_stubcol(F,A,prologHybrid))).

decl_mpred_hybrid(M,PI,F/A):-
     decl_mpred(F,A),  
     decl_mpred_pi(PI),       
     decl_mpred_mfa(M,F,A),
     decl_mpred_stubcol(F,A,prologHybrid).

decl_mpred_hybrid(_CM,M,PI,F/A):-
   decl_mpred_hybrid(M,PI,F/A).

:-op(1150,fx,decl_mpred_hybrid).



ensure_universal_stub_plus_minus_2_HIDE(F,AMinus2):-
   decl_mpred(F,predArity(AMinus2)),
   decl_mpred_hybrid(F/AMinus2).
   
ensure_universal_stub_plus_2(F,A2):- once(( AMinus2 is A2 -2, ensure_universal_stub_plus_minus_2(F,AMinus2))),fail.

%ensure_universal_stub_plus_2(F,A2):- cannot_override(F,A2,Why),!,dmsg(cannot_override_plus_2(F,A2,Why)).

ensure_universal_stub_plus_2(F,A2):- 
   swi_export(F/A2),
   functor(HEAD,F,A2),
   HEAD=..[F|ARGS],
   append(ARGSMinus2,[_,_],ARGS),
   HEADMinus2=..[F|ARGSMinus2],
   % AMinus2 is A2 -2,
   assert_if_new(HEAD:-HEADMinus2),!,
  % compile_predicates([HEAD]),
   dbase_mod(M),
   decl_mpred_hybrid(M,F,A2).




/*
hybrid_rule_term_expansion(file,':-'(_),_):-!,fail.
hybrid_rule_term_expansion(file,HEAD,_):-not(compound(HEAD)),!,fail.
hybrid_rule_term_expansion(file,(HEAD:-true),':-'(add(HEAD))):-get_functor(HEAD,F),mpred_prop(F,prologHybrid),add(HEAD),!.
hybrid_rule_term_expansion(file,(HEAD:-NEWBODY),ruleHybridChain(HEAD,NEWBODY)):-functor_h(HEAD,F),mpred_prop(F,prologHybrid),!.

hybrid_rule_term_expansion((I:-_),_):-!,once((compound(I),functor(I,F,A),asserta_if_new(mpred_prolog_arity(F,A)))),!,fail.
hybrid_rule_term_expansion(I,_):- once((compound(I),functor(I,F,A),asserta_if_new(mpred_prolog_arity(F,A)))),!,fail.

user:term_expansion(I,O):-not(thlocal:into_form_code),get_functor(I,F),mpred_prop(F,prologHybrid),hybrid_rule_term_expansion(file,I,O).
 */  
:- op(1150,fx,decl_mpred_hybrid).


add_hybrid_rules(M:HEAD,BDY):-atom(M),!,add_hybrid_rules(HEAD,BDY).
add_hybrid_rules(HEAD,true):-!,hooked_assertz(HEAD).
add_hybrid_rules(HEAD,BDY):- show_call(hooked_assertz(ruleHybridChain(HEAD,BDY))).


provide_mpred_storage_clauses(forwardRule,H,B):-forwardRule(H,B).
provide_mpred_storage_clauses(ruleHybridChain,H,B):-ruleHybridChain(H,B).
provide_mpred_storage_clauses(ruleEquiv,H,B):-ruleEquiv(HH,B),each_subterm(HH,SubTerm),compound(SubTerm),SubTerm = H.
provide_mpred_storage_clauses(ruleEquiv,H,B):-ruleEquiv(B,HH),each_subterm(HH,SubTerm),compound(SubTerm),SubTerm = H.



% -- CODEBLOCK
is_tCol(V):-is_ftVar(V),!,fail.
is_tCol(tCol).
is_tCol(F):- mpred_prop(F,tCol);hasInstance(tCol,F);hasInstance(F,_).
is_proc(V):-is_ftVar(V),!,fail.
is_proc(F):- functor(P,F,1),predicate_property(P,_),must(not(mpred_prop(F,tCol))).



% ISA HOOK
provide_mpred_currently(_OP, X, prologHybrid, declared(_)):-was_isa(X,_,_),!.
provide_mpred_storage_op(assert(_),X,prologHybrid, CALL):- was_isa(X,I,C),!,dmsg(isa_assert(X,I,C)),!, CALL=isa_assert(I,C).
provide_mpred_storage_op(call,X,prologHybrid, CALL):- was_isa(X,I,C),!, CALL=no_loop_check_unsafe(isa_backchaing(I,C)).

% RULE HOOK   
provide_mpred_storage_op(OP,(Head:-Body),prologHybrid,CALL):-
 transitive(how_to_op,OP,OP2),
  special_wrapper_body(Body),!,
  CALL = user:(call(OP2,(Head:-Body))),
  wdmsg(special_wrapper_body(OP2,Head,Body)).

% RULE HOOK   
provide_mpred_storage_op(OP,(Head:-Body),prologHybrid,CALL):-
 transitive(how_to_op,OP,OP2),
  CALL = user:(call(OP2,ruleHybridChain(Head,Body))),
  wdmsg(saved_clause_in_hybridRule(OP2,Head,Body)).

% REOP HOOK
provide_mpred_storage_op(OP1,HeadBody,prologHybrid,CALL):- 
  transitive(how_to_op,OP1,OP2), OP1\==OP2, provide_mpred_storage_op(OP2,HeadBody,prologHybrid,CALL).

% FACT CALL HOOK
provide_mpred_storage_op(call,FACT,prologHybrid,CALL):-!,
 into_assertable_form(dbase_t,FACT,DB),   
     CALL= call_fact_db(FACT,DB),!.

% FACT DB HOOK
provide_mpred_storage_op(OP,HeadBody,prologHybrid,CALL):-
 transitive(how_to_op,OP,OP2),
    into_assertable_form(dbase_t,HeadBody,DB),   
     CALL=loop_check(call(OP2,DB),fail),!.

call_fact_db( HEAD,DB):-no_repeats(HEAD,loop_check(call(call,DB),loop_check(call_rule_db(HEAD,DB),call(call,DB)))).
call_fact_db( HEAD,DB):-loop_check(call_rule_db(HEAD,DB)).
call_fact_db(_FACT,dbase_t(P1,A,B)):-dbase_t(genlPreds,P2,P1),call(P2,A,B).
call_rule_db( HEAD,_DB):- ruleHybridChain(HEAD,BODY),call_mpred_body(HEAD,BODY).

% THROW HOOK
provide_mpred_storage_op(OP1,HeadBody,prologHybrid,CALL):- trace_or_throw(provide_mpred_storage_op(OP1,HeadBody,prologHybrid,CALL)).

% SETUP HOOK
provide_mpred_setup(OP,Head,StubType,OUT):-  StubType = prologHybrid, 
  must_det_l(( get_pifunctor(Head,PHead,F,A),  
   show_call(provide_clauses_list(PHead,HBLIST)),
   user:abolish(F,A),dynamic_multifile_exported(user:F/A),
   asserta_if_new(mpred_prop(F,hasStub(StubType))),         
   asserta_if_new(mpred_prop(F,StubType)), 
   forall(member(HB,HBLIST),must(add(HB))),!,   
   asserta_if_new(user:(PHead:-use_provided_mpred_storage_op(call(conjecture),PHead,StubType))),
   must_same_clauses(PHead,HBLIST))),
   must(OUT=defined(provide_mpred_setup(OP,StubType))).


% =====================================
% = body_req
% =====================================
:-swi_export(last_arg_ground/1).
last_arg_ground(HEAD):-compound(HEAD),functor(HEAD,F,A),last_arg_ground(F, A, HEAD),!.
last_arg_ground(mud_test,_,_).
last_arg_ground(_,A,_):-A>2,!.
last_arg_ground(_,A,HEAD):-arg(A,HEAD,Arg),!,ground(Arg).

% call_body_req(HEAD):- functor(HEAD,F,A),HEAD_T=..[F|ARGS],HEAD_T=..[dbase_t,F|ARGS],hook_body_req(HEAD,HEAD_T).

provide_mpred_storage_clauses(dbase_t,H,true):-is_list(H),!,length(H,A),A>2,dbase_t(H).
provide_mpred_storage_clauses(dbase_t,H,true):-compound(H),!,functor(H,_,A),A>1,dbase_t(H).

% ========================================================================================
% BODY StubType
% ========================================================================================

body_req_isa(I,C):-isa_backchaing(I,C).

body_call_cyckb(HEAD_T):-el_holds_DISABLED_KB, HEAD_T =.. [dbase_t|PLIST], thglobal:use_cyc_database,!, no_repeats(kbp_t(PLIST)).

body_req(HEAD,HEAD_T):- (hook_body_req(HEAD,HEAD_T)).

:-swi_export(body_req_normal/4).
%hook_body_req(HEAD,HEAD_T):- mpred_prop(F,prologPTTP),!,dmsg(warn(hook_body_req(HEAD,HEAD_T))),fail.
%hook_body_req(HEAD,HEAD_T):- mpred_prop(F,prologOnly),!,dmsg(warn(hook_body_req(HEAD,HEAD_T))),fail.
hook_body_req(_,_,mudIsa(I,C),_):- !, body_req_isa(I,C).
hook_body_req(_,_,_,dbase_t(C,I)):- !, body_req_isa(I,C).
hook_body_req(_,_,_,hasInstance(C,I)):- !, body_req_isa(I,C).
hook_body_req(_,_,_ ,HEAD_T):- thlocal:useOnlyExternalDBs,!, body_call_cyckb(HEAD_T).
% loop checking is not usefull (why the cut was added)
hook_body_req(HEAD,HEAD_T):-  no_repeats(body_req_normal(HEAD,HEAD_T)).


:-swi_export(body_req_normal/4).
body_req_normal(HEAD,HEAD_T):- not(ground(HEAD)),!,no_repeats(HEAD_T,body_req_1(HEAD,HEAD_T)).
body_req_normal(HEAD,HEAD_T):- body_req_1(HEAD,HEAD_T),!. 

:-swi_export(body_req_1/4).
body_req_1(HEAD,HEAD_T):- mpred_prop(F,call_tabled),!, call_tabled(body_req_2(HEAD,HEAD_T)).
body_req_1(HEAD,HEAD_T):- body_req_2(HEAD,HEAD_T).

body_req_2(HEAD,  _):-    mpred_prop(F,external(Module)),!,call(Module:HEAD).
body_req_2(HEAD,HEAD_T):- body_req_with_rules(HEAD,HEAD_T).

body_req_with_rules(HEAD,HEAD_T):-body_req_no_rules(HEAD,HEAD_T).
body_req_with_rules(HEAD,HEAD_T):-body_req_only_rules(HEAD,HEAD_T).

body_req_no_rules(HEAD, _):-     clause(HEAD,  true).
body_req_no_rules(_,_,_  , HEAD_T):- clause(HEAD_T,true).
body_req_no_rules(F,_,_,HEAD_T):- body_req_plus_cyc(F,_,_,HEAD_T).

body_req_only_rules(HEAD, _):-  ruleHybridChain(HEAD,BODY),call_mpred_body(HEAD,BODY).
body_req_only_rules(_,_,_,dbase_t(F,Obj,LValue)):-  choose_val(F,Obj,LValue).

body_req_plus_cyc(F,_,_,HEAD_T):-  mpred_prop(F,cycPlus2(_)),thlocal:useOnlyExternalDBs,!,with_assertions(thglobal:use_cyc_database,body_call_cyckb(HEAD_T)).

call_mpred_body(_,true):-!.
call_mpred_body(HEAD,and(A,B)):- !,call_mpred_body(HEAD,A),!,call_mpred_body(HEAD,B).
call_mpred_body(HEAD,BODY):- no_repeats(loop_check(call_mpred_body_lc(HEAD,BODY))).

call_mpred_body_lc(_HEAD,BODY):- debugOnError(BODY).
 
foo_b(b1).
foo_b(b2):-!.
foo_b(b3):-!.

:-must_det((findall(R,call_no_cuts(foo_b(R)),List),length(List,3))).


decl_database_hook(AR,C):-smart_decl_database(AR,C).

smart_decl_database(AR,svo(S,V,O)):- !,dbase2pred2svo(DBASE,PRED,svo(S,V,O)),!,smart_db_op(AR,DBASE,PRED,svo(S,V,O)).
smart_decl_database(AR,DBASE):- functor_catch(DBASE,dbase_t,_),!,dbase2pred2svo(DBASE,PRED,SVO),!,smart_db_op(AR,DBASE,PRED,SVO).
smart_decl_database(AR,PRED):- dbase2pred2svo(DBASE,PRED,SVO),!,smart_db_op(AR,DBASE,PRED,SVO).

smart_db_op(retract(AR),A,B,C):- retract_ar_fact(AR,A), retract_ar_fact(AR,B),  retract_ar_fact(AR,C).

retract_ar_fact(all,What):- predicate_property(What,dynamic), !, doall((retract_ar_fact(one,What),fail)).
retract_ar_fact(all,What):- not(predicate_property(What,_)),!.
retract_ar_fact(all,What):- copy_term(What,WO),ignore(once(WO)),must_det(What=@=WO).

retract_ar_fact(one,What):- predicate_property(What,dynamic),!, clause(What,true),retract(What:-true).
retract_ar_fact(one,What):- predicate_property(What,_),!, clause_safe(What,true),!.
retract_ar_fact(one,What):- dmsg(mssing(retract_ar_fact(one,What))).


make_functorskel(_,_):-!. % currently ununused
make_functorskel(F,_):- fskel(F,_,_,_,_,_,_),!.
make_functorskel(F,N):- mpred_arity(F,N),make_functorskel(F,N,SKEL),asserta(SKEL),!.
make_functorskel(F,N):- ignore(mpred_arity(F,A)),dmsg(todo(trace_or_throw(illegal_make_functorskel(F,N,A)))).

dbase2pred2svo(DBASE,PRED,svo(A,F,RGS)):-fskel(F,DBASE,PRED,A,RGS,_,_),!.
dbase2pred2svo(DBASE,PRED,svo(A,F,RGS)):-compound(PRED),functor(PRED,F,N),make_functorskel(F,N),!,fskel(F,DBASE,PRED,A,RGS,_,_),!.
dbase2pred2svo(DBASE,PRED,svo(A,F,RGS)):-compound(DBASE),!,arg(1,DBASE,F),must_det(mpred_arity(F,N)),make_functorskel(F,N),!,fskel(F,DBASE,PRED,A,RGS,_,_),!.
dbase2pred2svo(DBASE,PRED,svo(A,F,RGS)):-nonvar(F),must(mpred_arity(F,N)),make_functorskel(F,N),!,fskel(F,DBASE,PRED,A,RGS,_,_),!.


