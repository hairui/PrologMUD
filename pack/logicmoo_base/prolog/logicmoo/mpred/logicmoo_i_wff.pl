/** <module> logicmoo_i_wff
% Provides a common set of operators in translation between the several logical languages
%
% Logicmoo Project PrologMUD: A MUD server written in Prolog
% Maintainer: Douglas Miles
% Dec 13, 2035
%
*/


:- include(logicmoo_i_header).

% ========================================
% Logic Preds Shared
% ========================================

:-export(is_svo_functor/1).
is_svo_functor(Prop):- hotrace((atom(Prop),arg(_,svo(svo,prop,valueOf,rdf),Prop))).

:-export(hilog_functor/1).
hilog_functor(true_t).

:-export(is_holds_true_not_hilog/1).
is_holds_true_not_hilog(HOFDS):-is_holds_true(HOFDS),\+ hilog_functor(HOFDS).

:-export(is_holds_true/1).
is_holds_true(Prop):- hotrace((atom(Prop),is_holds_true0(Prop))),!.

% k,p,..
is_holds_true0(Prop):-arg(_,vvv(holds,holds_t,t,t,asserted_mpred_t,assertion_t,true_t,assertion,secondOrder,firstOrder),Prop).
% is_holds_true0(Prop):-atom_concat(_,'_t',Prop).

:-export(is_2nd_order_holds/1).
is_2nd_order_holds(Prop):- is_holds_true(Prop) ; is_holds_false(Prop).

:-export(is_holds_false/1).
is_holds_false(Prop):-hotrace((atom(Prop),is_holds_false0(Prop))).

is_holds_false0(Prop):-member(Prop,[not,nholds,holds_f,mpred_f,aint,assertion_f,not_true_t,asserted_mpred_f,retraction,not_secondOrder,not_firstOrder]).
%is_holds_false0(Prop,Stem):-atom_concat('not_',Stem,Prop).
%is_holds_false0(Prop,Stem):-atom_concat('int_not_',Stem,Prop).
%is_holds_false0(Prop,Stem):-atom_concat(Stem,'_f',Prop).
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

isHiddenSlot(_Term):-fail.

% ===============================================================================================
% ===============================================================================================

isVarProlog(A):-((var(A);A='$VAR'(_))).

% ===============================================================================================
% ===============================================================================================

isVarObject(Denotation):-((
		  isObject(Denotation,_BaseType),
		  arg(1,Denotation,Value),!,isSlot(Value))).

isVarObject(Denotation,Value):-((
		  isObject(Denotation,_BaseType),
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
		  isQualifiedAs(Denotation,BaseType,Value,_SubType).
isQualifiedAs(Denotation,BaseType,Value,SubType):-
		  isObject(Denotation,BaseType),
		  arg(1,Denotation,Value),
		  arg(2,Denotation,List),
		  lastImproperMember(BaseType,SubType,List).

% ===============================================================================================
% ===============================================================================================
:- style_check(-singleton).

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

is_neg(not(_)).
is_pos(One):- get_functor(One,F),!,not(is_log_op(F)).

:- export(is_log_sent/1).
is_log_sent(S):- get_functor(S,F,_),is_log_op(F).

not_log_op(OP):- not(is_log_op(OP)).
:- export(is_log_op/1).
is_log_op(OP):- atomic(OP),to_dlog_ops(OPS),!,(member(OP=_,OPS);member(_=OP,OPS)).


:- export(defunctionalize/2).
defunctionalize(Wff,WffO):- with_assertions(thlocal:dont_use_mudEquals,defunctionalize(',',Wff,WffO)).
defunctionalize(OP,Wff,WffO):- call_last_is_var(defunctionalize(OP,Wff,WffO)).
defunctionalize(_ ,Wff,Wff):- \+ compound(Wff),!.
defunctionalize(_ ,Wff,Wff):- non_compound(Wff),!.
defunctionalize(_ ,Wff,Wff):- leave_as_is(Wff),!.

defunctionalize(OP,(H:-B),WffO):- thlocal:dont_use_mudEquals,!,
 with_no_assertions(thlocal:dont_use_mudEquals,defunctionalize(OP,(H:-B),WffO)).
defunctionalize(OP,(H:-B),WffO):- !,
  defunctionalize(',',(B=>H),HH),
  (HH=(PreC,(NewBody=>NEWH))-> 
     defunctionalize(OP,(NEWH:not(PreC,NewBody)),WffO);
  (defunctionalize(OP,B,NewBody),WffO=(H:-NewBody))).
  
defunctionalize(OP,Wff,WffO):- 
  each_subterm(Wff,SubTerm),
  compound(SubTerm),
  \+ (is_ftEquality(SubTerm)),
  \+ (leave_as_is(SubTerm)),
  arg(_,SubTerm,Function),is_function(Function),
  subst_except(SubTerm,Function,NewVar,NewSubTerm),
  function_to_predicate(Function,NewVar,PredifiedFunction),
  subst_except(Wff,SubTerm,NewSubTerm,NextWff),!,
  defunctionalize(OP,NextWff,WffM),!,
  WffO=..[OP,PredifiedFunction,WffM].

defunctionalize(OP,Wff,WffO):-
  each_subterm(Wff,SubTerm),
  compound(SubTerm),
  not(is_ftEquality(SubTerm)),
  not(leave_as_is(SubTerm)),
  arg(_,SubTerm,Function),is_function(Function),
  subst_except(SubTerm,Function,NewVar,NewSubTerm),
  function_to_predicate(Function,NewVar,PredifiedFunction),
  NEW =..[OP,PredifiedFunction,NewSubTerm],
  subst_except(Wff,SubTerm,NEW,NextWff),!,
  defunctionalize(OP,NextWff,WffO),!.
defunctionalize(_,Wff,Wff).


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



is_modal(MODAL,_):- \+ compound(MODAL),!,fail.
is_modal(MODAL,BDT):- (MODAL = nesc(BDT,_) ; MODAL = poss(BDT,_)),!,nonvar(BDT).
is_modal(MODAL,BDT):- arg(_,MODAL,ARG),is_modal(ARG,BDT).

contains_var_lits(Fml,Var,Lits):- findall(Lit,contains_t_var(Fml,Var,Lit),Lits).

get_isa(Lit,I,TT):- compound(Lit),get_isa0(Lit,I,TT).
get_isa0(isa(I,T),I,TT):- to_iname(T,TT),!.
get_isa0(IT,I,TT):- IT=..[T,I],is_colection_name(IT,T,TT),!.

is_colection_name(_,-,_):- !,fail.
is_colection_name(IT,T,TT):- atom_length(T,TL),TL>2,not(atom_contains(T,'_')),not(predicate_property(IT,_)),to_iname(T,TT).


is_sentence_functor(&).
is_sentence_functor(v).
is_sentence_functor(exists).
is_sentence_functor(all).


:-dynamic(leave_as_is0/1).
leave_as_is(V):- \+ compound(V),!.
leave_as_is(V):-leave_as_is0(V),!.
leave_as_is0('$VAR'(_)).
leave_as_is0(infer_by(_)).
leave_as_is0(b_d(_,_,_)).
leave_as_is0(ct(_,_)).
% leave_as_is0('CollectionSubsetFn'(_,_)).
leave_as_is0(ignore(_)).
leave_as_is0(z_unused(_)).
leave_as_is0(isa(_,_)).
leave_as_is0({}).
leave_as_is0(kbMark(_)).

leave_as_is0(P):-prequent(P).

prequent(original(_)).
prequent(mudEquals(_,_)).
prequent(skolem(_,_)).
prequent(different(_,_)).
prequent(argInst(_,_,_)).
prequent(G):-functor(G,call_builtin,_).
prequent(G):-functor(G,not_call_builtin,_).

kb_nlit(_KB,Neg):-member(Neg,[(not),(~),(-),(neg)]).

set_is_lit(A):-when(nonvar(A),\+ is_ftVar(A)),!.

non_compound(InOut):- once(not(compound(InOut));is_ftVar(InOut)).

is_gaf(Gaf):-when(nonvar(Gaf),not(is_kif_rule(Gaf))).

:- export(is_kif_rule/1).
is_kif_rule(Var):- is_ftVar(Var),!,fail.
% is_kif_rule(_:- _):- !.
is_kif_rule(R):- get_functor(R,F,A),functor(P,F,A),kif_hook(P),!.


:- export(term_slots/2).
term_slots(Term,Slots):-term_singletons(Term, [],NS, [],S),append(NS,S,Slots).

:- export(term_singletons/2).
term_singletons(A,Vs):- term_singletons(A,[],_,[],Vs). 
:- export(term_singletons/5).
term_singletons(Fml, NS,NS, S,S):- atomic(Fml),!.
term_singletons(Fml, NS,NS, S,S):- identical_member(Fml,NS),!.
term_singletons(Fml, NS, [Fml|NS], S, NSV):- is_ftVar(Fml),identical_member(Fml,S),!,delete_eq(S,Fml,NSV),!.
term_singletons(Fml, NS, NS, S, [Fml|S]):- is_ftVar(Fml),!.
term_singletons([H|T],NS,NSO,S,NSV):- !, term_singletons(H,NS,NSM,S,M),term_singletons(T,NSM,NSO,M,NSV).
term_singletons(Fml, NS,NSO, S,NSV):- compound(Fml),Fml=..[_,H|T],!, term_singletons(H,NS,NSM,S,M),term_singletons(T,NSM,NSO, M,NSV).

get_kv(X=Y,X,Y):- !.
get_kv(X-Y,X,Y):- !.
get_kv(KV,X,Y):- functor(KV,_,1),KV=..[X,Y],!.
get_kv(KV,X,Y):- arg(1,KV,X),arg(2,KV,Y),!.


is_function(F):- is_ftVar(F),!,fail.
is_function(Function):- compound(Function),get_functor(Function,F,A),is_function(Function,F,A).



is_function(_,'SubLQuoteFn',_):- !,fail.
is_function(_,'CollectionSubsetFn',_).
is_function(_,F,_):- atom_concat('sk',_Was,F),!,fail.
is_function(P,_,_):- leave_as_is(P),!,fail.
is_function(_,F,_):- is_log_op(F),!,fail.
is_function(_,F,_):- atom_concat(_Was,'Fn',F).
is_function(_,F,_):- tFunction(F).
is_function(_,F,A):- A2 is A+1,current_predicate(F/A2), not(current_predicate(F/A)).

%:- pfc_add(isa(I,C)<=(ttPredType(C),user:isa(I,C))).

is_ftEquality(Term):- is_ftVar(Term),!,fail.
%is_ftEquality(Term):- get_pred(Term,Pred),is),!,(Pred==mudEquals;genlPreds(Pred,equals);clause_asserted(prologEquality(Pred))),!.
is_ftEquality(mudEquals(_,_)).
is_ftEquality(skolem(_,_)).
is_ftEquality(equals(_,_)).

:-thread_local(thlocal:dont_use_mudEquals/0).


ensure_quantifiers(Wff:- B,WffO):- B== true,!, ensure_quantifiers(Wff,WffO).
ensure_quantifiers(Wff:- B,Wff:- B):- !.
% ensure_quantifiers(Wff,Wff):-!.
ensure_quantifiers(Wff,WffO):-
 must_det_l((show_call_failure(term_singletons(Wff,[],NS,[],Singles)),
  put_singles(Wff,'all',Singles,WffM),put_singles(WffM,'all',NS,WffO))).

:- multifile(function_corisponding_predicate/2).
:- dynamic(function_corisponding_predicate/2).

get_pred(Pred,F):- get_functor(Pred,F).



function_to_predicate(Function,NewVar,PredifiedFunction):- 
 Function = 'CollectionSubsetFn'(Col,'TheSetOf'(NewVar,Formulas)), 
 must(is_ftVar(NewVar)), % \+ is_ftVar(Col),!,
 PredifiedFunction = (isa(NewVar,Col) & Formulas).

function_to_predicate(Function,NewVar,PredifiedFunction):- 
  Function=..[F|ARGS],
  function_corisponding_predicate(F,P),
  fresh_varname(Function,NewVar),
  PredifiedFunction=..[P,NewVar|ARGS],!.

function_to_predicate(Function,NewVar,mudEquals(NewVar,Function)):- \+ thlocal:dont_use_mudEquals, fresh_varname(Function,NewVar),!.


