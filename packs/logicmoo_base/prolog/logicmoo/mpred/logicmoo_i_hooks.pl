/** <module> 
% ===================================================================
% File 'mpred_db_preds.pl'
% Purpose: Emulation of OpenCyc for SWI-Prolog
% Maintainer: Douglas Miles
% Contact: $Author: dmiles $@users.sourceforge.net ;
% Version: 'interface.pl' 1.0.0
% Revision:  $Revision: 1.9 $
% Revised At:   $Date: 2002/06/27 14:13:20 $
% ===================================================================
% File used as storage place for all predicates which change as
% the world is run.
%
%
% Dec 13, 2035
% Douglas Miles
*/

% :- registerCycPredPlus2([genlPreds/4,genlInverse/4,localityOfObject/4]).

% ========================================
% Logic Preds Shared
% ========================================

:-export(is_svo_functor/1).
is_svo_functor(Prop):- hotrace((atom(Prop),arg(_,svo(svo,prop,valueOf,rdf),Prop))).

:-export(hilog_functor/1).
hilog_functor(mpred_ttttt).

:-export(is_holds_true_not_hilog/1).
is_holds_true_not_hilog(HOFDS):-is_holds_true(HOFDS),\+ hilog_functor(HOFDS).

:-export(is_holds_true/1).
is_holds_true(Prop):- hotrace((atom(Prop),is_holds_true0(Prop))),!.

% k,p,..
is_holds_true0(Prop):-arg(_,vvv(holds,holds_t,t,t,asserted_mpred_t,assertion_t,assertion,secondOrder,firstOrder),Prop).
is_holds_true0(Prop):-atom_concat(_,'_t',Prop).

:-export(is_2nd_order_holds/1).
is_2nd_order_holds(Prop):- is_holds_true(Prop) ; is_holds_false(Prop).

:-export(is_holds_false/1).
is_holds_false(Prop):-hotrace((atom(Prop),is_holds_false0(Prop))).

is_holds_false0(Prop):-member(Prop,[not,nholds,holds_f,mpred_f,aint,assertion_f,asserted_mpred_f,retraction,not_secondOrder,not_firstOrder]).
is_holds_false0(Prop,Stem):-atom_concat('not_',Stem,Prop).
is_holds_false0(Prop,Stem):-atom_concat('int_not_',Stem,Prop).
is_holds_false0(Prop,Stem):-atom_concat(Stem,'_f',Prop).
%is_holds_false0(Prop):-is_holds_false0(Prop,Stem),is_holds_true0(Stem).
%is_holds_false0(Prop,Stem):-atom_concat(Stem,'_not',Prop).
%is_holds_false0(Prop,Stem):-atom_concat(Stem,'_false',Prop).


:- thread_local thlocal:override_hilog/1.

current_hilog(Dbase_t):- thlocal:override_hilog(Dbase_t),!.
current_hilog(t).


% ===================================================================
% EXPORTS
% ===================================================================
isNonVar(Denotation):-not(isSlot(Denotation)).

% ===============================================================================================
% ===============================================================================================

:-if(\+ current_predicate(isSlot/1)).
isSlot(Denotation):-((isVarProlog(Denotation);isVarObject(Denotation))),!.
:-endif.

isSlot(Denotation,Denotation):- isVarProlog(Denotation),!.
isSlot(Denotation,PrologVar):- isVarObject(Denotation,PrologVar),!.

% ===============================================================================================
% ===============================================================================================

isHiddenSlot(Term):-fail.

% ===============================================================================================
% ===============================================================================================

isVarProlog(A):-((var(A);A='$VAR'(_))).

% ===============================================================================================
% ===============================================================================================

isVarObject(Denotation):-((
		  isObject(Denotation,BaseType),
		  arg(1,Denotation,Value),!,isSlot(Value))).

isVarObject(Denotation,Value):-((
		  isObject(Denotation,BaseType),
		  arg(1,Denotation,Value),!,isSlot(Value))).

% ===============================================================================================
% ===============================================================================================
	
isObject(Denotation,BaseType):-
	(((atom(BaseType) ->
		  (atom_concat('$',BaseType,F),functor(Denotation,F,2));
		  (functor(Denotation,F,2),atom_concat('$',BaseType,F))
		 ),!)).

% ===============================================================================================
% ===============================================================================================

isQualifiableAsClass(Atom):-atom(Atom),!.
isQualifiableAsClass('$Class'(Atom,_)):-atom(Atom),!.

isQualifiableAs(Denotation,BaseType,Value):-
		  isObject(Denotation,BaseType),
		  arg(1,Denotation,Value).

% ===============================================================================================
% ===============================================================================================

isQualifiedAs(Denotation,_,_):-not(compound(Denotation)),!,fail.
isQualifiedAs(Denotation,BaseType,Value):-
		  isQualifiedAs(Denotation,BaseType,Value,SubType).
isQualifiedAs(Denotation,BaseType,Value,SubType):-
		  isObject(Denotation,BaseType),
		  arg(1,Denotation,Value),
		  arg(2,Denotation,List),
		  lastImproperMember(BaseType,SubType,List).

% ===============================================================================================
% ===============================================================================================

lastImproperMember(Default,Default,List):-isVarProlog(List),!.
lastImproperMember(Default,Default,[]):-!.
lastImproperMember(Default,SubType,List):-proper_lst(List),last(SubType,List).
lastImproperMember(Default,SubType,[SubType|End]):-isVarProlog(End),!.
lastImproperMember(Default,SubType,[_|Rest]):-
	lastImproperMember(Default,SubType,Rest),!.
	
% ===============================================================================================
% ===============================================================================================

isQualifiedAndKnownAs(Denotation,BaseType,Value):-
		  isQualifiedAs(Denotation,BaseType,Value),!,
		  not(isVarProlog(Value)).

% ===============================================================================================
% ===============================================================================================

isQualifiedAndVarAs(Denotation,BaseType,Value):-
		  isQualifiedAs(Denotation,BaseType,Value),!,
		  isVarProlog(Value).

% ===============================================================================================
% ===============================================================================================

isQualifiedAndVarAndUnifiable(Denotation,BaseType,NValue):-
		  isQualifiedAs(Denotation,BaseType,Value),!,
		  (isVarProlog(Value);
		  (\+ \+ NValue=Value)),!.

% ===============================================================================================
% ===============================================================================================

isBodyConnective(Funct):-atom_concat(_,'_',Funct),!.
isBodyConnective(Funct):-atom_concat('t~',_,Funct),!.
isBodyConnective(Funct):-atom_concat('f~',_,Funct),!.
isBodyConnective(Funct):-member(Funct,[and,or,until,',',';',':-',unless,xor,holdsDuring]). % Other Propositional Wrhtml_appers

isEntityref(Var,Var):-isSlot(Var),!.
isEntityref(Term,A):-Term=..[F,A,B],!,atom_concat('$',_,F),!.


% ===============================================================================================
% ===============================================================================================

isLiteralTerm(A):-isLiteralTerm_util(A),!.
isLiteralTerm(not(A)):-isLiteralTerm_util(A),!.

isLiteralTerm_util(A):-var(A),!.
isLiteralTerm_util('$VAR'(_)):-!.
isLiteralTerm_util(string(_)):-!.
isLiteralTerm_util(A):-not(compound(A)),!.
isLiteralTerm_util(A):-string(A).

% ===============================================================================================
% ===============================================================================================

isEntitySlot(Term):-isSlot(Term),!.
isEntitySlot(Term):-not(compound(Term)),!.
isEntitySlot(Term):-isEntityFunction(Term,FnT,ArgsT),!.

% ===============================================================================================
% ===============================================================================================

isEntityFunction(Term,FnT,ArgsT):-isSlot(Term),!,fail.
isEntityFunction(Term,FnT,ArgsT):-atomic(Term),!,fail.
isEntityFunction(Term,FnT,ArgsT):-Term=..[FnT|ArgsT],hlPredicateAttribute(FnT,'Function'),!.

% ===============================================================================================
% ===============================================================================================

isNonCompound(Var):-isSlot(Var),!.
isNonCompound(Var):-not(compound(Var)),!.
isNonCompound(svar(_,_)):-!.
isNonCompound(Var):-is_string(Var),!.
isNonCompound(string(Var)):-!.

% ===============================================================================================
% ===============================================================================================

logical_functor_ft(F):-is_logical_functor(F).
logical_functor_ft((':-')).
logical_functor_ft((',')).

% ===============================================================================================
% ===============================================================================================

:- dynamic(non_assertable/1).
non_assertable(WW,isVar(WW)):- var(WW),!.
non_assertable(_:WW,Why):- !,non_assertable(WW,Why).
non_assertable(WW,notAssertable(Why)):- compound(WW),get_functor(WW,F),user:mpred_prop(F,notAssertable(Why)),!.
% non_assertable(WW,Why):- db_prop_add

% ===============================================================================================
% ===============================================================================================

is_logical_functor(And):-hotrace(is_logical_functor0(And)).
is_logical_functor0(X):-atom(X),member(X,[',',';',xor,'\\+',neg]).
is_logical_functor0(X):-call_if_defined(logical_functor_pttp(X)).
is_logical_functor0(And):-member(And,[(,),(;),('<='),('=>'),('<=>'),(':-'),(and),nop]).

% ===============================================================================================
% ===============================================================================================


correct_negations(Op,(~({X})),O):-nonvar(X),wrap_in_neg_functor(Op,X,O).
correct_negations(Op,(-({X})),O):-nonvar(X),wrap_in_neg_functor(Op,X,O).
correct_negations(Op,(not({X})),O):-nonvar(X),wrap_in_neg_functor(Op,X,O).
correct_negations(Op,(notz({X})),O):-nonvar(X),wrap_in_neg_functor(Op,X,O).
correct_negations(Op,(assertable_not({X})),O):-nonvar(X),wrap_in_neg_functor(Op,X,O).
correct_negations(Op,(\+({X})),O):-nonvar(X),wrap_in_neg_functor(Op,X,O).

wrap_in_neg_functor(clause,X,assertable_neg(X)).
wrap_in_neg_functor(mpred,X,not(X)).
wrap_in_neg_functor(callable,X, (\+(X))).


:-export(infix_op/2).
infix_op(Op,_):-comparitiveOp(Op).
infix_op(Op,_):-additiveOp(Op).

:-export(comparitiveOp/1).
comparitiveOp((\=)).
comparitiveOp((\==)).
comparitiveOp((=)).
comparitiveOp((=:=)).
comparitiveOp((==)).
comparitiveOp((<)).
comparitiveOp((>)).
comparitiveOp((=<)).
comparitiveOp((>=)).

:-export(additiveOp/1).
additiveOp((is)).
additiveOp((*)).
additiveOp(+).
additiveOp(-).
additiveOp((/)).






/** <module> logicmoo_i_mpred_mpred_t
% Provides a prolog dabase in these predicates...
%
%  t/N
%  hybridRule/2
%  
%
% Logicmoo Project PrologMUD: A MUD server written in Prolog
% Maintainer: Douglas Miles
% Dec 13, 2035
%
*/

:- include(logicmoo_i_header).


:- meta_predicate(tf_result(0,+)).
tf_result(Call,TF):-(Call->TF=true;TF=fail).
:- meta_predicate(if_result(0,0)).
if_result(TF,Call):-(TF->Call;true).



% ========================================
% is_holds_true/is_holds_false
% ========================================


:-export(into_plist/2).
into_plist(In,Out):-into_plist_arities(2,12,In,Out).

:-export(into_plist_arities/4).
into_plist_arities(Min,Max,PLIST,PLISTO):- var(PLIST),!,between(Min,Max,X),length(PLIST,X),PLISTO=PLIST.
into_plist_arities(_,_,[P|LIST],[P|LIST]):-var(P),!.
into_plist_arities(_,_,[t|PLIST],PLIST):-!.  % t is our versuion of '$holds' or call/N
into_plist_arities(_,_,plist(P,LIST),[P|LIST]):-!.
into_plist_arities(_,_,Call,PLIST):-Call=..PLIST. % finally the fallthrue


never_mpred_mpred(user:mpred_prop).
never_mpred_mpred(isa).
never_mpred_mpred(arity).


% ================================================================================
% begin holds_t
% ================================================================================

:-dynamic t/2.
% t(C,I):- trace_or_throw(t(C,I)),t(C,I). % ,fail,loop_check_term(isa_backchaing(I,C),t(C,I),fail).
t(X,Y):-isa(Y,X).

%t([P|LIST]):- !,mpred_plist_t(P,LIST).
%t(naf(CALL)):-!,not(t(CALL)).
%t(not(CALL)):-!,mpred_f(CALL).
t(CALL):- into_plist_arities(3,10,CALL,[P|LIST]),mpred_plist_t(P,LIST).
mpred_plist_t(P,[]):-!,t(P).
mpred_plist_t(P,LIST):-var(P),!,is_list(LIST),CALL=..[t,P|LIST],debugOnError((CALL)).
mpred_plist_t(t,[P|LIST]):-!, mpred_plist_t(P,LIST).
mpred_plist_t(user:mpred_prop,[C,A,I]):-!,ground(I:C),user:mpred_prop(C,I).
mpred_plist_t(isa,[I,C]):-!,t(C,I).
mpred_plist_t(P,_):-never_mpred_mpred(P),!,fail.
mpred_plist_t(P,[L|IST]):-is_holds_true(P),!,mpred_plist_t(L,IST).
mpred_plist_t(P,LIST):-is_holds_false(P),!,mpred_f(LIST).
mpred_plist_t(P,LIST):- CALL=..[t,P|LIST],debugOnError(CALL).

:-meta_predicate(loop_check_mpred(?)).
% loop_check_mpred(Call):- current_predicate(ireq/1), loop_check_term(ireq(Call),loop_check_mpred(Call),fail).
loop_check_mpred(Call):- !, fail,not(thlocal:infInstanceOnly(_)),loop_check(ireq(Call),loop_check_mpred(Call),fail).
% loop_check_mpred(Call):-loop_check(mpred_call(t,Call),fail).

:-meta_predicate(mpred_pa_call(?,?,0)).
:-meta_predicate(t(?,?,?,?,?)).
:-meta_predicate(t(?,?,?,?)).
:-meta_predicate(t(?,?,?)).

t(P,A1,A2):- mpred_pa_call(P,2,call(P,A1,A2)).
t(P,A1,A2):- loop_check_mpred(t(P,A1,A2)).
t(P,A1,A2,A3):- mpred_pa_call(P,3,call(P,A1,A2,A3)).
t(P,A1,A2,A3):- loop_check_mpred(t(P,A1,A2,A3)).
t(P,A1,A2,A3,A4):- mpred_pa_call(P,4,call(P,A1,A2,A3,A4)).
t(P,A1,A2,A3,A4):- loop_check_mpred(t(P,A1,A2,A3,A4)).
t(P,A1,A2,A3,A4,A5):- mpred_pa_call(P,5,call(P,A1,A2,A3,A4,A5)).
t(P,A1,A2,A3,A4,A5):- loop_check_mpred(t(P,A1,A2,A3,A4,A5)).
t(P,A1,A2,A3,A4,A5,A6):- mpred_pa_call(P,6,call(P,A1,A2,A3,A4,A5,A6)).
t(P,A1,A2,A3,A4,A5,A6):- loop_check_mpred(t(P,A1,A2,A3,A4,A5,A6)).
t(P,A1,A2,A3,A4,A5,A6,A7):- mpred_pa_call(P,7,call(P,A1,A2,A3,A4,A5,A6,A7)).
t(P,A1,A2,A3,A4,A5,A6,A7):- loop_check_mpred(t(P,A1,A2,A3,A4,A5,A6,A7)).

mpred_pa_call(F,A,Call):-M=user,var(F),!,arity(F,A),\+tNotForUnboundPredicates(F),M:current_predicate(F/A),debugOnError(M:Call).
mpred_pa_call(F,A,Call):-M=user,arity(F,A),M:current_predicate(F/A),M:Call.

mpred_fact_arity(F,A):-arity(F,A),once(mpred_prop(F,prologHybrid);mpred_prop(F,pfcControlled);mpred_prop(F,prologPTTP);mpred_prop(F,prologSNARK)).

prologHybridFact(G):- (var(G)->(mpred_fact_arity(F,A),functor(G,F,A));true),into_mpred_form(G,M),!,no_repeats(mpred_call(M)).

isCycPredArity_ignoreable(F,A):- ignore(user:mpred_prop(F,cycPred(A))),ignore(arity(F,A)).

which_t(dac(d,a_notnow,c,no_fallback)).

holds_t(P,A1,A2,A3,A4,A5,A6,A7):- isCycPredArity_ignoreable(P,7),which_t(DBS),(call_which_t(DBS,P,A1,A2,A3,A4,A5,A6,A7);call_mt_t(DBS,P,A1,A2,A3,A4,A5,A6,A7,_,_);assertion_t([P,A1,A2,A3,A4,A5,A6,A7])).
holds_t(P,A1,A2,A3,A4,A5,A6):- isCycPredArity_ignoreable(P,6),which_t(DBS),(call_which_t(DBS,P,A1,A2,A3,A4,A5,A6);call_mt_t(DBS,P,A1,A2,A3,A4,A5,A6,_,_)).
holds_t(P,A1,A2,A3,A4,A5):- isCycPredArity_ignoreable(P,5),which_t(DBS),(call_which_t(DBS,P,A1,A2,A3,A4,A5);call_mt_t(DBS,P,A1,A2,A3,A4,A5,_,_)).
holds_t(P,A1,A2,A3,A4):- isCycPredArity_ignoreable(P,4),which_t(DBS),(call_which_t(DBS,P,A1,A2,A3,A4);call_mt_t(DBS,P,A1,A2,A3,A4,_,_)).
holds_t(P,A1,A2,A3):- isCycPredArity_ignoreable(P,3),which_t(DBS),(call_which_t(DBS,P,A1,A2,A3);call_mt_t(DBS,P,A1,A2,A3,_,_)).
%holds_t(P,A1,A2):- hotrace(holds_relaxed_t(P,A1,A2)).
holds_t(P,A1,A2):- isCycPredArity_ignoreable(P,2),which_t(DBS),(call_which_t(DBS,P,A1,A2);call_mt_t(DBS,P,A1,A2,_,_)).
holds_t(P,A1):- isCycPredArity_ignoreable(P,1),which_t(DBS),(call_which_t(DBS,P,A1);call_mt_t(DBS,P,A1,_,_)).


% holds_relaxed_t(P,A1,A2):-var(A1),var(A2),!,t(P,A1,A2).
holds_relaxed_t(P,A1,A2):-
  isCycPredArity_ignoreable(P,2),which_t(DBS),
      relax_term(P,PR,A1,R1,A2,R2),
         holds_relaxed_0_t(DBS,PR,R1,R2).

holds_relaxed_0_t(DBS,P,A1,A2):- call_which_t(DBS,P,A1,A2).
holds_relaxed_0_t(DBS,P,A1,A2):- call_mt_t(DBS,P,A1,A2,_,_).

/*
holds_relaxed_0_t(dac(_,a,_,_),P,A1,A2):- assertion_t([P,A1,A2]).
holds_relaxed_0_t(dac(d,_,_,_),P,A1,A2):- t(P,A1,A2).
holds_relaxed_0_t(dac(_,_,_,h),P,A1,A2):- call_which_t(DBS,P,A1,A2).
holds_relaxed_0_t(DBS,P,A1,A2):- call_mt_t(DBS,P,A1,A2,_,_).
holds_relaxed_0_t(_DBS,P,A1,A2):- ground((P,A1)), TEMPL=..[P,T1,_],t(argSingleValueDefault,TEMPL,2,A2),req(isa(A1,T1)),!.
*/

holds_t([AH,P|LIST]):- is_holds_true(AH),!,holds_plist_t(P,LIST).
holds_t([AH,P|LIST]):- is_holds_false(AH),!,holds_f_p2(P,LIST).
holds_t([P|LIST]):- !,holds_plist_t(P,LIST).
holds_t(not(CALL)):- !, holds_f(CALL).
holds_t(CALL):- '=..'(CALL,PLIST),holds_t(PLIST).

holds_plist_t(P,LIST):- apply(holds_t,[P|LIST]).




% =======================================================
% term utils
% =======================================================

:-export(inverse_args/2).
inverse_args([AR,GS],[GS,AR]):-!.
inverse_args([AR,G,S],[S,G,AR]):-!.
inverse_args([A,R,G,S],[S,R,G,A]):-!.
inverse_args([P,A,R,G,S],[S,A,R,G,P]):-!.

:-export(same_vars/2).
same_vars(T1,T2):-term_variables(T1,V1),term_variables(T2,V2),!,V1==V2.


:-moo_hide_childs(replace_arg/4).
replace_arg(C,A,OLD,CC):- 
   C=..FARGS,
   replace_nth(FARGS,A,OLD,FARGO),!,
   CC=..FARGO.

:-moo_hide_childs(replace_nth/4).
replace_nth([],_,_,[]):- !.
replace_nth([_|ARGO],0,OLD,[OLD|ARGO]):- !.
replace_nth([T|FARGS],A,OLD,[T|FARGO]):- 
    A2 is A-1,replace_nth(FARGS,A2,OLD,FARGO).


replace_nth([],_N,_OldVar,_NewVar,[]):- !,trace_or_throw(missed_the_boat).
replace_nth([OldVar|ARGS],1,OldVar,NewVar,[NewVar|ARGS]):- !.
replace_nth([Carry|ARGS],Which,OldVar,NewVar,[Carry|NEWARGS]):- 
 Which1 is Which-1,
 replace_nth(ARGS,Which1,OldVar,NewVar,NEWARGS),!.


:-moo_hide_childs(update_value/4).
update_value(OLD,NEW,NEXT):- var(NEW),!,trace_or_throw(logicmoo_bug(update_value(OLD,NEW,NEXT))).
update_value(OLD,NEW,NEWV):- var(OLD),!,compute_value_no_dice(NEW,NEWV).
update_value(OLD,X,NEW):- is_list(OLD),!,list_update_op(OLD,X,NEW),!.
update_value(OLDI,+X,NEW):- compute_value(OLDI,OLD),number(OLD),catch(NEW is OLD + X,_,fail),!.
update_value(OLDI,-X,NEW):- compute_value(OLDI,OLD),number(OLD),catch(NEW is OLD - X,_,fail),!.
update_value(OLDI,X,NEW):- number(X),X<0,compute_value(OLDI,OLD),number(OLD),catch(NEW is OLD + X,_,fail),!.
update_value(_,NEW,NEWV):- compute_value_no_dice(NEW,NEWV),!.


list_update_op(OLDI,+X,NEW):-flatten_append(OLDI,X,NEW),!.
list_update_op(OLDI,-X,NEW):-flatten([OLDI],OLD),flatten([X],XX),!,list_difference_eq(OLD,XX,NEW),!.

compute_value_no_dice(NEW,NEW):- compound(NEW),functor_catch(NEW,ftDice,_),!.
compute_value_no_dice(NEW,NEWV):-compute_value(NEW,NEWV).

compute_value(NEW,NEWV):-catch(NEWV is NEW,_,fail),!.
compute_value(NEW,NEWV):-catch(any_to_value(NEW,NEWV),_,fail),!.
compute_value(NEW,NEW).

insert_into(ARGS,0,Insert,[Insert|ARGS]):- !.
insert_into([Carry|ARGS],After,Insert,[Carry|NEWARGS]):- 
   After1 is After - 1,
   insert_into(ARGS,After1,Insert,NEWARGS).


add_arg_parts_of_speech(_F,_N,[],[]).
add_arg_parts_of_speech(F,N,[A|ARGS0],[ARG|ARGS]):-argIsa_call_or_undressed(F,N,A,ARG),N1 is N+1, add_arg_parts_of_speech(F,N1,ARGS0,ARGS).

argIsa_call_or_undressed(F,N,Obj,fN(Obj,Type)):- argIsa_call_0(F,N,Type),!.
argIsa_call_or_undressed(_F,_N,Obj,Obj).

verb_after_arg(_,_,1).


