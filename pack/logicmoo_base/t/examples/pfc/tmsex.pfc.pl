
:- use_module(library(logicmoo_user)).

p(X) ==> q(X).
q(X), r(X) ==> s(X).
s(X) ==> t.

==> p(1).
==> r(1).
==> s(2).
