% -*-Prolog-*-

:- use_module(library(logicmoo/logicmoo_user)).


% if we learn that someone has a full name, then we know they are a  'lmbase'.
full_name(U,_) ==>  'lmbase'(U).


% if we learn that someone has a host name, then we know they are a  'lmbase'.
host_name(U,_) ==>  'lmbase'(U).


% when we know a  'lmbase''s full name and host name, make a  'lmbase'/3 assertion.
 'lmbase'(User),
full_name(User,Name),
host_name(User,Host) 
  ==>
   'lmbase'(User,Name,Host).


% the default full_name for a  'lmbase' is 'unknown'.
 'lmbase'(User),
~full_name(User,X)/(X\==unknown)
  ==>
full_name(User,unknown).
  


% the default host_name for a  'lmbase' is 'unknown'. 

'lmbase'(User), ~host_name(User,X)/(X\==unknown)
  ==>
host_name(User,unknown).




==> full_name(finin,'Tim Finin').

==> host_name(finin,antares).

==> full_name(robin,'Robin,McEntire').

==> host_name(fritzson,hamlet).