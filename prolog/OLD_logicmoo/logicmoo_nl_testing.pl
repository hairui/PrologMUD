
%verb_expression(Time,Subj,Obj,Event,CycL) --> theWord('Be-TheWord'),noun_phrase(Event,Obj,EventProp,CycL).


testE2C:-tell(testE2C),runtests,told.

startE2CTest(_).
testE2C(_,X):-dmsg(X),fail.
testE2C(_,parse(X)):-!,testE2C(_,X).
testE2C(_,[*|X]):-!,testE2C(_,X).
testE2C(_,X):-notrace(ignore(catch(e2c(X),_,fail))). 
                              





%'nonCompositionalVerbSemTrans'('End-TheWord', 'Agreement', ['and', ['isa', ':ACTION', 'EndingAnAgreement'], ['performedBy', ':ACTION', ':SUBJECT'], ['objectActedOn', ':ACTION', ':OBJECT']]).

%'lightVerb-TransitiveSemTrans'('Do-TheWord', 'CommercialActivity', ['and', ['isa', ':ACTION', 'CommercialActivity'], ['performedBy', ':ACTION', ':SUBJECT']]).
%'multiWordStringDenotesArgInReln'([service], 'Provide-TheWord', 'AgentiveNoun', 'providerOfService', 2).
%'nounSemTrans'('Hire-TheWord', 0, 'RegularNounFrame', ['and', ['isa', '?HIRE', 'EmployeeHiring'], ['objectActedOn', '?HIRE', ':NOUN']]).
%'multiWordStringDenotesArgInReln'([service], 'Provide-TheWord', 'AgentiveNoun', 'providerOfService', 2).
%'headMedialString'([intended], 'Recipient-TheWord', [of, communication], 'SimpleNoun', 'communicationTarget').
%'agentiveNounSemTrans'('Emit-TheWord', 0, 'RegularNounFrame', ['emitter', '?X', ':NOUN']).
%'adjSemTrans'('Cloud-TheWord', 0, 'RegularAdjFrame', ['weather', ':NOUN', 'Cloudy']).
%'relationIndicators'('abbreviationForMultiWordString', 'Form-TheWord', 'Verb').
%'genNatTerm-compoundString'('TransportViaFn', 'Transport-TheWord', [via], 'MassNoun', 'singular').
%'genTemplate'('transferredThing', ['ConcatenatePhrasesFn', ['TermParaphraseFn-NP', ':ARG2'], ['BestHeadVerbForInitialSubjectFn', 'Be-TheWord'], ['BestNLPhraseOfStringFn', 'transferred in'], ['TermParaphraseFn-NP', ':ARG1']]).
%'lightVerb-TransitiveSemTrans'('Do-TheWord', 'CommercialActivity', ['and', ['isa', ':ACTION', 'CommercialActivity'], ['performedBy', ':ACTION', ':SUBJECT']]).
%'genTemplate-Constrained'('isa', ['quotedCollection', ':ARG2'], ['NPIsNP-NLSentenceFn', ['BestCycLPhraseFn', ':ARG1'], ['BestDetNbarFn-Indefinite', ['TermParaphraseFn', ':ARG2']]]).

    /*

% ============================================================================
% posMeans
% ============================================================================

posMeans(Phrase,Pos,Form,CycL):-
      posm_cached,!,posm_cached(Phrase,Pos,Form,CycL).

:-index(posm_cached(1,1,1,1)).

posMeans(Phrase,Pos,Form,CycL):-
      cache_the_posm,
      asserta(posm_cached),
      posMeans(Phrase,Pos,Form,CycL).



cache_the_posm:-
      posm_c(Phrase,Pos,Form,CycL),
      asserta_if_new(posm_cached(Phrase,Pos,Form,CycL)),%write(.),flush,
      %fmt('~q~n',[posm_cached(CycWord,Phrase,Pos,Form,CycL)]),
      fail.
   
cache_the_posm.



% ============================================================================
% General Parts Of Speech and Meanings
% ============================================================================

'multiWordString'([health, care], 'Organize-TheWord', 'SimpleNoun', 'MedicalCareOrganization').
posm_c(Phrase,Pos,Form,CycL):-'multiWordString'(Words, CycWord, Pos, CycL),
	 pos(CycWord,Eng,_POS,Form),append(Words,Eng,Phrase).

'genPhrase'('MedicalCareProvider', 'AgentiveNoun', 'agentive-Sg', [health, care, provider]).
posm_c(Phrase,Pos,Form,CycL):-'genPhrase'(CycL, Pos,Form, Phrase).

'headMedialString'([dimensionless], 'Unit-TheWord', [of, measure], 'SimpleNoun', 'DimensionlessUnitOfMeasure').
posm_c(Phrase,Pos,Form,CycL):-'headMedialString'(WordsBef,CycWord,WordsAft,Pos, CycL),
	 pos(CycWord,Eng,_POS,Form),append(WordsBef,Eng,PhrasingLeft),append(PhrasingLeft,WordsAft,Phrase).

'compoundString'('Movement-TheWord', [of, fluid], 'MassNoun', 'FluidFlowEvent').
posm_c(Phrase,Pos,Form,CycL):-'compoundString'(CycWord,Words,Pos, CycL),
	 pos(CycWord,Eng,_POS,Form),append(Eng,Words,Phrase).

'prepCollocation'('Beset-TheWord', 'Adjective', 'By-TheWord').      
posm_c(Phrase,Pos,Form2,'PrepCollocationFn'(CycWord1,Pos,CycWord2)):-'prepCollocation'(CycWord1,Pos, CycWord2),
	 pos(CycWord1,Eng1,_POS,Form1),pos(CycWord2,Eng2,_POS,Form2),append(Eng1,Eng2,Phrase).


%TODO 'abbreviationForString'([scatology], [scat]).  'abbreviationForMultiWordString'([political], 'Science-TheWord', 'massNumber', [poli, sci]).
%'abbreviationForLexicalWord'('Kilogram-TheWord', 'singular', [kg]).


%'initialismString'('CodeOfConduct', [coc]).
posm_c(Term,'SimpleNoun',normal,Proper) :- 
      'initialismString'(Proper,Term);
      'formerName'(Proper, Term);
      'scientificName'(Proper, Term);
      'termStrings-GuessedFromName'(Proper, Term);
      'nameString'(Proper, Term).

%'abbreviationString-PN'('India', ['IND']).
posm_c(Term,'ProperNoun',normal,Proper) :- 
      'initialismString'('CodeOfConduct',Term);
      'abbreviationString-PN'(Proper, Term);
      'preferredNameString'(Proper, Term);      
      'countryName-LongForm'(Proper, Term);
      'countryName-ShortForm'(Proper, Term).

posm_c(Eng,Pos,Form,CycL):-
	 pos(CycWord,Eng,Pos,Form),
	 posm_build(CycWord,Eng,Pos,Form,CycL).

% posm_c(Eng,Pos,Form,CycL):-posTT(CycWord,Eng,Pos,Form),'TTPred-denotation'(CycWord, Pos, _, CycL).


%'denotation'('Capacity-TheWord', 'SimpleNoun', 0, 'Volume').
posm_build(CycWord,Eng,Pos,Form,CycL):-'denotation'(CycWord, Pos, _, CycL).

%'preferredGenUnit'('on-Physical', 'Preposition-Directional-Telic', 'On-TheWord').
posm_build(CycWord,Eng,Pos,Form,CycL):-'preferredGenUnit'(CycL, Pos, CycWord).

%'denotationRelatedTo'('Can-TheWord', 'Verb', 0, 'PreservingFood').
%posm_build(CycWord,Eng,Pos,Form,'DenotationRelatedToFn'(CycL)):-'denotationRelatedTo'(CycWord, Pos, _, CycL).
posm_build(CycWord,Eng,Pos,Form,(CycL)):-'denotationRelatedTo'(CycWord, Pos, _, CycL).

posm_build(CycWord,Eng,Pos,Form,meaningOfWord(CycWord)):-
   not('denotation'(CycWord, _, _, CycL)),
   not('denotationRelatedTo'(CycWord, _, _, CycL)),
   not('preferredGenUnit'(CycL, _, CycWord)).
   
%'relationIndicators'('catalyst', 'Catalyst-TheWord', 'Verb').


%dmiles pos(CycWord,Phrase,Pos,Form):-'lex'(Form, CycWord, Phrase),'lexMap'(PosForms, CycWord, Pos).
%dmilespos(CycWord,Phrase,Pos,_) :- 'getPos'(CycWord,Pos, Phrase).
%'abbreviationForLexicalWord'('Kilogram-TheWord', 'singular', [kg])
%dmilespos(CycWord,Phrase,Pos,_) :- 'abbreviationForLexicalWord'(CycWord,Pos, Phrase).


% 'prepCollocation'('Beset-TheWord', 'Adjective', 'By-TheWord').
%dmiles posTT(CycWord,Phrase,Pos,Form:PosForms):-'TT-lex'(Form, CycWord, Phrase),not('lex'(_, _, Phrase)),  'TT-lexMap'(PosForms, CycWord, Pos).

%'termStrings-GuessedFromName'('GenlsFormat', 'Genls Format').
%   'nounPrep'('Offspring-TheWord', 'Of-TheWord', ['children', ':NOUN', ':OBLIQUE-OBJECT']),



%:-at_initialization(convertCycKb).
:-dynamic(posm_cached).
:-dynamic(posm_cached/4).
:-dynamic(real_posm_cached/4).
:-dynamic(real_posm_cachedTT/4).


  
%:-catch([foo],_,true).

%:-posMeans(CycWord,Phrase,Pos,Form,CycL).


clean_posm_cache:-
      retractall(posm_cached(CycWord,Phrase,Pos,Form,[null])),
      retractall(posm_cached(CycWord,[],Pos,Form,CycL)),
      retractall(real_posm_cached(CycWord,_,Pos,Form,CycL)),
      retractall(real_posm_cachedTT(CycWord,_,Pos,Form,CycL)),
      posm_cached(CycWord,Phrase,Pos,Form,CycL),
      once(partition_cache(CycWord,Phrase,Pos,Form,CycL)),
      fail.

clean_posm_cache:-tell(foo2),
   listing(real_posm_cached),
   listing(real_posm_cachedTT),
   told.

save_posm_cache
   :-tell(foo),
   listing(posm_cached),
   told.




partition_cache(CycWord,Phrase,Pos,Form:'posForms',CycL):-!,partition_cache(CycWord,Phrase,Pos,Form,CycL).

partition_cache(CycWord,Phrase,Pos,Form,CycL):-
   atom(CycWord),
      atom_concat('TT',_,CycWord),!,
      partition_cacheTT(CycWord,Phrase,Pos,Form,CycL).


% ======================================================
% Partitinion CycNL
% ======================================================

%posm_cached('Skill-TheWord', [skilled], 'MassNoun', 'regularDegree':'posForms', meaningOfWord('Skill-TheWord')).

partition_cache(CycWord,Phrase,Pos,Form,meaningOfWord(CycWord)):-!,
   posm_cached(CycWord,Phrase,_,_,CycL),not(CycL=meaningOfWord(_)),
   asserta_if_new(real_posm_cached(CycWord,Phrase,Pos,Form,CycL)).
      
   %real_posm_cached('Type-TheWord', [of, geographical, entity, classified, by, hierarchy], 'SimpleNoun', form, 'GeographicalEntityByHierarchy').
partition_cache(CycWord,Phrase,Pos,form,CycL):-!,
      posm_cached(CycWord,BPhraseing,Pos,Not_form,OMeaning),not(Not_form=form),
      append(BPhraseing,Phrase,OPhrasing),
      partition_cache(CycWord,OPhrasing,Pos,Not_form,CycL).
      

partition_cache(CycWord,Phrase,Pos,Form,CycL):-!,
   asserta_if_new(real_posm_cached(CycWord,Phrase,Pos,Form,CycL)).

% ======================================================
% Partitinion TT CycNL
%posm_cached('TTWord-RATP', ['RATP'], 'Noun', 'TTPred-inflNounFemininePluralUnchecked', 'TT-company-RATP')
% ======================================================

% Delete copies of cycNL from TT
partition_cacheTT(CycWord,Phrase,Pos,Form,CycL):-
   posm_cached(OCycWord,Phrase,_,_,_),
   atom(OCycWord),
   not(atom_concat('TT',_,OCycWord)),!.

partition_cacheTT(CycWord,Phrase,Pos,Form,meaningOfWord(CycWord)):-
   posm_cached(CycWord,Phrase,_,_,CycL),not(CycL=meaningOfWord(_)),!,
   asserta_if_new(real_posm_cachedTT(CycWord,Phrase,Pos,Form,CycL)).

partition_cacheTT(CycWord,Phrase,Pos,Form,CycL):-!,
   asserta_if_new(real_posm_cachedTT(CycWord,Phrase,Pos,Form,CycL)).

                                                    
[the, shopper, drank, the, pepsi]
(thereExists ?shopper4675 
  (and (isa ?shopper4675 (FrequentPerformerFn Shopping ) ) 
   (thereExists ?pepsi6 
     (and (isa ?pepsi6 PepsiCola ) 
     (and (occursDuring ?drank7550 Past ) 
     (and (isa ?drank7550 DrinkingEvent ) 
     (performedBy ?drank7550 ?shopper4675 ) 
     (consumedObject ?drank7550 ?pepsi6 ) ) ) ) ) ) )       
                                                  
[the, shopper, drinks, the, pepsi]
(thereExists ?shopper4675 
  (and (isa ?shopper4675 (FrequentPerformerFn Shopping ) ) 
   (thereExists ?pepsi6 
     (and (isa ?pepsi6 PepsiCola ) 
     (and (occursDuring ?drank7550 Now ) 
     (and (isa ?drank7550 DrinkingEvent ) 
     (performedBy ?drank7550 ?shopper4675 ) 
     (consumedObject ?drank7550 ?pepsi6 ) ) ) ) ) ) )                           

[the, shopper, bought, fries]
(thereExists ?shopper4794 
   (and (isa ?shopper4794 (FrequentPerformerFn Shopping ) ) 
   (and (and (isa ?fries20 Frying ) 
   (objectOfStateChange ?fries20 ?POSSESSOR13610 ) ) 
   (and (occursDuring ?bought3 Past ) 
   (and (isa ?bought3 Buying ) 
   (buyer ?bought3 ?shopper4794 ) 
   (objectPaidFor ?bought3 ?fries20 ) ) ) ) ) )

[the, shopper, bought, fries, with, his, pepsi]
(thereExists ?shopper4863 
    (and (isa ?shopper4863 (FrequentPerformerFn Shopping ) ) 
    (and (isa ?pepsi42 PepsiCola ) 
    (and (and (and (isa ?fries103 Frying ) 
       (objectOfStateChange ?fries103 ?POSSESSOR13613 ) ) 
    (and (isa ?bought4 Buying ) (seller ?bought4 ?shopper4863 ) 
    (objectPaidFor ?bought4 ?fries103 ) 
    (buyingPerformer ?bought4 ?pepsi42 ) ) ) 
    (equals ?POSSESSOR13613 
            (OneOfFn (PronounFn ThirdPerson-NLAttr Singular-NLAttr Masculine-NLAttr PossessivePronoun-Post ) 
             (PronounFn ThirdPerson-NLAttr Singular-NLAttr Masculine-NLAttr PossessivePronoun-Pre ) ) ) 
    (controls (OneOfFn (PronounFn ThirdPerson-NLAttr Singular-NLAttr Masculine-NLAttr PossessivePronoun-Post ) 
                           (PronounFn ThirdPerson-NLAttr Singular-NLAttr Masculine-NLAttr PossessivePronoun-Pre ) )
                   ?pepsi42 ) ) ) ) )



%:-clean_posm_cache.
   
cycPred('subcatFrameKeywords').
cycPred('nounPrep').
cycPred('verbPrep-Transitive').
cycPred('prepReln-Action').
cycPred('prepReln-Obj').
cycPred('preferredGenUnit').
cycPred('prepSemTrans').
cycPred('subcatFrame').
cycPred('verbSemTrans').
cycPred('genTemplate').
cycPred('multiWordSemTrans').
cycPred('denotationPlaceholder').
cycPred('denotesArgInReln').
cycPred('nounSemTrans').
cycPred('multiWordStringDenotesArgInReln').
cycPred('headMedialString').
cycPred('verbPrep-TransitiveTemplate').
cycPred('agentiveNounSemTrans').
cycPred('nonCompositionalVerbSemTrans').
cycPred('abbreviationForMultiWordString').
cycPred('abbreviationForLexicalWord').
cycPred('formalityOfWS').
cycPred('relationIndicators-Strong').
cycPred('verbSemTransPartial').
cycPred('implies').
cycPred('verbPrep-Passive').
cycPred('compoundStringDenotesArgInReln').
cycPred('genNatTerm-multiWordString').
cycPred('hyphenString').
cycPred('adjSemTrans').
cycPred('properNounSemTrans').
cycPred('morphologicallyDerivedFrom').
cycPred('politenessOfWS').
cycPred('genNatTerm-compoundString').
cycPred('genPhrase').
cycPred('abbreviationForCompoundString').
cycPred('posForms').
cycPred('plural').
cycPred('synonymousExternalConcept').
cycPred('lightVerb-TransitiveSemTrans').
cycPred('genTemplate-Constrained').
cycPred('expansion').
cycPred('compoundSemTrans').
cycPred('genStringAssertion-Old').
cycPred('compoundVerbSemTrans').
cycPred('adjSemTrans-Restricted').
cycPred('massNounSemTrans').
cycPred('morphologicalComposition').
cycPred('determinerAgreement').
cycPred('speechPartPreds').
cycPred('genlPreds').
cycPred('afterRemoving').
cycPred('isa').
cycPred('quotedArgument').
cycPred('notAssertible').
cycPred('genKeyword').
cycPred('basicSpeechPartPred').
cycPred('genFormat').
cycPred('arg2Format').
cycPred('argFormat').
cycPred('comparativeDegree').
cycPred('regularSuffix').
cycPred('paraphraseCoercionAllowedFrom').
cycPred('arg1Format').
cycPred('posPredForTemplateCategory').
cycPred('superlativeDegree').
cycPred('relationAllInstance').
cycPred('backchainForbidden').
cycPred('typedGenlPreds').
cycPred('transitiveViaArg').
cycPred('functionalInArgs').
cycPred('ncRuleLabel').
cycPred('keRequirementPreds').
cycPred('ncRuleTemplate').
cycPred('ncRuleConstraint').
cycPred('defaultCorrespondingRoles').
cycPred('headsPhraseOfType').
cycPred('posOfPhraseType').
cycPred('argGenl').
cycPred('barLevelOfPhraseType').
cycPred('transitiveViaArgInverse').
cycPred('nlPhraseTypeForTemplateCategory').
cycPred('denotatumArg').
cycPred('placeName-ShortForm').
cycPred('abnormal').
cycPred('scientificName').
cycPred('keWeakSuggestionPreds').
cycPred('sharedNotes').
cycPred('nameString').
cycPred('termStrings').
cycPred('interArgReln1-3').
cycPred('termStrings-GuessedFromName').
cycPred('acronymString').
cycPred('genFormat-Precise').
cycPred('completeExtentKnown').
cycPred('preferredTermStrings').
cycPred('initialismString').
cycPred('abbreviationString-PN').
cycPred('formerName').
cycPred('preferredNameString').
cycPred('countryName-LongForm').
cycPred('countryName-ShortForm').
cycPred('keStrongSuggestionPreds').
cycPred('arg5Isa').
cycPred('semTransArg').
cycPred('assertTemplate-Reln').
cycPred('interArgIsa3-4').
cycPred('interArgIsa4-5').
cycPred('arg4Format').
cycPred('termPOS-Strings').
cycPred('adjSemTransTemplate').
cycPred('salientAssertions').
cycPred('verbSemTransTemplate').
cycPred('semTransPredForPOS').
cycPred('arg5Format').
cycPred('not').
cycPred('phraseTemplateArg').
cycPred('ist').
cycPred('requiredArg1Pred').
cycPred('genPreferredKeyword').
cycPred('genQuestion').
cycPred('genExpansion').
cycPred('genStringAssertion').
cycPred('genFormat-ArgFixed').
cycPred('genStringAssertion-Precise').
cycPred('genFormat-NP').
cycPred('genNatTerm-ArgLast').
cycPred('genCodeSupport').
cycPred('relationAll').
cycPred('unitOfMeasurePrefixString').
cycPred('generateQuantOverArg').
cycPred('interArgIsa1-3').
cycPred('generateArgWithOutsideScope').
cycPred('interArgIsa1-2').
cycPred('formalityOfWS-New').
cycPred('languageOfLexicon').
cycPred('arg6Isa').
cycPred('abbreviationForString').
cycPred('instancesDontNeedLexification').
cycPred('lexicalWordTypeForLanguage').
cycPred('psRuleTemplateBindings').
cycPred('genlFuncs').
cycPred('resultIsaArgIsa').
cycPred('reformulatorEquiv').
cycPred('reformulatorEquals').
cycPred('reformulationPrecondition').
cycPred('subcatFrameDependentConstraint').
cycPred('subcatFrameArity').
cycPred('subcatFrameDependentKeyword').
cycPred('subcatFrameExample').
cycPred('prefixString').
cycPred('derivedUsingPrefix').
cycPred('relationAllExists').
cycPred('baseForm').
cycPred('derivedUsingSuffix').
cycPred('negationInverse').
cycPred('relationExistsAll').
cycPred('posBaseForms').
cycPred('suffixString').
cycPred('phoneticVariantOfPrefix').
cycPred('phoneticVariantOfSuffix').
cycPred('relationAllExistsMin').
cycPred('derivationalAffixBasePOS').
cycPred('affixRuleArity').
cycPred('affixRuleCategorialConstraint').
cycPred('derivationalAffixResultPOS').
cycPred('affixRuleTypeMorphemePosition').
cycPred('etymologicalVariantOfSuffix').
cycPred('variantOfSuffix').
cycPred('relationInstanceAll').
cycPred('genls').
cycPred('disjointWith').
cycPred('coExtensional').
cycPred('partitionedInto').
cycPred('notAssertibleCollection').
cycPred('typeGenls').
cycPred('resultIsaArg').
cycPred('resultGenlArg').
cycPred('arityMin').
cycPred('arityMax').
cycPred('argAndRestIsa').
cycPred('functionCorrespondingPredicate-Canonical').
cycPred('argsIsa').
cycPred('evaluationDefn').
cycPred('psRuleArity').
cycPred('psRuleSyntacticHeadDtr').
cycPred('psRuleTemplateDtr').
cycPred('psRuleConstraint').
cycPred('psRuleCategory').
cycPred('psRuleExample').
cycPred('psRuleSemanticsHandler').
cycPred('keConsiderationPreds').
cycPred('genlAttributes').
cycPred('negationAttribute').
cycPred('TTPred-thoughtTreasureToCyc').
cycPred('rewriteOf').
cycPred('TTPred-cycToThoughtTreasure').
cycPred('psRuleSemanticsFromDtr').
cycPred('posForTemplateCategory').
cycPred('backchainRequired').
cycPred('defnIff').
cycPred('completeCollectionExtent').
cycPred('quotedCollection').
cycPred('keClarifyingCollection').
cycPred('relationAllExistsCount').
cycPred('rolesForEventType').
cycPred('defaultReformulationDirectionInModeForPred').
cycPred('keStrongConsiderationPreds').
cycPred('keStrongSuggestion').
cycPred('requiredActorSlots').
cycPred('collectionUnion').
cycPred('keCommonQueryPredForInstances').
cycPred('subjectRoles').
cycPred('trueRule').   
cycPred('genlMt').




      */
:-style_check(-atom).

toEnglishString(A,EString):-string_to_atom(EString,A),!.
toEnglishString(EString,EString):-is_string(EString).
toEnglishString([A,B|C],EString):- atom(A), concat_atom([A,B|C],' ',O),!, toEnglishString(O,EString).

testEnglish(E):-recentParses(E).
testEnglish(E):-testE2C(_,E).

english2CycL:-testEnglish(E),english2CycL(E,O),nl,nl,writel(O),nl,nl,writeq(O),nl,nl,fail.
english2CycL.

%(ps-get-cycls-for-np "new oak furniture")
english2CycL(English,CycL:V):-toEnglishString(English,EString),
      catch((once(evalSubL('parse-a-sentence-completely'(string(EString),'#$AllEnglishLexicalMicrotheoryPSC'),CycL,V)),isTrue(CycL)),_,fail).
english2CycL(English,CycL:V):-toEnglishString(English,EString),
      catch((once(evalSubL('parse-a-question-completely'(string(EString),'#$AllEnglishLexicalMicrotheoryPSC'),CycL,V)),isTrue(CycL)),_,fail).
english2CycL(English,CycL:V):-toEnglishString(English,EString),
      catch((once(evalSubL('cyclify'(string(EString)),CycL:V)),isTrue(CycL)),_,fail).
%english2CycL(English,CycL):-toEnglishString(English,EString),
%      catch((once(evalSubL('link-parse'(string(EString)),CycL)),isTrue(CycL)),_,fail).
english2CycL(English,['NounphraseAsCycLFn',CycL]:V):-toEnglishString(English,EString),
      catch((once(evalSubL('ps-get-cycls-for-np'(string(EString)),CycL:V)),isTrue(CycL)),_,fail).
english2CycL(English,['NounphraseAsCycLNPFn',CycL]:V):-toEnglishString(English,EString),
      catch((once(evalSubL('ps-harvest-nps'(string(EString)),CycL:V)),isTrue(CycL)),_,fail).
english2CycL(English,['BestMeaningOfDenotsFn',string(EString),CycL]:V):-toEnglishString(English,EString),
      catch((once(evalSubL('denotation-mapper'(string(EString)),CycL:V)),isTrue(CycL)),_,fail),!.
english2CycL(English,['BestMeaningOfEnglishFn',English]:_).

t2("
((thereExists ?REVENUES0091 
   (and 
       (thereExists ?OIL-FIELD0090 
           (and 
               (isa ?OIL-FIELD0090 OilField))) 
       (isa ?REVENUES0091 Thing) 
       (thereExists ?FELL0092 
           (and 
               (isa ?FELL0092 FallingEvent) 
               (primaryObjectMoving ?FELL0092 ?REVENUES0091))))))").
t2("(thereExists ?REVENUES0091 (and (thereExists ?OIL-FIELD0090 (and (isa ?OIL-FIELD0090 OilField))) (isa ?REVENUES0091 Thing) (thereExists ?FELL0092 (and (isa ?FELL0092 FallingEvent) (primaryObjectMoving ?FELL0092 ?REVENUES0091)))))").

t1(X):-t2(S),string_to_list(S,Y),cyc:getSurfaceFromChars(Y,X,_V).                             


 
/*
The following 900 sentences are correctly handled by the parser. They represent many of the phenomena captured by our grammar. 
All sentences beginning with a ``*'' are judged as incorrect (that is, no complete linkage is found for them). 
Unlabelled sentences are judged as correct.
This list of sentences is available at our ftp directory, under the name \"4.0.batch\". This file can be run as a batchfile, 
and should parse with 0 errors. (See the Introduction, section 3.6, for an explanation of batchfiles.) 
*/


runtests:- startE2CTest("SANITY"),

testE2C(0,"George fell last year"),
testE2C(0,"Oil field revenues fell last year"),
testE2C(0,"I see you"),
testE2C(0,"I seen the wood"),
testE2C(0,"I sawed the wood"),
testE2C(0,"I see two books on a shelf"),
testE2C(1,"I see two books sitting on a shelf"),
testE2C(0,"I can see you"),
testE2C(0,"Fido is a dog"),
testE2C(0,"Who is the president of the United States of America?"),

testE2C(1,"I saw him"),
testE2C(1,"I saw him Monday"),
testE2C(2,"I saw him January"),
testE2C(1,"I saw him January twenty first"),
testE2C(1,"Monday's concert should be good"),
testE2C(2,"January 21, I saw him"),
testE2C(1,"This Monday's concert should be good"),
testE2C(1,"This week's concert should be good"),
testE2C(1,"The Monday concert should be good"),
testE2C(1,"We did it on Jan 21"),
testE2C(2,"We did it in Jan"),
testE2C(2,"I saw him on early January 21"),
testE2C(2,"The this week concert should be good"),
testE2C(1,"I saw him in January 1990"),

startE2CTest("NOUNS"),

testE2C(1,"The fact that he smiled at me gives me hope"),
testE2C(2,"The event that he smiled at me gives me hope"),
testE2C(1,"But my efforts to win his heart have failed"),
testE2C(2,"But my presents to win his heart have failed"),
testE2C(1,"Failure to comply may result in dismissal"),
testE2C(2,"Absence to comply may result in dismissal"),
testE2C(1,"The question is who we should invite"),
testE2C(2,"The party is who we should invite"),
testE2C(1,"The big question on everybody's mind is who killed OJ"),
testE2C(2,"The big mind on everybody's question is who killed OJ"),
testE2C(1,"Do it the way you've always done it"),
testE2C(1,"I really like the way you do your hair"),
testE2C(2,"I really like the fashion you do your hair"),
testE2C(1,"He made a request that there be an investigation"),
testE2C(2,"He stated the fact that there be an investigation"),
testE2C(1,"He is the kind of person who would do that"),
testE2C(2,"He is the character of person who would do that"),
testE2C(1,"An income tax increase may be necessary"),
testE2C(2,"A tax on income increase may be necessary"),
testE2C(1,"Last week I saw a great movie"),
testE2C(2,"Last dog I saw a great movie"),
     /*
testE2C(1,"The party that night was a big success"),
testE2C(2,"The party that dog was a big success"),
testE2C(1,"John Stuart Mill is an important author"),
testE2C(1,"The Richard Milhous Nixon Library has been a big success"),
testE2C(1,"The mystery of the Nixon tapes was never solved"),
testE2C(1,"High income taxes are important"),
testE2C(1,"Oil company stock prices rose in heavy trading today"),
testE2C(1,"Metals futures prices rose in heavy trading today"),
testE2C(1,"U.S. economic indicators fell sharply last month"),           
testE2C(1,"Columbia medical and administrative workers continued their strike today"),
testE2C(1,"Janet, who is an expert on dogs, helped me choose one"),
testE2C(2,"Janet who is an expert on dogs helped me choose one"),
testE2C(1,"The dog that we eventually bought was very expensive"),
testE2C(2,"The dog, that we eventually bought, was very expensive"),
testE2C(2,"The dog, we eventually bought, was very expensive"),
testE2C(1,"Have you ever seen the Pacific"),
testE2C(1,"The new David Letterman is a happy, relaxed David Letterman"),
testE2C(1,"Actress Whoopi Goldberg and singer Michael Jackson attended the ceremony"),
testE2C(1,"We are from the planet Gorpon"),
testE2C(1,"This is my friend Bob"),
testE2C(1,"John's family is renovating their kitchen"),
testE2C(2,"A man I know's family is renovating their kitchen"),
testE2C(1,"The boys' bedrooms will be enlarged"),
testE2C(2,"The boys's bedrooms will be enlarged"),
testE2C(1,"My uncle's mother's cousin is visiting us"),
testE2C(2,"Emily's my cousin is visiting us"),
testE2C(1,"We ate at Joe's Diner last week"),
testE2C(1,"The buy-out caused a free-for-all in the mid-afternoon"),
testE2C(1,"Joan Smith is president of the company"),
testE2C(2,"Joan Smith is tourist"),
testE2C(1,"Alfred Baird, formerly vice president of Beevil Corp., has been appointed as president"),*/
testE2C(2,"Alfred Baird, man I know, has been described as good gardener"),
testE2C(1,"A bunch of dogs are in the yard"),
testE2C(2,"A picture of dogs are in the yard"),

startE2CTest("DETERMINERS & PRONOUNS"),

testE2C(1,"Many people were angered by the hearings"),
testE2C(2,"Many person were angered by the hearings"),
testE2C(1,"Many were angered by the hearings"),
testE2C(1,"My many female friends were angered by the hearings"),
testE2C(2,"My some female friends were angered by the hearings"),
testE2C(1,"Many who initially supported Thomas later changed their minds"),
testE2C(1,"The stupidity of the senators annoyed all my friends"),
testE2C(2,"The stupidity of the senators annoyed many my friends"),
testE2C(1,"I need to buy a present, but I want something inexpensive"),
testE2C(2,"I need to buy a present, but I want a gift inexpensive"),
testE2C(1,"Anyone who thinks this will work is crazy"),
testE2C(1,"Their program is better than ours"),
testE2C(1,"Those that want to come can come"),
testE2C(1,"I read everything I could about the subject"),
testE2C(1,"I read whatever I could about the subjetc"),
testE2C(2,"I read several books I could about the subject"),
testE2C(1,"the best costumes got prizes"),
testE2C(2,"a best costume got prizes"),
testE2C(2,"some best costumes got prizes"),
testE2C(1,"the best five costumes got prizes"),
testE2C(1,"the five best costumes got prizes"),
testE2C(2,"the five best five costumes got prizes"),
testE2C(2,"the hundreds of best costumes got prizes"),
testE2C(2,"five best costumes got prizes"),
testE2C(2,"best costumes got prizes"),
testE2C(2,"best five costumes got prizes"),
testE2C(1,"five other costumes got prizes"),
testE2C(1,"the other five costumes got prizes"),
testE2C(2,"other five costumes got prizes"),
testE2C(1,"the other candy was really disgusting"),
testE2C(2,"the five other candy was really disgusting"),
testE2C(1,"other candy is really disgusting"),
testE2C(2,"other piece of candy was really bad"),
testE2C(1,"other costumes were really bad"),
testE2C(1,"some other costumes were really bad"),

startE2CTest("TIME EXPRESSIONS"),

testE2C(1,"We're thinking about going to a movie this evening"),
testE2C(2,"We're thinking about going to a movie this theater"),
testE2C(1,"I've been grading these stupid exams all day"),
testE2C(2,"I've been grading these stupid days all exam"),
testE2C(1,"We're having a big party Tuesday"),
testE2C(2,"We're having a big party our house"),
testE2C(2,"There is going to be an important meeting January"),
testE2C(1,"There is going to be an important meeting in January"),
testE2C(1,"There is going to be an important meeting next January"),
testE2C(1,"The party last week was a big success"),
testE2C(1,"John last week threw a great party"),
testE2C(1,"Until recently, these fossils were believed to belong to different species"),
testE2C(2,"Until initially, these fossils were believed to belong to different species"),
testE2C(2,"Until for many years, these fossils were believed to belong to different species"),
testE2C(1,"Until last week, these fossils were believed to belong to different species"),
testE2C(2,"Until last meeting, these fossils were believed to belong to different species"),
testE2C(1,"I'm quite excited about next week"),
testE2C(1,"Monday sounds good for the meeting"),
testE2C(1,"Tomorrow might be a good time for the meeting"),
testE2C(1,"Last Tuesday was really fun"),
testE2C(2,"Three days ago was really fun"),
testE2C(1,"Almost three years after our first date, I saw Ruth again"),
testE2C(1,"Almost three years after I first met her, I saw Ruth again"),
testE2C(2,"Almost three years, I saw Ruth again"),
testE2C(1,"Almost three years later, I saw Ruth again"),
testE2C(2,"Almost three years for our first date, I saw Ruth again"),
testE2C(1,"I saw her again a year and a half later"),
testE2C(2,"I saw her again a year and a dog later"),
testE2C(1,"He left here a quarter of an hour ago"),
testE2C(2,"He left here a quarter of a dog ago"),
testE2C(2,"He left here a picture of an hour ago"),
testE2C(1,"I still remember the day I kissed him"),
testE2C(2,"I still remember the room I kissed him"),
testE2C(1,"I'm going to Europe the day I graduate"),
testE2C(1,"Clinton is expected to return to Washington Thursday morning"),
testE2C(2,"Clinton is expected to return to Thursday Washington office"),
testE2C(1,"Clinton is expected to return to Washington on Thursday morning"),
testE2C(1,"Clinton is expected to return to Washington late Thursday morning"),
testE2C(1,"Clinton is expected to return to Washington next Thursday morning"),
testE2C(1,"She walked out of the room the minute I saw her"),
testE2C(2,"She walked out of the room two minutes I saw her"),
testE2C(1,"I was crazy about him the first time I saw him"),
testE2C(2,"I was crazy about him the first party I saw him"),
testE2C(1,"In January 1990, a historic new law was passed"),
testE2C(2,"In Washington 1990, a historic new law was passed"),
testE2C(1,"On January 15, 1990, a historic new law was passed"),
testE2C(2,"On January 320, 1990, a historic new law was passed"),
testE2C(1,"He was convicted under an obscure 1990 law "),
testE2C(2,"He was convicted under an obscure 50 law"),
testE2C(1,"I wish I could see him 100 times a day"),
testE2C(2,"I wish I could see him 3 meals a day"),
testE2C(2,"I wish I could see him 100 times a dog"),
testE2C(2,"I wish I could see him 100 times 2 days"),
testE2C(1,"It's good to eat three big meals a day"),
testE2C(1,"Someone is mugged in New York every five minutes"),
testE2C(1,"Her career lasted almost thirty years"),
testE2C(2,"Her career lasted almost thirty books"),
testE2C(1,"Every morning at 5 a.m., Ken gets up and runs for five miles"),
testE2C(1,"At 4:52 p.m., on Monday, December 26, 1997, nothing happened"),

startE2CTest("VERBS "),

testE2C(1,"Abrams does like programming"),
testE2C(2,"Abrams does be a good programmer"),
testE2C(1,"He is being hired by another company"),
testE2C(1,"He is looking for another job"),
testE2C(1,"Fred has had five years of experience as a programmer"),
testE2C(2,"Fred has had been a programmer for five years"),
testE2C(1,"I gave my mother the present I bought for her"),
testE2C(1,"I gave her the present I bought for her"),
testE2C(2,"I gave my mother it"),
testE2C(1,"We picked out some beautiful flowers for her"),
testE2C(1,"We picked some beautiful flowers out for her"),
testE2C(1,"We picked them out for her"),
testE2C(2,"We picked out them for her"),
testE2C(1,"Did you put the milk in the refrigerator"),
testE2C(2,"Did you put the milk"),
testE2C(1,"Where did you put the milk"),
testE2C(1,"I hope he comes to the party tomorrow"),
testE2C(1,"I hope that he comes to the party tomorrow"),
testE2C(2,"I hope him to come to the party tomorrow"),
testE2C(1,"I expect him to come to the party tomorrow"),
testE2C(1,"I expect to go to the party tomorrow"),
testE2C(2,"I expect"),
testE2C(2,"I expected who would come to the party"),
testE2C(1,"I knew who would come to the party"),
testE2C(2,"I expected he go to the party"),
testE2C(1,"I suggested he go to the party"),
testE2C(2,"He knew me how to use the program"),
testE2C(1,"He asked me how to use the program"),
testE2C(2,"He disputed our program was superior"),
testE2C(1,"He disputed that our program was superior"),
testE2C(1,"Anne told me I would almost certainly be hired"),
testE2C(2,"Anne expected me I would almost certainly be hired"),
testE2C(2,"We argued adding new features to the program"),
testE2C(1,"We discussed adding new features to the program"),
testE2C(2,"I thought terrible after our discussion"),
testE2C(1,"I felt terrible after our discussion"),
testE2C(1,"I made him make some changes in the program"),
testE2C(2,"I encouraged him make some changes in the program"),
testE2C(1,"I helped him make some changes in the program"),
testE2C(1,"I helped make some changes in the program"),
testE2C(2,"I saw make some changes in the program"),
testE2C(2,"I made him telling her about the party"),
testE2C(1,"I saw him telling her about the party"),
testE2C(1,"Phil gave me a sweater which he bought in Paris"),
testE2C(2,"Phil chose me a sweater which he bought in Paris"),
testE2C(1,"Alan bet me five dollars Clinton would lose the election"),
testE2C(2,"Alan offered me five dollars Clinton would lose the election"),
testE2C(1,"She said she didn't approve of my behavior"),
testE2C(2,"She said she didn't like of my behavior"),
testE2C(1,"The results are in, the game is up and the truth is out"),
testE2C(2,"The in results show the out truth about the up game"),
testE2C(2,"The results became in and the truth seemed out"),
testE2C(1,"He sold for five dollars the ring his mother had given him"),
testE2C(1,"Clinton announced on Tuesday a bold new proposal"),
testE2C(2,"Clinton announced on Tuesday it"),
testE2C(1,"I gave my brother an expensive present"),
testE2C(1,"I gave him an expensive present"),
testE2C(1,"I gave an expensive present"),
testE2C(1,"I gave it"),
testE2C(2,"I gave my brother it"),
testE2C(1,"I gave him for his birthday a very expensive present "),
testE2C(2,"I gave him for his birthday it"),
testE2C(1,"I gave for his birthday an expensive present "),
testE2C(2,"I gave for his birthday it"),
testE2C(1,"The President announced on Monday that several more bases would be closed"),
testE2C(1,"He had attempted for years to make a career as a concert pianist"),
testE2C(2,"He had attempted for years"),
testE2C(1,"I asked him when I saw him at the party yesterday what he was working on"),
testE2C(2,"I talked to him when I saw him at the party yesterday what he was working on"),
testE2C(1,"I wondered for a long time why everyone liked her so much"),
testE2C(2,"I thought for a long time why everyone liked her so much"),
testE2C(1,"I told Margaret that I thought she would probably be hired"),
testE2C(2,"I told on Tuesday Margaret that I thought she would probably be hired"),
testE2C(1,"I told Margaret on Tuesday that I thought she would probably be hired"),
testE2C(1,"We discussed at the meeting hiring a new secretary"),
testE2C(2,"We discussed at the meeting"),
testE2C(1,"We informed the new employees that no salary increase would be possible"),
testE2C(1,"We informed at the meeting the new employees"),
testE2C(2,"We informed at the meeting the new employees that no salary increase would be possible"),
testE2C(1,"They were asked that he be allowed to go"),
testE2C(1,"If his calculations were correct, Copernicus reasoned, the earth must revolve around the sun"),
testE2C(1,"The earth, Copernicus reasoned, must revolve around the sun"),
testE2C(1,"The earth must revolve around the sun, Copernicus reasoned"),
testE2C(2,"The earth must revolve around the sun, Copernicus was happy"),
testE2C(2,"The earth must revolve around the sun, Copernicus destroyed"),
testE2C(2,"The earth, the pope cringed when Copernicus reasoned, revolves around the sun"),
testE2C(1,"Abortion was legal until the third month, the court ruled"),
testE2C(1,"If the pregnancy was within the first three months, the court ruled, abortion was legal"),
testE2C(1,"Nobody, it seems, wants to be a liberal"),
testE2C(2,"Nobody, John seems, wants to be a liberal"),
testE2C(1,"Business is booming, Joe Smith, a car dealer, says"),
testE2C(1,"Business is booming, says Joe Smith, a car dealer"),
testE2C(1,"You can do anything you want, I told her"),
testE2C(1,"In the last few years, it seems, nobody wants to be a liberal"),
testE2C(1,"Also invited to the meeting were several prominent scientists"),
testE2C(2,"Also invited to the meeting invited several prominent scientists"),
testE2C(1,"Also awarded the prize was Jean Smith, a prominent computer scientist"),
testE2C(1,"Chosen to lead the commission was Fred Schultz, a former Federal judge"),
testE2C(2,"Chosen to lead the commission seemed likely to be Fred Schultz, a former Federal judge"),
testE2C(2,"Chooses to lead the investigation Fred Schultz"),
testE2C(2,"Choose to lead the investigation did Fred Schultz"),
testE2C(1,"Also recommended in the report was a new initiative to combat crime"),
testE2C(2,"Also chosen the leader for the commission was Fred Schultz"),
testE2C(1,"Included in our paper is a summary of the features of our program"),
testE2C(1,"Also performing in the concert were members of the Budapest Quartet"),
testE2C(2,"Were performing in the concert members of the Budapest Quartet"),
testE2C(1,"Voting in favor of the bill were 36 Republicans and 4 moderate Democrats"),
testE2C(1,"Glaring coldly at Sarah, he walked out of the room"),
testE2C(1,"He walked out of the room, glaring coldly at Sarah"),
testE2C(2,"Glaring coldly at Sarah, walking out of the room"),
testE2C(1,"Finding that it was impossible to get work as a waiter, he worked as a janitor"),
testE2C(1,"He had hoped to get work as a waiter, but, finding this was impossible, he worked as a janitor"),
testE2C(2,"He said that, finding that it was impossible to get work as a waiter, he would work as a janitor"),
testE2C(1,"Used by some of the finest pianists in the country, Baldwin pianos are technical marvels"),
testE2C(1,"Using specially designed parts, Baldwin pianos are technical marvels"),
testE2C(2,"Used specially designed parts, Baldwin pianos are technical marvels"),
testE2C(1,"Sending a message of discontent to Washington, voters overwhelmingly rejected the Clinton administration"),
testE2C(1,"She's a really good player"),
testE2C(1,"John's coming to the party tonight"),
testE2C(1,"He's usually gone to Boston for Thanksgiving"),
testE2C(2,"Do you know where John's"),
testE2C(1,"Who's afraid of the big bad wolf"),
testE2C(1,"That's just the kind of person he is"),
testE2C(2,"That's just the kind of person he's"),
testE2C(1,"There's no reason to get so upset about it"),
testE2C(1,"I didn't think he would do it, but he did"),
testE2C(2,"I didn't think he would invite her, but he invited"),
testE2C(1,"If you don't want to do it, you should find someone who will"),
testE2C(1,"If you don't want to do it, you should find someone who does"),
testE2C(1,"Find someone who does"),
testE2C(2,"Find someone who wants to do"),
testE2C(1,"I don't like programming, and someone who does may be difficult to find"),
testE2C(1,"The price of the stock more than doubled in two days"),
testE2C(2,"The price of the stock more than increased in two days"),
testE2C(1,"I finally figured out why this program is so slow"),
testE2C(2,"I finally flipped out why this program is so slow"),
testE2C(1,"It turns out that Clinton didn't actually kiss Monica"),
testE2C(1,"If you go around doing that, you're going to end up making people mad"),
testE2C(1,"The lawyer pointed out that Clinton didn't actually kiss Monica"),
testE2C(1,"A party is taking place, so if you'd like to show up, you should do so"),

startE2CTest("PREPOSITIONS"),

testE2C(1,"I have doubts about inviting him"),
testE2C(2,"I have doubts during inviting him"),
testE2C(1,"I prevented her from doing it by praising her for not doing it"),
testE2C(1,"From your description, I don't think I would enjoy it"),
testE2C(1,"We had an argument over whether it was a good movie"),
testE2C(2,"We had an argument at whether it was a good movie"),
testE2C(1,"Because of the rain, we decided to stay home"),
testE2C(1,"They're having a party in front of the building"),
testE2C(1,"The man with whom I play tennis is here"),
testE2C(1,"The man I play tennis with is here"),
testE2C(2,"The man whom I play tennis is here"),
testE2C(2,"The man with whom I play tennis with is here"),
testE2C(1,"With whom did you play tennis "),
testE2C(1,"Who did you play tennis with "),
testE2C(1,"The data on file will be used for the project at hand, which is already under way"),
testE2C(2,"The data on project will be used for the file at program"),
testE2C(1,"The project was finished on schedule, as usual"),
testE2C(2,"The project as usual and the report on schedule were finished "),
testE2C(1,"I told him by telephone that I was coming by car"),
testE2C(1,"From in back of the shed, I heard a scream that seemed to come from on top of the garage"),
testE2C(1,"The university spends $5 per student"),
testE2C(2,"The university spends $5 per the student"),
testE2C(1,"They're building a gigantic mall five miles from here"),
testE2C(2,"They're building a gigantic mall five mistakes from here"),
testE2C(1,"The 7-11 is half a mile up the road, but the supermarket is a long way away"),
testE2C(1,"I'm sure things will get done with Janet running the company "),
testE2C(2,"I'm sure things will get done by Janet running the company "),
testE2C(2,"I'm sure things will get done because Janet running the company "),
testE2C(1,"With Janet in charge, I'm sure things will get done"),

startE2CTest("ADJECTIVES"),

testE2C(1,"You are lucky that there is no exam today"),
testE2C(2,"You are stupid that there is no exam today"),
testE2C(1,"You are lucky I am here"),
testE2C(2,"You are right I am here"),
testE2C(1,"This is something we should be happy about"),
testE2C(2,"This is something we should be happy "),
testE2C(2,"The happy about it man kissed his wife"),
testE2C(1,"Is he sure how to find the house"),
testE2C(2,"Is he correct how to find the house"),
testE2C(1,"You should be proud of your achievement"),
testE2C(2,"You should be happy of your achievement"),
testE2C(1,"He is the smartest man I know"),
testE2C(2,"They are some smartest men I know"),
testE2C(1,"I've seen a lot of programs, but ours is the fastest"),
testE2C(1,"Ours is the fastest of the programs we have seen"),
testE2C(1,"I've seen a lot of programs, but ours runs the most quickly"),
testE2C(2,"This is our the fastest program"),
testE2C(1,"Voters angry about the economy will probably vote for Clinton"),
testE2C(2,"Voters angry will probably vote for Clinton"),
testE2C(1,"Many Democrats unhappy about the economy but doubtful that Clinton can be elected probably won't vote at all"),
testE2C(2,"Many Democrats unhappy but doubtful probably won't vote at all"),
testE2C(2,"Many Democrats likely that Bush will be reelected probably won't vote"),
testE2C(1,"Hundreds of young men, furious about the verdict in the Rodney King case, looted stores in Los Angeles today"),
testE2C(2,"Hundreds of young men, furious, looted stores in Los Angeles today"),
testE2C(1,"We need a programmer knowledgeable about Lisp"),
testE2C(2,"We need a programmer knowledgeable"),
testE2C(1,"Any program as good as ours should be useful"),
testE2C(2,"Any program good should be useful"),
testE2C(1,"Let us know if you have a program capable of parsing this utterance"),
testE2C(2,"Let us know if you have a program capable"),
testE2C(1,"It is believed that even the troops loyal to Hussein will soon be forced to surrender"),
testE2C(2,"It is believed that even the troops loyal will soon be forced to surrender"),
testE2C(1,"Republican policies only benefit the rich and powerful"),
testE2C(1,"Republican policies only benefit the rich and the powerful"),
testE2C(2,"Republican policies only benefit a rich and a powerful"),
testE2C(2,"Republican policies only benefit some rich and some powerful"),
testE2C(1,"The meek will inherit the earth, and the best is the enemy of the good"),
testE2C(1,"They're building a skyscraper over 1000 feet tall"),
testE2C(2,"They're building a skyscraper tall"),
testE2C(1,"The river is half a mile wide here and 300 feet deep"),
testE2C(2,"The river is half a mile beautiful and 300 feet dangerous"),
testE2C(1,"Mr. John Smith, 66 years old, will succeed him as president"),
testE2C(2,"Mr. John Smith, old, will succeed him as president"),
testE2C(1,"A big black ugly dog chased me"),
testE2C(1,"A big, black, ugly dog chased me"),
testE2C(1,"The former astronaut was alone and afraid"),
testE2C(2,"The alone astronaut was former"),

startE2CTest("ADVERBS"),

testE2C(1,"He is apparently an expert on dogs"),
testE2C(2,"He knows apparently an expert on dogs"),
testE2C(1,"Mary quickly walked out of the room"),
testE2C(1,"Mary just walked out of the room"),
testE2C(1,"Quickly, Mary walked out of the room"),
testE2C(1,"Mary walked out of the room quickly"),
testE2C(2,"Mary walked out of the room just"),
testE2C(1,"He told them about the accident immediately"),
testE2C(2,"He told them about the accident presumably"),
testE2C(1,"He told them about the accident, presumably"),
testE2C(1,"She is very careful about her work"),
testE2C(1,"She works very carefully"),
testE2C(2,"She very works carefully"),
testE2C(1,"Is the piece easy enough for you"),
testE2C(1,"Is the piece too easy for you"),
testE2C(2,"Is the piece enough easy for you"),
testE2C(1,"She is apparently an excellent pianist"),
testE2C(2,"She married apparently an excellent pianist"),
testE2C(1,"Only after the movie did he realize his mistake"),
testE2C(2,"After the movie did he realize his mistake"),
testE2C(1,"I may have taken cocaine a few times, but at no time did I inhale"),
testE2C(2,"A few times may I have taken cocaine, but I inhaled at no time"),
testE2C(1,"Never have I seen such a grotesque display of incompetence"),
testE2C(2,"Often have I seen such a grotesque display of incompetence"),
testE2C(1,"We like to eat at restaurants, particularly on weekends"),
testE2C(1,"We like to eat at restaurants, usually on weekends"),
testE2C(2,"We like to eat at restaurants, fortunately on weekends"),
testE2C(1,"Such flowers are found mainly in Europe"),
testE2C(2,"Such flowers are found apparently in Europe"),
testE2C(2,"Such flowers are found mainly particularly in Europe"),
testE2C(2,"Such flowers are found mainly"),
testE2C(1,"Many people, particularly doctors, believe there is no health care crisis"),
testE2C(2,"Many people, strongly doctors, believe there is no health care crisis"),
testE2C(1,"I found a house that even John thinks we should buy"),
testE2C(1,"He told me that even his mother likes me"),
testE2C(2,"He told me that even, his mother likes me"),
testE2C(1,"We put the pie straight in the oven"),
testE2C(2,"We put the pie quickly in the oven"),
testE2C(1,"We put the pie straight in"),
testE2C(2,"We put the pie straight"),
testE2C(1,"He lives high in the mountains"),
testE2C(1,"He lives over by the lake"),
testE2C(1,"He lives out down by the lake"),
testE2C(2,"He lives out down by"),
testE2C(1,"The apparently angry man walked out of the room"),
testE2C(1,"The often underpaid administrators resent the invariably rude students and the understandably impatient professors"),
testE2C(1,"The delicately lyrical tone of the cello contrasted with the fiercely percussive piano chords"),
testE2C(1,"The always delicately lyrical tone was really beautiful"),
testE2C(2,"The delicately always lyrical tone was really beautiful"),
testE2C(2,"The delicately very lyrical tone was really beautiful"),
testE2C(1,"Biochemically, I think the experiment has a lot of problems"),
testE2C(1,"I think the experiment has a lot of problems biochemically"),
testE2C(1,"It is biochemically an interesting experiment"),
testE2C(1,"I'm not sure the results are biochemically valid"),

startE2CTest("QUESTIONS AND RELATIVE CLAUSES"),

testE2C(1,"Which dog did you chase"),
testE2C(2,"Which dog you chased"),
testE2C(1,"Which dog did you say you chased"),
testE2C(2,"Which dog you said you chased"),
testE2C(2,"Which dog did you say did you chase"),
testE2C(1,"I wonder which dog he said you chased"),
testE2C(2,"I wonder which dog did he say you chased"),
testE2C(2,"I wonder which dog did he say did you chase"),
testE2C(1,"What did John say he thought you should do"),
testE2C(2,"What did John say did he think you should do"),
testE2C(2,"What John said he thought you should do"),
testE2C(1,"What Alice did really annoyed me"),
testE2C(2,"Who Alice did really annoyed me"),
testE2C(1,"Whoever designed this program didn't know what they were doing"),
testE2C(2,"Who designed this program didn't know what they were doing"),
testE2C(1,"Invite John and whoever else you want to invite"),
testE2C(1,"The dog which Chris bought is really ugly"),
testE2C(2,"The dog what Chris bought is really ugly"),
testE2C(1,"I wonder whether we should go"),
testE2C(2,"Whether should we go"),
testE2C(1,"We can't decide whether to go to the party"),
testE2C(2,"We can't decide who to go the party"),
testE2C(2,"We can't decide whether to go the the party with"),
testE2C(1,"I am wondering who to go to the party with"),
testE2C(1,"I am wondering who to invite to the party"),
testE2C(2,"I am wondering whether to invite to the party"),
testE2C(2,"I am wondering the people to invite to the party"),
testE2C(2,"Whether to go to the party"),
testE2C(2,"Who to invite to the party"),
testE2C(1,"Do you think we should go to the party"),
testE2C(2,"What do you think we should go to the party"),
testE2C(1,"How do you operate this machine"),
testE2C(1,"How fast is the program"),
testE2C(1,"How certain are you that John is coming"),
testE2C(2,"How tired are you that John is coming"),
testE2C(1,"How likely is it that he will come"),
testE2C(2,"How likely is John that he will come"),
testE2C(1,"How certain does he seem to be that John is coming"),
testE2C(1,"How efficient a program is it"),
testE2C(2,"Efficient a program is it"),
testE2C(2,"How fast programs are they"),
testE2C(2,"How fast the program is it"),
testE2C(1,"How fast a program does he think it is"),
testE2C(2,"How fast a program he thinks it is"),
testE2C(2,"How fast programs does he think they are"),
testE2C(2,"How big a dog chased you "),
testE2C(1,"I wonder how fast a program he thinks it is"),
testE2C(2,"I wonder how fast a program does he think it is"),
testE2C(1,"How much money did you earn"),
testE2C(2,"How much money you earn"),
testE2C(1,"I wonder how much money you earned"),
testE2C(2,"I wonder how much money have you earned"),
testE2C(1,"How much oil spilled"),
testE2C(1,"How much do you swim"),
testE2C(2,"How much you swim"),
testE2C(1,"I wonder how much you swim"),
testE2C(2,"I wonder how much do you swim"),
testE2C(2,"I don't have how much money"),
testE2C(1,"I don't have very much money"),
testE2C(1,"I don't have much money"),
testE2C(1,"How much did you read"),
testE2C(2,"How much of the book you read"),
testE2C(1,"How much of the book did you read"),
testE2C(1,"I wonder how much of the book you read"),
testE2C(1,"How many people died"),
testE2C(1,"How many people did you see"),
testE2C(2,"How many people you saw"),
testE2C(1,"I wonder how many people you saw"),
testE2C(1,"I wonder how many of the people you saw were students"),
testE2C(1,"How did John do it"),
testE2C(1,"I wonder how John did it"),
testE2C(1,"How long will it last"),
testE2C(2,"How big will it last"),
testE2C(1,"How many years did it take to do it"),
testE2C(1,"How big is the department"),
testE2C(2,"How big the department is"),
testE2C(2,"I wonder how big is the department"),
testE2C(1,"I wonder how big the department is"),
testE2C(2,"I wonder how big departments they are"),
testE2C(2,"I wonder how a department it is"),
testE2C(1,"I wonder how big a department it is"),
testE2C(1,"How important is it to turn the computer off"),
testE2C(1,"I wonder how important it is to turn off the computer"),
testE2C(2,"I wonder how important is it to turn off the computer"),
testE2C(1,"How quickly did Joe run"),
testE2C(2,"How quickly Joe ran"),
testE2C(1,"I know how quickly you ran"),
testE2C(2,"I know how quickly did you run"),
testE2C(2,"He ran I know how quickly"),
testE2C(2,"Quickly did Joe run"),
testE2C(2,"Very quickly did Joe run"),
testE2C(2,"I know very quickly did Joe run"),
testE2C(2,"I know quickly did John run"),
testE2C(1,"How much more quickly did you run"),
testE2C(2,"How much more quickly you run"),
testE2C(2,"I wonder how much more quickly did he run"),
testE2C(1,"I wonder how much more quickly he ran"),
testE2C(1,"How much more quickly did he run than Joe"),
testE2C(1,"How much more should we work on this"),
testE2C(1,"How much further do you think we should drive tonight"),
testE2C(1,"I don't know how much longer I can tolerate this"),
testE2C(1,"How much bigger is the dog"),
testE2C(2,"How much bigger dogs are they"),
testE2C(2,"How much bigger dogs ran"),
testE2C(2,"How big dogs run"),
testE2C(1,"How much further did you run"),
testE2C(1,"How much more oil spilled"),
testE2C(1,"How much more spilled"),
testE2C(1,"How much more oil did they spill"),
testE2C(1,"How much more did they spill"),
testE2C(2,"How much more they spilled"),
testE2C(1,"I wonder how much oil spilled"),
testE2C(1,"I wonder how much oil they spilled"),
testE2C(2,"How much more efficient programs are available"),
testE2C(1,"How many dogs ran"),
testE2C(1,"How many ran"),
testE2C(1,"How many dogs did you see"),
testE2C(1,"How many more people did you see"),
testE2C(1,"How many more people do you think will come"),
testE2C(1,"I wonder how many more people he thinks will come"),
testE2C(2,"I wonder how many more people does he think will come"),
testE2C(1,"How many times did you do it"),
testE2C(2,"How many times you did it"),
testE2C(1,"I wonder how many times you did it"),
testE2C(2,"How many more stupid times did you do it"),
testE2C(1,"How many years ago did you do it"),
testE2C(2,"Many years ago did you do it"),
testE2C(2,"How many years did you do it"),
testE2C(1,"I wonder how many years ago you did it"),
testE2C(2,"How many years ago you did it"),
testE2C(1,"I'll show you the house where I met your mother"),
testE2C(2,"I'll show you the house which I met your mother"),
testE2C(1,"This is the man whose dog I bought"),
testE2C(2,"This is the man which dog I bought"),
testE2C(1,"I wonder where John is"),
testE2C(2,"I wonder where John hit"),
testE2C(1,"The dogs, some of which were very large, ran after the man"),
testE2C(1,"The dogs, some of which I had seen before, ran after the man"),
testE2C(2,"The dogs some of which were very large ran after the man"),
testE2C(1,"The box contained many books, some of which were badly damaged"),
testE2C(2,"Some of which were badly damaged"),
testE2C(2,"The box contained many books, some were badly damaged"),
testE2C(2,"The box contained many books, some of the books were badly damaged"),
testE2C(1,"The dogs, some of them very large, ran after the man"),
testE2C(2,"The dogs, some of the dogs very large, ran after the man"),
testE2C(2,"Some of them very large ran after the man"),
testE2C(1,"The man was chased by dogs, some of them very large"),
testE2C(1,"I believe it was John who stole the priceless documents"),
testE2C(2,"I believe Fred was John who stole the priceless documents"),
testE2C(1,"It seems to have been Einstein who first came up with the idea"),
testE2C(2,"There seems to have been Einstein who first came up with the idea"),
testE2C(2,"It hopes to have been Einstein who first came up with the idea"),
testE2C(2,"The book discussed Einstein who first came up with the idea"),
testE2C(2,"Stravinsky was in Paris that Debussy first heard Balinese music"),
testE2C(1,"It was in Paris that Debussy first heard Balinese music"),
testE2C(1,"It must have been there that he realized his destiny"),
testE2C(2,"It tried to have been there that he realized his destiny"),
testE2C(2,"He composed some good music that he realized his destiny"),
testE2C(2,"It was quickly that he wrote his first symphony"),
testE2C(1,"Wasn't it in 1955 that Sally first met Joe"),
testE2C(1,"Whatever the outcome, I'm sure he'll still be popular"),
testE2C(2,"Whatever an outcome, I'm sure he'll still be popular"),
testE2C(1,"Whatever the outcome is, I'm sure he'll still be popular"),
testE2C(2,"What the outcome is, I'm sure he'll still be popular"),

startE2CTest("IT-THERE-THIS"),

testE2C(1,"There is a dog in the park"),
testE2C(2,"There is chasing dogs"),
testE2C(2,"There are a dog in the park"),
testE2C(1,"Does there seem to be a dog in the park?"),
testE2C(2,"Does there want to be a dog in the park?"),
testE2C(1,"There seems to appear to have been likely to be a problem"),
testE2C(2,"There seems to appear to have been likely to be problems"),
testE2C(2,"There seems to appear to have been likely to be stupid"),
testE2C(1,"There was an attempt to kill Rod"),
testE2C(1,"The man there was an attempt to kill died"),
testE2C(1,"There was a problem, but we solved it"),
testE2C(1,"It is likely that Rod died"),
testE2C(2,"Joe is likely that Rod died"),
testE2C(1,"It is clear who killed Rod"),
testE2C(2,"Joe is clear who killed Rod"),
testE2C(1,"It may not be possible to fix the problem"),
testE2C(1,"Grace may not be possible to fix the problem"),
testE2C(1,"It is important that women be ready when they make these choices"),
testE2C(2,"It is clear that women be ready when they make these choices"),
testE2C(2,"Joe is important that women be ready when they make these choices"),
testE2C(1,"flowers are red to attract bees"),
testE2C(1,"I made it clear that I was angry"),
testE2C(2,"I made Anne clear that I was angry"),
testE2C(1,"Dick is easy to hit"),
testE2C(2,"Dick is black to hit"),
testE2C(1,"It is important to fix the problem"),
testE2C(1,"Dick is important to fix the problem"),
testE2C(1,"The man it is likely that John hit died"),
testE2C(2,"The man Joe is likely that Dick hit died"),
testE2C(1,"Does it seem likely that Ann will come"),
testE2C(1,"Does Ann act glad that Joe came"),
testE2C(2,"Does it act likely that Joe came"),
testE2C(1,"It doesn't matter what Ted does"),
testE2C(2,"Joe doesn't matter what Ted does"),
testE2C(1,"I want it to be possible to use the program"),
testE2C(1,"I want Joe to be possible to use the program"),
testE2C(1,"I want it to be clear that it was my idea"),
testE2C(2,"I asked it to be clear that it was my idea"),
testE2C(1,"I want it to be obvious how to use the program"),
testE2C(2,"I want Emily to be obvious how to use the program"),
testE2C(1,"I want Joe to be easy to hit"),
testE2C(1,"It is likely they will come"),
testE2C(2,"Joe is likely they will come"),
testE2C(1,"This is because he is extremely famous"),
testE2C(1,"The trial is because he is extremely famous"),
testE2C(1,"The excitement over the trial is because he is extremely famous"),
testE2C(1,"This seems to have been because he is extremely famous"),

startE2CTest("COMPARATIVES"),

testE2C(1,"Our program works more elegantly than yours"),
testE2C(1,"Ours works more elegantly than yours does"),
testE2C(1,"Ours works more elegantly than yours works"),
testE2C(2,"Ours works more elegant than yours"),
testE2C(2,"Ours is more elegant than yours works"),
testE2C(1,"Our program works more elegantly than efficiently"),
testE2C(1,"Our program is more elegant than efficient"),
testE2C(1,"Our program works better than yours"),
testE2C(1,"We do this more for pleasure than for money"),
testE2C(1,"He is more likely to go than to stay"),
testE2C(2,"He is more likely than to stay"),
testE2C(2,"He is more black to go than to stay"),
testE2C(1,"He is more likely to go than he is to stay"),
testE2C(1,"He is more likely to go than John is"),
testE2C(1,"It is more likely that Joe died than that Fred died"),
testE2C(1,"It is more likely that Joe died than it is that Fred died"),
testE2C(2,"John is more likely that Joe died than it is that Fred died"),
testE2C(2,"It is more likely that Joe died than John is that Fred died"),
testE2C(1,"It is easier to ignore the problem than to solve it"),
testE2C(1,"It is easier to ignore the problem than it is to solve it"),
testE2C(2,"Greg is easier to ignore the problem than to solve it"),
testE2C(1,"Our program is easier to use than to understand"),
testE2C(2,"Our program is easier to use it than to understand"),
testE2C(1,"I am more happy now than I was in college"),
testE2C(2,"I am more happy now than I earned in college"),
testE2C(1,"He is more a teacher than a scholar"),
testE2C(1,"I make more money in a month than John makes in a year"),
testE2C(1,"I make more money in a month than John dies in a year"),
testE2C(1,"I hit more the dog than the cat"),
testE2C(1,"I have more money than John has time"),
testE2C(1,"I have more dogs than John has five cats"),
testE2C(1,"I have more money than John has a dog"),
testE2C(1,"She interviewed more programmers than were hired"),
testE2C(2,"She interviewed more programmers than was hired"),
testE2C(1,"I am as intelligent as John"),
testE2C(1,"I earn as much money as John does"),
testE2C(1,"I am as intelligent as John does"),
testE2C(1,"I earn as much money in a month as John earns in a year"),
testE2C(2,"I earn as much money in a month than John earns in a year"),
testE2C(1,"Our program was better than had been expected"),
testE2C(2,"Our program was better than had been argued"),
testE2C(2,"Our program was better than had been responded"),
testE2C(1,"Our program was better than was expected"),
testE2C(2,"Our program was better than were expected"),
testE2C(1,"More people came to the party than were expected"),
testE2C(1,"More people came to the party than was expected"),
testE2C(1,"Our program did not run as quickly as expected"),
testE2C(2,"Our program did not run as quickly as said"),
testE2C(1,"How much faster is our program than theirs"),
testE2C(2,"How much faster our program is than theirs"),
testE2C(1,"The more quickly we write the program, the more money we will earn"),
testE2C(2,"The more people like the program"),
testE2C(2,"The people like the program, the more money we will earn"),
testE2C(1,"The better the program is, the more people will like it"),
testE2C(1,"The better the program, the more people will like it"),
testE2C(2,"The better a program, the more people will like it"),
testE2C(1,"The less likely it is that we can parse this, the easier it is to understand "),

startE2CTest(" \"SO THAT\", \"SUCH...THAT\""),

testE2C(1,"The shuttle is so big that it has to be carried on the back of a jet "),
testE2C(2,"The shuttle is big that it has to be carried on the back of a jet "),
testE2C(1,"So many people attended that they spilled over into several neighboring fields"),
testE2C(2,"Many people attended that they spilled over into several neighboring fields"),
testE2C(1,"The program has so many problems that you should probably just rewrite it"),
testE2C(2,"The program has many problems that you should probably just rewrite it"),
testE2C(1,"I love her so much that I can't let her go"),
testE2C(2,"I love her very much that I can't let her go"),
testE2C(1,"He ran home so quickly that his mother could hardly believe he had called from school"),
testE2C(2,"He ran home quickly that his mother could hardly believe he had called from school"),
testE2C(1,"She presented her case with such eloquence that we could only admire her"),
testE2C(2,"She presented her case with eloquence that we could only admire her"),

startE2CTest("SUBORDINATING CONJUNCTIONS"),

testE2C(1,"The man we saw when we went to Paris is here"),
testE2C(2,"The man we saw but we went to Paris is here"),
testE2C(1,"You should see a play while in London"),
testE2C(2,"You should see a play after in London"),
testE2C(1,"I left the party after seeing Ann there"),
testE2C(2,"I left the party because seeing Ann there"),
testE2C(2,"I left the party despite I saw Ann there"),
testE2C(1,"Because I didn't see Ann, I left"),
testE2C(2,"Therefore I didn't see Ann, I left"),
testE2C(1,"I left, therefore I didn't see Ann"),
testE2C(1,"But I really wanted to see her"),
testE2C(2,"After I really wanted to see her"),
testE2C(1,"As I suspected, he had already left"),
testE2C(2,"Because I suspected, he had already left"),
testE2C(2,"I suspected, he had already left"),
testE2C(2,"I suspected"),
testE2C(1,"Some grammars are better than others, as we have proved"),
testE2C(1,"As had been expected, the party was a big success"),
testE2C(2,"As had been green, the party was a big success"),
testE2C(2,"As had wanted to be expected, the party was a big success"),
testE2C(2,"As had expected the party to be a success, it was a success"),
testE2C(1,"In the event that the case goes to trial, I'm sure Clinton will be acquitted"),
testE2C(2,"In the scandal that the case goes to trial, I'm sure Clinton will be acquitted"),
testE2C(1,"He should be acquitted, on the grounds that there's no evidence"),
testE2C(1,"The public seem to love him, no matter what he does"),
testE2C(2,"The public seem to love him, no matter the stupid things he does"),

startE2CTest("COORDINATING CONJUNCTIONS"),

testE2C(1,"I went to the store and got a gallon of milk"),
testE2C(2,"I got and went a gallon of milk"),
testE2C(1,"I got a gallon of milk and some eggs"),
testE2C(1,"I went to the store, got a gallon of milk, and returned the eggs"),
testE2C(2,"I went to the store, got a gallon of milk, and some eggs"),
testE2C(1,"Mary, Joe and Louise are coming to the party"),
testE2C(1,"Neither Mary nor Louise are coming to the party"),
testE2C(1,"I am ready and eager to go to the party"),
testE2C(1,"She handled it skillfully and with compassion"),
testE2C(1,"I told him that I hated him and that I never wanted to see him again"),
testE2C(1,"He told me why he was here and what he was doing"),
testE2C(2,"He told me why he was here and that he hated me"),
testE2C(1,"Although he likes me and he respects me, he says he needs some privacy"),
testE2C(1,"Your house and garden are very attractive"),
testE2C(1,"I am in New York and I would like to see you"),
testE2C(1,"This is not the man we know and love"),
testE2C(2,"This is not the man we know and love him"),
testE2C(1,"The coverage on TV and on the radio has been terrible"),
testE2C(2,"The coverage on TV and I have seen has been terrible"),
testE2C(1,"The sky is blue, so it is likely that Joe will come"),
testE2C(2,"It is blue and likely that Joe will come"),
testE2C(1,"That is the man for whom and with whom Joe works"),
testE2C(2,"That is the man for whom and with Janet Joe works"),
testE2C(2,"When did Joe and John did leave the party"),
testE2C(1,"My dog, cat, and cousin's friend came"),
testE2C(2,"My dog, cat, horse, mouse, and his cow left"),
testE2C(1,"My dog, cat, horse, and mouse, and his cow left"),
testE2C(1,"you should not only ask for your money back, but demand it"),
testE2C(1,"I was both angry and sad at the same time"),

startE2CTest("PLURALIZATION IN CONJUNCTIONS"),

testE2C(1,"There is neither a dog nor a cat here"),
testE2C(2,"There are neither a dog nor a cat here"),
testE2C(1,"There is a dog or a cat here"),
testE2C(2,"There are a dog or a cat here"),
testE2C(2,"There are a dog and a cat here"),
testE2C(1,"There is a dog and a cat here"),
testE2C(1,"He and I are friends"),
testE2C(1,"neither I nor my friend knows what happened"),
testE2C(1,"neither I nor my friend know what happened"),
testE2C(1,"Either I or my friend knows what happened"),
testE2C(1,"Either I or my friend know what happened"),
testE2C(1,"The dog and cats know what happened"),
testE2C(2,"The dog and cats knows what happened"),
testE2C(1,"Are a dog and a cat here"),
testE2C(2,"Is a dog and a cat here"),
testE2C(2,"Is John and I invited"),
testE2C(1,"Are John and I invited"),
testE2C(1,"Is John or I invited"),
testE2C(1,"Are John or I invited"),
testE2C(1,"Is neither John nor I invited"),
testE2C(1,"Are neither John nor I invited"),

startE2CTest("GERUNDS"),

testE2C(1,"Playing the piano bothers John"),
testE2C(1,"Releasing the program at this point would annoy our competitors"),
testE2C(1,"The playing of the piano really bothers John"),
testE2C(2,"The playing the piano really bothers John"),
testE2C(1,"Telling Joe about the party would create a real problem"),
testE2C(2,"The telling Joe about the party could create a real problem"),
testE2C(1,"Your telling Joe about the party could create a real problem"),
testE2C(1,"Telling Joe that Sue was coming to the party would create a real problem"),
testE2C(1,"Telling would create a real problem"),
testE2C(1,"I want her to know about it, but the telling won't be easy"),
testE2C(2,"The telling her won't be easy"),
testE2C(2,"Some children like to tease"),
testE2C(1,"Teasing can be very cruel"),
testE2C(1,"Your telling John to leave may have destroyed your relationship"),
testE2C(1,"The graduating of Fred changes the situation"),
testE2C(1,"The sleeping of students is becoming a big problem"),
testE2C(1,"The sleeping of students can ruin a lecture"),
testE2C(1,"Buying of shares was brisk on Wall Street today"),
testE2C(1,"The sleeping in class is becoming a big problem"),
testE2C(2,"The telling John to leave was stupid"),
testE2C(2,"The inviting your mother was stupid"),
testE2C(2,"The showing how to use the program seemed to interest people"),
testE2C(2,"The attempting to go to the party angered Joe"),
testE2C(1,"The showing of the program seemed to impress people"),
testE2C(1,"The sleeping of students described by Fred is a big problem"),
testE2C(1,"The sleeping of students I told you about is a big problem"),
testE2C(1,"The frequent sleeping of students is a big problem"),
testE2C(1,"His hitting of the dog didn't help matters"),
testE2C(1,"Some hitting of dogs will solve the problem"),
testE2C(1,"the drug running here has become a massive problem"),
testE2C(1,"He made a mistake in inviting John"),
testE2C(1,"He made a mistake in the inviting of John"),
testE2C(1,"I should have talked to you before inviting John"),
testE2C(1,"I should have talked to you before the inviting of John"),

startE2CTest("SPECIAL SUBJECTS: INFINITIVES, CLAUSES, AND INDIRECT QUESTIONS"),

testE2C(1,"To pretend that our program is usable in its current form would be silly"),
testE2C(2,"To pretend that our program is usable in its current form would be happy"),
testE2C(1,"That our program will be immediately accepted is hardly likely"),
testE2C(2,"That our program will be immediately accepted wrote the program"),
testE2C(2,"Is that our program will be accepted likely"),
testE2C(2,"That our program will be accepted seems likely that our program will be accepted"),
testE2C(1,"Whether we should go to the party is the important question"),
testE2C(2,"Whether we should go to the party annoys me"),

startE2CTest("LONGER CONSTRUCTIONS, PUNCTUATION, AND CAPITALIZATION"),

testE2C(1,"Using the conventional Minuet form, Beethoven produced a piece of great originality"),
testE2C(1,"Written in 1820, the symphony shows a new level of maturity for the composer"),
testE2C(1,"Abandoned by his friends, he left Vienna three years later"),
testE2C(1,"In Vienna, Beethoven met someone who would later be greatly influenced by him: Franz Schubert"),
testE2C(2,"In Vienna, Beethoven met someone who would later be greatly influenced by him; Franz Schubert"),
testE2C(1,"Today I did something very important: I bought a dog"),
testE2C(2,"The store where I did something very important: I bought a dog was closed today"),
testE2C(1,"It has been said that Schubert ran out of the room when he met Beethoven; but we now know this is untrue"),
testE2C(1,"An important question remains: did Beethoven know about Schubert's music"),
testE2C(1,"She just wanted one thing: to be a professional skater"),
testE2C(1,"She knew one thing: that she would be a professional skater"),
testE2C(1,"I agree that, in some ways, your program is better"),
testE2C(1,"I agree that in some ways, your program is better"),
testE2C(2,"I agree that, in some ways your program is better"),
testE2C(1,"That is the man who, in Joe's opinion, we should hire"),
testE2C(2,"That is the man, in Joe's opinion, we should hire"),
testE2C(2,"That is the man who, in Joe's opinion we should hire"),
testE2C(1,"I know you hate Bill, but why did you send him that nasty note"),
testE2C(2,"I know you hate Bill, because why did you send him that nasty note"),
testE2C(1,"But why did you send him that nasty note"),
testE2C(1,"If John was with Lisa last night, who went to the movie with Diane"),
testE2C(2,"Although John was with Lisa last night, who went to the movie with Diane"),
testE2C(1,"We need a President who understands us"),
testE2C(1,"We need a president who understands us"),
testE2C(2,"We need a Melvin who understand us"),
testE2C(1,"The Zongle of Bongle Dongle resigned today"),
testE2C(2,"A Zongle with a Bongle Dongle resigned today"),
testE2C(1,"The National Association of Linguists is meeting here"),
testE2C(2,"An Association that many Linguists belong to is meeting here"),
testE2C(1,"An association that many linguists belong to is meeting here"),
testE2C(1,"If you were a middle-class American without a job, who would you vote for"),
testE2C(1,"Many Croats who had fled their homes are now returning to them"),
testE2C(2,"Many Croat who had fled their homes are now returning to them"),
testE2C(1,"Chinese is a wonderful language, Chinese food is nice, and the Chinese are nice people"),
testE2C(2,"Armenian is a wonderful language, Armenian food is great, and the Armenian are nice people"),
testE2C(1,"Armenian is a wonderful language, Armenian food is great, and the Armenians are nice people"),
testE2C(1,"Danish is a wonderful language, Danish food is great, and the Danish are nice people"),
testE2C(1,"The Danes are nice people"),
testE2C(1,"Dr Jane Smith lives on Main St"),
testE2C(1,"Dr. Jane Smith lives on Main St"),
testE2C(2,"Dr. Jane. Smith. lives on Main. St"),
testE2C(1,"Dr. J.G.D. Smith lives on Main St"),
testE2C(2,"A Dr. lives on this St"),
testE2C(1,"Mr. Smith (a lawyer for Kodak) refused to comment"),
testE2C(1,"Mr. Smith -- a lawyer for Kodak -- refused to comment"),
testE2C(1,"We left (carrying the dog) and Fred followed"),
testE2C(1,"I have $50, but I want a $50000 car"),
testE2C(1,"10% of the employees here do 90% of the work"),
testE2C(1,"Zangbert stock fell 30% to $2.50 yesterday, but jumped 10% today in heavy trading"),
testE2C(2,"Zangbert stock fell %, but jumped to $ today"),
testE2C(1,"With a 5% raise, I can get a $50000 car"),
testE2C(1,"\"What are you doing?\" she asked"),
testE2C(1,"\"This is what I'm going to do,\" he replied"),
testE2C(1,"\"This is what I'm going to do!\" he replied"),
testE2C(2,"\"This is what I'm going to do.\" he replied"),
testE2C(2,"\"This is what I'm doing to do\" he replied"),
testE2C(1,"\"On second thought,\" he said, \"this is what I'm going to do\""),
testE2C(1,"\"Quotation marks\" are simply \"ignored\" by our \"program\""),
testE2C(1,"Sometimes, people do this: They follow the colon with a capital letter"),
testE2C(2,"However, they never do this; They don't follow a semi-colon with a capital letter"),
testE2C(1,"John said: \"This is another use of colons one sometimes sees\""),
testE2C(1,"Formerly, he had worked for Brody, McGill & Demson"),
testE2C(2,"He was unhappy & underpaid "),
testE2C(1,"The rally, at 6:00 last night, was attended by 1.1 million people"),

startE2CTest("DONE"),runhistests.



% The various grammar qualifying tests are given below.  
%
% Tests t1,t2,... should parse successfully.  
% Tests f1,f2,... should show parse failures.
% Tests q1,q2,... should be successful querys.  
% Tests r1,r2,... should be unsuccessful querys.  

runhistests:-testE2C(t1, parse([the,men,cry])),
testE2C(t2, parse([the,man,cries])),
testE2C(t3, parse([the,man,saw,the,dogs])),
testE2C(t4, parse([he,wants,the,dog])),
testE2C(t5, parse([he,wants,to,be,happy])),
testE2C(t6, parse([he,wants,the,man,to,see,the,dog])),
testE2C(t7, parse([he,is,happy,to,be,a,dog])),
testE2C(t8, parse([i,saw,the,happy,red,saw])),
testE2C(t9, parse([he,saw,the,man,saw,the,wood,with,the,saw])),
testE2C(t10 , parse([jack,goes,to,see,the,fish])),
testE2C(t11 , parse([i,will,hide,my,hat,in,the,drawer])),
testE2C(t12 , parse([i,hid,my,hat,in,the,drawer])),
testE2C(t13 , parse([i,was,hiding,my,hat,in,the,drawer])),
testE2C(t14 , parse([my,hat,will,be,hidden,in,the,drawer])),
testE2C(t15 , parse([my,hat,was,hidden,in,the,drawer])),
testE2C(t16 , parse([my,hat,was,being,hidden,in,the,drawer])),
testE2C(t17 , parse([my,hat,is,hidden,in,the,drawer])),
testE2C(t18 , parse([i,can,see,the,house])),
testE2C(t19 , parse([i,will,have,seen,the,house])),
testE2C(t20 , parse([i,was,watching,the,movie])),
testE2C(t21 , parse([i,should,have,been,watching,the,movie])),
testE2C(t22 , parse([he,was,sad,to,see,the,man,cry,to,the,fish])),
testE2C(t23 , parse([jack,has,to,see,a,doctor])),
testE2C(t24 , parse([the,cat,had,to,be,found])),
testE2C(t25 , parse([john,has,to,be,winning,the,race])),
testE2C(t26 , parse([the,book,would,have,had,to,have,been,found,by,jack])),
testE2C(t27 , parse([i,love,you])),
testE2C(t28 , parse([you,love,me])),
testE2C(t29 , parse([you,love,yourselves])),
testE2C(t30 , parse([i,think,that,you,loved,me])),
testE2C(t31 , parse([jack,thought,of,jill])),
testE2C(t32 , parse([it,seems,that,jack,is,a,man])),
testE2C(t33 , parse([jack,was,seen,by,jill])),
testE2C(t34 , parse([jack,was,seen])),
testE2C(t35 , parse([jack,can,see,the,dog])),
testE2C(t36 , parse([jill,saw,that,jack,was,a,man])),
testE2C(t37 , parse([jack,bought,a,ticket])),
testE2C(t38 , parse([a,ticket,was,bought,by,jill])),
testE2C(t39 , parse([jill,gave,jack,a,ticket])),
testE2C(t40 , parse([jill,gave,a,ticket,to,jack])),
testE2C(t41 , parse([jill,thinks,that,jack,stole,the,book])),
testE2C(t42 , parse([jack,will,be,seen,going,to,the,house])),
testE2C(t43 , parse([jack,was,seen,laughing])),
testE2C(t44 , parse([the,man,in,the,corner,was,crying])),
testE2C(t45 , parse([jill,was,crying,in,the,corner])),
testE2C(t46 , parse([george,said,that,henry,left,in,the,car])),
testE2C(t47 , parse([i,wanted,the,dog,in,the,house])),
testE2C(t48 , parse([i,kept,the,dog,in,the,house])),
testE2C(t49 , parse([i,put,the,dog,in,the,house])),
testE2C(t50 , parse([we,painted,all,the,walls,with,cracks])),
testE2C(t51 , parse([the,horse,raced,past,the,barn,fell])),
testE2C(t52 , parse([the,horse,that,was,raced,past,the,barn,fell])),
testE2C(t53 , parse([have,the,students,who,missed,the,exam,take,it,today])),
testE2C(t54 , parse([have,the,students,who,missed,the,exam,taken,it,today])),
testE2C(t55 , parse([i,saw,the,man,in,the,house,with,a,telescope])),
testE2C(t56 , parse([he,wants,to,go,home,quickly])),
testE2C(t57 , parse([he,wants,to,go,quickly,home])),
testE2C(t58 , parse([he,wants,to,quickly,go,home])),
testE2C(t59 , parse([he,wants,quickly,to,go,home])),
testE2C(t60 , parse([he,quickly,wants,to,go,home])),
testE2C(t61 , parse([jack,was,pleased,with,the,prize])),
testE2C(t62 , parse([who,are,they])),
testE2C(t63 , parse([who,ate,the,pizza])),
testE2C(t64 , parse([what,did,you,put,the,book,in])),
testE2C(t65 , parse([what,book,did,he,steal])),
testE2C(t66 , parse([where,did,you,put,the,book])),
testE2C(t67 , parse([how,quickly,did,he,run])),
testE2C(t68 , parse([whose,book,did,you,find])),
testE2C(t69 , parse([in,what,store,did,you,buy,the,picture])),
testE2C(t70 , parse([i,am,the,man,who,you,saw,at,the,store])),
testE2C(t71 , parse([i,destroyed,the,exam,in,which,you,found,the,error])),
testE2C(t72 , parse([i,am,the,man,whose,book,you,stole])),
testE2C(t73 , parse([this,is,the,paper,jack,read])),
testE2C(t74 , parse([this,is,the,damage,caused,by,the,storm])),
testE2C(t75 , parse([this,is,the,issue,creating,the,argument])),
testE2C(t76 , parse([the,man,who,we,saw,cried])),
testE2C(t77 , parse([this,is,the,mouse,that,the,cat,ate])),
testE2C(t78 , parse([the,paper,jack,read,is,here])),
testE2C(t79 , parse([the,man,gave,bill,the,money])),
testE2C(t80 , parse([george,gave,the,rug,to,ernest])),
testE2C(t81 , parse([george,gave,the,money,to,the,man])),
testE2C(t82 , parse([bill,was,given,the,money,by,the,man])),
testE2C(t83 , parse([the,rug,was,given,to,ernest,by,george])),
testE2C(t84 , parse([the,money,was,given,to,the,man,by,george])),
testE2C(t85 , parse([the,man,bill,was,given,the,money,by,is,here])),
testE2C(t86 , parse([the,rug,that,was,given,to,ernest,by,george,is,red])),
testE2C(t87 , parse([the,man,whom,the,money,was,given,to,by,george,is,rich])),
testE2C(t88 , parse([where,are,you])),
testE2C(t89 , parse([where,am,i])),
testE2C(t90 , parse([there,were,many,people,at,the,game])),
testE2C(t91 , parse([few,cars,are,fast])),
testE2C(t92 , parse([a,few,cars,are,fast])),
testE2C(t93 , parse([few,of,the,cars,are,fast])),
testE2C(t94 , parse([very,few,of,the,cars,are,fast])),
testE2C(t95 , parse([a,few,of,the,cars,are,fast])),
testE2C(t96 , parse([all,cars,are,fast])),
testE2C(t97 , parse([all,the,cars,are,fast])),
testE2C(t98 , parse([all,of,the,cars,are,fast])),
testE2C(t99 , parse([who,should,we,invite,to,the,party])),
testE2C(t100 , parse([water,is,necessary,for,life])),
testE2C(t101 , parse([a,bunch,of,dogs,are,in,the,yard])),
testE2C(t102 , parse([a,bunch,of,dogs,is,in,the,yard])),
testE2C(t103 , parse([bunches,of,dogs,are,in,the,yard])),
testE2C(f1, parse([*,the,men,cries])),
testE2C(f2, parse([*,the,man,cry])),
testE2C(f3, parse([*,the,man,saw,to,be,happy])),
testE2C(f4, parse([*,he,wants])),
testE2C(f5, parse([*,he,wants,the,man,saw,the,dog])),
testE2C(f6, parse([*,he,see,the,man])),
testE2C(f7, parse([*,i,have,should,been,watching,the,movie])),
testE2C(f8, parse([*,i,go,caught,fish])),
testE2C(f9, parse([*,you,was,hiding,in,the,drawer])),
testE2C(f10 , parse([*,jack,can,hidden])),
testE2C(f11 , parse([*,jack,has,to,have,to,see,a,doctor])),
testE2C(f12 , parse([*,john,had,to,played,the,violin])),
testE2C(f13 , parse([*,jack,would,to,go,to,the,movies])),
testE2C(f14 , parse([*,eat,john,the,pizza])),
testE2C(f15 , parse([*,me,love,you])),
testE2C(f16 , parse([*,you,love,you])),
testE2C(f17 , parse([*,yourself,loves,me])),
testE2C(f18 , parse([*,he,has,might,see,the,movie,already])),
testE2C(f19 , parse([*,jack,was,seen,flown,to,his,house])),
testE2C(f20 , parse([*,we,saw,that,was,man])),
testE2C(f21 , parse([*,jack,was,seen,go])),
testE2C(f22 , parse([*,my,hat,was,being,hidden,the,dog,in,the,drawer])),
testE2C(f23 , parse([*,the,man,in,corner,had,a,violin])),
testE2C(f24 , parse([*,he,wants,to,go,home,happy])),
testE2C(f25 , parse([*,he,wants,to,happy,go,home])),
testE2C(f26 , parse([*,he,happy,wants,to,go,home])),
testE2C(f27 , parse([*,who,are,i])),
testE2C(f28 , parse([*,it,is,house])),
testE2C(f29 , parse([*,where,am,you])),
testE2C(f30 , parse([*,where,are,i])),
testE2C(f31 , parse([*,few,car,are,fast])),
testE2C(f32 , parse([*,few,cars,is,fast])),
testE2C(f33 , parse([*,a,few,car,are,fast])),
testE2C(f34 , parse([*,all,a,cars,are,fast])),
testE2C(f35 , parse([*,many,all,cars,are,fast])),
testE2C(f36 , parse([*,waters,is,necessary,for,life])),
testE2C(f37 , parse([*,bunches,of,dogs,is,in,the,yard])),
testE2C(f38 , parse([*,bunch,of,dogs,are,in,the,yard])),
testE2C(f39 , parse([*,bunch,of,dogs,is,in,the,yard])),
testE2C(q1, parse([did,you,see,the,car])),
testE2C(q2, parse([can,i,catch,it])),
testE2C(q3, parse([did,i,eat,the,pizza])),
testE2C(q4, parse([did,the,boy,climb,in,the,window])),
testE2C(q5, parse([do,i,have,a,pen])),
testE2C(q6, parse([did,you,see,the,cat])),
testE2C(q7, parse([can,i,try,it])),
testE2C(q8, parse([is,the,boy,hiding])),
testE2C(q9, parse([is,the,boy,hidden])),
testE2C(q10 , parse([is,the,boy,at,home])),
testE2C(q11 , parse([are,the,boys,all,men])),
testE2C(q12 , parse([is,it,necessary,for,jack,to,go,to,the,store])),
testE2C(q13 , parse([was,jack,a,man])),
testE2C(q14 , parse([are,the,boys,in,the,house])),
testE2C(q15 , parse([are,the,boys,playing])),
testE2C(q16 , parse([are,the,boys,playing,with,the,house])),
testE2C(q17 , parse([where,am,i,going])),
testE2C(q18 , parse([what,are,you,doing])),
testE2C(q19 , parse([what,do,you,do])),
testE2C(q20 , parse([why,do,you,want,to,do,that])),
testE2C(q21 , parse([were,there,many,people,at,the,game])),
testE2C(q22 , parse([what,did,you,put,in,the,cupboard])),
testE2C(q23 , parse([why,did,you,put,the,bottle,in,the,cupboard])),
testE2C(r1 , parse([*,can,the,boys,in,the,house])),
testE2C(r2 , parse([*,where,do,i,going])),
testE2C(r3 , parse([*,what,am,you,doing])),
testE2C(r3 , parse([*,what,are,you,do])),
testE2C(r4 , parse([*,what,did,you,put,the,bottle,in,the,cupboard])).

% "It isn't very wide, and the light beige walls have been rounded, making the corridor an oval shape"
runMudTest:-
testE2C('NpcCol1004-Troi712',"Counselor Deanna Troi is here"),
testE2C('Area1008',"It isn't very wide, and the light beige walls have been rounded, making the corridor an oval shape"),
testE2C('NpcCol1002-Worf720',"Lieutenant Worf is here, looking pretty mean"),
testE2C('NpcCol1001-Data672',"Lieutenant Commander Data is here, trying to be more human"),
testE2C('Area1028',"Two large windows offer a great view of space"),
testE2C('Area1012',"It's quite a large room, with a very high ceiling and a lot of floor space"),
testE2C('Area1032',"Several vertical rows of lights make this place very well lit"),
testE2C('Area1026',"A thick stack of mats have been piled high in one corner, which can be used for different activities"),
testE2C('Area1033',"From here, you can access the other decks on the Enterprise"),
testE2C('Area1034',"You're in the turbolift"),
testE2C('Area1023',"Several different paintings have been hung from the walls, and a small couch and a recliner are positioned around a coffee table"),
testE2C('Area1027',"You find yourself in the middle of a well lit corridor on the Enterprise"),
testE2C('Area1039',"You feel very cold"),
testE2C('Area1004',"A computer control panel is situated in the northwestern corner of the room, which is where the force fields for the cells are controlled"),
testE2C('Area1020',"Three long tables surrounded by chairs stretch across the room"),
testE2C('Area1037',"A large glass rectangular table sits in the middle of the room, surrounded by about a dozen comfortable looking office chairs"),
testE2C('Area1015',"A large glass window in the northern part of the room separates the doctor's office with the rest of the room"),
testE2C('Area1010',"You're in the turbolift"),
testE2C('Area1008',"You see the holodeck's control panel beside the holodeck door, and it has some information on it"),
testE2C('Area1040',"You're floating in outer space right above the USS Enterprise"),
testE2C('NpcCol1006-Picard701',"Captain Jean-Luc Picard is standing here, watching you"),
testE2C('Area1011',"You're in the turbolift"),
testE2C('Area1012',"You can see several hundred plastic crates and barrels with the Starfleet insignia on them stacked right up to the ceiling"),
testE2C('Area1026',"Captain Picard likes to come here to practice his fencing"),
testE2C('Area1034',"Several vertical rows of lights make this place very well lit"),
testE2C('Area1002',"You find yourself in the middle of a well lit corridor on the Enterprise"),
testE2C('Area1003',"You're in the middle of Data's quarters"),
testE2C('Area1014',"You've arrived in Riker's quarters"),
testE2C('Area1023',"A neatly made bed is partially hidden behind a curtain at the northern part of the room"),
testE2C('Area1027',"It isn't very wide, and the light beige walls have been rounded, making the corridor an oval shape"),
testE2C('Area1039',"A large grey door leads into the Enterprise's Shuttle Bay"),
testE2C('Area1031',"You can see several hundred plastic crates and barrels with the Starfleet insignia on them stacked right up to the ceiling"),
testE2C('NpcCol1012-Ensign748',"A nervous looking ensign is standing here, watching you"),
testE2C('Area1018',"You're in Doctor Crusher's quarters"),
testE2C('Area1010',"The turbolift walls have been rounded off, making it in the shape of a tube"),
testE2C('Area1006',"You're in the Enterprise transporter room"),
testE2C('NpcCol1012-Ensign732',"A nervous looking ensign is standing here, watching you"),
testE2C('Area1039',"You're floating in outer space right beside the USS Enterprise"),
testE2C('Area1011',"The turbolift walls have been rounded off, making it in the shape of a tube"),
testE2C('Area1028',"A small partition at the northern part of the room contains Picard's sleeping area"),
testE2C('Area1037',"This is where the senior officers of the Enterprise meet and discuss important issues"),
testE2C('Area1038',"You find yourself on the lower half of the main bridge of the USS Enterprise"),
testE2C('Area1002',"It isn't very wide, and the light beige walls have been rounded, making the corridor an oval shape"),
testE2C('Area1003',"Some easils and paintings have been left scattered around the southern part of the room, while a huge computer screen showing a cross section of the Enterprise covers the entire northern wall"),
testE2C('Area1014',"The room is very neat and tidy, with a couch and several chairs aranged around a coffee table by the eastern wall"),
testE2C('Area1022',"You're in the main shuttle bay of the Enterprise"),
testE2C('Area1038',"This is where the ship's pilot and information officer sit"),
testE2C('NpcCol1000-Geordi684',"Lieutenant Commander Geordi LaForge is standing here"),
testE2C('Area1038',"This is where the Captain, Commander Riker, and Counselor Troi sit"),
testE2C('Area1029',"A strange looking machine sits in the middle of the room, up on a slightly raised platform"),
testE2C('Area1034',"From here, you can access the other decks on the Enterprise"),
testE2C('Area1010',"Several vertical rows of lights make this place very well lit"),
testE2C('Area1036',"You find yourself on the upper half of the main bridge of the USS Enterprise"),
testE2C('Area1006',"A computer terminal is sitting near the southern wall, where the transporter chief can control the transporters"),
testE2C('Area1011',"Several vertical rows of lights make this place very well lit"),
testE2C('Area1038',"Two computer consoles with built in chairs rest about ten feet in front of the chairs, also facing the view screen"),
testE2C('Area1021',"You're now in Ten Forward, the entertainment room of the Enterprise"),
testE2C('Area1038',"Three large chairs in the northern part of the room, in front of the railing, face the screen"),
testE2C('Area1038',"An enormous view screen covers almost the entire northern wall, and is currently displaying a view of the stars rushing by"),
testE2C('Area1018',"Several different paintings are attached to the walls, and you also notice a few sculptures"),
testE2C('Area1003',"In front of the screen is a large desk, which is covered in computer controls"),
testE2C('Area1014',"A small partition at the northern part of the room seperates his sleeping area with the rest of the room"),
testE2C('Area1022',"It's quite a large room, with a very high ceiling and a lot of floor space"),
testE2C('NpcCol1003-Dr-Crusher677',"Lieutenant Beverly Crusher is here, looking for someone to heal"),
testE2C('Area1037',"The entire eastern wall is covered with windows, looking out into space"),
testE2C('Area1035',"A small computer screen is sitting on the desk, as well as several other papers and documents"),
testE2C('Area1029',"It looks as though something (or someone) could be placed inside, hooked up to the multitude of wires and cables, and have scientific tests performed on it(or them)"),
testE2C('Area1000',"You find yourself in the middle of main engineering"),
testE2C('Area1010',"From here, you can access the other decks on the Enterprise"),
testE2C('Area1036',"Directly in front of you is a thick railing that contains many different computer panels used for the tactical systems of the ship"),
testE2C('Area1006',"Eight round transport pads have been arranged in a circle, on a raised platform against the northern wall"),
testE2C('Area1030',"You find yourself in the middle of a well lit corridor on the Enterprise"),
testE2C('Area1017',"You emerge into a dark narrow alley"),
testE2C('Area1011',"From here, you can accessthe other decks on the Enterprise"),
testE2C('Area1005',"You find yourself in the middle of a well lit corridor on the Enterprise"),
testE2C('Area1021',"The entire northern wall is covered with windows looking out into space, while two large wooden doors with the Starfleet insignia stamped on them face south"),
testE2C('Area1007',"You step through the doors and find yourself in a large school room"),
testE2C('Area1016',"You find yourself in the middle of a well lit corridor on the Enterprise"),
testE2C('Area1003',"You can't see a bed in this room, but you figure it's because Data doesn't sleep"),
testE2C('NpcCol1012-Ensign752',"A nervous looking ensign is standing here, watching you"),
testE2C('Area1022',"You can see three different shuttle crafts sitting here, waiting to be flown"),
testE2C('Area1024',"You find yourself in the middle of a well lit corridor on the Enterprise"),
testE2C('Area1040',"You can see stars in every direction, which provide the only light here"),
testE2C('Area1013',"You find yourself in the middle of a well lit corridor on the Enterprise"),
testE2C('Area1029',"A complex looking computer console is facing this machine"),
testE2C('Area1000',"The room is longer than it is wide, and it has fairly low ceilings"),
testE2C('Area1035',"You're standing in Captain Picard's ready room"),
testE2C('Area1010',""),
testE2C('Area1036',"The entire southern wall is covered with computer consoles, where the ship's main systems are controlled"),
testE2C('Area1030',"It isn't very wide, and the light beige walls have been rounded, making the corridor an oval shape"),
testE2C('Area1001',"You're in the middle of Geordi's quarters"),
testE2C('Area1017',"Tall dark brick buildings block your way north and south"),
testE2C('NpcCol1012-Ensign736',"A nervous looking ensign is standing here, watching you"),
testE2C('Area1005',"It isn't very wide, and the light beige walls have been rounded, making the corridor an oval shape"),
testE2C('Area1021',"Many round metal tables are scattered around the room, surrounded by metal chairs"),
testE2C('Area1007',"Various tables and chairs are set up all around the room, and many paintings and drawings have been attached to the walls"),
testE2C('Area1016',"It isn't very wide, and the light beige walls have been rounded, making the corridor an oval shape"),
testE2C('Area1018',"A neatly made bed is located by the northern wall, in between two large windows looking out into space"),
testE2C('Area1022',"A large grey door leads into space"),
testE2C('Area1001',"The room is sparsely decorated, due to the fact that Geordi is blind"),
testE2C('Area1040',"You feel very cold"),
testE2C('Area1013',"It isn't very wide, and the light beige walls have been rounded, making the corridor an oval shape"),
testE2C('Area1035',"A single high window beside the desk looks into space, and a fish tank is located in the northwestern corner of the room"),
testE2C('Area1000',"Computer terminals cover all the walls, and a large table built into the floor sits in the middle of the room"),
testE2C('Area1035',"A long couch has been placed beside the door, while a large U shaped desk is located by the northern wall"),
testE2C('Area1036',"Two small curved ramps on either side of the room lead north to the lower part of the bridge, and a large circular skylight shows the space outside the ship"),
testE2C('Area1025',"You're in Worf's quarters"),
testE2C('Area1024',"It isn't very wide, and the light beige walls have been rounded, making the corridor an oval shape"),
testE2C('Area1017',"You can see that the windows on the buildings are fairly high, and some have been boarded up"),
testE2C('Area1005',"You notice a tiny computer panel embedded into the wall"),
testE2C('Area1021',"A long bar spans almost the entire length of the southern part of the room, and about two dozen bar stools are sitting in front of it"),
testE2C('Area1007',"Several computer consoles with a children's interface on them can be seen on the tables"),
testE2C('Area1016',"You see the holodeck's control panel beside the holodeck door, and it has some information on it"),
testE2C('Area1001',"A small personal computer sits on a desk against the western wall, in between two windows that look out into space"),
testE2C('Area1009',"You're now on Holodeck 2"),
testE2C('NpcCol1013-Alexander671',"Alexander Rozhenko is here, practicing laughing hour"),
testE2C('Area1013',"You notice a tiny computer panel embedded into the wall"),
testE2C('Area1000',"At the far end of the room you see the warp core, a large pulsating vertical tube"),
testE2C('Area1041',"You're floating in outer space right above the USS Enterprise"),
testE2C('Area1025',"A small table is sitting in the southeastern corner, and on it is a small potted plant"),
testE2C('Area1024',"You notice a tiny computer panel embedded into the wall"),
testE2C('Area1017',"The smell from the rotting food and garbage mixing with the foul water on the ground is unbearable"),
testE2C('NpcCol1012-Ensign744',"A nervous looking ensign is standing here, watching you"),
testE2C('Area1021',"It's very noisy in here, due to all the talking and laughing"),
testE2C('NpcCol1012-Ensign740',"A nervous looking ensign is standing here, watching you"),
testE2C('Area1032',"From here, you can access the other decks on the Enterprise"),
testE2C('Area1041',"You feel very cold"),
testE2C('Area1041',"You can see stars in every direction, which provide the only light here"),
testE2C('Area1028',"You find yourself standing by the door of Captain Picard's quarters"),
testE2C('Area1026',"You emerge into the Enterprise gym"),
testE2C('Area1033',"You're in the turbolift"),
testE2C('Area1009',"The room is just a large cube, with jet black walls and a yellow grid painted on the floors, the walls, and the ceiling"),
testE2C('NpcCol1011-Spot727',"Spot, Data's pet cat, is sitting here looking at you"),
testE2C('Area1042',"All you can see is blue flashing light"),
testE2C('Area1031',"You're in the cargo bay 2 of the Enterprise"),
testE2C('Area1028',"You can see several different ancient artifacts on tables and small pedestals, and a large wooden wardrobe is facing south"),
testE2C('Area1004',"You're in the dimly lit Brig"),
testE2C('Area1025',"An impressive selection of Klingon weapons have been mounted on the northern wall, and a partition splits this room with Worf's bedroom to the east"),
testE2C('Area1029',"Around the rest of the room are countertops with with the odd computer terminal"),
testE2C('Area1001',"A neatly made bed has been placed against the northern wall"),
testE2C('Area1017',"You can hear the sounds of a bustling marketpace to the east"),
testE2C('NpcCol1010-Livingston726',"Livingston the fish is here, swimming about in his tank"),
testE2C('NpcCol1012-Ensign728',"A nervous looking ensign is standing here, watching you"),
testE2C('NpcCol1005-Riker707',"Commander William Riker is here, staring at you"),
testE2C('Area1029',"You're in the Enterprise science lab"),
testE2C('Area1019',"You find yourself in the middle of a well lit corridor on the Enterprise"),
testE2C('Area1028',"He isn't very fond of visitors, but you decide to stay and have a look around"),
testE2C('Area1032',"You're in the turbolift"),
testE2C('Area1026',"The room is quite large, with a soft grey floor"),
testE2C('Area1033',"The turbolift walls have been rounded off, making it in the shape of a tube"),
testE2C('Area1009',"This is where different programs can be loaded and experienced, which seem totally real"),
testE2C('NpcCol1009-Wesley716',"Wesley Crusher is here, eagerly trying to earn your praise"),
testE2C('Area1042',"As you try to look down at your body, you realize that there's nothing there!"),
testE2C('Area1042',"It feels as though your body is racing around at high speeds"),
testE2C('Area1035',"This is where the Captain makes all of his important decisions"),
testE2C('Area1028',"A comfortable looking recliner with a matching footrest sits beside the door, along with a bright reading lamp and end table"),
testE2C('Area1004',"This is where all the criminals and prisoners are kept while on board the Enterprise"),
testE2C('Area1020',"You're standing in the dimly lit Enterprise Security"),
testE2C('Area1034',"The turbolift walls have been rounded off, making it in the shape of a tube"),
testE2C('Area1015',"You're in the middle of the Enterprise's Sick Bay"),
testE2C('Area1017',"The archway leading out of the holodeck is west"),
testE2C('NpcCol1008-OBrien696',"Chief O'Brien is here, waiting to teleport you somwhere"),
testE2C('Area1008',"You find yourself in the middle of a well lit corridor on the Enterprise"),
testE2C('Area1039',"You can see stars in every direction, which provide the only light here"),
testE2C('Area1019',"It isn't very wide, and the light beige walls have been rounded, making the corridor an oval shape"),
testE2C('Area1012',"You're in the main cargo bay of the Enterprise"),
testE2C('Area1032',"The turbolift walls have been rounded off, making it in the shape of a tube"),
testE2C('Area1026',"A set of lockers against the southern wall contain all of the necessary equipment needed for using the gym"),
testE2C('Area1033',"Several vertical rows of lights make this place very well lit"),
testE2C('Area1009',"Right now, this holodeck is not functioning"),
testE2C('Area1042',"You find yourself in a transporter beam"),
testE2C('Area1023',"You're in Counselor Deanna Troi's quarters"),
testE2C('Area1031',"It's quite a large room, with a very high ceiling and a lot of floor space"),
testE2C('Area1004',"Three fairly large cells can been seen in the southern part of the room, and they're all empty"),
testE2C('Area1020',"Weapons lockers cover all of the walls, except along the northern wall, where a large glass window protects dozens of different phasors, blaster rifles, and other high tech weapons"),
testE2C('Area1037',"You're in the conference room of the Enterprise"),
testE2C('Area1015',"About a dozen beds are arranged along the walls of the room, while several carts covered with medical supplies are scattered around the room"),!.


testNumbers:-
startE2CTest("NUMBERS"),

testE2C(1,"2 million attended "),
testE2C(1,"2863764 attended"),
testE2C(1,"2 million people attended"),
testE2C(2,"2 million person attended "),
testE2C(1,"a million attended "),
testE2C(1,"a million people attended "),
testE2C(1,"about 2 million people attended"),
testE2C(1,"about 2 million attended"),
testE2C(2,"about people attended"),
testE2C(1,"a million such people attended"),
testE2C(2,"a million such attended"),
testE2C(1,"5 million of the people attended"),
testE2C(1,"5 thousand invited by Bob attended"),
testE2C(1,"The 5 thousand invited by Bob attended"),
testE2C(1,"The thousands of people who attended enjoyed it"),
testE2C(1,"The 5 thousand people invited by Bob attended"),
testE2C(1,"The nearly 5 million people who attended enjoyed it"),
testE2C(1,"a few attended"),
testE2C(1,"a few million people attended"),
testE2C(1,"a few people attended"),
testE2C(1,"few attended"),
testE2C(2,"few million people attended"),
testE2C(1,"millions attended"),
testE2C(2,"5 millions attended"),
testE2C(1,"millions of people attended"),
testE2C(1,"hundreds of millions of people attended"),
testE2C(1,"5 million years ago, the earth was covered with ice"),
testE2C(1,"millions of years ago, the earth was covered with ice"),
testE2C(2,"dogs of years ago, the earth was covered with ice"),
testE2C(2,"the five million years ago, the earth was covered with ice"),
testE2C(2,"the other five million years ago, the earth was covered with ice"),
testE2C(2,"5 million ago, the earth was covered with ice"),
testE2C(1,"The city of New York contains over one hundred million billion brain cells"),
testE2C(1,"Almost one third of the people in the country have no health insurance"),
testE2C(1,"Of all the people in this country, almost one third have no health insurance"),
testE2C(1,"Three quarters of a million people in this city have no health insurance"),
testE2C(1,"The price of the stock rose three tenths of one point"),
testE2C(2,"The price of the stock rose three tenths of one dog"),
testE2C(1,"The nearest drug store is about three quarters of a mile away "),
testE2C(1,"The nearest drug store is about 3/4 of a mile away "),
testE2C(1,"Every morning I walk 3 1/2 miles"),
testE2C(2,"Every morning I walk 1/2 3 miles"),
testE2C(1,"Nearly 1/2 million people work here every day"),
testE2C(1,"Nearly 1 1/4 million people work here every day"),
testE2C(2,"Nearly 1 million 1/4 people work here every day"),
testE2C(1,"Between 500 and 1000 people pass through here every minute"),
testE2C(1,"They are the Number 3 auto maker and a Fortune 500 company"),
testE2C(1,"I live at 805 West Indiana Street"),!.

