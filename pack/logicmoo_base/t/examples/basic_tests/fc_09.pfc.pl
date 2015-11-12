#!/usr/bin/env swipl
%
%  PFC is a language extension for prolog.. there is so much that can be done in this language extension to Prolog
%
% Dec 13, 2035
% Douglas Miles



:- use_module(library(logicmoo_base)).

:- file_begin(pfc).

:- abolish(a,1).
:- abolish(b,1).
:- dynamic((a/1,b/1)).

:- debug(mpred).
:- mpred_trace_exec.
:- mpred_is_tracing_exec.


a(t).
a(X) ==> b(X).
b(t).


:- mpred_test(a(t)).
:- mpred_test(b(t)).

\+ a(t).

:- mpred_test(\+ a(t)).
:- mpred_test(b(t)).

