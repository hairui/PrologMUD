/* <module> logicmoo_plarkc - special module hooks into the logicmoo engine allow
%   clif syntax to be recocogized via our CycL/KIF handlers 
% 
% Logicmoo Project: A LarKC Server written in Prolog
% Maintainer: Douglas Miles
% Dec 13, 2035
%
*/
:- module(logicmoo_snark,[
  load_snark/0,mpred_load_restore_file/1,mpred_load_restore_file/1,mpred_save_restore_file/1,ensure_autoexec/0,
  with_ukb_snark/2]).

:- module_transparent((
  load_snark/0,mpred_load_restore_file/1,mpred_load_restore_file/1,mpred_save_restore_file/1,ensure_autoexec/0,
  with_ukb_snark/2)).

% 	 	 
%% with_ukb_snark( ?VALUE1, ?VALUE2) is semidet.
%
% Hook To [with_ukb_snark/2] For Module Logicmoo_snark.
% Using Ukb Snark.
%
with_ukb_snark(KB,G):- with_umt(KB,G).

%:- use_module(logicmoo_utils).
%:- system:initialization(use_listing_vars).

% :- ensure_loaded(library(logicmoo_base)).

%:- add_import_module(baseKB,system,end).
%:- initialization(maybe_add_import_module(baseKB,system,end)).
% :- with_ukb_snark(baseKB,baseKB:use_module(baseKB:logicmoo_base)).

:-export(checkKB:m1/0).

% 	 	 
%% m1 is semidet.
%
% Hook To [checkkb:m1/0] For Module Logicmoo_snark.
% Module Secondary Helper.
%
%:- add_library_search_path('./mpred_online/',[ '*.pl']).
checkKB:m1:- gripe_time(40,ensure_loaded(baseKB:logicmoo(mpred_online/mpred_www))),if_defined(ensure_webserver), make,list_undefined.

% :- hook_message_hook.
% :- set_prolog_flag(verbose_autoload,false).
% :- set_prolog_flag(verbose_load,true).
% m9   :-asserta_if_new((user:term_expansion(I,O):- lmbase_expansion(term,user,I,O))).
%m31 :-   (F = mpred/_),foreach(must(baseKB:mpred_is_impl_file(F)),must_det_l((dmsg(list_file_preds(F)),ensure_loaded(F),export_file_preds(F),list_file_preds(F)))).
%m32:- rtrace(ensure_mpred_system).
% m33:- must(filematch_ext(['',mpred,ocl,moo,plmoo,pl,plt,pro,p,'pl.in',pfc,pfct],logicmoo_user:pfc/mpred,W)),dmsg(W),!.

%:-export(m2/0).
% m2:- ensure_mpred_file_loaded(logicmoo(pfc/relationAllExists)).

% :-ain(((P,Q,z(_))==>(p(P),q(Q)))).
%:-export(m3/0).
% m3:- put_variable_names( ['P'=P,'Q'=Q]), R = (==>((P,Q,z(_)),(p(P),q(Q)))),  renumbervars(write_functor,R,O), writeq(O).
%   put_variable_names( ['P'=P,'Q'=Q]), R = (==>((P,Q,z(_)),(p(P),q(Q)))), write_term(R,[numbervars(true),protray(_)]),renumbervars_prev(R,O).

%:-export(m4/0).


%m5 :- enable_mpred_system(baseKB).


ensure_autoexec:- with_ukb_snark(baseKB,baseKB:ensure_mpred_file_loaded(baseKB:logicmoo(pfc/'autoexec.pfc'))).

%:- use_listing_vars.
%:- autoload([verbose(false)]).
%:- use_listing_vars.
%:- nop((autoload,scan_for_varnames)).

mpred_load_restore_file(never):- !,ensure_autoexec,!.
mpred_load_restore_file(File):- absolute_file_name(File,AFN),AFN\=File,!,mpred_load_restore_file(AFN).
mpred_load_restore_file(File):- \+ exists_file(File),
  ensure_autoexec, !,
  mpred_save_restore_file(File),!.

mpred_load_restore_file(File):-
  must_det_l((
  time_file(File,Time),
  qcompile(File),
  ensure_loaded(File),
   ((\+ (baseKB:loaded_file_world_time(N,_,NewTime),NewTime>=Time)) ->true ;
    (
    ignore((baseKB:loaded_file_world_time(N,_,NewTime),NewTime>Time,with_ukb_snark(baseKB,baseKB:ensure_mpred_file_loaded(baseKB:N)),fail)),
    mpred_save_restore_file('some_test.pl~'))))),!.

mpred_save_resore_predicate(M:H,AFN):-
   functor(H,F,A),
   format('~N:- multifile(~q:(~q)/~q).~n',[M,F,A]),
   once((prolog_listing:list_declarations(M:H,M))),
   clause(M:H,B,R), 
   once(clause_property(R,file(AFN));\+clause_property(R,file(_))),
   ignore(once(get_clause_vars(H:-B))),
   prolog_listing:portray_clause((H:-B)).


mpred_save_restore_file(File):- 
 must_det_l((   
  absolute_file_name(File,AFN),
   tell(AFN), 
   format('~N:- ~q.~n',['$set_source_module'(basePFC)]),
   format('~N:- style_check(-singleton).'),  
   listing(_),
   flush_output,
   format('~N:- style_check(-singleton).'),
   format('~N:- ~q.~n',['$set_source_module'(baseKB)]),
   ignore((
   cur_predicate(_,baseKB:H),
    mpred_save_resore_predicate(baseKB:H,AFN),
   flush_output,
   fail)),!,
      format('~N:- ~q.~n',['$set_source_module'(baseKB)]),
      format('~N:- style_check(-singleton).~n'),
      listing(baseKB:loaded_file_world_time/3),
      flush_output,
   told)),!.
  


load_snark:- mpred_load_restore_file(never). 






