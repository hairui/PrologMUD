/** <module> 
% All modules are declared here so that this next lines dont have to be pasted into every file.
% Since this list will need at least 160 entries to cover the obj classes rooms and commands, 
% we add the modules here to not waste 160^2 lines of text and having to not 
% update 160+ files whenever a new module is used
%
% Logicmoo Project PrologMUD: A MUD server written in Prolog
% Maintainer: Douglas Miles
% Dec 13, 2035
%
*/

:- if( \+ current_predicate( thlocal:current_pttp_db_oper/1 )).

:- thread_local(thlocal:disable_mpred_term_expansions_locally /0).
:- multifile(system:term_expansion/2).
:- multifile(user:term_expansion/2).
:- multifile(user:goal_expansion/2).


:- multifile(thlocal:current_pttp_db_oper/1).
:- thread_local(thlocal:current_pttp_db_oper/1).

:- dynamic(new_was_isa/0).
:- multifile(new_was_isa/0).

:- dynamic(pfc_univ/3).
:- multifile(pfc_univ/3).

:-dynamic(user:hook_one_second_timer_tick/0).
:-multifile(user:hook_one_second_timer_tick/0).
:-dynamic(user:hook_one_minute_timer_tick/0).
:-multifile(user:hook_one_minute_timer_tick/0).

:- dynamic(completelyAssertedCollection/1).
:- multifile(completelyAssertedCollection/1).
:- dynamic(((tCol/1,tFunction/1,tSet/1,mpred_module/2))).
:- multifile(((tCol/1,tFunction/1,tSet/1,mpred_module/2))).
:- dynamic(ttPredType/1).
:- multifile(ttPredType/1).
:- dynamic(functorDeclares/1).
:- multifile(functorDeclares/1).
:- dynamic(ttFormatType/1).
:- multifile(ttFormatType/1).
:- dynamic(tPred/1).
:- multifile(tPred/1).
:- dynamic(tRelation/1).
:- multifile(tRelation/1).
:- dynamic(arity/2).
:- multifile(arity/2).
:- dynamic((neg)/1).
:- multifile((neg)/1).

:- dynamic(ttUnverifiableType/1).
:- multifile(ttUnverifiableType/1).

:- dynamic(type_prefix/2).
:- multifile(type_prefix/2).

:- dynamic(type_suffix/2).
:- multifile(type_suffix/2).


:- dynamic(pfcControlled/1).
:- multifile(pfcControlled/1).

:- dynamic(agent_text_command/4).
:- multifile(agent_text_command/4).

:- dynamic(arity/2).
:- multifile(arity/2).



:- dynamic(('=>')/1).
:- dynamic((('neg'))/1).
:- dynamic((('=>'))/2).
:- dynamic(('<=')/2).
:- dynamic(('::::')/2).
:- dynamic(('<=>')/2).
:- dynamic('pt'/2).
:- dynamic('pk'/3).
:- dynamic('nt'/3).
:- dynamic('bt'/2).

:- dynamic('spft'/3).
:- dynamic(pfc_undo_method/2).
:- dynamic(fcTmsMode/1).
:- dynamic(pfc_queue/2).
:- dynamic(pfc_halt_signal/1).
:- dynamic(pfc_select/2).
:- dynamic(pfc_search/1).

:- multifile(('=>')/1).
:- multifile(('neg')/1).
:- multifile(('=>')/2).
:- multifile(('<=')/2).
:- multifile(('::::')/2).
:- multifile(('<=>')/2).
:- multifile('pt'/2).
:- multifile('pk'/3).
:- multifile('nt'/3).
:- multifile('bt'/2).
:- multifile(pfc_undo_method/2).
:- multifile((pfc_action)/1).
:- multifile(fcTmsMode/1).
:- multifile(pfc_queue/2).
:- multifile(pfc_halt_signal/1).
:- multifile(pfc_select/2).
:- multifile(pfc_search/1).

:- dynamic(formatted_resultIsa/2).
:- multifile(formatted_resultIsa/2).

:- dynamic(user:asserted_argIsa_known/3).
:- dynamic(user:argQuotedIsa/3).
:- dynamic(user:resultGenls/2).
:- multifile(user:resultGenls/2).

:- dynamic(user:argGenls/3).
:- multifile(user:argGenls/3).

:- dynamic(user:prologSideEffects/1).
:- multifile(user:prologSideEffects/1).

:- dynamic(user:argsQuoted/1).
:- multifile(user:argsQuoted/1).

:- dynamic(user:disjointWith/2).
:- multifile(user:disjointWith/2).


:- dynamic(was_chain_rule/1).
:- multifile(was_chain_rule/1).


:- dynamic(is_edited_clause/3).
:- multifile(is_edited_clause/3).



:-thread_local(thlocal:print_mode/1).

%:-dynamic((t/1,t/2)).
:- dynamic((
         % t/1,
         % t/2,
          t/3,
          t/4,
          t/5,
          t/6,
          t/7,
          t/8,
          t/9,
          t/10,
          t/11,
        %  asserted_mpred_t/1,
          asserted_mpred_t/2,
          asserted_mpred_t/3,
          asserted_mpred_t/4,
          asserted_mpred_t/5,
          asserted_mpred_t/6,
          asserted_mpred_t/7,
          assertion_f/1,
          assertion_t/1,
        %  asserted_mpred_f/1,
          asserted_mpred_f/2,
          asserted_mpred_f/3,
          asserted_mpred_f/4,
          asserted_mpred_f/5,
          asserted_mpred_f/6,
          asserted_mpred_f/7,
         % mpred_f/1,
          mpred_f/2,
          mpred_f/3,
          mpred_f/4,
          mpred_f/5,
          mpred_f/6,
          mpred_f/7)).

:-multifile((t/1,t/2)).
:- multifile((
         % t/1,
        %  t/2,
          t/3,
          t/4,
          t/5,
          t/6,
          t/7,
          t/8,
          t/9,
          t/10,
          t/11,
        %  asserted_mpred_t/1,
          asserted_mpred_t/2,
          asserted_mpred_t/3,
          asserted_mpred_t/4,
          asserted_mpred_t/5,
          asserted_mpred_t/6,
          asserted_mpred_t/7,
          assertion_f/1,
          assertion_t/1,
        %  asserted_mpred_f/1,
          asserted_mpred_f/2,
          asserted_mpred_f/3,
          asserted_mpred_f/4,
          asserted_mpred_f/5,
          asserted_mpred_f/6,
          asserted_mpred_f/7,
         % mpred_f/1,
          mpred_f/2,
          mpred_f/3,
          mpred_f/4,
          mpred_f/5,
          mpred_f/6,
          mpred_f/7)).

:- op(500,fx,'~').
:- op(1050,xfx,('=>')).
:- op(1050,xfx,'<=>').
:- op(1050,xfx,('<=')).
:- op(1100,fx,('=>')).
:- op(1150,xfx,('::::')).

:-dynamic(user_db:grant_openid_server/2).
:-multifile(user_db:grant_openid_server/2).

:- dynamic user:'$was_imported_kb_content$'/2.
:- multifile user:'$was_imported_kb_content$'/2.
:- discontiguous(user:'$was_imported_kb_content$'/2).

:- user:ensure_loaded(library(logicmoo/util/logicmoo_util_all)).

:-foreach(arg(_,isEach(prologMultiValued,prologOrdered,prologNegByFailure,meta_argtypes,prologPTTP,
 prologHybrid,predCanHaveSingletons,prologDynamic,tCol,prologMacroHead,prologListValued,prologSingleValued,functorDeclares),P),
   ((dynamic(P/1),multifile(P/1)))).

:- multifile user:listing_mpred_hook/1.
:- dynamic user:listing_mpred_hook/1.

:- dynamic user:genls/2.
:- dynamic user:isa/2.
:- dynamic user:mudKeyword/2.
:- multifile user:mudKeyword/2.
:- multifile user:genls/2.
:- multifile user:isa/2.

%:- dynamic t/2.
%:- multifile t/2.

:- style_check(-singleton).
:- set_prolog_flag(double_quotes, atom).
:- set_prolog_flag(double_quotes, string). 
:- set_prolog_flag(generate_debug_info, true).

% these do not get defined!?
% :-dynamic user_db:assert_user/2, user_db:grant_openid_server/2, user_db:retractall_grant_openid_server/2, user_db:retractall_user/2, user_db:assert_grant_openid_server/2.

:-dynamic((
                     user:argIsa/3,
                     user:isa/2,
                     user:resultIsa/2,
                      user:ttTemporalType/1)).
:-multifile((
                     user:argIsa/3,
                     user:isa/2,
                     user:resultIsa/2,
                      user:ttTemporalType/1)).

:- multifile(mpred_online:semweb_startup).

:- dynamic(thlocal:infForward).
:- dynamic(mpred_module_ready).
:- dynamic thglobal:pfcManageHybrids/0.
:- thread_local thlocal:into_form_code/0.
:- thread_local thlocal:current_why/2.
:- dynamic_multifile_exported user:defnSufficient/2.
:- thread_local user:repl_to_string/2.
:- thread_local user:repl_writer/2.
:- thread_local thlocal:infSupertypeName/0.
:- dynamic_multifile_exported user:loaded_external_kbs/0.
:- dynamic_multifile_exported user:loading_module_h/1.
:- dynamic_multifile_exported user:registered_module_type/2.
:- dynamic_multifile_exported user:already_added_this_round/1.
:- dynamic_multifile_exported user:is_mpred_file/1.

:- multifile user:local_term_anglify/2.
:- multifile user:term_anglify_last/2.
:- multifile user:term_anglify_np/3.
:- multifile user:term_anglify_np_last/3.

% HOOKS
:- multifile user:create_random_fact/1.
:- multifile user:decl_coerce/3.
:- multifile user:decl_database_hook/2.
:- multifile user:deduce_facts/2.
:- multifile user:default_type_props/3.
:- multifile user:fact_always_true/1.
:- multifile user:fact_is_false/2.
:- multifile user:fact_maybe_deduced/1.
:- multifile user:tms_reject_why/2.
:- multifile user:fskel/7.
:- multifile user:hook_coerce/3.
:- dynamic user:hook_coerce/3.
:- multifile user:hooked_random_instance/3.

:- multifile user:now_unused/1.
:- multifile user:provide_mpred_read_attributes/3.
:- multifile user:provide_mpred_setup/4.
:- multifile user:provide_mpred_storage_clauses/3.
:- multifile user:provide_mpred_storage_op/2.
:- multifile user:provide_mpred_write_attributes/2.

% DYN HOOKS
:- dynamic_multifile_exported user:is_never_type/1.

% DYN FOR CODE
:- dynamic_multifile_exported thglobal:after_mpred_load/0.
:- dynamic_multifile_exported thglobal:use_cyc_database/0.
:- dynamic_multifile_exported thglobal:agent_session/2.

:- dynamic_multifile_exported user:fact_is_false/2.
:- dynamic_multifile_exported user:kbp_t_list_prehook/2.


% DYN KB
:- dynamic_multifile_exported user:only_if_pttp/0.
:- dynamic_multifile_exported user:use_kif/2.
:- dynamic_multifile_exported user:is_mpred_prop/2.
%:- dynamic_multifile_exported user:hasInstance_dyn/2.
:- dynamic_multifile_exported user:arity/2.
:- dynamic_multifile_exported user:mpred_prop/2.
:- dynamic_multifile_exported user:relationMostInstance/3.
:- dynamic_multifile_exported user:'<=>'/2.
% :- dynamic_multifile_exported user:ruleForward/2.
:- dynamic_multifile_exported user:ruleRewrite/2.
% :- dynamic_multifile_exported user:ruleBackward/2.
:- dynamic_multifile_exported user:tNearestReachableItem/1.
:- dynamic_multifile_exported user:tFarthestReachableItem/1.
:- dynamic_multifile_exported deduceFromArgTypes/1.
:- dynamic_multifile_exported prologSideEffects/1.

:-dynamic agent_action_queue/3.
:-multifile agent_action_queue/3.

% ================================================
% Thread Locals
% ================================================

:- thread_local thlocal:consulting_sources/0.
:- thread_local thlocal:already_in_file_term_expansion/0.
:- thread_local thlocal:agent_current_action/2.
:- thread_local thlocal:caller_module/2.
:- thread_local thlocal:mpred_opcall/2.
:- thread_local thlocal:deduceArgTypes/1.
:- thread_local thlocal:side_effect_ok/0.
:- thread_local thlocal:agenda_slow_op_do_prereqs/0.
:- thread_local thlocal:enable_src_loop_checking/0.
:- thread_local thlocal:in_dynamic_reader/1.
:- thread_local thlocal:in_prolog_source_code/0.
:- thread_local thlocal:is_calling/0.
:- thread_local thlocal:infAssertedOnly/1.
:- thread_local thlocal:infInstanceOnly/1.
:- thread_local thlocal:infSkipArgIsa/0.
:- thread_local thlocal:infSkipFullExpand/0.
:- thread_local thlocal:into_form_code/0.
:- thread_local thlocal:inVoProp/0.
:- thread_local thlocal:no_arg_type_error_checking/0.
:- thread_local thlocal:noDBaseHOOKS/1.
:- thread_local thlocal:noDBaseMODs/1.
:- thread_local thlocal:noRandomValues/1.
:- thread_local thlocal:agenda_suspend_scans/0.
:- thread_local thlocal:tracing80/0.
:- thread_local thlocal:useAltPOS/0.
:- thread_local thlocal:useOnlyExternalDBs/0.
:- thread_local thlocal:usePlTalk/0.
:- thread_local thlocal:with_callMPred/1.
:- thread_local thlocal:assert_op_override/1.

:- dynamic   thglobal:session_io/4, thglobal:session_agent/2, thglobal:agent_session/2, user:telnet_fmt_shown/3, user:agent_action_queue/3.
:- multifile thglobal:session_io/4, thglobal:session_agent/2, thglobal:agent_session/2, user:telnet_fmt_shown/3, user:agent_action_queue/3.
:- thread_local(infSecondOrder/0).
:- thread_local(infThirdOrder/0).

:- dynamic_multifile_exported(thglobal:use_cyc_database/0).
:- thread_local(thlocal:already_in_file_term_expansion/0).
:- thread_local(thlocal:assert_op_override/1).
:- thread_local(thlocal:caller_module/2).
:- thread_local(thlocal:consulting_sources/0).
:- thread_local(thlocal:deduceArgTypes/1).
:- thread_local(thlocal:enable_src_loop_checking/0).
:- thread_local(thlocal:in_prolog_source_code/0).
:- thread_local(thlocal:infMustArgIsa/0).
:- thread_local(thlocal:infSkipArgIsa/0).
:- thread_local(thlocal:infSkipFullExpand/0).
:- thread_local(thlocal:is_calling/0).
:- thread_local(thlocal:mpred_opcall/2).
:- thread_local(thlocal:mpred_pfc_add_loaded/0).
:- thread_local(thlocal:noDBaseHOOKS/1).
:- thread_local(thlocal:noDBaseMODs/1).
:- thread_local(thlocal:pfc_loads_file/0).
:- thread_local(thlocal:with_callMPred/1).
:- dynamic_multifile_exported(user:isa_pred_now_locked/0).
:- dynamic_multifile_exported(user:pfc_manages_unknowns/0).

:- dynamic_multifile_exported(user:props/2).
:- dynamic_multifile_exported(user:props/2).


:- thread_local repl_to_string/2.
:- thread_local repl_writer/2.

:- endif.
