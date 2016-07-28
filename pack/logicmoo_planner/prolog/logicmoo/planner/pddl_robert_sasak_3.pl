
:- module(pddl_robert_sasak,[test_blocks/0,test_domain/1,test_all/0,test_rest/0,test_sas/0,
   test_dir_files_sas/1,test_dir_files_sas/3,
   solve_files/2]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILENAME:  common.pl 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This file contain common predicates that are used in planners

:- dynamic(domain/3).
:- dynamic(pairfrom/4).


% end_of_file.

:- expects_dialect(sicstus).
:- use_module(library(timeout)).
:- use_module(library(lists)).



% command_line_sas/0
%
%   run planner
%   takes two params from command line arguments
%   first is a domain file 
%   second problem file
%

:-set_prolog_stack(global, limit(16*10**9)).
:-set_prolog_stack(local, limit(16*10**9)).
:-set_prolog_stack(trail, limit(16*10**9)).

command_line_sas:-
    prolog_flag(argv, [D,P]),!,
    solve_files(D, P),
    halt.

command_line_sas:- test_blocks, test_all.

slow_on('blocks-07-0.pddl').
slow_on('blocks-08-0.pddl').
slow_on('blocks-09-0.pddl').

filematch_sas(A,B):-must(hotrace(filematch(A,B))).
 
test_all:- 
  filematch_sas('./orig_pddl_parser/test/*/domain*.pddl',_),!,
  must(forall(filematch_sas('./orig_pddl_parser/test/*/domain*.pddl',E),once(test_domain(E)))).

test_all:- expand_file_name('./orig_pddl_parser/test/*/domain*.pddl',RList),RList\=[],!,reverse(RList,List),
  forall(member(E,List),once(test_domain(E))).

test_primaryobjects:- 
  must(forall(filematch_sas('./primaryobjects_strips/*/domain*.*',E),once(test_domain(E)))). 

min_sas(A,B,A):-A =< B,!.
min_sas(_,A,A).

test_domain(DP):-test_domain(DP,12).
test_domain(DP,Num):-
   format('~q.~n',[test_domain(DP)]),
  directory_file_path(D,_,DP),directory_files(D,RList),reverse(RList,ListR),
   sort(ListR,ListS),length(ListR,PosNum),min_sas(PosNum,Num,MinNum),length(List,MinNum),append(List,_,ListS),!,
   forall(member(T,List),ignore((directory_file_path(D,T,TP),exists_file(TP),not(same_file(DP,TP)),
  solve_files(DP,TP)))).

test_frolog:- test_dir_files_sas('frolog','p02-domain.pddl','p02.pddl'),
    test_dir_files_sas('frolog','tPddlAgent01-domain.pddl','tPddlAgent01.pddl'),
    !. % test_dir_files_sas('frolog','tPddlAgent02-domain.pddl','tPddlAgent02.pddl').

test_blocks:- solve_files('./orig_pddl_parser/test/blocks/domain-blocks.pddl', 
  './orig_pddl_parser/test/blocks/blocks-03-0.pddl'), fail.
test_blocks:- fail, expand_file_name('./orig_pddl_parser/test/blocks/domain*.pddl',RList),reverse(RList,List),
  forall(member(E,List),once(test_domain(E))).
test_blocks.

user:sanity_test:- test_blocks.

% solve_files(+DomainFile, +ProblemFile)
%
%   Reads files and set timelimit for planner
%
solve_files(DomainFile, ProblemFile):- 
 forall(must(filematch_sas(DomainFile,DomainFile0)),
   forall(must(filematch_sas(ProblemFile,ProblemFile0)),
     time(must(solve_files_0(DomainFile0, ProblemFile0))))),!.

solve_files_0(DomainFile, ProblemFile):-
  format('~q.~n',[solve_files(DomainFile, ProblemFile)]),
   must(( parseDomain(DomainFile, DD, _),
    parseProblem(ProblemFile, PP, _),
    term_to_ord_term(DD, D),
    term_to_ord_term(PP, P),
    reset_statistic)),
    !,
    gripe_time(45,time_out(solve(D, P, S), 50000, _Result)), % time limit for a planner (was 500000)
    show_statistic(P, S),
    !.


% solve(+Domain, +Problem, -Solution).
%
%   Set domain and problem on blackboard
%
solve(D, P, Solution):-
    get_init(P, I),    bb_put(initState, I),
    get_goal(P, G),    bb_put(goalState, G),
    get_metric(P, M),    bb_put(metric, M),
    get_actions(D, A),	bb_put(actions, A),
    get_objects(P, O),	bb_put(objects, O),
    make_init_state(IS),
    search(IS, G, Solution).


% term_to_ord_term(+Term, -OrdTerm)
%
%   Go throught the term and look for sets, return the same term
%   with all sets become ordered.
%
term_to_ord_term([], []).
term_to_ord_term(A, A):-
    atomic(A),
    !.
term_to_ord_term([H|T], R):-
    term_to_ord_term(H, OH),
    term_to_ord_term(T, OT),
    ord_add_element(OT, OH, R),
    !.
%    write(OH), write(OT), write('   '), write(R), nl.
term_to_ord_term(T, OT):-
    T =.. [F,P],
    !,
    term_to_ord_term(P, OP),
    OT =..[F,OP].
term_to_ord_term(T, OT):-
    T =.. [F,P|Ps],
    NT=.. [F|Ps],
    term_to_ord_term(P, OP),
    term_to_ord_term(NT, ONT),
    ONT =.. [_|OPs],
    OT =.. [F,OP|OPs],
    !.


% mysubset(+Subset, +Set)
%
%   It is similar to subset/2. Subset can include free variables that are 
%   grounded with atoms of Set.
%
mysubset([], _).
mysubset([X|R], S):- 
    member(X, S),
    mysubset(R, S).



% Collection of shortcuts


% get(+Structure, -Parameter)
%
get_actions(     	domain(_, _, _, _, _, _, _, A), A).    
get_problem_name(	problem(N, _, _, _, _, _, _, _, _), N).
get_init(    problem(_, _, _, _, I, _, _, _, _), I).
get_goal(    problem(_, _, _, _, _, G, _, _, _), G).
get_metric(    problem(_, _, _, _, _, _, _, M, _), M).
get_objects(    problem(_, _, _, O, _, _, _, _, _), O).
get_precondition(	action(_, _, P, _, _, _), P).
get_positiv_effect(	action(_, _, _, PE, _, _), PE).
get_negativ_effect(	action(_, _, _, _, NE, _), NE).
get_assign_effect(	action(_, _, _, _, _, AE), AE).
get_parameters(    action(_, P, _, _, _, _), P).
get_action_def(    action(Name, Params, _, _, _, _), F):-
    untype(Params, UP),
    F =.. [Name|UP].


% get_action(-Action, -ActionDef)
%
get_action(A):-
    get_action(A, _). 
get_action(A, ActionDef):-
    bb_get(actions, As),
    member(Afree, As),
    copy_term_spec(Afree, A),
%    A =.. [_, Name, Params|_],
    get_action_def(A, ActionDef).


get_goal(G):-bb_get(goalState, G).
get_init(I):-bb_get(initState, I).


% untype(LitOfParams, UntyperList).
%
untype([], []).
untype([H|T], [U|Us]):- 
    compound(H),
    H =.. [_T, [U]],
    !,
    untype(T, Us).
untype([H|T], [H|Us]):-
    untype(T, Us).


% setInit(+Init, -State)
%
setInit([], []).
setInit([set(F, V)|Ls], S):-
    F =.. A,
    concat_atom_iio(A, '-', CA),
    bb_put(CA, V),
%    write(CA),write(' '), write(V),  nl,
    setInit(Ls, S),
    !.
setInit([A|Ls], [A|Ss]):-
    setInit(Ls, Ss).


% concat_atom_iio(+List, +Delimiter, -ConcatenateAtom)
%

concat_atom_iio([E1, E2], D, O):-
    atom_concat(E1, D, Temp),
    atom_concat(Temp, E2, O).
concat_atom_iio([H|T], D, O):-
    concat_atom_iio(T, D, Ts),
    atom_concat(H, D, Temp),
    atom_concat(Temp, Ts, O).


% copy_term_spec(+Term, -Term)
%
%   Special version of copy_term. variable x represented as ?(x)
%   All occurs of ?(x) are replaced with real prolog variables.
%   Modified version of code published by Bartak: http://kti.mff.cuni.cz/~bartak/prolog/data_struct.html
%
copy_term_spec(A,B):-
    cp(A,[],B,_).

cp(A,Vars,A,Vars):-
    atomic(A), A\= ?(_).
cp(?(V),Vars,NV,NVars):-
    atomic(V),
    register_var(V,Vars,NV,NVars).
cp(V,Vars,NV,NVars):-
    var(V),
    register_var(V,Vars,NV,NVars).
cp(Term,Vars,NTerm,NVars):-
    compound(Term),
    Term \= ?(_),
    Term=..[F|Args],    % decompose term
    cp_args(Args,Vars,NArgs,NVars),
    NTerm=..[F|NArgs].  % construct copy term

cp_args([H|T],Vars,[NH|NT],NVars):-
    cp(H,Vars,NH,SVars),
cp_args(T,SVars,NT,NVars).
cp_args([],Vars,[],Vars).


% register_var(?, ?, ?)
%
%   During copying one has to remeber copies of variables which can be used further during copying.
%   Therefore the register of variable copies is maintained.
%
register_var(V,[X/H|T],N,[X/H|NT]):-
    V\==X,         % different variables
    register_var(V,T,N,NT).
register_var(V,[X/H|T],H,[X/H|T]):-
    V==X.          % same variables
register_var(V,[],N,[V/N]).


% minOfList(+List, -MaxiamlItem)
%
%   Find minimum value of the list
%
minOfList([X|Xs], Min):-
    minOfList(Xs, X, Min).
minOfList([], Min, Min).
minOfList([X|Xs], Min0, Min):-
    ( X @< Min0 ->
        Min1 = X
        ;
        Min1 = Min0
    ),
    minOfList(Xs, Min1, Min).


reset_statistic:-
    bb_put(stat_nodes, 0),
    statistics(runtime, [T,_]),
    bb_put(startTime, T).

show_statistic:-
    bb_get(stat_nodes, N),
    bb_get(startTime, T0),
    statistics(runtime, [T1,_]),
    statistics(memory, [M, _]),
    T is T1-T0,
    format('~3d sec      ~d nodes        ~d bytes~n', [T, N, M]).


% show_statistic(+Problem, +Solution).
%
show_statistic(P, S):-
    ground(S),
    get_problem_name(P, Name),
    bb_get(stat_nodes, N),
    bb_get(startTime, T0),
    statistics(runtime, [T1,_]),
    statistics(memory, [M, _]),
    T is T1-T0,
    (is_list(S)-> length(S, L) ; L = -1),
    format('~a ~3d ~d ~d ~d', [Name,T, N, M, L]),
    solution_to_lisp(S),
    nl,
    !.
show_statistic(_, _).

solution_to_lisp([]).
solution_to_lisp([H|T]):-
    H =.. [F|P],
    write(' ('),
    write(F),
    write_list_sas(P),
    write(')'),
    solution_to_lisp(T).

write_list_sas([]).
write_list_sas([H|T]):-
    write(' '), write(H),
    write_list_sas(T).


stat_node:-
    bb_get(stat_nodes, N),
    NN is N+1,
    bb_update(stat_nodes, _, NN).



space(0):-!.
space(I):-
    write('  '),
    NI is I-1,
    space(NI).

writel([]):-nl.
writel([H|T]):-
    write(H),nl,
    writel(T).

w(X):-
    var(X),
    domain(X, D, F),
    !,
    write(X=D-F).
w(X):-
    var(X),
    !,
    write(X).

w(X):-
    atomic(X),
    !,
    write(X).
w([H|T]):-
    write('['), 
    !,
    w_list([H|T]),
    write(']').
w(X):-
    compound(X),
    !,
    X=..[F|L],
    write(F),write('('),
    w_params(L),
    write(')').
w_params([H]):-
    w(H).
w_params([H,H2|T]):-
    w(H),write(','),
    w_params([H2|T]).
w_list([H]):-
    w(H), 
    !.
w_list([H|T]):-
    w(H),
    write(','),
    w_list(T).


% state_record(State, PreviousState, Action, Deep, StateRecord)
%
state_record(S, PS, A, D, [S, PS, A, D]).


% solution(+StateRecord, +Visited, -ListOfActions)
%
solution(SR, V, L):-
    solution(SR, V, [], L).
solution(SR, _, L, L):-
    state_record(_, nil, nil, _, SR), 
    !.
solution(SR, V, R, L):-
    state_record(_, PS, AD, _, SR),
    state_record(PS, _, _, _, Previous),
    member(Previous, V),
    solution(Previous, V, [AD|R], L).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Handling mutexes

 make_mutex(M):-
    bagof(R1, forbiden_pair(R1), MA),
    bagof(R2, forbiden_pair(MA, R2), MB),
%    writel(MA),nl,
%    writel(MB),nl,
    union(MA, MB, M0),
%    list_to_set(M0_, M0),
%    write('Cistim:'),nl,
    clear_mutex1(M0, M1),
    clear_mutex2(M1, M2),
    clear_duplicates(M2, M).
    %write('Ocistene:'),nl,writel(M),nl, length(M, L), write('Pocet: '), write(L),nl.

clear_duplicates([], []).
clear_duplicates([H|T], R):-
    member(M, T),
    identical_but_for_variables(H, M),
    !,
    clear_duplicates(T, R).
clear_duplicates([H|T], [H|R]):-
    clear_duplicates(T, R).

forbiden_pair(R):-
    get_action(A),
    get_positiv_effect(A, PE),
    get_negativ_effect(A, NE),
    member(P, PE),
    member(Q, NE),
    copy_term_spec(P-Q, R).
forbiden_pair(MA, NR):-
    member(P-Q, MA),
    get_action(A),
    get_precondition(A, Precond),
    get_positiv_effect(A, PE),
    member(R, Precond),
    member(P, PE),
    copy_term_spec(R-Q, NR).

clear_mutex1([], []):-!.
clear_mutex1([PP-QQ|T], M):-
    (P-Q = PP-QQ
     ;
     P-Q = QQ-PP
    ),
    get_init(I),
    select(P, I, R),
    member(Q, R),
%    write('Rule1: '), write(PP-QQ),nl,
    clear_mutex1(T, M),
    !.
clear_mutex1([P-Q|R], [P-Q|M]):-
    clear_mutex1(R, M).

clear_mutex2(M0, M):-
    (select(P-Q, M0, R) 
     ;
     select(Q-P, M0, R)
    ),
    get_action(A, _Def),
    get_precondition(A, Precond),
    get_positiv_effect(A, PE),
    get_negativ_effect(A, NE),
    select(P, PE, RPE),
    \+ member(Q, NE),
    (
      member(Q, RPE)%, write('prva cast')
      ;
      all_not_in(Precond, P, Q, M0)%, write('druha cast')
    ),
%    write('Rule2: '), write(P-Q-_Def),nl,
    clear_mutex2(R, M),
    !.
clear_mutex2(M0, M0).

all_not_in([], _, _, _).
all_not_in([P|T], P, Q, M):-
    all_not_in(T, P, Q, M).
all_not_in([R|T], P, Q, M):-
    \+ (member(R-Q, M)
        ;
        member(Q-R, M)
       ),
    %write(precon-R),nl,
    all_not_in(T, P, Q, M).


% check_mutex(+State).
%
check_mutex(S):-
    bb_get(mutex, M),
    pairfrom(S, P, Q, _),
    (member(P-Q, M)
     ;
     member(Q-P, M)
    ),
%    write('Mutex pair.'), write(P-Q), nl,
    !,
    fail.
check_mutex(_).


identical_but_for_variables(X, Y) :-
    \+ \+ (
           copy_term(X, Z),
           numbervars(Z, 0, N),
           numbervars(Y, 0, N),
           Z = Y
          ).

% FILENAME:  domain.pl 
% :- module(pdd_domain, [pdd_domain/2, pdd_domain/3, pddl_not_equal/2, pddl_bind/1]).

:- expects_dialect(sicstus).

:- use_module(library(when)).
% :- use_module(library(atts)).
:- use_module(library(ordsets), [
        ord_intersection/3,
        ord_intersect/2,
        ord_union/3,
        ord_union/2,
        %ord_member/2,
        %ord_nonmember/2,
        ord_add_element/3,
        ord_del_element/3,
        list_to_ord_set/2
   ]).

% :- use_module(library(sets), [ del_element/3 ]).

sicstus_get_atts(V,As):- get_attrs(V,As).
sicstus_put_atts(V,As):- put_attrs(V,As).
%:- attribute(pddl_dom/2).
%:- attribute forbidden/1.

domain3:verify_attributes(Var, Other, Goals) :-
    sicstus_get_atts(Var, pddl_dom(Da, Fa)),             % are we involved?
    !,
    (   var(Other) ->                       % must be attributed then
        (   sicstus_get_atts(Other, pddl_dom(Db, Fb)) -> %   has a pdd_domain?
            (my_del_element2(Var, Fb, _) -> 
                 !, 
                 fail
                 ;
                 true
            ),
            ord_intersection(Da, Db, Dc),
            ord_union(Fa, Fb, Fc),
            Dc = [El|Els],              % at least one element
            (   Els = [] ->             % exactly one element
                Goals = [Other=El]      % implied binding
                ;   
                Goals = [],
                sicstus_put_atts(Other, pddl_dom(Dc, Fc))% rescue intersection
            )
            ;
            Goals = [],
            sicstus_put_atts(Other, pddl_dom(Da, Fa))    % rescue the pdd_domain
        )
        ;
        Goals = [],
        ord_intersect([Other], Da),      % value in pdd_domain?
        delete_from(Fa, Var, Other),
        sicstus_put_atts(Var, pddl_dom([Other], Fa)),
%        my_del_element(Var, Fa, NewFa),
        bind_all(Fa)
    ).
domain3:verify_attributes(_, _, []).                % unification triggered
                                            % because of attributes
                                            % in other modules

attribute_goal(Var, pdd_domain(Var,Dom, F)) :-     % interpretation as goal
    sicstus_get_atts(Var, pddl_dom(Dom, F)).

pdd_domain(X, Dom) :-
    pdd_domain(X, Dom, _).
pdd_domain(X, List) :-
    list_to_ord_set(List, Set),
    Set = [El|Els],                     % at least one element
    (   Els = [] ->                     % exactly one element
        X = El                          % implied binding
        ;
        sicstus_put_atts(Fresh, pddl_dom(Set, [])),
        X = Fresh                       % may call
                                        % domain3:verify_attributes/3
    ).

pdd_domain(X, Dom, F) :-
    var(Dom),
    !,
    sicstus_get_atts(X, pddl_dom(Dom, F)).

delete_from([], _, _).
delete_from([A|T], V, Value):-
    (A==V ->
        true
        ;
        sicstus_get_atts(A, pddl_dom(Ad, Af)),
        my_del_element(Value, Ad, NewAd),
        my_del_element(V, Af, NewAf),
        sicstus_put_atts(A, pddl_dom(NewAd, NewAf))
    ),
    delete_from(T, V, Value).

my_del_element(_, [], []).
my_del_element(E, [H|T], R):-
    E==H,
    !,
    my_del_element(E, T, R).
my_del_element(E, [H|T], [H|R]):-
    my_del_element(E, T, R).

my_del_element2(E, [H|T], R):-
    E==H,
    !,
    my_del_element(E, T, R).
my_del_element2(E, [H|T], [H|R]):-
    my_del_element2(E, T, R).


pddl_not_equal([], []).
pddl_not_equal(A, B):-
    ground(A), ground(B),
    !,
    A\=B.

pddl_not_equal(A, B):-
    ground(A),
    !,
    pddl_not_equal(B, A).
pddl_not_equal(A, B):-
    var(A), ground(B),
    !,
    sicstus_get_atts(A, pddl_dom(Ad, Fa)),
    ord_del_element(Ad, B, NewAd),
    sicstus_put_atts(A, pddl_dom(NewAd, Fa)),
    pddl_bind(Fa).
pddl_not_equal(A, B):-
    A==B,
    !,
    fail.
pddl_not_equal(A, B):-
    var(A), var(B),
    sicstus_get_atts(A, pddl_dom(Da, Fa)),
    sicstus_get_atts(B, pddl_dom(Db, Fb)),
%    ord_union([Fa,Fb,[A,B]], F),
    ord_union([[B],Fa], Faa),
    ord_union([[A],Fb], Fbb),
    sicstus_put_atts(A, pddl_dom(Da, Faa)),
    sicstus_put_atts(B, pddl_dom(Db, Fbb)),
    ord_union([[A],Fa], Faaaa),
    ord_union([[B],Fb], Fbbbb),
    pddl_bind(Faaaa),
    pddl_bind(Fbbbb).
pddl_not_equal([Ha|Ta], [Hb|Tb]):-
    !,
    pddl_not_equal(Ha, Hb),
    pddl_not_equal(Ta, Tb).
pddl_not_equal(A, B):-
    compound(A), compound(B),
    !,
    A =.. [Fa|Pa], B=..[Fb|Pb],
    (Fa=Fb ->
        pddl_not_equal(Pa, Pb)
        ;
        true
    ).


set_forbidden([], _).
set_forbidden([H|T], F):-
    sicstus_get_atts(H, pddl_dom(D, _)),
    sicstus_put_atts(H, pddl_dom(D, F)),
%    write(H-D-F),nl,
    set_forbidden(T, F).

bind_all([]).
bind_all([H|T]):-
  (var(H) ->
       pddl_bind([H])
       ;
       true
  ),
  bind_all(T).

pddl_bind(F):-
    setof(B, solvable(F, [], B), Bs),
    rotate(Bs, RB),
    bind_value(F, RB).

bind_value([], _).
bind_value([H|T], [B|Bs]):-
    (var(H) ->
        list_to_ord_set(B, OB),
        (OB=[VB] ->
            H=VB
            ;
            sicstus_get_atts(H, pddl_dom(_, Hf)),
            sicstus_put_atts(H, pddl_dom(OB, Hf))
        )
        ;
        true
   ),
   bind_value(T, Bs).

rotate([[]|_], []).
rotate(S, [F|Fs]):-
    first(S, F, R),
    rotate(R, Fs).

first([], [], []).
first([[F|T]|T2], [F|Fs], [T|R]):-
    first(T2, Fs, R).

solvable([], _, []).
solvable([H|T], FV, [M|S]):-
    (var(H) ->
        sicstus_get_atts(H, pddl_dom(Hd, _)),
        member(M, Hd),
        ordsets:ord_nonmember(M, FV),
        ord_add_element(FV, M, NewFV)
        ;
        NewFV=FV
    ),
    solvable(T, NewFV, S).

% FILENAME:  forward.pl 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This file must implements following predicates:
%%
%% step(+State, -ActionDef, -NewState)
%%   Return descendant of State and ActionDefinition that was used.
%%
%% is_goal(State) - is true when State is a goal state.  
%%
%% repeating(Goal1, Goal2):-  Goal1 is the same as Goal2.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- expects_dialect(sicstus).
:-use_module(library(ordsets)).

make_init_state(I):-
    get_init(I),
    get_goal(G),
    bb_put(fictiveGoal, G).


make_solution(S, S).
    
% step(+State, -ActionDef, -NewState)
%
%   Return descendant of State and ActionDefinition that was used.
%
step(State, ActionDef, NewState):-
    get_action(A, ActionDef),
    get_precondition(A, P),    mysubset(P, State),  % choose suitable action
    get_negativ_effect(A, NE), ord_subtract(State, NE, State2),
    get_positiv_effect(A, PE), ord_union(State2, PE, NewState).

is_goal(S):-
    get_goal(G),
    ord_subset(G, S).

repeating(S1, S2):-
    S1 =  S2.

% FILENAME:  forward-wa-star-h_add.pl 
%:-[readFile, parseProblem, parseDomain, common].
%:-['wa-star', forward, h_add].



% FILENAME:  forward-wa-star-h_diff.pl 
%:-[readFile, parseProblem, parseDomain, common].
%:-['wa-star', forward, 'h_diff'].

% % :-command_line_sas.

% FILENAME:  h_add.pl 

:- expects_dialect(sicstus).

% :-use_module(library(sets)).

% h(+State, -EstimatedValue)
h(S, H):-h_add(S, H).
% h(S, H):-h_diff(S, H).


%
%   Estimated distance to achieve Goal.
%
h_add(S, E):-
    bb_get(fictiveGoal, G),
    relax(S, G, E).
%    write(G-S-E),nl.

relax(_, [], 0):-!.
relax(S, G, E):-
    subtract(G, S, Delta),
    setof(P, relax_step(S, P), RS),
    ord_union([S|RS], NS),
    relax(NS, Delta, NE),
    length(Delta, LD),
    E is LD+NE.

relax_step(State, PE):-
    get_action(A),
    get_precondition(A, P),
    mysubset(P, State),
    get_positiv_effect(A, PE).

% FILENAME:  h_diff.pl 
% h(+State, -EstimatedValue)
%
%   Estimated distance to achive Goal.
%
:- expects_dialect(sicstus).

h_diff(S, E):-
    bb_get(fictiveGoal, G),
    ord_subtract(G, S, I),
    length(I, E).
 
init_heuristics(_).

% FILENAME:  parseDomain.pl 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% parseDomain.pl
%%   Simple parser of PDDL domain file into prolog syntax.
%% Author: Robert Sasak, Charles University in Prague
%%
%% Example: 
%% ?-parseDomain('blocks_world.pddl', O).
%%   O = domain(blocks,
%%        [strips, typing, 'action-costs'],
%%        [block],
%%        _G4108,
%%        [ on(block(?x), block(?y)),
%%               ontable(block(?x)),
%%               clear(block(?x)),
%%               handempty,
%%               holding(block(?x)) ],
%%        [number(f('total-cost', []))],
%%        _G4108,
%%        [ action('pick-up', [block(?x)],       %parameters
%%                    [clear(?x), ontable(?x), handempty], %preconditions
%%                    [holding(?x)],                       %positiv effects
%%          [ontable(?x), clear(?x), handempty], %negativ effects
%%          [increase('total-cost', 2)]),        %numeric effects
%%         ...],
%%       ...)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- expects_dialect(sicstus).


% parseDomain(+File, -Output).
%
%   Parse PDDL domain File and return it rewritten prolog syntax.   
%
parseDomain(F, O):- parseDomain(F, O, _).


% parseDomain(+File, -Output, -RestOfFile)
%
%   The same as above and also return rest of file. Can be useful when domain and problem are in one file.
%
parseDomain(File, Output, R) :-
    read_file(File, List),!,
    domainBNF(Output, List, R),!.

can_pddl_30.

pddl_3_0 --> {can_pddl_30}, [],!.
pddl_3_0(_Feature) --> {fail, can_pddl_30}, [],!.
pddl_3_0_e(_Feature) --> {fail, can_pddl_30}, [],!.

% Support for reading file as a list.
% :- [readFile].

% Defining operator ?. It is a syntax sugar for marking variables: ?x
:- op(300, fy, ?).


% domainBNF(domain(N, R, T, C, P, F, C, S, Slack))
%
%   DCG rules describing structure of domain file in language PDDL.
%   BNF description was obtain from http://www.cs.yale.edu/homes/dvm/papers/pddl-bnf.pdf
%   This parser do not fully NOT support PDDL 3.0
%   However you will find comment out lines ready for futher development.
%
domainBNF(domain(N, R, T, C, P, F, C, S /*, Slack*/))
                        --> ['(','define', '(','domain'], name(N), [')'],
g                        dcgMust(domainBNF_rest( R, T, C, P, F, C, S, Slack)).
domainBNF_rest( R, T, C, P, F, C, S, Slack) --> 
                             dcgMust(dcgOptionalGreedy(require_def(R))),
                             dcgMust(dcgOptionalGreedy(types_def(T))),!, %:typing
                             dcgMust(constants_def(C)  ; []),
                             dcgMust(predicates_def(P) ; []),
                             dcgMust(functions_def(F)  ; []), %:fluents
%                            dcgMust(constraints(C)   ; []),    %:constraints
                             dcgMust(oneOrMore(structure_def, S)),
   						     zeroOrMore(anythings, Slack),
                             dcgMust([')']).

require_def(R)          --> ['(',':','requirements'], dcgMust((oneOrMore(require_key, R), [')'])).
require_key(strips)                             --> [':strips'].
require_key(typing)                             --> [':typing'].
require_key('action-costs')                             --> [':action-costs'].
require_key('goal-utilities')                             --> [':goal-utilities'].
%require_key('negative-preconditions')          --> [':negative-preconditions'].
%require_key('disjunctive-preconditions')       --> [':disjunctive-preconditions'].
require_key(equality)                           --> [':equality'].
require_key('existential-preconditions')        --> [':existential-preconditions'].
require_key('universal-preconditions')          --> [':universal-preconditions'].
require_key('quantified-preconditions')         --> [':quantified-preconditions'].
require_key('conditional-effects')              --> [':conditional-effects'].
require_key(fluents)                            --> [':fluents'].
require_key(adl)                                --> [':adl'].
require_key('durative-actions')                 --> [':durative-actions'].
require_key('derived-predicates')               --> [':derived-predicates'].
require_key('timed-initial-literals')           --> [':timed-initial-literals'].
require_key(preferences)                        --> [':preferences'].
require_key(constraints)                        --> [':constraints'].
% Universal requirements
require_key(R)                  --> [':', R].
require_key(A)		--> [R],{atom_concat(':',A,R)}.
require_key(_)		--> [')'],!,{fail}.
require_key(R)		--> [R],{R\=')',trace}.

anythings(R)		--> [R],{R\=')',trace}.

types_def(L)                    --> ['(',':',types],      typed_list(name, L), [')'].
constants_def(L)                --> ['(',':',constants],  typed_list(name, L), [')'].
predicates_def(P)               --> ['(',':',predicates], oneOrMore(atomic_formula_skeleton, P), [')'].

atomic_formula_skeleton(F)
                                --> ['('], predicate(P), typed_list(variable, L), [')'], {F =.. [P|L]}.
predicate(P)                    --> name(P).

variable(V)                     --> ['?'], name(N), {V =.. [?, N]}.
atomic_function_skeleton(f(S, L))
                                --> ['('], function_symbol(S), typed_list(variable, L), [')'].
function_symbol(S)              --> name(S).
functions_def(F)                --> ['(',':',functions], function_typed_list(atomic_function_skeleton, F), [')'].              %:fluents
constraints(C)                  --> pddl_3_0, ['(',':',constraints], con_GD(C), [')'].                                         %:constraints
structure_def(A)                --> action_def(A).
%structure_def(D)               --> durative_action_def(D).                                                                    %:durativeactions
%structure_def(D)               --> derived_def(D).                                                                            %:derivedpredicates
typed_list(W, [G|Ns])           --> oneOrMore(W, N), ['-'], type(T), !, typed_list(W, Ns), {(atom(T)-> G =.. [T,N] ; G = isa(N,T))}.
typed_list(W, N)                --> zeroOrMore(W, N).

effected_typed_list(W, [G|Ns])           --> oneOrMore(W, N), ['-'], effect(T), !, effected_typed_list(W, Ns), {G =.. [T,N]}.
effected_typed_list(W, N)                --> zeroOrMore(W, N).

primitive_type(N)               --> name(N).
type(either(PT))                --> ['(',either], !, dcgMust(( oneOrMore(primitive_type, PT), [')'])).
type(PT)                        --> primitive_type(PT).
function_typed_list(W, [F|Ls])
                                --> oneOrMore(W, L), ['-'], !, function_type(T), function_typed_list(W, Ls), {F =.. [T|L]}.    %:typing
function_typed_list(W, L)       --> zeroOrMore(W, L).

function_type(number)           --> [number].
emptyOr(_)                      --> ['(',')'].
emptyOr(W)                      --> W.

% Actions definitons
action_def(action(S, L, Precon, Pos, Neg, Assign))
                                --> ['(',':',action],
                                    dcgMust(action_symbol(S)),
                                    dcgMust(([':',parameters,'('], typed_list(variable, L), [')'])),{!},
                                    dcgMust((action_def_body(Precon, Pos, Neg, Assign))),
                                    [')'].
action_symbol(N)                --> name(N).

% % 2 ?- phrase(emptyOr(pre_GD(P)),['(',accessible,?,x,')','(','no-inventory-object',?,x,')','(','has-location',?,x,?,y,')'],X).
% % P = accessible(?x),
% % X = ['(', 'no-inventory-object', ?, x, ')', '(', 'has-location', ?, x|...] .


%% [1] 2 ?- pre_GD(X,['(',accessible,?,x,')'],[]).
%% X = accessible(?x) .


% PDDL 2.x Way?
action_def_body(P, Pos, Neg, Assign)
                                --> (([':',precondition], emptyOr(pre_GD(P)))                ; []),
                                    (([':',effect],       emptyOr(effect(Pos, Neg, Assign))) ; []).

% PDDL 3.0 Way?
action_def_body(P, Pos, Neg, Assign)
				--> (([':',precondition], zeroOrMore(pre_GD,P)) /*	; []*/),
				    (([':',effect],      (emptyOr(effect(Pos, Neg, Assign))))	; []).


pre_GD(_)			--> [:,effect],{!,fail}.
% PDDL 2.x 
% pre_GD([F])                     --> atomic_formula(term, F), !.
pre_GD(P)                       --> pref_GD(P).
% PDDL 2.x
% pre_GD(and(P))                  --> ['(',and],   zeroOrMore(pre_GD ,P), [')'].       
% PDDL 3.0 Way
pre_GD(P)                       --> ['(',and], dcgMust((pre_GD(P), [')'])).
pre_GD(forall(L, P))           -->  ['(',forall,'('],  dcgMust(((typed_list(variable, L), [')'], pre_GD(P), [')']))).         %:universal-preconditions
pref_GD(preference(N, P))      -->  ['(', preference], dcgOptionalGreedy(pref_name(N)),  dcgMust(gd(P)), dcgMust([')']).                         %:preferences
pref_GD(P)                      --> gd(P).
pref_name(N)                    --> name(N).
gd(L)				--> literal(term, L).								%:negative-preconditions

gd(F)                           --> atomic_formula(term, F).                                                    %:this option is covered by gd(L)
gd(P)                           --> ['(',and],  zeroOrMore(gd, P), [')'].
%gd(or(P))                      --> pddl_3_0_e(gd), ['(',or],   zeroOrMore(gd ,P), [')'].                                       %:disjuctive-preconditions
%gd(not(P))                     --> pddl_3_0, ['(',not],  gd(P), [')'].                                                   %:disjuctive-preconditions
%gd(imply(P1, P2))              --> pddl_3_0_e(gd), ['(',imply], gd(P1), gd(P2), [')'].                                         %:disjuctive-preconditions
%gd(exists(L, P))               --> pddl_3_0_e(gd), ['(',exists,'('], typed_list(variable, L), [')'], gd(P), [')'].             %:existential-preconditions
%gd(forall(L, P))               --> pddl_3_0_e(gd), ['(',forall,'('], typed_list(variable, L), [')'], gd(P), [')'].             %:universal-preconditions
gd(F)                           --> f_comp(F).                                                                  %:fluents
f_comp(compare(C, E1, E2))      --> ['('], binary_comp(C), f_exp(E1), f_exp(E2), [')'].
literal(T, F)                   --> atomic_formula(T, F).
literal(T, not(F))              --> ['(',not], atomic_formula(T, F), [')'].
atomic_formula(_, F)            --> ['('], predicate(P), zeroOrMore(term, T), [')'], {F =.. [P|T]}.             % cheating, maybe wrong


term(N)                         --> name(N).
term(V)                         --> variable(V).
f_exp(N)                        --> number_sas(N).
f_exp(op(O, E1, E2))            --> ['('],binary_op(O), f_exp(E1), f_exp(E2), [')'].
f_exp('-'(E))                   --> ['(','-'], f_exp(E), [')'].
f_exp(H)                        --> f_head(H).
f_head(F)                       --> ['('], function_symbol(S), zeroOrMore(term, T), [')'], { F =.. [S|T] }.
f_head(S)                       --> function_symbol(S).
binary_op(O)                    --> multi_op(O).
% binary_op(45)                   --> [45]. % 45 = minus = '-'  (TODO - WHY IS THIS HERE?)
% binary_op('-')			--> ['−'].
binary_op('-')                  --> ['-'].
binary_op('/')                  --> ['/'].
multi_op('*')                   --> ['*'].
multi_op('+')                   --> ['+'].
binary_comp('>')                --> ['>'].
binary_comp('<')                --> ['<'].
binary_comp('=')                --> ['='].
binary_comp('>=')               --> ['>='].
binary_comp('<=')               --> ['<='].
number_sas(N)                       --> [N],!, {number(N)}.
%number_sas(N)                       --> [N], {integer(N)}.
%number_sas(N)                       --> [N], {float(N)}.
effect(P, N, A)                 --> ['(',and], c_effect(P, N, A), [')'].
effect(P, N, A)                 --> c_effect(P, N, A).
%c_effect(forall(E))            --> pddl_3_0, ['(',forall,'('], effected_typed_list(variable,Es), [')', ')'].    %:conditional-effects
%c_effect(when(P, E))           --> pddl_3_0, ['(',when], gd(P), cond_effect(E), [')'].                   %:conditional-effects
c_effect(P, N, A)               --> p_effect(P, N, A).
p_effect([], [], [])            --> [].
p_effect(Ps, Ns, [F|As])
				--> ['('], assign_op(O), f_head(H), f_exp(E), [')'], p_effect(Ps, Ns, As), {F =.. [O, H, E]}.
p_effect(Ps, [F|Ns], As)        --> ['(',not], atomic_formula(term,F), [')'], p_effect(Ps, Ns, As).
p_effect([F|Ps], Ns, As)        --> atomic_formula(term, F), p_effect(Ps, Ns, As).
%p_effect(op(O, H, E))          --> pddl_3_0(op/3), ['('], assign_op(O), dcgMust((f_head(H), f_exp(E), [')'])).            %:fluents , What is difference between rule 3 lines above???
%cond_effect(E)                 --> ['(',and], zeroOrMore(p_effect, E), [')'].                  %:conditional-effects
%cond_effect(E)                 --> p_effect(E).                                                %:conditional-effects
assign_op(assign)               --> [assign].
assign_op(scale_up)             --> [scale_up].
assign_op(scale_down)           --> [scale_down].
assign_op(increase)             --> [increase].
assign_op(decrease)             --> [decrease].


% BNF description include operator <term>+ to mark zero or more replacements.
% This DCG extension to overcome this. 
oneOrMore(W, [R|Rs], A, C) :- F =.. [W, R, A, B], F, (
                                                         oneOrMore(W, Rs, B, C)
                                                         ;
                                                         (Rs = [] , C = B) 
                                                     ).
% BNF operator <term>*
zeroOrMore(W, R)                --> oneOrMore(W, R).
zeroOrMore(_, [])               --> [].

% Name is everything that is not number, bracket or question mark.
% Those rules are not necessary, but rapidly speed up parsing process.
name(N,S,E):-notrace(name0(N,S,E)).
name0(N)                         --> [N], {number(N), !, fail}.
name0(N)                         --> [N], {N=')', !, fail}.
name0(N)                         --> [N], {N='(', !, fail}.
name0(N)                         --> [N], {N='?', !, fail}.
name0(N)                         --> [N], {N='-', !, fail}.
%name0 NEVER (N)                 --> [N], {N=':', !, fail}.
name0(N)                         --> [N].

% FILENAME:  parseProblem.pl 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% parseDomain.pl
%%   Simple parser of PDDL domain file into prolog syntax.
%% Author: Robert Sasak, Charles University in Prague
%%
%% Example: 
%% ?-parseProblem('problem.pddl', O).
%%   O = problem('blocks-4-0',                                                                  % name
%%              blocks,                                                                         % domain name
%%              _G1443,                                                                         % require definition
%%              [block(d, b, a, c)],                                                            % object declaration
%%              [ clear(c), clear(a), clear(b), clear(d), ontable(c),                           % initial state
%%                ontable(a), ontable(b), ontable(d), handempty,
%%                set('total-cost', 0) ],
%%              [on(d, c), on(c, b), on(b, a)],                                                 % goal
%%              _G1447,                                                                         % constraints-not implemented
%%              metric(minimize, 'total-cost'),                                                 % metric
%%              _G1449                                                                          % length_specification-not implemented
%%              )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- expects_dialect(sicstus).

% parseProblem(+File, -Output).
%
%   Parse PDDL problem File and return rewritten prolog syntax. 
%
parseProblem(F, O):-parseProblem(F, O, _).


% parseProblem(+File, -Output, -RestOfFile).
%
%   The same as above and also return rest of file. Can be useful when domain and problem are in one file.
%
parseProblem(F, O, R) :-
    read_file(F, L),!,
    problem(O, L, R),!.

% Support for reading file as a list.
% :- [readFile].



% List of DCG rules describing structure of problem file in language PDDL.
%
%   BNF description was obtain from http://www.cs.yale.edu/homes/dvm/papers/pddl-bnf.pdf
%   This parser do not fully NOT support PDDL 3.0
%   However you will find comment out lines ready for futher development.
%   Some of the rules are already implemented in parseDomain.pl
%
% :-[parseDomain]. % make sure that it is loaded.

problem(problem(Name, Domain, R, OD, I, G, UNK, MS, LS))   
                                --> ['(',define,'(',problem,Name,')',
                                     '(',':',domain, Domain,')'],
                                     dcgMust(problem_rest(R, OD, I, G, UNK, MS, LS)).

problem_rest(R, OD, I, G, _, MS, LS) --> 
   dcgMust(require_def(R)         ; []),
   dcgMust(object_declaration(OD) ; []),
   dcgMust(init(I)),
   dcgMust(goal(G)),
%                                    (constraints(C)   ; []), %:constraints
   dcgMust(dcgOptionalGreedy(metric_spec(MS))),
   dcgMust(length_spec(LS)  ; []),
   dcgMust([')']),!.

object_declaration(L)		--> ['(',':',objects], typed_list(name, L),[')'].
object_declaration(L)           --> ['(',':',objects], typed_list_as_list(name, L),[')'].

typed_list_as_list(W, OUT)   --> oneOrMore(W, N), ['-'],!, dcgMust(( type(T), typed_list_as_list(W, Ns), {
 (atom(T)-> G =.. [T,N] ; G = isa(N,T)), OUT = [G|Ns]})).
typed_list_as_list(W, N)        --> zeroOrMore(W, N).

init(I)                         --> ['(',':',init], zeroOrMore(init_el, I), [')'].

init_el(I)                      --> literal(name, I).
init_el(set(H,N))               --> ['(','='], f_head(H), number_sas(N), [')'].                                     % fluents
init_el(at(N, L))               --> ['(',at], number_sas(N), literal(name, L), [')'].                               % timed-initial literal
goal(G)                         --> ['(',':',goal], dcgMust((pre_GD(G),[')'])).
%constraints(C)                 --> ['(',':',constraints], pref_con_GD(C), [')'].                               % constraints
pref_con_GD(and(P))             --> ['(',and], zeroOrMore(pref_con_GD, P), [')'].
%pref_con_GD(foral(L, P))       --> ['(',forall,'('], typed_list(variable, L), [')'], pref_con_GD(P), [')'].    % universal-preconditions
%pref_con_GD(prefernce(N, P))   --> ['(',preference], (pref_name(N) ; []), con_GD(P), [')'].                    % prefernces
pref_con_GD(P)                  --> con_GD(P).

con_GD(and(L))                  --> ['(',and], zeroOrMore(con_GD, L), [')'].
con_GD(forall(L, P))            --> ['(',forall,'('], typed_list(variable, L),[')'], con_GD(P), [')'].
con_GD(at_end(P))               --> ['(',at,end],   gd(P), [')'].
con_GD(always(P))               --> ['(',always],   gd(P), [')'].
con_GD(sometime(P))             --> ['(',sometime], gd(P), [')'].
con_GD(within(N, P))            --> ['(',within], number_sas(N), gd(P), [')'].

con_GD(at_most_once(P))         --> ['(','at-most-once'], gd(P),[')'].
con_GD(some_time_after(P1, P2)) --> ['(','sometime-after'], gd(P1), gd(P2), [')'].
con_GD(some_time_before(P1, P2))--> ['(','sometime-before'], gd(P1), gd(P2), [')'].
con_GD(always_within(N, P1, P2))--> ['(','always-within'], number_sas(N), gd(P1), gd(P2), [')'].
con_GD(hold_during(N1, N2, P))  --> ['(','hold-during'], number_sas(N1), number_sas(N2), gd(P), [')'].
con_GD(hold_after(N, P))        --> ['(','hold-after'], number_sas(N), gd(P),[')'].

metric_spec(metric(O, E))       --> ['(',':',metric], optimization(O), dcgMust((metric_f_exp(E), [')'])).

optimization(minimize)          --> [minimize].
optimization(maximize)          --> [maximize].

metric_f_exp(E)                 --> ['('], binary_op(O), metric_f_exp(E1), metric_f_exp(E2), [')'], {E =..[O, E1, E2]}.
metric_f_exp(multi_op(O,[E1|E]))--> ['('], multi_op(O), metric_f_exp(E1), oneOrMore(metric_f_exp, E), [')']. % I dont see meanful of this rule, in additional is missing in f-exp
metric_f_exp(E)                 --> ['(','-'], metric_f_exp(E1), [')'], {E=..[-, E1]}.
metric_f_exp(N)                 --> number_sas(N).
% 3.0 
metric_f_exp(F)			        --> ['('], function_symbol(S), zeroOrMore(name, Ns), [')'], { concat_atom([S|Ns], '-', F) }.
% 2.x
metric_f_exp(F)                 --> ['('], function_symbol(S), zeroOrMore(name, Ns), [')'], { F=..[S|Ns]}.%concat_atom_iio([S|Ns], '-', F) }.
metric_f_exp(function(S))       --> function_symbol(S).
metric_f_exp(total_time)        --> ['total-time'].
metric_f_exp(is_violated(N))    --> ['(','is-violated'], pref_name(N), [')'].

% Work arround
metric_f_exp(is_violated(N,V))    --> ['(','*','(','is-violated'], pref_name(N), [')'],number_sas(V),[')'].

% Work arround
length_spec([])                 --> [not_defined].      % there is no definition???


% FILENAME:  readFile.pl 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  read_file
%%%  This is a modified version for parsing pddl files.
%%%  Read the input file character by character and parse it
%%%  into a list. Brackets, comma, period and question marks
%%%  are treated as separate words. White spaces separed 
%%%  words. 
%%%
%%%  Similar to read_sent in Pereira and Shieber, Prolog and
%%%        Natural Language Analysis, CSLI, 1987.
%%%
%%%  Examples:
%%%           :- read_file('input.txt', L).
%%%           input.txt> The sky was blue, after the rain.
%%%           L = [the, sky, was, blue, (','), after, the, rain, '.']
%%%
%%%           :- read_file('domain.pddl', L).
%%%           domain.pddl>
%%%           (define (domain BLOCKS)
%%%             (:requirements :strips :typing :action-costs)
%%%             (:types block)
%%%             (:predicates (on ?x - block ?y - block)
%%%           ...
%%%           L = ['(', define, '(', domain, blocks, ')', '(', :, requirements|...].

:- expects_dialect(sicstus).

%
% read_file(+File, -List).
%
read_file( File, Words) :-  exists_file(File), !, seeing(Old),call_cleanup(( see(File), get_code(C), notrace(read_rest(C, Words))),( seen, see(Old))),!.
read_file(File0, Words) :-  must((filematch_sas(File0,File),exists_file(File),read_file( File, Words))),!.

/* Ends the input. */
read_rest(-1,[]) :- !.

/* Spaces, tabs and newlines between words are ignored. */
read_rest(C,Words) :- ( C=32 ; C=10 ; C=9 ; C=13 ; C=92 ) , !,
                     get_code(C1),
                     read_rest(C1,Words).

/* Brackets, comma, period or question marks are treated as separed words */
read_rest(C, [Char|Words]) :- ( C=40 ; C=41 ; C=44 ; C=45 ; C=46 ; C=63 ; C=58 ) , name(Char, [C]), !,
			get_code(C1),
			read_rest(C1, Words).

/* Read comments to the end of line */
read_rest(59, Words) :- get_code(Next), !, 
			      read_comment(Next, Last),
			      read_rest(Last, Words).

/* Otherwise get all of the next word. */
read_rest(C,[Word|Words]) :- read_word(C,Chars,Next),
                             name(Word,Chars),
                             read_rest(Next,Words).

/* Space, comma, newline, period, end-of-file or question mark separate words. */
read_word(C,[],C) :- ( C=32 ; C=44 ; C=10 ; C=9 ; C=13 ;
                         C=46 ; C=63 ; C=40 ; C=41 ; C=58 ; C= -1 ) , !.

/* Otherwise, get characters and convert to lower case. */
read_word(C,[LC|Chars],Last) :- lower_case(C, LC),
				get_code(Next),
                                read_word(Next,Chars,Last).

/* Convert to lower case if necessary. */
lower_case(C,C) :- ( C <  65 ; C > 90 ) , !.
lower_case(C,LC) :- LC is C + 32.


/* Keep reading as long you dont find end-of-line or end-of-file */
read_comment(10, 10) :- !.
read_comment(-1, -1) :- !.
read_comment(_, Last) :- get_code(Next),
			 read_comment(Next, Last).

%get0(C):-get_code(C), !.

/* for reference ... 
newline(10).
comma(44).
space(32).
period(46).
question_mark(63).
*/



% FILENAME:  test_validate_input_2009.pl 
:- expects_dialect(sicstus).
% :-[parseProblem, parseDomain].

%nop(_).

%parse_file(+File).
test_parse_file(F,O):- must(read_file(F, L)),!,((domainBNF(O, L, _R1); must(((problem(O, L, _R2)))))),!.

test_parse_file(F):- test_parse_file(F,L),arg(2,L,List),!,
 (not(member('(',List))->true;
    ((absolute_file_name(F,A),
	write('Parsing file failed. '), write('('), write(F:A), write(')'), nl))),!.


test_dir_sas(DirIn):-forall(filematch_sas(DirIn,DirInM),test_dir_m(DirInM)).
test_dir_m(DIR):-
  working_directory(WAS,WAS),
     call_cleanup(( 
        cd(DIR),
	write('Testing ':DIR), nl,
	test_dir_files_sas(DIR)),
        cd(WAS)).

test_sas:- 
      test_dir_sas('ipc2008-no-cybersec/seq-sat/elevators-strips/'),!, % NO FIRST ANSWER
      !.

test_sas_sanity:- 
      test_dir_sas('ipc2008-no-cybersec/seq-opt/openstacks-strips/'), %PASSES BUT RUNS SLOW
       test_dir_sas('ipc2008-no-cybersec/seq-opt/transport-strips/'), %PASSES BUT RUNS
      test_dir_sas('ipc2008-no-cybersec/netben-opt/elevators-strips/'), % FAIL ALL
      !.

test_rest:-	
	test_dir_sas('ipc2008-no-cybersec/seq-opt/parcprinter-strips/'),
	test_dir_sas('ipc2008-no-cybersec/seq-opt/pegsol-strips/'),
	test_dir_sas('ipc2008-no-cybersec/seq-opt/scanalyzer-strips/'),
	test_dir_sas('ipc2008-no-cybersec/seq-opt/sokoban-strips/'),  % NO FIRST ANSWER
       
	test_dir_sas('ipc2008-no-cybersec/seq-opt/woodworking-strips/'),
	
        
        expand_file_name('ipc2008-no-cybersec/*/*/',O),
        forall(member(E,O),test_dir_sas(E)).

test_dir_files_sas(Dir,D,P):- directory_file_path(Dir,D,DF), directory_file_path(Dir,P,PF),
        test_parse_file(DF),test_parse_file(PF),
        solve_files(DF,PF),!.

test_dir_files_sas(Dir):-   
	test_dir_files_sas(Dir,'p01-domain.pddl','p01.pddl'),
	test_dir_files_sas(Dir,'p02-domain.pddl','p02.pddl'),
	test_dir_files_sas(Dir,'p03-domain.pddl','p03.pddl'),
	test_dir_files_sas(Dir,'p04-domain.pddl','p04.pddl'),
	test_dir_files_sas(Dir,'p05-domain.pddl','p05.pddl'),
	test_dir_files_sas(Dir,'p06-domain.pddl','p06.pddl'),
	test_dir_files_sas(Dir,'p07-domain.pddl','p07.pddl'),
	test_dir_files_sas(Dir,'p08-domain.pddl','p08.pddl'),
	test_dir_files_sas(Dir,'p09-domain.pddl','p09.pddl'),
	test_dir_files_sas(Dir,'p10-domain.pddl','p10.pddl'),
	test_dir_files_sas(Dir,'p11-domain.pddl','p11.pddl'),
	test_dir_files_sas(Dir,'p12-domain.pddl','p12.pddl'),
	test_dir_files_sas(Dir,'p13-domain.pddl','p13.pddl'),
	test_dir_files_sas(Dir,'p14-domain.pddl','p14.pddl'),
	test_dir_files_sas(Dir,'p15-domain.pddl','p15.pddl'),
	test_dir_files_sas(Dir,'p16-domain.pddl','p16.pddl'),
	test_dir_files_sas(Dir,'p17-domain.pddl','p17.pddl'),
	test_dir_files_sas(Dir,'p18-domain.pddl','p18.pddl'),
	test_dir_files_sas(Dir,'p19-domain.pddl','p19.pddl'),
	test_dir_files_sas(Dir,'p20-domain.pddl','p20.pddl'),
	test_dir_files_sas(Dir,'p21-domain.pddl','p21.pddl'),
	test_dir_files_sas(Dir,'p22-domain.pddl','p22.pddl'),
	test_dir_files_sas(Dir,'p23-domain.pddl','p23.pddl'),
	test_dir_files_sas(Dir,'p24-domain.pddl','p24.pddl'),
	test_dir_files_sas(Dir,'p25-domain.pddl','p25.pddl'),
	test_dir_files_sas(Dir,'p26-domain.pddl','p26.pddl'),
	test_dir_files_sas(Dir,'p27-domain.pddl','p27.pddl'),
	test_dir_files_sas(Dir,'p28-domain.pddl','p28.pddl'),
	test_dir_files_sas(Dir,'p29-domain.pddl','p29.pddl'),
	test_dir_files_sas(Dir,'p30-domain.pddl','p30.pddl').


% FILENAME:  wa-star.pl 
% Interface:
%
% step(+State, -NewState)
% is_goal(State)
% h(State, Value) 
% repeating(+State, +AnotherState)
:- expects_dialect(sicstus).

:-use_module(library(ordsets)).
:-use_module(library(heaps)).


% search(+InitState, +GoalState, -Solution)
%
search(I, _, Solution):-
    a_star(I, Solution, _).
    
    
% a_star(+InitState, -Actions, -Cost).
%
a_star(S, A, C):-
    state_record(S, nil, nil, 0, SR),
    list_to_heap([0-SR], PQ),
    a_star(PQ, [], A, C).


% a_star(+Queue, +Visited, -Solution, -Cost)
%
a_star(PQ, _, 'NO SOLUTION', _):-
  %  write('NO SOLUTION'),nl,
    empty_heap(PQ),
    !.
a_star(PQ, V, Solution, C):-
    get_from_heap(PQ, C, SR, _),
    state_record(S, _, _, _, SR),
    is_goal(S),
%    write('FOUND SOLUTION'),nl,
%    state_record(S, _, _, D, SR), write(C-D), write('   '),write(S),nl,
%    writel(V),nl,halt,
    solution(SR, V, Solution).

a_star(PQ, V, Solution, C):-
    get_from_heap(PQ, _K, SR, RPQ),
    ord_add_element(V, SR, NV),
    (    bagof(K-NS, next_node(SR, PQ, NV, K, NS), NextNodes) 
         ;
         NextNodes=[]
    ),
%    state_record(S, _, _, D, SR), write(_K-D), write('   '),write(S),length(NextNodes, L), write(L),nl,
%    write(NextNodes),nl,
    add_list_to_heap(RPQ, NextNodes, NPQ),
    stat_node,
    a_star(NPQ, NV, Solution, C).


% next_node(+StateRecord, +Queue, +Visited, -EstimateDeep, -NewStateRecord)
%
next_node_wastar(SR, Q, V, E, NewSR):- trace,
    state_record(S, _, _, D, SR),
    step(S, A, NewS),
    state_record(NewS, _, _, _, Temp),
    \+ my_ord_member(NewS, V),
    heap_to_list(Q, PQL),
    \+ member(Temp, PQL),
    h(S, H),
    E is 5*H+D,
    ND is D+1,
    state_record(NewS, S, A, ND, NewSR).


% next_node(+StateRecord, +Queue, +Visited, -EstimateDeep, -NewStateRecord)
%
next_node(SR, Q, V, E, NewSR):-
    state_record(S, _, _, D, SR),
    step(S, A, NewS),
    state_record(NewS, _, _, _, Temp),
    \+ my_ord_member(NewS, V),
    heap_to_list(Q, PQL),
    \+ member(Temp, PQL),
    h(S, H),
    E is H+D,
    ND is D+1,
    state_record(NewS, S, A, ND, NewSR).


% add_list_to_heap(+OldHeap, List, NewHeap)
%
add_list_to_heap(OH, [], OH).
add_list_to_heap(OH, [K-D|T], NH):-
    add_to_heap(OH, K, D, H),
    add_list_to_heap(H, T, NH).

my_ord_member(S, [SR|_]):-
    state_record(S2, _, _, _,SR),
    repeating(S, S2),
    !.
my_ord_member(S, [_|T]):-
    my_ord_member(S, T).


:- test_blocks.
:- test_primaryobjects.
:- time(test_tpddla).
:- prolog.