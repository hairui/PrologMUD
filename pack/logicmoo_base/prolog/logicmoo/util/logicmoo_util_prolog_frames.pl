  

:-moo_hide_childs(stack_depth/1).
:-moo_hide_childs(stack_check/0).
:-moo_hide_childs(stack_check/1).
:-moo_hide_childs(stack_check/2).
stack_depth(Level):-hotrace((prolog_current_frame(Frame),prolog_frame_attribute(Frame,level,Level))).

stack_check:-!.
stack_check:-stack_check(3000).
stack_check(BreakIfOver):- stack_check_else(BreakIfOver, trace_or_throw(stack_check(BreakIfOver))).
stack_check(BreakIfOver,Error):- stack_check_else(BreakIfOver, trace_or_throw(stack_check(BreakIfOver,Error))).
stack_check_else(BreakIfOver,Call):- stack_depth(Level) ,  ( Level < BreakIfOver -> true ; (dbgsubst(Call,stack_lvl,Level,NewCall),NewCall)).


in_pengines:- relative_frame(context_module,pengines,_).

% ?- relative_frame(context_module,X,Y).
:- swi_export(relative_frame/3).
relative_frame(Attrib,Term,Nth):- parent_frame_attribute(Attrib,Term,Nth,_RealNth,_FrameNum).

:- swi_export(parent_goal/2).
parent_goal(Term,Nth):- parent_frame_attribute(goal,Term,Nth,_RealNth,_FrameNum).
:- swi_export(parent_frame_attribute/5).
parent_frame_attribute(Attrib,Term,Nth,RealNth,FrameNum):-hotrace((ignore(Attrib=goal),prolog_current_frame(Frame),
                                                current_frames(Frame,Attrib,5,NextList))),!,nth1(Nth,NextList,RealNth-FrameNum-Term).


prolog_frame_match(Frame,goal,Term):-!,prolog_frame_attribute(Frame,goal,TermO),!,Term=TermO.
prolog_frame_match(Frame,parent_goal,Term):-nonvar(Term),!,prolog_frame_attribute(Frame,parent_goal,Term).
prolog_frame_match(Frame,not(Attrib),Term):-!,nonvar(Attrib),not(prolog_frame_attribute(Frame,Attrib,Term)).
prolog_frame_match(_,[],X):-!,X=[].
prolog_frame_match(Frame,[I|IL],[O|OL]):-!,prolog_frame_match(Frame,I,O),!,prolog_frame_match(Frame,IL,OL),!.
prolog_frame_match(Frame,Attrib,Term):-prolog_frame_attribute(Frame,Attrib,Term).

current_frames(Frame,Attrib,N,NextList):- N>0, N2 is N-1,prolog_frame_attribute(Frame,parent,ParentFrame),!,current_frames(ParentFrame,Attrib,N2,NextList).
current_frames(Frame,Attrib,0,NextList):- current_next_frames(Attrib,1,Frame,NextList).

current_next_frames(Attrib,Nth,Frame,[Nth-Frame-Term|NextList]):- prolog_frame_match(Frame,Attrib,Term), !,
   (prolog_frame_attribute(Frame,parent,ParentFrame) -> 
    ( Nth2 is Nth+1, current_next_frames(Attrib,Nth2, ParentFrame,NextList));
         NextList=[]).
current_next_frames(Attrib,Nth,Frame,NextList):- 
   (prolog_frame_attribute(Frame,parent,ParentFrame) -> 
    ( Nth2 is Nth+1, current_next_frames(Attrib,Nth2, ParentFrame,NextList));
         NextList=[]).
current_next_frames(_,_,_,[]).
