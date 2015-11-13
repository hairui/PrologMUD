#!/usr/bin/env swipl
%
%  PFC is a language extension for prolog.. there is so much that can be done in this language extension to Prolog
%
% Dec 13, 2035
% Douglas Miles


%  cls ; kill -9 %1 ; swipl -g "ensure_loaded(pack(logicmoo_base/t/examples/base/'sanity_abc.pfc'))."

:- module(sanity,[]).

:- use_module(library(logicmoo_base)).

:- begin_pfc.

:- process_this_script.

must_is_entailed(G):- cwc, must(is_entailed(G)).

:- xlisting(must_is_entailed).

a.

:- must_is_entailed(a).

