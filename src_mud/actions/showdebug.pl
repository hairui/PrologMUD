% any.pl
% Dec 13, 2035
% Douglas Miles
%
% This file defines the basics of dmsg/show/hide

% :-swi_module(user). 
:-swi_module(showdebug, []).

:- include(logicmoo(vworld/moo_header)).

:-decl_type(vtOnOff).

mudIsa(vOn,vtOnOff).
mudIsa(vOff,vtOnOff).

user:hook_coerce(Text,vtOnOff,ON_OFF):-text_to_string(Text,FLAG),to_on_off(FLAG,vOn,vOff,ON_OFF).

t_f("vOn","vOff").
t_f("t","f").
t_f("true","false").
t_f("on","off").
t_f("1","0").
t_f("show","hide").
t_f("yes","no").
t_f("y","n").

to_on_off(FLAG,ON,OFF,ON_OFF):- t_f(_,FLAG) -> ON_OFF=OFF; ON_OFF=ON.

:-onEachLoad(do_gc).
do_gc:-statistics,do_gc0,do_gc0,statistics.
do_gc0:- current_prolog_flag(gc,GCWAS),set_prolog_flag(gc,true), garbage_collect, garbage_collect_atoms, set_prolog_flag(gc,GCWAS).
 
show_dmsg_values:- listing(tlbugger:dmsg_match/2),current_prolog_flag(opt_debug,ON_OFF),fmt(current_prolog_flag(opt_debug,ON_OFF)),debugging.

% dmsg/show/hide
action_info(actDMsg(isOptional(vtOnOff,isValueMissing)),"set the dmsg flag to on/off").
agent_call_command(_Agent,actDMsg(isValueMissing)):- !, show_dmsg_values.
agent_call_command(_Agent,actDMsg(ON_OFF)):- !, (ON_OFF==vOff->FLAG=false;FLAG=true),set_show_dmsg(FLAG).

set_show_dmsg(FLAG):- set_prolog_flag(debug,FLAG),set_bugger_flag(opt_debug,FLAG),fmt(current_prolog_flag(opt_debug,FLAG)).

action_info(actShow(isOptional(prolog,isValueMissing)),"show messages of col").
agent_call_command(_Agent,actShow(A)):-!, (A==isValueMissing -> (set_show_dmsg(true),show_dmsg_values) ; (bugger:dmsg_show(A),prolog_debug:debug(A))).

action_info(actHide(isOptional(prolog,isValueMissing)),"hide messages of col").
agent_call_command(_Agent,actHide(A)):-!, A==isValueMissing -> (set_show_dmsg(false),show_dmsg_values) ; (bugger:dmsg_hide(A),prolog_debug:nodebug(A)).

% ===========================================================
% DEBUG/NODEBUG command
% ===========================================================
verb_alias(debug,actShow).
verb_alias(nodebug,actHide).


:- include(logicmoo(vworld/moo_footer)).
