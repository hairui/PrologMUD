/** <module>
% actPut.pl
%
% This file defines how an agent puts 
%
%  Test of the new concise syntax:
% 
%   props(Agent,charge>10),
%
% Comments below document the basic idea.
%
% Dec 13, 2035
% Douglas Miles
*/
% :-swi_module(user). 
:-swi_module(modPut, []).

:- include(prologmud(mud_header)).

% :- register_module_type (mtCommand).

% actPut
user:action_info(actPut(tCarryAble,txtPrepSpatial,tPutTargetAble),"actPut [obj] [onto|inside] [somewhere]").

user:verb_alias(T,V):-vtVerb(V),name_text(V,T).
user:verb_alias(set,actPut).
user:verb_alias(place,actPut).
user:verb_alias(hide,actPut).
user:verb_alias(display,actPut).
user:verb_alias(stow,actPut).

%targeted
user:agent_call_command(_Agent,actPut(Other,_Prep,Where)):-
   coerce(Other,tObj,Target),
   coerce(Where,tPutTargetAble,Location),
   clr(localityOfObject(Target,_)),
   clr(mudAtLoc(Target,_)),
   to_3d(Location,Where3D),
   add(mudAtLoc(Where3D,Location)).


:- include(prologmud(mud_footer)).
