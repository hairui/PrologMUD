
:- use_module(library(logicmoo_user)).

%this will require a better tms to work!

% general truths

% a man can only love one woman.
loves(M,W1), woman(W1), woman(W2)/W1\==W2
  ==>
  ( ~loves(M,W2)).

% unrequited love leads to suicide.
loves(P1,P2),( ~loves(P2,P1))
  ==> kills(P1,P1).

% a jealous lover kills his competitor in love.
jealous(P1), loves(P1,X), loves(P2,X)/(P1\==P2)
  ==> kills(P1,P2).

% killing is a tragedy.
kill(X,Y) ==> tragedy.

% we don't want a tragedy in THIS play.
tragedy ==> contradiction.

% the facts of a midsummer night's dream

==> woman(hermia).
==> woman(helena).

( ~loves(demitrius,hermia)) ==> loves(demitrius,helena).

( ~loves(lysander,hermia)) ==> loves(lysander,helena).

==> jealous(lysander).
==> loves(hermia,lysander).
==> default(loves(lysander,hermia)).
==> loves(helena,demetrius).
==> default(loves(demetrius,hermia)).
