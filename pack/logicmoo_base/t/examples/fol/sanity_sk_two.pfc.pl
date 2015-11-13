#!/usr/bin/env swipl

:- module(sanity_ks_two,[]).

:- use_module(library(logicmoo_user)).

:- mpred_pfc_file.

:- debug(_).
:- nodebug(http(_)).
:- begin_pfc.


% Basicly is this.. forall(C, forall(G, grandparent(C,G) => exists(P, (parent(P,G) & parent(C,P))))).
forall(C, forall(G, exists(P,  grandparent(C,G) => (parent(C,P) & (parent(P,G)))))).

grandparent(douglas,trudy).

:- must(parent(douglas,_X)).

