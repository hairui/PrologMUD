/* <module>
%
%  PFC is a language extension for prolog.
%
%  It adds a new type of module inheritance
%
% Dec 13, 2035
% Douglas Miles
*/
:- module(mt_01,[]).

:- user:use_module(library(logicmoo_utils)).
:- user:use_module(library(logicmoo_base)).


%:- add_import_module(mt_01,baseKB,end).

:- set_defaultAssertMt(myMt).

mtProlog(code1).
mtCycL(kb2).
mtCycL(kb3).

% code1: (a <- b).
code1: (a:- printAll('$current_source_module'(M)),b).


kb2: (b).

genlMt(kb2,code1).

kb2: (?- a).

genlMt(kb3,kb2).


baseKB:predicateConventionMt(a,kb2).

kb3: (a==>c).

:- mpred_must(clause(kb2:a,_)).
