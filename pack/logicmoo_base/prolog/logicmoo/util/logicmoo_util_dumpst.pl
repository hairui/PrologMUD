/* Part of LogicMOO Base Logicmoo Debug Tools
% ===================================================================
% File '$FILENAME.pl'
% Purpose: An Implementation in SWI-Prolog of certain debugging tools
% Maintainer: Douglas Miles
% Contact: $Author: dmiles $@users.sourceforge.net ;
% Version: '$FILENAME.pl' 1.0.0
% Revision: $Revision: 1.1 $
% Revised At:  $Date: 2002/07/11 21:57:28 $
% Licience: LGPL
% ===================================================================
*/
:- module(logicmoo_util_dumpst,[
          getPFA/3,getPFA1/3,getPFA2/3,get_m_opt/4,fdmsg/1,fdmsg1/1,
          neg1_numbervars/3,clauseST/2,
          dtrace/0,dtrace/1,dtrace/2,
          dumptrace/1,dumptrace/2,
          dumptrace_ret/1,
          drain_framelist/1,
          drain_framelist_ele/1,
          dump_st/0,
          to_wmsg/2,
          simplify_goal_printed/2,
          dumpST/0,dumpST/1,dumpST1/0,
          dumpST0/0,dumpST0/1,dumpST0/2,
          dumpST9/0,dumpST9/1,dumpST9/2,dumpST_now/2,printFrame/3,frame_to_fmsg/4

   ]).

:-  meta_predicate dumptrace_ret(?),
  neg1_numbervars(?, ?, 0).



:- set_prolog_flag(backtrace_depth,      200).
:- set_prolog_flag(backtrace_goal_depth, 20).
:- set_prolog_flag(backtrace_show_lines, true).

:- module_transparent
            getPFA/3,getPFA1/3,getPFA2/3,get_m_opt/4,fdmsg/1,fdmsg1/1,
          neg1_numbervars/3,clauseST/2,
          dtrace/0,dtrace/1,dtrace/2,
          dumptrace/1,dumptrace/2,
          dumptrace_ret/1,
          dump_st/0,
          dumpST/0,dumpST/1,dumpST/2,
          dumpST0/0,dumpST0/1,dumpST0/2,
          dumpST9/0,dumpST9/1,dumpST9/2,dumpST9/3,dumpST9/4.



dump_st:- dumpST0(10).

dumpST0:-notrace(dumpST0(800)),!.
dumpST0(Opts):- prolog_current_frame(Frame),dumpST0(Frame,Opts).
dumpST0(_,_):- tlbugger:ifHideTrace,!.
dumpST0(Frame,MaxDepth):- ignore(MaxDepth=5000),Term = dumpST(MaxDepth),
   (var(Frame)->prolog_current_frame(Frame);true),
   ignore(( get_prolog_backtrace(MaxDepth, Trace,[frame(Frame),goal_depth(100)]),
    format(user_error, '% dumpST ~p', [Term]), nl(user_error),
    print_prolog_backtrace(user_error, Trace,[subgoal_positions(true)]), nl(user_error), fail)),!.



% dumpstack_arguments.
dumpST:- notrace(dumpST1).
dumpST1:- is_hiding_dmsgs,!.
dumpST1:- tlbugger:no_slow_io,!,dumpST0,!.
dumpST1:- tlbugger:ifHideTrace,!.
dumpST1:- loop_check_early(dumpST9,dumpST0).
dumpST(Depth):- loop_check_early(dumpST9(Depth),dumpST0(Depth)).

get_m_opt(Opts,Max_depth,D100,RetVal):-E=..[Max_depth,V],(((member(E,Opts),nonvar(V)))->RetVal=V;RetVal=D100).


dumpST9:- notrace((prolog_current_frame(Frame), dumpST9(Frame,5000))).
dumpST9(Depth):- prolog_current_frame(Frame), dumpST9(Frame,Depth).

dumpST9(_,_):- tlbugger:ifHideTrace,!.
dumpST9(Frame,MaxDepth):- integer(MaxDepth),!,dumpST_now(Frame,[max_depth(MaxDepth),numbervars(true),show([level,has_alternatives,hidden,context_module,goal,clause])]).
dumpST9(Frame,From-MaxDepth):- integer(MaxDepth),!,dumpST_now(Frame,[skip_depth(From),max_depth(MaxDepth),numbervars(true),show([level,has_alternatives,hidden,context_module,goal,clause])]).
dumpST9(Frame,List):- is_list(List),dumpST_now(Frame,[show([level,has_alternatives,hidden,context_module,goal,clause])|List]).


drain_framelist(Opts):- repeat, \+ drain_framelist_ele(Opts).

drain_framelist_ele(Opts):- 
    nb_getval('$current_stack_frame_list',[N-Frame|Next]),
    nb_setval('$current_stack_frame_list',Next),!,
    printFrame(N,Frame,Opts),!.
    
        

dumpST_now(FrameIn,Opts):-
  once(number(FrameIn);prolog_current_frame(FrameIn)),
   b_setval('$current_stack_frame_depth',0),
   b_setval('$current_stack_frame_list',[]),
   get_m_opt(Opts,max_depth,100,MD),
   b_setval('$current_stack_frame_handle',FrameIn),
  (repeat,  
     nb_getval('$current_stack_frame_depth',N),
     nb_getval('$current_stack_frame_handle',Frame),
    ((pushFrame(N,Frame,Opts),MD>N)-> 
     ((prolog_frame_attribute(Frame,parent,ParentFrame)->
       (nb_setval('$current_stack_frame_handle',ParentFrame),
       NN is N +1,nb_setval('$current_stack_frame_depth',NN),fail); !));
     (!))),
   drain_framelist(Opts),!.

dumpST_now_reversed(FrameIn,Opts):-
  once(number(FrameIn);prolog_current_frame(FrameIn)),
   b_setval('$current_stack_frame_depth',0),
   b_setval('$current_stack_frame_handle',FrameIn),
  (repeat,  
     nb_getval('$current_stack_frame_depth',N),
     nb_getval('$current_stack_frame_handle',Frame),
    (printFrame(N,Frame,Opts) -> 
     ((prolog_frame_attribute(Frame,parent,ParentFrame)->
       (nb_setval('$current_stack_frame_handle',ParentFrame),
       NN is N +1,nb_setval('$current_stack_frame_depth',NN),fail); !));
     (!))).

pushFrame(N,Frame,_Opts):- nb_getval('$current_stack_frame_list',Current),nb_setval('$current_stack_frame_list',[N-Frame|Current]).

printFrame(N,Frame,Opts):-
  must(frame_to_fmsg(N,Frame,Opts,Out)),must(fmsg_rout(Out)),!.

frame_to_fmsg(N,Frame,Opts,[nf(max_depth,N,Frame,Opts)]):-get_m_opt(Opts,max_depth,100,MD),N>=MD,!,fail.
%  dumpST9(N,Frame,Opts,[nf(max_depth,N,Frame,Opts)]):-get_m_opt(Opts,skip_depth,100,SD),N=<SD,!.
frame_to_fmsg(_,Frame,Opts,[fr(Goal)]):- get_m_opt(Opts,show,goal,Ctrl),getPFA(Frame,Ctrl,Goal),!.
frame_to_fmsg(N,Frame,Opts,[nf(no(Ctrl),N,Frame,Opts)]):- get_m_opt(Opts,show,goal,Ctrl),!.
frame_to_fmsg(N,Frame,Opts,[nf(noFrame(N,Frame,Opts))]).

 

fmsg_rout([]):-!.
fmsg_rout([fr(E)|_]):- member(goal=GG,E),end_dump(GG),!,ignore(fdmsg(fr(E))),!.
fmsg_rout([E|RROut]):- ignore(fdmsg(E)),!,fmsg_rout(RROut).
fmsg_rout(RROut):- show_call(why,forall(member(E,RROut),fdmsg(E))),!.

neg1_numbervars(T,-1,T):-!.
neg1_numbervars(Out,false,Out):-!.
neg1_numbervars(Out,true,ROut):-copy_term(Out,ROut),!,snumbervars(ROut,777,_).
neg1_numbervars(Out,Start,ROut):-copy_term(Out,ROut),integer(Start),!,snumbervars(ROut,Start,_).
neg1_numbervars(Out,safe,ROut):-copy_term(Out,ROut),safe_numbervars(ROut).

fdmsg1(txt(S)):-'format'(S,[]),!.
fdmsg1(level=L):-'format'('(~q)',[L]),!.
fdmsg1(context_module=G):- simplify_m(G,M),!,mesg_color(G,Ctrl),ansicall(Ctrl,format('[~w]',[M])),!.
fdmsg1(has_alternatives=G):- (G==false->true;'format'('*',[G])),!.
fdmsg1(hidden=G):- (G==false->true;'format'('$',[G])),!.
fdmsg1(goal=G):-simplify_goal_printed(G,GG),!,mesg_color(GG,Ctrl),ansicall(Ctrl,format(' ~q. ',[GG])),!.
fdmsg1(clause=[F,L]):- directory_file_path(_,FF,F),'format'('  %  ~w:~w: ',[FF,L]),!.
fdmsg1(clause=[F,L]):- fresh_line,'format'('%  ~w:~w: ',[F,L]),!.
fdmsg1(clause=[]):-'format'(' /*DYN*/ ',[]),!.
fdmsg1(G):-mesg_color(G,Ctrl),ansicall(Ctrl,format(' ~q ',[G])),!.
fdmsg1(M):-dmsg(failed_fdmsg1(M)).


simplify_m(G,M):-atom(G),sub_atom(G,_,6,0,M),!.
simplify_m(G,G).
fdmsg(fr(List)):-is_list(List),!,must((fresh_line,ignore(forall(member(E,List),fdmsg1(E))),nl)).
fdmsg(M):-ddmsg(failed_fdmsg(M)).

:-export(simplify_goal_printed/2).
simplify_goal_printed(Var,Var):- is_ftVar(Var),!.
simplify_goal_printed(setup_call_catcher_cleanup,sccc).
simplify_goal_printed(setup_call_cleanup,scc).
simplify_goal_printed(call_cleanup,cc).
simplify_goal_printed(A,'...'(SA)):- atom(A),atom_concat('/opt/PrologMUD/pack/logicmoo_base/prolog/logicmoo/',SA,A),!.
simplify_goal_printed(A,'...'(SA)):- atom(A),atom_concat('/home/dmiles/lib/swipl/pack/logicmoo_base/prolog/logicmoo/',SA,A),!.
simplify_goal_printed(A,'...'(SA)):- atom(A),atom_concat('/home/dmiles/lib/swipl/pack/logicmoo_base/t/',SA,A),!.
% simplify_goal_printed(A,'...'(SA)):- atom(A),atom_concat('/',_,A),!,directory_file_path(_,SA,A),!.
simplify_goal_printed(GOAL=A,AS):-goal==GOAL,!,simplify_goal_printed(A,AS).
simplify_goal_printed(Var,Var):- \+ compound(Var),!.
simplify_goal_printed(term_position(_,_,_,_,_),'$..term_position/4..$').
%simplify_goal_printed(user:G,GS):-!,simplify_goal_printed(G,GS).
simplify_goal_printed(system:G,GS):-!,simplify_goal_printed(G,GS).
%simplify_goal_printed(catchv(G,_,_),GS):-!,simplify_goal_printed(G,GS).
%simplify_goal_printed(catch(G,_,_),GS):-!,simplify_goal_printed(G,GS).
simplify_goal_printed('<meta-call>'(G),GS):-!,simplify_goal_printed(G,GS).
simplify_goal_printed(must_det_lm(M,G),GS):-!,simplify_goal_printed(M:must_det_l(G),GS).
simplify_goal_printed(call(G),GS):-!,simplify_goal_printed(G,GS).
simplify_goal_printed(M:G,MS:GS):-atom(M), simplify_m(M,MS),!,simplify_goal_printed(G,GS).
simplify_goal_printed([F|A],[FS|AS]):- !,simplify_goal_printed(F,FS),simplify_goal_printed(A,AS).
simplify_goal_printed(G,GS):- G=..[F|A],maplist(simplify_goal_printed,[F|A],AA),GS=..AA.



getPFA(Frame,[L|List],Goal):- !,findall(R, (member(A,[L|List]),getPFA1(Frame,A,R)) ,Goal).
getPFA(Frame,Ctrl,Goal):-getPFA1(Frame,Ctrl,Goal).

getPFA1(_Frame,txt(Txt),txt(Txt)):-!.
getPFA1(Frame,clause,Goal):-getPFA2(Frame,clause,ClRef),clauseST(ClRef,Goal),!.
getPFA1(Frame,Ctrl,Ctrl=Goal):-getPFA2(Frame,Ctrl,Goal),!.
getPFA1(_,Ctrl,no(Ctrl)).

getPFA2(Frame,Ctrl,Goal):- catchv((prolog_frame_attribute(Frame,Ctrl,Goal)),E,Goal=[error(Ctrl,E)]),!.

clauseST(ClRef,clause=Goal):- findall(V,(member(Prop,[file(V),line_count(V)]),clause_property(ClRef,Prop)),Goal).

clauseST(ClRef,Goal = HB):- ignore(((clause(Head, Body, ClRef),copy_term(((Head :- Body)),HB)))),
   snumbervars(HB,0,_),
   findall(Prop,(member(Prop,[source(_),line_count(_),file(_),fact,erased]),clause_property(ClRef,Prop)),Goal).


:- thread_local(tlbugger:ifCanTrace/0).

end_dump(true):-!,fail.
end_dump(_:GG):-!,end_dump(GG).
end_dump(GG):-compound(GG),functor(GG,F,_),atom_concat(dump,_,F).

% =====================
% dtrace/0/1/2
% =====================

dtrace:- dtrace(wdmsg("DUMP_TRACE/0")).

:- thread_local(has_auto_trace/1).
:-meta_predicate(dtrace(0)).
dtrace(G):- notrace((tracing,notrace)),!,wdmsg(tracing_dtrace(G)),setup_call_cleanup(notrace,(leash(+call),dtrace(G)),trace).
dtrace(G):- has_auto_trace(C),wdmsg(has_auto_trace(C,G)),!,call(C,G). 
%dtrace(G):- \+ tlbugger:ifCanTrace,!,hotrace((wdmsg((not(tlbugger:ifCanTrace(G)))))),!,badfood(G),!,dumpST.
%dtrace(G):- \+ tlbugger:ifCanTrace,!,hotrace((wdmsg((not(tlbugger:ifCanTrace(G)))))),!,badfood(G),!,dumpST.
dtrace(G):- nop(current_predicate(_:logicmoo_bugger_loaded/0)),!,dumptrace(G).
dtrace(G):- G. 


:-meta_predicate(dtrace(+,?)).
dtrace(MSG,G):-wdmsg(MSG),dtrace(G).

to_wmsg(G,WG):- \+ compound(G),!,WG=G.
to_wmsg(M:G,M:WG):-atom(M), to_wmsg(G,WG).
to_wmsg(dmsg(G),WG):-!, to_wmsg(G,WG).
to_wmsg(wdmsg(G),WG):-!, to_wmsg(G,WG).
to_wmsg(G,WG):- (G=WG).

% =====================
% dumptrace/1/2
% =====================
:-meta_predicate(dumptrace(?)).
dumptrace(G):- non_user_console,!,trace_or_throw(dumptrace(G)).
dumptrace(G):- notrace((tracing,notrace)),!,wdmsg(tracing_dumptrace(G)),setup_call_cleanup(notrace,(leash(+call),dumptrace(G)),trace).
dumptrace(G):- ignore((debug,
 catchv(attach_console,_,true),
 leash(+exception),visible(+exception))),fresh_line,
 (repeat,(tracing -> (!,fail) ; true)),
 to_wmsg(G,WG),
 notrace((
  fmt(in_dumptrace(G)),
  wdmsg(WG),
  show_failure(why,get_single_char(C)))),
  with_all_dmsg(dumptrace(G,C)),!.

:-meta_predicate(dumptrace(0,+)).
dumptrace(_,0'g):-!,hotrace(dumpST(500000000)),!,fail.
dumptrace(_,0'G):-!,notrace(dumpST0(500000000)),!,fail.
dumptrace(G,0'l):-!, 
  restore_trace(( notrace(ggtrace),G)),!,notrace.
dumptrace(G,0's):-!,hotrace(ggtrace),!,(hotrace(G)*->true;true).
dumptrace(G,0'S):-!, wdmsg(skipping(G)),!.
dumptrace(G,0'x):-!, wdmsg(skipping(G)),!.
dumptrace(G,0'i):-!,hotrace(ggtrace),!,ignore(G).
dumptrace(_,0'b):-!,debug,prolog,!,fail.
dumptrace(_,0'a):-!,abort,!,fail.
dumptrace(_,0'x):-!,must((lex,ex)),!,fail.
dumptrace(_,0'e):-!,halt(1),!.
dumptrace(_,0'm):-!,make,fail.
dumptrace(G,0'l):-!,visible(+all),show_and_do(rtrace(G)).
dumptrace(G,0'c):-!, show_and_do((G))*->true;true.
dumptrace(G,0'r):-!, notrace,(rtrace((G,notrace))),!,fail.
dumptrace(G,0'f):-!, notrace,(ftrace((G,notrace))),!,fail.
dumptrace(G,0't):-!,visible(+all),leash(+all),trace,!,G.
dumptrace(G,10):-!,dumptrace_ret(G).
dumptrace(G,13):-!,dumptrace_ret(G).
dumptrace(_,C):-fmt(unused_keypress(C)),!,fail.
% )))))))))))))) %
dumptrace_ret(G):-leash(+all),visible(+all),visible(+unify),trace,G.

