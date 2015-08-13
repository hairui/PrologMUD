
%%% Convert a file with first order predicate logic formulas to clausal normal form
%%% in tme-syntax.
%%% Uses rather dumb algorithm.
%%% Author: Peter Baumgartner (peter@informatik.uni-koblenz.de)


:- set_flag(occur_check, on).
:- set_flag(output_mode, "Dm").
%% abolish some unwanted infix ops:


%:- op(1050,xfy, '<->').
%:- op(1050,xfy, '<-').
%:- op(1050,xfy, '<=>').
%:- op(1050,xfy, '<=').
%:- op(1050,xfy, '=>').
%:- op(1000,xfy, '&').
%:- op(1100,xfy, 'v').

% from tptp2X.main:
:-op(100,fx,++).
:-op(100,fx,--).
:-op(401,fy,~).
:-op(502,xfy,'|').
:-op(502,xfy,'v'). % peter
:-op(502,xfy,'~|').
:-op(502,xfy,\/).     %----To go
:-op(502,xfy,\~/).    %----To go
:-op(503,xfy,&).
:-op(503,xfy,~&).
:-op(503,xfy,/\).     %----To go
:-op(503,xfy,/~\).    %----To go
:-op(504,xfy,=>).
:-op(504,xfy,<-). % peter
:-op(504,xfy,<=).
:-op(505,xfy,<->). % peter
:-op(505,xfy,<=>).
:-op(505,xfy,<~>).
%----! and ? are of higher precedence than : so !X:p(X) is :(!(X),p(X))
%----Otherwise !X:!Y:p(X,Y) cannot be parsed.
:-op(400,fx,!).
:-op(400,fx,?).
%----Need : stronger than + for equality and otter in tptp2X
%----Need : weaker than ~ for !X : ~p. This means bracketing in ~ (! X ...)
%----Need : stronger than binary connectives for !X : p(X) <=> !Y ...
:-op(450,xfy,:).
%---- .. used for range in tptp2X. Needs to be stronger than :
:-op(400,xfx,'..').


:- meta_attribute(eclipse, [unify:unify_sort/2, print:print_sort/2]).

unify_sort(_Term, _Attr). % currently there is not much to be done.
print_sort(_V{Attr}, AttrOut) :-
	-?->
	AttrOut = Attr.

test(Clauses) :- 
	clausify((forall([Y{set},Z{set}], ((Y=Z) <-> 
	  forall(U{el},(in(U,Y) <-> in(U,Z)))))),CNF),
	pl_list_con(CNF,Clauses).
	  


:- [myread, parser, misc].



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
	close(F).


pl2tptp(InFileName,OutFileName) :-
	setval(tme_cleanlit,off),
	init_parser,
	concat_atoms(InFileName,'.pl1',InFileNameExt),
	atom_string(InFileNameExt,InFileNameExtString),
	consult_file(InFileNameExtString),
	concat_atoms(OutFileName, '.p', OutFileNameExt),
	open(OutFileNameExt, write, F),
	printf(F,"%%%% File generated by pl2tptp utility.\n%%%% Have a nice proof!\n\n",[]),
	convert_clauses_to_tptp_file(F),
	close(F).


convert_clauses_to_file(F) :-
	retract(oi_clause(C,Type)),
	((Type == comment ; Type == skip) ->
	    skip_clause(F,C,Type) %% Keep the comments
        ; 
	    convert_general_clause_to_clauses(C,FinalFormula,Clauses),
	    ( Type == query ->
		Typestring = 'Query formula:'
	    ; Typestring =  'Input formula:'
            ),
	    printf(F,"%%%% %w %Dw\n",[Typestring,FinalFormula]),
	    write_clauses(F,Clauses,Type),
	    printf(F,"\n",[])),
	convert_clauses_to_file(F).
convert_clauses_to_file(_F).

% Convert a 'general clause' to a prolog list of clauses, where a clause is a ';'-separated list 
% of literals, where '-' is the negation sign
% A general clause is a list of formulas, thought of as a disjunction and all unbound prolog 
% variables being considered as universally quantified
%% the explicitly quantified formula will be left in QuantifiedFormula.
convert_general_clause_to_clauses(GeneralClause,QuantifiedFormula,Clauses) :-
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
	convert_pl1_formula_to_clauses(Formula,QuantifiedFormula,Clauses).


convert_clauses_to_tptp_file(F) :-
	retract(oi_clause(C,Type)),
	((Type == comment ; Type == skip) ->
	    skip_clause(F,C,Type) %% Keep the comments
        ; 
	    % there is some overhead here...:
	    convert_general_clause_to_clauses(C,FinalFormula,_Clauses),
	    write_tptp_formula(F,FinalFormula,Type),
	    printf(F,"\n",[])),
	convert_clauses_to_tptp_file(F).
convert_clauses_to_tptp_file(_F).


write_tptp_formula(F,Formula,Type) :-
	(Type == query -> TPTPType = conjecture ; TPTPType = hypothesis),
	pl_tptp(Formula,TPTPF),
	printf(F,"input_formula(unknown,%w,(%n",[TPTPType]),
	printf(F,"  %Dw )).%n%n",[TPTPF]),
        !.


%% Convert a formula to a list of clauses; 
%% here, a clause is a ';' separated list of literals
%% extra, unbound Prolog variables are treated as implicit universally quantified variables
%% the explicitly quantified formula will be left in QuantifiedFormula.
convert_pl1_formula_to_clauses(Formula,QuantifiedFormula,Clauses) :-
	%% transform  all remaining (Prolog) into atoms:
	term_variables(Formula,FormulaPrologVars),
	bind_variables(FormulaPrologVars),
	%% find all bound variables, and treat extra variables as universally quantified:
	bound_variables(Formula,BoundVars),
	subtractq(FormulaPrologVars,BoundVars,ExtraVars),
	( ExtraVars == [] ->
	    QuantifiedFormula = Formula
	; QuantifiedFormula = forall(ExtraVars,Formula)
        ),
	clausify(QuantifiedFormula,CNF),
	pl_list_con(CNF,Clauses).
%        write(HClauses),nl,
%	norm_dis_list(HClauses,Clauses).

write_clauses(_F,[],_Type).
write_clauses(F,[Clause|Rest],Type) :-
	pl_list_dis(Clause,LitList),
	split_clause(LitList,Pos,Neg,_PosVars,_SV),
	write_tme_clause(F,Pos,Neg,Type),
	write_clauses(F,Rest,Type).

bind_variables([]).
bind_variables([X|R]) :-
	% bind variable to its printname:
	get_var_info(X,name,X),
	bind_variables(R).

%%%%%%%%% Conversion
%:- set_flag(print_depth,50).
%p%
clausify(F,Res) :-
	nnf(F,Fnnf),
	matrix(Fnnf,Matrix),
	cnf(Matrix,Mcnf),
	norm_con(Mcnf,NMcnf), 
	set_matrix(Fnnf,NMcnf,FNMcnf),
	skolemize(FNMcnf,NMcnf,[],Res), !.

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
%p%

pl_tptp(- A, NA) :- pl_tptp(A,~ NA).
pl_tptp(~ A, NA) :- pl_tptp(A,~ NA).


pl_tptp((A <-> B),  (NA <=> NB)) :- 
	pl_tptp(A,NA), pl_tptp(B,NB).
pl_tptp((A <=> B),  (NA <=> NB)) :- 
	pl_tptp(A,NA), pl_tptp(B,NB).

pl_tptp((A -> B), NA => NB) :-
	pl_tptp(A,NA), pl_tptp(B,NB).
pl_tptp((A => B), NA => NB) :-
	pl_tptp(A,NA), pl_tptp(B,NB).
pl_tptp((A <- B), NA <= NB) :-
	pl_tptp(A,NA), pl_tptp(B,NB).
pl_tptp((A <= B), NA <= NB) :-
	pl_tptp(A,NA), pl_tptp(B,NB).

pl_tptp((A , B), (NA & NB)) :-
	pl_tptp(A, NA),
	pl_tptp(B, NB).
pl_tptp((A & B), (NA & NB)) :-
	pl_tptp(A, NA),
	pl_tptp(B, NB).

pl_tptp((A ; B),  (NA ; NB)) :-
	pl_tptp(A , NA),
	pl_tptp(B , NB).
pl_tptp((A v B),  (NA ; NB)) :-
	pl_tptp(A , NA),
	pl_tptp(B , NB).


pl_tptp( exists(X,A), (? [X] : NA)) :-
	( var(X) ; atom(X)),
	pl_tptp(A,NA).
pl_tptp( exists(X,A), (? X : NA)) :-
	pl_tptp(A,NA).
pl_tptp( forall(X,A), (! [X] : NA)) :-
	( var(X) ; atom(X)),
	pl_tptp(A,NA).
pl_tptp( forall(X,A), (! X : NA)) :-
	pl_tptp(A,NA).

pl_tptp(A, A).



%%% nnf -- put into negation normal form, also normalizes quantified variables as lists
nnf(F,FT) :-
	prennf(F,FP),
	prenex(FP,FT).

prennf(- (- A), NA) :- prennf(A,NA).

prennf(- (A <-> B),  R) :-
	prennf(((-A ; -B) , (A ; B)),R).
prennf(- (A <=> B),  R) :-
	prennf(((-A ; -B) , (A ; B)),R).

prennf((A <-> B),  R) :- 
	prennf(((A->B) , (B->A)),R).
prennf((A <=> B),  R) :- 
	prennf(((A->B) , (B->A)),R).

prennf(- (A -> B), R) :-
	prennf(- (- A ; B), R).
prennf(- (A => B), R) :-
	prennf(- (- A ; B), R).

prennf(- (B <- A), R) :- 
	prennf(- (B ; - A), R).
prennf(- (B <= A), R) :- 
	prennf(- (B ; - A), R).

prennf((A -> B), R) :-
	prennf((- A ; B), R).
prennf((A => B), R) :-
	prennf((- A ; B), R).

prennf((B <- A), R) :-
	prennf((B ; - A), R).
prennf((B <= A), R) :-
	prennf((B ; - A), R).


prennf(- (A , B), R) :-
	prennf((- A ; - B), R).
prennf(- (A & B), R) :-
	prennf((- A ; - B), R).

prennf((A , B), (NA , NB)) :-
	prennf(A, NA),
	prennf(B, NB).
prennf((A & B), (NA , NB)) :-
	prennf(A, NA),
	prennf(B, NB).

prennf(- (A ; B), (NNA , NNB)) :-
	prennf(- A, NNA),
	prennf(- B, NNB).
prennf(- (A v B), (NNA , NNB)) :-
	prennf(- A, NNA),
	prennf(- B, NNB).

prennf((A ; B),  (NA ; NB)) :-
	prennf(A , NA),
	prennf(B , NB).
prennf((A v B),  (NA ; NB)) :-
	prennf(A , NA),
	prennf(B , NB).



prennf(- exists(X,A), forall(XVec,NNA)) :-
	make_vector(X,XVec),
	prennf(-A,NNA).
prennf( exists(X,A), exists(XVec,NA)) :-
	make_vector(X,XVec),
	prennf(A,NA).

prennf(- forall(X,A), exists(XVec,NNA)) :-
	make_vector(X,XVec),
	prennf(-A,NNA).
prennf( forall(X,A), forall(XVec,NA)) :-
	make_vector(X,XVec),
	prennf(A,NA).


prennf(- A, - A).

prennf(B, B).


%% works on pre-nnf, assumes variables as vectors
prenex(forall(X,F) , forall(X,Res)) :-
	prenex(F, Res).

prenex(exists(X,F) , exists(X,Res)) :-
	prenex(F, Res).


prenex((F , G) , R) :-
	prenex(F, FP), 
	prenex(G, GP),
	prenexq((FP, GP), R).

prenex((F & G) , R) :-
	prenex(F, FP), 
	prenex(G, GP),
	prenexq((FP, GP), R).
	
prenex((F ; G) , R) :-
	prenex(F, FP), 
	prenex(G, GP),
	prenexq((FP ; GP),R).
prenex((F v G) , R) :-
	prenex(F, FP), 
	prenex(G, GP),
	prenexq((FP ; GP),R).

prenex(F , F ).


prenexq((forall(X,F), G) , forall(X1,Res)) :-
	new_quantification(forall(X,F),forall(X1,F1)),
	prenexq((F1,G), Res).

prenexq((G , forall(X,F)) , forall(X1,Res)) :-
	new_quantification(forall(X,F),forall(X1,F1)),
	prenexq((G,F1), Res).
prenexq((G & forall(X,F)) , forall(X1,Res)) :-
	new_quantification(forall(X,F),forall(X1,F1)),
	prenexq((G,F1), Res).

prenexq((forall(X,F); G) , forall(X1,Res)) :-
	new_quantification(forall(X,F),forall(X1,F1)),
	prenexq((F1;G), Res).
prenexq((forall(X,F) v G) , forall(X1,Res)) :-
	new_quantification(forall(X,F),forall(X1,F1)),
	prenexq((F1;G), Res).
prenexq((G ; forall(X,F)) , forall(X1,Res)) :-
	new_quantification(forall(X,F),forall(X1,F1)),
	prenexq((G;F1), Res).
prenexq((G v forall(X,F)) , forall(X1,Res)) :-
	new_quantification(forall(X,F),forall(X1,F1)),
	prenexq((G;F1), Res).

prenexq((exists(X,F), G) , exists(X1,Res)) :-
	new_quantification(exists(X,F),exists(X1,F1)),
	prenexq((F1,G), Res).
prenexq((G , exists(X,F)) , exists(X1,Res)) :-
	new_quantification(exists(X,F),exists(X1,F1)),
	prenexq((G,F1), Res).
prenexq((G & exists(X,F)) , exists(X1,Res)) :-
	new_quantification(exists(X,F),exists(X1,F1)),
	prenexq((G,F1), Res).

prenexq((exists(X,F); G) , exists(X1,Res)) :-
	new_quantification(exists(X,F),exists(X1,F1)),
	prenexq((F1;G), Res).
prenexq((exists(X,F) v G) , exists(X1,Res)) :-
	new_quantification(exists(X,F),exists(X1,F1)),
	prenexq((F1;G), Res).
prenexq((G ; exists(X,F)) , exists(X1,Res)) :-
	new_quantification(exists(X,F),exists(X1,F1)),
	prenexq((G;F1), Res).
prenexq((G v exists(X,F)) , exists(X1,Res)) :-
	new_quantification(exists(X,F),exists(X1,F1)),
	prenexq((G;F1), Res).

prenexq((F v G) , (F ; G)).
prenexq((F ; G) , (F ; G)).
prenexq((F , G) , (F , G)).
prenexq((F & G) , (F , G)).


make_vector([],[]) :- !.
make_vector([A|B],[A|B]) :- !.
make_vector(A,[A]).

cnf(- (A <-> B),  R) :-
	cnf(- ((A->B) , (B->A)),R).
cnf(- (A <=> B),  R) :-
	cnf(- ((A->B) , (B->A)),R).

cnf((A <-> B),  R) :- 
	cnf(((A->B) , (B->A)),R).
cnf((A <=> B),  R) :- 
	cnf(((A->B) , (B->A)),R).

cnf(- (A -> B), R) :-
	cnf(- (- A ; B), R).
cnf(- (A => B), R) :-
	cnf(- (- A ; B), R).

cnf(- (B <- A), R) :- 
	cnf(- (B ; - A), R).
cnf(- (B <= A), R) :- 
	cnf(- (B ; - A), R).

cnf((A -> B), R) :-
	cnf((- A ; B), R).
cnf((A => B), R) :-
	cnf((- A ; B), R).

cnf((B <- A), R) :-
	cnf((B ; - A), R).
cnf((B <= A), R) :-
	cnf((B ; - A), R).

cnf(- (A , B), R) :-
	cnf((- A ;  - B), R).
cnf(- (A & B), R) :-
	cnf((- A ;  - B), R).

cnf((A , B), (NA , NB)) :-
	cnf(A, NA),
	cnf(B, NB).
cnf((A & B), (NA , NB)) :-
	cnf(A, NA),
	cnf(B, NB).

cnf(- (A ; B), (NNA , NNB)) :-
	cnf(- A, NNA),
	cnf(- B, NNB).
cnf(- (A v B), (NNA , NNB)) :-
	cnf(- A, NNA),
	cnf(- B, NNB).

cnf((A ; B),  R) :-
	cnf(A , NA),
	cnf(B , NB),
	cnf1((NA ; NB),  R).
cnf((A v B),  R) :-
	cnf(A , NA),
	cnf(B , NB),
	cnf1((NA ; NB),  R).


cnf(- (- A),  NA) :- cnf(A,NA).

cnf(- A,  - A).

cnf(B,  B).

cnf1( ((AF, AR) ; B) ,  R) :-
	cnf(((AF ; B) , (AR ; B)), R).
cnf1( ((AF & AR) ; B) ,  R) :-
	cnf(((AF ; B) , (AR ; B)), R).

cnf1( (A ; (BF, BR)) , R) :-
	cnf(((A ; BF) , (A ; BR)),R).
cnf1( (A ; (BF & BR)) , R) :-
	cnf(((A ; BF) , (A ; BR)),R).
cnf1( (A ; B) ,  (A ; B)).

%% works only for CNF:
norm_con(((A , B) , C), (FN , R)) :-
	norm_con((A, B), (F , G)),
	norm_dis(F, FN),
	norm_con((G, C), R).
norm_con((A , B), (NA , NB)) :-
	norm_dis(A, NA),
	norm_con(B, NB).
%norm_con(A,NA) :-
%	norm_dis(A, NA).
norm_con(A, NA) :- norm_dis(A,NA).

norm_dis(((A ; B) ; C), (F ; R)) :-
	norm_dis((A; B), (F ; G)),
	norm_dis((G; C), R).
norm_dis((A ; B), (A ; NB)) :-
	norm_dis(B, NB).
%norm_dis(A,NA) :-
%	norm_dis(A, NA).
norm_dis(A, A).

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

skolemfunction(Vars,Res) :-
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
 */

free_variables_union((Con1,Con2),X,UVs,GUVs) :-
	unionq(X,UVs,XUVs),
	free_variables(Con1,XUVs,Con1vars),
	intersectq(X,Con1vars,[]),
	free_variables_union(Con2,X,UVs,GUVs).
free_variables_union((Con1,Con2),X,UVs,GUVs) :-
	% Here we know that X occurs in Con1
	free_variables(Con1,UVs,Con1vars),
	free_variables_union(Con2,X,UVs,Con2vars),
	unionq(Con1vars,Con2vars,GUVs).
free_variables_union(Con,X,UVs,[]) :-
	unionq(X,UVs,XUVs),
	free_variables(Con,XUVs,Convars),
	intersectq(X,Convars,[]).
free_variables_union(Con,_X,UVs,GUVs) :-
	% Here we know that X occurs in Con
	free_variables(Con,UVs,GUVs).


%% skolemize works for prenex normal form, currently used for matrix in cnf

skolemize(exists(X,F),Matrix,UVs,Res) :-
	free_variables_union(Matrix,X,UVs,GUVs),
	skolemfunction_vector(GUVs,X,XSkFPairs),
% old
%	skolemfunction_vector(UVs,X,XSkFPairs),
	subst_vector(XSkFPairs, F, Fsk),
	subst_vector(XSkFPairs, Matrix, Matrixsk),
	skolemize(Fsk,Matrixsk,UVs,Res).
skolemize(forall(X,F),Matrix,UVs,Res) :-
	%% make sure that inner existential quantification will not introduce variables
	%% by a universal quantification within that existential quantifier
%	new_quantification(forall(X,F),forall(X1,F1)),
	newvar_vector(X,X1,X_X1_Pairs),
	subst_vector(X_X1_Pairs,F,F1),
	subst_vector(X_X1_Pairs,Matrix,Matrix1),
	append(X1,UVs,F1UVs),
	skolemize(F1,Matrix1,F1UVs,Res).
%p%

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
skolemize(F,_Matrix,_UVs,F).

%%% 2nd result is suitable for subst_vector:
newvar_vector([],[],[]).
newvar_vector([X|R],[XN|RN],[X/XN|RNPairs]) :-
	newvar(X,XN), 
	newvar_vector(R,RN,RNPairs).

%%% generate vector of skolemfunctions for binding universal variables UVars
%%% result is suitable for subst_vector:
skolemfunction_vector(_UVars,[],[]).
skolemfunction_vector(UVars,[EVar|RestEVars],[EVar/SkF|RRestEVars]) :-
	skolemfunction(UVars,SkF),
	skolemfunction_vector(UVars,RestEVars,RRestEVars).


new_quantification(forall(X,F),forall(X1,F1)) :-
	newvar_vector(X,X1,X_X1_Pairs),
	subst_vector(X_X1_Pairs,F,F1).
new_quantification(exists(X,F),exists(X1,F1)) :-
	newvar_vector(X,X1,X_X1_Pairs),
	subst_vector(X_X1_Pairs,F,F1).

subst_vector([],Formula,Formula).
subst_vector([X/T|R],Formula,Result) :-
	subst(X/T,Formula,H),
	subst_vector(R,H,Result).

subst(X/T,(A <-> B),(SA <-> SB)) :- subst(X/T,A,SA), subst(X/T,B,SB).
subst(X/T,(A  -> B),(SA  -> SB)) :- subst(X/T,A,SA), subst(X/T,B,SB).
subst(X/T,(A <-  B),(SA  <- SB)) :- subst(X/T,A,SA), subst(X/T,B,SB).
subst(X/T,(A,B),(SA,SB)) :- subst(X/T,A,SA), subst(X/T,B,SB).
subst(X/T,(A;B),(SA;SB)) :- subst(X/T,A,SA), subst(X/T,B,SB).
subst(X/T,- F,- F1) :- subst(X/T,F,F1).
subst(X/_T,forall(X,F),forall(X,F)).
subst(X/T,forall(Y,F),forall(Y,F1)) :-
	X \== Y, subst(X/T,F,F1).
subst(X/_T,exists(X,F),exists(X,F)).
subst(X/T,exists(Y,F),exists(Y,F1)) :-
	X \== Y, subst(X/T,F,F1).
%% down at literal case:
subst(X/T,L,LS) :-
	L =.. [P|Args],
	subst_list(X/T,Args,SArgs),
	LS =.. [P|SArgs].

subst_list(_X/_T,[],[]).
subst_list(X/T,[S|R],[ST|RR]) :-
	subst_term(X/T,S,ST),
	subst_list(X/T,R,RR).

subst_term(X/T,Y,T) :-
	var(Y), X == Y.
subst_term(X/_T,Y,Y) :-
	var(Y), X \== Y.
subst_term(X/T,Y,T) :-
	atomic(Y), Y == X.
subst_term(X/T,S,ST) :-
	S =.. [F|Args],
	subst_list(X/T,Args,SArgs),
	ST =.. [F|SArgs].



%%% slooooooooooooow:
bound_variables((A <-> B), R) :-
	bound_variables(A,BA),
	bound_variables(B,BB),
	unionq(BA,BB,R).
bound_variables((A -> B), R) :-
	bound_variables(A,BA),
	bound_variables(B,BB),
	unionq(BA,BB,R).
bound_variables((A <- B), R) :-
	bound_variables(A,BA),
	bound_variables(B,BB),
	unionq(BA,BB,R).
bound_variables(-A, R) :-
	bound_variables(A,R).
bound_variables((A , B), R) :-
	bound_variables(A,BA),
	bound_variables(B,BB),
	unionq(BA,BB,R).
bound_variables((A ; B), R) :-
	bound_variables(A,BA),
	bound_variables(B,BB),
	unionq(BA,BB,R).
bound_variables(forall(X,F),R) :-
	bound_variables(F,RF),
	make_vector(X,XVec),
	unionq(RF,XVec,R).
bound_variables(exists(X,F),R) :-
	bound_variables(F,RF),
	make_vector(X,XVec),
	unionq(RF,XVec,R).

%% down at literal level
bound_variables(_B,  []).

%p%
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

%p%

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


