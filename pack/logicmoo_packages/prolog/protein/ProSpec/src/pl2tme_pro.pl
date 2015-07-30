%%% ----------------------------------------
%%% File: pl2tme_pro.pl
%%% Author: Peter Baumgartner
%%% --------------------------------------------------
%%% Normal Form Transformator
%%%
%%% $Id: pl2tme_pro.pl,v 1.6 1998/07/30 12:27:49 peter Exp $
%%% $Log: pl2tme_pro.pl,v $
%%% Revision 1.6  1998/07/30 12:27:49  peter
%%% ne geniale Aenderung
%%%
%%% Revision 1.5  1998/04/07 09:45:04  peter
%%% bug fix.
%%%
%%% Revision 1.3  1998/01/23 12:40:50  peter
%%% slight improvement to free_variables_union code.
%%%
%%% Revision 1.2  1998/01/21 15:26:44  doro
%%% nnf of simplification rules optimized, transform for simplification rules corrected
%%%
%%% Revision 1.1  1998/01/16 14:51:06  bthomas
%%% Initial revision
%%%
%%% --------------------------------------------------
%%% Last Change: 23.1.98 Peter
%%% ----------------------------------------
%%%
%%% slight improvement to free_variables_union code
%%% Peter 23.1.98
%%%
%%% ----------------------------------------
%%%
%%% treatment of Simplification rules C -> K <-> L corrected
%%% Doro 14.1.98
%%%
%%% ----------------------------------------
%%%
%%% forall(x,exists(y,p(x,y))) ==> p(x,fsk) bug fixed
%%% Peter, 14/1/98 
%%%
%%% ----------------------------------------
%%% 
%%% Added special treatment for simplification rules.
%%% Simplification rules are not transformed into cnf but skolemized.
%%% Rules with <-> must be splitted in two rules with -> because of 
%%% different skolemisation of the parts.
%%% Changes marked with %D%
%%% Doro December 97
%%% 
%%% ----------------------------------------
%%%
%%% Improved Skolemisation: try to push forall quantifier over exists quantifer
%%% so that skolem functions need fewer variables.
%%% Peter December 1997
%%%                                               
%%% ----------------------------------------
%%%
%%% Convert a file with first order predicate 
%%% logic formulas to clausal normal form
%%% in tme-syntax.
%%% Uses rather dumb algorithm.
%%% Author: Peter Baumgartner (peter@informatik.uni-koblenz.de)
%%%
%%% ----------------------------------------
%%%
%%% pl2tme_pro.pl
%%% Modified version of pl2tme_sorted.pl for use with prospec
%%% some minor changes used for ProSpec interface
%%% Benno 26.8.96
%%%
%%% ----------------------------------------
%%% 
%%% Added some new logical operators 
%%% to gain a more flexible syntax 
%%% Benno 16.4.97
%%%
%%% ----------------------------------------
%%%
%%% Added a prospec_flag query_conversion, values are
%%% aggressive: in the clauses stemming from a query formula '?- F.'
%%%   only the purely negative clauses become queries ('?-'), all others
%%%   become input clauses (':-'). This is very incomplete.
%%% conservative: in the clauses stemming from a query formula '?- F.'
%%%   all clauses become queries ('?-')
%%% Peter and Benno 15.7.
%%%
%% ----------------------------------------
%% global defs, settings, consults
%% ----------------------------------------

%%% Convert a file with first order predicate logic formulas 
%%% to clausal normal form
%%% in tme-syntax.
%%% Uses rather dumb algorithm.
%%% Author: Peter Baumgartner (peter@informatik.uni-koblenz.de)

:- set_flag(occur_check, on).
:- set_flag(output_mode, "D").
:- setval(query_conversion, aggressive).

:- [parser, misc].

:- op(1050,xfy, '<->').
:- op(1050,xfy, '<-').
:- op(1050,xfy, '<=>').
:- op(1050,xfy, '<=').
:- op(1050,xfy, '=>').
:- op(1000,xfy, '&').
:- op(1100,xfy, 'v').


%% ========================================
%% Prospec Interface =;-]
%% ========================================

%% ----------------------------------------
%% nft(+PrologTerm,+NFTClauseListTme) 
%% interface predicate to prospec
%% ----------------------------------------

nft(PTerm) :-	
        init_parser,
	t_list(PTerm,TList,Type),
	convert_general_clause_to_clauses(TList,Q,NF,SF),
        skolemlist(SF),
	comment(Q,Type),
        write_clauses(pipeout,NF,Type),
	write(pipeout,"end_of_nft. \n"),
	flush(pipeout), !.

comment(Q,T) :-
	printf(pipeout,"prospec_comment('%w formula => %Dw'). \n",[T,Q]).

skolemlist(SF) :-
	printf(pipeout,"skf(%w). \n",[SF]).
     

%% ========================================
%% Peters Stuff =:-]
%% ========================================
	
pl2tme(InFileName,OutFileName) :-
	setval(tme_cleanlit,off),
	init_parser,
	concat_atoms(InFileName,'.pl1',InFileNameExt),
	atom_string(InFileNameExt,InFileNameExtString),
	consult_file(InFileNameExtString),
	concat_atoms(OutFileName, '.tme', OutFileNameExt),
	open(OutFileNameExt, write, F),
	printf(F,"%%%% File generated by pl2tme utility.\n%%%% Have a nice proof!\n\n",[]),
	convert_clauses_to_file(F),
	close(F),
	printf("Output written to %w\n",[OutFileNameExt]).


convert_clauses_to_file(F) :-
	retract(oi_clause(C,Type)),
	convert_general_clause_to_clauses(C,FinalFormula,Clauses,SkolemFunctions),
	( Type == query ->
	    Typestring = 'Query formula:'
	; Typestring =  'Input formula:'
        ),
	printf(F,"\n%%%% %w %Dw\n",[Typestring,FinalFormula]),
        (SkolemFunctions \== [] ->
	    printf(F,"%%%% Skolem Functions: %w\n",[SkolemFunctions])
	; true),
	write_clauses(F,Clauses,Type),
	convert_clauses_to_file(F).
convert_clauses_to_file(_F).

% Convert a 'general clause' to a prolog list of clauses, 
% where a clause is a ';'-separated list 
% of literals, where '-' is the negation sign
% A general clause is a list of formulas, thought of as a disjunction 
% and all unbound prolog  
% variables being considered as universally quantified
%% the explicitly quantified formula will be left in QuantifiedFormula.
%% SkolemFunctions is a prolog list of function symbols, each function
%% symbol being a skolem function occuring in Clauses
convert_general_clause_to_clauses(GeneralClause,QuantifiedFormula,Clauses,
	     SkolemFunctions) :-
	split_clause(GeneralClause,Pos,Neg,_PosVars,_SV),
	( Pos = [] ->
	    pl_list_con(ConNeg,Neg), 
	    Formula = -(ConNeg) 
	; Neg = [] ->
	    pl_list_dis(Formula,Pos)
	; pl_list_con(ConNeg,Neg),
	  pl_list_dis(DisPos,Pos),
	  Formula = (DisPos <- ConNeg)
        ),
	convert_pl1_formula_to_clauses(Formula,QuantifiedFormula,Clauses,
	     SkolemFunctions).


%% Convert a formula to a list of clauses; 
%% here, a clause is a ';' separated list of literals
%% extra, unbound Prolog variables are treated as implicit universally quantified variables
%% the explicitly quantified formula will be left in QuantifiedFormula.
%% SkolemFunctions is a prolog list of function symbols, each function
%% symbol being a skolem function occuring in Clauses
convert_pl1_formula_to_clauses(Formula,QuantifiedFormula,Clauses,SkolemFunctions) :-
	normalize_variables(Formula,NormFormula,_BoundVars,FreeVars),
	( FreeVars == [] ->
	    QuantifiedFormula = NormFormula
	; QuantifiedFormula = forall(FreeVars,NormFormula)
        ),
	clausify(QuantifiedFormula,CNF,SkolemFunctions),
	pl_list_con(CNF,HClauses),
	norm_dis_list(HClauses,Clauses).

no_negative_clause([]).
no_negative_clause([Clause|Rest]) :-
	pl_list_dis(Clause,LitList),
	split_clause(LitList,Pos,_Neg,_PosVars,_SV),
	Pos \== [],
	no_negative_clause(Rest).


write_clauses(F,Clauses,Type) :-
	(Type == query, getval(query_conversion,aggressive),
	 no_negative_clause(Clauses)
        ) -> 
	write_clauses_conservative(F,Clauses,Type) 
        ; write_clauses_aggressive(F,Clauses,Type).

write_clauses_aggressive(_F,[],_Type).
write_clauses_aggressive(F,[Clause|Rest],Type) :-
	pl_list_dis(Clause,LitList),
	split_clause(LitList,Pos,Neg,_PosVars,_SV),
	(Type == query ->
	    ((getval(query_conversion,aggressive) , Pos \== []) ->
	        NewType = input
	      ; NewType = query)
	  ; NewType = Type),
	write_tme_clause(F,Pos,Neg,NewType),
	write_clauses_aggressive(F,Rest,Type).

write_clauses_conservative(_F,[],_Type).
write_clauses_conservative(F,[Clause|Rest],Type) :-
	pl_list_dis(Clause,LitList),
	split_clause(LitList,Pos,Neg,_PosVars,_SV),
	write_tme_clause(F,Pos,Neg,Type),
	write_clauses_conservative(F,Rest,Type).

% bind variable to its printname:
bind_variables([]).
% not needed:
%bind_variables([X:Sort|R]) :- !,
%	% bind variable to its printname:
%	get_var_info(X,name,X),
%	bind_variables(R).
bind_variables([X:_Sort|R]) :- 
	(var(X) -> get_var_info(X,name,X) ; true),
%	(var(Sort) -> get_var_info(Sort,name,Sort) ; true),
	bind_variables(R).

%%%%%%%%% Conversion

%D% special treatment for simplification rules
%D% nnf gets additional argument
clausify(F,Res,SkolemFunctions) :-
	getval(simplifier_mode,true), !, 
	nnf(sim,F,Fnnf),	
        matrix(Fnnf,Matrix),
	cnf(Matrix,Mcnf),
	norm_con(Mcnf,NMcnf), 
	set_matrix(Fnnf,NMcnf,FNMcnf),
	skolemize(FNMcnf,NMcnf,[],ZwiRes,SkolemFunctions),
	norm_sim( ZwiRes, Res), !.

clausify(F,Res,SkolemFunctions) :-
	nnf(oth,F,Fnnf),
	matrix(Fnnf,Matrix),
	cnf(Matrix,Mcnf),
	norm_con(Mcnf,NMcnf), 
	set_matrix(Fnnf,NMcnf,FNMcnf),
	skolemize(FNMcnf,NMcnf,[],Res,SkolemFunctions), !.

matrix(exists(_X,F),R) :- 
        matrix(F,R).
matrix(forall(_X,F),R) :- 
        matrix(F,R).
matrix(R,R).

set_matrix(exists(X,F),NewMatrix,exists(X,R)) :-
	set_matrix(F,NewMatrix,R).
set_matrix(forall(X,F),NewMatrix,forall(X,R)) :-
	set_matrix(F,NewMatrix,R).
set_matrix(_F,NewMatrix,NewMatrix).


%%% nnf -- put into negation normal form, also normalizes quantified variables as lists
%D% nnf gets additional argument to split prennf

nnf(Mode,F,FT) :-
	prennf(Mode,F,FP),
	prenex(FP,FT).


%D% original prennf splitted into two predicates
%D% prennf_sim saves the syntax of simplification rules 
%D% but normalizes subformulae by prennf

prennf(sim, (C -> A <-> B), ((NC -> NA -> NB), (NC -> NNA -> NNB))) :-
	prennf(oth, C, NC),
	prennf(oth, A, NA),
	prennf(oth, B, NB),
	prennf(oth, -(A), NNA),
	prennf(oth, -(B), NNB).

prennf(sim, (C -> A -> B), (NC -> NA -> NB)) :-
	prennf(oth, C, NC),
	prennf(oth, A, NA),
	prennf(oth, B, NB).

prennf(sim, (C -> A=B), (NC -> A=B)) :-
	prennf(oth, C, NC).

prennf(sim, (A <-> B), ((NA -> NB), (NNA -> NNB))) :-
 	prennf(oth, A, NA),
	prennf(oth, B, NB),
	prennf(oth, -(A), NNA),
	prennf(oth, -(B), NNB).

prennf(sim, (A -> B), (NA -> NB)) :-
	prennf(oth, A, NA),
	prennf(oth, B, NB).

%D% here starts the original prennf

prennf(Mode, ~ A, NA)       :- prennf(Mode, - A, NA).
prennf(Mode, (A <=> B), R)  :- prennf(Mode, (A <-> B), R).
prennf(Mode, (A  => B), R)  :- prennf(Mode, (A  -> B), R).
prennf(oth,  (B <=  A), R)  :- prennf(oth,  (A  -> B), R).
prennf(oth,  (A <-> B), R)  :- prennf(oth,  ((A -> B), (B -> A)), R).
prennf(oth,  (B <-  A), R)  :- prennf(oth,  (A  -> B), R).
prennf(oth,  (A  -> B), R)  :- prennf(oth,  (- A ; B), R).

prennf(Mode, - (~ A), NA)   :- prennf(Mode, A, NA).
prennf(Mode, - (- A), NA)   :- prennf(Mode, A, NA).

prennf(oth, - (A <-> B), R) :- prennf(oth, (A <-> - B), R).
prennf(oth, - (A  -> B), R) :- prennf(oth, - (- A ; B), R).
prennf(oth, - (B <-  A), R) :- prennf(oth, - (B ; - A), R).
prennf(oth, - (B <=  A), R) :- prennf(oth, - (B ; - A), R).

prennf(oth, - (A , B), R)   :- prennf(oth, (- A ; - B), R).
prennf(oth, - (A & B), R)   :- prennf(oth, (- A ; - B), R).
prennf(oth, - (A ; B), R)   :- prennf(oth, (- A , - B), R).
prennf(oth, - (A v B), R)   :- prennf(oth, (- A , - B), R).

prennf(oth, (A & B), R)     :- prennf(oth, (A , B), R).
prennf(oth, (A v B), R)     :- prennf(oth, (A ; B), R).

prennf(oth, (A , B), (NA , NB)) :-
	prennf(oth, A, NA),
	prennf(oth, B, NB).

prennf(oth, (A ; B), (NA ; NB)) :-
	prennf(oth, A, NA),
	prennf(oth, B, NB).

%% this can obviously be programmed in a more compact way:
prennf(Mode, - exists(X,A), forall(XVec,NNA)) :-
	make_vector(X,XVec),
	prennf(Mode, -A, NNA).
prennf(Mode, exists(X,A), exists(XVec,NA)) :-
	make_vector(X,XVec),
	prennf(Mode, A, NA).
prennf(Mode, - forall(X,A), exists(XVec,NNA)) :-
	make_vector(X,XVec),
	prennf(Mode, -A, NNA).
prennf(Mode, forall(X,A), forall(XVec,NA)) :-
	make_vector(X,XVec),
	prennf(Mode, A, NA).

prennf(oth, - A, - A).
prennf(_, B, B).


%%  works on pre-nnf, assumes variables sorted and as vectors
%D% &, v, =>, <=> replaced by nnf
%D% added some cuts to avoid infinite loops in case of errors
%D% additional operator occurs in simplification rules ->

prenex(forall(X,F), forall(X,Res)) :- !, prenex(F, Res).
prenex(exists(X,F), exists(X,Res)) :- !, prenex(F, Res).

%D% prenex((F & G), R) :- prenex( (F , G), R).
%D% prenex((F v G), R) :- prenex( (F ; G), R). 

prenex((F , G), R) :- !,
	prenex(F, FP), 
	prenex(G, GP),
	prenexq((FP, GP), R).

prenex((F ; G) , R) :- !,
	prenex(F, FP), 
	prenex(G, GP),
	prenexq((FP ; GP),R).

%D%
prenex((F -> G) , R) :- !,
	prenex( F, FP),
	prenex( G, GP),
	prenexq((FP -> GP),R).

prenex(F, F).


prenexq((forall(X,F), G) , forall(X1,Res)) :- !,
	new_quantification(forall(X,F),forall(X1,F1)),
	prenexq((F1,G), Res).
prenexq((G , forall(X,F)) , forall(X1,Res)) :- !,
	new_quantification(forall(X,F),forall(X1,F1)),
	prenexq((G,F1), Res).
%D%prenexq((G & forall(X,F)) , forall(X1,Res)) :-
%D%	new_quantification(forall(X,F),forall(X1,F1)),
%D%	prenexq((G,F1), Res).
prenexq((forall(X,F); G) , forall(X1,Res)) :- !,
	new_quantification(forall(X,F),forall(X1,F1)),
	prenexq((F1;G), Res).
%D%prenexq((forall(X,F) v G) , forall(X1,Res)) :-
%D%	new_quantification(forall(X,F),forall(X1,F1)),
%D%	prenexq((F1;G), Res).
prenexq((G ; forall(X,F)) , forall(X1,Res)) :- !,
	new_quantification(forall(X,F),forall(X1,F1)),
	prenexq((G;F1), Res).
%D%prenexq((G v forall(X,F)) , forall(X1,Res)) :-
%D%	new_quantification(forall(X,F),forall(X1,F1)),
%D%	prenexq((G;F1), Res).
%D%
prenexq((forall(X,F) -> G), exists(X1,Res)) :- !,
	new_quantification(exists(X,-F),exists(X1,-F1)),
	prenexq((F1 -> G), Res).
prenexq((G -> forall(X,F)), forall(X1,Res)) :- !,
	new_quantification(forall(X,F),forall(X1,F1)),
	prenexq((G -> F1), Res).

prenexq((exists(X,F), G) , exists(X1,Res)) :- !,
	new_quantification(exists(X,F),exists(X1,F1)),
	prenexq((F1,G), Res).
prenexq((G , exists(X,F)) , exists(X1,Res)) :- !,
	new_quantification(exists(X,F),exists(X1,F1)),
	prenexq((G,F1), Res).
%D%prenexq((G & exists(X,F)) , exists(X1,Res)) :-
%D%	new_quantification(exists(X,F),exists(X1,F1)),
%D%	prenexq((G,F1), Res).
prenexq((exists(X,F); G) , exists(X1,Res)) :- !,
	new_quantification(exists(X,F),exists(X1,F1)),
	prenexq((F1;G), Res).
%D%prenexq((exists(X,F) v G) , exists(X1,Res)) :-
%D%	new_quantification(exists(X,F),exists(X1,F1)),
%D%	prenexq((F1;G), Res).
prenexq((G ; exists(X,F)) , exists(X1,Res)) :- !,
	new_quantification(exists(X,F),exists(X1,F1)),
	prenexq((G;F1), Res).
%D%prenexq((G v exists(X,F)) , exists(X1,Res)) :-
%D%	new_quantification(exists(X,F),exists(X1,F1)),
%D%	prenexq((G;F1), Res).
prenexq((exists(X,F) -> G), forall(X1,Res)) :- !,
	new_quantification(forall(X,-F),forall(X1,-F1)),
	prenexq((F1 -> G), Res).
prenexq((G -> exists(X,F)), exists(X1,Res)) :- !,
	new_quantification(exists(X,F),exists(X1,F1)),
	prenexq((G -> F1), Res).

%D%prenexq((F v G) , (F ; G)).
prenexq((F ; G) , (F ; G)).
prenexq((F , G) , (F , G)).
%D%prenexq((F & G) , (F , G)).
prenexq((F -> G) , (F -> G)).


%%% normlaization; convert a variable to a vector
make_vector([],[]) :- !.
make_vector([A|B],[A|B]) :- !.
make_vector(A,[A]).

%%% normlaization; same as make_vector, but this time join sort info
make_sorted_vector(A,[A:_]) :- (var(A) ; (atomic(A), A \== [])), !.
make_sorted_vector(A:Sort,[A:Sort]).
make_sorted_vector([],[]) :- !.
make_sorted_vector([A|B],[(A:_)|BR]) :- 
	(var(A) ; (atomic(A), A \== [])), !,
	make_sorted_vector(B,BR).
make_sorted_vector([(A:Sort)|B],[(A:Sort)|BR]) :- !,
	make_sorted_vector(B,BR).


%D% &, v, =>, <=, <=> replaced by nnf 
%D% additionally ->, <-, <-> replaced by nnf for non-simplification rules 
%D% commenting these clauses prevents from splitting the predicate

%D%cnf(- (A <-> B),  R) :-
%D%	cnf(- ((A->B) , (B->A)),R).
%D%cnf(- (A <=> B),  R) :-
%D%	cnf(- ((A->B) , (B->A)),R).

%D%cnf((A <-> B),  R) :- 
%D%	cnf(((A->B) , (B->A)),R).
%D%cnf((A <=> B),  R) :- 
%D%	cnf(((A->B) , (B->A)),R).

%D%cnf(- (A -> B), R) :-
%D%	cnf(- (- A ; B), R).
%D%cnf(- (A => B), R) :-
%D%	cnf(- (- A ; B), R).

%D%cnf(- (B <- A), R) :- 
%D%	cnf(- (B ; - A), R).
%D%cnf(- (B <= A), R) :- 
%D%	cnf(- (B ; - A), R).

%D%cnf((A -> B), R) :-
%D%	cnf((- A ; B), R).
%D%cnf((A => B), R) :-
%D%	cnf((- A ; B), R).

%D%cnf((B <- A), R) :-
%D%	cnf((B ; - A), R).
%D%cnf((B <= A), R) :-
%D%	cnf((B ; - A), R).

%D%cnf(- (A , B), R) :-
%D%	cnf((- A ;  - B), R).
%D%cnf(- (A & B), R) :-
%D%	cnf((- A ;  - B), R).

cnf((A , B), (NA , NB)) :-
	cnf(A, NA),
	cnf(B, NB).
%D%cnf((A & B), (NA , NB)) :-
%D%	cnf(A, NA),
%D%	cnf(B, NB).

%D%cnf(- (A ; B), (NNA , NNB)) :-
%D%	cnf(- A, NNA),
%D%	cnf(- B, NNB).
%D%cnf(- (A v B), (NNA , NNB)) :-
%D%	cnf(- A, NNA),
%D%	cnf(- B, NNB).

cnf((A ; B),  R) :-
	cnf(A , NA),
	cnf(B , NB),
	cnf1((NA ; NB),  R).
%D%cnf((A v B),  R) :-
%D%	cnf(A , NA),
%D%	cnf(B , NB),
%D%	cnf1((NA ; NB),  R).

%D% some new clauses for simplification rules
%D% no cnf of the subformulas
cnf( (A -> (( B -> C), (-D -> -E))), ((A -> B -> C), (A -> -D -> -E))) :-
	B == D, C == E.

%D%cnf(- (- A),  NA) :- cnf(A,NA).

cnf(- A,  - A).

cnf(B,  B).

cnf1( ((AF, AR) ; B) ,  R) :-
	cnf(((AF ; B) , (AR ; B)), R).
%D%cnf1( ((AF & AR) ; B) ,  R) :-
%D%	cnf(((AF ; B) , (AR ; B)), R).

cnf1( (A ; (BF, BR)) , R) :-
	cnf(((A ; BF) , (A ; BR)),R).
%D%cnf1( (A ; (BF & BR)) , R) :-
%D%	cnf(((A ; BF) , (A ; BR)),R).
cnf1( (A ; B) ,  (A ; B)).

%% works only for CNF
norm_con(((A , B) , C), (FN , R)) :-
	norm_con((A , B), (F , G)),
	norm_dis(F, FN),
	norm_con((G, C), R).
norm_con((A , B), (NA , NB)) :-	
        norm_dis(A, NA),
	norm_con(B, NB).
%norm_con(A,NA) :-
%	norm_dis(A, NA).
norm_con(A, NA) :- norm_dis(A,NA).

%D% added some clauses for simplification rules (operator ->)
norm_dis( (A -> B), (NA -> NB)) :-
	norm_con( A, NA),
	norm_con( B, NB).
norm_dis(((A ; B) ; C), (F ; R)) :-
	norm_dis((A ; B), (F ; G)),
	norm_dis((G ; C), R).
norm_dis((A ; B), (A ; NB)) :-
	norm_dis(B, NB).
%norm_dis(A,NA) :-
%	norm_dis(A, NA).
norm_dis(A, A).

%D% aus der -> Form wieder die <-> herleitem, wenn moeglich und norm_con
norm_sim( ((A -> B -> C), (D -> E -> F)), (A -> B <-> C)) :-
	prennf(oth,-B,NB),
	prennf(oth,-C,NC),
	A == D, NB == E, NC == F.
norm_sim( ((A -> B) , (C -> D)), (A <-> B)) :-
	prennf(oth,-A,NA),
	prennf(oth,-B,NB),
	NA == C, NB == D.
norm_sim( A, A).

%%%%%%%%%% Variable utilities

:- setval(varctr,0).
:- setval(skctr,0).

newvar(NewVar) :-
	getval(varctr,S),
	integer_atom(S,SA),
	concat_atoms('X',SA,NewVar),
	incval(varctr).

is_lowercase(Atom) :-
	name(Atom,[Code|_]),
	97 =< Code, %% 'a'
	Code =< 122. %% 'z'

is_uppercase(Atom) :-
	name(Atom,[Code|_]),
	65 =< Code, %% 'A'
	Code =< 90. %% 'Z'

to_uppercase(Atom,UppercaseAtom) :-
	name(Atom,[Code|Rest]),
	UCode is Code-32,
	name(UppercaseAtom,[UCode|Rest]).

newvar(Base,NewVar) :-
	( var(Base) ->
	    %% use Base itself
	    get_var_info(Base,name,BaseName)
	  ; is_lowercase(Base) ->
	    to_uppercase(Base,BaseName)
	  ; is_uppercase(Base) ->
	    Base = BaseName
	  ; concat_atoms('X', Base,BaseName)
        ),
	concat_atoms(BaseName,'_',BaseName1),
	getval(varctr,S),
	integer_atom(S,SA),
	concat_atoms(BaseName1,SA,NewVar),
	incval(varctr).

newvar(Base,NewVar) :-
	getval(varctr,S),
	integer_atom(S,SA),
	concat_atoms('X',Base,H),
	concat_atoms(H,SA,NewVar),
	incval(varctr).

%%%%%%%%%%%%%% Skolemisation

skolemfunction(Vars,Res,NewSkF) :-
	getval(skctr,S),
	integer_atom(S,SA),
	concat_atoms('fsk',SA,NewSkF),
	Res =.. [NewSkF|Vars],
	incval(skctr).
%p% new:

/*
 * free_variables_union(Conjunction,X,UVs,GUVs).
 * Conjunction = (C1,...,Cn) is a conjunction of formulae, spearated by ','
 * X is a variable
 * UVs is a list of variables, the universal quantified ones wrt. the existential
 * quantified variable x is to be skolemized
 * Let UVi be the subset of UVs such that UVi is the set of free variables also in Ci
 * Let XUVi be UVi in case X also occurs in Ci, the empty set else.
 * GUVs is the union of all XUVis
 * GUVs is the set of universally quantified variables which are used in the skolem function 
 * for X
 */

%free_variables_union(_Con,_X,UVs,UVs) :- write(x), !.

free_variables_union((Con1,Con2),X,UVs,GUVs) :-
	unionq(X,UVs,XUVs),
	free_variables(Con1,XUVs,HCon1vars),
	(intersectq(X,HCon1vars,[]) ->
	  free_variables_union(Con2,X,UVs,GUVs)
	; % Here we know that X occurs in Con1
	  free_variables(Con1,UVs,Con1vars),
	  free_variables_union(Con2,X,UVs,Con2vars),
	  unionq(Con1vars,Con2vars,GUVs
         )).
free_variables_union(Con,X,UVs,GUVs) :-
	unionq(X,UVs,XUVs),
	free_variables(Con,XUVs,Convars),
	(intersectq(X,Convars,[]) -> 
	   GUVs = []
	;  % Here we know that X occurs in Con
	   free_variables(Con,UVs,GUVs)).


%% skolemize works for prenex normal form
skolemize(exists(X,F),Matrix,UVs,FS,Skolems) :-
% Peter 14/1/98: 
	% X ist bereits sortiert, d.h. von der Form X = Z:S
	% aber in Matrix kommt moeglicherweise Z ohne sortenannotation vor. Deshalb:
	newvar_vector(X,X1,X_X1_Pairs),
	subst_vector(X_X1_Pairs,F,F1),
	subst_vector(X_X1_Pairs,Matrix,Matrix1),
	free_variables_union(Matrix1,X1,UVs,GUVs),
	skolemfunction_vector(GUVs,X1,XSkFPairs,ThisSkolems),
%	skolemfunction_vector(UVs,X,XSkFPairs,ThisSkolems),
	subst_vector(XSkFPairs, F1, Fsk),
	subst_vector(XSkFPairs, Matrix1, Matrixsk),
	skolemize(Fsk,Matrixsk,UVs,FS,FSkolems),
	append(ThisSkolems,FSkolems,Skolems).

skolemize(forall(X,F),Matrix,UVs,FS,Skolems) :-
	%% make sure that inner existential quantification will not introduce variables
	%% by a universal quantification within that existential quantifier
	newvar_vector(X,X1,X_X1_Pairs),
	subst_vector(X_X1_Pairs,F,F1),
	subst_vector(X_X1_Pairs,Matrix,Matrix1),
%	new_quantification(forall(X,F),forall(X1,F1)),
	append(X1,UVs,F1UVs),
	skolemize(F1,Matrix1,F1UVs,FS,Skolems).

skolemize(F,_Matrix,_UVs,F,[]).


/* old version where inner existential quantifiers introduced new variables
%% skolemize works for prenex normal form
skolemize(exists(X,F),UVs,FS,Skolems) :-
	skolemfunction_vector(UVs,X,XSkFPairs,ThisSkolems),
	subst_vector(XSkFPairs, F, Fsk),
	skolemize(Fsk,UVs,FS,FSkolems),
	append(ThisSkolems,FSkolems,Skolems).
skolemize(forall(X,F),UVs,FS,Skolems) :-
	%% make sure that inner existential quantification will not introduce variables
	%% by a universal quantification within that existential quantifier
	new_quantification(forall(X,F),forall(X1,F1)),
	append(X1,UVs,F1UVs),
	skolemize(F1,F1UVs,FS,Skolems).
*/
/* %% Old code, where variables are non- vectors
skolemize(exists(X,F),UVs,FS) :-
	skolemfunction(UVs,SkF),
	subst(X/SkF, F, Fsk),
	skolemize(Fsk,UVs,FS).

skolemize(forall(X,F),UVs,FS) :-
	%% make sure that inner existential quantification will not introduce variables
	%% by a universal quantification within that existential quantifier
	%%new_quantification(forall(X,F),forall(X1,F1)),
	newvar(X,Y),
	subst(X/Y,F,F1),
	skolemize(F1,[Y|UVs],FS).
*/
	
%% Down at Matrix:
skolemize(Matrix,_UVs,Matrix,[]).

%%% 2nd result is suitable for subst_vector:
newvar_vector([],[],[]).
newvar_vector([(X:Sort)|R],[(XN:Sort)|RN],[(X:Sort)/(XN:Sort)|RNPairs]) :-
	newvar(X,XN), 
	newvar_vector(R,RN,RNPairs).

%%% generate vector of skolemfunctions for binding universal variables UVars
%%% result is suitable for subst_vector:
skolemfunction_vector(_UVars,[],[],[]).
skolemfunction_vector(UVars,[(EVar:ResSort)|RestEVars],
% Peter 14/1/97: remove sort from skolemfunction, only _variables_ are sorted
	[(EVar:ResSort)/(SkF)|RRestEVars],[(NewSkF:ResSort)|RestSkolems]) :-
%	[(EVar:ResSort)/(SkF:ResSort)|RRestEVars],[NewSkF|RestSkolems]) :-
	skolemfunction(UVars,SkF,NewSkF),
	skolemfunction_vector(UVars,RestEVars,RRestEVars,RestSkolems).


new_quantification(forall(X,F),forall(X1,F1)) :-
	newvar_vector(X,X1,X_X1_Pairs),
	subst_vector(X_X1_Pairs,F,F1).
new_quantification(exists(X,F),exists(X1,F1)) :-
	newvar_vector(X,X1,X_X1_Pairs),
	subst_vector(X_X1_Pairs,F,F1).

quantified_formula(forall(X,F),forall,X,F).
quantified_formula(exists(X,F),exists,X,F).


shielded(X:Sort,Vars) :- \+ \+ member(X:Sort,Vars), !.

subst_vector([],Formula,Formula).
subst_vector([(X:Sort)/T|R],Formula,Result) :-
	subst((X:Sort)/T,Formula,H),
	subst_vector(R,H,Result).

%D% &, v, =>, <=, <=>, <-, <-> replaced in nnf
%D%subst(X/T,(A <-> B),(SA <-> SB)) :- subst(X/T,A,SA), subst(X/T,B,SB).
%D%subst(X/T,(A <=> B),(SA <-> SB)) :- subst(X/T,A,SA), subst(X/T,B,SB).
subst(X/T,(A  -> B),(SA  -> SB)) :- subst(X/T,A,SA), subst(X/T,B,SB).
%D%subst(X/T,(A  => B),(SA  -> SB)) :- subst(X/T,A,SA), subst(X/T,B,SB).
%D%subst(X/T,(A <-  B),(SA  <- SB)) :- subst(X/T,A,SA), subst(X/T,B,SB).
%D%subst(X/T,(A <=  B),(SA  <- SB)) :- subst(X/T,A,SA), subst(X/T,B,SB).
%D%subst(X/T,(A &B),(SA,SB)) :- subst(X/T,A,SA), subst(X/T,B,SB).
subst(X/T,(A,B),(SA,SB)) :- subst(X/T,A,SA), subst(X/T,B,SB).
subst(X/T,(A;B),(SA;SB)) :- subst(X/T,A,SA), subst(X/T,B,SB).
%D%subst(X/T,(A v B),(SA;SB)) :- subst(X/T,A,SA), subst(X/T,B,SB).
subst(X/T,- F,- F1) :- subst(X/T,F,F1).

subst(X/T,QuantForm,Res) :-
	quantified_formula(QuantForm,Q,V,F),
	\+ shielded(X,V),
	subst(X/T,F,F1),
	quantified_formula(Res,Q,V,F1).
	
%
%subst(X/_T,forall(X,F),forall(X,F)).
%subst(X:SortX/T,forall(Y:SortY,F),forall(Y,F1)) :-
%	X \== Y, subst(X/T,F,F1).
%subst(X/_T,exists(X,F),exists(X,F)).
%subst(X/T,exists(Y,F),exists(Y,F1)) :-
%	X \== Y, subst(X/T,F,F1).
%% down at literal case:
subst(X/T,L,LS) :-
	L =.. [P|Args],
	subst_list(X/T,Args,SArgs),
	LS =.. [P|SArgs].

subst_list(_X/_T,[],[]).
subst_list(X/T,[S|R],[ST|RR]) :-
	subst_term(X/T,S,ST),
	subst_list(X/T,R,RR).

%subst_term(X/T,Y,T) :-
%	var(Y), X == Y.
%subst_term(X/_T,Y,Y) :-
%	var(Y), X \== Y.
%subst_term(X/T,Y,T) :-
%	atomic(Y), Y == X.
%% is this correct?:
subst_term((X:_Sort)/T,X,T).
subst_term((X:Sort)/T,(X:Sort),T).
subst_term((X:_Sort)/_T,Y,Y) :- (atomic(Y), Y \== []), X \= Y.
subst_term((X:_SortX)/_T, Y:SortY, Y:SortY) :- X \= Y.
subst_term((X:Sort)/T,S,ST) :-
	S =.. [F|Args],
	subst_list((X:Sort)/T,Args,SArgs),
	ST =.. [F|SArgs].

%%% slooooooooooooow:
%% F is the input formula
%% the rest are result parameters:
%% NF is the  formula with normalized variables:
%%    All variables are annotated by sorts and replaced by their printname, 
%%    thus are Prolog constants
%% BV contains list of bound variables in formula
%% FV contains list of free variables in formula (given as Prolog variable)

%D% &, v, =>, <=, <=>, <-, <-> replaced in nnf
%D% -> only for simplification rules

normalize_variables(F, NF, BV, FV) :-
	(F = (A <-> B) ; F = (A <=> B) ; 
	     F = (A -> B) ; F = (A => B) ; F = (A <- B) ; F = (A <= B) ; 
	     F = (A , B) ; F = (A & B) ;
	    F = (A ; B) ; F = (A v B)), !, 
	normalize_variables(A,NA,BA,FA),
	normalize_variables(B,NB,BB,FB),
	union(BA,BB,BV),
	union(FA,FB,FV),
	functor(F,Junctor,2),
	NF =.. [Junctor,NA,NB].

normalize_variables(QF,NQF,BV,FV) :-
	quantified_formula(QF,Quantor,X,F),
	make_sorted_vector(X,XVec), 
	bind_variables(XVec),
	normalize_variables(F,NF,BF,FV),
	union(BF,XVec,BV),
	quantified_formula(NQF,Quantor,XVec,NF).

%% down at literal level
normalize_variables(-A, -NA, BV, FV) :-
	normalize_variables(A,NA,BV,FV).
normalize_variables(Lit,  Lit, [], XVec) :-
	term_variables(Lit, X),
	make_sorted_vector(X,XVec), 
	bind_variables(XVec).
	


strip_sort(A:_Sort,A) :- (var(A) ; (atomic(A), A \== [])), !.
strip_sort(A,A) :- (var(A) ; (atomic(A), A \== [])), !.
strip_sort(A:_Sort,R) :- 
	A \= [_|_],
	A =.. [Fun|Args],
	strip_sort(Args,SArgs),
	R =.. [Fun|SArgs].
strip_sort(A,R) :- 
	A \= [_|_],
	A \= [],
	A =.. [Fun|Args],
	strip_sort(Args,SArgs),
	R =.. [Fun|SArgs].

strip_sort([],[]).
strip_sort([F|R],[SF|SR]) :-
	strip_sort(F,SF),
	strip_sort(R,SR).

free_variables((A <-> B), UVs, R) :-
	free_variables(A,UVs, BA),
	free_variables(B,UVs, BB),
	unionq(BA,BB,R).
free_variables((A -> B), UVs, R) :-
	free_variables(A,UVs, BA),
	free_variables(B,UVs, BB),
	unionq(BA,BB,R).
free_variables((A <- B), UVs, R) :-
	free_variables(A,UVs, BA),
	free_variables(B,UVs, BB),
	unionq(BA,BB,R).
free_variables(-A, UVs, R) :-
	free_variables(A,UVs, R).
free_variables((A , B), UVs, R) :-
	free_variables(A,UVs, BA),
	free_variables(B,UVs, BB),
	unionq(BA,BB,R).
free_variables((A ; B), UVs, R) :-
	free_variables(A,UVs, BA),
	free_variables(B,UVs, BB),
	unionq(BA,BB,R).
free_variables(forall(X,F),UVs, R) :-
	free_variables(F,UVs, RF),
	make_vector(X,XVec),
	subtractq(RF,XVec,R).
free_variables(exists(X,F),UVs, R) :-
	free_variables(F,UVs, RF),
	make_vector(X,XVec),
	subtractq(RF,XVec,R).

%% down at literal level
free_variables(B,  UVs, R) :-
	free_variables_term(B,  UVs, R).

free_variables_term(B,  UVs, [B]) :-
	memberq(B,UVs).
free_variables_term(B,  _UVs, []) :-
	(var(B) ; atomic(B)). % a variable which is not in the scope of UVs, or a constant

free_variables_term(T,  UVs, Res) :-
	functor(T,_F,A),
	free_variables_term(T,UVs,A,Res), !.
free_variables_term(_T,_UVs, 0,[]) :- !.
free_variables_term(T,UVs,M,Res) :-
	arg(M,T,TM),
	free_variables_term(TM,UVs,VH),
	N is M-1,
	free_variables_term(T,UVs,N,V1),
	unionq(VH,V1,Res).



skip_clause(F,C,comment) :-
	name(C,[StringCommentSign_ascii|Rest]),
	Comment_sign = '%',
%	getval(comment_sign,Comment_sign),
	name(Comment_sign,[Comment_sign_ascii]),
	(StringCommentSign_ascii = Comment_sign_ascii ->
	    NewC = C %% have the correct comment sign
	%% else replace first char by correct comment sign for output language
	; name(NewC,[Comment_sign_ascii|Rest])), 
	printf(F,"%w\n",[NewC]).
skip_clause(F,C,skip) :-
%	writeq(F,C), nl(F).
	printf(F,"%q.\n",C).

