#!/usr/bin/env swipl

:- if( \+ exists_source(library(logicmoo/logicmoo_base))).
:- dynamic(user:file_search_path/2).
:- multifile(user:file_search_path/2).
:- absolute_file_name('../../prolog',Dir),asserta(user:file_search_path(library,Dir)).
:- endif.

:- ensure_loaded(library(logicmoo/logicmoo_utils)).
:- thread_local(t_l:user_abox/1).
:- (t_l:user_abox(M)->true;(context_module_of_file(M),asserta(t_l:user_abox(M)))),!,writeln(user_kb=M).

:- if(gethostname(ubuntu)).
:- ensure_loaded(library(logicmoo/logicmoo_user)).
:- else.
:- ensure_loaded(library(logicmoo/logicmoo_user)).
% :- load_files(logicmoo_repl, [if(not_loaded),qcompile(auto)]).
:- endif.

:- with_ukb(baseKB,baseKB:ensure_mpred_file_loaded(logicmoo(snark/'common_logic_clif.pfc'))).

show_test(G):- get_user_abox(KB),must(show_call(KB:G)).
show_call_test(G):- get_user_abox(KB),must(show_call(KB:G)).


%= define the example language
example_known_is_success(G):-  G.
example_impossible_is_success(G):- neg(G).
example_known_is_failure(G):-  \+ G.
example_impossible_is_failure(G):- \+ neg(G).

%= define the four truth values
example_proven_true(G):- example_known_is_success(G),example_impossible_is_failure(G).
example_proven_false(G):- example_impossible_is_success(G),example_known_is_failure(G).
example_inconsistent(G):- example_known_is_success(G),example_impossible_is_success(G).
example_unknown(G):- example_known_is_failure(G),example_impossible_is_failure(G).
  
:-multifile shared_hide_data/1.
%= shared_hide_data(hideMeta):-is_main_thread.
%= shared_hide_data(hideTriggers):-is_main_thread.

% = clear the screen
% :- shell(cls).

%= save compiled clauses using forward chaining storage (by default)
%= we are using forward chaining just so any logical errors, performance and program bugs manefest
%= immediately
:- set_clause_compile(fwc).
