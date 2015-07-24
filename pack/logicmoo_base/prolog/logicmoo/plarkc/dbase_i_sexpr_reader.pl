:-module(logicmoo_i_sexp_reader,[codelist_to_forms/2,input_to_forms/3,lisp_read_from_input/2,parse_sexpr/2]).



:-dynamic(user:mpred_prop/2).
:-multifile(user:mpred_prop/2).

:- dynamic   user:file_search_path/2.
:- multifile user:file_search_path/2.
:- prolog_load_context(directory,Dir),
   DirFor = plarkc,
   (( \+ user:file_search_path(DirFor,Dir)) ->asserta(user:file_search_path(DirFor,Dir));true),
   absolute_file_name('../../../../',Y,[relative_to(Dir),file_type(directory)]),
   (( \+ user:file_search_path(pack,Y)) ->asserta(user:file_search_path(pack,Y));true).
:- attach_packs.
:- initialization(attach_packs).
% [Required] Load the Logicmoo Library Utils
:- user:ensure_loaded(library(logicmoo/util/logicmoo_util_all)).

:- user:ensure_loaded(library(logicmoo/plarkc/logicmoo_i_cyc_api)).



/*===================================================================
% input_to_forms/3 does less consistancy checking then conv_to_sterm

Always a S-Expression: 'WFFOut' placing variables in 'VARSOut'

|?-input_to_forms("(isa a b)",Clause,Vars).
Clause = [isa,a,b]
Vars = _h70

| ?- input_to_forms("(isa a (b))",Clause,Vars).
Clause = [isa,a,[b]]
Vars = _h70

|?-input_to_forms("(list a b )",Clause,Vars)
Clause = [list,a,b]
Vars = _h70

| ?- input_to_forms("(genlMt A ?B)",Clause,Vars).
Clause = [genlMt,'A',_h998]
Vars = [=('B',_h998)|_h1101]

| ?- input_to_forms("(goals Iran  (not   (exists   (?CITIZEN)   (and    (citizens Iran ?CITIZEN)    (relationExistsInstance maleficiary ViolentAction ?CITIZEN)))))",Clause,Vars).

Clause = [goals,Iran,[not,[exists,[_h2866],[and,[citizens,Iran,_h2866],[relationExistsInstance,maleficiary,ViolentAction,_h2866]]]]]
Vars = [=(CITIZEN,_h2866)|_h3347]

| ?- input_to_forms("
(queryTemplate-Reln QuestionTemplate definitionalDisplaySentence 
       (NLPatternList 
           (NLPattern-Exact \"can you\") 
           (RequireOne 
               (NLPattern-Word Acquaint-TheWord Verb) 
               (NLPattern-Word Tell-TheWord Verb)) 
           (RequireOne 
               (NLPattern-Exact \"me with\") 
               (NLPattern-Exact \"me what\")) 
           (OptionalOne 
               (WordSequence \"the term\") \"a\" \"an\") 
           (NLPattern-Template NPTemplate :THING) 
           (OptionalOne \"is\") 
           (OptionalOne TemplateQuestionMarkMarker)) 
       (definitionalDisplaySentence :THING ?SENTENCE)) ",
 Clause,Vars).

| ?- input_to_forms("
 (#$STemplate #$bioForProposal-short 
  (#$NLPatternList (#$NLPattern-Template #$NPTemplate :ARG1) 
   (#$NLPattern-Exact \"short bio for use in proposals\") (#$NLPattern-Word #$Be-TheWord #$Verb) 
      (#$NLPattern-Exact \"\\\"\") (#$NLPattern-Template #$NPTemplate :ARG2)) (#$bioForProposal-short :ARG1 :ARG2)) ",
      Clause,Vars).


input_to_forms("
 (#$STemplate #$bioForProposal-short 
  (#$NLPatternList (#$NLPattern-Template #$NPTemplate :ARG1) 
   (#$NLPattern-Exact \"short bio for use in proposals\") (#$NLPattern-Word #$Be-TheWord #$Verb) 
      (#$NLPattern-Exact \"\") (#$NLPattern-Template #$NPTemplate :ARG2)) (#$bioForProposal-short :ARG1 :ARG2)) ",
      Clause,Vars).

// ==================================================================== */
:-export(input_to_forms/2).
input_to_forms(FormsOut,Vars):- 
    current_input(In),
    input_to_forms(In, FormsOut,Vars).

:-export(input_to_forms/3).
input_to_forms(In,FormsOut,Vars):-
 must_det_l((
    parse_sexpr(In, Forms0),
    to_untyped(Forms0, Forms1),
    extract_lvars(Forms1,FormsOut,Vars))).


:-export(any_to_lazy_list/2).
any_to_lazy_list(Stream0,Chars):-l_open_input(Stream0,Stream),stream_to_lazy_list(Stream,CharsM),!,Chars=CharsM.



/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    Lisprolog -- Interpreter for a simple Lisp. Written in Prolog.
    Written Nov. 26th, 2006 by Markus Triska (triska@gmx.at).
    Public domain code.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

:- style_check(-singleton).
:- style_check(-discontiguous).
% :- style_check(-atom).
:- set_prolog_flag(double_quotes, codes). 
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   Parsing
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
parse_sexpr(String, Expr) :- is_stream(S),stream_to_lazy_list(S,LList),!,LList=[E|List],parse_sexpr_codes([E|List], Expr).
parse_sexpr(Any, Expr) :- Any\=[_|_],any_to_lazy_list(Any,[E|List]),!,parse_sexpr_codes([E|List], Expr).
parse_sexpr([SC|Codes], Expr) :- integer(SC),!,parse_sexpr_codes([SC|Codes], Expr).
parse_sexpr([SC|Codes], Expr) :- atom(SC),!,string_chars(String,[SC|Codes]),!,parse_sexpr(String, Expr).
parse_sexpr(String, Expr) :- string(String),!,string_codes(String,Codes),parse_sexpr_codes(Codes, Expr).

parse_sexpr_codes(Codes, Expr) :- phrase(sexpr(Expr), Codes).

:-export(sexpr//1).

% Use DCG for parser.


sexpr(L)                      --> sblank,sexpr(L).
sexpr(L)                      --> "(", !, swhite, sexpr_list(L), swhite.
sexpr('$VECT'(V))                 --> "#(", !, sexpr_vector(V), swhite.
sexpr('$SYM'(t))                 --> "#t", !, swhite.
sexpr('$SYM'(f))                 --> "#f", !, swhite.
sexpr('$SYM'(E))              --> "#$", !, swhite, sexpr(E).
sexpr('$CHAR'(C))                 --> "#\\", rsymbol(C), !, swhite.
sexpr('$STR'(S))                 --> """", !, sexpr_string(S), swhite.
sexpr(['$SYM'(quote),E])              --> "'", !, swhite, sexpr(E).
sexpr(['$SYM'(backquote),E])         --> "`", !, swhite, sexpr(E).
sexpr(['$BQ-COMMA-ELIPSE',E]) --> ",@", !, swhite, sexpr(E).
sexpr('$COMMA'(E))            --> ",", !, swhite, sexpr(E).
sexpr('$SYM'(E))                      --> sym_or_num(E),!, swhite.

sblank --> [C], {C =< 32}, swhite.
sblank --> ";", line_comment, swhite.

swhite --> sblank.
swhite --> [].

line_comment --> [C], {eoln(C)}, !.
line_comment --> [C], line_comment.

sexprs([H|T]) --> sexpr(H), !, sexprs(T).
sexprs([]) --> [].


:-export(sexpr_list//1).

sexpr_list([]) --> ")", !.
sexpr_list(_) --> ".", [C], {\+ sym_char(C)}, !, fail.
sexpr_list([Car|Cdr]) --> sexpr(Car), !, sexpr_rest(Cdr).

sexpr_rest([]) --> ")", !.
sexpr_rest(E) --> ".", [C], {\+ sym_char(C)}, !, sexpr(E,C), !, ")".
sexpr_rest([Car|Cdr]) --> sexpr(Car), !, sexpr_rest(Cdr).

sexpr_vector([]) --> ")", !.
sexpr_vector([First|Rest]) --> sexpr(First), !, sexpr_vector(Rest).

sexpr_string([C|S]) --> "\\", lchar(C),!, sexpr_string(S).
sexpr_string([]) --> """", !.
sexpr_string([C|S]) --> lchar(C), sexpr_string(S).

lchar(92) --> "\\", !.
lchar(34) --> "\"", !.
lchar(N)  --> [C], {C >= 32, N is C}.

rsymbol(E) --> [C], {sym_char(C)}, sym_string(S), {string_to_atom([C|S],E)}.

sym_or_num('$SYM'(E)) --> rsymbol(E).
sym_or_num('$NUMBER'(E)) --> snumber(E).

sym_string([H|T]) --> [H], {sym_char(H)}, sym_string(T).
sym_string([]) --> [].

snumber(N) --> unsigned_number(N).
snumber(N) --> "-", unsigned_number(M), {N is -M}.
snumber(N) --> "+", unsigned_number(N).

unsigned_number(N) --> cdigit(X), unsigned_number(X,N).
unsigned_number(N,M) --> cdigit(X), {Y is N*10+X}, unsigned_number(Y,M).
unsigned_number(N,N) --> [].

cdigit(N) --> [C], {C >= 48, C =<57, N is C-48}.

% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

sexpr(E,C,X,Z) :- swhite([C|X],Y), sexpr(E,Y,Z).

% dquote semicolon parens  hash qquote  comma backquote
sym_char(C) :- C > 32, not(member(C,[34,59,40,41,35,39,44,96])).  



:-thread_local(thlocal:s2p/1).


to_unbackquote(I,O):-to_untyped(I,O).

:-export(to_untyped/2).
to_untyped(Var,'$VAR'(Name)):-lvar(Var,Name),!.
to_untyped(S,S):- string(S).
to_untyped(S,S):- number(S).
to_untyped(S,O):- atom(S),catch(atom_number(S,O),_,fail),!.
to_untyped(Atom,Atom):- \+ compound(Atom),!.
to_untyped('$BQ'(VarName),'$BQ'(VarName)):-!.
to_untyped('$SYM'(S),O):-nonvar(S),!,to_untyped(S,O),!.
to_untyped('$CHAR'(S),'$CHAR'(S)):-!.
to_untyped('$COMMA'(S),'$COMMA'(O)):-to_untyped(S,O),!.
to_untyped('$VECT'(S),'$VECT'(O)):-to_untyped(S,O),!.
to_untyped('$NUMBER'(S),O):-to_untyped(S,O),!.
to_untyped([[]],[]):-!.
to_untyped('$STR'(Expr),Forms):- (text_to_string_safe(Expr,Forms);to_untyped(Expr,Forms)),!.
to_untyped(['$SYM'(backquote),Rest],Out):- !,to_untyped(['$SYM'('$BQ'),Rest],Out).
to_untyped(['$SYM'(S)|Rest],Out):-is_list(Rest),maplist(to_untyped,[S|Rest],[F|Mid]), 
          ((atom(F),thlocal:s2p(F))-> Out=..[F|Mid];Out=[F|Mid]),
          to_untyped(Out,OOut).
to_untyped([H|T],Forms):-is_list([H|T]),must(text_to_string_safe([H|T],Forms);maplist(to_untyped,[H|T],Forms)).
to_untyped([H|T],[HH|TT]):-!,must_det_l((to_untyped(H,HH),to_untyped(T,TT))).
to_untyped(ExprI,ExprO):- ExprI=..Expr,
  maplist(to_untyped,Expr,[HH|TT]),(atom(HH)-> ExprO=..[HH|TT] ; ExprO=[HH|TT]).
% to_untyped(Expr,Forms):-compile_all(Expr,Forms),!.


:-export(extract_lvars/3).
extract_lvars(A,B,After):-
     b_getval('$variable_names',Before),
     copy_lvars(A,Before,B,After).

% copy_lvars( VAR,Vars,VAR,Vars):- var(VAR),!.
copy_lvars( VAR,Vars,NV,NVars):- lvar(VAR,Name),must(atom(Name)),!,must(register_var(Name=NV,Vars,NVars)).
copy_lvars([],Vars,[],Vars).
copy_lvars(Term,Vars,Term,Vars):- \+compound(Term),!.
copy_lvars('?'(Inner),Vars,Out,NVars):- !,
    copy_lvars((Inner),Vars,(NInner),NVars),
    (atom(NInner) -> atom_concat('?',NInner,Out) ; Out = '?'(NInner)),!.

copy_lvars([H|T],Vars,[NH|NT],NVars):- !, copy_lvars(H,Vars,NH,SVars), copy_lvars(T,SVars,NT,NVars).
copy_lvars(Term,Vars,NTerm,NVars):-    
    Term=..[F|Args],    % decompose term
    (lvar(F,_)-> copy_lvars( [F|Args],Vars,NTerm,NVars);
    % construct copy term
    (copy_lvars(Args,Vars,NArgs,NVars), NTerm=..[F|NArgs])).  

lvar(Var,NameU):-var(Var),!,format(atom(Name),'~w',[(Var)]),!,atom_concat('_',NameU,Name).
lvar('$VAR'(Var),Name):-number(Var),format(atom(Name),'~w',['$VAR'(Var)]),!.
lvar('$VAR'(VarName),VarNameU):-lvar_fixvarname(VarName,VarNameU),!.
lvar('$VAR'(Name),Name):-!.
lvar('?'(Name),NameU):-lvar_fixvarname(Name,NameU),!.
lvar(VAR,NameU):-atom(VAR),atom_concat('??',Name,VAR),!,lvar_fixvarname(Name,NameI),atom_concat('_',NameI,NameU).
lvar(VAR,NameU):-atom(VAR),atom_concat('?',Name,VAR),lvar_fixvarname(Name,NameU).

:-export(ok_varname/1).
ok_varname(Name):- number(Name).
ok_varname(Name):- atom(Name),atom_codes(Name,[C|_List]),char_type(C,csym).

%:-export(ok_codes_in_varname/1).
%ok_codes_in_varname([]).
%ok_codes_in_varname([C|List]):-!,ok_in_varname(C),ok_codes_in_varname(List).

%:-export(ok_in_varname/1).
%ok_in_varname(C):-sym_char(C),\+member(C,`!@#$%^&*?()`).

:-export(lvar_fixvarname/2).
lvar_fixvarname(SVAR,UP):- atom(SVAR)->(ok_varname(SVAR),upcase_atom(SVAR,UP));UP=SVAR.

atom_upper(A,U):-string_upper(A,S),atom_string(U,S).

lisp_read_from_input(Forms):-lisp_read_from_input(current_input,Forms),!.
lisp_read_from_input(I,Forms):-stream_source_typed(I,Type),!,must(to_untyped(Type,Forms)).

stream_source_typed(I,Expr):-   l_open_input(I,In),
  see(In),
   read_line_to_codes(current_input,AsciiCodes),(parse_sexpr(AsciiCodes,Expr);read_term_from_codes(AsciiCodes,Expr,[])),!,seen.


lowcase([],[]).
lowcase([C1|T1],[C2|T2]) :- lowercase(C1,C2), lowcase(T1,T2).

lowercase(C1,C2) :- C1 >= 65, C1 =< 90, !, C2 is C1+32.
lowercase(C,C).


/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   Interpretation
   --------------

   Declaratively, execution of a Lisp form is a relation between the
   (function and variable) binding environment before its execution
   and the environment after its execution. A Lisp program is a
   sequence of Lisp forms, and its result is the sequence of their
   results. The environment is represented as a pair of association
   lists Fs-Vs, associating function names with argument names and
   bodies, and variables with values. DCGs are used to implicitly
   thread the environment state through.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */


codelist_to_forms(AsciiCodesList,FormsOut):-
    parse_sexpr(AsciiCodesList, Forms0),    
    compile_all(Forms0, FormsOut),!.

run(Program, Values) :-
    parse_sexpr(Program, Forms0),    
    empty_assoc(E),
    compile_all(Forms0, Forms),
    writeq(seeingFormas(Forms)),nl,
    phrase(eval_all(Forms, Values0), [E-E], _),
    maplist(unfunc, Values0, Values).

unfunc('$SYM'(S), S).
unfunc(t, t).
unfunc('$NUMBER'(N), N).
unfunc([], []).
unfunc([Q0|Qs0], [Q|Qs]) :- unfunc(Q0, Q), unfunc(Qs0, Qs).

fold([], _, V, '$NUMBER'(V)).
fold(['$NUMBER'(F)|Fs], Op, V0, V) :- E =.. [Op,V0,F], V1 is E, fold(Fs, Op, V1, V).

compile_all(Fs0, Fs) :- maplist(compile, Fs0, Fs).

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    compile/2 marks (with 'user/1') calls of user-defined functions.
    This eliminates an otherwise defaulty representation of function
    calls and thus allows for first argument indexing in eval//3.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

compile(F0, F) :-
    (   F0 = '$NUMBER'(_)   -> F = F0
    ;   F0 = '$SYM'(t)   -> F = t
    ;   F0 = '$SYM'(nil) -> F = []
    ;   F0 = '$SYM'(_)   -> F = F0
    ;   F0 = [] -> F = []
    ;   F0 = ['$SYM'(quote),Arg] -> F = [quote,Arg]
    ;   F0 = ['$SYM'(setq),'$SYM'(Var),Val0] -> compile(Val0, Val), F = [setq,Var,Val]
    ;   F0 = ['$SYM'(Op)|Args0],
        memberchk(Op, [+,-,*,equal,if,>,<,=,progn,eval,list,car,cons,
                       cdr,while,not]) ->
        compile_all(Args0, Args),
        F = [Op|Args]
    ;   F0 = ['$SYM'(defun),'$SYM'(Name),Args0|Body0] ->
        compile_all(Body0, Body),
        maplist(arg(1), Args0, Args),
        F = [defun,Name,Args|Body]
    ;   F0 = ['$SYM'(Op)|Args0] -> compile_all(Args0, Args), F = [user(Op)|Args]
    ).

eval_all([], [])         --> [].
eval_all([A|As], [B|Bs]) --> eval(A, B), eval_all(As, Bs).

eval('$NUMBER'(N), '$NUMBER'(N))       --> [].
eval(t, t)             --> [].
eval([], [])           --> [].
eval('$SYM'(A), V), [Fs-Vs] --> [Fs-Vs], { get_assoc(A, Vs, V) }.
eval([L|Ls], Value)    --> eval(L, Ls, Value).

eval(quote, [Q], Q) --> [].
eval(+, As0, V)     --> eval_all(As0, As), { fold(As, +, 0, V) }.
eval(-, As0, V)     --> eval_all(As0, ['$NUMBER'(V0)|Vs0]), { fold(Vs0, -, V0, V) }.
eval(*, As0, V)     --> eval_all(As0, Vs), { fold(Vs, *, 1, V) }.
eval(car, [A], C)   --> eval(A, V), { V == [] -> C = [] ; V = [C|_] }.
eval(cdr, [A], C)   --> eval(A, V), { V == [] -> C = [] ; V = [_|C] }.
eval(list, Ls0, Ls) --> eval_all(Ls0, Ls).
eval(not, [A], V)   --> eval(A, V0), goal_truth(V0=[], V).
eval(>, [A,B], V)   --> eval(A, '$NUMBER'(V1)), eval(B, '$NUMBER'(V2)), goal_truth(V1>V2, V).
eval(<, [A,B], V)   --> eval(>, [B,A], V).
eval(=, [A,B], V)   --> eval(A, '$NUMBER'(V1)), eval(B, '$NUMBER'(V2)), goal_truth(V1=:=V2, V).
eval(progn, Ps, V)  --> eval_all(Ps, Vs), { last(Vs, V) }.
eval(eval, [A], V)  --> eval(A, F0), { compile(F0, F1) }, eval(F1, V).
eval(equal, [A,B], V) --> eval(A, V1), eval(B, V2), goal_truth(V1=V2, V).
eval(cons, [A,B], [V0|V1])  --> eval(A, V0), eval(B, V1).
eval(while, [Cond|Bs], [])  -->
    (   eval(Cond, []) -> []
    ;   eval_all(Bs, _),
        eval(while, [Cond|Bs], _)
    ).
eval(defun, [F,As|Body], '$SYM'(F)), [Fs-Vs0] -->
    [Fs0-Vs0],
    { put_assoc(F, Fs0, As-Body, Fs) }.
eval(user(F), As0, V), [Fs-Vs] -->
    eval_all(As0, As1),
    [Fs-Vs],
    { empty_assoc(E),
      get_assoc(F, Fs, As-Body),
      bind_arguments(As, As1, E, Bindings),
      phrase(eval_all(Body, Results), [Fs-Bindings], _),
      last(Results, V) }.
eval(setq, [Var,V0], V), [Fs0-Vs] -->
    eval(V0, V),
    [Fs0-Vs0],
    { put_assoc(Var, Vs0, V, Vs) }.
eval(if, [Cond,Then|Else], Value) -->
    (   eval(Cond, []) -> eval_all(Else, Values), { last(Values, Value) }
    ;   eval(Then, Value)
    ).

:- meta_predicate user:goal_truth(0,*,*,*).
goal_truth(Goal, T) --> { Goal -> T = t ; T = [] }.

bind_arguments([], [], Bs, Bs).
bind_arguments([A|As], [V|Vs], Bs0, Bs) :-
    put_assoc(A, Bs0, V, Bs1),
    bind_arguments(As, Vs, Bs1, Bs).

run(S):-'format'('~n~s~n',[S]),run(S,V),writeq(V).

if_script_file_time(X):-if_startup_script(time(X)).

% Append:
    :- if_script_file_time(run("
        (defun append (x y)
          (if x
              (cons (car x) (append (cdr x) y))
            y))

        (append '(a b) '(3 4 5))"
)).

    %@ V = [append, [a, b, 3, 4, 5]].
    

% Fibonacci, naive version:
    :- if_script_file_time(run("
        (defun fib (n)
          (if (= 0 n)
              0
            (if (= 1 n)
                1
              (+ (fib (- n 1)) (fib (- n 2))))))
        (fib 24)"
)).

    %@ % 14,255,802 inferences, 3.71 CPU in 3.87 seconds (96% CPU, 3842534 Lips)
    %@ V = [fib, 46368].
    

% Fibonacci, accumulating version:
    :- if_script_file_time(run("
        (defun fib (n)
          (if (= 0 n) 0 (fib1 0 1 1 n)))

        (defun fib1 (f1 f2 i to)
          (if (= i to)
              f2
            (fib1 f2 (+ f1 f2) (+ i 1) to)))

        (fib 250)"
)).

    %@ % 39,882 inferences, 0.010 CPU in 0.013 seconds (80% CPU, 3988200 Lips)
    %@ V = [fib, fib1, 7896325826131730509282738943634332893686268675876375].
    

% Fibonacci, iterative version:
    :- if_script_file_time(run("
        (defun fib (n)
          (setq f (cons 0 1))
          (setq i 0)
          (while (< i n)
            (setq f (cons (cdr f) (+ (car f) (cdr f))))
            (setq i (+ i 1)))
          (car f))

        (fib 350)"
)).

    %@ % 34,233 inferences, 0.010 CPU in 0.010 seconds (98% CPU, 3423300 Lips)
    %@ V = [fib, 6254449428820551641549772190170184190608177514674331726439961915653414425].
    

% Higher-order programming and eval:
    :- if_startup_script(run("
        (defun map (f xs)
          (if xs
              (cons (eval (list f (car xs))) (map f (cdr xs)))
            ()))

        (defun plus1 (x) (+ 1 x))

        (map 'plus1 '(1 2 3))
        "
        )).

    %@ V = [map, plus1, [2, 3, 4]].


