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

:- include(dbase_i_header).

user:provide_mpred_write_attributes(F,A,multifile):- multifile(F/A).
user:provide_mpred_write_attributes(F,A,thread_local):- thread_local(F/A).
user:provide_mpred_write_attributes(F,A,dynamic):- dynamic(F/A).
user:provide_mpred_write_attributes(F,external(Module)):- dmsg(decl_mpred(F,external(Module))),not(dbase_mod(Module)),must_det(mpred_arity(F,A)),functor(HEAD,F,A),must_det(predicate_property(Module:HEAD,_)),!.

user:provide_mpred_read_attributes(Obj,PropVal):- fail, safe_univ(PropVal,[Prop,NonVar|Val]),safe_univ(CallVal,[Prop,Obj,NonVar|Val]),
     predicate_property(CallVal,_),!,mpred_call(CallVal).


user:provide_mpred_read_attributes(F,_,_):-mpred_prop(F,prologHybrid),!,fail.
user:provide_mpred_read_attributes(F,A,prologOnly(F,A)):-mpred_prop(F,prologOnly).
user:provide_mpred_read_attributes(F,A,Why):-functor_safe(P,F,A),user:provide_mpred_read_attributes(P,F,A,Why).

user:provide_mpred_read_attributes(P,F,A,static_predicate(P)):-static_predicate(user,F,A).
user:provide_mpred_read_attributes(P,_,_,predicate_property(P,foreign)):-predicate_property(P,foreign),!.
user:provide_mpred_read_attributes(P,_,_,predicate_property(P,built_in)):-real_builtin_predicate(P),!.
user:provide_mpred_read_attributes(P,_,_,predicate_property(P,imported_from(system))):-predicate_property(P,imported_from(system)).


:-export(prolog_side_effects/1).
prolog_side_effects(G):-var(G),!,fail.
prolog_side_effects(F/A):- ((integer(A);current_predicate(F/A)),functor(G,F,A)), prolog_side_effects(G).
prolog_side_effects(G):-get_functor(G,F),mpred_prop(F,sideEffect),!.
prolog_side_effects(G):-predicate_property(G,number_of_rules(N)),N >0,clause(G,(B,_)),compound(B),!.
prolog_side_effects(G):-predicate_property(G,exported),!.
prolog_side_effects(G):-functor_h(G,F),mpred_prop(F,prologOnly),!.
prolog_side_effects(G):-mpred_prop(G,predStub(prologOnly)),!.
prolog_side_effects(P):-atom(P),!,prolog_side_effects(P/_).


user:provide_mpred_storage_clauses(prolog(Mod),G,B,ftProofFn(aClauseRefFn(Ref))):-predicate_property(G,number_of_clauses(_)),clause(G,B,Ref),clause_property(Ref,predicate(Mod:_)).

cant_redefine(PI):-real_builtin_predicate(PI);predicate_property(PI,imported_from(lists)).

user:provide_mpred_setup(Op,HeadIn,StubType,OUT):-  StubType = prologOnly,
   get_pifunctor(HeadIn,Head,F),
 predicate_property(Head,_),
 not(mpred_prop(F,prologHybrid)),
 must(OUT=defined(user:provide_mpred_setup(Op,Head,StubType))),!.

user:provide_mpred_setup(Op,HeadIn,prologOnly,OUT):- get_functor(HeadIn,F),mpred_prop(F,prologHybrid),retractall(mpred_prop(F,prologOnly)),
   MSG = trace_or_throw(prologOnly_was_hybrid(HeadIn,Op)),
   wdmsg(MSG),must(OUT=MSG),!.
   
user:provide_mpred_setup(Op,HeadIn,StubType,OUT):-  StubType = prologOnly, get_pifunctor(HeadIn,Head,F,A),  
  show_call_failure(not(cant_redefine(Head))),
  must((Op= call(_))),
  must_det_l((      
   (provide_clauses_list(Head,HBLIST)),
   erase_mpred_storage_op(Head),
   (mpred_prop(F,prologHybrid) -> show_call((predicate_property(Head,thread_local)->retract_all(Head:-_);abolish(F,A);true)) ; true),
   retract_all((mpred_prop(F,prologHybrid):-true)),
   retract_all((mpred_prop(F,stubType(prologHybrid)):-true)),
   module_transparent(F/A),export(F/A),dynamic_safe(F/A),
   asserta_if_new(mpred_prop(F,predStub(StubType))),
   asserta_if_new(mpred_prop(F,StubType)),
   forall(member(HB,HBLIST),must(dbase_modify(change(assert,z),HB))),!,
   must_same_clauses(Head,HBLIST))),
   must(OUT=defined(user:provide_mpred_setup(Op,Head,StubType))).

   
:-op(0,fx,decl_mpred_prolog).

:-export(decl_mpred_prolog/1).
decl_mpred_prolog(P):- with_pi(P,decl_mpred_prolog).

:-export(decl_mpred_prolog/3).
decl_mpred_prolog(M,F,A):-integer(A),!,must(functor(PI,F,A)),decl_mpred_prolog(M,PI,F/A).
decl_mpred_prolog(M,PI,FA):- must(decl_mpred_prolog(_,M,PI,FA)).

decl_mpred_prolog(F,Other):- 
     decl_mpred(F,Other),
     get_functor(F,F0),
     must(mpred_arity(F0,A)),
     decl_mpred_prolog(F0/A).

:-export(decl_mpred_prolog/4).
decl_mpred_prolog(CM,M,PI,FA):- loop_check(must(decl_mpred_prolog_lc(CM,M,PI,FA)),true).

% decl_mpred_prolog_lc(_,_,_,_):-!.
decl_mpred_prolog_lc(CM,M,PI,F/A):-
      assert_if_new(mpred_arity(F,A)),
      assert_if_new(mpred_prop(F,prologOnly)),            
      assert_if_new(mpred_prop(F,[info(decl_mpred_prolog(CM,M,PI,F/A))])),
      decl_mpred(PI,predModule(M)),    
      must(call_no_cuts((user:provide_mpred_setup(call(_),PI,prologOnly,OUT),dmsg(PI=OUT)))),!.      


:-op(1120,fx,decl_mpred_prolog).

 

user_dynamic_multifile_exported(_):- dbase_mod(user),!.
user_dynamic_multifile_exported(Prop/Arity):- 
   dbase_mod(M), '@'( M:decl_mpred(Prop/Arity) , M).




%retract_all((G:-B)) :-!, forall(clause(G,B,Ref),erase(Ref)).
retract_all(HB) :- ignore((retract(HB),fail)).


is_static_pred(Head:-_):-!,predicate_property(Head,_),not(predicate_property(Head,dynamic)).
is_static_pred(Head):-predicate_property(Head,_),not(predicate_property(Head,dynamic)).

prolog_provide_mpred_storage_op(Op,G):- G\=isa(_,_), get_functor(G,F),mpred_prop(F,prologOnly),!, prolog_op(Op,G).
prolog_provide_mpred_storage_op(Op,G):- G\=isa(_,_), get_functor(G,F),not(mpred_prop(F,prologHybrid)),!,current_predicate(_,G), prolog_op(Op,G).
use_if_modify_new:- current_predicate(assert_if_new/1).
prolog_op(change(AR,Op), G):-ensure_dynamic(G),!,prolog_modify(change(AR,Op), G).

prolog_op(_,clause(G,B)):-!,clause_asserted(G,B).
prolog_op(_,clause(G,B,Ref)):-!,clause(G,B,Ref).

prolog_op(query(_,Op),G):-!,prolog_op(Op,G).
prolog_op(call(Op),G):-!, prolog_op(Op,G).
prolog_op(clauses(Op),G):-!, prolog_op(Op,G).
prolog_op(is_asserted,(G:-B)):-!,clause_asserted(G,B).
prolog_op(is_asserted,(G)):-!,clause_asserted(G,true).

prolog_op(conjecture,G):-!, mpred_call(G).
prolog_op(call,G):-!, mpred_call(G).
prolog_op(Op,G):- reduce_dbase_op(Op,Op2), debugOnError(call(Op2,G)).



prolog_modify(_Op,(:-(G))):-!, mpred_call(G).
prolog_modify(change(assert,z),G):- use_if_modify_new,!,assertz_if_new(G).
prolog_modify(change(assert,a),G):- use_if_modify_new,!,asserta_if_new(G).
prolog_modify(change(assert,_),G):- use_if_modify_new,!,assert_if_new(G).
prolog_modify(change(assert,z),G):-!,assertz(G).
prolog_modify(change(assert,a),G):-!,asserta(G).
prolog_modify(change(assert,_),G):-!,assert(G).
prolog_modify(change( retract,all),G):-!,retractall(G).
prolog_modify(change(retract,one),(G-B)):-!,retract((G-B)).

prolog_modify(change(retract,_),G):-!,retract(G).
prolog_modify(Op,G):- reduce_dbase_op(Op,Op2), mud_call_store_op(Op2,G).

ensure_dynamic(Var):-var(Var),!,trace_or_throw(var_ensure_dynamic(Var)).
ensure_dynamic(M:H1):-atom(M),!,ensure_dynamic(H1).
ensure_dynamic((H1,H2)):-!,ensure_dynamic(H1),ensure_dynamic(H2).
ensure_dynamic((H1;H2)):-!,ensure_dynamic(H1),ensure_dynamic(H2).
ensure_dynamic((H1:-_)):-!,ensure_dynamic(H1).
ensure_dynamic(':-'(_)):-!.
ensure_dynamic(Head):- Head\=isa(_,_),
   get_functor(Head,F,A),
   functor(PF,F,A),
   (\+ predicate_property(PF,_)->show_call((dynamic(F/A),multifile(F/A),export(F/A)));
   (is_static_pred(PF)-> 
     ((listing(F/A),dmsg(want_to_assert(ensure_dynamic(Head),decl_mpred_prolog(F,A,Head))),nop(dtrace))); true)).



:- op(1120,fx,decl_mpred_prolog).
  
  

  
  
  
  

  
