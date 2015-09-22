% ===================================================================
% File 'parser_all.pl'
% Purpose: English to KIF conversions from SWI-Prolog  
% This implementation is incomplete
% Maintainer: Douglas Miles
% Contact: $Author: dmiles $@users.sourceforge.net ;
% Version: 'parser_all.pl' 1.0.0
% Revision:  $Revision: 1.3 $
% Revised At:   $Date: 2002/06/06 15:43:15 $
% ===================================================================

end_of_file.

% ==============================================================================

:- user:ensure_loaded_no_mpreds(library(logicmoo/util/logicmoo_util_all)).
:- user:ensure_loaded_no_mpreds(library(logicmoo/logicmoo_base)).
:- asserta(thlocal:disable_mpred_term_expansions_locally).

:- multifile(user:type_action_info/3).
:- multifile(user:agent_call_command/2).
:- multifile(user:mud_test/2).
:- multifile(user:sanity_test/0).
:- multifile(user:regression_test/0).
:- multifile(user:feature_test/0).



% ==============================================================================
%   
% APE: Converter Pipeline
%   acetext, sentences, syntaxTrees, drs, drs0, sdrs, fol, pnf, tokens, 
%        sentencesToParse, paraphrase
% 
% CHAT80:  acetext, acetext_no_punct, pos_sents_pre,  syntaxTree80, query80
%
%  needConverter(syntaxTree,syntaxTree80).
% 
% =============================================================================

:-meta_predicate(install_converter(:)).
:-export(install_converter/1).
%% install_converter(+FunctorArgList).
%
%  ?- install_converter(tokens_to_paragraphs(+tokens, -sentences:set)).
%  ?- install_converter(call_parser(+sentences:list, +(startID,1), -syntaxtrees, -(drs0,reversed))).
%
install_converter(CNV):-strip_module(CNV,M,CNVLST),functor(CNVLST,F,A), '@'(export(M:F/A),M), must(assertz_new(installed_converter(M:CNVLST))).


:-thread_local(pipeline_pass_fail/3).

%% try_converter(+TID:key,+CNV:pred).
%
%  called by recusive code upon Transaction ID
%
try_converter(TID,CNV):- strip_module(CNV,M,CNVLST), CNVLST=..[F|Args],!,
  ignore((debugOnError(maplist(make_io_closure(TID),Args,IOArgs,CLOSURES)), IOCNVLST=..[F|IOArgs],!, show_call(call_ape('@'(IOCNVLST,M))),maplist(must,CLOSURES))).

%% try_converter(+TID:key,+CNV:pred).
%
% Make in-out closure on Convertor arg
%
make_io_closure(TID, + Name:Type, Value    ,true):-!,get_pipeline_value(TID,Name:Type,Value,error),!, 
  (Value\=error->true;((fail,trace_or_throw(unknown_get_pipeline_value(TID,+(Name:Type),Value))))).
make_io_closure(TID, +(Name,Else),Value,true):-!, get_pipeline_value(TID,Name,Value,Else).
make_io_closure(TID, + Name, Value    ,true):-get_pipeline_value(TID,Name,Value,error),!,
         (Value\=error->true;((fail,trace_or_throw(unknown_get_pipeline_value(TID,+(Name),Value))))).

make_io_closure(TID, -Name:Type ,Value, set_pipeline_value(TID,Name:Type,Value)):-!.
make_io_closure(TID, -Name ,Value, set_pipeline_value(TID,Name,Value)):-!.
make_io_closure(TID, NameType ,Value, O):- trace_or_throw(unknown_get_pipeline_value(TID,NameType,Value,O)).

:-thread_local(pipeline_value/3).

%% get_pipeline_value(+TID:key, +Name:varspec, -Value:term, +Else:term ).
%
% Get a variable in the Transaction ID or else a default
%
get_pipeline_value(TID,Name,Value,Else):-var(Name),!,trace_or_throw(var_get_pipeline_value(TID,Name,Value,Else)).
get_pipeline_value(TID,Name:list,ValueOut,Else):- findall(V,pipeline_value(TID,Name,V),Values), !, (Values==[]-> ValueOut=Else, ValueOut = Values).
get_pipeline_value(TID,Name:set,ValueOut,Else):- findall(V,pipeline_value(TID,Name,V),Values), !, (Values==[]-> ValueOut=Else, ValueOut = Values).
get_pipeline_value(TID,Name:uniqe,ValueOut,Else):- !,get_pipeline_value(TID,Name,ValueOut,Else).
get_pipeline_value(TID,Name:reversed,ValueOut,Else):- findall(V,pipeline_value(TID,Name,V),RBinders),reverse(RBinders,Values), !, (Values==[]-> ValueOut=Else, ValueOut = Values).
get_pipeline_value(TID,Name:reversed_set,ValueOut,Else):- findall(V,pipeline_value(TID,Name,V),RBinders),reverse(RBinders,Values), !, (Values==[]-> ValueOut=Else, ValueOut = Values).
get_pipeline_value(TID,Name:Other,Value,Else):-!,trace_or_throw(unknown_get_pipeline_value(TID,Name:Other,Value,Else)).
get_pipeline_value(TID,Name,Value,_ ):- pipeline_value(TID,Name,Value),!.
get_pipeline_value(TID,(N1;Name),ValueOut, Else):- get_pipeline_value(TID,N1,Value,missing),
   (Value==missing ->  get_pipeline_value(TID,Name,ValueOut, Else) ; ValueOut= Value),!.
get_pipeline_value(TID,Name,Value,Else):- pipeline_value(TID,Name,Value) -> true;  Value=Else.
get_pipeline_value(TID,Name,Value,Else):- pipeline_value(TID,'&'(Name ,_),Value) -> true;  Value=Else.

is_word_atomic(Value):-atomic(Value),!.
is_word_atomic(Value):-functor(Value,w,2).

is_worldlist_list([Value|_]):-!, is_word_atomic(Value),!.

%% set_pipeline_value(+TID:key, +Name:varspec, +Value:term ).
%
% Set a variable in the Transaction ID 
%
set_pipeline_value(TID,'&'(N1,Name),Value):-!,set_pipeline_value(TID,N1,Value),set_pipeline_value(TID,Name,Value).
set_pipeline_value(TID,Name,Value):-var(Value),var(Name),!,trace_or_throw(var_set_pipeline_value(TID,Name,Value)).
set_pipeline_value(TID,Name:set,Values):- \+ is_worldlist_list(Values), is_list(Values),!,must(( foreach(member(V,Values),set_pipeline_value(TID,Name:unique,V)))).
set_pipeline_value(TID,Name:set,Value):- is_worldlist_list(Value), !,must(set_pipeline_value(TID,Name:unique,Value)).
set_pipeline_value(TID,Name:list,Values):- is_list(Values),!,must(( foreach(member(V,Values),set_pipeline_value(TID,Name,V)))).
set_pipeline_value(TID,Name:list,Value):- !,must(set_pipeline_value(TID,Name,Value)).
set_pipeline_value(TID,Name:reversed_set,RBinders):- reverse(RBinders,Values),set_pipeline_value(TID,Name:set,Values).
set_pipeline_value(TID,Name:reversed,RBinders):- reverse(RBinders,Values),set_pipeline_value(TID,Name:list,Values).
set_pipeline_value(TID,Name:unique,V0):-
   %rename_vars
   renumber_vars_from_0(Name,V0,V),
    ((copy_term(V,CV),clause(pipeline_value(TID,Name,V),true,Ref),clause(pipeline_value(TID,NameC,VC),true,Ref),(NameC:VC)=@=(Name:CV)) ->
        true; flag(TID,OPs,1+OPs)),
        show_call(assertz_if_new(pipeline_value(TID,Name,V))).

set_pipeline_value(TID,Name,Values):- \+ is_worldlist_list(Values), is_list(Values),!,must(( foreach(member(V,Values),set_pipeline_value(TID,Name:unique,V)))).
set_pipeline_value(TID,Name,Value):- is_worldlist_list(Value), !,must(set_pipeline_value(TID,Name:unique,Value)).

set_pipeline_value(TID,Name:Other,Value):-!,trace_or_throw(unknown_set_pipeline_value(TID,Name:Other,Value)).
set_pipeline_value(TID,Name,V0):-  
        %rename_vars
        renumber_vars_from_0(Name,V0,V),
    ((copy_term(V,CV),clause(pipeline_value(TID,Name,V),true,Ref),clause(pipeline_value(TID,NameC,VC),true,Ref),(NameC:VC)=@=(Name:CV)) ->
        true; flag(TID,OPs,1+OPs)),       
        show_call(assertz(pipeline_value(TID,Name,V))).


renumber_vars_from_0(kif(_),V,UV):-V=UV,!.
renumber_vars_from_0(_,V,UV):-unnumbervars(V,UV),rename_vars(UV,UV),numbervars(UV,0,_).



%% clear_pipeline(+TID:key)
%
%  Clean out the Transaction ID 
%
clear_pipeline(TID):-retractall(pipeline_value(TID,_,_)),retractall(pipeline_pass_fail(TID,_,_)).


%% init_pipeline(+TID:key)
%
%  Intialize the Transaction ID with defaults
%
%  when we switch to dictionaries.. we'd prebuild the keys
%
init_pipeline(_ID).


%% run_pipleine( +StartingNameValues:list, +EndingNameValues:list, -AllNameValues:list )
%
%  Run a pipeline to yeild NameValues list
%
run_pipleine(StartingNameValues0,EndingNameValues0,AllNameValues):- 
      flatten([StartingNameValues0],StartingNameValues),
      flatten([EndingNameValues0],EndingNameValues),      
      gensym(pipline,TID),clear_pipeline(TID),init_pipeline(TID),
      forall(member(Name=Value,StartingNameValues),set_pipeline_value(TID,Name,Value)),
      run_pipeline_id(TID,EndingNameValues),
      findall(Name=Values,((no_repeats(Name,pipeline_value(TID,Name,_)),findall(Value,pipeline_value(TID,Name,Value),Values))),AllNameValues),
      show_pipeline(TID),
      clear_pipeline(TID),!.


%% text_pipeline( +Text:acetext, +NameValues:list )
%
%  Runs Transaction ID with acetext
%
text_pipeline(AceText,AllNameValues):- run_pipleine([acetext=AceText],[untildone=_],AllNameValues).

%% run_pipeline_id( +TID:key, +NameValuesWaiting:list )
%
%  Runs Transaction ID until NameValuesWaiting is grounded
%
run_pipeline_id(TID,NameValuesWaiting):- 
  findall(N=V, (member(N=VF,NameValuesWaiting),(pipeline_value(TID,N,V)->VF=val(V);VF=_)), List),
  (\+ member(_=error(_),List) -> (true,!);
   (((flag(TID,OPs,0), ((OPs==0 -> (true,!) ; (forall(installed_converter(CNV),try_converter(TID,CNV)),run_pipeline_id(TID,NameValuesWaiting)))))))).

% show stat
show_pipeline(TID):-
  forall(pipeline_value(TID,Name,Value),wdmsg(pipeline_value(TID,Name,Value))),
  forall(pipeline_pass_fail(TID,Name,Value),wdmsg(pipeline_pass_fail(TID,Name,Value))).

show_pipeline:-forall(installed_converter(CNV),wdmsg(installed_converter(CNV))).


:- user:ignore(( Z = ('/'),current_op(X,Y,Z),display(:-(op(X,Y,Z))),nl,fail)).
:- user:ignore((Z = (':'),current_op(X,Y,Z),display(:-(op(X,Y,Z))),nl,fail)).
:- user:ignore((Z = ('-'),current_op(X,Y,Z),display(:-(op(X,Y,Z))),nl,fail)).
:- dmsg(parser_all_start).


% ================================================================================================
% PLDATA: LOAD ENGLISH CORE FILES
% ================================================================================================

% :- time(ignore((absolute_file_name(library(el_holds/'el_assertions.pl.qlf'),AFN),(exists_file(AFN)->true;qcompile(library(el_holds/'el_assertions.pl.hide')))))).

get_it:- 
 time(ignore((absolute_file_name(library(el_holds/'el_assertions.pl.qlf'),AFN),   
  (exists_file(AFN)->true;(
    (absolute_file_name(library(el_holds),AFND),sformat( S, 'curl --compressed http://prologmoo.com/devel/LogicmooDeveloperFramework/PrologMUD/pack/pldata_larkc/prolog/el_holds/el_assertions.pl.qlf > ~w/el_assertions.pl.qlf',[AFND]),
    shell(S))))))).


:- dmsg("Loading loading language data (This may take 10-15 seconds)").

% 
% gripe_time(warn(12.246577455>7),        user:time(user:ensure_loaded_no_mpreds(library(el_holds/'el_assertions.pl.qlf')))).
% OLD :- gripe_time(7,time(user:ensure_loaded_no_mpreds(library(el_holds/'el_assertions.pl.qlf')))).

% 6.052 CPU on VMWare I7



:- 
%  with_assertions
%  [(user:term_expansion(_,_):-!,fail),(user:goal_expansion(_,_):-!,fail),(system:term_expansion(_,_):-!,fail),(system:goal_expansion(_,_):-!,fail)],
  (user:ensure_loaded_no_mpreds(library(logicmoo/plarkc/logicmoo_i_call_kb)),
   load_language_file(pldata/clex_iface),
   load_language_file(pldata/nldata_BRN_WSJ_LEXICON),
   if_defined(skip_el_assertions,load_language_file(library(el_holds/el_assertions))),
   load_language_file(pldata/nldata_freq_pdat),
   load_language_file(pldata/nldata_cycl_pos0)),!.




% ================================================================================================
:- include(parser_ape).
%:- user:ensure_loaded_no_mpreds('AceRules/engine/run_testcases').
% ================================================================================================

:- install_converter(ace_to_drs:call_tokenizer(+acetext, +(guess,on), -sentences:set, -sentencesToParse)).
:- install_converter(ace_to_drs:paragraphs_to_drs(+sentences:list, +(guess,on), +(catch,off), +(startID,1), -sentences, -syntaxTrees, -drs0, -messages, -time)).
:- install_converter(ace_to_drs:call_parser(+sentences:list, +(startID,1), -syntaxtrees, -(drs0,reversed_set))).
:- install_converter(ace_to_drs:acetext_to_drs(+acetext, -sentences:set, -syntaxTrees, -drs0, -messages)).
:- install_converter(tokenizer:tokenize(+acetext, -tokens)).
:- install_converter(tokens_to_sentences:tokens_to_sentences(+tokens:set, -sentences:set)).
:- install_converter(tokens_to_sentences:tokens_to_paragraphs(+tokens:set, -sentences:set)).
:- install_converter(drs_fol_pnf:drs_pnf(+drs, -fol)).
:- install_converter(drs_fol_pnf:drs_fol(+drs, -pnf)).

:- install_converter(get_ape_results:fol_to_pkif(+pnf, -kif(p))).
:- install_converter(get_ape_results:fol_to_pkif(+fol, -kif(f))).
:- install_converter(get_ape_results:fol_to_pkif(+drs, -kif(d))).
:- install_converter(get_ape_results:fol_to_pkif(+sdrs, -kif(s))).

:- install_converter(drs_to_ace(+drs0, -paraphrase:set)).
:- install_converter(drs_to_drslist:drslist_to_ace(+drs0:list, -paraphrase:set)).
:- install_converter(drs_to_drslist:drs_to_drslist(+drs0, -drs:set)).
:- install_converter(drs_to_sdrs:drs_to_sdrs(+drs, -sdrs)).


% ================================================================================================
% CHAT80:  acetext,  text_no_punct, pos_sents_pre,  syntaxTree80,  sem80, query80
:- user:ensure_loaded_no_mpreds(parser_chat80).
% ================================================================================================

was_punct(Remove):-domain(WRemove,[(,),(.),(?),(!)]),
  (domain(Remove,[w(_,punc),w(WRemove,_)]);Remove=WRemove).
remove_punctuation(W2,NP):-  (was_punct(Remove),delete(W2,Remove,W3),W2 \=@= W3)  -> remove_punctuation(W3,NP) ; NP=W2.
:- install_converter(parser_chat80:words_to_w2(+acetext,-pos_sents_pre)).
:- install_converter(remove_punctuation(+pos_sents_pre,-text_no_punct)).
:- install_converter(parser_chat80:sent_to_parsed(+text_no_punct,-syntaxTree80)).
:- install_converter(parser_chat80:i_sentence(+syntaxTree80,-sem_pre80)).
:- install_converter(parser_chat80:clausify80(+sem_pre80,-sem80)).
:- install_converter(parser_chat80:qplan(+sem80,-query80)).

:-dynamic(partOfSpeech/3).
:-dynamic(determinerStrings/2).




:-asserta((type(SET):-tSet(SET))).

% ================================================================================================
% CHAT80:  
:- user:ensure_loaded_no_mpreds(parser_e2c). % TODO confirm CHAT80 runs without E2C
% ================================================================================================

:- debug.


% ================================================================================================
%:- user:ensure_loaded_no_mpreds(parser_candc).
% ================================================================================================

% ================================================================================================
%:- user:ensure_loaded_no_mpreds(parser_chart89).
% ================================================================================================

% ================================================================================================
%:- user:ensure_loaded_no_mpreds(parser_talk).
% ================================================================================================


% ================================================================================================
:- user:ensure_loaded_no_mpreds(stanford_parser).
% ================================================================================================
% :- get_pos_tagger(I),jpl_set(I,is_DEBUG,'@'(false)).


:- dynamic is_cyckb_t_pred/2.
:- dynamic is_cyckb_t_pred_rename/2.

:- dmsg("Scanning el_assertions.pl for programatic definations (This may take 10-30 seconds)").
%:- pfc_add(cyckb_t(A, _, _) ==> is_cyckb_t_pred(A,2)).
:- with_el_holds_enabled(gripe_time(10,forall(cyckb_t(A, _, _) , assert_if_new(is_cyckb_t_pred(A,2))))).
%:- pfc_add(cyckb_t(A, _, _, _ ) ==> is_cyckb_t_pred(A,3)).
:- with_el_holds_enabled(gripe_time(2,forall(cyckb_t(A, _, _, _) , assert_if_new(is_cyckb_t_pred(A,3))))).
%:- pfc_add(cyckb_t(A, _, _, _, _ ) ==> is_cyckb_t_pred(A,4)).
:- with_el_holds_enabled(gripe_time(2,forall(cyckb_t(A, _, _,_ ,_ ) , assert_if_new(is_cyckb_t_pred(A,4))))).
:- with_el_holds_enabled(gripe_time(2,forall(cyckb_t(A, _, _,_ ,_,_ ) , assert_if_new(is_cyckb_t_pred(A,5))))).

:- dmsg("Implementing programatic definations (This shoiuld take less than 2 seconds)").
% :- pfc_add((is_cyckb_t_pred(F,A) ==> {functor(H,F,A),H=..[F|ARGS],KB=..[cyckb_t,F|ARGS],assert_if_new((H:-KB))})).
:- gripe_time(2,forall(is_cyckb_t_pred(F,A) , ignore((atom(F),functor(H,F,A),H=..[F|ARGS],KB=..[cyckb_t,F|ARGS],logOnErrorIgnore(assert_if_new((H:- \+(el_holds_DISABLED_KB), KB))))))).



% ================================================================================================



% ================================================================================================
% TODO Not yet started 
:- user:ensure_loaded_no_mpreds(parser_CURT).
% ================================================================================================

% ================================================================================================
% TODO - grovel the API
:- user:ensure_loaded_no_mpreds(parser_regulus).
% ================================================================================================

% ================================================================================================
% TODO - grovel the API
:- user:ensure_loaded_no_mpreds(parser_SUPPLE).
% ================================================================================================

% ================================================================================================
% TODO - grovel the API
:- user:ensure_loaded_no_mpreds(parser_SIRIDUS).
% ================================================================================================

% ================================================================================================
% TODO - grovel the API
:- user:ensure_loaded_no_mpreds(parser_ProNTo).
% ================================================================================================

:- dmsg("List of possible data transformations").


:- show_pipeline.


:- dmsg(parser_all_complete).


user:sanity_test:- run_pipleine(acetext='All persons are happy.',[foo=_],O),wdmsg(O).
user:regression_test:- run_pipleine(acetext='What is the ocean that borders african countries and, that borders asian countries?',[foo=_],O),wdmsg(O).
user:regression_test_TODO:- run_pipleine(acetext='A person who loves all animals is loved by someone.',[foo=_],O),wdmsg(O).

user:regression_test:- ace_to_pkif('A person who loves all animals is loved by someone.',X),kif_to_boxlog(X,BOX),portray_clause(user_error,(fol:-BOX)),!.

% som3how this next directive changes  -/1 op?
:- ace_to_pkif('A person who loves all animals is loved by someone.',X),kif_to_boxlog(X,BOX),portray_clause(user_error,(fol:-BOX)),!.
:- op(300,fx,(-)).


user:regression_test:- gripe_time(5,test_chat80_sanity).


% :- must(retract(thlocal:disable_mpred_term_expansions_locally)).


:-asserta(thlocal:disable_mpred_term_expansions_locally).


% set  -/1 op 
:- op(200,fy,(-)).
:- must((current_op(P,FXY,(-)),((arg(_,v(fy,fx),FXY),P =< 300)))).


