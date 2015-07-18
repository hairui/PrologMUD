

/** <module>
% ===================================================================
% File 'logicmoo_i_builtin.pfc'
% Purpose: Agent Reactivity for SWI-Prolog
% Maintainer: Douglas Miles
% Contact: $Author: dmiles $@users.sourceforge.net ;
% Version: 'interface' 1.0.0
% Revision: $Revision: 1.9 $
% Revised At: $Date: 2002/06/27 14:13:20 $
% ===================================================================
% File used as storage place for all predicates which change as
% the world is run.
%
% props(Obj,height(ObjHt)) == holds(height,Obj,ObjHt) == rdf(Obj,height,ObjHt) == height(Obj,ObjHt)
% padd(Obj,height(ObjHt)) == padd(height,Obj,ObjHt,...) == moo(QueryForm)
% kretract[all](Obj,height(ObjHt)) == kretract[all](Obj,height,ObjHt) == pretract[all](height,Obj,ObjHt) == del[all](QueryForm)
% keraseall(AnyTerm).
%
%
% Dec 13, 2035
% Douglas Miles
*/

:- op(500,fx,'~').
:- op(1050,xfx,('=>')).
:- op(1050,xfx,'<=>').
:- op(1050,xfx,('<=')).
:- op(1100,fx,('=>')).
:- op(1150,xfx,('::::')).
:- dynamic(tCol/1).
:- dynamic(subFormat/2).
:- dynamic(pfc_undo_sys/3).

:- include((logicmoo_i_header)).


:- file_begin(pfc).

a(z).

:- if(if_defined(pfc_testing)).

:- dynamic((a/0,b/0,c/0)).
a => b.
b => c.

:- must(\+c).
a.
:- must(c).
:- endif.

prologHybrid(arity/2).

% argsQuoted(P) => {assert_into_someplace(argsQuoted(P))}.


% this mean to leave terms at EL:  foo('QuoteFn'([cant,touch,me])).


argsQuoted('loop_check_term').
argsQuoted('loop_check_term_key').
argsQuoted('QuoteFn').

quasiQuote('QuoteFn').

argsQuoted(pfc_add).
argsQuoted(meta_argtypes).
argsQuoted(ttFormated).
argsQuoted(ruleRewrite).
argsQuoted(bordersOn).
argsQuoted(pfc_action).
argsQuoted(pfc_assert).
argsQuoted(pfc_rem).
argsQuoted(added).
argsQuoted(call).
argsQuoted(call_u).
argsQuoted(member).
argsQuoted(=..).
argsQuoted({}).
argsQuoted(second_order).
% argsQuoted((':-')).


% neg(tCol({})).

:-dynamic(pfc_default/1).
:-dynamic(pfc_default/1).
% here is an example which defines pfc_default facts and rules.  Will it work?
(pfc_default(P)/pfc_literal(P))  =>  (~neg(P) => P).
(pfc_default((P => Q))/pfc_literal(Q)) => (P, ~neg(Q) => Q).
(pfc_default((P => Q))/(pfc_literal(P),\+ pfc_literal(Q))) => (P => pfc_default(Q)).

%(pfc_default(P)/pfc_each_literal(P,E))  =>  pfc_default(E).

:-dynamic(conflict/1).
% a conflict triggers a Prolog action to resolve it.
conflict(C) => {must(resolveConflict(C))}.

% meta rules to schedule inferencing.
% resolve conflicts asap
pfc_select(conflict(X),W) :- pfc_queue(conflict(X),W).

% a pretty basic conflict.
(neg(P), P) => conflict(P).
(P, neg(P)) => conflict(P).

% remove conflicts early 
neg(P) => (\+P ).
(P => (\+neg(P))).

% is this how to define constraints?
(either(P,Q) => ((neg(P) <=> Q), (neg(Q) <=> P))).
% ((P,Q => false) => (P => neg(Q)), (Q => neg(P))).

type_prefix(_Prefix,Type)=>tCol(Type).
type_suffix(Suffix,Type)=>tCol(Type).



pfc_undo_sys(P, WhenAdded, WhenRemoved) => (P => {WhenAdded}), pfc_undo_method(WhenAdded,WhenRemoved).

pfc_undo_sys(added(P),pfc_assert(P),pfc_retract(P)).
% pfc_undo_sys(asserted(P),assert_eq_quitely(PE),retract_eq_quitely(PE)):-expand_goal(P,PE).

% 
comment(isa,"Instance of").

neg(tCol(genlPreds)).

% PFC is a language extension for prolog.. there is so much that can be done in the language for exmaple.. 

neg(arity(argIsa,1)).
arity(pddlObjects,2).

prologHybrid(genls/2).

tPred(F),arity(F,A)/(integer(A),A>1) => (not_col(F),support_hilog(F,A)).

(not_col(C) => ( \+ tCol(C), \+ completelyAssertedCollection(C),  neg(tCol(C)))).

(((support_hilog(F,A)/(atom(F),integer(A),\+ static_predicate(F/A), \+ prologDynamic(F)))) =>
   (hybrid_support(F,A), 
   {functor(Head,F,A) ,Head=..[F|TTs],TT=..[t,F|TTs]},
   added((Head :- cwc, second_order(TT,CuttedCall), ((CuttedCall=(C1,!,C2)) -> (C1,!,C2);CuttedCall))))).

(((hybrid_support(F,A)/(atom(F),integer(A), \+ prologDynamic(F),\+ static_predicate(F/A)))) =>
  (({
    functor(Head,F,A),    
    % must(rebuild_pred_into(Head,Head,pfc_assert,[+dynamic,+multifile,+discontiguous])),
    convert_to_dynamic(user,F,A),
    must(show_call_failure( \+ static_predicate(Head)))}),
    prologHybrid(F),
    arity(F,A))).

prologHybrid(F),arity(F,A)=>hybrid_support(F,A).

arity(genlPreds,2).

prologBuiltin(resolveConflict,mpred_module(user)).
prologBuiltin(pfc_select,mpred_module(user)).
prologBuiltin(agent_text_command/4,prologDynamic).
%tPred(t,prologDynamic).
tPred(member/2,prologBuiltin).
tPred(arity/2,prologHybrid).
tPred(is_never_type/1,prologDynamic).
tPred(term_expansion/2,prologDynamic).
tPred(var/1,prologBuiltin).

tCol(completelyAssertedCollection).
completelyAssertedCollection(completelyAssertedCollection).
completelyAssertedCollection(C)=>tCol(C).

% A Type Specification
completelyAssertedCollection(tCol).  % a type is a type
completelyAssertedCollection(tSpec). % A specification is sort of a type
tSpec(tCol).  % A specification may be a type
tSpec(meta_argtypes).  % A specification may be a syntactic description



% Cols are either syntactic or existential
completelyAssertedCollection(ttFormatType).  % syntactic
completelyAssertedCollection(tSet). % existential

% relations are predsor functions
completelyAssertedCollection(tRelation).
completelyAssertedCollection(tPred).
completelyAssertedCollection(tFunction).


completelyAssertedCollection(prologMacroHead).  % Items read from a file might be a special Macro Head
completelyAssertedCollection(ttPredType).  % Or they might be a predciate declarer
completelyAssertedCollection(functorDeclares).  % or they might declare other things

:-time((pfc_add((completelyAssertedCollection(isEach(tPred,prologMultiValued,prologOrdered,predIsFlag,ttNonGenled,
 prologNegByFailure,meta_argtypes,prologHybrid,prologPTTP,prologDynamic,prologKIF,prologBuiltin,prologMacroHead,prologListValued,prologSingleValued)))))).

completelyAssertedCollection(ftTerm).
completelyAssertedCollection(meta_argtypes).
completelyAssertedCollection(pfcControlled).
completelyAssertedCollection(predCanHaveSingletons).
completelyAssertedCollection(prologHybrid).
completelyAssertedCollection(tTemporalThing).
completelyAssertedCollection(prologMultiValued).
completelyAssertedCollection(prologDynamic).
completelyAssertedCollection(prologSideEffects).
completelyAssertedCollection(prologSingleValued).
completelyAssertedCollection(tInferInstanceFromArgType).
completelyAssertedCollection(ttNotTemporalType).
completelyAssertedCollection(ttSpatialType).
completelyAssertedCollection(ttTemporalType).
completelyAssertedCollection(ttTypeType).
completelyAssertedCollection(ttUnverifiableType).

ttPredType(P)=>(tSet(P),completelyAssertedCollection(P)).
ttTypeType(C)=>completelyAssertedCollection(C).

%overkill
tSet(C)=>completelyAssertedCollection(C).

%underkill
ttFormatType(C)=> ~completelyAssertedCollection(C).

tCol(C)/(atom(C),TCI=..[C,I]) => {decl_type(C)},arity(C,1),pfc_univ(C,I,TCI).
(tCol(C)/(atom(C),TCI=..[C,_I],\+ static_predicate(TCI) )) => {dynamic(C/1)}.
(tCol(C)/(atom(C),TCI=..[C,I],\+ static_predicate(TCI), \+completelyAssertedCollection(C))) => added((TCI:-cwc,isa_backchaing(I,C))).

% (tInferInstanceFromArgType(Col),tCol(Col)/i_name('',Col,ColName),tPred(Prop)/i_name('',Prop,PropName),{ColName=PropName}=> tInferInstanceFromArgType(Prop)).

% (tInferInstanceFromArgType(Prop),tPred(Prop),arity(Prop,N)/(N>1) => ({i_name('vt',Prop,FinalType)},tCol(FinalType),tInferInstanceFromArgType(FinalType),argIsa(Prop,N,FinalType))).

ttPredType(predCanHaveSingletons).
ttPredType(prologSideEffects).
prologSideEffects(write/1).

ttPredType(pfcDatabaseTerm).
ttPredType(pfcControlled).
ttPredType(prologSingleValued).


ttPredType(pfcWatched).
ttPredType(pfcCreates).
ttPredType(pfcNegTrigger).
ttPredType(pfcPosTrigger).
ttPredType(pfcBcTrigger).
ttPredType(pfcRHS).

ttPredType(pfcMustFC).


ttPredType(isEach(meta_argtypes,pfcDatabaseTerm,pfcControlled,pfcWatched,pfcMustFC,predIsFlag,tPred,prologMultiValued,
 prologSingleValued,prologMacroHead,prologBuiltin,prologDynamic,prologOrdered,prologNegByFailure,prologPTTP,prologKIF,prologEquality,prologPTTP,
 prologSideEffects,prologHybrid,prologListValued)).

completelyAssertedCollection(isEach(tCol,tPred,pfcControlled)).
ttPredType(C)=>completelyAssertedCollection(C).


neg(ttFormatType(prologEquality)).
ttPredType(prologEquality).
tSpec(prologEquality).
prologEquality(mudEquals).
prologEquality(('=')).
prologEquality(('==')).

neg(isa((','), prologEquality)).

tCol(isEach(tCol,tPred,pfcControlled)).
tCol(meta_argtypes).
tCol(functorDeclares).
ttPredType(predIsFlag).
ttPredType(prologDynamic).
ttPredType(prologHybrid).
ttPredType(pfcControlled).
ttPredType(prologKIF).
ttPredType(prologBuiltin).
ttPredType(prologPTTP).
:-pfc_add( pfcControlled(genlPreds)).
:-pfc_add( pfcControlled(isa)).
:-pfc_add(pfcControlled(argIsa)).

pfcControlled(P),arity(P,A)=>hybrid_support(P,A).

ttPredType(X)=>tCol(X).

tSet(ttFormatType).

isa(I,C):- cwc, pfc_univ(C,I,CI),atom(C),current_predicate(C/1,CI)->call(CI).



%tCol(X) => isa(X,tCol).
%tCol(X) => ruleRewrite(t(X,I),isa(I,X)).


%typeProps(tCoffeeCup,[mudColor(vBlack),mudColor(isEach(vBrown,vBlack)),mudSize(vSmall),mudShape(vCuplike),mudMaterial(vGlass),mudTexture(vSmooth)]).
%props(iCoffeeCup7,[mudColor(vBlack),mudColor(isEach(vBrown,vBlack)),mudSize(vSmall),mudShape(vCuplike),mudMaterial(vGlass),mudTexture(vSmooth)]).

=>tSet(tSet).

tSet(P)=>
  {get_functor(P,C), functor(Head,C,1),
  (\+(predicate_property(Head,_))->dynamic(C/1);true),  
  Head=..[C,_],
 (predicate_property(Head,dynamic)->true;show_pred_info(Head))},
   functorDeclares(C),
   isa(C,pfcControlled),
   arity(C,1),
   % (isa(I,C)/ground(I:C)=>Head),
   isa(C,tCol).

ttFormatType(P) => {get_functor(P,C), functor(Head,C,1),
  (\+(predicate_property(Head,_))->dynamic(C/1);true),  
  Head=..[C,I],
 (predicate_property(Head,dynamic)->true;show_pred_info(Head))},
   neg(functorDeclares(C)),
   % isa(C,prologDynamic),
   arity(C,1),
   ((Head)/predicate_property(Head,dynamic)=>{retract(Head)}),
   ((isa(I,C))=>{retract(isa(I,C))}).

arity(prologMacroHead,1).

:-dmsg("line 128").

ttPredType(isEach(prologMultiValued,prologOrdered,prologNegByFailure,prologPTTP,prologHybrid,
  predCanHaveSingletons,prologDynamic,tPred,prologMacroHead,prologListValued,prologSingleValued)).
prologMacroHead(prologMacroHead).
ttPredType(X)=>functorDeclares(X).
functorDeclares(X)=>tSet(X).
functorDeclares(X)=>tCol(X).
% prologMacroHead(X)=>functorDeclares(X).
:-dmsg("line 136").
% prologMacroHead(pddlSomethingIsa/2).
tPred(pddlSomethingIsa(ftTerm,ftListFn(tCol))).


isa(pddlSomethingIsa/2, prologHybrid).

arity(argIsa,3).


%:-rtrace.
%genls(X,tPred) <=> ttPredType(X).
%:-nortrace.
% sane_transitivity((genls(I,Sub),genls(Sub, Super)),I,Sub,Super)
(genls(C1,C2),arity(C1,1),arity(C2,1),
  { 
   \+((genls(C1,CM),CM\=C1,genls(CM,C2),CM\=C2)),C2\=C1
    
   }) =>

  {
  get_functor(C1,F1),get_functor(C2,F2),
    nop(dmsg(wishing_to_add(C2 <= C1)))},
    nearestGenls(F1,F2).

nearestGenls(C1,C2)=>
 {get_functor(C1,F1),get_functor(C2,F2),
   P1 =.. [F1,X],
    P2 =.. [F2,X],
    asserta_if_new((P2:-P1))}.

% prologHybrid(F/A)/(atom(F),number(A)) => arity(F,A),{show_call(dynamic_safe(F/A))}.

% Functions
tFunction(ArgTypes)/is_declarations(ArgTypes) => meta_argtypes(ArgTypes).
% FormatTypes
ttFormatType(ArgTypes)/is_declarations(ArgTypes) => meta_argtypes(ArgTypes).



prologMacroHead(tCol).


completelyAssertedCollection(prologSingleValued).
completelyAssertedCollection(tCol).
completelyAssertedCollection(ttFormatType).
completelyAssertedCollection(ttValueType).
completelyAssertedCollection(ttTemporalType).
completelyAssertedCollection(tRelation).
completelyAssertedCollection(tPred).

completelyAssertedCollection(C)=>completeExtentAsserted(C).

completeExtentAsserted(genlPreds).
completeExtentAsserted(defnSufficient).

:-dynamic(ttNotTemporalType/1).
ttNotTemporalType(ftInt).
%ttNotTemporalType(ftTerm).
ttNotTemporalType(tCol).
ttNotTemporalType(ttFormatType).
ttNotTemporalType(ttValueType).

=>ttNotTemporalType(tCol).
ttNotTemporalType(T)=>tCol(T).
=>ttTemporalType(tTemporalThing).
ttTemporalType(T)=>tCol(T).

arity(argQuoted,1).


((isa(Inst,ttTemporalType), tCol(Inst)) => genls(Inst,tTemporalThing)).

% (isa(Inst,Type), tCol(Inst)) => isa(Type,ttTypeType).


(ttFormatType(FT),{compound(FT)})=>meta_argtypes(FT).

tCol(vtDirection).

disjointWith(Sub, Super) => disjointWith( Super, Sub).
disjointWith(ttTemporalType,ttAbstractType).



tCol(tNotForUnboundPredicates).

prologSideEffects(P)=>tNotForUnboundPredicates(P).

isa(member,tNotForUnboundPredicates).

isa(tRelation,ttAbstractType).



%P/(nonvar(P),get_functor(P,F)),afterAdding(F,Do)/nonvar(Do)=>{call(Do,P)}.
%~P/(nonvar(P),get_functor(P,F)),afterRemoving(F,Do)/nonvar(Do)=>{call(Do,P)}.

%pfcMark(pfcPosTrigger, _, F, A)/(integer(A),functor(P,F,A)) => pfcTriggered(F/A), afterAdding(F,lambda(P,pfc_enqueue(P,(m,m)))).
%pfcMark(pfcNegTrigger, _, F, A)/(integer(A),functor(P,F,A)) => pfcTriggered(F/A), afterRemoving(F,lambda(P,pfc_enqueue(~P,(m,m)))).




(tCol(Inst), {isa_from_morphology(Inst,Type)}) => added(isa(Inst,Type)).

% HOW TO MAKE THIS FAST?  isa(Inst,Type) <= {isa_from_morphology(Inst,Type)}.

%((disjointWith(P1,P2) , genls(C1,P1), {dif:dif(C1,P1)}) =>    disjointWith(C1,P2)).
% (disjointWith(C1,P2) <= (genls(C1,P1), {dif:dif(C1,P1)}, disjointWith(P1,P2))).

tCol(completelyAssertedCollection).
tCol(completeIsaAsserted).
% genls(completeIsaAsserted,tTemporalThing).
genls(completelyAssertedCollection,tCol).
completelyAssertedCollection(completelyAssertedCollection).
completelyAssertedCollection(tPred).
completelyAssertedCollection(tRelation).
completelyAssertedCollection(tFormatType).
completelyAssertedCollection(tSet).
completelyAssertedCollection(functorDeclares).
completelyAssertedCollection(ttPredType).
completelyAssertedCollection(completelyAssertedCollection).

% dividesBetween(S,C1,C2) => (disjointWith(C1,C2) , genls(C1,S) ,genls(C2,S)).

% disjointWith(P1,P2) => ((neg(isa(C,P1))) <=> isa(C,P2)).

% isa(Col1, ttObjectType) => neg(isa(Col1, ttFormatType)).

tCol(tCol).
tCol(tPred).
tCol(tFunction).
tCol(tRelation).
tCol(ttTemporalType).
tCol(ttFormatType).
tCol(functorDeclares).
% tCol(ArgsIsa):-ttPredType(ArgsIsa).
% TODO decide if OK
%tCol(F):-t(functorDeclares,F).
tCol(ttFormatType).


genls(ttSpatialType,ttTemporalType).
genls(tSpatialThing,tTemporalThing).




tCol(ttNonGenled).
% genls(ttFormatType,ttNonGenled).
isa('Thing',ttNonGenled).
isa('CycLTerm',ttNonGenled).
=>prologHybrid(quotedIsa(ftTerm,ttFormatType)).
:-dynamic(quotedIsa/2).

tCol(ttSpatialType).
tCol(tSpatialThing).
completelyAssertedCollection(ttTypeType).
completelyAssertedCollection(tCol).


((completeIsaAsserted(I), isa(I,Sub), genls(Sub, Super),{ground(Sub:Super)}) => ({dif:dif(Sub, Super)}, isa(I,Super))).
% (isa(I,Sub), genls(Sub, Super),{ground(Sub:Super)}, ~neg(completelyAssertedCollection(Super))) => ({dif:dif(Sub, Super)}, isa(I,Super)).

( meta_argtypes(FT), {dif:dif(FT,COL)}, genls(FT, COL),tCol(COL),{not(isa(COL,ttFormatType))}) => formatted_resultIsa(FT,COL).


% asserting mpred_sv(p,2) causes p/2 to be treated as a mpred_sv, i.e.
% if p(foo,1)) is a fact and we assert_db p(foo,2), then the forrmer assertion
% is retracted.
mpred_sv(Pred,Arity)=> prologSingleValued(Pred),arity(Pred,Arity),singleValuedInArg(Pred,Arity).

prologSingleValued(Pred),arity(Pred,Arity) => hybrid_support(Pred,Arity).


singleValuedInArg(Pred,_)=>prologSingleValued(Pred).



% prologSingleValued(Pred),arity(Pred,Arity), \+ singleValuedInArg(Pred,_) => singleValuedInArg(Pred,Arity).
pfc_default((prologSingleValued(Pred),arity(Pred,Arity)) => singleValuedInArg(Pred,Arity)).


singleValuedInArg(singleValuedInArg,2).



:- dynamic(isa/2).

ttPredType(Prop)=>tCol(Prop).


%:-user:agenda_slow_op_enqueue(add(((arity(Pred,2),argIsa(Pred,1,Col)/(nonvar(Pred),Col\=ftTerm,tSet(Col)), \+prologSideEffects(Pred), t(Pred,Arg,_)/nonvar(Arg)) => t(Col,Arg)))).
%:-user:agenda_slow_op_enqueue(add(((arity(Pred,2),argIsa(Pred,2,Col)/(nonvar(Pred),Col\=ftTerm,tSet(Col)), \+prologSideEffects(Pred), t(Pred,_,Arg)/nonvar(Arg)) => t(Col,Arg)))).
%:-add_slow(((arity(Pred,2),argIsa(Pred,2,Col)/(nonvar(Pred),Col\=ftTerm,tSet(Col)),t(Pred,_,Arg)/nonvar(Arg)) => t(Col,Arg))).
%(((P/(has_functor(P),get_functor(P,F,A),A\=2,\+prologSideEffects(F),pfc_literal(P)) => {user:agenda_slow_op_enqueue(deduceEachArgType(P))}))).
(P/pfc_literal(P) => {user:agenda_slow_op_enqueue(must(ignore(deduceEachArgType(P))))}).
% tCol(Col) <=> isa(Col,tCol).

:-dynamic((disjointWith/2,genls/2,isa/2)).

%(disjointWith(P1,P2) , genls(C1,P1)) =>    disjointWith(C1,P2).
disjointWith(Sub, Super) => disjointWith( Super, Sub).
disjointWith(ttTemporalType,ttAbstractType).

prologHybrid(typeGenls/2).
:-add(meta_argtypes(typeGenls(ttTypeType,tCol))).
%(isa(COLTYPEINST,COLTYPE) , typeGenls(COLTYPE,COL)) => genls(COLTYPEINST,COL).

typeGenls(ttPredType,tPred).


prologHybrid(argIsa/3).

:-asserta(thlocal:pfcExpansion).
prologBuiltin(resolveConflict/1).
prologBuiltin(pfc_select/2).


/*
:- pfc_add(((vtActionTemplate(ArgTypes)/is_declarations(ArgTypes) => vtActionTemplate(ArgTypes)))).
:- pfc_add(((user:action_info(ArgTypes,_)/is_declarations(ArgTypes) => vtActionTemplate(ArgTypes)))).
:- pfc_add(((isa(Compound,prologMacroHead)/compound_functor(Compound,F)) => functorDeclares(F))).
(ttFormatType(FT)/is_declarations(FT))=>meta_argtypes(FT).


*/



% :- if_startup_script(with_assertions(thlocal:pfcExpansion,ensure_loaded(mpred_i_mpred_pfc_testing))).

% :-asserta(user:isa_pred_now_locked).


% :-loadTinyAssertions1.

%:-prolog_repl.
%:-showTinyAssertions.
%:-prolog_repl.
%:-loadTinyAssertions2.

tCol(tBird).
%:-debug.
%:-rtrace.
:-must(dynamic(tBird/1)).

:- meta_predicate(neg(0)).
:- dynamic(neg(0)).

:-dynamic(mpred_module/2).
:-decl_mpred(mpred_module/2).

meta_argtypes(mpred_module(tPred,tPrologModule)).
:-debug.

prologHybrid(mpred_module, 2).
prologMultiValued(mpred_module(tRelation,ftAtom)).


% pddlObjects(Type,EList)=>  isa(isEach(EList),Type).
% pddlSorts(Type,EList)=> genls(isEach(EList),Type).


:-dynamic(argIsa/3).

:-decl_mpred(argIsa/3).

isa(Spec,tCol) => arity(Spec,1).

% :-pfc_add((mpred_prop(I,C)=>{add((isa(I,tPred),mpred_prop(I,C),props(I,[C])))})).
% :-pfc_add((t(C,I)=>{ /* retract(hasInstance_dyn(C,I)), */ add((isa(I,C))) , add((props(I,C)))})).

:- meta_predicate(mp_test_agr(?,+,-,*,^,:,0,1,5,9)).
% becomes         mp_test_agr(+,+,-,?,^,:,0,1,0,0)

mp_test_agr(_,_,_,_,_,_,_,_,_,_).

:-show_call(predicate_property(mp_test_agr(_,_,_,_,_,_,_,_,_,_),meta_predicate(_))).

% :-include(logicmoo_i_header).
tCol(tPred).
:-must(assert_argIsa(tPred,1,tPred)).


/*
% reflexive equality
equal(A,B) => equal(B,A).
equal(A,B),{ \+ (A=B}),equal(B,C),{ \+ (A=C)} => equal(A,C).

notequal(A,B) <= notequal(B,A).
notequal(C,B) <= equal(A,C),notequal(A,B).
*/

% is this how to define constraints?
% either(P,Q) => (neg(P) => Q), (neg(Q) => P).
% (P,Q => false) => (P => neg(Q)), (Q => neg(P)).


:-export(member/2).
:-export(arg/3).
%:-export(mpred_call/1).
% prologDynamic(cycAssert/2).
:-export(integer/1).
% :-export(makeConstant/1).
% :-export(naf/1).
:-export(number/1).
:-export(string/1).
:-export(var/1).

tCol(completeExtentAsserted).
tCol(ttFormatType).
tCol(functorDeclares).


((prologHybrid(C),{get_functor(C,F,A),C\=F}) => arity(F,A)).
prologHybrid(typeProps/2).
arity(typeProps,2).



% :- decl_mpred_pfc neg/1.
prologHybrid(isEach( tCol/1, disjointWith/2, genls/2,genlPreds/2, meta_argtypes/1)).

:- ignore(show_call_failure(arity(typeProps,2))).
:- must(pfc_call(arity(typeProps,2))).
:- add((argIsa(isEach(tPred,prologMultiValued,prologOrdered,prologNegByFailure,prologHybrid,prologPTTP,predCanHaveSingletons,prologDynamic,prologMacroHead,prologListValued,prologSingleValued),1,tPred))).
:- add((argIsa(isEach(tPred,prologMultiValued,prologOrdered,prologNegByFailure,meta_argtypes,prologHybrid,prologPTTP,prologDynamic,prologMacroHead,prologListValued,prologSingleValued),2,ftListFn(ftVoprop)))).
:-dmsg("line 427").
:- add((isa(isEach(prologMultiValued,prologOrdered,prologNegByFailure,meta_argtypes,prologPTTP,prologHybrid,predCanHaveSingletons,prologDynamic,prologBuiltin,prologMacroHead,prologListValued,prologSingleValued),functorDeclares))).
:- add((genls(isEach(prologMultiValued,prologOrdered,prologNegByFailure,prologHybrid,prologPTTP,prologDynamic,prologBuiltin,prologKIF,prologMacroHead,prologListValued,prologSingleValued),tPred))).
:- assert_hasInstance(tCol,tCol).
:- file_begin(pfc).
:- debug.
%TODO FIX :- decl_mpred(tDeleted(ftID),[predIsFlag]).
prologHybrid(isEach( ttNotTemporalType/1,ttTemporalType/1 )).
prologHybrid(isEach(genlInverse/2,genlPreds/2)).
prologHybrid(argIsa/3).
prologHybrid(argSingleValueDefault, 3).
prologHybrid(disjointWith/2).
prologHybrid(instTypeProps/3).
prologHybrid(predProxyAssert,2).
prologHybrid(predProxyQuery, 2).
prologHybrid(predProxyRetract, 2).
prologHybrid(predTypeMax/3).
prologHybrid(prologSingleValued/1).
prologHybrid(prologSideEffects).
prologHybrid(resultIsa/2).
prologHybrid(genls/2).
prologHybrid(isa/2).
prologHybrid(genls/2).
prologDynamic(arg/3).
tCol(meta_argtypes).
tCol(prologMultiValued).
tCol(prologSingleValued).
tCol(tCol).
tCol(tFunction).
tCol(tInferInstanceFromArgType).
tCol(tPred).
tCol(tRelation).
tCol(meta_argtypes).
tCol(ttTemporalType).
tCol(ttTypeType).
% tCol(tPathway).

tCol(ttValueType).
tSpec(vtActionTemplate).
ttFormatType(ftString).
ttFormatType(ftVar).
ttFormatType(ftSpec).

ttFormatType(ftCallable).
ttFormatType(ftPercent).

isa(vRed,vtColor).

completelyAssertedCollection(vtValue).



isa(vtColor,ttValueType).
isa(X,ttValueType)=> (genls(X,vtValue),completelyAssertedCollection(X)).

isa(vtValue,ttValueType).

typeGenls(ttValueType,vtValue).


:-must(vtColor(vRed)).


:-assertz_if_new((argIsa(Prop,N,Type) :- cwc,number(N),argIsa_known(Prop,N,Type),must(ground(argIsa(Prop,N,Type))))).

argQuotedIsa(Prop,N,Type) <= {number(N)},argIsa(Prop,N,Type),ttFormatType(Type).

:- discontiguous(prologSingleValued/1).
:- do_gc.

:-dynamic(mudLabelTypeProps/3).
:-multifile(mudLabelTypeProps/3).
:- forall(ttPredType(F),must((decl_type(F),add(isa(F,functorDeclares)),add(genls(F,tPred))))).
:- export(mtForPred/2).

:- set_prolog_flag(report_error,true).
:- set_prolog_flag(debug_on_error,true).

:- debug,(decl_mpred_hybrid((argIsa/3, formatted_resultIsa/2, localityOfObject/2, subFormat/2, 
    isa/2,  genls/2, pddlSomethingIsa/2, 
    resultIsa/2, subFormat/2, tCol/1, tRegion/1, completelyAssertedCollection/1, 
    ttFormatType/1, typeProps/2))).

prologHybrid(isEach(argIsa/3, formatted_resultIsa/2, localityOfObject/2, subFormat/2, isa/2, 
   genls/2, pddlSomethingIsa/2, resultIsa/2, subFormat/2, tCol/1, tRegion/1, 
   completelyAssertedCollection/1, ttFormatType/1, typeProps/2)).

:-add(isa(ttFormatType,ttAbstractType)).
:-discontiguous(subFormat/2).
:-dynamic(tChannel/1).
:-multifile(tChannel/1).

% pfc_add((I/(pfc_literal(I),fully_expand(_,I,O),I \=@=O )=> ({format('~q~n',[fully_expand(I->O)])},O))).

subFormat(ftDeplictsFn(tCol),ftSpec).
subFormat(ftDeplictsFn(meta_argtypes),ftSpec).
subFormat(ftVoprop,ftSpec).

tFunction(isEach(ftRest(ftTerm))).
tFunction(isRandom(tCol)).
tFunction(isAnd(ftRest(ftSpec))).
tFunction(isMost(ftRest(ftSpec))).
tFunction(isOneOf(ftRest(ftSpec))).
tFunction(isNot(ftSpec)).
tFunction(isOptional(ftSpec,ftTerm)).
tFunction(isOptionalStr(ftString)).
tFunction(exactStr(ftString)).

resultIsa(F,C)=>(isa(F,'tFunction'),isa(C,ftSpec)).
resultIsa(ftDeplictsFn,ftSpec).

tPred(quotedDefnIff/2,prologHybrid).

isa(argIsa,prologHybrid).
isa(determinerString, prologMultiValued).
isa(quotedDefnIff, completeExtentAsserted).
isa(ftInt,ttFormatType).
isa(ftNumber,ttFormatType).
isa(ftString,ttFormatType).
isa(isInstFn,tFunction).
isa(isKappaFn,tFunction).
isa(prologMultiValued, tCol).
arity(ftListFn,1).
arity(isLikeFn,2).
arity(ftDeplictsFn,1).
tFunction(ftDice(ftInt,ftInt,ftInt)).
tFunction(ftListFn(ftRest)).
tFunction(ftDeplictsFn(tCol)).

completelyAssertedCollection(tAvoidForwardChain).
completelyAssertedCollection('SententialOperator').

tCol(tAvoidForwardChain).
tCol('SententialOperator').
%TODO tAvoidForwardChain('$VAR'('FUNC')).

tAvoidForwardChain(isEach('FunctionToArg',holds,equals,different,evaluate,trueSentence,'TINYKB-ASSERTION',termOfUnit)).
genls('SententialRelation','SententialOperator').
genls('SententialOperator',tAvoidForwardChain).
genls('VariableArityRelation',tAvoidForwardChain).
genls('CommutativeRelation',tAvoidForwardChain).
genls('tFunction',tAvoidForwardChain).
genls('EvaluatableRelation',tAvoidForwardChain).


tCol(completeIsaAsserted).
%completelyAssertedCollection(Ext):- fwc, arg(_,vv(tCol,vtDirection,ttFormatType,tRegion,ftString,genlPreds),Ext).
completeExtentAsserted(formatted_resultIsa).
completeExtentAsserted(quotedDefnIff).
completelyAssertedCollection(completelyAssertedCollection).
ttFormatType(ftString).
ttFormatType(ftVar).
ttFormatType(ftVoprop).



%:- pfc_trace.
%:- pfcWatch.
%:- pfc_warn.
% next_test :- sleep(1),pfcReset.


% :-dynamic((disjointWith/2,genls/2)).


prologHybrid(argQuotedIsa(tRelation,ftInt,ttFormatType)).
prologHybrid(argIsa(tRelation,ftInt,tCol)).
prologHybrid(argSingleValueDefault(prologSingleValued,ftInt,ftTerm)).
prologHybrid(formatted_resultIsa(ttFormatType,tCol)).

{FtInt=2},argSingleValueDefault(PrologSingleValued,FtInt,FtTerm),arity(PrologSingleValued,FtInt),
  argIsa(PrologSingleValued,1,Col)=>relationMostInstance(PrologSingleValued,Col,FtTerm).

prologHybrid(quotedDefnIff(ttFormatType,ftTerm)).
prologHybrid(defnNecessary(ttFormatType,ftTerm)).
prologHybrid(defnIff(ttFormatType,ftTerm)).
prologHybrid(quotedDefnIff(ttFormatType,ftTerm)).


tFuncton(isLikeFn(tPred,tCol)).
tRelation('=>'(ftAskable,ftAssertable)).
tRelation('<='(ftAssertable,ftAskable)).
prologHybrid(instTypeProps(ftID,tCol,ftRest(ftVoprop))).
prologHybrid(subFormat(ttFormatType,ttFormatType)).
prologMacroHead(macroSomethingDescription(ftTerm,ftListFn(ftString))).
prologMacroHead(pddlObjects(tCol,ftListFn(ftID))).
prologMacroHead(pddlPredicates(ftListFn(ftVoprop))).
prologMacroHead(pddlSorts(tCol,ftListFn(tCol))).
prologMacroHead(pddlTypes(ftListFn(tCol))).
prologMultiValued(comment(ftTerm,ftString)).
prologMultiValued(genlInverse(tPred,tPred)).
prologMultiValued(genlPreds(tPred,tPred)).
prologMultiValued(predProxyAssert(prologMultiValued,ftTerm)).
prologMultiValued(predProxyQuery(prologMultiValued,ftTerm)).
% prologMultiValued('<=>'(ftTerm,ftTerm)).
prologMultiValued('<='(ftAssertable,ftAskable)).
prologMultiValued('=>'(ftAskable,ftAssertable)).
prologNegByFailure(predArgMulti(prologMultiValued,ftInt)).
prologNegByFailure(tDeleted(ftID)).
prologSingleValued(predInstMax(ftID,prologSingleValued,ftInt),prologHybrid).
prologSingleValued(predTypeMax(prologSingleValued,tCol,ftInt),prologHybrid).
resultIsa(txtFormatFn,ftText).
%'<=>'(prologMultiValued(CallSig,[predProxyAssert(hooked_asserta),predProxyRetract(hooked_retract),predProxyQuery(call)]),prologDynamic(CallSig)).
%'<=>'(prologMultiValued(CallSig,[predProxyAssert(pttp_tell),predProxyRetract(pttp_retract),predProxyQuery(pttp_ask)]),prologPTTP(CallSig)).
subFormat(ftAtom,ftTerm).
subFormat(ftCallable,ftProlog).
resultIsa(ftDice,ftInt).
subFormat(ftID,ftTerm).
subFormat(ftInt,ftNumber).
subFormat(ftInteger,ftNumber).
subFormat(ftNumber,ftPercent).
subFormat(ftPercent,ftNumber).
subFormat(ftString,ftTerm).
subFormat(ftString,ftText).
subFormat(ftTerm,ftProlog).
subFormat(ftText,ftTerm).
subFormat(ftVar,ftProlog).
subFormat(ftVoprop,ftRest(ftVoprop)).
subFormat(ftVoprop,ftTerm).


tCol(W)=>{guess_supertypes(W)}.


tCol(tNewlyCreated).
tCol(ttTypeFacet).

tNewlyCreated(W)=>{guess_types(W)}.

ttTypeFacet(tNewlyCreated).
ttTypeFacet(ttTypeFacet).
ttTypeFacet(ttUnverifiableType).


%typeGenls(tPred,ttPredType).
typeGenls(ttFormatTypeType,ttFormatType).
typeGenls(ttTemporalType,tTemporalThing).
typeGenls(ttTypeFacet,tCol).
typeGenls(ttTypeType,tCol).



ttTypeFacet(ttUnverifiableType).
ttUnverifiableType(ftDice).
ttUnverifiableType(ftID).
ttUnverifiableType(ftListFn(ftTerm)).
ttUnverifiableType(ftString).
ttUnverifiableType(ftTerm).
ttUnverifiableType(ftText).
ttUnverifiableType(ftVoprop).
ttUnverifiableType(tCol).
ttUnverifiableType(tFunction).
ttUnverifiableType(tPred).
ttUnverifiableType(ttFormatType).
ttUnverifiableType(vtDirection).


%ttPredType(ArgsIsa)=>tPred(ArgsIsa).
%TODO isa(_,ArgsIsa)=>tCol(ArgsIsa).



/*
disjointWith(A,B):- A=B,!,fail.
disjointWith(A,B):- disjointWithT(A,B).
disjointWith(A,B):- disjointWithT(AS,BS),transitive_subclass_or_same(A,AS),transitive_subclass_or_same(B,BS).
disjointWith(A,B):- once((type_isa(A,AT),type_isa(B,BT))),AT \= BT.
*/
disjointWith(Sub, Super) => disjointWith( Super, Sub).


disjointWith(ttTemporalType,ttAbstractType).

prologHybrid(dividesBetween(tCol,tCol,tCol)).

quotedDefnIff(X,_)=>ttFormatType(X).

quotedDefnIff(ftInt,integer).
quotedDefnIff(ftFloat,float).
quotedDefnIff(ftAtom,atom).
quotedDefnIff(ftString,string).
quotedDefnIff(ftCallable,is_callable).
quotedDefnIff(ftCompound,compound).
quotedDefnIff(ftGround,ground).
quotedDefnIff(ftID,is_id).
quotedDefnIff(ftTerm,nonvar).
quotedDefnIff(ftVar,var).
quotedDefnIff(ftNonvar,nonvar).
quotedDefnIff(ftNumber,number).
quotedDefnIff(ftRest,is_rest).
quotedDefnIff(ftRest(Type),is_rest_of(Type)).
quotedDefnIff(ftListFn(Type),is_list_of(Type)).
quotedDefnIff(ftBoolean,is_boolean).
quotedDefnIff(ftText,is_string).
quotedDefnIff(ftCodeIs(SomeCode),SomeCode):-nonvar(SomeCode).

isa(arity,tBinaryPredicate).



% tCol(Type),(tBinaryPredicate(Pred)/(functor(G,Pred,2),G=..[Pred,isInstFn(Type),Value])), G => relationMostInstance(Pred,Type,Value).



%((genlPreds(Col1,Col2),(arity(Col1,1);arity(Col2,1)))=>genls(Col1,Col2)).
%((genls(Col1,Col2),(tPred(Col1);tPred(Col2)))=>genlPreds(Col1,Col2)).

:-must(pfc_add(tCol('UnaryPredicate'))).


pfcMark(_Type,_,F,A)/(A>1,F\==arity)=>arity(F,A),pfcControlled(F).

pfc_mark_C(G) => {pfc_mark_C(G)}.
pfc_mark_C(G) :-  map_literals(lambda(P,(get_functor(P,F,A),pfc_add([isa(F,pfcControlled),arity(F,A)]))),G).

((pfcControlled(C)/(get_arity(C,F,A),arity(F,A))) => support_hilog(F,A)).

pfcControlled(C)/has_functor(C)=>({decl_mpred_hybrid(C),get_functor(C,F,A)},arity(F,A),pfcControlled(F)).
isa(F,pfcMustFC) => pfcControlled(F).

(tCol(P),~ttFormatType(P)) => tSet(P).

prologHybrid(X)/has_functor(X)=>{decl_mpred_hybrid(X)}.
prologDynamic(X)/has_functor(X)=>{decl_mpred_prolog(X)}.
prologBuiltin(X)/has_functor(X)=>{decl_mpred_prolog(X)}.
pfcControlled(X)/has_functor(X)=>{once(X=(F/A);get_functor(X,F,A)),dynamic(F/A),multifile(F/A),decl_mpred_hybrid(X)}.


pfcControlled(C)=>prologHybrid(C).


pfcMark(pfcRHS,_,F,A)/(atom(F),integer(A),F\==arity)=>tPred(F).

/*
pfcMark(pfcRHS,_,F,1)/(fail,atom(F),functor(Head,F,1), 
 \+ argsQuoted(F),
 \+ prologDynamic(F),
 \+ neg(tCol(F)),
 \+ specialFunctor(F),
 \+ predicate_property(Head,built_in))=>completelyAssertedCollection(F).
*/

specialFunctor('\\+').
specialFunctor('/').


isa(I,C):- cwc, is_asserted(ttFormatType(C)), quotedIsa(I,C).
quotedIsa(I,C):- cwc, term_is_ft(I,C).

:-time(expand_props(_,props(iCrackers666,[mudColor(vTan),isa(tBread),mudShape(isEach(vCircular,vFlat)),mudSize(vSmall),mudTexture(isEach(vDry,vCoarse))]),O)),time(pfc_add(pfc_default(O))).

:-time(fully_expand(_,props(iCrackers666,[mudColor(vTan),isa(tBread),mudShape(isEach(vCircular,vFlat)),mudSize(vSmall),mudTexture(isEach(vDry,vCoarse))]),_)).

:-pfc_trace.

:-time(pfc_add((((arity(Pred,2),tPred(Pred)) <=> isa(Pred,tBinaryPredicate))))).

% if arity is ever greater than 1 it can never become 1
arity(F,A)/(number(A),A>1) => neg(arity(F,1)).

completelyAssertedCollection(tBinaryPredicate).

prologHybrid(relationMostInstance(tBinaryPredicate,tCol,vtValue)).

(relationMostInstance(Pred,_,Value),argIsa(Pred,2,Type)=>(isa(Value,Type),isa(Pred,tRolePredicate))).
(relationAllInstance(Pred,_,Value),argIsa(Pred,2,Type)=>(isa(Value,Type),isa(Pred,tRolePredicate))).


relationMostInstance(BP,_,_)=>tBinaryPredicate(BP).
prologHybrid(relationAllInstance(tBinaryPredicate,tCol,vtValue)).


relationAllInstance(BP,_,_)=>tBinaryPredicate(BP).

% TODO ADD THIS 
%(tSet(Super),completelyAssertedCollection(Super),genls(Sub, Super), isa(I,Sub), {ground(I:Sub:Super),\==(Sub, Super)}) => isa(I,Super).

% genlPreds(genls,equals).
% genls(A, B):- tCol(A),{A=B}.

% rtrace(Goal):- Goal. % (hotrace((visible(+all),visible(+unify),visible(+exception),leash(-all),leash(+exception))),(trace,Goal),leash(+all)).

% :- gutracer.

% (isa(TypeType,ttTypeType) , isa(Inst,TypeType), genls(SubInst,Inst)) => isa(SubInst,TypeType).






:-must((fully_expand_goal(_,:-multifile user:create_random_fact/1,O),show_call_failure(O=(:-multifile user:create_random_fact/1)))).

tCol(tPred).
prologHybrid(isa/2).

%mpred_online:semweb_startup:- with_no_term_expansions(if_file_exists(user:ensure_loaded(logicmoo(dbase/mpred_i_rdf_store)))).

% :- with_no_term_expansions(if_file_exists(user:ensure_loaded(logicmoo(mobs/planner/mpred_i_hyhtn)))).
tCol(predIsFlag).
tCol(prologDynamic).
prologHybrid(formatted_resultIsa/2).
prologHybrid(resultIsa/2).


% :- sanity(test_expand_units(tCol(_A))).

% :- sanity(test_expand_units(number(_A))).

:- sanity((writeq(tCol(_A)),nl)).


tCol(vtTestType).

:- must(must_compile_special_clause(vtTestType(vTest1))).

vtTestType(vTest1).
vtTestType(vTest2).

%:-must(not(tPred(prologHybrid))).
% prologHybrid(function_corisponding_predicate(tFunction,tPred)).

:- sanity(tCol(tCol)).

:- must(agenda_rescan_for_module_ready).

:- must(must_compile_special_clause(tCol(tCol))).

:- must(must_compile_special_clause(isa(_,_))).
:- must(must_compile_special_clause(not(_))).

:- show_call(source_location(_,_)).

:-must(in_file_expansion;in_file_directive).







%((relationMostInstance(Pred,Type,Value),{G=..[Pred,Inst,Value],GI=..[Pred,Inst,_]})) => (({GI=..[Pred,Inst,_]},isa(Inst,Type), ~GI) => G ).
((relationAllInstance(Pred,Type,Value),{G=..[Pred,Inst,Value]})) =>  ((isa(Inst,Type), {G=..[Pred,Inst,Value]} => G )).
relationMostInstance(Pred,Type,Value),{G=..[Pred,Inst,Value]} => pfc_default(isa(Inst,Type) => G).
% relationMostInstance(Pred,Type,Value) => pfc_default( isa(Inst,Type) => ?Pred(Inst,Value) ).




pfc_default(((clause_asserted(argIsa(Pred,N,FT))/ground(argIsa(Pred,N,FT)),ttFormatType(FT))=>argQuotedIsa(Pred,N,FT))).
pfc_default(((genlPreds(Child,Parent),argIsa(Parent,N,FT))=>argIsa(Child,N,FT))).
pfc_default(((genlPreds(Child,Parent),argQuotedIsa(Parent,N,FT)/ground(argIsa(Parent,N,FT)))=>argQuotedIsa(Child,N,FT))).




makeArgConstraint(I,TCol)=>{
     concat_atom([result,I],'',ResultIsa),pfc_add(argIsa(ResultIsa,1,tFunction)),pfc_add(argIsa(ResultIsa,2,TCol)),
     concat_atom([arg,I],'',ArgIsa),pfc_add(argIsa(ArgIsa,1,tRelation)),pfc_add(argIsa(ArgIsa,2,ftInt)),pfc_add(argIsa(ArgIsa,3,TCol)),
     doall((between(1,6,N),concat_atom([arg,N,I],'',ArgNIsa),
     pfc_add(argIsa(ArgNIsa,1,tRelation)),pfc_add(argIsa(ArgNIsa,2,TCol)),  
     CArgNIsa =.. [ArgNIsa,Pred,Col],
     CArgIsa =.. [ArgIsa,Pred,N,Col],
     %pfc_add((CArgNIsa<=>CArgIsa)),
     pfc_add_fast(ruleRewrite(CArgNIsa,CArgIsa))
     ))}.

makeArgConstraint('Isa',tCol).
makeArgConstraint('Genl',tCol).
makeArgConstraint('QuotedIsa',ttFormatType).
makeArgConstraint('Format',ftTerm).
makeArgConstraint('SometimesIsa',tCol).


% {Arity=2},arity(Pred,Arity),(argIsa(Pred,Arity,ftInt)/(A=ftInt;A=ftPercent))=>singleValuedInArg(Pred,Arity).
((arity(Pred,2),argIsa(Pred,2,ftInt))=>singleValuedInArg(Pred,2)).
((arity(Pred,2),argIsa(Pred,2,ftPercent))=>singleValuedInArg(Pred,2)).

:-ensure_loaded('zenls.pfct').

dif_in_arg(P,N,Q):- cwc, ground(P),P=..[F|ARGS],arg(N,P,B),Q=..[F|ARGS],nb_setarg(N,Q,A),dif(A,B).

/*
(  (P/ground(P),
   {get_functor(P,F,A)},
   singleValuedInArg(F,N),
   {dif_in_arg(P,N,Q)},
   Q)
   => \+ Q ).

*/

/*
(singleValuedInArg(F,N),arity(F,A),{integer(A),integer(N),atom(F),functor(P,F,A),functor(Q,F,A)} => 
 ( (P/dif_in_arg(P,N,Q),Q) => \+ Q )).


((arity(Pred,Arity),singleValuedInArg(Pred,SV),
  {functor(Before,Pred,Arity),arg(SV,Before,B),replace_arg(Before,SV,A,After)})
  =>
   ((After,{dif:dif(B,A),clause_asserted(Before), B\==A,\+ is_relative(B),\+ is_relative(A)}) 
     =>
      {pfc_rem2a(Before)})).


(singleValuedInArg(F,N),arity(F,A),{ground(F+N+A),functor(P,F,A),arg(N,P,B),replace_arg(P,N,E,Q)} => 
  (P => {pfc_add_fire_once(Q=>({pfc_rem2a(P)} , Q)))).

 (singleValuedInArg(F,N),arity(F,A),{ground(F+N+A),functor(P,F,A),arg(N,P,B),replace_arg(P,N,E,Q)} => 
  ((P/(dif(E,B),\+ is_relative(B),Q))=> ({pfc_rem2a(Q)},P))).

((singleValuedInArg(F,N),arity(F,A),{ground(F+N+A),functor(P,F,A),arg(N,P,B),replace_arg(P,N,E,Q)}) => 
 (((P/(\+ is_relative(B)))=> ({dif(E,B),forall(Q,pfc_rem2a(Q))}, (\+ Q) ,P)))).


:-pfc_add((((singleValuedInArg(F,N),arity(F,A),{ground(F+N+A),functor(P,F,A),functor(Q,F,A),arg(N,P,B),P=Q,nb_setarg(N,Q,E)})
 => 
 {show_call(pfc_add(((P/(\+ is_relative(B)) => {forall((Q,B\=E),retract(Q))}))))}))).



:-pfc_add((((singleValuedInArg(F,N),arity(F,A),{ground(F+N+A),functor(P,F,A),functor(Q,F,A),arg(N,P,B),P=Q,nb_setarg(N,Q,E)})
 => 
 {show_call(pfc_add(((P/(\+ is_relative(B)) => {forall((Q,B\=E),retract(Q))}))))}))).


:-pfc_add((((singleValuedInArg(F,N),arity(F,A),{ground(F+N+A),functor(P,F,A),arg(N,P,UPDATE),replace_arg(P,N,OLD,Q)})
 => 
 {show_call(pfc_add((P => {(is_relative(UPDATE)->
     must_det_l((Q,update_value(OLD,UPDATE,NEW),\+ is_relative(NEW), replace_arg(Q,N,NEW,R),retract(Q),retract(P),pfc_add(R)));
     forall((Q,UPDATE\=OLD),retract(Q)))})))}))).


*/

:-pfc_add((((singleValuedInArg(F,N),arity(F,A),{ground(F+N+A),functor(P,F,A)})
 => (P => {update_single_valued_arg(P,N)})))).


:-include('singleValued.pfct').

:- listing(_=>_).


end_of_file.



sane_transitivity(_PredInfo,I,Sub,Super):-  
% (I=Super->trace_or_throw(sane_transitivity(PredInfo,I,Sub,Super));true),
%  sanity(I=Sub->trace_or_throw(sane_transitivity(PredInfo,I,Sub,Super));true),
%  sanity(Sub=Super->trace_or_throw(sane_transitivity(PredInfo,I,Sub,Super));true),
  \=(I,Super),\=(Sub,Super),\=(I,Sub),
  \+(isa(Super,ttNonGenled)),
  \+(isa(I,ttNonGenled)).

(genls(I,Sub),genls(Sub, Super),{sane_transitivity((genls(I,Sub),genls(Sub, Super)),I,Sub,Super)}) => genls(I,Super).










tCol(tFly).

(mpred_prop(_,meta_argtypes(ArgTypes)),{is_declarations(ArgTypes)}) =>  meta_argtypes(ArgTypes).



a=>b.
b=>c.
c=>a.


jj=>jj.


% completeExtentAsserted(genls)



implies(and(resultIsaArg('$VAR'('FUNC'), 5), arg5Genl('$VAR'('FUNC'), '$VAR'('COL'))), resultIsa('$VAR'('FUNC'), '$VAR'('COL'))).




dividesBetween(tTemporalThing,tMassfull,tMassless).
dividesBetween(tObj,tMassfull,tMassless).

((dividesBetween(S,C1,C2),{ground(S:C1:C2)}) => ({ground(S:C1:C2)},(disjointWith(C1,C2) , genls(C1,S) ,genls(C2,S)))).

isa(Col1, ttObjectType) => ~isa(Col1, ttFormatType).

(neg(isa(I,Super)) <= (disjointWith(Sub, Super),isa(I,Sub))).
% disjointWith(P1,P2) => {\+(isa(P1,ttNonGenled)),\+(isa(P2,ttNonGenled))},(neg(isa(C,P1)) <=> isa(C,P2)).

tCol(tCol).
tCol(tPred).
tCol(tFunction).
tCol(tRelation).
tCol(ttTemporalType).
tCol(ttFormatType).
/*

% this isn't written yet.
resolveConflict(C) :- dtrace,
  format("~NHalting with conflict ~w", [C]),
  pfc_halt.


% a conflict triggers a Prolog action to resolve it.
conflict(C) => {resolveConflict(C)}.

% meta rules to schedule inferencing.

% resolve conflicts asap
pfc_select(conflict(X),S) :- pfc_queue(conflict(X),S).
  
% a pretty basic conflict.
((neg(P), P ) => conflict(P)).

*/

tCol(tFly).
tCol(tCanary).
tCol(tPenguin).
tCol(tBird).
genls(tCanary,tBird).
genls(tPenguin,tBird).
%(isa(A, tBird) =>isa(A, tFly)).
%(isa(A, tBird), ~neg(isa(A, tFly))=>isa(A, tFly)).

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % These next two have been comnbined with the two following % % %
(((pfc_default(P)/pfc_literal(P))  =>  (~neg(P) => P))).
((pfc_default((P => Q))/pfc_literal(Q) => (P, ~neg(Q) => Q))).


%((pfc_default(P)/pfc_literal(P), {pfcVerifyMissing(P,F)})) =>  ((F, ~neg(P)) => P).
%((pfc_default((P => Q))/pfc_literal(Q), {pfcVerifyMissing(Q,F)})) => ((P, F, ~neg(Q)) => Q).
% % % 
(pfc_default((Q <= P))/pfc_literal(Q)) => (Q <=(P, ~neg(Q))).
%(pfc_default((P => Q))/pfc_literal(Q)) => (Q <=(P, ~neg(Q))).
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

neg(P) <= {pfcVerifyMissing(P,F,Test)},Test,{F\=P}.

% is this how to define constraints?
either(P,Q) => (neg(P) => Q), (neg(Q) => P).
% (P,Q => false) => (P => neg(Q)), (Q => neg(P)).

% rembmer the tCol rule points to isa/2
% tCol(C)=>{atom(C),P=..[C,I],assertz_if_new((P:-infoF(isa(I,C)))),assertz_if_new((P:-isa(I,C)))}.

tCol(C)=> {atom(C),P=..[C,I],assertz_if_new((P:-infoF(isa(I,C)))),assertz_if_new((isa(I,C):-no_repeats(P)))}.
% isa(I,C):- tCol(C),{append_term(C,I,G)},(G/current_predicate(_,G)).
% isa(I,C):- no_repeats((no_repeats(tCol(C)),append_term(C,I,G),current_predicate(_,G),G)).

prologHybrid((zDefault/1,tPenguin/1,tFly/1,tBird/1,tCanary/1)).

'UnaryPredicate'(Pred)<=>(arity(Pred,1),tPred(Pred)).

'UnaryPredicate'(zDefault).
((zDefault(P/pfc_literal(P)))  =>  (~neg(P) => P)).
zDefault((P => Q))/pfc_literal(Q) => ((P, ~neg(Q) => Q)).
%zDefault((P => Q))/pfc_literal(Q) => (Q <=(P, ~neg(Q))).
%zDefault((Q <= P))/pfc_literal(Q) => (Q <=(P, ~neg(Q))).

% birds fly by default.
zDefault((tBird(X) => tFly(X))).

% here's one way to do an isa hierarchy.
% genlPreds = subclass.

/*
(genlPreds(C1,C2),arity(C1,2)) =>
  {P1 =.. [C1,X,Y],
    P2 =.. [C2,X,Y]},
  (P1 => P2).

(genlPreds(C1,C2),arity(C1,3)) =>
  {P1 =.. [C1,X,Y,Z],
    P2 =.. [C2,X,Y,Z]},
  (P1 => P2).
*/



(zenlPreds(C1,C2)) =>
  {P1 =.. [C1,X],
    P2 =.. [C2,X]},
  (P1 => P2).


zenlPreds(tCanary,tBird).
zenlPreds(tPenguin,tBird).

% penguins do neg fly.
tPenguin(X) => neg(tFly(X)).

% chilly is a penguin.
tPenguin(iChilly).

% tweety is a canary.
tCanary(iTweety).


% birds fly by default.
(pfc_default(( tBird(X) => tFly(X)))).


tCol(tFly).
tCol(tCanary).
tCol(tPenguin).
tCol(tBird).

% => genls(tBird,tFly).


% penguins do neg tFly.
tPenguin(X) => neg(tFly(X)).

% iChilly is a tPenguin.
((=> tPenguin(iChilly))).

% iTweety is a tCanary.
((=> tCanary(iTweety))).

:-must(in_file_expansion;in_file_directive).

:-listing(tBird).
:-listing(tFly).



end_of_file.


:-dynamic((fly/1,bird/1,penguin/1,canary/1)).


% birds fly by default.
(pfc_default((bird(X) => fly(X)))).

% heres one way to do an subclass hierarchy.

(((genls_test(C1,C2) =>
  {P1 =.. [C1,X],
    P2 =.. [C2,X]},
  (P1 => P2)))).

(genls_test(canary,bird)).
(genls_test(penguin,bird)).

% penguins do neg fly.
(penguin(X) => neg(fly(X))).

% chilly is a penguin.
(penguin(chilly)).

% tweety is a canary.
(canary(tweety)).

:-listing([fly/1,bird/1,penguin/1,canary/1]).

:-ignore(show_call_failure(fly(tweety))).

/*

 the CycL language extends Prolog's first order logic capabilities with some higher order logics.  
 It also extrends prolog to show proofs.. one issue is the CycL language never signed up for cuts or other execution  orders.    
 PrologMUD extends the CycL language to allow preset program flow (unless a predicate is declared to not honor order of execution 
  (this is usually best!)).  PrologMUD  implements a new design of the cyc canonicalizer..   

 usually in Cyc the rules "(implies (and Axy Byz) (and Cwxyz Dwx))" are converted to DNF (Correct me if I am wrong.. 
 since i have heard it uses ConjectiveNormalForm as well) ... the DNF generates Clausal forms..  The forms choosen 



?-  kif_to_boxlog(((parent('$VAR'('G'),'$VAR'('P')) & parent('$VAR'('P'),'$VAR'('C'))) => grandparent('$VAR'('G'),'$VAR'('C'))),O). 

O = [ (-parent(G, P):- -grandparent(G, C), parent(P, C)), 
      (-parent(P, C):- -grandparent(G, C), parent(G, P)), 
      (grandparent(G, C):-parent(G, P), parent(P, C))].


?- kif_to_boxlog( (grandparent('$VAR'('G'),'$VAR'('C')) => exists('$VAR'('P'), (parent('$VAR'('G'),'$VAR'('P')) & parent('$VAR'('P'),'$VAR'('C'))))),O).

    (-grandparent(G, C):- mudEquals(P, skUnkArg2OfParentArg1OfFn(KB, C, G)), (-parent(G, P) ; -parent(P, C))),   % You have proven G is not the grandparent of C when you have proven tha G has no children or that C has no parents
    (-mudEquals(P, skUnkArg2OfParentArg1OfFn(KB, C, G)):- grandparent(G, C), (-parent(G, P) ; -parent(P, C))), 
    (parent(G, P):-grandparent(G, C), mudEquals(P, skUnkArg2OfParentArg1OfFn(KB, C, G))), % if you prove G is grandparent of P somehow, you will have proved that G is parent to  parentOf P
    (parent(P, C):-grandparent(G, C), mudEquals(P, skUnkArg2OfParentArg1OfFn(KB, C, G))),
    (mudEquals(P, skUnkArg2OfParentArg1OfFn(KB, C, G)):- grandparent(G, C),  \+ (parent(G, P) , parent(P, C)))]  % We failed to find a true P


O = [ 
      (-grandparent(G, P):- -parent(G, _P) ; -parent(_P, P)),    
      parent(G, P):- grandparent(G, C), parent(P,C),   % if you prove G is grandparent of P somehow, you will have proved that G is parent to  parentOf P
      parent(P, C):- grandparent(G, C), parent(G,P))].   % if you prove G is grandparent of P somehow, you will have proved that G is parent to  parentOf P

*/



/*

genls(_Sub, Super) => tCol(Super).
genls(Sub, _Super) => tCol(Sub).
% use backchain instead (isa(I,Sub), disjointWith(Sub, Super)) => neg(isa(I,Super)).

*/

:- must_det(argIsa(genlPreds,2,_Type)).


% Hook a predicate up!
/*
(tinyInstallToAssertedEL(F,A) => ({current_predicate(make_el_stub/4),functor(H,F,A),make_el_stub(H,_,_,B)},(H<=B))).

((tinyPredTypeActive(PREDTYPE),isa(F,PREDTYPE)) => tinyPredActive(F)).

((tinyPredActive(F),arity(F,A))=>tinyInstallToAssertedEL(F,A)).

=>tinyPredActive(isa).
=>tinyPredActive(genls).
=>tinyPredActive(arity).
=>tinyInstallToAssertedEL(afterAdding,2).

=>tinyPredTypeActive('WFFConstraintSatisfactionPredicate').
=>tinyPredTypeActive('WFFConstraintPredicate').
=>tinyPredTypeActive('WFFSupportedPredicate').

=>tinyPredActive(afterRemoving).
=>tinyPredActive(afterAdding).

% argQuotedIsa(Pred, N, FT) <=  (argIsa(Pred, N, Type),genls(Type,FT),ttFormatType(FT)).

% consistent(CycL) <= cycLToMpred(neg(CycL),Consequent),not(pfcCall(Consequent)). 

=>tinyPredTypeActive('expansion').
=>tinyPredTypeActive('collectionExpansion').
(isa(F,tPred),arity(F,A),{once((tinyAssertion0(DB,MT,STR),arg(1,DB,F),atom(F)))})=>tinyInstallToAssertedEL(F,A).
*/

argQuotedIsa(sentenceTruth,1,'CycLSentence-Assertible').
:- pfc_add(((collectionExpansion(COL,RULE),isa(PRED,COL),{subst(RULE,':ARG1',PRED,NEWRULE)}) => trueSentence(NEWRULE))).
:- pfc_add(((expansion(F,RULE),arity(F,A),{make_kw_functor(F,A,CYCL),kw_to_vars((CYCL<=>RULE),NEWRULE)}) => trueSentence(NEWRULE))).

nearestIsa(I,C) <= is_user_supported(isa(I,C)).
nearestGenls(I,C) <= is_user_supported(genls(I,C)).


% meta_argtypes(ArgTypes)/is_declarations(ArgTypes) => {wdmsg(in_loop(meta_argtypes))},meta_argtypes(ArgTypes).
tRelation(ArgTypes)/is_declarations(ArgTypes) => meta_argtypes(ArgTypes).
:- pfc_add(((isa(Compound,prologMacroHead)/compound_functor(Compound,F)) => functorDeclares(F))).
(ttFormatType(FT)/is_declarations(FT))=>meta_argtypes(FT).

:- show_call(source_location(_,_)).

:- must(in_file_expansion;in_file_directive).


end_of_file.

%(exactlyAssertedSentence(CycL), is_simple_gaf(CycL)) => ({cycAdd(CycL)},CycL).
%(exactlyAssertedSentence(CycL), needs_indexing(CycL)) => assertedSentence(CycL).
%(exactlyAssertedSentence(CycL), needs_canoncalization(CycL)) => trueSentence(CycL).
%:- prolog.
assertedSentence(CycL) => ({ sent_to_conseq(CycL,Consequent) }, Consequent).
trueSentence(CycL) => ({ sent_to_conseq(CycL,Consequent) }, Consequent).


% :- pfc_add(((isa(Compound,prologMacroHead)/compound_functor(Compound,F)) => functorDeclares(F))).
% :- rtrace,pfc_add((isa(_,ArgsIsa)=>tCol(ArgsIsa))).




% (typeProps(Type,Props)=>(tSet(Type),((isa(I,Type)=>props(I,Props))))).


% props(I,Props)/(ground(I:Props),as_list(Props,PList))=>pfc_assert(props(I,isEach(PList))).

))).

.

