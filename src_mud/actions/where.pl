
% Dec 13, 2035
% Douglas Miles
%
/** <module> 
% This file defines the agents action of eating. 
% Very simple... but kept separate to maintain modularity
%
% This uses the worth/2 predicate from take.pl
% Will (theoretically) only be used in conjuction with take action
%
% It will destroy something, even if it is not food... talk about a garbage disposal. 
*/

% :-swi_module(user). 
:-swi_module(where_cmd, []).

:- include(logicmoo(vworld/moo_header)).

:- register_module_type(command).


subclass(agent,obj).
subclass(item,obj).


% where 
agent_text_command(Agent,[where,BE,X],Agent,where(X)):-memberchk(BE,[is,are,be,were]).
action_info(where(obj),"Tells where something is").
agent_call_command(_Agent,where(SObj)) :-
    forall(
     (atloc(Obj,LOC), match_object(SObj,Obj)),
        fmt(cmdresult(where,atloc(Obj,LOC)))).


action_info(who(optional(agent,world)),"Lists who is online (where they are at least)").

agent_call_command(_Gent,who(W)) :- mud_cmd_who(W).

mud_cmd_who(world):-!,mud_cmd_who_1(_).
mud_cmd_who(Who):- mud_cmd_who_1(Who).

get_inRegion(Agnt,Where):- inRegion(Agnt,Where),!.
get_inRegion(Agnt,Where):- atloc(Agnt,Where),!.
get_inRegion(Agnt,Where):- localityOfObject(Agnt,Where),!.

mud_cmd_who_1(Who):-
     forall(agent(Who),
      once((get_inRegion(Who,Where),
            fmt(cmdresult(who(Who),localityOfObject(Who,Where)))))).

:- include(logicmoo(vworld/moo_footer)).

