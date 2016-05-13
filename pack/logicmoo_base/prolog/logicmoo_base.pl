/*   
  LogicMOO Base FOL/PFC Setup
% Dec 13, 2035
% Douglas Miles

*/
:- if(( system:use_module(system:library('logicmoo/util/logicmoo_util_filesystem.pl')), push_modules)). 
:- endif.
:- module(logicmoo_base_file,[]).
% restore entry state
:- reset_modules.

:- if( \+ current_predicate(system:setup_call_cleanup_each/3)).
:- use_module(system:library('logicmoo/util/logicmoo_util_supp.pl')).
:- endif.

:- use_module(library(logicmoo_utils)).

/*
% lmconf:startup_option(datalog,sanity). %  Run datalog sanity tests while starting
% lmconf:startup_option(clif,sanity). %  Run datalog sanity tests while starting
:- set_prolog_flag(report_error,true).
:- set_prolog_flag(fileerrors,false).
:- set_prolog_flag(access_level,system).
:- set_prolog_flag(debug_on_error,true).
:- set_prolog_flag(debug,true).
:- set_prolog_flag(gc,false).
:- set_prolog_flag(gc,true).
:- set_prolog_flag(optimise,false).
:- set_prolog_flag(last_call_optimisation,false).
:- debug.
:- Six = 6, set_prolog_stack(global, limit(Six*10**9)),set_prolog_stack(local, limit(Six*10**9)),set_prolog_stack(trail, limit(Six*10**9)).
*/

:- multifile '$si$':'$was_imported_kb_content$'/2.
:- dynamic '$si$':'$was_imported_kb_content$'/2.
:- discontiguous('$si$':'$was_imported_kb_content$'/2).
:- multifile(lmconf:mpred_is_impl_file/2).
:- dynamic(lmconf:mpred_is_impl_file/2).

:- source_location(F,_),asserta(lmconf:ignore_file_mpreds(F)).

:- multifile lmconf:startup_option/2. 
:- dynamic lmconf:startup_option/2. 
:- multifile lmconf:mpred_system_status/2.
:- dynamic lmconf:mpred_system_status/2.
:- multifile(t_l:disable_px/0).
:- thread_local(t_l:disable_px/0).

:- multifile(abox:defaultTBoxMt/1).
:- dynamic(abox:defaultTBoxMt/1).

lmconf:mpred_skipped_module(eggdrop).
:- forall(current_module(CM),system:assert(lmconf:mpred_skipped_module(CM))).
:- retractall(lmconf:mpred_skipped_module(pfc)).


% ================================================
% DBASE_T System
% ================================================    

:-use_module(system:library('logicmoo/mpred/mpred_at_box.pl')).
:-use_module(system:library('logicmoo/mpred/mpred_expansion.pl')).
:-use_module(system:library('logicmoo/mpred/mpred_kb_ops.pl')).
:-use_module(system:library('logicmoo/mpred/mpred_listing.pl')).
:-use_module(system:library('logicmoo/snark/common_logic_sexpr.pl')).
:-use_module(system:library('logicmoo/mpred/mpred_loader.pl')).
:-use_module(system:library('logicmoo/mpred/mpred_pfc.pl'),except([op(_,_,_)])).
:-use_module(system:library('logicmoo/mpred/mpred_prolog_file.pl')).
:-use_module(system:library('logicmoo/mpred/mpred_props.pl')).
:-use_module(system:library('logicmoo/mpred/mpred_storage.pl')).
:-use_module(system:library('logicmoo/mpred/mpred_stubs.pl')).
:-use_module(system:library('logicmoo/mpred/mpred_type_constraints.pl')).
:-use_module(system:library('logicmoo/mpred/mpred_type_isa.pl')).
:-use_module(system:library('logicmoo/mpred/mpred_type_naming.pl')).
:-use_module(system:library('logicmoo/mpred/mpred_type_wff.pl')).
:-use_module(system:library('logicmoo/mpred/mpred_type_args.pl')).
:-use_module(system:library('logicmoo/mpred/mpred_agenda.pl')).
:-use_module(system:library('logicmoo/snark/common_logic_boxlog.pl')).
:-use_module(system:library('logicmoo/snark/common_logic_skolem.pl')).
:-use_module(system:library('logicmoo/snark/common_logic_compiler.pl'),except([op(_,_,_)])).
:-use_module(system:library('logicmoo/snark/common_logic_snark.pl'),except([op(_,_,_)])).
:-use_module(system:library('logicmoo/snark/common_logic_kb_hooks.pl')).
% :-use_module(system:library('logicmoo/mpred/mpred_*.pl')).

:-use_module(system:library('logicmoo/mpred/mpred_hooks.pl')).
:-use_module(baseKB:library('logicmoo/mpred/mpred_userkb.pl')).

:- reset_modules.

:- thread_local t_l:side_effect_ok/0.

system:goal_expansion(I,P1,O,P2):- current_prolog_flag(mpred_te,true),mpred_expander(goal,system,I,P1,O,P2).
system:term_expansion(I,P1,O,P2):- current_prolog_flag(mpred_te,true),mpred_expander(term,system,I,P1,O,P2).

/*

:- autoload. % ([verbose(false)]).

bad_thing_to_do:- doall((clause(wsh_w:wrap_shared(F,A,ereq),Body),
    retract(( wsh_w:wrap_shared(F,A,ereq):- Body )), 
      between(0,9,A),ain((arity(F,A),pfcControlled(F),prologHybrid(F))),fail)).

% :- doall((current_module(W),import_module(W,system),\+ import_module(W, user), W\==baseKB, add_import_module(lmcode,W,end))).

*/
%:- dmsg("Adding logicmoo/[snark|mpred[online]] to autoload path",[]).
%:- add_library_search_path('./logicmoo/snark/',[ '*.pl']).
%:- add_library_search_path('./logicmoo/mpred/',[ 'mpred_*.pl']).
%:- must(add_library_search_path('./logicmoo/mpred_online/',[ '*.pl'])).
% :- add_library_search_path('./logicmoo/',[ '*.pl']).
% :- add_library_search_path('./plarkc/',[ '*.pl']).
% :- add_library_search_path('./pttp/',[ 'dbase_i_mpred_*.pl']).

%lmconf:sanity_check:- findall(U,(current_module(U),default_module(U,baseKB)),L),must(L==[baseKB]).
lmconf:sanity_check:- doall((current_module(M),setof(U,(current_module(U),default_module(U,M),U\==M),L),
     wdmsg(imports_eache :- (L,[sees(M)])))).
lmconf:sanity_check:- doall((current_module(M),setof(U,(current_module(U),default_module(M,U),U\==M),L),wdmsg(imports(M):-L))).
lmconf:sanity_check:- doall((baseKB:mtProlog(M),
    setof(U,(current_module(U),default_module(M,U),U\==M),L),wdmsg(imports(M):-L))).


:- module_transparent(user:exception/3).
:- multifile user:exception/3.
:- dynamic user:exception/3.
:- multifile system:exception/3.
:- module_transparent system:exception/3.
:- dynamic system:exception/3.

/*
:-ignore((lmconf:source_typein_modules(O, _O, _), O\=user,O\=baseKB,O\=system,
   setup_module_ops(O), add_abox_module(O), set_defaultAssertMt(O))).
*/  

:- set_prolog_flag(retry_undefined,false).

% Enable System
system:exception(undefined_predicate,MFA, Action):- current_prolog_flag(retry_undefined,true),loop_check(mpred_at_box:uses_predicate(MFA, Action)).
user:exception(undefined_predicate,MFA, Action):- current_prolog_flag(retry_undefined,true),loop_check(mpred_at_box:uses_predicate(MFA, Action)).

:- set_prolog_flag(system:unknown,error).
:- set_prolog_flag(user:unknown,error).
:- set_prolog_flag(lmcode:unknown,error).
:- set_prolog_flag(baseKB:unknown,warning).
:- set_prolog_flag(tbox:unknown,warning).
:- set_prolog_flag(abox:unknown,warning).

:- w_tl(t_l:side_effect_ok,doall(call_no_cuts(lmconf:module_local_init(abox,baseKB)))).
% :- forall(lmconf:sanity_check,true).

:- asserta_new((logicmoo_util_database:ainz(G):- !, call(abox:mpred_ainz,G))).
:- asserta_new((logicmoo_util_database:ain(G):- !, call(abox:mpred_ain,G))).
:- asserta_new((logicmoo_util_database:aina(G):- !, call(abox:mpred_aina,G))).

% Load boot base file
user:lmbf:- 
  set_prolog_flag(mpred_te,true),
  set_prolog_flag(pfc_booted,false),
  with_umt(baseKB,
  time((ensure_mpred_file_loaded(baseKB:library(logicmoo/pfc/'system_base.pfc'))))),
  set_prolog_flag(pfc_booted,true).

:- user:lmbf.
:- reset_modules.

:- forall((current_module(M),M\=user,M\=system,M\=baseKB,M\=abox),maybe_add_import_module(M,abox,start)).
:- forall((current_module(M),M\=user,M\=system,M\=baseKB),maybe_add_import_module(M,baseKB,start)).



