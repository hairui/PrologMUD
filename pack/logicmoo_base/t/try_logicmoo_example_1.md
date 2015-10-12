#!/usr/bin/env swipl

/**
````
*/

:- if(gethostname(ubuntu)).
:- user:ensure_loaded(logicmoo_repl).
:- else.
:- user:ensure_loaded(logicmoo_repl).
% :- load_files(logicmoo_repl, [if(not_loaded),qcompile(auto)]).
:- endif.

show_call_test(G):-must(show_call(G)).

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

:- shell(cls).
:- process_this_script.


%=  setup pfc
:- file_begin(pfc).

%=  see logicmoo_i_compiler.pl for more info
:- set_clause_compile(fwc).

==> clif(male(P)  => ~female(P)).
%=%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%= kif = 
%=       all(P, (male(P)=> ~female(P))).
%=
%= pkif = 
%=       all(P, (male(P)=>not(female(P)))).
%=
%= cnf = 
%=       not(male(P))v not(female(P)).
%=
%= horn = 
%=       [ (not(female(P)):-male(P)), (not(male(P)):-female(P))].
%=
%=
%= succeed(user:boxlog_to_pfc((not(female(P)):-male(P)), (male(P), {is_unit(P)}==>neg(female(P))))).
%=
%= succeed(user:boxlog_to_pfc((not(male(P)):-female(P)), (female(P), {is_unit(P)}==>neg(male(P))))).
%=
%=%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%= Notice we do not have the evidence to prove anyone male to female!
%= Only the ability to "disprove" right now


%= Humans are male or female
==> clif(human(P) => (female(P) v male(P))).

%=%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%= kif = 
%=       all(P, (human(P)=>female(P)v male(P))).
%=
%= pkif = 
%=       all(P, (human(P)=>female(P)v male(P))).
%=
%= cnf = 
%=       not(human(P))v (female(P)v male(P)).
%=
%= horn = 
%=
%=       [ (female(P):-human(P), not(male(P))),
%=         (male(P):-human(P), not(female(P))),
%=         (not(human(P)):-not(female(P)), not(male(P)))
%=       ].
%=
%=
%= succeed(user:boxlog_to_pfc((female(P):-human(P), not(male(P))), (human(P), neg(male(P)), {is_unit(P)}==>female(P)))).
%=
%= succeed(user:boxlog_to_pfc((male(P):-human(P), not(female(P))), (human(P), neg(female(P)), {is_unit(P)}==>male(P)))).
%=
%= succeed(user:boxlog_to_pfc((not(human(P)):-not(female(P)), not(male(P))), (neg(female(P)), neg(male(P)), {is_unit(P)}==>neg(human(P))))).
%=
%=%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%= joe is male
==> male(joe).

:- show_call(example_proven_true( male(joe ))).

%= Logical Negation (not by failure)
:- pfc_trace.
:- pfc_watch.

%= pat is not female
==> neg(female(pat)).

%= We check that we cannot prove Pat is male.
%= Thus a query to ?- male(pat ). 
:- show_call(example_known_is_failure( male(pat ))).

%= Assert pat is human
==> human(pat).

%= Thus we can deduce he is male now 
:- show_call(example_known_is_success( male(pat ))).


:-prolog.
