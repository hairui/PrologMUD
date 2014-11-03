%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  read_line
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
%%%           :- read_line('input.txt', L).
%%%           input.txt> The sky was blue, after the rain.
%%%           L = [the, sky, was, blue, (','), after, the, rain, '.']
%%%
%%%           :- read_line('domain.pddl', L).
%%%           domain.pddl>
%%%           (define (domain BLOCKS)
%%%             (:requirements :strips :typing :action-costs)
%%%             (:types block)
%%%             (:predicates (on ?x - block ?y - block)


:- module(readFile2,_,_).
:- use_module(library(strings)).
:- use_module(library(lists)).
:- use_module(library(dec10_io)).



read_file(File, List) :- seeing(Old), see(File), read_line(List), seen, see(Old).


read_line(_Words) :- getct(C, _Type),
                    read_rest(C,_Words).
          

read_rest(-1,[]) :- !.


% Spaces, tabs and newlines between words are ignored.
read_rest(C,_Words) :- ( C=32 ; C=10 ; C=9 ; C=13 ; C=92 ) , !,
                     getct(C1, _Type),
                     read_rest(C1,_Words).

% Brackets, comma, period or question marks are treated as separed words
read_rest(C, [Char|_Words]) :- ( C=40 ; C=41 ; C=44 ; C=45 ; C=46 ; C=63 ; C=58 ) , name(Char, [C]), !,
			getct(C1, _Type),
			read_rest(C1, _Words).

% Read comments to the end of line
read_rest(59, Words) :- getct(Next, _Type), !, 
			      read_comment(Next, Last),
			      read_rest(Last, Words).

% Otherwise get all of the next word.
read_rest(C,[Word|Words]) :- read_word(C,Chars,Next),
                             name(Word,Chars),
                             read_rest(Next,Words).

% Space, comma, newline, period, end-of-file or question mark separate words
read_word(C,[],C) :- ( C=32 ; C=44 ; C=10 ; C=9 ; C=13 ;
                         C=46 ; C=63 ; C=40 ; C=41 ; C=58 ; C= -1 ) , !.

% Otherwise, get characters and convert to lower case.
read_word(C,[LC|Chars],Last) :- lower_case(C, LC),
				getct(Next, _Type),
                                read_word(Next,Chars,Last).

% Convert to lower case if necessary.
lower_case(C,C) :- ( C <  65 ; C > 90 ) , !.
lower_case(C,LC) :- LC is C + 32.


% Keep reading as long you dont find end-of-line or end-of-file
read_comment(10, 10) :- !.
read_comment(-1, -1) :- !.
read_comment(_, Last) :- getct(Next, _Type),
			 read_comment(Next, Last).

/* for reference ... 
newline(10).
comma(44).
space(32).
period(46).
question_mark(63).
*/

