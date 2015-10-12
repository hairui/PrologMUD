
:- if(lmconf:startup_option(datalog,sanity);lmconf:startup_option(clif,sanity)).

:- file_begin(pfc).


% if we learn that someone has a full name, then we know they are a user_login.
full_name(U,_) ==> user_login(U).


% if we learn that someone has a host name, then we know they are a user_login.
host_name(U,_) ==> user_login(U).


% when we know a user_login's full name and host name, make a user_name_host/3 assertion.
(((user_login(User),
  full_name(User,Name)/(Name\=isMissing),
  host_name(User,Host)/(Host\=isMissing) ),
  {ground(user_name_host(User,Name,Host))}) ==> user_name_host(User,Name,Host)).


% the default full_name for a user_login is 'isMissing'.
%user_login(User), ~full_name(User,X)/(X\=isMissing)==>full_name(User,isMissing).
prologSingleValued(full_name).
mpred_default( user_login(User) ==> full_name(User,isMissing)).  


% the default host_name for a user_login is 'isMissing'.
%user_login(User), ~host_name(User,X)/(X\==isMissing) ==> host_name(User,isMissing).
prologSingleValued(host_name).
mpred_default( user_login(User) ==> host_name(User,isMissing)).


(mpred_default1(P ==> Q),{mpred_literal_nv(Q),arg(N,Q,DEF),N>1,nonvar(DEF),replace_arg(Q,N,NEW,R)} ==> (P, ~R/(NEW\==DEF) ==> Q)).

((singleValuedInArgDefault(F, N, DEF),arity(F,A),
   {functor(Q,F,A),mpred_literal_nv(Q),arg(N,Q,DEF),N>1,nonvar(DEF),replace_arg(Q,N,NEW,R)})==> (~R/(NEW\==DEF) ==> Q)).

==> full_name(finin,'Tim Finin').

==> host_name(finin,antares).

==> full_name(robin,'Robin,McEntire').

==> host_name(fritzson,hamlet).

:- listing([full_name/2,host_name/2,user_login/1,user_name_host/3]).

:-must(host_name(robin,isMissing)).

==> host_name(robin,rmachine).

:-must(\+ host_name(robin,isMissing)).

==> ~host_name(robin,rmachine).

:-must(\+ host_name(robin,rmachine)).

:-must(host_name(robin,isMissing)).


meta_argtypes(idForTest(tBird,ftTerm)).

singleValuedInArgDefault(idForTest,2,isMissing).

tBird(iPeety).

:- endif.


end_of_file.


:-must(idForTest(iPeety,isMissing)).


idForTest(iTweety,foo1).

:-must(\+ idForTest(iTweety,isMissing)).

:-must(idForTest(iTweety,foo1)).


:-show_call(listing(idForTest)).

==> \+ idForTest(iTweety,foo1).

:-must(idForTest(iTweety,isMissing)).
:-must(\+ idForTest(iTweety,foo1)).

:-show_call(listing(idForTest)).


