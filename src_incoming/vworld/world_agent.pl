/** <module> 
% NPC_Interface for calling actions
%
% "command"s are often text or a description of proposed actions
% "action" is a MUD understood command (GOAL)
%
% Douglas Miles
% Dec 13, 2035
%
*/

/*
% This file is "included" from world.pl 
:-module(actr, [ call_agent_command/2,  call_agent_action/2 ]).
*/


% =====================================================================================================================
% call_agent_command/2 -->  call_agent_action/2
% =====================================================================================================================

% join up @ verbs 
call_agent_command(Ag,[A,B|REST]):- atom(A),atom(B),member(A,['@']),atom_concat(A,B,C),!,call_agent_command(Ag,[C|REST]).

call_agent_command(Agent,[VERB|ARGS]):-
      debugOnError(parser_imperative:parse_agent_text_command(Agent,VERB,ARGS,NewAgent,CMD)),
      must(call_agent_action(NewAgent,CMD)),!.

% lists
call_agent_command(A,Atom):-atom(Atom),atomSplit(Atom,List),!,call_agent_command(A,List).

% execute a prolog command including prolog/0
call_agent_command(_Gent,Atom):- atom(Atom), catch((
   (once((read_term_from_atom(Atom,OneCmd,[variables(VARS)]),
      predicate_property(OneCmd,_),
      fmt('doing command ~q~n',[OneCmd]))),!, doall((OneCmd,fmt('Yes: ~w',[VARS]))))),_,fail).

% remove period at end
call_agent_command(A,PeriodAtEnd):-append(New,[(.)],PeriodAtEnd),!,call_agent_command(A,New).

call_agent_command(A,[L,I|IST]):- atom(L), CMD =.. [L,I|IST],!, call_agent_action(A,CMD).

call_agent_command(A,CMD):- call_agent_action(A,CMD),!.

% All Actions must be called from here!
call_agent_action(Agent,CMDI):-
   ensure_session_id(Agent,SESSION,Pushed),
      subst(CMDI,self,Agent,CMDI2),      
      atloc(Agent,Where),
      subst(CMDI2,here,Where,CMD),
      % start event
     % raise_location_event(Where,notice(reciever,do(Agent,CMD))),
     catch(( ignore(( once((debugOnError(moo:agent_call_command(Agent,CMD)),
           % complete event
           raise_location_event(Where,notice(reciever,done(Agent,CMD))));
           % fail event
              raise_location_event(Where,notice(reciever,failed(Agent,CMD))))))),E,fmt('call_agent_action/2 Error ~q ',[E])),
    (Pushed -> ignore(retract(thlocal:current_agent(SESSION,Agent)));true).

/*
test_te:- xcall_t((
 

  user:term_expansion(((call_agent_action(Agent,CMDI):-
  (( ensure_session_id(Agent,SESSION,Pushed),
      subst(CMDI,self,Agent,CMDI2),      
      atloc(Agent,Where),
      subst(CMDI2,here,Where,CMD),
      % start event
     % raise_location_event(Where,notice(reciever,do(Agent,CMD))),
     catch(( ignore(( once((debugOnError(moo:agent_call_command(Agent,CMD)),
           % complete event
           raise_location_event(Where,notice(reciever,done(Agent,CMD))));
           % fail event
              raise_location_event(Where,notice(reciever,failed(Agent,CMD))))))),E,fmt('call_agent_action/2 Error ~q ',[E])),
    (Pushed -> ignore(retract(thlocal:current_agent(SESSION,Agent)));true))))),TE), 

  writeq(TE)
  )).

:-test_te.
*/

ensure_session_id(Agent,SESSION,fail):- get_session_id(SESSION),once(thlocal:current_agent(SESSION,Agent2)),Agent2==Agent,!.
ensure_session_id(Agent,SESSION,true):- get_session_id(SESSION),asserta(thlocal:current_agent(SESSION,Agent)),!.


get_session_id(IDIn):-current_input(ID),is_stream(ID),!,ID=IDIn.
get_session_id(ID):-thread_self(ID).

current_agent(PIn):-get_session_id(O),thlocal:current_agent(O,P),!,P=PIn.

current_agent_or_var(P):- once(current_agent(PIn)),P=PIn,!.
current_agent_or_var(_).

foc_current_player(P):- current_agent(P),!.
foc_current_player(P):- get_session_id(O),generate_new_player(P),!,asserta(thlocal:current_agent(O,P)).

generate_new_player(P) :-
  gensym(player,N),
   P=explorer(N),
   must(create_agent(P)).


% Lists all the agents in the run. Except for other monsters.
list_agents(Agents) :- agent_list(Agents), !.
list_agents(Agents) :- % build cache
	findall(NearAgent,req(agent(NearAgent)),Agents),
	assert(agent_list(Agents)),!.

% When an agent dies, it turns into a corpse.
% corpse is defined as an object in the *.objects.pl files
agent_into_corpse(Agent) :-
	del(atloc(Agent,LOC)),
	clr(str(Agent,_)),
	clr(height(Agent,_)),
	clr(stm(Agent,_)),
	clr(spd(Agent,_)),
	add(atloc(corpse(Agent),LOC)).

% Displays all the agents stats. Used at end of a run.
display_stats(Agents) :-
	forall(member(Agent,Agents),
	          (charge(Agent,Chg),
		  damage(Agent,Dam),
		  score(Agent,Scr),
		  findall(Obj,possess(Agent,Obj),Inv),
		  write('Agent = '), write(Agent), nl,
		  write('Charge = '), write(Chg), write('  '),
		  write('Dam= ' ), write(Dam), write('  '),
		  write('Score = '), write(Scr), nl,
		  write('Inventory = '), write(Inv), nl)).

