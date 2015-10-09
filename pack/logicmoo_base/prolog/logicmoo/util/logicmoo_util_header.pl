

:- multifile((term_expansion/2,user:term_expansion/2,system:term_expansion/2)).
:- dynamic((term_expansion/2,user:term_expansion/2,system:term_expansion/2)).

:- multifile
        % '$pldoc'/4,
	user:portray/1,
	user:prolog_list_goal/1,
	user:prolog_predicate_name/2,
	user:prolog_clause_name/2,
        lmconf:mpred_is_impl_file/1.
:- dynamic
	user:portray/1,
        lmconf:mpred_is_impl_file.

:- prolog_load_context(source,F), 
   once(lmconf:mpred_is_impl_file(F);asserta(lmconf:mpred_is_impl_file(F))).

% ===================================================================
% Creates a warning if we are in the incorrect context
% ===================================================================
/*
:- if(current_predicate(logicmoo_utils:combine_logicmoo_utils/0)).
:- multifile(lmconf:logicmoo_utils_separate/0).
lmconf:logicmoo_utils_separate.
:- set_prolog_flag(generate_debug_info, true).
:- else.
:- \+ lmconf:logicmoo_utils_separate.
:- endif.
*/

% :- style_check(-discontiguous).
% :- style_check(-singleton).
% % :- style_check(-atom).
/*

:- dynamic   user:file_search_path/2.
:- multifile user:file_search_path/2.
user:file_search_path(pack, '../../../../').
:- attach_packs.
:- initialization(attach_packs).
:- user: use_module(library(logicmoo/logicmoo_utils)).

add_pack_dir(UpUp):- prolog_load_context(directory,Dir),   
   DirFor = logicmoo,
   (( \+ file_search_path(DirFor,Dir)) ->asserta(file_search_path(DirFor,Dir));true),
   absolute_file_name(UpUp,Y,[relative_to(Dir),file_type(directory)]),
   (( \+ file_search_path(pack,Y)) ->asserta(file_search_path(pack,Y));true),
   attach_packs.
*/


:- use_module(logicmoo_util_first).
:- use_module(logicmoo_util_database).
:- use_module(logicmoo_util_bugger_catch).
:- use_module(logicmoo_util_with_assertions).
:- use_module(logicmoo_util_loop_check).
:- use_module(logicmoo_util_dmsg).
:- use_module(logicmoo_util_bugger).
:- use_module(logicmoo_util_ctx_frame).
:- use_module(logicmoo_util_filestreams).
:- use_module(logicmoo_util_filesystem).
:- use_module(logicmoo_util_multivar).
:- use_module(logicmoo_util_no_repeats).
:- use_module(logicmoo_util_preddefs).
:- use_module(logicmoo_util_prolog_frames).
% :- use_module(logicmoo_util_prolog_streams).
:- use_module(logicmoo_util_term_listing).
:- use_module(logicmoo_util_terms).









