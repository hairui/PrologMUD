#!/usr/bin/env swipl

:- include('sanity_fi_sk.pfc').

:- debug(req).
:- mpred_trace_exec.

:- process_this_script.

%= simply retract (so we can re-deduce)
\+ human(douglas).

%= confirm no inheritance twoards father
:- must(\+ father(_,douglas)).

:- prolog.

%= catch a regression bug that may couse trudy to lose human assertion
never_retract_u(human(trudy)).

related_to(P1,P2)=>related_to(P2,P1).

father(P1,P2)=>related_to(P1,P2).
mother(P1,P2)=>related_to(P1,P2).

human(P2)<-human(P1),related_to(P1,P2).

:- printAll(must(father(_,_))).
:- printAll(must(mother(_,_))).




