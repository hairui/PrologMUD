% #!/usr/bin/env swipl
%
%  PFC is a language extension for prolog.. there is so much that can be done in this language extension to Prolog
%
% Dec 13, 2035
% Douglas Miles


%  cls ; kill -9 %1 ; swipl -g "ensure_loaded(pack(logicmoo_base/t/examples/base/'sanity_abc.pfc'))."

:- module(sanity,[]).

:- use_module(library(logicmoo_base)).

              
:- file_begin(pfc).

:- autoload.

:- abolish(a,0).
:- abolish(b,0).
:- dynamic((a/0,b/0)).

:- debug(mpred).
:- mpred_trace_exec.
:- mpred_is_tracing_exec.

:- mpred_trace_msg(beginxxxxxxxxxxxxxxxxXXXXXXXXXXXXXXXXXXXXXXXXxxxxxxxxxxxxxxxxxxxxxxxx_abc).

:- mpred_ain((a ==> b)).
:- rtrace(mpred_ain(a)).

a ==> b.

:- pp_DB.

:- mpred_test(a).
:- mpred_test(b).

