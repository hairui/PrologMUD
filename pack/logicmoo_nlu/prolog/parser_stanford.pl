% ===================================================================
% File 'parser_stanford.pl'
% Purpose: English to KIF conversions from SWI-Prolog  
% This implementation is incomplete
% Maintainer: Douglas Miles
% Contact: $Author: dmiles $@users.sourceforge.net ;
% Version: 'parser_stanford.pl' 1.0.0
% Revision:  $Revision: 1.3 $
% Revised At:   $Date: 2002/06/06 15:43:15 $
% ===================================================================

:-module(parser_stanford,[

         ]).

:-dynamic(tag_pos/2).
:-dynamic(tag_pos/3).
:-dynamic(get_pos_tagger/1).

% export all predicates in this file
export_preds_term_expansion(end_of_file):-!.
export_preds_term_expansion((MH:-_)):- !, export_preds_term_expansion((MH)).
export_preds_term_expansion((MH)):- strip_module(MH,M,H),
   functor(H,F,A),F\=(:-),M:export(F/A),!.

parser_stanford:term_expansion(HB,_):-export_preds_term_expansion(HB),fail.

atomic_subst(Before,Find,Replace,After):- atomic_list_concat(Atoms,Find,Before),atomic_list_concat(Atoms,Replace,After).

%:- setenv('CLASSPATH','/devel/PrologMUD/runtime/stanford-corenlp/*:/devel/PrologMUD/runtime/stanford-corenlp/classes:.').
%:- setenv('CLASSPATH','.:/opt/PrologMUD/runtime/stanford-parser-full-2014-08-27:/opt/PrologMUD/pack/stanford-parser-full-2014-08-27/stanford-postagger.jar:/opt/PrologMUD/runtime/stanford-parser-full-2014-08-27/stanford-srpser-2014-08-28-models.jar:/opt/PrologMUD/runtime/stanford-parser-full-2014-08-27/stanford-parser-3.4.1-models.jar:/opt/PrologMUD/runtime/stanford-parser-full-2014-08-27/stanford-parser.jar').

:- (prolog_load_context(directory,D),
  format(atom(Atom),'~w:~w/stanford-corenlp3.5.2-ALL.jar',[D,D]), 
  show_call(setenv('CLASSPATH',Atom))).

:- use_module(library(jpl)).
:- jpl_set_default_jvm_opts(['-Xmx5G']).

:-if(\+ current_predicate(must/1)).
% must(G):- G *-> true; (trace,G).
:-endif.

:-dynamic(pos_tagger/1).

get_pos_tagger(I):-pos_tagger(I)->true;(jpl_new(class([],['POSTaggerParser']),[],I),jpl_call(I,'init',[],@void),asserta(pos_tagger(I))).

call_pos_tagger(Call,Args,Out):- get_pos_tagger(I),jpl_call(I,Call,Args,Out).

unwrap_functor([],O,O).
unwrap_functor([F/A-Arg|Rest],I,O):-unwrap_functor_0(F/A,Arg,I,M),unwrap_functor(Rest,M,O).

unwrap_functor_0(F/A,Arg,I,M):-compound(I),functor(I,F,A),arg(Arg,I,M).
unwrap_functor_0(_,_,I,I).

% pos_tagger_test(Out),arg(3,Out,A).

s_to_sin(S,SIn):-
  string_to_atom(S,SIn),!.

s_to_sin(S,SIn):-
  string_to_atom(S,In),
   atomic_subst(In,' here, ',' here and is ',SIn0),
   atomic_subst(SIn0,'\'re ',' are ',SIn1),
   atomic_subst(SIn1,'n\'t ',' not ',SIn2),
   atomic_subst(SIn2,', ',' and ',SIn),!.

:-export(tag_pos/2).
tag_pos(S,OO):-tag_pos(S,OO,_).
tag_pos(S,OO,OO2) :- 
  s_to_sin(S,SIn),
  call_pos_tagger(tagPOS, [SIn],O),
   j_get(O,[f(1),j_to_term],Out),once(unwrap_functor(['ROOT'/1-1,'S'/1-1],Out,OO)),
   j_get(O,[f(0),j_to_term],Out2),once(unwrap_functor(['ROOT'/1-1,'S'/1-1],Out2,OO2)).

:-export(acetext_to_typedDependencies/2).
acetext_to_typedDependencies(S,OO) :- 
  s_to_sin(S,SIn),
  call_pos_tagger(tagPOS, [SIn],O),
   j_get(O,[+j_to_term],Out),once(unwrap_functor(['ROOT'/1-1,'S'/1-1],Out,OO)).

:-export(annotateSentence/2).
annotateSentence(S,OO) :- 
  s_to_sin(S,SIn),
  call_pos_tagger(annotateSentence, [SIn],O),
   j_get(O,[j_to_term],Out),once(unwrap_functor(['ROOT'/1-1,'S'/1-1],Out,OO)).

spall(S,a_t(A,B)) :- acetext_to_typedDependencies(S,B),annotateSentence(S,A),!.
spall(S):-spall(S,O),show_tree((S:-O)).

:- jpl_call('java.lang.System',getProperty,['java.specification.version'],O),dmsg(version(O)).
:-export(pos_tagger_test/1).
pos_tagger_test(Out) :- tag_pos('Lieutenant Worf is here, looking pretty mean.',Out),writeq(Out).
% pos_tagger_test(Out) :- acetext_to_typedDependencies('Lieutenant Worf is here, looking pretty mean.',Out),writeq(Out).
pos_tagger_test(Out) :- spall('The strongest rain ever recorded in India shut down the financial hub of Mumbai, snapped communication lines, closed airports and forced thousands of people to sleep in their offices or walk home during the night, officials said today.',Out),
  portray_clause(c:-Out).

% pos_tagger_test :- call_pos_tagger(tagPOS(class([java,lang],['String'])), ["The check is in your mouth. "],Out),writeq(Out).



j_get_l(E,I,O):-must(j_get(I,E,O)),!.

j_is_term(I,T):- ground(T),!,must(jpl_type_to_class(T,SC)),jpl_call(SC,isInstance,[I],IS),IS='@'(true).
j_is_term(I,T):- jpl_call(I,getClass,[],C),j_subclasses(C,TT),jpl_class_to_type(TT,Type),T=Type,!.

j_subclasses(C,C).
j_subclasses(C,TO):-jpl_call(C,getSuperclass,[],T),j_subclasses(T,TO).
j_subclasses(C,TE):-jpl_call(C,getInterfaces,[],T),jpl_array_to_list(T,L),member(E,L),j_subclasses(E,TE).


j_to_term_until_done(I,O):- j_to_term(I, M),(I\=@=M -> j_to_term_until_done(M, O) ; M=O).

j_to_term(I, O):- var(I),!,must(I=O).
j_to_term(I, O):- is_list(I),!,must(maplist(j_to_term,I,O)).
j_to_term(I, O):- jpl_is_object(I),!,must(jo_to_term(I, O)).
j_to_term(I, O):- compound(I),I=..[F|IA],!,must((maplist(j_to_term,IA,OA),O=..[F|OA])).
j_to_term(I, O):- must(I=O).


jo_to_term(I,OO):- jconvert(T,How),j_is_term(I,T),!,must(j_get(I,How,O)),j_to_term(O,OO).
jo_to_term(I, O):- catch(jpl_enumeration_to_list(I,M),_,fail),!,j_to_term(M,O).
jo_to_term(I, O):- catch(jpl_array_to_list(I,M),_,fail),!,j_to_term(M,O).
jo_to_term(I, O):- catch(jpl_map_element(I,M),_,fail),!,j_to_term(M,O).
jo_to_term(I, O):- jpl_is_object(I),j_get(I,[getClass,isEnum],T),jpl_is_true(T),!,must(j_get(I,[toString],O)).
jo_to_term(I, O):- jpl_is_object(I),j_get(I,pa(obj,[m(getClass,[]),jo_to_term],m(toString,[])),O).
jo_to_term(I, O):- jpl_is_object(I),must(j_get(I,[toString],O)).
jo_to_term(IO,IO):-!.

jconvert(class([edu, stanford, nlp, util], ['IntTuple']),pa('IntTuple',elems)).
jconvert(class([edu, stanford, nlp, trees], ['UniversalEnglishGrammaticalStructure']),term(ugs)).
jconvert(class([edu,stanford,nlp,semgraph],['SemanticGraph']),pa(sg,typedDependencies)).
jconvert(class([edu,stanford,nlp,dcoref],['CorefChain','CorefMention']),+ pa('CorefMention',-mentionSpan,-headIndex,-corefClusterID,-position, + animacy,+ gender,+ number,+ mentionType)).
jconvert(class([edu,stanford,nlp,dcoref],['CorefChain']),pa('CorefChain', - getRepresentativeMention,- getMentionsInTextualOrder)).
jconvert(class([java,lang],['String']),[toString,revcall(string_to_atom)]).
jconvert(class([edu,stanford,nlp,ling],['CoreLabel']),pa(twin,m(tag,[]),m(word,[]),m(index,[]),m(ner,[]))).
jconvert(class([edu,stanford,nlp,ling],['IndexedWord']),pa(wi,m(tag,[]),m(word,[]),m(index,[]))).
jconvert(class([edu,stanford,nlp,ling],['TaggedWord']),fa(m(tag,[]),m(word,[]))).
jconvert(array(class([java,lang],['Object'])),[call(jpl_array_to_list)]).
jconvert(class([edu,stanford,nlp,trees],['Tree']),pl([label,toString],[children,call(jpl_array_to_list)],[call(j_to_term)])).
jconvert(class([edu,stanford,nlp,trees],['TypedDependency']),fa([m(reln,[]),getShortName],m(gov,[]),m(dep,[]))).
jconvert(class([java,util],['Map']),[entrySet]).
jconvert(class([java,util],['Map','Entry']),[pa(kv,+getKey,+getValue)]).
jconvert(class([java,util],['List']),[toArray,+call(jpl_array_to_list)]).
jconvert(class([java,lang],['Class']),[call(jpl_class_to_type)]).
jconvert(class([java,lang],['Integer']),[m(intValue)]).
jconvert(class([java,util],['Collection']),[toArray,+call(jpl_array_to_list)]).


:-export(j_get/3).
j_get(IO,[],IO):-!.
j_get(I,-(E),(E=O)):-!,must((j_get(I,E,M),j_to_term_until_done(M,O))).
j_get(I,+(E),O):-!,must((j_get(I,E,M),j_to_term_until_done(M,O))).
j_get(I,+,O):-!,must(j_to_term_until_done(I,O)).
j_get(I,[E|L],O):-!,must((j_get(I,E,M),j_get(M,L,O))),!.
j_get(I,E,O):- compound(E),compound_name_arguments(E,fa,Args),!,must((maplist(j_get(I),Args,ArgsO),O=..ArgsO)).
j_get(I,E,O):- compound(E),compound_name_arguments(E,pa,[F|Args]),!,must((maplist(j_get(I),Args,ArgsO),O=..[F|ArgsO])).
j_get(I,pl(FunctorGet,ArgsGet,ArgFormat),O):- !, must(j_get(I,FunctorGet,Atom)),must(j_get(I,ArgsGet,List)),must(maplist(j_get_l(ArgFormat),List,ListO)),O=..[Atom|ListO],!.
j_get(I,N,O):- number(N),is_list(I),nth0(N,I,O).
j_get(I,f(E),O):- jpl_get(I,E,O),!.
j_get(_,term(E),E):-!.
j_get(I,p2s,O):- pterm_to_sterm(I,O),!.
j_get(I,maplist(F),O):- must(is_list(I)),maplist(j_get_l(F),I,O),!.
j_get(I,maptree(F),O):- must(maptree(j_get_l(F),I,O)),!.
j_get(I,Compound,O):- compound(Compound),functor(Compound,lambda,_),call(Compound,I,O),!.
j_get(I,m(N),O):- jpl_call(I,N,[],O),!.
j_get(I,m(N,Args),O):- jpl_call(I,N,Args,O),!.
j_get(I,call(C),O):-!, must(call(C,I,O)),!.
j_get(I,show_call(C),O):-!, show_call(j_get(I,C,O)).
j_get(I,revcall(C),O):-!, must(call(C,O,I)),!.
j_get(I,E,O):- compound(E),compound_name_arguments(E,N,Args),catch(jpl_call(I,N,Args,O),_,fail),!.
j_get(I,j_to_term,O):- must(j_to_term(I,O)),!.
j_get(I,E,O):- catch(jpl_get(I,E,O),_,fail),!.
j_get(I,E,O):- catch(jpl_call(I,E,[],O),_,fail),!.
j_get(I,E,O):- catch(jpl_call(I,get,[E],O),_,fail),!.
j_get(I,E,O):- catch(jpl_call(I,getValue,[E],O),_,fail),!.
j_get(I,E,O):- catch(jpl_call(I,E,[I],O),_,fail),!.
j_get(I,E,O):- catch(call(E,I,O),_,fail),!.

% j_get(O,[f(0),children,jpl_array_to_list,0,children,jpl_array_to_list],E).

to_string(I):-jpl_get(class([java,lang],['System']),'out',Out),jpl_call(Out,println,[I],_).
% :- pos_tagger_test.

:- op(400,xfy,((&))).
:- op(400,xfy,((v))).

install_example(List):-is_list(List),!,maplist(install_example,List).
install_example(N=List):-is_list(List),!,maplist(add_example_value(N),List).
install_example(NList):-dmsg(warn(failed_install_example(NList))),!.

:-dynamic(is_example_value/2).

:-export(add_example_value/2).
add_example_value(N,V):-assert_if_new(is_example_value(N,V)).

:- install_example([
             sentences=[[^, 'All', persons, are, happy, '.']],
             sentencesToParse=[[^, 'All', persons, are, happy, '.']],
             syntaxTrees=[[specification, [s, [np, [det, all], [nbar, [n, persons]]], [vp, [], [aux, are, []], [ap_coord, [ap, [adj, happy]]], []]], '.']],
             drs0=[drs([], [ (drs([PERSON_OBJ], [object(PERSON_OBJ, person, countable, na, eq, 1)-1/2])=>drs([HAPPY_REL, A], [property(HAPPY_REL, happy, POS)-1/4, predicate(A, be, PERSON_OBJ, HAPPY_REL)-1/3]))]), drs([], [ (drs([PERSON_OBJ], [object(PERSON_OBJ, person, countable, na, eq, 1)-1/2])=>drs([HAPPY_REL, A], [property(HAPPY_REL, happy, POS)-1/4, predicate(A, be, PERSON_OBJ, HAPPY_REL)-1/3]))]), drs([], [ (drs([PERSON_OBJ], [object(PERSON_OBJ, person, countable, na, eq, 1)-1/2])=>drs([HAPPY_REL, A], [property(HAPPY_REL, happy, POS)-1/4, predicate(A, be, PERSON_OBJ, HAPPY_REL)-1/3]))])],
             tokens=[['All', persons, are, happy, '.']],
             paraphrase=[['If there is a person X1 then the person X1 is happy.']],
             drs=[drs([], [ (drs([PERSON_OBJ], [object(PERSON_OBJ, person, countable, na, eq, 1)-1/2])=>drs([HAPPY_REL, A], [property(HAPPY_REL, happy, POS)-1/4, predicate(A, be, PERSON_OBJ, HAPPY_REL)-1/3]))])],
             sdrs=[ ([object(PERSON_OBJ, person, countable, na, eq, 1)-1/2]=>[property(HAPPY_REL, happy, POS)-1/4, predicate(A, be, PERSON_OBJ, HAPPY_REL)-1/3])],
             fol=[forall(PERSON_OBJ, exists(HAPPY_PROP, exists(BE_EVENT, - (object(BE_FRAME, PERSON_OBJ, person, countable, na, eq, 1)-1/2)v (property(BE_FRAME, HAPPY_PROP, happy, POS)-1/4)& (predicate(BE_FRAME, BE_EVENT, be, PERSON_OBJ, HAPPY_PROP)-1/3)))), forall(PERSON_OBJ, exists(HAPPY_PROP, exists(BE_EVENT, - (object(BE_FRAME, PERSON_OBJ, person, countable, na, eq, 1)-1/2)v (property(BE_FRAME, HAPPY_PROP, happy, POS)-1/4)& (predicate(BE_FRAME, BE_EVENT, be, PERSON_OBJ, HAPPY_PROP)-1/3))))],
             pnf=[forall(PERSON_OBJ, (object(BE_FRAME, PERSON_OBJ, person, countable, na, eq, 1)-1/2=>exists(HAPPY_PROP, exists(BE_EVENT, (property(BE_FRAME, HAPPY_PROP, happy, POS)-1/4)& (predicate(BE_FRAME, BE_EVENT, be, PERSON_OBJ, HAPPY_PROP)-1/3))))), forall(PERSON_OBJ, (object(BE_FRAME, PERSON_OBJ, person, countable, na, eq, 1)-1/2=>exists(HAPPY_PROP, exists(BE_EVENT, (property(BE_FRAME, HAPPY_PROP, happy, POS)-1/4)& (predicate(BE_FRAME, BE_EVENT, be, PERSON_OBJ, HAPPY_PROP)-1/3)))))],
             kif(p)=[all(PERSON_OBJ, implies(tPerson(PERSON_OBJ), exists(HAPPY_PROP, exists(BE_EVENT, (vHappy(HAPPY_PROP), mudBe(PERSON_OBJ, HAPPY_PROP)))))), all(PERSON_OBJ, implies(tPerson(PERSON_OBJ), exists(HAPPY_PROP, exists(BE_EVENT, (vHappy(HAPPY_PROP), mudBe(PERSON_OBJ, HAPPY_PROP))))))],
             kif(f)=[all(PERSON_OBJ, exists(HAPPY_PROP, exists(BE_EVENT, (-tPerson(PERSON_OBJ);vHappy(HAPPY_PROP), mudBe(PERSON_OBJ, HAPPY_PROP))))), all(PERSON_OBJ, exists(HAPPY_PROP, exists(BE_EVENT, (-tPerson(PERSON_OBJ);vHappy(HAPPY_PROP), mudBe(PERSON_OBJ, HAPPY_PROP)))))],
             kif(d)=[implies(exists([PERSON_OBJ], tPerson(PERSON_OBJ)), exists([HAPPY_REL, A], (vHappy(HAPPY_REL), mudBe(PERSON_OBJ, HAPPY_REL)))), implies(exists([PERSON_OBJ], tPerson(PERSON_OBJ)), exists([HAPPY_REL, A], (vHappy(HAPPY_REL), mudBe(PERSON_OBJ, HAPPY_REL))))],
             kif(s)=[implies([tPerson(PERSON_OBJ)], [vHappy(HAPPY_REL), mudBe(PERSON_OBJ, HAPPY_REL)]), implies([tPerson(PERSON_OBJ)], [vHappy(HAPPY_REL), mudBe(PERSON_OBJ, HAPPY_REL)])]
           ]).


:- add_example_value(stanfordTree,
  [ 'S',['NP', ['PRP', 'I-1']],[ 'VP',['VBD', 'had-2'],['ADVP', ['RB', 'never-3']],[ 'VP',['VBN', 'seen-4'],['NP', ['NN', 'something-5']],[ 'PP',['IN', 'like-6'],[ 'NP',['NP', ['DT', 'that-7']],['PP', ['IN', 'in-8'], ['NP', ['DT', 'any-9'], ['NN', 'language-10']]]]]]],['.', '.-11']]).

:- add_example_value(stanfordTree,
 [ 'FRAG', ['NP', ['NN', 'ok-1']],[',', ',-2'],[ 'SBAR',['IN', 'so-3'],[ 'S',['NP', ['PRP', 'you-4']],[ 'VP',['VBP', 'want-5'],[ 'NP',['NP', ['DT', 'a-6'], ['JJ', 'concrete-7'], ['NN', 'example-8']],[',', ',-9'],['RB', 'not-10'],['NP', ['DT', 'a-11'], ['JJ', 'general-12'], ['NN', 'rule-13']]]]]],['.', '?-14']]).


% ===================================================================

/*
TODO  FIX THE CONVERTERS!
:- install_converter(parser_stanford:acetext_to_typedDependencies(+acetext, -typedDependencies)).
:- install_converter(parser_stanford:typedDependencies_to_w2pos(+typedDependencies, -w2pos)).
:- install_converter(parser_stanford:acetext_to_w2pos(+acetext, -w2pos)).
:- install_converter(parser_stanford:w2pos_to_aacetext_w_pos(+w2pos, -acetext_w_pos)).

:- install_converter(parser_stanford:acetext_to_stanfordTree(+acetext, -stanfordTree)).
:- install_converter(parser_stanford:typedDependencies_to_stanfordTree(+acetext_to_typedDependencies, -stanfordTree)).
*/

show_tree(H:-Tree):- !, nl,portray_clause((H:-Tree)),nl.
show_tree(Tree):-nl,portray_clause((t1:-Tree)),nl.

tc0:- acetext_to_stanfordTree('OK, so you want a concrete example, not a general rule?',Tree),show_tree(Tree).
tc1:- acetext_to_stanfordTree('I had never seen something like that in any language.',Tree),show_tree(Tree).
tc2:- acetext_to_stanfordTree('Can the can do the Can Can dance?',Tree),show_tree(Tree).

% ===================================================================
% 


:-export(acetext_to_w2pos/2).
acetext_to_w2pos(I,O):-acetext_to_typedDependencies(I,M),typedDependencies_to_w2pos(M,O).

% JJ = penn tag
% jj = brill tag
% 'Gradable-Adjective' -->  'JJR'
pos_penn_pos(POS,PennPOS):- flatten([POS],POSL),
  pos_penn_pos0(POSL,PennPOS),
  list_to_set([open, wordnum(-1)|POSL],[open, wordnum(-1)|SET]),
  pos_penn_pos0(SET,PennPOS).

pos_penn_pos0([],open).
pos_penn_pos0(POSL,PennPOS):-
  must((member(PennPOS,POSL),
        atom(PennPOS),
        downcase_atom(PennPOS,UPOS), PennPOS=UPOS)),is_word_tag(PennPOS),
        must(is_penn(PennPOS)).

% The/DT quick/JJ brown/JJ fox/NN jumped/VBD over/IN the/DT lazy/JJ dog/NN ./.
% w(pretty,['Adjective','Gradable-Adjective'])  -->  'pretty/JJR'
% w(pretty,['Adjective'])  -->  'pretty/JJ' 


% pennTagString,'EX-PennTag','EX', 
w2_to_pos_slash_word(Text,open,Text):-!.
w2_to_pos_slash_word(Text,POS,Atom):-
 get_word_from_hyphen(Text,W,_),
 pos_penn_pos(POS,PennPOS),must(atom(PennPOS)),
 ( PennPOS==open -> Atom = W ; format(atom(Atom),'~w/~w',[W,PennPOS]) ).

is_phrase_tag(PM):- ( \+ atom(PM) ),!,fail.
is_phrase_tag(PM):- arg(_,v('VP','S','NBAR','SBAR','NP','VP','ADJP'),PM),!.
is_phrase_tag(PM):- upcase_atom(PM,UC),!, \+ is_word_tag(UC).

is_word_tag(WM):- atom(WM),bposToCPos(WM,DEF), is_variant_case(DEF),!.
%TODO is_word_tag(PM):- upcase_atom(PM,UC),!, \+ is_phrase_tag(UC).

% jj = brill tag
is_brill_word_tag(WM):- atom(WM), downcase_atom(WM,UWM), WM==UWM, bposToCPos(WM,DEF), WM\=DEF, is_variant_case(DEF),!.
% JJ = penn tag
is_penn_word_tag(WM):- is_penn(WM),
    must((atom(WM),upcase_atom(WM,UWM), WM==UWM, bposToCPos(WM,DEF), WM\=DEF, is_variant_case(DEF))),!.


is_variant_case(DEF):- atom(DEF), (upcase_atom(DEF,OC);downcase_atom(DEF,OC)),DEF\=OC.

w2pos_to_aacetext_w_pos(w(Text,POS),Atom):- w2_to_pos_slash_word(Text,POS,Atom).
w2pos_to_aacetext_w_pos([POS,Text],Atom):-  is_phrase_tag(POS),atom(Text), !, w2_to_pos_slash_word(Text,POS,Atom).
w2pos_to_aacetext_w_pos(W2List,Atom):-is_list(W2List),
    maplist(w2pos_to_aacetext_w_pos,W2List,AtomS),concat_atom(AtomS,' ',Atom).
w2pos_to_aacetext_w_pos(Atom,Atom).

:-export(typedDependencies_to_w2pos/2).
typedDependencies_to_w2pos(I,O):-  must(j_get(I,[0,p2s,
  maplist(call(w_to_w2))],M)),!,
  must(maplist(w2stanford_to_w2cyc,M,O)).

:-export(typedDependencies_to_stanfordTree/2).
typedDependencies_to_stanfordTree(I,O):- j_get(I,[1,p2s,
  (maptree(call(simplified_tree_element)))],O).

stanfordTree_to_syntaxTrees(I,O):- transform_language(lang_stanfordTree_to_syntaxTrees,I,O).
% :- add_example_value(stanfordTree , ['ROOT'('S'('NP'('DT'('All-1'),'NNS'('persons-2')),'VP'('VBP'('are-3'), 'ADJP'('JJ'('happy-4'))),'.'('.-5')))]).
% -> wordParseTree = 'S'('NP'('DT'('All-1'),'NNS'('persons-2')),'VP'('aux'('are-3'),           'ADJP'('JJ'('happy-4')))
% syntaxTrees=[[specification, [s, [np, [det, all], [nbar, [n, persons]]], [vp, [], [aux, are, []], [ap_coord, [ap, [adj, happy]]], []]], '.']],
% -> wordParseTree = [s, [np, [det, all], [nbar, [n, persons]]], [vp, [aux, are, []], [ap_coord, [ap,  [adj, happy]]], []]]


 is_penn('CC'). %  Coordinating conjunction 
 is_penn('CD'). %  Cardinal number 
 is_penn('DT'). %  Determiner 
 is_penn('EX'). %  Existential there 
 is_penn('FW'). %  Foreign word 
 is_penn('IN'). %  Preposition or subordinating conjunction 
 is_penn('JJ'). %  Adjective 
 is_penn('JJR'). %  Adjective, comparative 
 is_penn('JJS'). %  Adjective, superlative 
 is_penn('LS'). %  List item marker 
 is_penn('MD'). %  Modal 
 is_penn('NN'). %  Noun, singular or mass 
 is_penn('NNP'). %  Proper noun, singular 
 is_penn('NNPS'). %  Proper noun, plural 
 is_penn('NNS'). %  Noun, plural 
 is_penn('PDT'). %  Predeterminer 
 is_penn('POS'). %  Possessive ending 
 is_penn('PRP$'). %  Possessive pronoun 
 is_penn('PRP'). %  Personal pronoun 
 is_penn('RB'). %  Adverb 
 is_penn('RBR'). %  Adverb, comparative 
 is_penn('RBS'). %  Adverb, superlative 
 is_penn('RP'). %  Particle 
 is_penn('SYM'). %  Symbol 
 is_penn('TO'). %  to 
 is_penn('UH'). %  Interjection 
 is_penn('VB'). %  Verb, base form 
 is_penn('VBD'). %  Verb, past tense 
 is_penn('VBG'). %  Verb, gerund or present participle 
 is_penn('VBN'). %  Verb, past participle 
 is_penn('VBP'). %  Verb, non-3rd person singular present 
 is_penn('VBZ'). %  Verb, 3rd person singular present 
 is_penn('WDT'). %  Wh-determiner 
 is_penn('WP$'). %  Possessive wh-pronoun 
 is_penn('WP'). %  Wh-pronoun 
 is_penn('WRB'). %  Wh-adverb

is_node_unwrappable('ROOT').
is_node_unwrappable('NBAR').
is_node_unwrappable('specification').

is_node_unlistifiable('ROOT').
is_node_unlistifiable('nbar').
%is_node_unlistifiable('specification').

:-maptree(rec_lambda:lambda(I,O,(atom(I),upcase_atom(I,O))),a(b),X),assertion(X='A'('B')).


simplified_tree_element(w(Text,POS),O):- !,
  must(w2stanford_to_w2cyc(w(Text,POS),O)),!.
simplified_tree_element([POS,Text],O):- is_word_tag(POS),!,
  must(w2stanford_to_w2cyc(w(Text,POS),O)),!.
simplified_tree_element([ROOT,LIST],O):- is_node_unwrappable(ROOT), !,
  must(simplified_tree_element_or_pass(LIST,O)),!.
simplified_tree_element([ROOT,LIST],O):- is_node_unlistifiable(ROOT), !,
  simplified_tree_element_or_pass(LIST,O),!.
simplified_tree_element([ROOT|LIST],valueWithComment(O,warn(ROOT))):- is_node_unwrappable(ROOT), !,
  simplified_tree_element_or_pass(LIST,O),!.

simplified_tree_element_or_pass(I , O):-simplified_tree_element(I,O),!.
simplified_tree_element_or_pass(IO,IO).

:-export(acetext_to_w2pos/2).
acetext_to_stanfordTree(I,O):-acetext_to_typedDependencies(I,M),
  typedDependencies_to_stanfordTree(M,O).

:-export(w2stanford_to_w2cyc/2).
w2stanford_to_w2cyc(I,O):-  must(I = w(_,_)), copy_term(I,O),
  arg(1,I,WWP),get_word_from_hyphen(WWP,W,N),
  arg(2,I,SPOS),
  findall(E,bposToCPos(SPOS,E),List),
  list_to_set([SPOS,wordnum(N)|List],Set),
  nb_setarg(1,O,W),
  nb_setarg(2,O,Set),!.


%'All-1' => 'All'
%'persons-2' => 'persons'
:-export(get_word_from_hyphen/3).
get_word_from_hyphen(SP,W,1):-atom_concat(W,'-1',SP),!.
get_word_from_hyphen(SP,W,2):-atom_concat(W,'-2',SP),!.
get_word_from_hyphen(SP,W,Num):-concat_atom([W,N],'-',SP),atom_number(N,Num),!.
get_word_from_hyphen(SP,W,Num):-concat_atom([W1,W2,N],'-',SP),atom_number(N,Num),!,concat_atom([W1,W2],'-',W).
get_word_from_hyphen(SP,W,Num):-concat_atom(List,'-',SP),reverse(List,[N|Rev]),atom_number(N,Num),!,
   reverse(Rev,UnRev),concat_atom(UnRev,'-',W).
get_word_from_hyphen(W,W,-1).


% syntaxTrees=[[specification, [s, [np, [det, all], [nbar, [n, persons]]], [vp, [], [aux, are, []], [ap_coord, [ap, [adj, happy]]], []]], '.']],


:-if(\+ current_predicate(isSlot/1)).
isSlot(Var):-var(Var),!.
isSlot('$VAR'(Var)):-number(Var).
:-endif.

:-if(\+ current_predicate(pterm_to_sterm/2)).
pterm_to_sterm(VAR,VAR):-isNonCompound(VAR),!.
pterm_to_sterm([X|L],[Y|Ls]):-!,pterm_to_sterm(X,Y),pterm_to_sterm(L,Ls),!.
pterm_to_sterm(X,Y):-compound(X),X=..L,pterm_to_sterm(L,Y),!.
pterm_to_sterm(X,X).

:-endif.



end_of_file.

1.	CC	Coordinating conjunction
2.	CD	Cardinal number
3.	DT	Determiner
4.	EX	Existential there
5.	FW	Foreign word
6.	IN	Preposition or subordinating conjunction
7.	JJ	Adjective
8.	JJR	Adjective, comparative
9.	JJS	Adjective, superlative
10.	LS	List item marker
11.	MD	Modal
12.	NN	Noun, singular or mass
13.	NNS	Noun, plural
14.	NNP	Proper noun, singular
15.	NNPS	Proper noun, plural
16.	PDT	Predeterminer
17.	POS	Possessive ending
18.	PRP	Personal pronoun
19.	PRP$	Possessive pronoun
20.	RB	Adverb
21.	RBR	Adverb, comparative
22.	RBS	Adverb, superlative
23.	RP	Particle
24.	SYM	Symbol
25.	TO	to
26.	UH	Interjection
27.	VB	Verb, base form
28.	VBD	Verb, past tense
29.	VBG	Verb, gerund or present participle
30.	VBN	Verb, past participle
31.	VBP	Verb, non-3rd person singular present
32.	VBZ	Verb, 3rd person singular present
33.	WDT	Wh-determiner
34.	WP	Wh-pronoun
35.	WP$	Possessive wh-pronoun
36.	WRB	Wh-adverb