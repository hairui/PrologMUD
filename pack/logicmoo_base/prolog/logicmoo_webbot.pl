/*  LogicMOO User Modules Setup
%
%
% Dec 13, 2035
% Douglas Miles
*/
:- if(( system:use_module(system:library('logicmoo/util/logicmoo_util_clause_expansion.pl')), push_modules)). 
:- endif.
:- module(logicmoo_webbot_file,[]).
% restore entry state
:- lcme:reset_modules.

%:- prolog_ide(thread_monitor).
%:- prolog_ide(debug_monitor).

:- system:use_module(library(debug)).
:- forall(prolog_debug:debugging(X,true,_),prolog_debug:nodebug(X)).
:- prolog_debug:nodebug(logicmoo_webbot).

:- set_prolog_flag(lm_expanders,true).
:- set_prolog_flag(mpred_te,true).

:- use_module(library(logicmoo_utils)).
:- use_module(library(logicmoo_base)).
%:- system:use_module(library(logicmoo/mpred_online/mpred_www)).
%:- system:use_module(library(logicmoo/mpred_online/mpred_pldoc_util)).

:- initialization(ensure_webserver(3020)).
:- initialization(ensure_webserver(3020),restore).


:- forall(prolog_debug:debugging(X,true,_),prolog_debug:nodebug(X)).

:- initialization(wdmsg("Running Initialization/1")).
:- initialization(wdmsg("Initialization of restore state"),restore).

:- set_prolog_flag(lm_expanders,false).
:- set_prolog_flag(read_attvars,false).
:- set_prolog_flag(mpred_te,false).
:- set_lang(pl).
:- system:use_module(library(socket)).
:- user:use_module(library(eggdrop)).
:- forall(prolog_debug:debugging(X,true,_),prolog_debug:nodebug(X)).
:- initialization(eggdrop:egg_go,restore).
:- initialization(eggdrop:egg_go).
wbg:- eggdrop:egg_go.

:- set_prolog_flag(lm_expanders,true).
:- set_prolog_flag(mpred_te,true).

:- forall(prolog_debug:debugging(X,true,_),prolog_debug:nodebug(X)).

size666_stacks:- Six = 6, set_prolog_stack(global, limit(Six*10**9)),set_prolog_stack(local, limit(Six*10**9)),set_prolog_stack(trail, limit(Six*10**9)).

:- abolish(system:nondet/1).
:- at_start(size666_stacks).


:- user:use_module(library(logicmoo_user),except([op(_,_,_)])).
%:- forall(prolog_debug:debugging(X,true,_),prolog_debug:nodebug(X)).
%:- initialization(set_prolog_flag(mpred_te,false)).
%:- initialization(set_prolog_flag(mpred_te,false),restore).

%:- system:use_module(library(logicmoo/mpred_online/mpred_rdf)).

% :- tdebug.

% :- qsave_program('lm_user.prc').
%:- qsave_program('lm_webbot.prc').

:- threads.
%:- use_listing_vars.
:- statistics.
% :- repeat,sleep(3.0),fail.


