
:- file_begin(pfc).




prologSingleValued(C):-cwc,is_ftCompound(C),functor(C,F,_),!,prologSingleValued(F).

% asserting mpred_sv(p,2) causes p/2 to be treated as a mpred_sv, i.e.
% if p(foo,1)) is a fact and we assert_db p(foo,2), then the forrmer assertion
% is retracted.
mpred_sv(Pred,Arity)==> prologSingleValued(Pred),arity(Pred,Arity),singleValuedInArg(Pred,Arity).

% prologSingleValued(Pred),arity(Pred,Arity) ==> hybrid_support(Pred,Arity).

% prologSingleValued(Pred),arity(Pred,Arity), \+ singleValuedInArg(Pred,_) ==> singleValuedInArg(Pred,Arity).
mpred_default(((prologSingleValued(Pred),arity(Pred,Arity))==> singleValuedInArg(Pred,Arity))).



((singleValuedInArg(Pred,_))==>(prologSingleValued(Pred))).

singleValuedInArg(singleValuedInArg,2).



prologHybrid(singleValuedInArgDefault, 3).
prologHybrid(singleValuedInArgDefault(prologSingleValued,ftInt,ftTerm)).
((singleValuedInArgDefault(P, 2, V), arity(P,2), argIsa(P,1,Most)) ==> relationMostInstance(P,Most,V)).
(singleValuedInArgDefault(SingleValued,ArgN,S1)/ground(S1) ==> singleValuedInArg(SingleValued,ArgN)).
{FtInt=2},singleValuedInArgDefault(PrologSingleValued,FtInt,FtTerm),arity(PrologSingleValued,FtInt),
  argIsa(PrologSingleValued,1,Col)==>relationMostInstance(PrologSingleValued,Col,FtTerm).
((singleValuedInArgDefault(F, N, DEF)/is_ftNonvar(DEF), arity(F,A),
   {functor(P,F,A),replace_arg(P,N,DEF,Q),replace_arg(Q,N,WAS,R)})
       ==> mpred_default( Q <- ({ground(P)},~R/nonvar(WAS)))).




:- if(lmconf:startup_option(datalog,sanity);lmconf:startup_option(clif,sanity)).
/*

% These tests mix singleValuedInArg and mpred_default/1 is differnt ways


% if we learn that something has a full name, then we guess it is a user_login object.  (in our version of reality)
full_name(U,_) ==> user_login(U).


% if we learn that something has a host name, then we guess it is a user_login object.
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


never_assert_u(full_name(finin,isMissing),too_much_forward_chaing).

user_login(joe1).

:- sanity(listing([full_name/2,host_name/2,user_login/1])).

:- mpred_test(host_name(joe1,isMissing)).


% (mpred_default1(P ==> Q),{mpred_literal_nv(Q),arg(N,Q,DEF),N>1,nonvar(DEF),replace_arg(Q,N,NEW,R)} ==> (P, ~R/(NEW\==DEF) ==> Q)).

==> full_name(finin,'Tim Finin').

:- mpred_test(user_login(finin)).
:- mpred_test(host_name(finin,isMissing)).

==> host_name(finin,antares).

:- mpred_test(\+ host_name(finin,isMissing)).

user_login(finin).

:- mpred_test(\+ host_name(finin,isMissing)).
:- mpred_test(\+ full_name(finin,isMissing)).



==> full_name(robin,'Robin,McEntire').

==> host_name(fritzson,hamlet).

:- sanity(listing([full_name/2,host_name/2,user_login/1,user_name_host/3])).

:- mpred_test(host_name(robin,isMissing)).

==> host_name(robin,rmachine).

:- mpred_test(\+ host_name(robin,isMissing)).

==> ~host_name(robin,rmachine).

:- mpred_test(\+ host_name(robin,rmachine)).

:- mpred_test(host_name(robin,isMissing)).



meta_argtypes(idForTest(tBird,ftTerm)).


singleValuedInArgDefault(idForTest,2,isMissing).

tBird(iPeety).
*/
/*

:- mpred_test(idForTest(iPeety,isMissing)).


idForTest(iTweetyPie,foo1).

:- mpred_test(\+ idForTest(iTweetyPie,isMissing)).

:- mpred_test(idForTest(iTweetyPie,foo1)).


:- show_call(why,listing(idForTest)).

==> \+ idForTest(iTweetyPie,foo1).

:- mpred_test(idForTest(iTweetyPie,isMissing)).
:- mpred_test(\+ idForTest(iTweetyPie,foo1)).

:- show_call(why,listing(idForTest)).


*/

:- endif.


