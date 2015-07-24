:- module(multi,
          [ multi/2,multi/1,
            domain/2                    % Var, ?Domain
          ]).

:- set_prolog_flag(generate_debug_info, true).

:- dynamic   user:file_search_path/2.
:- multifile user:file_search_path/2.
user:file_search_path(pack, '../../../../').
:- attach_packs.
:- initialization(attach_packs).
:- user:ensure_loaded(library(logicmoo/util/logicmoo_util_all)).





nobind0(X):- when((?=(X, Y);?=(X, X);?=(X, xx);nonvar(X)),unbind(X,Y)).
nobind1(X):- multi(X,Y),freeze(X,unbind(X,Y)),put_attr(X, multi,[x(X)]), when((?=(X, Y);nonvar(X)),unbind(X,Y)).
nobind2(X):- when(?=(X, X),unbind(X,_)).
project_attributes(QueryVars, ResidualVars):-fmsg(project_attributes(QueryVars, ResidualVars)).
verify_attributes(Var, Other, Goals) :- fmsg(verify_attributes(Var, Other, Goals)).

attr_unify_hook(X, Other) :-  fmsg(attr_unify_hook(X, Other)).
attr_unify_hook(mdif(V1,V2),Other) :- dif_attr_unify_hook(mdif(V1,V2),Other).

attribute_goals(X,In,Out) :- get_attr(X, multi, List), fmsg(attribute_goals(X,In,Out,multi, List)), fail.
attribute_goals(X) -->
        { get_attr(X, multi, List) },
        [ put_attr(X, multi, List) ].


fmsg(D):-format('~N',[]),writeq(dmsg(D)),nl,dumpST,!,fail.
fdmsg_and_fail(D):-format('~N',[]),writeq(D),nl,!,fail.

'$attvar':uhook(Multi, AttVal, Value):- fmsg(uhook(user,Multi, AttVal, Value)),fail.
'$attvar':uhook(freeze, C, A) :- !,
        (   attvar(A)
        ->  (   get_attr(A, freeze, B)
            ->  put_attr(A, freeze, '$and'(B, C))
            ;   put_attr(A, freeze, C)
            )
        ;   unfreeze(C)
        ).
'$attvar':uhook(A, B, C) :- 
        call(A:attr_unify_hook(B, C)).


'$attvar':'$wakeup'(Multi):- fmsg('$attvar':'$wakeup'(Multi)).
'$attvar':'$wakeup'([]).
'$attvar':'$wakeup'(wakeup(A, B, C)) :-
        '$attvar':call_all_attr_uhooks(A, B),
        '$attvar':'$wakeup'(C).


unbind(X,Y):- writeq(X=Y),dumpST.

test_nb:- nobind(X),X = 1.

/*

?-  nobind(X),X=1,writeq(yes(X)).

writeq(yes(X)).
X{multi..[1]}
X = _G56.


*/

:- public
	portray_attvar/1.

'$attvar':portray_attvar(Var) :-
	write('{<'),
	get_attrs(Var, Attr),
	catch(writeq(Attr),_,'$attvar':portray_attrs(Attr, Var)),
	write('>}').



:- use_module(library(ordsets)).

domain(X, Dom) :-
        var(Dom), !,
        get_attr(X, domain, Dom).
domain(X, List) :-
        list_to_ord_set(List, Domain),
        put_attr(Y, domain, Domain),
        X = Y.

%       An attributed variable with attribute value Domain has been
%       assigned the value Y

domain_attr_unify_hook(Domain, Y) :-
        (   get_attr(Y, domain, Dom2)
        ->  ord_intersection(Domain, Dom2, NewDomain),
            (   NewDomain == []
            ->  fail
            ;   NewDomain = [Value]
            ->  Y = Value
            ;   put_attr(Y, domain, NewDomain)
            )
        ;   var(Y)
        ->  put_attr( Y, domain, Domain )
        ;   ord_memberchk(Y, Domain)
        ).

%       Translate attributes from this module to residual goals

domain_attribute_goals(X) -->
        { get_attr(X, domain, List) },
        [domain(X, List)].




:- use_module(library(lists)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
multi(X) :- ignore(fdmsg_and_fail(multi_t(X))), dif_c_c(X,zNotz,_).
multi(X,Y) :- ignore(fdmsg_and_fail(multi_t(X,Y))), X \== Y,  dif_c_c(X,Y,_).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% types of attributes?
%	mdif: X is a variable
%%	node(Parent,Children,Variables,Counter)

dif_c_c(X,Y,OrNode) :-
	(	( current_prolog_flag(occurs_check, error) ->
			catch(unifiable(X,Y,Unifier), error(occurs_check(_,_),_), fail)
		  ;
			unifiable(X,Y,Unifier)
		) ->
		( Unifier == [] ->
			or_one_fail(OrNode)
		;
			dif_c_c_l(Unifier,OrNode)
		)
	;
		or_succeed(OrNode)
	).


dif_c_c_l(Unifier,OrNode) :-
	length(Unifier,N),
	extend_ornode(OrNode,N,List,Tail),
	dif_c_c_l_aux(Unifier,OrNode,List,Tail).

extend_ornode(OrNode,N,List,Vars) :-
	( get_attr(OrNode,multi,Attr) ->
		Attr = node(M,Vars),
		O is N + M - 1
	;
		O = N,
		Vars = []
	),
	put_attr(OrNode,multi,node(O,List)).

dif_c_c_l_aux([],_,List,List).
dif_c_c_l_aux([X=Y|Unifier],OrNode,List,Tail) :-
	List = [X=Y|Rest],
	add_ornode(X,Y,OrNode),
	dif_c_c_l_aux(Unifier,OrNode,Rest,Tail).

add_ornode(X,Y,OrNode) :-
	add_ornode_var1(X,Y,OrNode),
	( var(Y) ->
		add_ornode_var2(X,Y,OrNode)
	;
		true
	).

add_ornode_var1(X,Y,OrNode) :-
	( get_attr(X,multi,Attr) ->
		Attr = mdif(V1,V2),
		put_attr(X,multi,mdif([OrNode-Y|V1],V2))
	;
		put_attr(X,multi,mdif([OrNode-Y],[]))
	).

add_ornode_var2(X,Y,OrNode) :-
	( get_attr(Y,multi,Attr) ->
		Attr = mdif(V1,V2),
		put_attr(Y,multi,mdif(V1,[OrNode-X|V2]))
	;
		put_attr(Y,multi,mdif([],[OrNode-X]))
	).


dif_attr_unify_hook(mdif(V1,V2),Other) :-
	( var(Other) ->
		reverse_lookups(V1,Other,OrNodes1,NV1),
		or_one_fails(OrNodes1),
		get_attr(Other,multi,OAttr),
		OAttr = mdif(OV1,OV2),
		reverse_lookups(OV1,Other,OrNodes2,NOV1),
		or_one_fails(OrNodes2),
		remove_obsolete(V2,Other,NV2),
		remove_obsolete(OV2,Other,NOV2),
		append(NV1,NOV1,CV1),
		append(NV2,NOV2,CV2),
		( CV1 == [], CV2 == [] ->
			del_attr(Other,multi)
		;
			put_attr(Other,multi,mdif(CV1,CV2))
		)
	;
		verify_compounds(V1,Other),
		verify_compounds(V2,Other)
	).

remove_obsolete([], _, []).
remove_obsolete([N-Y|T], X, L) :-
        (   Y==X ->
            remove_obsolete(T, X, L)
        ;   L=[N-Y|RT],
            remove_obsolete(T, X, RT)
        ).

reverse_lookups([],_,[],[]).
reverse_lookups([N-X|NXs],Value,Nodes,Rest) :-
	( X == Value ->
		Nodes = [N|RNodes],
		Rest = RRest
	;
		Nodes = RNodes,
		Rest = [N-X|RRest]
	),
	reverse_lookups(NXs,Value,RNodes,RRest).

verify_compounds([],_).
verify_compounds([OrNode-Y|Rest],X) :-
	( var(Y) ->
		true
	; OrNode == (-) ->
		true
	;
		dif_c_c(X,Y,OrNode)
	),
	verify_compounds(Rest,X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
or_succeed(OrNode) :-
	( attvar(OrNode) ->
		get_attr(OrNode,multi,Attr),
		Attr = node(_Counter,Pairs),
		del_attr(OrNode,multi),
		OrNode = (-),
		del_or_dif(Pairs)
	;
		true
	).

or_one_fails([]).
or_one_fails([N|Ns]) :-
	or_one_fail(N),
	or_one_fails(Ns).

or_one_fail(OrNode) :-
	( attvar(OrNode) ->
		get_attr(OrNode,multi,Attr),
		Attr = node(Counter,Pairs),
		NCounter is Counter - 1,
		( NCounter == 0 ->
			fail
		;
			put_attr(OrNode,multi,node(NCounter,Pairs))
		)
	;
		fail
	).

del_or_dif([]).
del_or_dif([X=Y|Xs]) :-
	cleanup_dead_nodes(X),
	cleanup_dead_nodes(Y),
	del_or_dif(Xs).

cleanup_dead_nodes(X) :-
	( attvar(X) ->
		get_attr(X,multi,Attr),
		Attr = mdif(V1,V2),
		filter_dead_ors(V1,NV1),
		filter_dead_ors(V2,NV2),
		( NV1 == [], NV2 == [] ->
			del_attr(X,multi)
		;
			put_attr(X,multi,mdif(NV1,NV2))
		)
	;
		true
	).

filter_dead_ors([],[]).
filter_dead_ors([Or-Y|Rest],List) :-
	( var(Or) ->
		List = [Or-Y|NRest]
	;
		List = NRest
	),
	filter_dead_ors(Rest,NRest).

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   The attribute of a variable X is mdif/2. The first argument is a
   list of pairs. The first component of each pair is an OrNode. The
   attribute of each OrNode is node/2. The second argument of node/2
   is a list of equations A = B. If the LHS of the first equation is
   X, then return a goal, otherwise don't because someone else will.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

dif_attribute_goals(Var) -->
	(   { get_attr(Var, multi, mdif(Ors,_)) } ->
	    or_nodes(Ors, Var)
	;   or_node(Var)
	).

or_node(O) -->
        (   { get_attr(O, multi, node(_, Pairs)) } ->
            { eqs_lefts_rights(Pairs, As, Bs) },
            mydif(As, Bs),
            { del_attr(O, multi) }
        ;   []
        ).

or_nodes([], _)       --> [].
or_nodes([O-_|Os], X) -->
	(   { get_attr(O, multi, node(_, Eqs)) } ->
            (   { Eqs = [LHS=_|_], LHS == X } ->
                { eqs_lefts_rights(Eqs, As, Bs) },
                mydif(As, Bs),
                { del_attr(O, multi) }
            ;   []
            )
        ;   [] % or-node already removed
        ),
	or_nodes(Os, X).

mydif([X], [Y]) --> !, [multi(X, Y)].
mydif(Xs0, Ys0) --> [multi(X,Y)],
        { reverse(Xs0, Xs), reverse(Ys0, Ys), % follow original order
          X =.. [f|Xs], Y =.. [f|Ys] }.

eqs_lefts_rights([], [], []).
eqs_lefts_rights([A=B|ABs], [A|As], [B|Bs]) :-
        eqs_lefts_rights(ABs, As, Bs).
