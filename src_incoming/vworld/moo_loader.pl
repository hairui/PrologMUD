/** <module> 
% Game loading Utils
%
% Project Logicmoo: A MUD server written in Prolog
% Maintainer: Douglas Miles
% Dec 13, 2035
%
*/
:- module(moo_loader, []).

:-dynamic current_world/1.
current_world(current).

:- meta_predicate show_load_call(0).

:- include(logicmoo('vworld/moo_header.pl')).

ensure_game_file(Mask):- ensure_plmoo_loaded(Mask).

:-export(load_game/1).

load_game(File):-current_world(World), load_game(World,File),!.
load_game(World,File):- 
   world_clear(World),
   retractall(loaded_file_world_time(_,_,_)),
  ensure_plmoo_loaded(File),!,
  finish_processing_world.

:-export(filematch/2).
:-export filematch/3.
filematch(Mask,File1):-filematch('./',Mask,File1).
filematch(RelativeTo,Mask,File1):-absolute_file_name(Mask,File1,[expand(true),access(read),extensions(['',plmoo,pl]),file_errors(fail),solutions(all),relative_to(RelativeTo)]).

/*

path_concat(L,R,LR):-path_concat1(L,R,LR),!.
path_concat(R,L,LR):-path_concat1(L,R,LR),!.
path_concat(L,R,LR):-atom_concat(L,R,LR),!.
path_concat1('',R,R):-!.
path_concat1('./',R,R):-!.
path_concat1('.',R,R):-!.


:-export(files_matching/2).
:-export(files_matching/3).
files_matching(Mask,File1):- files_matching('./',Mask,File1),access_file(File1,read),!.
files_matching(_Prepend,Mask,File1):- compound(Mask),Mask=..[F,A],!,file_search_path(F,NextPrepend),files_matching(NextPrepend,A,File1),access_file(File1,read).
files_matching(Prepend,Mask,File1):- filematch(Prepend,Mask,File1),access_file(File1,read).
% files_matching(Prepend,Mask,File1):- path_concat(Prepend,Mask,PMask),expand_file_name(PMask,Files),Files\=[],!,member(File1,Files),access_file(File1,read).
*/

:-export(ensure_plmoo_loaded/1).
ensure_plmoo_loaded(Mask):-
  forall(filematch(Mask,File1),ensure_plmoo_loaded_each(File1)).

:-dynamic(loaded_file_world_time/3).
:-export(loaded_file_world_time/3).
:-export(get_last_time_file/3).
get_last_time_file(FileIn,World,LastTime):- absolute_file_name(FileIn,File),loaded_file_world_time(File,World,LastTime),!.
get_last_time_file(_,_,0).

:-export(ensure_plmoo_loaded_each/1).
ensure_plmoo_loaded_each(FileIn):-
   absolute_file_name(FileIn,File),
   current_world(World),
   time_file_safe(File,NewTime),!,
   get_last_time_file(File,World,LastTime),
   (LastTime<NewTime -> reload_plmoo_file(File) ; true).

:-export(reload_plmoo_file/1).

reload_plmoo_file(FileIn):-
   absolute_file_name(FileIn,File),
   current_world(World),
   retractall(loaded_file_world_time(File,World,_)),   
   dbase_mod(DBASE),'@'(load_data_file(World,File),DBASE).

:-export(load_data_file/2).
load_data_file(World,FileIn):- with_assertions(current_world(World),load_data_file(FileIn)).

:-export(load_data_file/1).
load_data_file(FileIn):-
  absolute_file_name(FileIn,File),
  current_world(World),
  time_file_safe(File,NewTime),
  assert(loaded_file_world_time(File,World,NewTime)), 
   dmsg(load_data_file(File,World,NewTime)),
  with_assertions(moo:loading_game_file(World,File),
   setup_call_cleanup(see(File),
    (load_game_name_stream(World),asserta_new(moo:loaded_game_file(World,File))), seen)).
   
load_game_name_stream(_Name):- repeat,read_one_term(Term),myDebugOnError(game_assert(Term)),Term == end_of_file,!.
load_game_name_stream(_Name,Stream):- repeat,read_one_term(Stream,Term),myDebugOnError(game_assert(Term)),Term == end_of_file,!.

myDebugOnError(Term):-catch(once((call(Term))),E,(dmsg(start_myDebugOnError(E=Term)),trace,rtrace(call(Term)),dmsg(stop_myDebugOnError(E=Term)),trace)).

read_one_term(Term):- style_check(-atom), catch(once(( read_term(Term,[double_quotes(string)]))),E,(Term=error(E),dmsg(read_one_term(Term)))).
read_one_term(Stream,Term):- style_check(-atom), catch(once(( read_term(Stream,Term,[double_quotes(string)]))),E,(Term=error(E),dmsg(read_one_term(Term)))).

ensure_mpred_stubs:- doall((mpred_prop(F,prologHybrid),mpred_arity(F,A),A>0,warnOnError(declare_dbase_local_dynamic(moo,F,A)))).


:-export(finish_processing_world/0).
finish_processing_world:- loop_check(doall(finish_processing_game),true).
finish_processing_game:- dmsg(begin_finish_processing_game),fail.
finish_processing_game:- ignore(rescan_mpred_props),fail.
finish_processing_game:- forall(retract(moo:call_after_load(A)),once(must_det(A))),fail.
finish_processing_game:- ignore(rescan_mpred_props),fail.
finish_processing_game:- retract(moo:call_after_load(A)),once(must_det(A)),fail.
finish_processing_game:- once(rescan_dbase_t),fail.
finish_processing_game:- once(scan_default_props),fail.
finish_processing_game:- once(rescan_dbase_t),fail.
finish_processing_game:- dmsg(saving_gameb),fail.
finish_processing_game:- ensure_mpred_stubs,fail.
finish_processing_game:- do_after_game_file,fail.
finish_processing_game:- do_db_op_hooks0,fail.
finish_processing_game:- savedb,fail.
finish_processing_game:- dmsg(end_finish_processing_game),fail.
finish_processing_game.


:-export(rescandb/0).
rescandb:- forall(current_world(World),(findall(File,loaded_file_world_time(File,World,_),Files),forall(member(File,Files),ensure_plmoo_loaded_each(File)),finish_processing_world)).
rescandb:-finish_processing_world.



:- style_check(-singleton).
:- style_check(-discontiguous).
:- style_check(-atom).

% gload:- load_game(savedb),!.
gload:- load_game(logicmoo('rooms/startrek.all.plmoo')).

:-export(savedb/0).
savedb:-
 ccatch((
   rescan_dbase_t_once,
   ignore(catch(make_directory('/tmp/lm/'),_,true)),
   ignore(catch(delete_file('/tmp/lm/savedb'),E,(dmsg(E:delete_file('/tmp/lm/savedb')),dtrace))),   
   tell('/tmp/lm/savedb'),make_db_listing,told),E,dmsg(savedb(E))).


:-export(make_db_listing/0).
make_db_listing:-
 % moo:dbase_mod(DBM),
%   listing(dbase_t),
 %  listing(dbase_f),
     listing(hook:_),
     listing(user:_),  
     listing(dbase:_),
     listing(dyn:_),
     listing(moo_loader:_),
     listing(world:_),
     listing(moo:_),!.

/*
"Lieutenant",
"Commander",
"Human",
"Player",
"Explorer Player",
"ACT_NICE_THIEF",
"AWARE",
"NOBACKSTAB",
"ACT_STAY_ZONE",
"MEMORY",
"HELPER",
"ACT_FRIEND",
"NOCHARM",
"NOSUMMON",
"NOSLEEP",
"NOBASH",
"NOBLIND",
"NPC_DETECT_INVIS",
"NPC_NOTRACK",
"+mudToHitArmorClass0: 1",
"mudMaxHitPoints: 18d18+4000",
"#$PunchingSomething mudBareHandDamage: 10d10+75",
"Player",
"Player",
"Human",
"Logged on player character",
"burgandy",
"starfleet",
"command",
"uniform",
"a burgandy Starfleet command uniform",
"A neatly folded burgandy Starfleet command uniform is lying here",
"armorLevel: 10",
"These uniforms are worn by command officers on Federation starships. It's kind of tight, but it looks pretty good",
"Red Uniform",
"a burgandy Starfleet command uniform"

*/
detWithSpace(WithSpace,String):-ddeterminer0(String),atom_concat(String,' ',WithSpace).
detWithSpace(WithSpace,String):-ddeterminer1(String),atom_concat(String,' ',WithSpace).

:-export(determinerRemoved/3).
determinerRemoved(S0,Det,S):- detWithSpace(WithSpace,String),string_concat(WithSpace,S,S0),string_lower(String,Det).

:-export(query_description/1).
query_description(description(I,S)):-dbase_t(description,I,S).

:-export(remove_description/1).
remove_description(description(I,S)):- trace_or_throw(remove_description(description(I,S))).

:-export(add_description/1).
add_description(description(I,S)):-add_description(I,S).

:-export(add_description/2).
add_description(A,S0):-string_concat('#$PunchingSomething ',S,S0),!,add_description(A,S).
add_description(A,S0):-determinerRemoved(S0,String,S),!,add_description(A,S),game_assert(determinerString(A,String)).
add_description(A,S0):-
   string_to_atom(S0,S),
   atomic_list_concat(Words,' ',S),
   atomic_list_concat(Sents,'.',S),!,
   length(Words,Ws),
   must_det(add_description(A,S,S0,Ws,Sents,Words)).

% mudBareHandDamage: 10d10+75
add_description(A,S,_S0,Ws,_Sents,_Words):- Ws<3,  
   atomic_list_concat([K,V],': ',S),!,add_description_kv(A,K,V).

add_description(A,S,_S0,Ws,_Sents,_Words):- Ws<3,
   atomic_list_concat([K,V],'=',S),!,add_description_kv(A,K,V).

% "NOBACKSTAB","ACT_STAY_ZONE","MEMORY"
add_description(A,_S,_S0,1,_,[Word]):-add_description_word(A,Word),!.

%#$PunchingSomething ..
add_description(A,S,S0,Ws,Sents,['#$PunchingSomething',B|C]):-add_description(A,S,S0,Ws,Sents,[B|C]).
add_description(A,S,S0,Ws,Sents,[Det,B|C]):-ddeterminer(Det,L),add_description(A,S,S0,Ws,Sents,[B|C]),game_assert(determinerString(A,L)).
add_description(A,S,S0,Ws,_Sents,_Words):-Ws>3,is_here_String(S),!,show_load_call(game_assert_fast(descriptionHere(A,S0))).
add_description(A,_S,S0,_Ws,_Sents,_Words):-show_load_call(game_assert_fast(description(A,S0))).

is_here_String(S):- atomic_list_concat_safe([_,is,_,here,_],S).
is_here_String(S):- atomic_list_concat_safe([_,here],S).
is_here_String(S):- atomic_list_concat_safe([_,is,here,_],S).


ddeterminer1('A').
ddeterminer1('An').
ddeterminer1('The').
ddeterminer0(a).
ddeterminer0(an).
ddeterminer0(the).
ddeterminer(L,L):-ddeterminer0(L).
ddeterminer(U,L):-string_lower(U,L),U\=L,!,ddeterminer0(L).

add_description_word(A,Word):- string_upper(Word,Word),string_lower(Word,Flag),string_to_atom(Flag,Atom),atom_concat(flagged_,Atom,FAtom),show_load_call(game_assert(isa(A,FAtom))).
add_description_word(A,Word):- string_lower(Word,Word),show_load_call(game_assert(keyword(A,Word))).
add_description_word(A,Word):- string_lower(Word,Lower),show_load_call(game_assert(keyword(A,Lower))).


add_description_kv(A,K,V):- atom_concat('#$PunchingSomething ',Key,K),!,add_description_kv(A,Key,V).
add_description_kv(A,K,V):- atom_concat('+',Key,K),!,add_description_kv(A,Key,V).
add_description_kv(A,K,V):-atom_to_value(V,Term),C=..[K,A,Term],show_load_call(game_assert(C)).


% =======================================================

show_load_call(game_assert_fast(A)):-
   correctArgsIsa(A,AA),
   logOnFailure(game_assert_fast(AA)).
show_load_call(game_assert(A)):-
   correctArgsIsa(A,AA),
   logOnFailure(game_assert(AA)).
show_load_call(C):- 
   logOnFailure(debugOnError(C)).


:- include(logicmoo('vworld/moo_footer.pl')).


