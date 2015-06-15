end_of_file.

:-include('logicmoo_utils_header.pl').
% this is both a latex file and a Sicstus Prolog file.
% just compile it in Prolog or Latex it.
% the only difference is that the Latex version comments out the following
% line:  (i.e., the latex vesion starts with "%/*" and the prolog has "/*")


/*
\documentclass[11pt,fleqn]{article}

%\usepackage[LY1]{fontenc}           % for Y&Y tex
%\usepackage[mtbold,LY1]{mathtime}   % for Y&Y tex

\usepackage{times,latexsym,makeidx}
\pagestyle{myheadings}
\markright{ICL interpreter --- Version 0.2.1}
\makeindex

\newcommand{\btt}{\ttfamily\bfseries}

\title{Independent Choice Logic Interpreter\\Version 0.2.1
\\PROLOG CODE\thanks{Copyright \copyright 1998 David Poole. All rights
reserved.}}
\author{David Poole\\
Department of Computer Science,\\
University of British Columbia,\\
2366 Main Mall,\\
Vancouver, B.C. Canada V6T 1Z4\\
Phone: (604) 822-6254\\
Fax: (604) 822-5485\\
Email: {\ttfamily poole@cs.ubc.ca}\\
URL: {\ttfamily http://www.cs.ubc.ca/spider/poole}}
\begin{document}
\maketitle
\begin{abstract}
This paper gives the code for a simple independent choice logic
\cite{Poole97b,Poole98a} interpreter. This is based on a naive Prolog
search (rather than some best first, or iterative deepening search).

It includes negation as failure,
controllables (although is a very limited form --- they are
not chosen, but the user can control them), and debugging facilities
(including tracing, traversing explaination trees, and automatic detection
of non-disjoint rules).

This is experimental code. It is written to let us explore with
ideas. I make no warranty as to its suitability for anything. Use at
your own risk.
\end{abstract}
\newpage
\section{Syntax} \label{vocabulary}
The following commands can be used in a file or
as a user command to the prolog prompt. Note that all commands end with a period.
\begin{description}
\item[{\btt rule$(R)$.}]
The facts are
given in the form of {\ttfamily rule($R$)}, where $R$ is either a rule of
the form {\ttfamily H :- B} or is just an atom (similar to the use of
$clause$ in many Prolog systems). $B$ is a body made up of {\ttfamily
true}, atoms, conjunctions (using ``\verb|&|''), disjunctions (using
``\verb|;|'') and negations (using ``\verb|~|''). This code assumes
that rules are disjoint. 
\item[{\ttfamily $H$  when  $B$.}] is the same as {\ttfamily rule((H :-
B))}. Rules with empty 
bodies (facts) must be written as {\ttfamily H  when  true.} or as
{\ttfamily rule(H).} 
\item[{\btt random$([h_1:p_1,\cdots,h_n:p_n])$.}]declares
the $h_i$ to be pairwise disjoint hypotheses, with $P(h_i)=p_i$. 
\item[{\btt random$(X,h,[x_1:p_1,\cdots,x_n:p_n])$.}]
where $h$ is an atom that contains variable $X$, and the $x_1$ are
different terms, declares the atoms $h$ with $X$ replaced by each
$x_i$ to be pairwise disjoint hypotheses with $P(h[x_i])=p_i$.
\item[{\btt controllable$([h_1,\cdots,h_n])$.}]declares
the $h_i$ to be pairwise disjoint controllable variables (i.e., the
agent can choose one of the $h_i$.)
\end{description}

The following commands can be used as
user commands to the prolog prompt:
\begin{description}
\item[{\btt explain$(G,C)$.}] asks to find all explanations of $G$
given controllables $C$.
\item[{\btt thconsult$(\hbox{\em filename})$.}] loads a file called
{\em filename}. This does not erase any definitions in the database.
\item[{\btt tracing(F).}] sets tracing to have status $F$ which is
one of {\ttfamily \{yes,no,duals\}}. {\ttfamily duals} traces only the
duals (i.e., the explanations of the negation of an atom).
\item[{\btt debug(F).}] sets debugging to have status $F$ which is
one of {\ttfamily \{yes,no\}}. This lets you choose which rules get
selected, so you can pinpoint missing cluases (i.e., when an answer
wasn't returned).
\item[{\btt help.}] gives a list of commands.
\item[{\btt how$(G,C,N)$.}]
is used to explain the $N$th explanation of $G$ given $C$. Called
after {\ttfamily explain$(G,C)$.}
\item[{\btt diff$(G,C,N,M)$.}] 
prints the differences in the explaination tree for the $N$th and $M$th
explanation of $G$ given $C$. Called after {\ttfamily explain$(G,C)$}.
\item[{\btt check$(G)$.}] 
checks for disjoint rules in the explanations of $G$.
 Called after {\ttfamily explain$(G,C)$.}.
\item[{\btt check\_disj$(G_1,G_2)$.}] 
checks for cases in which $G_1$ and $G_2$ are both true.
 Called after {\ttfamily explain$(G_1,C)$} and {\ttfamily explain$(G_2,C)$}.
\item[{\btt recap$(G).$}] 
recaps the explanations of $G$, with posterior probabilities of each
 explanation (i.e., given $G$). 
 Called after {\ttfamily explain$(G,C)$}.
\item[{\btt recap.}] 
gives the prior probabilities of every goal explained.
\item[{\btt check\_undef.}] checks for undefined atoms --- those atoms
in the body of rules for which there is no corresponding definition.
\item[{\btt clear.}] clears the knowledge base. This should be done before reloading clauses.
\end{description}

\section{Code}
\subsection{Operators}
The ``if'' operator is written as ``{\ttfamily  when }''.  In bodies,
conjunction is represented as ``{\ttfamily \&}'', disjunction as ``{\ttfamily
;}'', negation as failure as ``\verb|~|'', and inequality as
``\verb|\=|.
\begin{verbatim} */
%end_of_file.

% :-include('logicmoo_utils_header.pl').


:- op(1060, xfy, [ & ]).
:- op(900,fy, ~).
:- op(700,xfx, \=).
:- op(1150, xfx,  when  ).
/* \end{verbatim}
The following declare the predicates that are used to store the
object-level knowledge base.
\begin{verbatim} */
:- dynamic rul/2.
:- dynamic control/1.
:- dynamic hypothesis/2.
:- dynamic nogood/2.
/* \end{verbatim}
   
\subsection{Clearing the knowledge base}
\index{clear}
\begin{verbatim} */
clearICL :-
   retractall(rul(_,_)),
   retractall(control(_)),
   retractall(hypothesis(_,_)),
   retractall(nogood(_,_)),
   retractall(done(_,_,_,_,_)).
/* \end{verbatim}

\subsection{Declaring Rules}

$rule(R)$ where $R$ is the form of a Prolog rule. This asserts the
rule produced. 

{\ttfamily h  when  b} is the same as $rule(h,b)$.

\index{rule}
\begin{verbatim} */
/*
(H  when  B) :- rule((H :- B)).
rule((H :- B)) :- !,
  nonvar(H),nonvar(B), assertz(rul(H,B)).
rule(H) :-
   nonvar(H),assertz(rul(H,true)).
*/   

rul(H,Tf):-
	mooCache(H, Tf, Context, Ctx,Explaination).
rul(H,Tf):-
	mooCache(H, Tf,_, Context, Ctx,Explaination).

/* \end{verbatim}

$lemma(G)$ is here to make the program upwardly compatible with the
version that includes lemmata. The declaration is ignored here.

\index{rule}
\begin{verbatim} */
lemma(_).
/* \end{verbatim}

\subsection{Declaring Hypotheses}

\[\hbox{\ttfamily icl_random}([h_1:p_1,\cdots,h_n:p_n]).\]
declares the $h_i$ to be pairwise disjoint hypotheses, with $P(h_i)=p_i$.
It should be the case that 
\[\sum_{i=1}^n p_i = 1\]

This asserts $hypothesis(h_i,p_i)$ for each $i$ and asserts
$ngood(h_i,h_j)$ for each $i \neq j$.

\index{icl_random}
\begin{verbatim} */
:- op(  500, xfx,  : ).
:- dynamic hypothesis/2.
icl_random(L) :-
   probsum(L,T),
   randomt(L,T).
probsum([],0).
probsum([_:P|R],P1) :-
   probsum(R,P0),
   P1 is P0+P.
randomt([],_).
randomt([H:P|R],T) :-
   NP is P/T,
   assertz(hypothesis(H,NP)),
   make_hyp_disjoint(H,R),
   randomt(R,T).
/* \end{verbatim}
\index{make\_disjoint}
\begin{verbatim} */
make_hyp_disjoint(_,[]).
make_hyp_disjoint(H,[H2 : _ | R]) :-
   asserta(nogood(H,H2)),
   asserta(nogood(H2,H)),
   make_hyp_disjoint(H,R).
/* \end{verbatim}

\[\hbox{\ttfamily icl_random}(X,h,[x_1:p_1,\cdots,x_n:p_n]).\]
where $X$ is a variable and $h$ is an atom that contains $X$ free, and the $x_1$ are different terms, is an abbreviation for
\[\hbox{\ttfamily icl_random}([h[X \leftarrow x_1]:p_1,\cdots,h[X \leftarrow x_n]:p_n]).\]
Where $h[X \leftarrow x_1]$ is the atom $h$ with $X$ replaced by $x_i$.
\index{icl_random}
\begin{verbatim} */
icl_random(X,H,L) :-
   repvar(X,X1,H,H1),
   asserta((nogood(H,H1) :- dif(X,X1))),
   probsum(L,T),
   random_each(X,H,L,T).
random_each(_,_,[],_).
random_each(X,H,[X:P|_],T) :-
   NP is P/T,
   asserta(hypothesis(H,NP)),
   fail.
random_each(X,H,[_|R],T) :-
   random_each(X,H,R,T).
/* \end{verbatim}



\[\hbox{\ttfamily controllable}([h_1,\cdots,h_n]).\]
declares the $h_i$ to be pairwise disjoint controllable hypotheses.

This asserts $control(h_i)$ for each $i$ and asserts
$ngood(h_i,h_j)$ for each $i \neq j$.

\index{disjoint}
\begin{verbatim} */
:- op(  500, xfx,  : ).
controllable([]).
controllable([H|R]) :-
   asserta(control(H)),
   make_cont_disjoint(H,R),
   controllable(R).
/* \end{verbatim}
\index{make\_cont\_disjoint}
\begin{verbatim} */
make_cont_disjoint(_,[]).
make_cont_disjoint(H,[H2 | R]) :-
   asserta(nogood(H,H2)),
   asserta(nogood(H2,H)),
   make_cont_disjoint(H,R).
/* \end{verbatim}

\section{The Internals of the Interpreter}
\subsection{Meta-interpreter}
The meta-interpreter is implemented using the relation:
\[prove(G,C0,C1,R0,R1,P0,P1,T)\]
where
\begin{description}
\item $G$ is the goal to be proved.
\item $R1-R0$ is a difference list of icl_random assumptions to prove $G$.
\item $C1-C0$ is a difference list of controllable assumptions to prove $G$.
\item $P0$ is the probability of $R0$, $P1$ is the probability of $R1$.
\item $T$ is the returned explaination tree.
\end{description}
The first rules defining $prove$ are the special purpose rules
for commands that are defined in the system.
\index{prove}
\begin{verbatim} */


prove(ans(A),C,C,R,R,P,P,ans(A)) :- !,
   ans(A,C,R,P).
prove(report_cp,C,C,R,R,P,P,_) :- !,
   report_cp(C,R,P).
prove(report_evidence,C,C,R,R,P,P,_) :- !,
   report_evidence(C,R,P).
/* \end{verbatim}

The remaining rules are the real definition
\begin{verbatim} */
prove(true,C,C,R,R,P,P,true) :- !.
prove([],C,C,R,R,P,P,true) :- !.
prove((A & B),C0,C2,R0,R2,P0,P2,(AT & BT)) :- !,
   prove(A,C0,C1,R0,R1,P0,P1,AT),
   prove(B,C1,C2,R1,R2,P1,P2,BT).
prove([A | B],C0,C2,R0,R2,P0,P2,(AT & BT)) :- !,
   prove(A,C0,C1,R0,R1,P0,P1,AT),
   prove(B,C1,C2,R1,R2,P1,P2,BT).
prove((A ; _),C0,C2,R0,R2,P0,P2,AT) :-
   prove(A,C0,C2,R0,R2,P0,P2,AT).
prove((_ ; B),C0,C2,R0,R2,P0,P2,BT) :-
   prove(B,C0,C2,R0,R2,P0,P2,BT).

prove((~ G),C0,C0,R0,R2,P0,P3,if(G,not)) :-
   findall(R2,prove(G,C0,_,R0,R2,P0,_,_), ExpG),
   duals(ExpG,R0,[exp(R0,P0)],ADs),
   make_disjoint(ADs,MDs),
   ( (tracn(yes); tracn(duals)) -> 
        writeln(['   Proved ~ ',G ,', assuming ',R0,'.']) ,
        writeln(['     explanations of ',G,': ',ExpG]),
        writeln(['     duals: ',ADs]),
        writeln(['     disjointed duals: ',MDs])
     ; true),!,
   member(exp(R2,P3),MDs).
   

prove(H,_,_,R,_,P,_,_) :-
   tracn(yes),
   writeln(['Proving: ',H,' assuming: ',R,' prob=',P]),
   fail.
prove(H,C,C,R,R,P,P,if(H,assumed)) :-
   hypothesis(H,_),
   member(H,R),
   ( tracn(yes) 
     -> writeln(['   Already assumed: ',H ,'.']) 
    ; true).
prove(H,C,C,R,[H|R],P0,P1,if(H,assumed)) :-
   hypothesis(H,PH),
   \+ member(H,R),
   PH > 0,
   good(H,R),
   P1 is P0*PH,
   ( tracn(yes) -> writeln(['   Assuming: ',H ,'.']) ; true).
prove(H,C,C,R,R,P,P,if(H,given)) :- 
   control(H),member(H,C),!,
   ( tracn(yes) -> writeln(['   Given: ',H,'.']) ; true).
prove(H,C,C,R,R,P,P,if(H,builtin)) :- 
   builtin(H), call(H).
prove(A \= B,C,C,R,R,P,P,if(A \= B,builtin)) :- 
   dif(A,B).
prove(G,C0,C1,R0,R1,P0,P1,if(G,BT)) :-
   rul(G,B),
   ( tracn(yes) -> 
     writeln(['   Using rule: ',G ,'  when  ',B,'.']) 
   ; true),
   ( debgn(yes) -> deb(G,B) ; true),
   tprove(G,B,C0,C1,R0,R1,P0,P1,BT),
   ( tracn(yes) -> 
     writeln(['   Proved: ',G ,' assuming ',R1,'.']) 
     ; true).
     
prove((G),C0,C0,R0,R2,P0,P3,T) :-
	G=..[F,A|Rgs],
	proveE(F,G,A,Rgs,C0,C0,R0,R2,P0,P3,T).

proveE(holds,G,A,Rgs,C0,C0,R0,R2,P0,P3,T):-get_val_from_vaR(A,V),!,nonvar(V),
	NG=..[V|Rgs],prove((NG),C0,C0,R0,R2,P0,P3,T).

proveE('~holds',G,A,Rgs,C0,C0,R0,R2,P0,P3,T):-get_val_from_vaR(A,V),!,nonvar(V),
	NG=..[V|Rgs],prove((~ NG),C0,C0,R0,R2,P0,P3,T).
	
get_val_from_vaR(v(_,V,_),V):-!.
get_val_from_vaR(V,V).

prove(H,_,_,R,_,P,_,_) :-
   tracn(yes),
   writeln(['Failed: ',H,' assuming: ',R,' prob=',P]), 
   fail.
tprove(_,B,C0,C1,R0,R1,P0,P1,BT) :-
   prove(B,C0,C1,R0,R1,P0,P1,BT).
tprove(G,_,_,_,R,_,P,_,_) :-
   tracn(yes),
   writeln([' Retrying: ',G,' assuming: ',R,' prob=',P]),
   fail.
/* \end{verbatim}

We allow many built in relations to be evaluated directly by Prolog.
\index{builtin}
\begin{verbatim} */
:- dynamic builtin/1.
%:- multifile builtin/1.
builtin((_ is _)).
builtin((_ < _)).
builtin((_ > _)).
builtin((_ =< _)).
builtin((_ >= _)).
builtin((_ = _)).
/* \end{verbatim}

\begin{verbatim} */
deb(G,true) :-!.
deb(G,B) :-
   writeln([' Use rule: ',G ,'  when  ',B,'? [y, n or off]']),
   read(A),
  ( A = y -> true ;
    A = n -> fail ;
    A = off -> debug(off) ;
    true -> writeln(['y= use this rule, n= use another rule, off=debugging off']) ,
       deb(G,B)
   ).

/* \end{verbatim}
\subsection{Negation}
\[duals(Es,R0,D0,D1)\]
is true if $Es$ is a list of composite choices (all of whose tail is
$R0$), and $D1-D2$ is a list of $exp(R1,P1)$ such that $R1-R0$ is a
hitting set of negations of $Es$.
\index{dual}
\begin{verbatim} */
duals([],_,D,D).
duals([S|L],R0,D0,D2) :-
   split_each(S,R0,D0,[],D1),
   duals(L,R0,D1,D2).
/* \end{verbatim}

\[split\_each(S,R0,D0,D,D1)\]
is true if $S$ is a composite choice (with tail $R0$), and
$D2$ is $D$ together with the hitting set of negations of $D0$.
\index{split\_each}
\begin{verbatim} */
split_each(R0,R0,_,D0,D0) :- !.
split_each([A|R],R0,D0,PDs,D2) :-
   negs(A,NA),
   add_to_each(A,NA,D0,PDs,D1),
   split_each(R,R0,D0,D1,D2).
/* \end{verbatim}

\[add\_to\_each(S,R0,D0,D,D1)\]
is true if $S$ is a composite choice (with tail $R0$), and
$D2$ is $D$ together with the hitting set of negations of $D0$.
\index{add\_to\_each}
\begin{verbatim} */
add_to_each(_,_,[],D,D).
add_to_each(A,NA,[exp(E,_)|T],D0,D1) :-
   member(A,E),!,
   add_to_each(A,NA,T,D0,D1).
add_to_each(A,NA,[exp(E,PE)|T],D0,D2) :-
   bad(A,E),!,
   insert_exp(exp(E,PE),D0,D1),
   add_to_each(A,NA,T,D1,D2).
add_to_each(A,NA,[B|T],D0,D2) :-
   ins_negs(NA,B,D0,D1),
   add_to_each(A,NA,T,D1,D2).
/* \end{verbatim}

\[ins\_negs(NA,B,D0,D1)\]
is true if adding the elements of $NA$ to composite choice $B$, and
adding these to $D0$ produces $D1$.
\index{ins\_negs}
\begin{verbatim} */
ins_negs([],_,D0,D0).
ins_negs([N|NA],exp(E,PE),D,D2) :-
   hypothesis(N,PN),
   P is PN * PE,
   insert_exp(exp([N|E],P),D,D1),
   ins_negs(NA,exp(E,PE),D1,D2).
/* \end{verbatim}

\[insert\_exp(E,L0,L1)\]
is true if inserting composite choice $E$ into list $L0$ 
produces list $L1$. Subsumed elements are removed.
\index{insert\_exp}
\begin{verbatim} */
insert_exp(exp(_,0.0),L,L) :-!.
insert_exp(E,[],[E]) :- !.
insert_exp(exp(E,_),D,D) :-
   member(exp(E1,_),D),
   subset(E1,E),!.
insert_exp(exp(E,P),[exp(E1,_)|D0],D1) :-
   subset(E,E1),!,
   insert_exp(exp(E,P),D0,D1).
insert_exp(exp(E,P),[E1|D0],[E1|D1]) :-
   insert_exp(exp(E,P),D0,D1).
/* \end{verbatim}

\subsection{Making Composite Choices Disjoint}

\[make\_disjoint(L,SL)\]
is true if $L$ and $SL$ are lists of the form $exp(R,P)$, such that
$L1$ is a subset of $L$ containing minimal elements with minimal
$R$-values.
\index{ins\_neg}
\begin{verbatim} */
make_disjoint([],[]).
make_disjoint([exp(R,P)|L],L2) :-
   member(exp(R1,_),L),
   \+ incompatible(R,R1),!,
   member(E,R1), \+ member(E,R),!,
   negs(E,NE),
   split(exp(R,P),NE,E,L,L1),
   make_disjoint(L1,L2).
make_disjoint([E|L1],[E|L2]) :-
   make_disjoint(L1,L2).
split(exp(R,P),[],E,L,L1) :-
   hypothesis(E,PE),
   P1 is P*PE,
   insert_exp1(exp([E|R],P1),L,L1).
split(exp(R,P),[E1|LE],E,L,L2) :-
   hypothesis(E1,PE),
   P1 is P*PE,
   split(exp(R,P),LE,E,L,L1),
   insert_exp1(exp([E1|R],P1),L1,L2).
negs(E,NE) :-
   findall(N,nogood(E,N),NE).
insert_exp1(exp(_,0.0),L,L) :-!.
insert_exp1(exp(E,_),D,D) :-
   member(exp(E1,_),D),
   subset(E1,E),!.
insert_exp1(exp(E,P),D,[exp(E,P)|D]).
/* \end{verbatim}

\subsection{Nogoods}
We assume three relations for handling $nogoods$:
\[good(A,L)\]
fails if $[A|L]$ has a subset that has been declared nogood. We can
assume that no subset of $L$ is nogood (this allows us to more
efficiently index nogoods).
\[allgood(L)\]
fails if $L$ has a subset that has been declared nogood.
\index{good}
\begin{verbatim} */
allgood([]).
allgood([H|T]) :-
   good(H,T),
   allgood(T).

good(A,T) :-
   \+ ( makeground((A,T)), bad(A,T)).
bad(A,[B|_]) :-
   nogood(A,B).
bad(A,[_|R]) :-
   bad(A,R).
/* \end{verbatim}


\subsection{Explaining}
Channel find an explanation for a subgoal $G$ given controllables $C$ and
building on icl_random assumables $R$, we do
an $explain(G,C,R)$. Both $R$ and $C$ are optional.
\index{explain}
\begin{verbatim} */
:- dynamic done/4.
explain(G) :-
   explain(G,[],[]).
explain(G,C) :-
   explain(G,C,[]).
explain(G,C,R) :-
   prolog_statistics(runtime,_),
   ex(G,C,R).
:- dynamic false/6.
/* \end{verbatim}

$ex(G,C,R)$ tries to prove $G$ with controllables $C$ and icl_random
assumptions $R$. It repeatedly proves $G$, calling $ans$ for each
successful explaination.
\index{ex}
\index{ans}
\begin{verbatim} */
:- dynamic done/5.
ex(G,C,R0) :- 
   prove(G,C,_,R0,R,1,P,T), 
   ans(G,C,R0,R,P,T), fail.
ex(G,C,R) :-
   done(G,C,R,_,Pr),
   append(C,R,CR),
   nl,
   writeln(['Prob( ',G,' | ',CR,' ) = ',Pr]),
   prolog_statistics(runtime,[_,Time]),
   writeln(['Runtime: ',Time,' msec.']).
ex(G,C,R) :-
   \+ done(G,C,R,_,_),
   append(C,R,CR),
   nl,
   writeln(['Prob( ',G,' | ',CR,' ) = ',0.0]),
   prolog_statistics(runtime,[_,Time]),
   writeln(['Runtime: ',Time,' msec.']).

ans(G,C,R0,R,P,T) :-
   allgood(R),
   ( retract(done(G,C,R0,Done,DC))
     -> true
     ; Done=[], DC=0),
   DC1 is DC+P,
   asserta(done(G,C,R0,[expl(R,P,T)|Done],DC1)),
   nl,
   length(Done,L),
   append(C,R0,Given),
   writeln(['***** Explanation ',L,' of ',G,' given ',Given,':']),
   writeln([R]),
   writeln(['Prior = ',P]).
/* \end{verbatim}

$recap$ is used to give a list of all conditional probabilities computed.
\index{ans}
\begin{verbatim} */
recap :-
   done(G,C,R,_,Pr),
   append(C,R,CR),
   writeln(['Prob( ',G,' | ',CR,' ) = ',Pr]),
   fail.
recap.
recap(G) :-
   recap(G,_,_).
recap(G,C) :-
   recap(G,C,_).
recap(G,C,R) :-
   done(G,C,R,Expls,Pr),
   append(C,R,CR),
   writeln(['Prob( ',G,' | ',CR,' ) = ',Pr]),
   writeln(['Explanations:']),
   recap_each(_,Expls,Pr).
recap_each(0,[],_).
recap_each(N,[expl(R,P,_)|L],Pr) :-
   recap_each(N0,L,Pr),
   N is N0+1,
   PP is P/Pr,
   writeln([N0,': ',R,' Post Prob=',PP]).
   
/* \end{verbatim}

\section{Debugging}
\subsection{Help}
\begin{verbatim} */
h  when  user_help.
user_help :- writeln([
'rule(R).','
  asserts either a rule of the form H :- B or an atom.','
H  when  B. ','
   is the same as rule((H :- B)). ','
   Rules with empty bodies (facts) must be written as H  when  true. or as rule(H).','
icl_random([h1:p1,...,hn:pn]).','
   declares the hi to be pairwise disjoint hypotheses, with P(hi)=pi. ','
icl_random(X,h,[x1:p1,...,xn:pn]).','
   declares h[X/xi] to be pairwise disjoint hypotheses with P(h[X/xi])=pi.','
controllable([h1,...,hn]).','
   declares the hi to be pairwise disjoint controllable variables.','
explain(G,C). ','
   finds explanations of G given list of controlling values C.','
how(G,C,R,N).','
   is used to explain the Nth explanation of G given controllables C,','
   and randoms R.',' 
diff(G,C,N,M) ','
   prints difference in the explaination tree for the Nth and Mth explanation','
   of G given C.','
check(G,C).','
   checks for disjoint rules in the explanations of G given C.','
recap(G). ','
   recaps the explanations of G, with posterior probabilities (given G).','
recap. ','
   gives the prior probabilities of everything explained.','
thconsult(filename). ','
   loads a file called filename. ','
tracing(F). ','
    sets tracing to have status F which is one of {yes,no,duals}.','
debug(F). ','
    sets debugging to have status F which is one of {yes,no}.','
check_undef.','
    checks for undefined atoms in the body of rules.','
clear.','
    clears the knowedge base. Do this before reloading.','
    Reconsulting a program will not remove old clauses and declarations.','
help.','
    print this message.']).
/* \end{verbatim}

\subsection{Tracing}
Tracing is used to true the details of the search tree. It is ugly
except for very small programs.
\index{tracing}
\begin{verbatim} */
:- dynamic tracn/1.
tracing(V) :-
   member(V,[yes,no,duals]),!,
   retractall(tracn(_)),
   asserta(tracn(V)).
tracing(V) :-
   member(V,[on,y]),!,
   retractall(tracn(_)),
   asserta(tracn(yes)).
tracing(V) :-
   member(V,[off,n]),!,
   retractall(tracn(_)),
   asserta(tracn(no)).
tracing(_) :-
   writeln(['Argument to tracing should be in {yes,no,duals}.']),
   !,
   fail.
tracn(no).
user_help :- unix(shell('more help')).
/* \end{verbatim}
\subsection{Debugging}
Debugging is useful for determining why a program failed.
\begin{verbatim} */
:- dynamic debgn/1.
debgn(no).

debug(V) :-
   member(V,[yes,on,y]),!,
   retractall(debgn(_)),
   assert(debgn(yes)).
debug(V) :-
   member(V,[no,off,n]),!,
   retractall(debgn(_)),
   assert(debgn(no)).
debug(_) :-
   writeln(['Argument to debug should be in {yes,no}.']), !, fail.
/* \end{verbatim}

\subsection{How was a goal proved?}
The programs in this section are used to explore how explainations were generated.
\[how(G,C,R,N)\]
is used to explain the $N$th explanation of $G$ given controllables
$C$, and randoms $R$. $R$ and $C$ are optional.

\index{how}
\begin{verbatim} */
how(G,N) :-
   how(G,[],[],N).
how(G,C,N) :-
   how(G,C,[],N).
how(G,C,R,N) :-
   tree(G,C,R,N,T),
   traverse(T).
/* \end{verbatim}

\[tree(G,C,R,N,NT)\]
is true if $NT$ is the explaination tree for the $N$th explanation of $G$ given $C\wedge R$.

\index{tree}
\begin{verbatim} */
tree(G,C,R,N,NT) :-
   done(G,C,R,Done,_),
   nthT(Done,N,NT).

nthT([expl(_,_,T) |R],N,T) :-
   length(R,N),!.
nthT([_|R],N,T) :-
   nthT(R,N,T).
/* \end{verbatim}

\[traverse(T)\] 
is true if T is a tree being traversed.
\index{traverse}
\begin{verbatim} */
traverse(if(H,true)) :-
    writeln([H,' is a fact']).
traverse(if(H,builtin)) :-
    writeln([H,' is built-in.']).
traverse(if(H,assumed)) :-
    writeln([H,' is assumed.']).
traverse(if(H,given)) :-
    writeln([H,' is a given controllable.']).
traverse(if(H,not)) :-
    writeln([~ H,' is a negation - I cannot true it. Sorry.']).
traverse(if(H,B)) :-
    B \== true,
    B \== builtin,
    B \== assumed,
    B \== given,
    writeln([H,' :-']),
    printbody(B,1,Max),
    read(Comm),
    interpretcommand(Comm,B,Max,if(H,B)).
/* \end{verbatim}

\[printbody(B,N)\]
is true if B is a body to be printed and N is the 
count of atoms before B was called (this assumes that ``{\ttfamily \&}'' is 
left-associative).

\index{printbody}
\begin{verbatim} */
printbody((A&B),N,N2) :-
   printbody(A,N,N),
   N1 is N+1,
   printbody(B,N1,N2).
printbody(if(H,not),N,N) :-!,
   writeln(['   ',N,': ~ ',H]).
printbody(if(H,_),N,N) :-
   writeln(['   ',N,': ',H]).
printbody(true,N,N):-!,
   writeln(['   ',N,': true ']).
printbody(builtin,N,N):-!,
   writeln(['   ',N,': built in ']).
printbody(assumed,N,N):-!,
   writeln(['   ',N,': assumed ']).
printbody(given,N,N):-!,
   writeln(['   ',N,': given ']).
/* \end{verbatim}

\[interpretcommand(Comm,B)\]
interprets the command $Comm$ on body $B$.
\index{interpretcommand}
\begin{verbatim} */
interpretcommand(N,B,Max,G) :-
   integer(N),
   N > 0,
   N =< Max,
   nth(B,N,E),
   traverse(E),
   traverse(G).
interpretcommand(up,_,_,_).
interpretcommand(N,_,Max,G) :-
   integer(N),
   (N < 1 ; N > Max),
   writeln(['Number out of range: ',N]),
   traverse(G).
interpretcommand(help,_,_,G) :-
   writeln(['Give either a number, up or exit. End command with a Period.']),
   traverse(G).
interpretcommand(C,_,_,G) :-
   \+ integer(C),
   C \== up,
   C \== help,
   C \== exit,
   C \== end_of_file,
   writeln(['Illegal Command: ',C,'   Type "help." for help.']),
   traverse(G).

/*
% nth(S,N,E) is true if E is the N-th element of conjunction S
nth(A,1,A) :-
   \+ (A = (_&_)).

nth([H|T],N,E):-!,nth1(N,[H|T],E).

nth((A&_),1,A).
nth((_&B),N,E) :-
   N>1,
   N1 is N-1,
   nth(B,N1,E).
*/
   /* \end{verbatim}

\subsection{Diff}
\[diff(G,C,N,M)\] \index{diff}
prints the differences in the explaination tree for the $N$th and $M$th
explanation of $G$ given $C$. 

\begin{verbatim} */
diff(G,C,N,M) :-
   tree(G,C,N,NT),
   tree(G,C,M,MT),
   diffT(NT,MT).
/* \end{verbatim}

\[diffT(T1,T2)\] 
prints the differences in the explaination trees $T1$ and $T2$.
\begin{verbatim} */
diffT(T,T) :-
   writeln(['Trees are identical']).

diffT(if(H,B1),if(H,B2)) :-
   immdiff(B1,B2),!,
   writeln([H,' :-']),
   printbody(B1,1,N1),
   writeln([H,' :-']),
   printbody(B2,N1,_).
diffT(if(H,B1),if(H,B2)) :-
   diffT(B1,B2).
diffT((X&Y),(X&Z)) :- !,
   diffT(Y,Z).
diffT((X&_),(Y&_)) :-
   diffT(X,Y).

immdiff((A&_),(B&_)) :-
   immdiff(A,B).
immdiff((_&A),(_&B)) :-
   immdiff(A,B).
immdiff((_&_),if(_,_)).
immdiff(if(_,_),(_&_)).
immdiff(if(A,_),if(B,_)) :-
   \+ A = B.
immdiff(if(_,_),B) :-
   atomic(B).
immdiff(A,if(_,_)) :-
   atomic(A).
/* \end{verbatim}

\subsection{Check}
\[check(G,C,R)\]\index{check} 
checks the explanations of $G$ given controllables $C$ and randoms $R$ 
for rules which violate the disjoint
assumptions assumption. The two rules which are not disjoint are returned.

\begin{verbatim} */
check :- 
   check(_,_,_).
check(G) :-
   check(G,_,_).
check(G,C) :-
   check(G,C,_).
check(G,C,R) :-
   done(G,C,R,Done,_),
   check_done(Done).

check_done([expl(R1,_,T1)|D]) :-
   memberR(expl(R2,_,T2),D,DR),
   \+ incompatible(R1,R2),
   length(D,LD),
   length(DR,L2),
   union(R1,R2,R),
   writeln(['Non-disjoint rules ',LD,' & ',L2,' assuming ',R]),
   diffT(T1,T2).
check_done([_|D]) :-
   check_done(D).
/* \end{verbatim}

\subsection{Check Disjoint Explanations}
\[check\_disj(G0,G1)\] \index{check\_disj}
checks whether explanations of $G0$ and $G1$ are disjoint. This is useful when $G0$ and $G1$ should be incompatible.
\begin{verbatim} */
check_disj(G0,G1):-
   check_disj(G0,G1,_,_).
check_disj(G0,G1,C,R):-
   done(G0,C,R,D0,_),
   done(G1,C,R,D1,_),
   memberR(expl(R0,_,_),D0,LD0),
   memberR(expl(R1,_,_),D1,LD1),
   \+ incompatible(R0,R1),
   length(LD0,L0),
   length(LD1,L1),
   append(C,R,CR),
   writeln(['Explanation ',L0,' of ',G0,' and ',L1,' of ',G1,
       ', given ',CR,' are compatible assuming:']),
   union(R0,R1,R),
   writeln([R]).

incompatible(R1,R2) :-
   member(A1,R1),
   member(A2,R2),
   nogood(A1,A2).
/* \end{verbatim}

\subsection{Checking for undefined atoms}
$check_undef$ searches through the knowledge base looking for a rule
containing an atom in the body which doesn't have a corresponding
definition (i.e., a clause with it at the head, or an atomic choice).
\begin{verbatim} */
check_undef :-
   rul(H,B),
   body_elt_undefined(B,H,B).
check_undef.

body_elt_undefined([],_,_) :- !,fail.
body_elt_undefined(true,_,_) :- !,fail.
body_elt_undefined([A|_],H,B) :-
   body_elt_undefined(A,H,B).
body_elt_undefined([_|A],H,B) :- !,
   body_elt_undefined(A,H,B).
body_elt_undefined((A&_),H,B) :-
   body_elt_undefined(A,H,B).
body_elt_undefined((_&A),H,B) :- !,
   body_elt_undefined(A,H,B).
body_elt_undefined((~ A),H,B) :- !,
   body_elt_undefined(A,H,B).
body_elt_undefined((A;_),H,B) :-
   body_elt_undefined(A,H,B).
body_elt_undefined((_;A),H,B) :- !,
   body_elt_undefined(A,H,B).
body_elt_undefined(call(A),H,B) :- !,
   body_elt_undefined(A,H,B).
body_elt_undefined(_ \= _,_,_) :- !,fail.
%body_elt_undefined(A,_,_) :-
%   askabl(A),!,fail.
%body_elt_undefined(A,_,_) :-
%   assumabl(A),!,fail.
body_elt_undefined(A,_,_) :-
   builtin(A),!,fail.
body_elt_undefined(A,_,_) :-
   hypothesis(A,_),!,fail.
body_elt_undefined(A,_,_) :-
   rul(A,_),!,fail.
body_elt_undefined(A,H,B) :-
   writeln(['Warning: no clauses for ',A,' in rule ',(H  when  B),'.']),!,fail.
/* \end{verbatim}

\section{Miscellaneous}
\subsection{File Handling}
Channel consult a probabilistic Horn abduction file, you should do a,
\begin{verse}
{\bf thconsult}\em (filename).
\end{verse}
The following is the definition of {\em thconsult}. Basically we just
keep reading the file and executing the commands in it until we stop.
This does not clear any previous database. If you reconsult a file you
will get multiple instances of clauses and this will undoubtedly screw you up.
\index{thconsult}
\begin{verbatim} */
thconsult(File) :-
   current_input(OldFile),
   open(File,read,Input),
   set_input(Input),
   read(T),
   read_all(T),
   set_input(OldFile),
   writeln(['ICL theory ',File,' consulted.']).
/* \end{verbatim}
\index{read\_all}
\begin{verbatim} */
read_all(end_of_file) :- !.

read_all(T) :-
   (call(T);fmt('Warning: ~w failed~n',[T])),
   read(T2),
   read_all(T2).
/* \end{verbatim}

\subsection{Utility Functions}
\subsubsection{List Predicates}
$append(X,Y,Z)$ is the normal append function
\index{append} 
\begin{verbatim} */
/*
append([],L,L).

append([H|X],Y,[H|Z]) :-
   append(X,Y,Z).
/* \end{verbatim}
*/
\index{union} 
\begin{verbatim} */
/*
union([],L,L).

union([H|X],Y,Z) :-
   member(H,Y),!,
   union(X,Y,Z).
union([H|X],Y,[H|Z]) :-
   union(X,Y,Z).
*/
/* \end{verbatim}

\index{member}
\begin{verbatim} */
/*
member(A,[A|_]).
member(A,[_|R]) :-
   member(A,R).
*/
/* \end{verbatim}
\index{member}
\begin{verbatim} */
memberR(A,[A|R],R).
memberR(A,[_|T],R) :-
   memberR(A,T,R).
/* \end{verbatim}
\index{subset}
\begin{verbatim} */
/*
subset([],_).
subset([H|T],L) :-
   member(H,L),
   subset(T,L).
*/
/* \end{verbatim}
\subsubsection{Term Management}

\index{makeground}
\begin{verbatim} */
makeground(T) :-
   numbervars(T,0,_).
/* \end{verbatim}

$repvar(X,X1,T,T1)$ replaces each occurrence of $X$ in $T$ by $X1$ forming $T1$.
\index{copy}
\begin{verbatim} */
repvar(X,X1,Y,X1) :- X==Y, !.
repvar(_,_,Y,Y) :- var(Y), !.
repvar(_,_,Y,Y) :- ground(Y), !.
repvar(X,X1,[H|T],[H1|T1]) :- !,
   repvar(X,X1,H,H1),
   repvar(X,X1,T,T1).
repvar(X,X1,T,T1) :-
   T =.. L,
   repvar(X,X1,L,L1),
   T1 =.. L1.
/* \end{verbatim}
						     f
\subsubsection{Output}
\index{writeln}
\begin{verbatim} */
/*
writeln([]) :- nl,nl,!.

writeln([H|T]) :-
   write(H),
   writeln(T).
*/
/* \end{verbatim}
\bibliographystyle{plain}
%\bibliography{/ai/poole/bib/reason.string,/ai/poole/bib/poole_local_reason,/ai/poole/bib/reason}
%\bibliography{../../../book/bib/string,../../../book/bib/poole,../../../book/bib/reason}

\begin{thebibliography}{1}

\bibitem{Poole97b}
D.~Poole.
\newblock The independent choice logic for modelling multiple agents under
  uncertainty.
\newblock {\em Artificial Intelligence}, 94:7--56, 1997.
\newblock special issue on economic principles of multi-agent systems.

\bibitem{Poole98a}
D.~Poole.
\newblock Abducing through negation as failure: stable models in the
  {Independent Choice Logic}.
\newblock {\em Journal of Logic Programming}, to appear, 1998.

\end{thebibliography}

\printindex

\end{document}
*/

% Decision Theory, the Situation Calculus and Conditional Plans
% ICL axiomatization of the example from the paper.
% Copyright, David Poole, 1998.  http://www.cs.ubc.ca/spider/poole/
% (See the end for how to run this).

% ACTIONS
%    goto(Pos,Route) robot takes Route to Pos
%    pickup(X)       robot picks up X
%    unlock_door     robot unlocks the door
%    enter_lab       robot enters the lab

% Fluents
%    at(Obj,Pos,S)   Obj is at Pos in state S (and not crashed)
%    carrying(X,S)   robot is carrying X in state S
%    locked(door,S)  door is locked at state S
%    crashed(S)      robot is in a tangled mess at bottom of the stairs in S
%    value(V,S)      robot would receive V is it stopped in S
%    resources(R,S)  robot has R resources left

% Sensing conditions
%     sense(at_key,S) robot senses that it is at the same location as the key.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             INITIAL SITUATION                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% initial situation has the following probabilities
%   P(locked(door,s0)) = 0.9
%   P(at_key(r101,s0)|locked(door,s0)) = 0.7
%   P(at_key(r101,s0)|unlocked(door,s0)) = 0.2
%   ( from which we conclude P(at_key(r101,s0))=0.65

icl_random([locked(door,s0):0.9,unlocked(door,s0):0.1]).
icl_random([at_key_lo(r101,s0):0.7,at_key_lo(r123,s0):0.3]).
icl_random([at_key_unlo(r101,s0):0.2,at_key_unlo(r123,s0):0.8]).

at(key,R,s0)  when  at_key_lo(R,s0) & locked(door,s0).
at(key,R,s0)  when  at_key_unlo(R,s0) & unlocked(door,s0).

% initially the robot is at room 111.
at(robot,r111,s0)  when  true.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             LOCATION                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The robot reaches its desitination as long as it does not fall down
% the stairs and as long as it has enough resources.

at(robot,Channel,do(goto(Channel,Route),S))  when 
    at(robot,Agent,S) &
    path(Agent,Channel,Route,no,Cost) &        % not risky
    resources(R,S) &
    R >= Cost.

at(robot,Channel,do(goto(Channel,Route),S))  when 
    at(robot,Agent,S) &
    path(Agent,Channel,Route,yes,Cost) &       % is risky & don't fall down
    would_not_fall_down_stairs(S) &
    resources(R,S) &
    R >= Cost.

at(robot,Pos,do(A,S))  when 
   ~ gotoaction(A) &
   at(robot,Pos,S).

% non-robots remain where they were unless they are being carried
at(X,P,S)  when 
   X \= robot &
   carrying(X,S)&
   at(robot,P,S).

at(X,Pos,do(A,S))  when 
   X \= robot &
   ~ carrying(X,S)&
   at(X,Pos,S).

gotoaction(goto(_,_))  when  true.

% Whenever the robot goes past the stairs there is a 10% chance 
% that it will fall down the stairs, in which case it has crashed
% permanently.
% N.B. we assume when the robot has crashed, it is not "at" anywhere.

icl_random([would_fall_down_stairs(S):0.1,would_not_fall_down_stairs(S):0.9]).

crashed(do(A,S))  when  crashed(S).
crashed(do(A,S))  when  risky(A,S) & would_fall_down_stairs(S).



% path(Agent,Channel,Route,Risky,Cost)
%     Risky means whether it has to go past the stairs
path(r101,r111,direct,yes,10)  when  true.
path(r101,r111,long,no,100)  when  true.
path(r101,r123,direct,yes,50)  when  true.
path(r101,r123,long,no,90)  when  true.
path(r101,door,direct,yes,50)  when  true.
path(r101,door,long,no,70)  when  true.

path(r111,r101,direct,yes,10)  when  true.
path(r111,r101,long,no,100)  when  true.
path(r111,r123,direct,no,30)  when  true.
path(r111,r123,long,yes,90)  when  true.
path(r111,door,direct,no,30)  when  true.
path(r111,door,long,yes,70)  when  true.

path(r123,r101,direct,yes,50)  when  true.
path(r123,r101,long,no,90)  when  true.
path(r123,r111,direct,no,30)  when  true.
path(r123,r111,long,yes,90)  when  true.
path(r123,door,direct,no,20)  when  true.
path(r123,door,long,yes,100)  when  true.

path(door,r101,direct,yes,50)  when  true.
path(door,r101,long,no,70)  when  true.
path(door,r111,direct,no,30)  when  true.
path(door,r111,long,yes,70)  when  true.
path(door,r123,direct,no,20)  when  true.
path(door,r123,long,yes,100)  when  true.


risky(goto(Channel,Route),S)  when 
    path(Agent,Channel,Route,yes,_) &
    at(robot,Agent,S).


%    carrying(X,S) means robot is carrying X in state S

carrying(key,do(pickup(key),S))  when 
    at(robot,P,S) &
    at(key,P,S) &
    pickup_succeeds(S).

carrying(key,do(A,S))  when 
    carrying(key,S) &
    A \= putdown(key) &
    A \= pickup(key) &
    keeps_carrying(key,S).

% 88% chance that a legal pickup will succeed and 
% 5% chance that the robot will drop the key

icl_random([pickup_succeeds(S):0.88, pickup_fails(S):0.12]).
icl_random([keeps_carrying(key,S):0.95, drops(key,S):0.05]).


unlocked(door,do(unlock_door,S))  when 
   at(robot,door,S) &
   at(key,door,S).
unlocked(door,do(A,S))  when 
   ~ ( at(robot,door,S) & at(key,door,S)) &   % ensures rules are dijoint
   unlocked(door,S).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             UTILITY                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% utility is the prize plus the resources remaining
utility(V,S)  when  
    prize(P,S) &
    resources(R,S) &
    V is R+P.

prize(1000,S)  when  in_lab(S).
prize(-1000,S)  when  crashed(S).
prize(0,S)  when  ~ in_lab(S) & ~ crashed(S).

in_lab(do(enter_lab,S))  when 
   at(robot,door,S) &
   unlocked(door,S).

resources(200,s0)  when  true.
resources(RR,do(goto(Channel,Route),S))  when 
    at(robot,Agent,S) &
    path(Agent,Channel,Route,Risky,Cost) &
    resources(R,S) &
    RR is R-Cost.

resources(R,do(A,S))  when 
    crashed(S) &
    resources(R,S).

resources(RR,do(A,S))  when 
    ~ crashed(S) &
    ~ gotoaction(A) &
    resources(R,S) &
    RR is R-10.           % every other action costs 10


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             SENSING                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sense(at_key,S)  when 
   at(robot,P,S) &
   at(key,P,S) &
   sensor_true_pos(S).
sense(at_key,S)  when 
   at(robot,P1,S) &
   at(key,P2,S) &
   P1 \= P2 &
   sensor_false_neg(S).

% sensor to detect if at the same location as the key is noisy.
% It has a 3% false positive rate and an 8% false negative rate

icl_random([sensor_true_pos(S):0.92, sensor_false_neg(S):0.08]).
icl_random([sensor_true_neg(S):0.97, sensor_false_pos(S):0.03]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             TO RUN THIS                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This has only been tested with Sicstus Prolog, although it is
% reasonably standard Edinburgh prolog

% compile('icl_int.tex').
% thconsult('dtp.pl').

% Here is a simple plan:
% explain(utility(V,do(enter_lab,do(goto(door,direct),s0))),[],[]).

%Here is the explanations of the sensing
% explain(sense(at_key,do(goto(r101,direct), s0)),[],[]).

% The following two generate the explanations needed to determine the
% expected utility of the plan in the paper:
% explain((sense(at_key,do(goto(r101,direct), s0)) & utility(V,do(enter_lab, do(unlock_door, do(goto(door,long), do(pickup(key), do(goto(r101,direct), s0))))))) ,[],[]).

% explain((~ sense(at_key,do(goto(r101,direct), s0)) & utility(V,do(enter_lab, do(unlock_door, do(goto(door,direct), do(pickup(key), do(goto(r123,direct), do(goto(r101,direct), s0)))))))) ,[],[]).

