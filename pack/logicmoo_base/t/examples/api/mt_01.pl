/* <module>
%
%  PFC is a language extension for prolog.
%
%  It adds a new type of module inheritance
%
% Dec 13, 2035
% Douglas Miles
*/
:- module(sanity,[]).

:- use_module(library(logicmoo_base)).

:- add_import_module(sanity,baseKB,end).

:- set_defaultAssertMt(myMt).

:- begin_pfc.

:- rtrace((ain(socialMt:loves(joe,sally)))).
:- break.
socialMt:loves(sally,joe).

% set_defaultAssertMt/1 worked good?
:- mpred_test(defaultAssertMt(myMt)).

:- mpred_test('$current_source_module'(myMt)).

% loves/2 has no visible assertions?
:- rtrace(mpred_test(\+ loves(_,_))).

:- break.

:- mpred_test(\+ loves(_,_)).
% :- (break,notrace,nortrace).

% loves/2 has visible assertions where it should?
:- mpred_test(socialMt:loves(sally,joe)).

% query didnt mess visibility?
:- rtrace(mpred_test(\+ loves(_,_))).

% like Cyc genlMt/2 is require to be in baseKB
baseKB:genlMt(myMt,socialMt).

% loves/2 is now visible?
:- mpred_test(loves(sally,joe)).

