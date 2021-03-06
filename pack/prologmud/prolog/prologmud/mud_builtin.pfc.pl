/* * module 
% ===================================================================
% File 'mud_builtin.pl'
% Purpose: Emulation of OpenCyc for SWI-Prolog
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


:- dynamic(baseKB:agent_call_command/2).
:- baseKB:import(baseKB:agent_call_command/2).

:- assert_until_eof(infSupertypeName).
:- onEndOfFile(dmsg(infSupertypeName)).

:- include(prologmud(mud_header)).


:- file_begin(pfc).
:- set_defaultAssertMt(baseKB).

:- retractall(t_l:disable_px).

:- file_begin(code).
:- op(1150,fx,kb_dynamic).

:- kb_dynamic(  baseKB:irc_event_hooks/3).
:- kb_dynamic(  baseKB:deliver_event_hooks/2).
:- kb_dynamic   baseKB:irc_user_plays/3.

:- kb_dynamic lmcache:wants_logout/1.

:- kb_dynamic   lmcache:session_io/4, lmcache:session_agent/2, lmcache:agent_session/2,   telnet_fmt_shown/3,   agent_action_queue/3.
:- kb_dynamic lmcache:session_io/4, lmcache:session_agent/2, lmcache:agent_session/2,   telnet_fmt_shown/3,   agent_action_queue/3.

:- kb_dynamic   mudDescription/1.
:- kb_dynamic   term_specifier_text/2.
:- kb_dynamic   type_action_info/3.
:- kb_dynamic   update_charge/2.
:- kb_dynamic   update_stats/2.
:- kb_dynamic   use_usable/4.
:- kb_dynamic   verb_alias/2.
:- kb_dynamic   vtActionTemplate/1.
% :- kb_dynamic   baseKB:mud_test/0.
:- kb_dynamic  baseKB:mud_test/1.
:- kb_dynamic  baseKB:mud_test/2.
:- kb_dynamic  baseKB:mud_test_local/0.
:- kb_dynamic  baseKB:mud_test_local/1.
:- kb_dynamic  baseKB:mud_test_local/2.
:- kb_dynamic   world_agent_plan/3.
:- kb_dynamic   action_info/2.
:- kb_dynamic   action_rules/4.
:- kb_dynamic   action_verb_useable/5.
:- kb_dynamic   agent_command/2.
:- kb_dynamic   agent_command_fallback/2.
:- kb_dynamic   agent_text_command/4.
:- kb_dynamic   check_permanence/4.



:-op(0,fx,  ('disabled')).
:-op(0,fx,  ('enabled')).
:-op(0,fy,  ('disabled')).
:-op(0,fy,  ('enabled')).
% :- '@'(ensure_loaded(library(logicmoo/util/logicmoo_util_bugger)),user).

:- kb_dynamic(user_db:grant_openid_server/2).
:- kb_dynamic(user_db:grant_openid_server/2).
:- kb_dynamic '$was_imported_kb_content$'/2.
:- discontiguous('$was_imported_kb_content$'/2).
:- kb_dynamic(  disabled/1).
:- discontiguous(  disabled/1).
:- kb_dynamic(  enabled/1).
:- discontiguous(  enabled/1).
:- kb_dynamic   was_enabled/1.
:- discontiguous(  was_enabled/1).
:- kb_dynamic   listing_mpred_hook/1.


:- kb_dynamic   genls/2.
:- kb_dynamic(  isa/2).

:- style_check((-(singleton))).

/*
:-op(1190,fx,  (disabled)).
:-op(1190,fx,  (enabled)).
:-op(1190,fy,  (disabled)).
:-op(1190,fy,  (enabled)).
:-op(1120,fx,  (export)).
:-op(1120,fx,  (kb_dynamic)).
*/

:- set_prolog_flag(double_quotes, atom).
:- set_prolog_flag(double_quotes, string). 
:- set_prolog_flag(generate_debug_info, true).

% these do not get defined!?
% :- kb_dynamic user_db:assert_user/2, user_db:grant_openid_server/2, user_db:retractall_grant_openid_server/2, user_db:retractall_user/2, user_db:assert_grant_openid_server/2.

% :- kb_dynamic(mpred_online:semweb_startup/0).
% :- break.
:- kb_dynamic(  tChannel/1).


:- kb_dynamic baseKB:pfcManageHybrids/0.
:- kb_dynamic t_l:infMustArgIsa/0.
:- thread_local t_l:into_form_code/0.
:- thread_local t_l:current_local_why/2.
:- kb_dynamic   defnSufficient/2.
:- thread_local   t_l:repl_to_string/2.
:- thread_local   t_l:repl_writer/2.
:- kb_dynamic   lmcache:loaded_external_kbs/1.
% :- break.
:- kb_dynamic   loading_module_h/1.
:- kb_dynamic   baseKB:registered_module_type/2.
:- kb_dynamic   must_compile_special_clause_file/1.

% HOOKS
:- kb_dynamic   decl_coerce/3.
:- kb_dynamic   listen_to_ops/2.
:- kb_dynamic   deduce_facts/2.
:- kb_dynamic   default_type_props/3.
:- kb_dynamic   fact_always_true/1.
:- kb_dynamic   fact_is_false/2.
:- kb_dynamic   fact_maybe_deduced/1.
:- kb_dynamic   never_assert_u/2.
:- kb_dynamic   impl_coerce_hook/3.

:- kb_dynamic   create_random_fact/1.
% :- kb_dynamic   local_term_anglify/2.
% :- kb_dynamic   term_anglify_last/2.
% :- kb_dynamic   term_anglify_np/3.
% :- kb_dynamic   term_anglify_np_last/3.

% :- kb_dynamic   hooked_random_instance/3.

:- kb_dynamic   now_unused/1.
:- kb_dynamic   provide_mpred_read_attributes/3.
:- kb_dynamic   provide_mpred_setup/4.
:- kb_dynamic   provide_mpred_clauses/3.
:- kb_dynamic   provide_mpred_op/2.
:- kb_dynamic   provide_mpred_write_attributes/2.

% DYN HOOKS
% :- kb_dynamic   is_never_type/1.

% DYN FOR CODE
:- kb_dynamic lmcache:after_mpred_load/0.
:- thread_local baseKB:use_cyc_database/0.
:- kb_dynamic baseKB:use_cyc_database/0.

:- kb_dynamic   fact_is_false/2.
% :- kb_dynamic(kbp_t_list_prehook/2).


% DYN KB
:- kb_dynamic   baseKB:only_if_pttp/0.
:- kb_dynamic   use_kif/2.
:- kb_dynamic   is_mpred_prop/2.
%:- kb_dynamic   hasInstance_dyn/2.
:- kb_dynamic   arity/2.
:- kb_dynamic   mpred_prop/2.
:- kb_dynamic   '<=>'/2.
% :- kb_dynamic   ruleForward/2.
:- kb_dynamic   ruleRewrite/2.
% :- kb_dynamic   ruleBackward/2.

% :-must(not(  mpred_prop(t,prologHybrid))).


:- kb_dynamic   term_specifier_text/2.
:- kb_dynamic   update_charge/2.
:- kb_dynamic   update_stats/2.
:- kb_dynamic   use_usable/4.
:- kb_dynamic   verb_alias/2.
:- kb_dynamic   vtActionTemplate/1.
:- kb_dynamic  baseKB:mud_test/0.
:- kb_dynamic  baseKB:mud_test/1.
:- kb_dynamic  baseKB:mud_test/2.
:- kb_dynamic  baseKB:mud_test_local/0.
:- kb_dynamic  baseKB:mud_test_local/1.
:- kb_dynamic  baseKB:mud_test_local/2.
:- kb_dynamic   world_agent_plan/3.
:- kb_dynamic   action_info/2.
:- kb_dynamic   action_rules/4.
:- kb_dynamic   action_verb_useable/5.
:- kb_dynamic   agent_command/2.
:- kb_dynamic   agent_text_command/4.
:- kb_dynamic   check_permanence/4.

predicateConventionMt(agent_call_command,baseKB).

:- with_umt(baseKB,baseKB:ensure_mpred_file_loaded('logicmoo/pfc/autoexec.pfc')).

% baseKB:isa(iPerson99,tPerson).

:- op(500,fx,'~').
:- op(1050,xfx,('=>')).
:- op(1050,xfx,'<==>').
:- op(1050,xfx,('<-')).
:- op(1100,fx,('==>')).
:- op(1150,xfx,('::::')).

:- dynamic(mudTermAnglify/2).
:- discontiguous(mudTermAnglify/2).

tCol(tCol).
tCol(tSet).
tCol(meta_argtypes).
% tCol(prologMacroHead).
tCol(functorDeclares).
tCol(prologMultiValued).
tCol(prologSingleValued).
tCol(tFunction).
tCol(tInferInstanceFromArgType).
tCol(tPred).
tCol(tRelation).
tCol(meta_argtypes).
tCol(ttSpatialType).
tCol(ttTypeType).

tCol(tWorld).
tWorld(iWorld7).

ttExpressionType(ftProlog).

% ==> neg(arity(bordersOn,1)).

%ruleRewrite(isa(isInstFn(Sub),Super),genls(Sub,Super)):-ground(Sub:Super),!.

:- dynamic(tItem/1).
:- dynamic(ttAgentType/1).

typeGenls(ttAgentType,tAgent).
typeGenls(ttExpressionTypeType,ttExpressionType).
typeGenls(ttItemType,tItem).
typeGenls(ttObjectType,tObj).
typeGenls(ttPredType,tPred).
typeGenls(ttRegionType,tRegion).
typeGenls(ttSpatialType,tSpatialThing).
% :- break.

genls(tSpatialThing,tTemporalThing).
genls(ttSpatialType,ttTemporalType).
 
ttUnverifiableType(ftDiceFn(ftInt,ftInt,ftInt)).
ttUnverifiableType(vtDirection).


:- dynamic(disjointWith/2).
/*
disjointWith(A,B):- A=B,!,fail.
disjointWith(A,B):- disjointWithT(A,B).
disjointWith(A,B):- disjointWithT(AS,BS),transitive_subclass_or_same(A,AS),transitive_subclass_or_same(B,BS).
disjointWith(A,B):- once((type_isa(A,AT),type_isa(B,BT))),AT \= BT.
*/

disjointWith(Sub, Super) ==> disjointWith( Super, Sub).
disjointWith(tObj,tRegion).
disjointWith(ttSpatialType,ttAbstractType).


ptBinaryPredicate(arity).

(arity(Pred,2),tPred(Pred)) <==> ptBinaryPredicate(Pred).
prologHybrid(relationMostInstance(ptBinaryPredicate,tCol,vtValue)).
%relationMostInstance(BP,_,_)==>(ptBinaryPredicate(BP),ptRolePredicate(BP)).
prologHybrid(relationAllInstance(ptBinaryPredicate,tCol,vtValue)).
relationAllInstance(BP,_,_)==>ptBinaryPredicate(BP).


% (isa(Inst,Type), tCol(Inst)) ==> isa(Type,ttTypeType).
% (isa(TypeType,ttTypeType) , isa(Inst,TypeType), genls(SubInst,Inst)) ==> isa(SubInst,TypeType).

(sometimesSlow, ttExpressionType(FT),{compound(FT)})==>meta_argtypes(FT).

tCol(vtDirection).

genls(tPartofObj,tItem).

tCol(tCol).

:- must(ain(tCol(tAgent))).


% defined more correctly below dividesBetween(S,C1,C2) ==> (disjointWith(C1,C2) , genls(C1,S) ,genls(C2,S)).
% dividesBetween(S,C1,C2) ==> (disjointWith(C1,C2) , genls(C1,S) ,genls(C2,S)).
% disjointWith(tItem,tPathway).
%:-export(repl_to_string(tAgent,ftTerm)).
%:-export(repl_writer(tAgent,ftTerm)).
%:-export(repl_writer/2).
%prologHybrid(typeProps(tCol,ftVoprop)).
dividesBetween(tHominid,tMale,tFemale).
dividesBetween(tAgent,tHumanControlled,tNpcPlayer).
dividesBetween(tObj,tItem,tAgent).
dividesBetween(tItem,tMassfull,tMassless).
disjointdividesBetween(tObj,tMassfull,tMassless).
dividesBetween(tSpatialThing,tObj,tRegion).
dividesBetween(tTemporalThing,tObj,tRegion).
formatted_resultIsa(ftDiceFn(ftInt,ftInt,ftInt),ftInt).
% disjointWith(P1,P2) ==> ((neg(isa(C,P1))) <==> isa(C,P2)).

% isa(Col1, ttObjectType) ==> neg(isa(Col1, ttExpressionType)).

tSet(tCol).
tSet(tPred).
tSet(tFunction).
tSet(tRelation).
tSet(ttSpatialType).
tSet(ttExpressionType).
tCol(prologMacroHead).
% tCol(ArgsIsa):-mpred_is_trigger(ArgsIsa).
% TODO decide if OK
%tCol(F):-t(functorDeclares,F).
tCol(ttExpressionType).
tSpec(vtActionTemplate).
tSet(tRegion).
tSet(tContainer).

%(mpred_prop(_,meta_argtypes(ArgTypes)),{is_declarations(ArgTypes)}) ==> meta_argtypes(ArgTypes).



isa(tRegion,ttSpatialType).
isa(tRelation,ttAbstractType).

% genlPreds(genls,equals).
% genls(A, B):- tCol(A),{A=B}.

% must(Goal):- Goal. % (no_trace((visible(+all),visible(+unify),visible(+exception),leash(-all),leash(+exception))),(trace,Goal),leash(+all)).

% :- gutracer.


tCol(tFly).

prologHybrid(localityOfObject(tObj,tSpatialThing)).


(sometimesSlow, tCol(Inst), {isa_from_morphology(Inst,Type)}) ==> isa(Inst,Type).

% HOW TO MAKE THIS FAST? isa(Inst,Type) <= {isa_from_morphology(Inst,Type)}.

%((disjointWith(P1,P2) , genls(C1,P1), {dif:dif(C1,P1)}) ==>    disjointWith(C1,P2)).
% (disjointWith(C1,P2) <- (genls(C1,P1), {dif:dif(C1,P1)}, disjointWith(P1,P2))).

completelyAssertedCollection(Complete)==> {must(\+ ttExpressionType(Complete))}.

tCol(completelyAssertedCollection).
tCol(completeIsaAsserted).
% genls(completeIsaAsserted,tSpatialThing).
genls(completelyAssertedCollection,tCol).
completelyAssertedCollection(tItem).
completelyAssertedCollection(tRegion).
completelyAssertedCollection(tObj).
% :-must.
completelyAssertedCollection(tAgent).
completelyAssertedCollection(tCarryAble).
completelyAssertedCollection(vtVerb).
% :-rnotrace.

tCol(ttTypeByAction).
:-must(ain(tCol(ttTypeByAction))).

genls(ttTypeByAction,completelyAssertedCollection).

% dividesBetween(tItem,tPathway).
dividesBetween(tItem,tMassfull,tMassless).
dividesBetween(tSpatialThing,tObj,tRegion).
dividesBetween(tObj,tItem,tAgent).
dividesBetween(tObj,tMassfull,tMassless).
dividesBetween(tAgent,tHumanControlled,tNpcPlayer).

((sometimesBuggy,genls(A,B)/ground(genls(A,B)))==>{call((call((trace,baseKB:(must(ain(baseKB:tCol(A))),must(ain(baseKB:tCol(B))))))))}).

((sometimesBuggy,dividesBetween(S,C1,C2),{ground(S:C1:C2)}) ==> ((disjointWith(C1,C2) , genls(C1,S) ,genls(C2,S)))).

% slow... ttObjectType(Col1) ==> ~ttExpressionType(Col1).

neg(isa(I,Super)) <- {ground(isa(I,Super))}, (isa(I,Sub), disjointWith(Sub, Super)).
% disjointWith(P1,P2) ==> {\+(isa(P1,ttNonGenled)),\+(isa(P2,ttNonGenled))},(neg(isa(C,P1)) <==> isa(C,P2)).


tCol(ttSpatialType).

% Representations
vtActionTemplate(ArgTypes)/is_declarations(ArgTypes) ==> meta_argtypes(ArgTypes).

meta_argtypes(ArgTypes)/get_functor(ArgTypes,F),vtVerb(F)==>vtActionTemplate(ArgTypes).



argIsa(aDirectionsFn,2,ftListFn(vtDirection)).
argIsa(apathFn,1,tRegion).
argIsa(apathFn,2,vtDirection).
argIsa(localityOfObject,1,tObj).
argIsa(localityOfObject,2,tSpatialThing).
argIsa(mudColor,1,tObj).
argIsa(mudColor,2,vtColor).
argIsa(mudFacing,1,tObj).
argIsa(mudFacing,2,vtDirection).
argIsa(mudMemory,2,ftTerm).

tCol(vtVerb).
tCol(vtVerb).

/*
never_assert_u(mudAtLoc(iArea1025, _),isa(iArea1025,tRegion)).
never_assert_u(localityOfObject(iArea1025, iOfficeRoom7),isa(iArea1025,tRegion)).
never_assert_u(localityOfObject(R,_),isa(R,tRegion)):- isa(R,tRegion).
never_assert_u(mudFacing(R,_),isa(R,tRegion)):- isa(R,tRegion).
never_assert_u(mudAtLoc(R,_),isa(R,tRegion)):- isa(R,tRegion).

%deduce_facts_forward(localityOfObject(_,Region),isa(Region,tSpatialThing)).
deduce_facts_forward(localityOfObject(Obj,_),isa(Obj,tObj)).
fix_argIsa(F,N,vtDirection(Val),vtDirection):-ain(mpred_prop(F,argSingleValueDefault(N,Val))),!.

*/

tCol(tChannel).
tCol(tItem).
tCol(vtVerb).

% predIsFlag(tAgent(ftID),[predIsFlag]).
% prologDynamic(createableSubclassType/2).
% alt_forms1(none_AR,localityOfObject(P,R),mudAtLoc(P,L)):-ground(localityOfObject(P,R)),call_u(mudAtLoc(P,L)),nonvar(L),once(locationToRegion(L,R)).
% alt_forms1(none_AR,mudAtLoc(P,L),localityOfObject(P,R)):-ground(mudAtLoc(P,L)),once(locationToRegion(L,R)),nonvar(R).
% argsIsa(mudFacing,ftTerm).
% we need a way to call this: maxCapacity
% we need a way to call this: typeMaxCapacity
%:- compile_predicates([isa/2]).
%prologHybrid(repl_to_string(tAgent,term),[prologSingleValued,argSingleValueDefault(2,default_repl_obj_to_string)]).
% prologHybrid(repl_writer(tAgent,term),[prologSingleValued,argSingleValueDefault(2,default_repl_writer)]).
%:- forall(ttPredType(F),dynamic(F/1)).
%:- foreach(retract(isa(I,C)),assert_hasInstance(C,I)).
%isa(AT,ttAgentType):- genls(AT,ttAgentGeneric).
%genls(AT,ttAgentGeneric):- isa(AT,ttAgentType).
%subFormat(ftTextType,ftText).
%predIsFlag(tItem(ftID),[predIsFlag]).
%predIsFlag(tRegion(ftID),[predIsFlag]).
%predIsFlag(tRegion(ftID),tCol).
predIsFlag(tThinking(tAgent),[predIsFlag]).

prologHybrid(isEach((mudLastCmdSuccess/3 ))).
prologHybrid(isEach(mudLastCommand/2,mudNamed/2, mudSpd/2,mudStr/2,typeGrid/3)).
prologHybrid(isEach((mudContains/2))).



:- dynamic(mudDescription/2).
:- dynamic((tItem/1, tRegion/1, instVerbOverride/3,mudNamed/2, determinerString/2, mudKeyword/2 ,descriptionHere/2, mudToHitArmorClass0/2, tThinking/1, tDeleted/1, mudWeight/2, mudPermanence/3, act_term/2, mudAgentTurnnum/2, mudAtLoc/2, mudEnergy/2, mudHealth/2, mudDescription/2, mudFacing/2, mudCmdFailure/2, mudSpd/2, typeGrid/3, mudHeight/2, mudMemory/2, isa/2, pathName/3, mudPossess/2, mudScore/2, mudStm/2, mudStr/2, wearsClothing/2)).
:- dynamic((mudArmorLevel/2, mudLevelOf/2, mudToHitArmorClass0/2, mudBareHandDamage/2,
   chargeCapacity/2, mudEnergy/2, tCol/1, tAgent/1, tItem/1, tRegion/1, instVerbOverride/3,
   mudNamed/2, determinerString/2, mudKeyword/2 ,descriptionHere/2, tThinking/1, mudWeight/2,
   mudPermanence/3, act_term/2, mudAgentTurnnum/2, mudAtLoc/2, mudEnergy/2, mudHealth/2,
   mudDescription/2, mudFacing/2, failure/2, gridValue/4, mudHeight/2, mudMemory/2, isa/2, pathName/3, mudPossess/2, mudScore/2, mudStm/2, mudStr/2, mudWearing/2)).



prologMultiValued(mudDescription(ftTerm,ftString),[prologOrdered,prologHybrid]).
prologMultiValued(mudDescription(ftTerm,ftText), [predProxyAssert(add_description),predProxyRetract(remove_description),predProxyQuery(query_description)],prologHybrid).
prologMultiValued(mudDescription(ftTerm,ftText),[predProxyAssert(add_description),prologHybrid]).
prologMultiValued(mudKeyword(ftTerm,ftString),prologHybrid).
prologMultiValued(mudMemory(tAgent,ftTerm),prologHybrid).
prologMultiValued(mudNamed(ftTerm,ftTerm),prologHybrid).
prologMultiValued(mudPossess(tObj,tObj),prologHybrid).
prologMultiValued(nameStrings(ftTerm,ftString),prologHybrid).
prologMultiValued(pathDirLeadsTo(tRegion,vtDirection,tRegion),prologHybrid).
prologMultiValued(pathName(tRegion,vtDirection,ftString),prologHybrid).
prologMultiValued(genls(tCol,tCol),prologHybrid).
prologMultiValued(typeGrid(tCol,ftInt,ftListFn(ftString)),prologHybrid).
prologMultiValued(verbAsWell(ftTerm,ftAction,ftAction),prologHybrid).

prologNegByFailure(mudNeedsLook(tObj,ftBoolean),prologHybrid).
prologNegByFailure(tAgent(ftID),prologHybrid).
prologNegByFailure(tCol(ftID),prologHybrid).
prologNegByFailure(tCol(ftID),prologHybrid).
prologNegByFailure(tItem(ftID),prologHybrid).
prologNegByFailure(tRegion(ftID),prologHybrid).
prologNegByFailure(tThinking(tAgent),prologHybrid).
pathName(Region,Dir,Text)==>mudDescription(apathFn(Region,Dir),Text).

prologSingleValued(chargeCapacity(tChargeAble,ftInt),prologHybrid).
prologSingleValued(location_center(tRegion,xyzFn(tRegion,ftInt,ftInt,ftInt)),prologHybrid).
prologSingleValued(mudAgentTurnnum(tAgent,ftInt),[argSingleValueDefault(2,0)],prologHybrid).
prologSingleValued(mudArmor(tObj,ftInt),prologHybrid).
prologSingleValued(mudArmorLevel(tWearAble,ftInt),prologHybrid).
prologSingleValued(mudAtLoc(tObj,xyzFn(tRegion,ftInt,ftInt,ftInt)),prologHybrid).
prologSingleValued(mudAttack(tObj,ftInt),prologHybrid).
prologSingleValued(mudBareHandDamage(tAgent,ftInt),prologHybrid).
% prologSingleValued(mudBareHandDamage(tAgent,ftDiceFn),prologHybrid).
% prologSingleValued(mudEnergy(tChargeAble,ftInt(90)),prologHybrid).
prologSingleValued(mudEnergy(tChargeAble,ftInt),prologHybrid).
prologSingleValued(mudEnergy(tObj,ftInt),[argSingleValueDefault(2,90)],prologHybrid).
prologSingleValued(mudNonHunger(tObj,ftInt),[argSingleValueDefault(2,90)],prologHybrid).
prologSingleValued(mudHygiene(tObj,ftInt),[argSingleValueDefault(2,90)],prologHybrid).

:- ain_expanded((prologSingleValued(mudFacing(tObj,vtDirection),[argSingleValueDefault(2,vNorth)],prologHybrid))).

prologSingleValued(mudHealth(tObj,ftInt),prologHybrid).
prologSingleValued(mudHeight(tObj,ftInt),prologHybrid).
prologSingleValued(mudHeight(tSpatialThing,ftInt),prologHybrid).
prologSingleValued(mudID(tObj,ftID),prologHybrid).
prologSingleValued(mudLastCommand(tAgent,ftAction),prologHybrid).
prologSingleValued(mudLevelOf(tCarryAble,ftInt),prologHybrid).
prologSingleValued(mudMaxHitPoints(tAgent,ftInt),[prologHybrid],prologHybrid).
prologSingleValued(mudMoveDist(tAgent,ftInt),[argSingleValueDefault(2,1)]).
prologSingleValued(mudNeedsLook(tAgent,ftBoolean),argSingleValueDefault(2,vFalse),prologHybrid).
prologSingleValued(mudPermanence(tItem,vtVerb,vtPerminance),prologHybrid).
prologSingleValued(mudScore(tObj,ftInt),prologHybrid).
prologSingleValued(mudSpd(tAgent,ftInt),prologHybrid).
prologSingleValued(mudStm(tAgent,ftInt),prologHybrid).
prologSingleValued(mudStr(tAgent,ftInt),prologHybrid).
prologSingleValued(mudToHitArmorClass0(tAgent,ftInt),prologHybrid).
prologSingleValued(mudWeight(tObj,ftInt),prologHybrid).
% prologSingleValued(spawn_rate(isPropFn(genls(tObj)),ftInt)).
prologSingleValued(spawn_rate(tCol,ftInt)).
prologSingleValued(stat_total(tAgent,ftInt)).
prologSingleValued(typeGrid(tCol,ftInt,ftListFn(ftString))).
resultIsa(apathFn,tPathway).
% '<==>'(isa(Whom,tNpcPlayer),whenAnd(isa(Whom,tAgent),naf(isa(Whom,tHumanControlled)))).
'<==>'(mudDescription(apathFn(Region,Dir),Text),pathName(Region,Dir,Text)).
'<==>'(nameStrings(apathFn(Region,Dir),Text),pathName(Region,Dir,Text)).

ttPredAndValueType("size").
ttPredAndValueType("texture").
ttPredAndValueType("color").
ttPredAndValueType("shape").
ttPredAndValueType("material").

vtValue(Val)/(atom(Val),i_name_lc(Val,KW))==>mudKeyword(Val,KW).

ttPredAndValueType(Str)/
  (i_name('mud',Str,Pred),
  i_name('vt',Str,VT)) ==> 
    (ptRolePredicate(Pred),
     ttValueType(VT),
      mudKeyword(VT,Str),mudKeyword(Pred,Str),
      argIsa(Pred,2,VT),
      argIsa(Pred,1,tTemporalThing)).

%relationMostInstance(arg1Isa,ptRolePredicate,tTemporalThing).
%relationMostInstance(arg2QuotedIsa,ptRolePredicate,ftTerm).

% mudKeyword(W,R) <= {atom(W),i_name_lc(W,R)}.

ttValueType(vtSize).
ttValueType(vtTexture).
ttValueType(vtColor).

ttValueType(VT)==>tInferInstanceFromArgType(VT).

prologHybrid(verb_alias(ftString,vtVerb)).
prologHybrid(typeHasGlyph(tCol,ftString)).
prologHybrid(mudMaxHitPoints(tAgent,ftInt)).
prologHybrid(mudStowing(tAgent,tItem)).

:-dynamic((latitude/2, mudMoveDist/2, longitude/2)).
prologHybrid(typeHasGlyph,2).
prologHybrid(mudActAffect/3).
prologHybrid(mudAtLoc,2).
prologHybrid(mudColor/2).
prologHybrid(mudHealth,2).
prologHybrid(mudMaterial/2).
prologHybrid(mudNeedsLook,2).
prologHybrid(mudNeedsLook/2,[completeExtentAsserted]).
prologHybrid(mudShape/2).
prologHybrid(mudSize/2).
prologHybrid(mudTexture/2).
prologHybrid(pathDirLeadsTo/3).
prologDynamic(mudMoveDist/2).
:- dynamic(mudMoveDist/2).
meta_argtypes(mudMoveDist(tAgent,ftInt)).
prologSingleValued(mudMoveDist,[predicateConventionMt(abox),query(call),argSingleValueDefault(2,1)]).
prologDynamic(stat_total/2).

:- dynamic(vtBasicDir/1).

tCol(vtBasicDir).
:- must(ain(tCol(vtBasicDirPlusUpDown))).
% :- break.
tCol(vtDirection).
tCol(vtVerb).
:- dynamic stat_total/2.
:- dynamic(spawn_rate/2).
tCol(tMonster).
%prologDynamic(action_info(vtActionTemplate,ftText)).
prologDynamic(agent_command(tAgent,ftAction)).
:- ain(prologSideEffects(agent_command(tAgent,ftAction))).
%prologBuiltin(member(ftTerm,ftTerm)).
prologDynamic(mud_test(ftTerm,ftCallable)).
prologDynamic(use_action_templates(ftTerm)).


prologHybrid(typeHasGlyph(tCol,ftString)).
prologHybrid(mudColor(tSpatialThing,vtColor)).
prologHybrid(mudKnowing(tAgent,ftTerm)).
prologHybrid(mudLabelTypeProps(ftString,tCol,ftVoprop)).
prologHybrid(mudListPrice(tItem,ftNumber)).
:-dynamic(mudOpaqueness/2).
prologHybrid(mudOpaqueness(ftTerm,ftPercent)).
prologHybrid(mudPossess(tAgent,tObj)).
prologHybrid(mudShape(tSpatialThing,vtShape)).
prologHybrid(mudSize(tSpatialThing,vtSize)).
prologHybrid(mudTextSame(ftText,ftText)).
prologHybrid(mudTexture(tSpatialThing,vtTexture)).
prologHybrid(typeGrid(tCol,ftInt,ftListFn(ftString))).
meta_argtypes(aDirectionsFn(ftTerm,ftListFn(ftTerm))).
prologListValued(mudGetPrecepts(tAgent,ftListFn(tSpatialThing)),[predicateConventionMt(abox)]).
prologListValued(mudNearFeet(tAgent,ftListFn(tSpatialThing)),[]).
prologListValued(mudNearReach(tAgent,ftListFn(tSpatialThing)),[predicateConventionMt(abox)]).
prologMultiValued(action_rules(tAgent,vtVerb,ftListFn(ftVar),ftVoprop)).
prologMultiValued(mudLastCmdSuccess(tAgent,ftAction,ftBoolean)).
prologMultiValued(descriptionHere(ftTerm,ftString)).
prologMultiValued(descriptionHere(ftTerm,ftString),prologOrdered).
prologMultiValued(determinerString(ftTerm,ftString)).
prologMultiValued(typeHasGlyph(ftTerm,ftString)).
prologMultiValued(gridValue(tRegion,ftInt,ftInt,tObj)).
prologMultiValued(instVerbOverride(ftTerm,ftAction,ftAction)).
prologMultiValued(isa(ftTerm,tCol)).
prologMultiValued(mudActAffect(ftTerm,ftTerm,ftTerm)).
prologMultiValued(mudActAffect(tItem,vtVerb,ftTerm(ftVoprop))).
prologMultiValued(mudCmdFailure(tAgent,ftAction)).

tPred(isEach(tAgent/1, mudEnergy/2,mudHealth/2, mudAtLoc/2, failure/2, typeGrid/3, gridValue/4, isa/2, tItem/1, mudMemory/2, pathName/3, mudPossess/2, tRegion/1, mudScore/2, mudStm/2, mudFacing/2, localityOfObject/2, tThinking/1, mudWearing/2, mudFacing/2, mudHeight/2, act_term/2, nameStrings/2, mudDescription/2, pathDirLeadsTo/3, mudAgentTurnnum/2)).
prologHybrid(mudToHitArmorClass0 / 2).
prologHybrid(mudAtLoc/2).
prologBuiltin((agent_command/2)).
prologHybrid(isEach(argIsa/3, formatted_resultIsa/2, typeHasGlyph/2, inRegion/2, mudContains/2, isa/2, mudLabelTypeProps/3, mudMemory/2, mudPossess/2, mudStowing/2, genls/2, mudToHitArmorClass0/2, 
 pddlSomethingIsa/2, resultIsa/2, subFormat/2, tCol/1, tRegion/1, completeExtentAsserted/1, ttExpressionType/1, typeProps/2)).
prologHybrid(isEach(argIsa/3, formatted_resultIsa/2, typeHasGlyph/2, inRegion/2, mudContains/2, isa/2, mudLabelTypeProps/3, mudMemory/2, mudPossess/2, mudStowing/2, genls/2, mudToHitArmorClass0/2, 
 pddlSomethingIsa/2, resultIsa/2, subFormat/2, tCol/1, tRegion/1, completelyAssertedCollection/1, ttExpressionType/1, typeProps/2)).

prologHybrid(isEach(tItem/1, tRegion/1, instVerbOverride/3,mudNamed/2, determinerString/2, mudKeyword/2 ,descriptionHere/2, mudToHitArmorClass0/2, tThinking/1, tDeleted/1, mudWeight/2, mudPermanence/3, act_term/2, mudAgentTurnnum/2, mudAtLoc/2, mudEnergy/2, mudHealth/2, mudDescription/2, mudFacing/2, mudCmdFailure/2, mudSpd/2, typeGrid/3, mudHeight/2, mudMemory/2, isa/2, pathName/3, mudPossess/2, mudScore/2, mudStm/2, mudStr/2, wearsClothing/2)).
prologHybrid(isEach( mudArmorLevel/2, mudLevelOf/2, mudToHitArmorClass0/2, mudBareHandDamage/2, chargeCapacity/2, mudEnergy/2, tCol/1, tAgent/1, tItem/1, tRegion/1, instVerbOverride/3,mudNamed/2, determinerString/2, mudKeyword/2 ,descriptionHere/2, tThinking/1, mudWeight/2, mudPermanence/3, act_term/2, mudAgentTurnnum/2, mudAtLoc/2, mudEnergy/2, mudHealth/2, mudDescription/2, mudFacing/2, failure/2, gridValue/4, mudHeight/2, mudMemory/2, isa/2, pathName/3, mudPossess/2, mudScore/2, mudStm/2, mudStr/2, mudWearing/2)).

% :-must(fully_expand(clause(asert,test),prologHybrid(typeHasGlyph,2),(arity(typeHasGlyph, 2), prologHybrid(typeHasGlyph), tPred(typeHasGlyph)))).

arity(typeHasGlyph,2).
arity(mudTermAnglify,2).
arity(mudMaxHitPoints,2).


prologHybrid(instVerbOverride(ftTerm,ftAction,ftAction)).
%isa(localityOfObject,prologHybrid). 
%isa(mudActAffect, prologMultiValued).
%isa(mudMaxHitPoints,prologHybrid).
isa(vtDirection,ttValueType).

prologMultiValued(agent_text_command(tAgent,ftText,tAgent,ftAction)).

formatted_resultIsa(apathFn(tRegion,vtDirection),tPathway).

prologBuiltin(is_vtActionTemplate/1).

is_vtActionTemplate(C):-nonvar(C),get_functor(C,F),!,atom_concat(act,_,F).
defnSufficient(ftAction,is_vtActionTemplate).
defnSufficient(ftAction,vtVerb).
defnSufficient(ftTerm,vtValue).

genls('FemaleAnimal',tAgent).
genls('MaleAnimal',tAgent).
genls(isEach('PortableObject','ProtectiveAttire','SomethingToWear'),tCarryAble).
genls(isEach('ProtectiveAttire','SomethingToWear'),tWearAble).
genls(isEach(tRegion,tAgent),tChannel).

genls(tAgent,tObj).
genls(tAgent,tSpatialThing).
genls(tItem,tObj).
genls(tItem,tSpatialThing).
genls(tObj,tSpatialThing).
genls(tPred,tRelation).
genls(tRegion,tSpatialThing).
genls(ttObjectType,tCol).
genls(ttSpatialType,tCol).
genls(tFunction,tRelation).
tPred(meta_argtypes).
meta_argtypes(aDirectionsFn(ftTerm,ftListFn(ftTerm))).
meta_argtypes(apathFn(tRegion,vtDirection)).
meta_argtypes(xyzFn(tRegion,ftInt,ftInt,ftInt)).

% :- set_prolog_flag(assert_attvars,true).

genls(ttTypeByAction,tCol).

:-w_tl(set_prolog_flag(assert_attvars,true),ain(((ttTypeByAction(X) ==> tCol(X))))).

% (isa(Inst,Type),isa(Type,ttTypeByAction)) ==> isa(Inst,tHasAction).

ttTypeByAction(C),isa(I,C),{\+ is_in_world(I)} ==> \+ isa(I,C).

/*
% Produces actEat(String):- current_agent(Agent),agent_call_command(Agent,actEat(String)).
((vtActionTemplate(Compound)/(compound(Compound), 
    \+ current_predicate(_,Compound),
    arg(1,Compound,TC),
    functor(Compound,F,A),
    functor(Skel,F,A),
    arg(1,Compound,String)))
  ==> 
   ( (Skel 
       :- 
       current_agent(Agent),agent_call_command(Agent,Skel)),
    {nop((asserta_if_new((agent_call_command(Agent,Skel) 
       :- agent_coerce_for(mudPossess,TC,Agent,String,Obj),!,
          agent_call_command(Agent,Skel)))))})).
*/


genls(tAgent,tObj).
genls(tAgent,tSpatialThing).
genls(tItem,tObj).
genls(tItem,tSpatialThing).
genls(tObj,tSpatialThing).
genls(tPred,tRelation).
genls(tRegion,tSpatialThing).
genls(ttObjectType,tCol).
genls(ttSpatialType,tCol).
genls(tFunction,tRelation).

genls(tCarryAble,tItem).
genls(tChargeAble,tItem).
genls(tContolDevice,tChargeAble).

tCol(tFurniture).

genls(tDoor,tFurniture).
genls(tDoor,tItem).
genls(tDrinkAble,tItem).
genls(tEatAble,tItem).
genls(tFurniture,tObj).
genls(tFurniture,tPartofObj).
genls(tHumanControlled,tAgent).
genls(tMonster,ttAgentGeneric).
genls(tNpcPlayer,tAgent).
genls(tPathway,tDoor).
genls(tUseAble,tItem).
genls(tWearAble,tItem).
genls(vtBasicDir,vtBasicDirPlusUpDown).
genls(vtBasicDirPlusUpDown,vtDirection).
genls(vtDirection,vtValue).

:- kb_dynamic(vtPosture/1).

tCol(vtPosture).
genls(vtPosture,vtVerb).


action_to_able(actSearch,tSearchAble).
action_to_able(actOperate,tOperateAble).
action_to_able(actObserve,tObserveAble).
(action_to_able(ACT,ABLE)==> ((argIsa(ACT,1,Type),isa(Type,ttObjectType))==> genls(Type,ABLE))).
  

genlInverse(mudContains,mudInsideOf).

arity(mudInsideOf,2).

vtBasicDir(vEast).
vtBasicDir(vNorth).
vtBasicDir(vSouth).
vtBasicDir(vWest).
vtBasicDirPlusUpDown(vDown).
vtBasicDirPlusUpDown(vUp).
%localityOfObject(Above,HasSurface):- mudLocOnSurface(Above,HasSurface).
%localityOfObject(Clothes,Agent):- mudSubPart(Agent,Clothes).
%localityOfObject(Inner,Container):- mudInsideOf(Inner,Container).
%localityOfObject(Inner,Outer):- baseKB:only_if_pttp, localityOfObject(Inner,Container),localityOfObject(Container,Outer).
nameStrings(apathFn(Region,Dir),Text):- pathName(Region,Dir,Text).
meta_argtypes(mudMaterial(tSpatialThing,vtMaterial)).
meta_argtypes(mudTexture(tSpatialThing,vtTexture)).
meta_argtypes(mudWearing(tAgent,tWearAble)).
meta_argtypes(pathName(tRegion,vtDirection,ftString)).
meta_argtypes(resultIsa(tFunction,tCol)).
meta_argtypes(wasSuccess(tAgent,ftBoolean)).
meta_argtypes(type_action_info(tCol,vtActionTemplate,ftText)).
%NEXT TODO predTypeMax(mudEnergy,tObj,130).
%NEXT TODO predTypeMax(mudHealth,tObj,500).

tCol(ttAgentType).

prologHybrid(pathDirLeadsTo(tRegion,vtDirection,tRegion)).
prologHybrid(bordersOn(tRegion,tRegion),tSymmetricRelation).

ttAgentType(tMonster).
% instTypeProps(apathFn(Region,_Dir),tPathway,[localityOfObject(Region)]).


==> tSpec(vtActionTemplate).

disjointWith(tObj,tRegion).
disjointWith(tRegion,tObj).


ttTemporalType(tAgent).
ttTemporalType(tItem).
ttTemporalType(tObj).
ttTemporalType(tRegion).

tCol(tChannel).
tChannel(A):- tAgent(A).
tChannel(A):- tRegion(A).
tChannel(iGossupChannel).
%ttTypeFacet(tChannel).
:-ain_expanded(isa(tObj,ttTemporalType)).
:-ain_expanded(isa(tRegion,ttTemporalType)).

/*
already defined
typeGenls(ttAgentType,tAgent).
typeGenls(ttItemType,tItem).
typeGenls(ttObjectType,tObj).
typeGenls(ttRegionType,tRegion).
% cycAssert(A,B):- trace_or_throw(cycAssert(A,B)).
*/



prologHybrid(dividesBetween(tCol,tCol,tCol)).

% defined more correctly below dividesBetween(S,C1,C2) ==> (disjointWith(C1,C2) , genls(C1,S) ,genls(C2,S)).
dividesBetween(tAgent,tMale,tFemale).
dividesBetween(tAgent,tHumanControlled,tNpcPlayer).
dividesBetween(tItem,tMassfull,tMassless).
dividesBetween(tObj,tItem,tAgent).
dividesBetween(tObj,tMassfull,tMassless).
dividesBetween(tSpatialThing,tObj,tRegion).
dividesBetween(tTemporalThing,tObj,tRegion).
formatted_resultIsa(ftDiceFn(ftInt,ftInt,ftInt),ftInt).

isa(tRegion,ttTemporalType).

completelyAssertedCollection(tCol).
 completelyAssertedCollection(tCol).
 completelyAssertedCollection(ttExpressionType).
completelyAssertedCollection(tItem).
completelyAssertedCollection(tRegion).
completelyAssertedCollection(tObj).
completelyAssertedCollection(tAgent).
completelyAssertedCollection(tCarryAble).
completelyAssertedCollection(vtVerb).
genls(ttTypeByAction,completelyAssertedCollection).

arity(bordersOn,2).


% ensure_some_pathBetween(R1,R2):- cwc,must((ain(pathDirLeadsTo(R1,aRelatedFn(vtDirection,R1,R2),R2)),ain(pathDirLeadsTo(R2,aRelatedFn(vtDirection,R2,R1),R1)))),!.

bordersOn(R1,R2)/ground(bordersOn(R1,R2)) ==> isa(R1,tRegion),isa(R2,tRegion),bordersOn(R2,R1).

(bordersOn(R1,R2)/ground(bordersOn(R1,R2)), \+ pathDirLeadsTo(R1,_,R2), 
  {random_path_dir(Dir),reverse_dir(Dir,Rev)}, 
   {\+ pathDirLeadsTo(R1,Dir,_NotR2), 
   \+ pathDirLeadsTo(R2,Rev,_NotR1)}) ==>
  {ain(pathDirLeadsTo(R1,Dir,R2))}.

pathDirLeadsTo(R1,Dir,R2)/reverse_dir(Dir,Rev) ==> pathDirLeadsTo(R2,Rev,R1).
% pathDirLeadsTo(R1,_,R2) ==> bordersOn(R1,R2).

singleValuedInArg(pathDirLeadsTo,2).

% ==================================================
% Classes of things
% ==================================================


genls(tAgent,tObj).
genls(tItem,tObj).
genls(tClothing, tWashAble).
genls(tClothing, tWearAble).
genls(tFood,tEatAble).
genls(tFood, tItem).
genls(tClothing, tItem).

genls( tCarryAble, tItem).
genls( tCarryAble, tDropAble).

/*

tCol(genlsInheritable).
:-dynamic(genlsInheritable/1).

genlsInheritable(tCol).
genlsInheritable(ttPredType).
:-must(ain((genls(ttTypeType,genlsInheritable)))).

:- dynamic(nearestIsa/2).
(genls(C,SC)/ground(genls(C,SC)),nearestIsa(SC,W),\+ genlsInheritable(W) )==>isa(C,W).

*/

% throw(sane_transitivity (genls( tCarryAble, tThrowAble))).
% genls( tCarryAble, tCarryAble).

genls(tPortableDevice,tCarryAble).

predIsFlag(spatialInRegion/1).

:-do_gc.

genls(tClothing, tFoldAble).
genls(tClothing, tWearAble).

genls(tLiquidContainer, tDrinkAble).
genls(tLiquidContainer, tCarryAble).


genls(tFoldAble, tCarryAble).
% genls(tThrowAble, tCarryAble).
genls(tPortableDevice,tCarryAble).
genls(tPortableDevice,tPhysicalDevice).
genls(tPhysicalDevice,tUseAble).
genls(tWearAble, tCarryAble).
genls(tFood,tCarryAble).
genls(tCarryAble,tObj).
genls(tPartofObj,tNotTakAble).
genls(tBodyPart,tPartofObj).
genls(tSpatialThing,tLookAble).
genls(tFurnature,tOntoAble).
genls(tFurnature,tItem).

genls(tPartofFurnature,tPartofObj).






%(isa(I,Sub), disjointWith(Sub, Super)) ==> neg(isa(I,Super)).


genls(tPartofObj,tItem).


(sometimesBuggy,dividesBetween(S,C1,C2)/ground(v(S,C1,C2))) ==> (disjointWith(C1,C2) , genls(C1,S) ,genls(C2,S)).

% disjointWith(P1,P2) ==> (not(isa(C,P1)) <==> isa(C,P2)).


tCol(tCol).
tCol(tPred).
tCol(tFunction).
tCol(tRelation).
tCol(ttSpatialType).
tCol(ttExpressionType).
%  tCol(prologMacroHead).
% tCol(ArgsIsa):-ttPredType(ArgsIsa).
% TODO decide if OK
%tCol(F):-t(prologMacroHead,F).
tCol(ttExpressionType).
tSpec(vtActionTemplate).

isa(tRegion,ttSpatialType).
isa(tRelation,ttAbstractType).
typeProps(tTorso,[mudColor(isLikeFn(mudColor,tSkin)),mudShape(vUnique)]).
typeProps(tSkin,[mudColor(vUnique),mudShape(vUnique)]).

%Empty Location
% You *have* to use 0 as the id of the empty location. (no way!)
mudLabelTypeProps(--,tRegion,[]).

%NEXT TODO predTypeMax(mudEnergy,tAgent,120).

typeProps(tAgent,[predInstMax(mudHealth,500)]).
genls('IndoorsIsolatedFromOutside',tRegion).
genls('SpaceInAHOC',tRegion).

typeProps(tAgent,[mudMoveDist(1)]).
% isRandom(vtBasicDir)
typeProps(tAgent,[predInstMax(mudHealth,500), predInstMax(mudEnergy,200), mudHealth(500), mudEnergy(90),  mudFacing(vNorth), mudAgentTurnnum(0), mudScore(1), 
    mudMemory(aDirectionsFn([vNorth,vSouth,vEast,vWest,vNE,vNW,vSE,vSW,vUp,vDown]))]).
% typeProps(tAgent,mudLastCommand(actStand)).
typeProps(tAgent,mudNeedsLook(vFalse)).

typeProps(tFood,[mudHeight(0)]).

typeProps(tItem,mudEnergy(140)).

typeProps(tItem,mudListPrice(0)).
typeProps(tObj,[mudOpaqueness(100)]).
typeProps(tRegion,[mudOpaqueness(1)]).
typeProps(tSpatialThing,mudHeight(0)).

% :-end_module_type(dynamic).

mudLabelTypeProps(Lbl,Type,Props)/ground(mudLabelTypeProps(Lbl,Type,Props))==> (typeHasGlyph(Type,Lbl) , typeProps(Type,Props)).

% Vacuum World example objects........
mudLabelTypeProps(wl,tWall,[mudHeight(3),mudWeight(4)]).

%TOO SLOW isa(I,SC)<=isa(I,C),genls(C,SC).

wearsClothing(A,I)==>tAgent(A),tClothing(I).


genls(tBread, tFood).

typeProps(tCrackers,
  [mudColor(vTan),tBread,
   mudShape(isEach(vCircular,vFlat)),
   mudSize(vSmall),
   mudTexture(isEach(vDry,vCoarse))]).

nonvar_must_be(V,G):- (var(V);G),!.

% TODO SPEED THIS UP 
% mudKeyword(I,Str)<= {(nonvar(I);nonvar(Str)), nonvar_must_be(I,\+tCol(I)), nonvar_must_be(Str,string(Str))}, isa(I,Type),mudKeyword(Type,Str).

pfc_slow((mudKeyword(Type,Str),tCol(Type),isa(I,Type)/(atom(I),ftID(I)) ==> mudKeyword(I,Str))).


action_info(C,_)==>vtActionTemplate(C).

completelyAssertedCollection(cachedPredicate).

argsQuoted(cachedPredicate).

ttPredType(cachedPredicate).
cachedPredicate(P)/predicate_to_goal(P,Goal)==>{forall(call_u(Goal),ain(Goal))}.

cachedPredicate(vtActionTemplate(_)).

% from inform7
prologHybrid(mudRelating(ftID,ftID)).
prologHybrid(mudProviding(ftID,ftID)).
prologHybrid(mudContainment(ftID,ftID)).
prologHybrid(mudSupportsSpatially(ftID,ftID)).
prologHybrid(mudIncorporates(ftID,ftID)).
prologHybrid(mudEncloses(ftID,ftID)).

/*
An object has a text called printed name.
An object has a text called printed plural name.
An object has a text called an indefinite article.
An object can be plural-named or singular-named. An object is usually singular-named.
An object can be proper-named or improper-named. An object is usually improper-named.

A room can be privately-named or publically-named. A room is usually publically-named.
A room can be lighted or dark. A room is usually lighted.
A room can be visited or unvisited. A room is usually unvisited.
A room has a text called description.

Y [can] be C1 or C2.  
Y is [usually] C2.

A thing can be lit or unlit. A thing is usually unlit.
A thing can be edible or inedible. A thing is usually inedible.
A thing can be fixed in place or portable. A thing is usually portable.
A thing can be scenery.
A thing can be wearable.
A thing can be pushable between rooms.

The north is a direction.
The northeast is a direction.
The northwest is a direction.
The south is a direction.
The southeast is a direction.
The southwest is a direction.
The east is a direction.
A/sr1 - SR1 - Physical World Model �30 14
The west is a direction.
The up is a direction.
The down is a direction.
The inside is a direction.
The outside is a direction.
The north has opposite south. Understand "n" as north.
The northeast has opposite southwest. Understand "ne" as northeast.
The northwest has opposite southeast. Understand "nw" as northwest.
The south has opposite north. Understand "s" as south.
The southeast has opposite northwest. Understand "se" as southeast.
The southwest has opposite northeast. Understand "sw" as southwest.
The east has opposite west. Understand "e" as east.
The west has opposite east. Understand "w" as west.
Up has opposite down. Understand "u" as up.
Down has opposite up. Understand "d" as down.
Inside has opposite outside. Understand "in" as inside.
Outside has opposite inside. Understand "out" as outside.
The inside object translates into I6 as "in_obj".
The outside object translates into I6 as "out_obj".
The verb to be above implies the mapping up relation.
The verb to be mapped above implies the mapping up relation.
The verb to be below implies the mapping down relation.
The verb to be mapped below implies the mapping down relatio

A door has an object called other side.
The other side property translates into I6 as "door_to".
Leading-through relates one room (called the other side) to various doors.
The verb to be through implies the leading-through relation.
�33. Containers and supporters. The carrying capacity property is the exception to the remarks above
about the qualitative nature of the world model: here for the first and only time we have a value which can
be meaningfully compared.
Section SR1/6 - Containers
The specification of container is "Represents something into which portable
things can be put, such as a teachest or a handbag. Something with a really
large immobile interior, such as the Albert Hall, had better be a room
instead."
A container can be enterable.
A container can be opaque or transparent. A container is usually opaque.
A container has a number called carrying capacity.
The carrying capacity of a container is usually 100.
Include (- has container, -) when defining a container

The specification of supporter is "Represents a surface on which things can be
placed, such as a table."
A supporter can be enterable.
A supporter has a number called carrying capacity.
The carrying capacity of a supporter is usually 100.
A supporter is usually fixed in place.
Include (-
has transparent supporter
-) when defining a supporte

A door can be open or closed. A door is usually closed.
A door can be openable or unopenable. A door is usually openable.
A container can be open or closed. A container is usually open.
A container can be openable or unopenable. A container is usually unopenable.

Before rules is a rulebook. [20]
Instead rules is a rulebook. [21]
Check rules is a rulebook. [22]
Carry out rules is a rulebook. [23]
After rules is a rulebook. [24]
Report rules is a rulebook. [25]

Action-processing rules is a rulebook. [10]
The action-processing rulebook has a person called the actor.
Setting action variables is a rulebook. [11]
The specific action-processing rules is a rulebook. [12]
The specific action-processing rulebook has a truth state called action in world.
The specific action-processing rulebook has a truth state called action keeping silent.
The specific action-processing rulebook has a rulebook called specific check rulebook.
The specific action-processing rulebook has a rulebook called specific carry out rulebook.
The specific action-processing rulebook has a rulebook called specific report rulebook.
The specific action-processing rulebook has a truth state called within the player�s sight.
The player�s action awareness rules is a rulebook. [13]
�16. The rules on accessibility and visibility, which control whether an action is physically possible, have
named outcomes as a taste of syntactic sugar.
Accessibility rules is a rulebook. [14]
Reaching inside rules is an object-based rulebook. [15]
Reaching inside rules have outcomes allow access (success) and deny access (failure).
Reaching outside rules is an object-based rulebook. [16]
Reaching outside rules have outcomes allow access (success) and deny access (failure).
Visibility rules is a rulebook. [17]
Visibility rules have outcomes there is sufficient light (failure) and there is
insufficient light (success).
�17. Two rulebooks govern the processing of asking other people to carry out actions:
Persuasion rules is a rulebook. [18]
Persuasion rules have outcomes persuasion succeeds (success) and persuasion fails (failure).
Unsuccessful attempt by is a rulebook. [19

*/



prologBuiltin(random_path_dir/1).
random_path_dir(Dir):-nonvar(Dir),!,random_path_dir(Dir0),Dir=Dir0,!.
random_path_dir(Dir):- call(call,random_instance(vtBasicDir,Dir,true)).
random_path_dir(Dir):- call(call,random_instance(vtBasicDirPlusUpDown,Dir,true)).
random_path_dir(Dir):- call(call,random_instance(vtDirection,Dir,true)).

prologBuiltin(onEachLoad/0).
argsQuoted(onEachLoad).
argsQuoted(must).

tCol(tStatPred).

prologHybrid(normalAgentGoal(tStatPred,ftTerm)).

(tStatPred(Pred)==>(ptRolePredicate(Pred),arity(Pred,2),singleValuedInArg(Pred,2))).

:- ain(((normalAgentGoal(Pred,N)/atom(Pred) ==>
 ({AT=..[Pred,tAgent,ftPercent]},{kb_dynamic(Pred,2)},
     meta_argtypes(AT),argSingleValueDefault(Pred,2,N),prologHybrid(Pred),tStatPred(Pred))))).


normalAgentGoal(mudEnergy,90).
normalAgentGoal(mudNonHunger,90).
normalAgentGoal(mudHygiene,90).
normalAgentGoal(mudBladderEmpty,90).
normalAgentGoal(mudSecureRoom,90).
normalAgentGoal(mudFun,90).
normalAgentGoal(mudNonLonelinessSocial,90).
normalAgentGoal(mudSadToHappy,90).
normalAgentGoal(mudComfort,90).

typeProps(tAgent,[mudStr(2),mudHeight(2),mudStm(2),mudSpd(2)]).


%normalAgentGoal(Pred,Val)==>  (tAgent(A)==>agentGoals(A,Pred,((t(Pred,A,V),V>=Val)))).
%agentGoals(A,About,State)/State ==> \+ agentTODO(A,actImprove(About)).

prologHybrid(on_command_show(tAgent,vtActionType,ftTerm)).
prologHybrid(agentTODO(tAgent,vtActionType)).
prologHybrid(agentGOAL(tAgent,ftAssertable)).

normalAgentGoal(Pred,Val) ==>  ( t(Pred,A,V)/(V<Val) ==> agentTODO(A,actImprove(Pred))).
normalAgentGoal(Pred,Val) ==>  ( t(Pred,A,V)/(V<Val) ==> agentGOAL(A,t(Pred,A,Val))).

:-ain((normalAgentGoal(Pred,Val) ==>  ( t(Pred,A,V)/(V<Val) ==> agentGOAL(A,t(Pred,A,Val))))).
% :-mpred_fwd((normalAgentGoal(Pred,Val) ==>  ( t(Pred,A,V)/(V<Val) ==> agentGOAL(A,t(Pred,A,Val))))).
normalAgentGoal(Pred,Val)==>  (tAgent(A)==>mdefault(t(Pred,A,Val))).

genls(tRoom,tRegion).

:- set_prolog_flag(dialect_pfc,false).

/*

 the CycL language extends Prolog''s first order logic capabilities with some higher order logics.  
 It also extrends prolog to show proofs.. one issue is the CycL language never signed up for cuts or other execution  orders.    
 PrologMUD extends the CycL language to allow preset program flow (unless a predicate is declared to not honor order of execution 
  (this is usually best!)).  PrologMUD  implements a new design of the cyc canonicalizer..   

 usually in Cyc the rules "(implies (and Axy Byz) (and Cwxyz Dwx))" are converted to DNF (Correct me if I am wrong.. 
 since i have heard it uses ConjuntiveNormalForm as well) ... the DNF generates Clausal forms..  The forms choosen 



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

(((meta_argtypes(Types)/
 (functor(Types,F,A), A >1, functor(Matcher,F,A),arity(F,A)))
  ==> 
    ((Matcher ==> {between(1,A,N),arg(N,Matcher,I),arg(N,Types,T),ground(I:T)},\+ttExpressionType(T),isa(I,T),{dmsg(isa(I,T))})))).

((argQuotedIsa(Pred, _, 'CycLSentence') ==> 'SententialOperator'(Pred))).

*/

:- set_prolog_flag(dialect_pfc,false).


% :- time(must(ain_expanded(prologSingleValued(mudFacing666(tObj,vtDirection),[argSingleValueDefault(2,vNorth)],prologHybrid)))).

% :- profile((ain_expanded(prologSingleValued(mudFacing666(tObj,vtDirection),[argSingleValueDefault(2,vNorth)],prologHybrid)))).
