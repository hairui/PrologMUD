% =======================================================
/** <module> 
%
%= predicates to examine the state of pfc 
% interactively exploring Pfc justifications.
%
% Logicmoo Project PrologMUD: A MUD server written in Prolog
% Maintainer: Douglas Miles
% Dec 13, 2035
%
*/
% =======================================================
% File: /opt/PrologMUD/pack/logicmoo_base/prolog/logicmoo/mpred/mpred_list_triggers.pl
:- module(mpred_listing,
          [ draw_line/0,
            loop_check_just/1,
            mpred_ask/2,
            mpred_classify_facts/4,
            mpred_command/3,
            mpred_contains_term/2,
            mpred_interactive_why/0,
            mpred_interactive_why/1,
            mpred_list_triggers_0/1,
            mpred_list_triggers_1/1,
            mpred_list_triggers_nlc/1,
            mpred_list_triggers_types/1,
            mpred_queue/0,
            mpred_select_justificationNode/3,
            mpred_trace_item/2,
            mpred_why/0,
            mpred_why/1,
            mpred_why1/1,
            mpred_whyBrouse/2,
            mpred_why_command/3,
            nth_mpred_call/3,
            pp_facts/0,
            pp_facts/1,
            pp_facts/2,
            pp_item/2,
            pp_items/2,
            pp_justification1/2,
            pp_justifications/2,
            pp_justifications2/3,
            pp_rules/0,
            pp_supports/0,
            pp_triggers/0,
            pp_why/1,
            pppfc/0,
            print_db_items/1,
            print_db_items/2,
            print_db_items/3,
            print_db_items/4,
            print_db_items_and_neg/3,
            show_pred_info/1,
            show_pred_info_0/1,
            why/1,
            whymemory/2
          ]).
% autoloading user:portray_clause_pi/2 from /opt/PrologMUD/pack/logicmoo_base/prolog/logicmoo/util/logicmoo_util_first
:- multifile % (multifile) :-
        '$included'/4,
        '$load_context_module'/3,
        hook_mpred_listing/1,
        mpred_list_triggers/1.
:- meta_predicate % (meta_predicate) :-
        mpred_list_triggers_nlc(?).
:- module_transparent % (module_transparent) :-
        loop_check_just/1,
        mpred_ask/2,
        mpred_classify_facts/4,
        mpred_command/3,
        mpred_contains_term/2,
        mpred_interactive_why/0,
        mpred_interactive_why/1,
        mpred_list_triggers/1,
        mpred_list_triggers_0/1,
        mpred_list_triggers_1/1,
        mpred_list_triggers_types/1,
        mpred_queue/0,
        mpred_select_justificationNode/3,
        mpred_trace_item/2,
        mpred_why/0,
        mpred_why/1,
        mpred_why1/1,
        mpred_whyBrouse/2,
        mpred_why_command/3,
        nth_mpred_call/3,
        pp_facts/0,
        pp_facts/1,
        pp_facts/2,
        pp_item/2,
        pp_items/2,
        pp_justification1/2,
        pp_justifications/2,
        pp_justifications2/3,
        pp_rules/0,
        pp_supports/0,
        pp_triggers/0,
        pp_why/1,
        pppfc/0,
        print_db_items/1,
        print_db_items/2,
        print_db_items/3,
        print_db_items/4,
        print_db_items_and_neg/3,
        show_pred_info/1,
        show_pred_info_0/1,
        why/1,
        whymemory/2.
:- dynamic % (dynamic) :-
        '$included'/4,
        '$load_context_module'/3,
        hook_mpred_listing/1,
        mpred_list_triggers/1,
        whymemory/2.


:- include('mpred_header.pi').

:- multifile
  	user:portray/1,
  	user:prolog_list_goal/1,
  	user:prolog_predicate_name/2,
  	user:prolog_clause_name/2.

:- dynamic
  	user:portray/1.


mpred_queue :- listing(mpred_queue/2).



pppfc :-
  pp_facts,
  pp_rules,
  pp_triggers,
  pp_supports,
  mpred_queue.

%= pp_facts ...

pp_facts :- pp_facts(_,true).

pp_facts(Pattern) :- pp_facts(Pattern,true).

pp_facts(P,C) :-
  mpred_facts(P,C,L),
  mpred_classify_facts(L,User,Pfc,_Rule),
  draw_line,
  fmt("User added facts:",[]),
  pp_items(Type,User),
  draw_line,
  draw_line,
  fmt("Pfc added facts:",[]),
  pp_items(Type,Pfc),
  draw_line.


pp_items(Type,[]).
pp_items(Type,[H|T]) :-
  ignore(pp_item(Type,H)),!,
  pp_items(Type,T).
pp_items(Type,H) :- ignore(pp_item(Type,H)).


mpred_trace_item(_,_):- tlbugger:ifHideTrace,!.
mpred_trace_item(MM,H):- ignore(t_l:mpred_trace_exec-> on_x_rtrace(in_cmt(pp_item(MM,H))); true).


   
pp_item(MM,(H:-B)):- B ==true,pp_item(MM,H).
pp_item(MM,H):- flag(show_asserions_offered,X,X+1),t_l:print_mode(html),!, (\+ \+ pp_item_html(MM,H)),!.

pp_item(MM,spftY(KB,P,F,T,W)):-!,
   w_tl(t_l:current_why_source(W),pp_item(MM,spft(KB,P,F,T))).

pp_item(MM,spft(KB,W0,U,U)):- W = (KB:W0),!,pp_item(MM,U:W).
pp_item(MM,spft(KB,W0,F,U)):- W = (KB:W0),atom(U),!,    fmt('~N%~n',[]),pp_item(MM,U:W), fmt('rule: ~p~n~n', [F]),!.
pp_item(MM,spft(KB,W0,F,U)):- W = (KB:W0),         !,   fmt('~w~nd:       ~p~nformat:    ~p~n', [MM,W,F]),pp_item(MM,U).
pp_item(MM,nt(KB,Trigger0,Test,Body)) :- Trigger = (KB:Trigger0), !, fmt('~w n-trigger: ~p~ntest: ~p~nbody: ~p~n', [MM,Trigger,Test,Body]).
pp_item(MM,pt(KB,F0,Body)):- F = (KB:F0),             !,fmt('~w p-trigger:~n', [MM]), pp_i2tml_now((F:-Body)).
pp_item(MM,bt(KB,F0,Body)):- F = (KB:F0),             !,fmt('~w b-trigger:~n', [MM]), pp_i2tml_now((F:-Body)).


pp_item(MM,U:W):- !,sformat(S,'~w  ~w:',[MM,U]),!, pp_item(S,W).
pp_item(MM,H):- \+ \+ (( get_clause_vars_for_print(H,HH),fmt("~w ~p~N",[MM,HH]))).

mpred_classify_facts([],[],[],[]).

mpred_classify_facts([H|T],User,Pfc,[H|Rule]) :-
  mpred_db_type(H,rule),
  !,
  mpred_classify_facts(T,User,Pfc,Rule).

mpred_classify_facts([H|T],[H|User],Pfc,Rule) :-
  mpred_get_support(H,(u,u)),
  !,
  mpred_classify_facts(T,User,Pfc,Rule).

mpred_classify_facts([H|T],User,[H|Pfc],Rule) :-
  mpred_classify_facts(T,User,Pfc,Rule).


print_db_items(T, I):- 
    draw_line, 
    fmt("~w ...~n",[T]),
    print_db_items(I),
    draw_line.

print_db_items(F/A):-number(A),!,functor(P,F,A),!,print_db_items(P).
print_db_items(I):- bagof(I,clause_u(I,true),R1),pp_items(Type,R1),!.
print_db_items(I):- listing(I),!,nl,nl.

pp_rules :-
   print_db_items("Forward Rules",(_ ==> _)),
   print_db_items("Bidirectional Rules",(_ <==> _)), 
   print_db_items("implication Rules",(_ => _)),
   print_db_items("Bi-conditional Rules",(_ <=> _)),
   print_db_items("Backchaining Rules",(_ <- _)),
   print_db_items("Positive Facts",(nesc(_))),
   print_db_items("Negative Facts",(neg(_))).

pp_triggers :-
     print_db_items("Positive hideTriggers",pt(_,_)),
     print_db_items("Negative hideTriggers", nt(_,_,_)),
     print_db_items("Goal hideTriggers",bt(_,_)).

pp_supports :-
  % temporary hack.
  draw_line,
  fmt("Supports ...~n",[]),
  setof((S > P), mpred_get_support(P,S),L),
  pp_items(Type,L),
  draw_line.

draw_line:- (t_l:print_mode(H)->true;H=unknown),fmt("~N%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%~n",[]),H=H.

 :- meta_predicate loop_check_just(0).
loop_check_just(G):-loop_check(G,ignore(arg(1,G,[]))).

% ======================= mpred_file('pfcwhy').	% interactive exploration of justifications.

%   File   : pfcwhy.pl
%   Author : Tim Finin, finin@prc.unisys.com
%   Updated:
%   Purpose: predicates for interactively exploring Pfc justifications.

% ***** predicates for brousing justifications *****

:-dynamic(whymemory/2).
:-thread_local(t_l:is_mpred_interactive_why/0).

:- use_module(library(lists)).

mpred_interactive_why:- w_tl(t_l:is_mpred_interactive_why,mpred_why).

mpred_why :-
  whymemory(P,_),
  mpred_why(P).

why(N) :- mpred_why(N).

mpred_interactive_why(N):- w_tl(t_l:is_mpred_interactive_why,mpred_why(N)).

mpred_why(N) :-
  number(N),
  !,
  whymemory(P,Js),
  mpred_why_command(N,P,Js).

mpred_why(P) :-
  no_repeats(justifications(P,Js)),
  retractall_i(whymemory(_,_)),
  assert_i(whymemory(P,Js)),!,
  mpred_whyBrouse(P,Js).

mpred_why1(P) :-
  justifications(P,Js),!,
  mpred_whyBrouse(P,Js).

mpred_whyBrouse(P,Js) :-
  pp_justifications(P,Js),!,
  (t_l:is_mpred_interactive_why -> ((
  mpred_ask(' >> ',Answer),
  mpred_why_command(Answer,P,Js))); true).

mpred_why_command(q,_,_) :- !.
mpred_why_command(h,_,_) :-
  !,
  fmt("~N%
Justification Browser Commands:
 q   quit.
 N   focus on Nth justification.
 N.MM brouse step MM of the Nth justification
 u   up a level
",
[]).

mpred_why_command(N,_P,Js) :-
  float(N),
  !,
  mpred_select_justificationNode(Js,N,Node),
  mpred_why1(Node).

mpred_why_command(u,_,_) :-
  % u=up
  !.

mpred_command(N,_,_) :-
  integer(N),
  !,
  fmt("~w is a yet unimplemented command.",[N]),
  fail.

mpred_command(X,_,_) :-
 fmt("~w is an unrecognized command, enter h. for help.",[X]),
 fail.

pp_why(P):- is_list(P),!,maplist(pp_why,P),!.

pp_why(P):-must((
  no_repeats(P,justifications(P,Js)),
      pp_justifications(P,Js))),!.

pp_justifications(P,Js) :-
  fmt("Justifications for ~w:",[P]),
  must(pp_justification1(Js,1)).

pp_justification1([],_).

pp_justification1([J|Js],N) :-
  % show one justification and recurse.
  nl,
  pp_justifications2(J,N,1),
  N2 is N+1,
  loop_check_just(pp_justification1(Js,N2)).

pp_justifications2([],_,_).

pp_justifications2([C|Rest],JustNo,StepNo) :-  
  fmt("    ~w.~w ~w",[JustNo,StepNo,C]),
  StepNext is 1+StepNo,
  loop_check_just(pp_justifications2(Rest,JustNo,StepNext)).

mpred_ask(Msg,Ans) :-
  fmt("~w",[Msg]),
  read(Ans).

mpred_select_justificationNode(Js,Index,Step) :-
  JustNo is integer(Index),
  nth_mpred_call(JustNo,Js,Justification),
  StepNo is 1+ integer(Index*10 - JustNo*10),
  nth_mpred_call(StepNo,Justification,Step).

nth_mpred_call(N,List,Ele):-N2 is N+1,lists:nth0(N2,List,Ele).



show_pred_info(F/A):-integer(A),functor(H,F,A),!,show_pred_info(H).
show_pred_info(Head):-
        doall(show_call(no_repeats(isa(Head,_)))),
        functor(Head,F,_),
        doall(show_call(no_repeats(isa(F,_)))),
     (current_predicate(_,Head) -> show_pred_info_0(Head); wdmsg(cannot_show_pred_info(Head))),!.

show_pred_info_0(Head):- 
        doall(show_call(predicate_property(Head,_))),
        (has_cl(Head)->doall((show_call(clause(Head,_))));hotrace((listing(Head)))),!.


% ===================================================
% Pretty Print Formula
% ===================================================


print_db_items(Title,Mask,What):-print_db_items(Title,Mask,Mask,What).
print_db_items(Title,Mask,SHOW,What0):-
     get_pi(Mask,H),get_pi(What0,What),
     format(atom(Showing),'~p for ~p...',[Title,What]),
     statistics(cputime,Now),Max is Now + 2,!,
       gripe_time(1.0,
         doall((once(statistics(cputime,NewNow)),NewNow<Max,clause_or_call(H,B),
             hotrace(mpred_contains_term(What,(H:-B))),
             flag(print_db_items,LI,LI+1),
             ignore(hotrace(pp_item(Showing,SHOW)))))),
     ignore(pp_item(Showing,done)),!.

mpred_contains_term(What,_):-is_ftVar(What),!.
mpred_contains_term(What,Inside):- compound(What),!,(\+ \+ ((copy_term_nat(Inside,Inside0),snumbervars(Inside0),contains_term(What,Inside0)))),!.
mpred_contains_term(What,Inside):- (\+ \+ once((subst(Inside,What,foundZadooksy,Diff),Diff \=@= Inside ))),!.


lmconf:hook_mpred_listing(What):- on_x_rtrace(mpred_list_triggers(What)).

:-thread_local t_l:mpred_list_triggers_disabled.
% listing(L):-w_tl(t_l:mpred_list_triggers_disabled,listing(L)).

mpred_list_triggers(What):-t_l:mpred_list_triggers_disabled,!.
mpred_list_triggers(What):-loop_check(mpred_list_triggers_nlc(What)).

:-meta_predicate(mpred_list_triggers_nlc(?)).

mpred_list_triggers_nlc(MM:What):-atom(MM),!,MM:mpred_list_triggers(What).
mpred_list_triggers_nlc(What):-loop_check(mpred_list_triggers_0(What),true).

mpred_list_triggers_0(What):-get_pi(What,PI),PI\=@=What,mpred_list_triggers(PI).
mpred_list_triggers_0(What):-nonvar(What),What=neg(Then),!, \+ \+ mpred_list_triggers_1(Then), \+ \+ mpred_list_triggers_1(What).
mpred_list_triggers_0(What):- \+ \+  mpred_list_triggers_1(neg(What)), \+ \+ mpred_list_triggers_1(What).

mpred_list_triggers_types('Triggers').
mpred_list_triggers_types('Instances').
mpred_list_triggers_types('Subclasses').
mpred_list_triggers_types('ArgTypes').
mpred_list_triggers_types('Arity').
mpred_list_triggers_types('Forward').
mpred_list_triggers_types('Bidirectional').
mpred_list_triggers_types('Backchaining').
mpred_list_triggers_types('Negative').
mpred_list_triggers_types('Sources').
mpred_list_triggers_types('Supports').
mpred_list_triggers_types('Edits').

% print_db_items_and_neg(Title,Fact,What):-nonvar(Fact),Fact=neg(_),!,fail.
print_db_items_and_neg(Title,Fact,What):-print_db_items(Title,Fact,What).
print_db_items_and_neg(Title,Fact,What):-print_db_items(Title,neg(Fact),What).

mpred_list_triggers_1(neg(What)):-var(What),!.
mpred_list_triggers_1(neg(_What)):-!.
mpred_list_triggers_1(What):-var(What),!.
mpred_list_triggers_1(What):-
   print_db_items('Supports User',spft_precanonical(P,u,u),spft(P,u,u),What),
   print_db_items('Forward Facts',(nesc(F)),F,What),
   print_db_items('Forward Rules',(_==>_),What),
 ignore((What\=neg(_),functor(What,IWhat,_),
   print_db_items_and_neg('Instance Of',isa(IWhat,_),IWhat),
   print_db_items_and_neg('Instances: ',isa(_,IWhat),IWhat),
   print_db_items_and_neg('Subclass Of',genls(IWhat,_),IWhat),
   print_db_items_and_neg('Subclasses: ',genls(_,IWhat),IWhat))),
   print_db_items('PFC Watches', pfcMark(_,_,_,_),What),
   print_db_items('Triggers Negative', nt(_,_,_),What),
   print_db_items('Triggers Goal',bt(_,_),What),
   print_db_items('Triggers Positive',pt(_,_),What),
   print_db_items('Bidirectional Rules',(_<==>_),What), 
   dif(A,B),print_db_items('Supports Deduced',spft_precanonical(P,A,B),spft(P,A,B),What),
   dif(G,u),print_db_items('Supports Nonuser',spft_precanonical(P,G,G),spft(P,G,G),What),
   print_db_items('Backchaining Rules',(_<-_),What),
   % print_db_items('Edits',is_disabled_clause(_),What),
   print_db_items('Edits',is_edited_clause(_,_,_),What),
   print_db_items('Instances',isa(_,_),What),
   print_db_items('Subclasses',genls(_,_),What),
   print_db_items('Negative Facts',neg(_),What),

   print_db_items('ArgTypes',argGenls(_,_,_),What),
   print_db_items('ArgTypes',argIsa(_,_,_),What),
   print_db_items('ArgTypes',argQuotedIsa(_,_,_),What),
   print_db_items('ArgTypes',meta_argtypes(_),What),
   print_db_items('ArgTypes',predicate_property(G,meta_predicate(G)),What),
   print_db_items('ArgTypes',resultGenls(_,_),What),
   print_db_items('ArgTypes',resultIsa(_,_),What),
   print_db_items('Arity',arity(_,_),What),
   print_db_items('Arity',current_predicate(_),What),
   print_db_items('MetaFacts Predicate',predicate_property(_,_),What),
   print_db_items('Sources',module_property(_,_),What),
   print_db_items('Sources',mpred_module(_,_),What),
   print_db_items('Sources',source_file(_,_),What),
   print_db_items('Sources',_:man_index(_,_,_,_,_),What),
   print_db_items('Sources',_:'$pldoc'(_,_,_,_),What),
   print_db_items('Sources',_:'$pred_option'(_,_,_,_),What),
   print_db_items('Sources',_:'$mode'(_,_),What),
   !.     

