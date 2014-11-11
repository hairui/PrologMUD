

:-asserta(in_motel_kb(fssKB)).

'sb_defenv'('fssKB','What means fss?').
%'sb_initenv'('fssKB').
'sb_primconcept'('lexicon', ['supers'(['sbone'])]).
'sb_primconcept'('fss', ['supers'(['sbone'])]).
'sb_primconcept'('pointing', ['supers'(['fss'])]).
'sb_primconcept'('vague_p', ['supers'(['pointing'])]).
'sb_primconcept'('standard_p', ['supers'(['pointing'])]).
'sb_primconcept'('encircling_p', ['supers'(['pointing'])]).
'sb_primconcept'('exact_p', ['supers'(['pointing'])]).
'sb_primconcept'('time', ['supers'(['fss'])]).
'sb_primconcept'('moment', ['supers'(['time'])]).
'sb_primconcept'('period', ['supers'(['time'])]).
'sb_primconcept'('interval', ['supers'(['time'])]).
'sb_primconcept'('yearly', ['supers'(['interval'])]).
'sb_primconcept'('jaehrlich', ['supers'(['yearly', 'lexicon'])]).
'sb_primconcept'('weekly', ['supers'(['interval'])]).
'sb_primconcept'('woechentlich', ['supers'(['lexicon', 'weekly'])]).
'sb_primconcept'('daily', ['supers'(['interval'])]).
'sb_defconcept'('taeglich', ['supers'(['daily', 'lexicon'])]).
'sb_primconcept'('monthly', ['supers'(['interval'])]).
'sb_defconcept'('monat', ['supers'(['monthly', 'lexicon'])]).
'sb_primconcept'('speech_act', ['supers'(['fss'])]).
'sb_primconcept'('order', ['supers'(['speech_act'])]).
'sb_primconcept'('assertion', ['supers'(['speech_act'])]).
'sb_primconcept'('question', ['supers'(['speech_act'])]).
'sb_primconcept'('interjection', ['supers'(['speech_act'])]).
'sb_primconcept'('determiner', ['supers'(['fss'])]).
'sb_defconcept'('d', ['supers'(['determiner', 'lexicon'])]).
'sb_primconcept'('indefinite', ['supers'(['determiner'])]).
'sb_defconcept'('ein', ['supers'(['indefinite', 'lexicon'])]).
'sb_primconcept'('cardinal', ['supers'(['indefinite'])]).
'sb_defconcept'('number35', ['supers'(['cardinal', 'lexicon'])]).
'sb_primconcept'('number50', ['supers'(['cardinal', 'lexicon'])]).
'sb_defconcept'('fuenfunddreissig', ['supers'(['cardinal', 'lexicon'])]).
'sb_primconcept'('interrogative', ['supers'(['determiner'])]).
'sb_primconcept'('definite', ['supers'(['determiner'])]).
'sb_primconcept'('demonstrative', ['supers'(['definite'])]).
'sb_defconcept'('der', ['supers'(['definite', 'lexicon'])]).
'sb_defconcept'('die', ['supers'(['definite', 'lexicon'])]).
'sb_primconcept'('possessive', ['supers'(['definite'])]).
'sb_defconcept'('dem', ['supers'(['lexicon', 'definite'])]).
'sb_defconcept'('mein', ['supers'(['lexicon', 'determiner'])]).
'sb_primconcept'('property_filler', ['supers'(['fss'])]).
'sb_primconcept'('adjective_property', ['supers'(['property_filler'])]).
'sb_primconcept'('truth_value', ['supers'(['adjective_property'])]).
'sb_defconcept'('abstract_thing', ['supers'(['thing']), 'nr'('sb_primelemrole'('truth_mod', 'domain-range'('abstract_thing', 'truth_value', 'bot')), 1, 1, 1)]).
'sb_primconcept'('name', ['supers'(['abstract_thing'])]).
'sb_defconcept'('thing', ['supers'(['property_filler']), 'nr'('sb_primelemrole'('det', 'domain-range'('thing', 'determiner', 'bot')), 1, 1, 1), 'nr'('sb_primelemrole'('deictic_mod', 'domain-range'('thing', 'pointing', 'bot')), 1, 1, 1), 'nr'('sb_primelemrole'('named', 'domain-range'('thing', 'name', 'bot')), 1, 1, 1)]).
'sb_defconcept'('predicate', ['supers'(['fss']), 'nr'('sb_primelemrole'('subject', 'domain-range'('predicate', 'thing', 'bot')), 1, 1, 1), 'nr'('sb_primelemrole'('purpose', 'domain-range'('predicate', 'predicate', 'bot')), 1, 1, 1), 'nr'('sb_primelemrole'('time', 'domain-range'('predicate', 'time', 'bot')), 1, 1, 1), 'nr'('sb_primelemrole'('illoc', 'domain-range'('predicate', 'speech_act', 'bot')), 1, 1, 1), 'nr'('sb_primelemrole'('cause', 'domain-range'('predicate', 'predicate', 'bot')), 1, 1, 1), 'nr'('sb_primelemrole'('result', 'domain-range'('predicate', 'thing', 'bot')), 1, 1, 1), 'nr'('sb_primelemrole'('location', 'domain-range'('predicate', 'thing', 'bot')), 1, 1, 1), 'necres'('subject', 'nec')]).
'sb_primconcept'('state', ['supers'(['predicate']), 'restrict_inh'('time_state', 'restricts'('time', 'range'('period', 'bot')))]).
'sb_attributes'('state', 'subject', 'role_to_case'('nominativ')).
'sb_attributes'('state', 'location', 'role_to_case'('prep_stems'('in'))).
'sb_defconcept'('human', ['supers'(['animate']), 'nr'('sb_primelemrole'('volition', 'domain-range'('human', 'volitional_sq', 'bot')), 1, 1, 1)]).
'sb_defconcept'('geographical_object', ['supers'(['inanimate']), 'nr'('sb_primelemrole'('origin_mod', 'domain-range'('geographical_object', 'origin', 'bot')), 1, 1, 1)]).
'sb_primconcept'('wohn', ['supers'(['lexicon', 'state']), 'restrict_inh'('agent', 'restricts'('subject', 'range'('human', 'thing'))), 'restrict_inh'('location_wohn', 'restricts'('location', 'range'('geographical_object', 'bot')))]).
'sb_attributes'('wohn', 'agent', 'role_to_case'('nominativ')).
'sb_attributes'('wohn', 'location', 'role_to_case'('prep_stems'('in'))).
'sb_primconcept'('qualitative', ['supers'(['adjective_property'])]).
'sb_primconcept'('quality', ['supers'(['qualitative'])]).
'sb_primconcept'('colour', ['supers'(['quality'])]).
'sb_defconcept'('concrete_thing', ['supers'(['thing']), 'nr'('sb_primelemrole'('colour_mod', 'domain-range'('concrete_thing', 'colour', 'bot')), 1, 1, 1)]).
'sb_primconcept'('relation', ['supers'(['adjective_property'])]).
'sb_defconcept'('individual', ['supers'(['concrete_thing']), 'nr'('sb_primelemrole'('relative_mod', 'domain-range'('individual', 'relation', 'bot')), 1, 1, 1)]).
'sb_defconcept'('mass_noun', ['supers'(['concrete_thing'])]).
'sb_primconcept'('material', ['supers'(['mass_noun'])]).
'sb_defconcept'('inanimate', ['supers'(['individual']), 'nr'('sb_primelemrole'('material_mod', 'domain-range'('inanimate', 'material', 'bot')), 1, 1, 1)]).
'sb_primconcept'('weight', ['supers'(['quality'])]).
'sb_defconcept'('touchable_object', ['supers'(['inanimate']), 'nr'('sb_primelemrole'('weight_mod', 'domain-range'('touchable_object', 'weight', 'bot')), 1, 1, 1)]).
'sb_defconcept'('action', ['supers'(['predicate']), 'restrict_inh'('agent', 'restricts'('subject', 'range'('human', 'human'))), 'nr'('sb_primelemrole'('instrument', 'domain-range'('action', 'touchable_object', 'bot')), 1, 1, 1), 'nr'('sb_primelemrole'('concerned', 'domain-range'('action', 'thing', 'bot')), 1, 1, 1)]).
'sb_primconcept'('do', ['supers'(['action'])]).
'sb_attributes'('do', 'result', 'role_to_case'('akkusativ')).
'sb_attributes'('do', 'agent', 'role_to_case'('nominativ')).
'sb_primconcept'('absetz', ['supers'(['lexicon', 'do'])]).
'sb_attributes'('absetz', 'result', 'role_to_case'('akkusativ')).
'sb_attributes'('absetz', 'agent', 'role_to_case'('nominativ')).
'sb_primconcept'('ausfuehr', ['supers'(['lexicon', 'do'])]).
'sb_attributes'('ausfuehr', 'agent', 'role_to_case'('nominativ')).
'sb_attributes'('ausfuehr', 'result', 'role_to_case'('akkusativ')).
'sb_defconcept'('motion', ['supers'(['action']), 'nr'('sb_primelemrole'('destination', 'domain-range'('motion', 'geographical_object', 'bot')), 1, 1, 1), 'nr'('sb_primelemrole'('source', 'domain-range'('motion', 'geographical_object', 'bot')), 1, 1, 1)]).
'sb_attributes'('motion', 'agent', 'role_to_case'('nominativ')).
'sb_attributes'('motion', 'location', 'role_to_case'('dativ')).
'sb_defconcept'('motion_by_means', ['supers'(['motion']), 'necres'('sb_primelemrole'('means', 'domain-range'('motion_by_means', 'touchable_object', 'touchable_object')), 'nec')]).
'sb_attributes'('motion_by_means', 'destination', 'role_to_case'('prep_stems'('nach'))).
'sb_attributes'('motion_by_means', 'source', 'role_to_case'('prep_stems'('von'))).
'sb_attributes'('motion_by_means', 'agent', 'role_to_case'('nominativ')).
'sb_attributes'('motion_by_means', 'means', 'role_to_case'('prep_stems'('mit'))).
'sb_defconcept'('fahr', ['supers'(['lexicon', 'motion_by_means'])]).
'sb_attributes'('fahr', 'source', 'role_to_case'('prep_stems'('von'))).
'sb_attributes'('fahr', 'agent', 'role_to_case'('nominativ')).
'sb_attributes'('fahr', 'destination', 'role_to_case'('prep_stems'('nach'))).
'sb_attributes'('fahr', 'means', 'role_to_case'('prep_stems'('mit'))).
'sb_defconcept'('geh', ['supers'(['lexicon', 'motion'])]).
'sb_defconcept'('treff', ['supers'(['lexicon', 'action'])]).
'sb_defconcept'('werf', ['supers'(['lexicon', 'action']), 'necres'('concerned', 'nec')]).
'sb_defconcept'('causative', ['supers'(['action'])]).
'sb_defconcept'('productive', ['supers'(['causative']), 'necres'('sb_primelemrole'('result', 'domain-range'('productive', 'thing', 'thing')), 'nec')]).
'sb_defconcept'('write', ['supers'(['productive']), 'necres'('sb_primelemrole'('concerned', 'domain-range'('write', 'thing', 'thing')), 'nec')]).
'sb_primconcept'('canvas', ['supers'(['touchable_object'])]).
'sb_defconcept'('enter', ['supers'(['write']), 'restrict_inh'('location_enter', 'restricts'('location', 'range'('canvas', 'canvas')))]).
'sb_defconcept'('arbeit', ['supers'(['lexicon', 'action'])]).
'sb_primconcept'('repeat', ['supers'(['action'])]).
'sb_attributes'('repeat', 'result', 'role_to_case'('akkusativ')).
'sb_primconcept'('wiederhol', ['supers'(['repeat', 'lexicon'])]).
'sb_attributes'('wiederhol', 'result', 'role_to_case'('akkusativ')).
'sb_defconcept'('transaction', ['supers'(['action']), 'nr'('sb_primelemrole'('beneficative', 'domain-range'('transaction', 'human', 'bot')), 1, 1, 1)]).
'sb_defconcept'('schenk', ['supers'(['lexicon', 'transaction']), 'necres'('concerned', 'nec')]).
'sb_attributes'('schenk', 'beneficative', 'role_to_case'('dativ')).
'sb_primconcept'('zahl', ['supers'(['lexicon', 'transaction'])]).
'sb_defconcept'('kauf', ['supers'(['lexicon', 'transaction']), 'necres'('concerned', 'nec')]).
'sb_attributes'('kauf', 'location', 'role_to_case'('prep_stems'('in'))).
'sb_attributes'('kauf', 'beneficative', 'role_to_case'('dativ')).
'sb_attributes'('kauf', 'result', 'role_to_case'('akkusativ')).
'sb_attributes'('kauf', 'agent', 'role_to_case'('nominativ')).
'sb_primconcept'('reason',['supers'([('action')])]).
'sb_attributes'('reason', 'agent', 'role_to_case'('nominativ')).
'sb_attributes'('reason', 'result', 'role_to_case'('akkusativ')).
'sb_primconcept'('verursach', ['supers'(['lexicon', 'reason'])]).
'sb_attributes'('verursach', 'agent', 'role_to_case'('nominativ')).
'sb_attributes'('verursach', 'result', 'role_to_case'('akkusativ')).
'sb_defconcept'('unterricht', ['supers'(['predicate', 'lexicon'])]).
'sb_primconcept'('property', ['supers'(['predicate'])]).
'sb_primelemrole'('has_property', 'domain-range'('property', 'property_filler', 'bot')).
'sb_attributes'('property', 'result', 'role_to_case'('praedikatsnominativ')).
'sb_attributes'('property', 'subject', 'role_to_case'('nominativ')).
'sb_attributes'('property', 'has_property', 'role_to_case'('adjektivalergaenzung')).
'sb_defconcept'('value_property', ['supers'(['property']), 'nr'('sb_primelemrole'('measure', 'domain-range'('value_property', 'abstract_thing', 'bot')), 1, 1, 1)]).
'sb_defconcept'('cost', ['supers'(['value_property']), 'necres'('sb_primelemrole'('measure', 'domain-range'('cost', 'abstract_thing', 'abstract_thing')), 'nec')]).
'sb_attributes'('cost', 'measure', 'role_to_case'('akkusativ')).
'sb_attributes'('cost', 'subject', 'role_to_case'('nominativ')).
'sb_defconcept'('kost', ['supers'(['cost', 'lexicon'])]).
'sb_attributes'('kost', 'subject', 'role_to_case'('nominativ')).
'sb_attributes'('kost', 'measure', 'role_to_case'('akkusativ')).
'sb_primconcept'('deducte', ['supers'(['property'])]).
'sb_primconcept'('absetzbar', ['supers'(['deducte', 'lexicon'])]).
'sb_primconcept'('sein', ['supers'(['lexicon', 'property'])]).
'sb_attributes'('sein', 'subject', 'role_to_case'('nominativ')).
'sb_attributes'('sein', 'result', 'role_to_case'('praedikatsnominativ')).
'sb_primconcept'('possess', ['supers'(['lexicon', 'property'])]).
'sb_attributes'('possess', 'subject', 'role_to_case'('nominativ')).
'sb_attributes'('possess', 'has_property', 'role_to_case'('adjektivalergaenzung')).
'sb_attributes'('possess', 'result', 'role_to_case'('akkusativ')).
'sb_primconcept'('haben', ['supers'(['lexicon', 'property']), 'restrict_inh'('has_property_haben', 'restricts'('has_property', 'range'('thing', 'bot')))]).
'sb_primconcept'('origin', ['supers'(['adjective_property'])]).
'sb_primconcept'('state_q', ['supers'(['qualitative'])]).
'sb_primconcept'('volitional_sq', ['supers'(['state_q'])]).
'sb_primconcept'('physical_sq', ['supers'(['state_q'])]).
'sb_primconcept'('klein', ['supers'(['lexicon', 'physical_sq'])]).
'sb_primconcept'('gross', ['supers'(['lexicon', 'physical_sq'])]).
'sb_primconcept'('rot', ['supers'(['colour', 'lexicon'])]).
'sb_primconcept'('worth', ['supers'(['quality'])]).
'sb_primconcept'('voelklingen', ['supers'(['name'])]).
'sb_primconcept'('gi', ['supers'(['abstract_thing', 'lexicon'])]).
'sb_defconcept'('indication_of_quantity', ['supers'(['abstract_thing']), 'restrict_inh'('quantity', 'restricts'('det', 'range'('cardinal', 'cardinal'))), 'necres'('quantity', 'nec')]).
'sb_defconcept'('dm', ['supers'(['indication_of_quantity', 'lexicon'])]).
'sb_primconcept'('profession', ['supers'(['abstract_thing'])]).
'sb_primconcept'('schreiner', ['supers'(['profession', 'lexicon'])]).
'sb_primconcept'('programmer', ['supers'(['profession', 'lexicon'])]).
'sb_primconcept'('action_content', ['supers'(['abstract_thing', 'action'])]).
'sb_primconcept'('motion_content', ['supers'(['action_content', 'motion'])]).
'sb_primconcept'('motion_by_means_content', ['supers'(['motion_by_means', 'action_content'])]).
'sb_primconcept'('cost', ['supers'(['abstract_thing'])]).
'sb_primconcept'('kosten', ['supers'(['lexicon', 'cost'])]).
'sb_primconcept'('geld', ['supers'(['lexicon', 'cost'])]).
'sb_primconcept'('profession', ['supers'(['abstract_thing'])]).
'sb_primconcept'('programmer', ['supers'(['lexicon', 'profession'])]).
'sb_primconcept'('tax_action', ['supers'(['abstract_thing'])]).
'sb_primconcept'('steuerhandlung', ['supers'(['lexicon', 'tax_action'])]).
'sb_primconcept'('number', ['supers'(['abstract_thing'])]).
'sb_defconcept'('fahrt', ['supers'(['thing', 'lexicon'])]).
'sb_defconcept'('das', ['supers'(['thing', 'lexicon'])]).
'sb_defconcept'('animate', ['supers'(['individual']), 'nr'('sb_primelemrole'('physis_mod', 'domain-range'('animate', 'physical_sq', 'bot')), 1, 1, 1)]).
'sb_primconcept'('frau', ['supers'(['human', 'lexicon'])]).
'sb_defconcept'('mann', ['supers'(['human', 'lexicon'])]).
'sb_attributes'('mann', 'physis_mod', 'role_to_case'('adj')).
'sb_primconcept'('sie', ['supers'(['human', 'lexicon'])]).
'sb_defconcept'('junge', ['supers'(['human', 'lexicon'])]).
'sb_primconcept'('sie', ['supers'(['lexicon', 'human'])]).
'sb_primconcept'('person', ['supers'(['lexicon', 'human'])]).
'sb_defconcept'('karl', 'supers'(['lexicon', 'human'])).
'sb_defconcept'('ich', ['supers'(['lexicon', 'human'])]).
'sb_defconcept'('peter', ['supers'(['lexicon', 'human'])]).
'sb_primconcept'('plant', ['supers'(['animate'])]).
'sb_defconcept'('animal', ['supers'(['animate']), 'nr'('sb_primelemrole'('volition', 'domain-range'('animal', 'volitional_sq', 'bot')), 1, 1, 1)]).
'sb_primconcept'('town', ['supers'(['geographical_object'])]).
'sb_defconcept'('voelklingen', ['supers'(['town', 'lexicon'])]).
'sb_attributes'('voelklingen', 'named', 'annotate_filler'('t')).
'sb_defconcept'('saarbruecken', ['supers'(['town', 'lexicon'])]).
'sb_attributes'('saarbruecken', 'named', 'annotate_filler'('t')).
'sb_defconcept'('dudweiler', ['supers'(['town', 'lexicon'])]).
'sb_attributes'('dudweiler', 'named', 'annotate_filler'('t')).
'sb_defconcept'('saarlouis', ['supers'(['lexicon', 'town'])]).
'sb_attributes'('saarlouis', 'named', 'annotate_filler'('t')).
'sb_primconcept'('berlin', ['supers'(['lexicon', 'town'])]).
'sb_defconcept'('wald', ['supers'(['geographical_object', 'lexicon'])]).
'sb_defconcept'('hier', ['supers'(['geographical_object', 'lexicon'])]).
'sb_defconcept'('ort', ['supers'(['lexicon', 'geographical_object'])]).
'sb_primconcept'('information', ['supers'(['inanimate'])]).
'sb_primconcept'('string', ['supers'(['information'])]).
'sb_primconcept'('system', ['supers'(['human', 'inanimate'])]).
'sb_defconcept'('vehicle', ['supers'(['touchable_object']), 'nr'('sb_primelemrole'('worth_mod', 'domain-range'('vehicle', 'worth', 'bot')), 1, 1, 1)]).
'sb_defconcept'('fahrrad', ['supers'(['vehicle', 'lexicon'])]).
'sb_primconcept'('bus', ['supers'(['vehicle'])]).
'sb_defconcept'('bus', ['supers'(['bus', 'lexicon'])]).
'sb_primconcept'('motorcycle', ['supers'(['vehicle', 'lexicon'])]).
'sb_primconcept'('motorcycle', ['supers'(['vehicle', 'lexicon'])]).
'sb_attributes'('motorcycle', 'colour_mod', 'role_to_case'('adj')).
'sb_defconcept'('buch', ['supers'(['lexicon', 'touchable_object'])]).
'sb_primconcept'('spellbook', ['supers'(['lexicon', 'touchable_object'])]).
'sb_primconcept'('result', ['supers'(['touchable_object'])]).
'sb_defconcept'('auktion', ['supers'(['lexicon', 'thing'])]).
'sb_defconcept'('was', ['supers'(['lexicon', 'thing'])]).

:-retract(in_motel_kb(fssKB)).

