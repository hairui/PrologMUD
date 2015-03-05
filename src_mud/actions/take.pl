% take.pl
% May 18, 1996
% John Eikenberry
%
% Dec 13, 2035
% Douglas Miles
%
/** <module>
% This file defines the basic take command
%
*/
:-swi_module(moduleTake, [do_act_for_take/2]).

:- include(logicmoo(vworld/moo_header)).

% :- register_module_type (mtCommand).

action_info(actTake(tCarryAble)).

% Command Hook
user:agent_call_command(Agent,actTake(Obj)) :- 
  not(action_verb_useable(actTake,_,_,_,_)),
  agent_call_take(Agent,Obj).

% Successfully
agent_call_take(Agent,Obj) :- 
	once((farthest_reachable_object(Agent,Obj))),
	nop((ignore(props(Obj,mudWeight<2)),
	ignore(do_act_affect(Agent,actTake,Obj)))),
	do_act_for_take(Agent,Obj),
	call_update_charge(Agent,actTake).

% Unsuccessfully
agent_call_take(Agent,_Obj) :- 
	call_update_charge(Agent,actTake),
	add_cmdfailure(Agent,actTake).


% Is the obect going to stick around after take-ing, either as is
% or in the agent's possession.
do_act_for_take(Agent,Obj) :-
	do_change_for_take(Agent,Obj),!.
        %term_listing(Obj).

do_change_for_take(_,Obj):-
        props(Obj,mudPermanence(actTake,Disappears)), 
		member(Disappears,[0,vTakenDeletes]),
        detatch_object(Obj),
        add(mudStowing(Agent,Obj)),    
        must_post_for_take(Agent,Obj),
        detatch_object(Obj).
do_change_for_take(Agent,Source) :-
	props(Source,mudPermanence(actTake,vTakenCopyFn(What))),
        create_new_object([What],Obj),
        detatch_object(Obj),
        add(mudStowing(Agent,Obj)),        
        must_post_for_take(Agent,Obj).
do_change_for_take(Agent,Obj) :-        
        props(Obj,mudPermanence(actTake,vTakenStays)),!,
        mudAtLoc(Obj,Was),
        detatch_object(Obj),
        add(mudStowing(Agent,Obj)),
        must_post_for_take(Agent,Obj),
        detatch_object(Obj),
        add(mudAtLoc(Obj,Was)).
% default is same as vTakenMoves
do_change_for_take(Agent,Obj) :-
	ignore((props(Obj,mudPermanence(actTake,Held)),member(Held,[1,vTakenMoves]))),
        detatch_object(Obj),
	add(mudStowing(Agent,Obj)),
        must_post_for_take(Agent,Obj).

must_post_for_take(Agent,Obj):-
       fmt([Agent,take,Obj]),
       (req(mudPossess(Agent,Obj)) -> true; trace_or_throw(req(mudPossess(Agent,Obj)))).

% Record keeping
update_charge(Agent,actTake) :- 
        padd(Agent,mudEnergy(-2)).

% :- include(logicmoo(vworld/moo_footer)).
