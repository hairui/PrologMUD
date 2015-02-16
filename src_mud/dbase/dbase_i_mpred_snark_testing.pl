% :- assert_kif("; This is the IDE's built-in-editor, where you create and edit lisp source code. You could use some other editor instead, though the IDE's menu-bar commands would not be applicable there. This editor has a tab for each file that it's editing. You can create a new editor buffer at any time with the File | New command. Other commands such as Search | Find Definitions will create editor buffers automatically for existing code. You can use the File | Compile and Load command to compile and load an entire file, or compile an individual definition by placing the text cursor inside it and using Tools | Incremental Compile. You can similarly evaluate test expressions in the editor by using Tools | Incremental Evaluation the returned values and any printed output will appear in a lisp listener in the Debug Window. For a brief introduction to other IDE tools, try the Help | Interactive IDE Intro command. And be sure to explore the other facilities on the Help menu.").
% :- assert_kif("; ================================================ SUMO (Suggested Upper Merged Ontology) ================================================").
% :- assert_kif("; The original versions of SUMO incorporated elements from many public sources which are documented at http://www.ontologyportal.org/SUMOhistory/").
% :- assert_kif("; The SUMO is freely available, subject to the following IEEE license.").
% :- assert_kif("; ---------------------- Copyright � 2004 by the Institute of Electrical and Electronics Engineers, Inc. Three Park Avenue New York, NY 10016-5997, USA All rights reserved.").
% :- assert_kif("; 1. COPYRIGHT The Institute of Electrical and Electronics Engineers, Inc., (\"IEEE\") owns the copyright to this Document in all forms of media. Copyright in the text retrieved, displayed or output from this Document is owned by IEEE and is protected by the copyright laws of the United States and by international treaties. The IEEE reserves all rights not expressly granted herein.").
% :- assert_kif("; 2. ROYALTIES The IEEE is providing the Document at no charge. However, the Document is not to be considered \"Public Domain,\" as the IEEE is, and at all times shall remain, the sole copyright holder in the Document. The IEEE intends to revise the Document from time to time the latest version shall be available at http://standards.ieee.org/catalog/").
% :- assert_kif("; 3. TERMS OF USE The IEEE hereby grants Licensee a perpetual, non-exclusive, royalty-free, world-wide right and license to copy, publish and distribute the Document in any way, and to prepare derivative works that are based on or incorporate all or part of the Document provided that the IEEE is appropriately acknowledged as the source and copyright owner in each and every use.").
% :- assert_kif("; 4. LIMITED WARRANTIES & LIMITATIONS OF REMEDIES LICENSOR Does not warrant or represent the accuracy or content of the document and Expressly Disclaims any Express or Implied Warranty, including any Implied Warranty of Merchantability or Fitness for a Specific Purpose or that the use of the document is free from patent infringement. The document is supplied ONLY \"AS IS.\" ----------------------").
% :- assert_kif("; The SUMO was initially developed at Teknowledge Corp.").
% :- assert_kif("; Any questions or comments about this ontology can be directed to the Technical editor, Adam Pease, apease [at] articulatesoftware [dot] com").
% :- assert_kif(";      ").
% :- assert_kif("; The knowledge representation language in which the SUMO is expressed is SUO-KIF, which stands for \"Standard Upper Ontology - Knowledge Interchange Format\". SUO-KIF is a simplified form of the popular KIF knowledge representation language. A specification of SUO-KIF can be found at: http://www.ontologyportal.org").
% :- assert_kif("; The SUMO is a modular ontology. That is, the ontology is divided into self-contained subontologies. Each subontology is indicated by a section header, and the dependencies between the subontologies are specified with statements of the form \" INCLUDES '<SUBONTOLOGY>'\". These statements are found at the beginning of each section.").
% :- assert_kif("; We ask the people using or referencing SUMO cite our primary paper:").
% :- assert_kif("; Niles, I., and Pease, A. 2001. Towards a Standard Upper Ontology. In Proceedings of the 2nd International Conference on Formal Ontology in Information Systems (FOIS-2001), Chris Welty and Barry Smith, eds, Ogunquit, Maine, October 17-19, 2001. Also see http://www.ontologyportal.org").
% :- assert_kif("; BEGIN FILE").
% :- assert_kif(";  STRUCTURAL ONTOLOGY  ").
% :- assert_kif("; INCLUDES 'BASE ONTOLOGY'").
% :- assert_kif("; The Structural Ontology consists of definitions of certain syntactic abbreviations that can be both heuristically useful and computationally advantageous.").
:- assert_kif("(instance instance BinaryPredicate)").
:- assert_kif("(domain instance 1 Entity)").
:- assert_kif("(domain instance 2 SetOrClass)").
:- assert_kif("(documentation instance EnglishLanguage \"An object is an &%instance of a &%SetOrClass if it is included in that &%SetOrClass. An individual may be an instance of many classes, some of which may be subclasses of others. Thus, there is no assumption in the meaning of &%instance about specificity or uniqueness.\")").
:- assert_kif("(subrelation immediateInstance instance)").
:- assert_kif("(instance immediateInstance AsymmetricRelation)").
:- assert_kif("(instance immediateInstance IntransitiveRelation)").
:- assert_kif("(documentation immediateInstance EnglishLanguage \"An object is an &%immediateInstance of a &%SetOrClass if it is an instance of the &%SetOrClass and it is not an instance of a proper subclass of &%SetOrClass.\")").
:- assert_kif("(=> (immediateInstance ?ENTITY ?CLASS) (not (exists (?SUBCLASS) (and (subclass ?SUBCLASS ?CLASS) (not (equal ?SUBCLASS ?CLASS)) (instance ?ENTITY ?SUBCLASS)))))").
:- assert_kif("(instance inverse BinaryPredicate)").
:- assert_kif("(instance inverse IrreflexiveRelation)").
:- assert_kif("(instance inverse IntransitiveRelation)").
:- assert_kif("(instance inverse SymmetricRelation)").
:- assert_kif("(domain inverse 1 BinaryRelation)").
:- assert_kif("(domain inverse 2 BinaryRelation)").
:- assert_kif("(documentation inverse EnglishLanguage \"The inverse of a &%BinaryRelation is a relation in which all the tuples of the original relation are reversed. In other words, one &%BinaryRelation is the inverse of another if they are equivalent when their arguments are swapped.\")").
% :- assert_kif("; causes a predicate variable expansion explosion ").
% :- assert_kif(" (=> (and (inverse ?REL1 ?REL2) (instance ?REL1 Predicate) (instance ?REL2 Predicate)) (forall (?INST1 ?INST2) (<=> (?REL1 ?INST1 ?INST2) (?REL2 ?INST2 ?INST1))))").
:- assert_kif("(instance subclass BinaryPredicate)").
:- assert_kif("(instance subclass PartialOrderingRelation)").
:- assert_kif("(domain subclass 1 SetOrClass)").
:- assert_kif("(domain subclass 2 SetOrClass)").
:- assert_kif("(documentation subclass EnglishLanguage \"(&%subclass ?CLASS1 ?CLASS2) means that ?CLASS1 is a subclass of ?CLASS2, i.e. every instance of ?CLASS1 is also an instance of ?CLASS2. A class may have multiple superclasses and subclasses.\")").
:- assert_kif("(=> (subclass ?X ?Y) (and (instance ?X SetOrClass) (instance ?Y SetOrClass)))").
:- assert_kif("(=> (and (subclass ?X ?Y) (instance ?Z ?X)) (instance ?Z ?Y))").
:- assert_kif("(subrelation immediateSubclass subclass)").
:- assert_kif("(instance immediateSubclass AsymmetricRelation)").
:- assert_kif("(instance immediateSubclass IntransitiveRelation)").
:- assert_kif("(documentation immediateSubclass EnglishLanguage \"A &%SetOrClass ?CLASS1 is an &%immediateSubclass of another &%SetOrClass ?CLASS2 just in case ?CLASS1 is a subclass of ?CLASS2 and there is no other subclass of ?CLASS2 such that ?CLASS1 is also a subclass of it.\")").
:- assert_kif("(=> (immediateSubclass ?CLASS1 ?CLASS2) (not (exists (?CLASS3) (and (subclass ?CLASS3 ?CLASS2) (subclass ?CLASS1 ?CLASS3) (not (equal ?CLASS2 ?CLASS3)) (not (equal ?CLASS1 ?CLASS3))))))").
:- assert_kif("(instance subrelation BinaryPredicate)").
:- assert_kif("(instance subrelation PartialOrderingRelation)").
:- assert_kif("(domain subrelation 1 Relation)").
:- assert_kif("(domain subrelation 2 Relation)").
:- assert_kif("(documentation subrelation EnglishLanguage \"(&%subrelation ?REL1 ?REL2) means that every tuple of ?REL1 is also a tuple of ?REL2. In other words, if the &%Relation ?REL1 holds for some arguments arg_1, arg_2, ... arg_n, then the &%Relation ?REL2 holds for the same arguments. A consequence of this is that a &%Relation and its subrelations must have the same &%valence.\")").
:- assert_kif("(=> (and (subrelation ?PRED1 ?PRED2) (valence ?PRED1 ?NUMBER)) (valence ?PRED2 ?NUMBER))").
:- assert_kif("(=> (and (subrelation ?PRED1 ?PRED2) (domain ?PRED2 ?NUMBER ?CLASS1)) (domain ?PRED1 ?NUMBER ?CLASS1))").
:- assert_kif("(=> (and (subrelation ?REL1 ?REL2) (instance ?REL1 Predicate) (instance ?REL2 Predicate) (?REL1 @ROW)) (?REL2 @ROW))").
:- assert_kif("(=> (and (subrelation ?PRED1 ?PRED2) (instance ?PRED2 ?CLASS) (instance ?CLASS InheritableRelation)) (instance ?PRED1 ?CLASS))").
:- assert_kif("(instance domain TernaryPredicate)").
:- assert_kif("(domain domain 1 Relation)").
:- assert_kif("(domain domain 2 PositiveInteger)").
:- assert_kif("(domain domain 3 SetOrClass)").
:- assert_kif("(documentation domain EnglishLanguage \"Provides a computationally and heuristically convenient mechanism for declaring the argument types of a given relation. The formula (&%domain ?REL ?INT ?CLASS) means that the ?INT'th element of each tuple in the relation ?REL must be an instance of ?CLASS. Specifying argument types is very helpful in maintaining ontologies. Representation systems can use these specifications to classify terms and check integrity constraints. If the restriction on the argument type of a &%Relation is not captured by a &%SetOrClass already defined in the ontology, one can specify a &%SetOrClass compositionally with the functions &%UnionFn, &%IntersectionFn, etc.\")").
:- assert_kif("(=> (and (domain ?REL ?NUMBER ?CLASS1) (domain ?REL ?NUMBER ?CLASS2)) (or (subclass ?CLASS1 ?CLASS2) (subclass ?CLASS2 ?CLASS1)))").
:- assert_kif("(instance domainSubclass TernaryPredicate)").
:- assert_kif("(domain domainSubclass 1 Relation)").
:- assert_kif("(domain domainSubclass 2 PositiveInteger)").
:- assert_kif("(domain domainSubclass 3 SetOrClass)").
:- assert_kif("(documentation domainSubclass EnglishLanguage \"&%Predicate used to specify argument type restrictions of &%Predicates. The formula (&%domainSubclass ?REL ?INT ?CLASS) means that the ?INT'th element of each tuple in the relation ?REL must be a subclass of ?CLASS.\")").
:- assert_kif("(=> (and (subrelation ?REL1 ?REL2) (domainSubclass ?REL2 ?NUMBER ?CLASS1)) (domainSubclass ?REL1 ?NUMBER ?CLASS1))").
:- assert_kif("(=> (and (domainSubclass ?REL ?NUMBER ?CLASS1) (domainSubclass ?REL ?NUMBER ?CLASS2)) (or (subclass ?CLASS1 ?CLASS2) (subclass ?CLASS2 ?CLASS1)))").
:- assert_kif("(instance equal BinaryPredicate)").
:- assert_kif("(instance equal EquivalenceRelation)").
:- assert_kif("(instance equal RelationExtendedToQuantities)").
:- assert_kif("(domain equal 1 Entity)").
:- assert_kif("(domain equal 2 Entity)").
:- assert_kif("(documentation equal EnglishLanguage \"(equal ?ENTITY1 ?ENTITY2) is true just in case ?ENTITY1 is identical with ?ENTITY2.\")").
:- assert_kif("(=> (equal ?THING1 ?THING2) (forall (?ATTR) (<=> (property ?THING1 ?ATTR) (property ?THING2 ?ATTR))))").
:- assert_kif("(=> (equal ?ATTR1 ?ATTR2) (forall (?THING) (<=> (property ?THING ?ATTR1) (property ?THING ?ATTR2))))").
:- assert_kif("(=> (equal ?THING1 ?THING2) (forall (?CLASS) (<=> (instance ?THING1 ?CLASS) (instance ?THING2 ?CLASS))))").
:- assert_kif("(=> (equal ?CLASS1 ?CLASS2) (forall (?THING) (<=> (instance ?THING ?CLASS1) (instance ?THING ?CLASS2))))").
% :- assert_kif(" (=> (equal ?REL1 ?REL2) (forall (@ROW) (<=> (?REL1 @ROW) (?REL2 @ROW))))").
:- assert_kif("(=> (equal ?LIST1 ?LIST2) (=> (and (equal ?LIST1 (ListFn @ROW1)) (equal ?LIST2 (ListFn @ROW2))) (forall (?NUMBER) (equal (ListOrderFn (ListFn @ROW1) ?NUMBER) (ListOrderFn (ListFn @ROW2) ?NUMBER)))))").
:- assert_kif("(instance range BinaryPredicate)").
:- assert_kif("(instance range AsymmetricRelation)").
:- assert_kif("(domain range 1 Function)").
:- assert_kif("(domain range 2 SetOrClass)").
:- assert_kif("(documentation range EnglishLanguage \"Gives the range of a function. In other words, &%range ?FUNCTION ?CLASS) means that all of the values assigned by ?FUNCTION are &%instances of ?CLASS.\")").
:- assert_kif("(=> (and (range ?FUNCTION ?CLASS) (equal (AssignmentFn ?FUNCTION @ROW) ?VALUE)) (instance ?VALUE ?CLASS))").
:- assert_kif("(=> (and (subrelation ?REL1 ?REL2) (range ?REL2 ?CLASS1)) (range ?REL1 ?CLASS1))").
:- assert_kif("(=> (and (range ?REL ?CLASS1) (range ?REL ?CLASS2)) (or (subclass ?CLASS1 ?CLASS2) (subclass ?CLASS2 ?CLASS1)))").
:- assert_kif("(instance rangeSubclass BinaryPredicate)").
:- assert_kif("(instance rangeSubclass AsymmetricRelation)").
:- assert_kif("(domain rangeSubclass 1 Function)").
:- assert_kif("(domainSubclass rangeSubclass 2 SetOrClass)").
:- assert_kif("(documentation rangeSubclass EnglishLanguage \"(&%rangeSubclass ?FUNCTION ?CLASS) means that all of the values assigned by ?FUNCTION are &%subclasses of ?CLASS.\")").
:- assert_kif("(=> (and (rangeSubclass ?FUNCTION ?CLASS) (equal (AssignmentFn ?FUNCTION @ROW) ?VALUE)) (subclass ?VALUE ?CLASS))").
:- assert_kif("(=> (and (subrelation ?REL1 ?REL2) (rangeSubclass ?REL2 ?CLASS1)) (rangeSubclass ?REL1 ?CLASS1))").
:- assert_kif("(=> (and (rangeSubclass ?REL ?CLASS1) (rangeSubclass ?REL ?CLASS2)) (or (subclass ?CLASS1 ?CLASS2) (subclass ?CLASS2 ?CLASS1)))").
:- assert_kif("(instance valence BinaryPredicate)").
:- assert_kif("(instance valence AsymmetricRelation)").
:- assert_kif("(instance valence SingleValuedRelation)").
:- assert_kif("(domain valence 1 Relation)").
:- assert_kif("(domain valence 2 PositiveInteger)").
:- assert_kif("(documentation valence EnglishLanguage \"Specifies the number of arguments that a relation can take. If a relation does not have a fixed number of arguments, it does not have a valence and it is an instance of &%VariableArityRelation.\")").
:- assert_kif("(instance documentation TernaryPredicate)").
:- assert_kif("(domain documentation 1 Entity)").
:- assert_kif("(domain documentation 2 HumanLanguage)").
:- assert_kif("(domain documentation 3 SymbolicString)").
:- assert_kif("(documentation documentation EnglishLanguage \"A relation between objects in the domain of discourse and strings of natural language text stated in a particular &%HumanLanguage. The domain of &%documentation is not constants (names), but the objects themselves. This means that one does not quote the names when associating them with their documentation.\")").
:- assert_kif("(instance format TernaryPredicate)").
:- assert_kif("(domain format 1 Language)").
:- assert_kif("(domain format 2 Entity)").
:- assert_kif("(domain format 3 SymbolicString)").
:- assert_kif("(documentation format EnglishLanguage \"A relation that specifies how to present an expression in a natural language format.\")").
:- assert_kif("(instance termFormat TernaryPredicate)").
:- assert_kif("(domain termFormat 1 Language)").
:- assert_kif("(domain termFormat 2 Entity)").
:- assert_kif("(domain termFormat 3 SymbolicString)").
:- assert_kif("(documentation termFormat EnglishLanguage \"A relation that specifies how to present a term in a natural language format.\")").
:- assert_kif("(instance disjoint BinaryPredicate)").
:- assert_kif("(instance disjoint SymmetricRelation)").
:- assert_kif("(domain disjoint 1 SetOrClass)").
:- assert_kif("(domain disjoint 2 SetOrClass)").
:- assert_kif("(documentation disjoint EnglishLanguage \"&%Classes are &%disjoint only if they share no instances, i.e. just in case the result of applying &%IntersectionFn to them is empty.\")").
:- assert_kif("(<=> (disjoint ?CLASS1 ?CLASS2) (forall (?INST) (not (and (instance ?INST ?CLASS1) (instance ?INST ?CLASS2)))))").
:- assert_kif("(instance disjointRelation BinaryPredicate)").
:- assert_kif("(instance disjointRelation IrreflexiveRelation)").
:- assert_kif("(domain disjointRelation 1 Relation)").
:- assert_kif("(domain disjointRelation 2 Relation)").
:- assert_kif("(relatedInternalConcept disjointRelation disjoint)").
:- assert_kif("(documentation disjointRelation EnglishLanguage \"This predicate relates two &%Relations.  (&%disjointRelation ?REL1 ?REL2) means that the two relations have no tuples in common.\")").
:- assert_kif("(=> (and (domain ?REL1 ?NUMBER ?CLASS1) (domain ?REL2 ?NUMBER ?CLASS2) (disjoint ?CLASS1 ?CLASS2)) (disjointRelation ?REL1 ?REL2))").
:- assert_kif("(=> (and (domainSubclass ?REL1 ?NUMBER ?CLASS1) (domainSubclass ?REL2 ?NUMBER ?CLASS2) (disjoint ?CLASS1 ?CLASS2)) (disjointRelation ?REL1 ?REL2))").
:- assert_kif("(=> (and (range ?REL1 ?CLASS1) (range ?REL2 ?CLASS2) (disjoint ?CLASS1 ?CLASS2)) (disjointRelation ?REL1 ?REL2))").
:- assert_kif("(=> (and (rangeSubclass ?REL1 ?CLASS1) (rangeSubclass ?REL2 ?CLASS2) (disjoint ?CLASS1 ?CLASS2)) (disjointRelation ?REL1 ?REL2))").
:- assert_kif("(=> (and (instance ?REL1 Predicate) (instance ?REL2 Predicate) (disjointRelation ?REL1 ?REL2) (not (equal ?REL1 ?REL2)) (?REL1 @ROW2)) (not (?REL2 @ROW2)))").
:- assert_kif("(instance contraryAttribute Predicate)").
:- assert_kif("(instance contraryAttribute VariableArityRelation)").
:- assert_kif("(documentation contraryAttribute EnglishLanguage \"A &%contraryAttribute is a set of &%Attributes such that something can not simultaneously have more than one of these &%Attributes. For example, (&%contraryAttribute &%Pliable &%Rigid) means that nothing can be both &%Pliable and &%Rigid.\")").
:- assert_kif("(=> (contraryAttribute @ROW) (=> (inList ?ELEMENT (ListFn @ROW)) (instance ?ELEMENT Attribute)))").
:- assert_kif("(=> (and (contraryAttribute @ROW1) (identicalListItems (ListFn @ROW1) (ListFn @ROW2))) (contraryAttribute @ROW2))").
:- assert_kif("(=> (contraryAttribute @ROW) (forall (?ATTR1 ?ATTR2) (=> (and (equal ?ATTR1 (ListOrderFn (ListFn @ROW) ?NUMBER1)) (equal ?ATTR2 (ListOrderFn (ListFn @ROW) ?NUMBER2)) (not (equal ?NUMBER1 ?NUMBER2))) (=> (property ?OBJ ?ATTR1) (not (property ?OBJ ?ATTR2))))))").
:- assert_kif("(instance exhaustiveAttribute Predicate)").
:- assert_kif("(instance exhaustiveAttribute VariableArityRelation)").
:- assert_kif("(domainSubclass exhaustiveAttribute 1 Attribute)").
:- assert_kif("(documentation exhaustiveAttribute EnglishLanguage \"This predicate relates a &%Class to a set of &%Attributes, and it means that the elements of this set exhaust the instances of the &%Class. For example, (&%exhaustiveAttribute &%PhysicalState &%Solid &%Fluid &%Liquid &%Gas &%Plasma) means that there are only five instances of the class &%PhysicalState, viz. &%Solid, &%Fluid, &%Liquid, &%Gas and &%Plasma.\")").
:- assert_kif("(=> (exhaustiveAttribute ?CLASS @ROW) (=> (inList ?ATTR (ListFn @ROW)) (instance ?ATTR Attribute)))").
:- assert_kif("(=> (exhaustiveAttribute ?CLASS @ROW) (forall (?ATTR1) (=> (instance ?ATTR1 ?CLASS) (exists (?ATTR2) (and (inList ?ATTR2 (ListFn @ROW)) (equal ?ATTR1 ?ATTR2))))))").
:- assert_kif("(=> (exhaustiveAttribute ?ATTRCLASS @ROW) (not (exists (?EL) (and (instance ?EL ?ATTRCLASS) (not (exists (?ATTR ?NUMBER) (and (equal ?EL ?ATTR) (equal ?ATTR (ListOrderFn (ListFn @ROW) ?NUMBER)))))))))").
:- assert_kif("(instance exhaustiveDecomposition Predicate)").
:- assert_kif("(instance exhaustiveDecomposition VariableArityRelation)").
:- assert_kif("(domain exhaustiveDecomposition 1 Class)").
:- assert_kif("(relatedInternalConcept exhaustiveDecomposition partition)").
:- assert_kif("(documentation exhaustiveDecomposition EnglishLanguage \"An &%exhaustiveDecomposition of a &%Class C is a set of subclasses of C such that every instance of C is an instance of one of the subclasses in the set. Note: this does not necessarily mean that the elements of the set are disjoint (see &%partition - a &%partition is a disjoint exhaustive decomposition).\")").
:- assert_kif("(=> (exhaustiveDecomposition @ROW) (=> (inList ?ELEMENT (ListFn @ROW)) (instance ?ELEMENT Class)))").
:- assert_kif("(instance disjointDecomposition Predicate)").
:- assert_kif("(instance disjointDecomposition VariableArityRelation)").
:- assert_kif("(domain disjointDecomposition 1 Class)").
:- assert_kif("(relatedInternalConcept disjointDecomposition exhaustiveDecomposition)").
:- assert_kif("(relatedInternalConcept disjointDecomposition disjoint)").
:- assert_kif("(documentation disjointDecomposition EnglishLanguage \"A &%disjointDecomposition of a &%Class C is a set of subclasses of C that are mutually &%disjoint.\")").
:- assert_kif("(=> (disjointDecomposition @ROW) (=> (inList ?ELEMENT (ListFn @ROW)) (instance ?ELEMENT Class)))").
:- assert_kif("(instance partition Predicate)").
:- assert_kif("(instance partition VariableArityRelation)").
:- assert_kif("(domain partition 1 Class)").
:- assert_kif("(documentation partition EnglishLanguage \"A &%partition of a class C is a set of mutually &%disjoint classes (a subclass partition) which covers C. Every instance of C is an instance of exactly one of the subclasses in the partition.\")").
:- assert_kif("(<=> (partition @ROW) (and (exhaustiveDecomposition @ROW) (disjointDecomposition @ROW)))").
:- assert_kif("(instance relatedInternalConcept BinaryPredicate)").
:- assert_kif("(instance relatedInternalConcept EquivalenceRelation)").
:- assert_kif("(domain relatedInternalConcept 1 Entity)").
:- assert_kif("(domain relatedInternalConcept 2 Entity)").
:- assert_kif("(documentation relatedInternalConcept EnglishLanguage \"Means that the two arguments are related concepts within the SUMO, i.e. there is a significant similarity of meaning between them. To indicate a meaning relation between a SUMO concept and a concept from another source, use the Predicate &%relatedExternalConcept.\")").
:- assert_kif("(instance relatedExternalConcept TernaryPredicate)").
:- assert_kif("(domain relatedExternalConcept 1 SymbolicString)").
:- assert_kif("(domain relatedExternalConcept 2 Entity)").
:- assert_kif("(domain relatedExternalConcept 3 Language)").
:- assert_kif("(relatedInternalConcept relatedExternalConcept relatedInternalConcept)").
:- assert_kif("(documentation relatedExternalConcept EnglishLanguage \"Used to signify a three-place relation between a concept in an external knowledge source, a concept in the SUMO, and the name of the other knowledge source.\")").
:- assert_kif("(subrelation synonymousExternalConcept relatedExternalConcept)").
:- assert_kif("(disjointRelation synonymousExternalConcept subsumedExternalConcept)").
:- assert_kif("(disjointRelation synonymousExternalConcept subsumingExternalConcept)").
:- assert_kif("(disjointRelation subsumedExternalConcept subsumingExternalConcept)").
:- assert_kif("(documentation synonymousExternalConcept EnglishLanguage \"(&%synonymousExternalConcept ?STRING ?THING ?LANGUAGE) means that the SUMO concept ?THING has the same meaning as ?STRING in ?LANGUAGE.\")").
:- assert_kif("(subrelation subsumingExternalConcept relatedExternalConcept)").
:- assert_kif("(documentation subsumingExternalConcept EnglishLanguage \"(&%subsumingExternalConcept ?STRING ?THING ?LANGUAGE) means that the SUMO concept ?THING subsumes the meaning of ?STRING in ?LANGUAGE, i.e. the concept ?THING is broader in meaning than ?STRING.\")").
:- assert_kif("(subrelation subsumedExternalConcept relatedExternalConcept)").
:- assert_kif("(documentation subsumedExternalConcept EnglishLanguage \"(&%subsumedExternalConcept ?STRING ?THING ?LANGUAGE) means that the SUMO concept ?THING is subsumed by the meaning of ?STRING in ?LANGUAGE, i.e. the concept ?THING is narrower in meaning than ?STRING.\")").
:- assert_kif("(instance externalImage BinaryPredicate)").
:- assert_kif("(documentation externalImage EnglishLanguage \"A link between an Entity and a URL that represents or exemplifies the term in some way.\")").
:- assert_kif("(domain externalImage 1 Entity)").
:- assert_kif("(domain externalImage 2 SymbolicString)").
:- assert_kif("(instance subAttribute BinaryPredicate)").
:- assert_kif("(instance subAttribute PartialOrderingRelation)").
:- assert_kif("(domain subAttribute 1 Attribute)").
:- assert_kif("(domain subAttribute 2 Attribute)").
:- assert_kif("(disjointRelation subAttribute successorAttribute)").
:- assert_kif("(documentation subAttribute EnglishLanguage \"Means that the second argument can be ascribed to everything which has the first argument ascribed to it.\")").
:- assert_kif("(=> (subAttribute ?ATTR1 ?ATTR2) (forall (?OBJ) (=> (property ?OBJ ?ATTR1) (property ?OBJ ?ATTR2))))").
:- assert_kif("(=> (and (subAttribute ?ATTR1 ?ATTR2) (instance ?ATTR2 ?CLASS)) (instance ?ATTR1 ?CLASS))").
:- assert_kif("(instance successorAttribute BinaryPredicate)").
:- assert_kif("(instance successorAttribute AsymmetricRelation)").
:- assert_kif("(domain successorAttribute 1 Attribute)").
:- assert_kif("(domain successorAttribute 2 Attribute)").
:- assert_kif("(documentation successorAttribute EnglishLanguage \"(&%successorAttribute ?ATTR1 ?ATTR2) means that ?ATTR2 is the &%Attribute that comes immediately after ?ATTR1 on the scale that they share.\")").
:- assert_kif("(=> (and (successorAttribute ?ATTR1 ?ATTR2) (holdsDuring ?TIME1 (property ?ENTITY ?ATTR2))) (exists (?TIME2) (and (temporalPart ?TIME2 (PastFn ?TIME1)) (holdsDuring ?TIME2 (property ?ENTITY ?ATTR1)))))").
:- assert_kif("(instance successorAttributeClosure BinaryPredicate)").
:- assert_kif("(instance successorAttributeClosure TransitiveRelation)").
:- assert_kif("(instance successorAttributeClosure IrreflexiveRelation)").
:- assert_kif("(domain successorAttributeClosure 1 Attribute)").
:- assert_kif("(domain successorAttributeClosure 2 Attribute)").
:- assert_kif("(relatedInternalConcept successorAttributeClosure successorAttribute)").
:- assert_kif("(documentation successorAttributeClosure EnglishLanguage \"The transitive closure of &%successorAttribute. (&%successorAttributeClosure ?ATTR1 ?ATTR2) means that there is a chain of &%successorAttribute assertions connecting ?ATTR1 and ?ATTR2.\")").
:- assert_kif("(=> (successorAttribute ?ATTR1 ?ATTR2) (successorAttributeClosure ?ATTR1 ?ATTR2))").
:- assert_kif("(instance greaterThanByQuality TernaryPredicate)").
:- assert_kif("(documentation greaterThanByQuality EnglishLanguage \"(greaterThanByQuality ?ENTITY1 ?ENTITY2 ?ATT) means that ?ENTITY1 has more of the given quality ?ATT than ?ENTITY2)\")").
:- assert_kif("(domain greaterThanByQuality 1 Entity)").
:- assert_kif("(domain greaterThanByQuality 2 Entity)").
:- assert_kif("(domain greaterThanByQuality 3 Attribute)").
:- assert_kif("(=> (and (greaterThanByQuality ?E1 ?E2 ?ATT) (greaterThanByQuality ?E2 ?E3 ?ATT)) (greaterThanByQuality ?E1 ?E3 ?ATT))").
:- assert_kif("(=> (greaterThanByQuality ?E1 ?E2 ?ATT) (not (greaterThanByQuality ?E2 ?E1 ?ATT)))").
:- assert_kif("(=> (greaterThanByQuality ?E1 ?E2 ?ATT) (not (equal ?E2 ?E1)))").
:- assert_kif("(instance entails BinaryPredicate)").
:- assert_kif("(domain entails 1 Formula)").
:- assert_kif("(domain entails 2 Formula)").
:- assert_kif("(documentation entails EnglishLanguage \"The operator of logical entailment. (&%entails ?FORMULA1 ?FORMULA2) means that ?FORMULA2 can be derived from ?FORMULA1 by means of the proof theory of SUO-KIF.\")").
% :- assert_kif("; The following axiom is commented out, because it is rejected by the inference engine parser.").
% :- assert_kif(" (=> (entails ?FORMULA1 ?FORMULA2) (=> ?FORMULA1 ?FORMULA2))").
:- assert_kif("(instance AssignmentFn Function)").
:- assert_kif("(instance AssignmentFn VariableArityRelation)").
:- assert_kif("(domain AssignmentFn 1 Function)").
:- assert_kif("(range AssignmentFn Entity)").
:- assert_kif("(documentation AssignmentFn EnglishLanguage \"If F is a &%Function with a value for the objects denoted by N1,..., NK, then (&%AssignmentFn F N1 ... NK) is the value of applying F to the objects denoted by N1,..., NK. Otherwise, the value is undefined.\")").
:- assert_kif("(instance PowerSetFn UnaryFunction)").
:- assert_kif("(instance PowerSetFn TotalValuedRelation)").
:- assert_kif("(domain PowerSetFn 1 SetOrClass)").
:- assert_kif("(rangeSubclass PowerSetFn SetOrClass)").
:- assert_kif("(documentation PowerSetFn EnglishLanguage \"(&%PowerSetFn ?CLASS) maps the &%SetOrClass ?CLASS to the &%SetOrClass of all &%subclasses of ?CLASS.\")").
% :- assert_kif("; END FILE").
% :- assert_kif("; BEGIN FILE").
% :- assert_kif(";  BASE ONTOLOGY  ").
% :- assert_kif("; INCLUDES 'STRUCTURAL ONTOLOGY'").
% :- assert_kif("; The following hierarchy incorporates content from Sowa, Russell & Norvig, and the top-level ontology from ITBM-CNR.").
:- assert_kif("(partition Entity Physical Abstract)").
:- assert_kif("(documentation Entity EnglishLanguage \"The universal class of individuals. This is the root node of the ontology.\")").
:- assert_kif("(forall (?THING) (instance ?THING Entity))").
:- assert_kif("(exists (?THING) (instance ?THING Entity))").
:- assert_kif("(<=> (instance ?CLASS Class) (subclass ?CLASS Entity))").
:- assert_kif("(subclass Physical Entity)").
:- assert_kif("(partition Physical Object Process)").
:- assert_kif("(documentation Physical EnglishLanguage \"An entity that has a location in space-time. Note that locations are themselves understood to have a location in space-time.\")").
:- assert_kif("(<=> (instance ?PHYS Physical) (exists (?LOC ?TIME) (and (located ?PHYS ?LOC) (time ?PHYS ?TIME))))").
:- assert_kif("(subclass Object Physical)").
:- assert_kif("(documentation Object EnglishLanguage \"Corresponds roughly to the class of ordinary objects. Examples include normal physical objects, geographical regions, and locations of &%Processes, the complement of &%Objects in the &%Physical class. In a 4D ontology, an &%Object is something whose spatiotemporal extent is thought of as dividing into spatial parts roughly parallel to the time-axis.\")").
:- assert_kif("(subclass SelfConnectedObject Object)").
:- assert_kif("(documentation SelfConnectedObject EnglishLanguage \"A &%SelfConnectedObject is any &%Object that does not consist of two or more disconnected parts.\")").
:- assert_kif("(subclass OrganicThing SelfConnectedObject)").
:- assert_kif("(documentation OrganicThing EnglishLanguage \"A &%SelfConnectedObject that is produced by a non-intentional process from an &%Organism. Note that this refers only to the primary cause. That is, a &%PlantAgriculturalProduct is firstly produced by a &%Plant, and only secondarily by a &%Human that is tending the plant.\")").
:- assert_kif("(instance FrontFn SpatialRelation)").
:- assert_kif("(instance FrontFn PartialValuedRelation)").
:- assert_kif("(instance FrontFn UnaryFunction)").
:- assert_kif("(instance FrontFn AsymmetricRelation)").
:- assert_kif("(instance FrontFn IrreflexiveRelation)").
:- assert_kif("(domain FrontFn 1 SelfConnectedObject)").
:- assert_kif("(range FrontFn SelfConnectedObject)").
:- assert_kif("(documentation FrontFn EnglishLanguage \"A &%Function that maps an &%Object to the side that generally receives the most attention or that typically faces the direction in which the &%Object moves. Note that this is a partial function, since some &%Objects do not have sides, e.g. apples and spheres. Note too that the &%range of this &%Function is indefinite in much the way that &%ImmediateFutureFn and &%ImmediatePastFn are indefinite. Although this indefiniteness is undesirable from a theoretical standpoint, it does not have significant practical implications, since there is widespread intersubjective agreement about the most common cases.\")").
:- assert_kif("(=> (instance ?OBJ SelfConnectedObject) (side (FrontFn ?OBJ) ?OBJ))").
:- assert_kif("(instance BackFn SpatialRelation)").
:- assert_kif("(instance BackFn PartialValuedRelation)").
:- assert_kif("(instance BackFn UnaryFunction)").
:- assert_kif("(instance BackFn AsymmetricRelation)").
:- assert_kif("(instance BackFn IrreflexiveRelation)").
:- assert_kif("(domain BackFn 1 SelfConnectedObject)").
:- assert_kif("(range BackFn SelfConnectedObject)").
:- assert_kif("(documentation BackFn EnglishLanguage \"A &%Function that maps an &%Object to the side that is opposite the &%FrontFn of the &%Object. Note that this is a partial function, since some &%Objects do not have sides, e.g. apples and spheres. Note too that the &%range of this &%Function is indefinite in much the way that &%ImmediateFutureFn and &%ImmediatePastFn are indefinite. Although this indefiniteness is undesirable from a theoretical standpoint, it does not have significant practical implications, since there is widespread intersubjective agreement about the most common cases.\")").
:- assert_kif("(=> (instance ?OBJ SelfConnectedObject) (side (BackFn ?OBJ) ?OBJ))").
:- assert_kif("(instance part SpatialRelation)").
:- assert_kif("(instance part PartialOrderingRelation)").
:- assert_kif("(domain part 1 Object)").
:- assert_kif("(domain part 2 Object)").
:- assert_kif("(documentation part EnglishLanguage \"The basic mereological relation. All other mereological relations are defined in terms of this one.  (&%part ?PART ?WHOLE) simply means that the &%Object ?PART is part of the &%Object ?WHOLE. Note that, since &%part is a &%ReflexiveRelation, every &%Object is a part of itself.\")").
:- assert_kif("(instance properPart AsymmetricRelation)").
:- assert_kif("(instance properPart TransitiveRelation)").
:- assert_kif("(subrelation properPart part)").
:- assert_kif("(documentation properPart EnglishLanguage \"(&%properPart ?OBJ1 ?OBJ2) means that ?OBJ1 is a part of ?OBJ2 other than ?OBJ2 itself. This is a &%TransitiveRelation and &%AsymmetricRelation (hence an &%IrreflexiveRelation).\")").
:- assert_kif("(<=> (properPart ?OBJ1 ?OBJ2) (and (part ?OBJ1 ?OBJ2) (not (part ?OBJ2 ?OBJ1))))").
:- assert_kif("(subrelation piece part)").
:- assert_kif("(domain piece 1 Substance)").
:- assert_kif("(domain piece 2 Substance)").
:- assert_kif("(documentation piece EnglishLanguage \"A specialized common sense notion of part for arbitrary parts of &%Substances. Quasi-synonyms are: chunk, hunk, bit, etc. Compare &%component, another subrelation of &%part.\")").
:- assert_kif("(=> (piece ?SUBSTANCE1 ?SUBSTANCE2) (forall (?CLASS) (=> (instance ?SUBSTANCE1 ?CLASS) (instance ?SUBSTANCE2 ?CLASS))))").
:- assert_kif("(subrelation component part)").
:- assert_kif("(domain component 1 CorpuscularObject)").
:- assert_kif("(domain component 2 CorpuscularObject)").
:- assert_kif("(documentation component EnglishLanguage \"A specialized common sense notion of part for heterogeneous parts of complexes. (&%component ?COMPONENT ?WHOLE) means that ?COMPONENT is a component of ?WHOLE. Examples of component include the doors and walls of a house, the states or provinces of a country, or the limbs and organs of an animal. Compare &%piece, which is also a subrelation of &%part.\")").
:- assert_kif("(instance material BinaryPredicate)").
:- assert_kif("(domainSubclass material 1 Substance)").
:- assert_kif("(domain material 2 CorpuscularObject)").
:- assert_kif("(documentation material EnglishLanguage \"(&%material ?SUBSTANCE ?OBJECT) means that ?OBJECT is structurally made up in part of ?SUBSTANCE. This relation encompasses the concepts of 'composed of', 'made of', and 'formed of'. For example, plastic is a &%material of my computer monitor. Compare &%part and its subrelations, viz &%component and &%piece.\")").
:- assert_kif("(subrelation contains partlyLocated)").
:- assert_kif("(instance contains SpatialRelation)").
:- assert_kif("(instance contains AsymmetricRelation)").
:- assert_kif("(disjointRelation contains part)").
:- assert_kif("(domain contains 1 SelfConnectedObject)").
:- assert_kif("(domain contains 2 Object)").
:- assert_kif("(documentation contains EnglishLanguage \"The relation of spatial containment for two separable objects. When the two objects are not separable (e.g. an automobile and one of its seats), the relation of &%part should be used.  (&%contains ?OBJ1 ?OBJ2) means that the &%SelfConnectedObject ?OBJ1 has a space (i.e. a &%Hole) which is at least partially filled by ?OBJ2.\")").
:- assert_kif("(<=> (contains ?OBJ1 ?OBJ2) (exists (?HOLE) (and (hole ?HOLE ?OBJ1) (properlyFills ?OBJ2 ?HOLE))))").
:- assert_kif("(subclass Substance SelfConnectedObject)").
:- assert_kif("(partition Substance PureSubstance Mixture)").
:- assert_kif("(partition Substance SyntheticSubstance NaturalSubstance)").
:- assert_kif("(documentation Substance EnglishLanguage \"An &%Object in which every part is similar to every other in every relevant respect. More precisely, something is a &%Substance when it has only arbitrary pieces as parts - any parts have properties which are similar to those of the whole. Note that a &%Substance may nonetheless have physical properties that vary. For example, the temperature, chemical constitution, density, etc. may change from one part to another. An example would be a body of water.\")").
:- assert_kif("(=> (and (subclass ?OBJECTTYPE Substance) (instance ?OBJECT ?OBJECTTYPE) (part ?PART ?OBJECT)) (instance ?PART ?OBJECTTYPE))").
:- assert_kif("(=> (and (instance ?OBJ Substance) (attribute ?OBJ ?ATTR) (part ?PART ?OBJ)) (attribute ?PART ?ATTR))").
:- assert_kif("(subclass SyntheticSubstance Substance)").
:- assert_kif("(documentation SyntheticSubstance EnglishLanguage \"Any &%Substance that is the result of an &%IntentionalProcess, i.e. any substance that is created by &%Humans.\")").
:- assert_kif("(<=> (instance ?SUBSTANCE SyntheticSubstance) (exists (?PROCESS) (and (instance ?PROCESS IntentionalProcess) (result ?PROCESS ?SUBSTANCE) (instance ?SUBSTANCE Substance))))").
:- assert_kif("(subclass NaturalSubstance Substance)").
:- assert_kif("(documentation NaturalSubstance EnglishLanguage \"Any &%Substance that is not the result of an &%IntentionalProcess, i.e. any substance that occurs naturally.\")").
:- assert_kif("(subclass PureSubstance Substance)").
:- assert_kif("(partition PureSubstance CompoundSubstance ElementalSubstance)").
:- assert_kif("(documentation PureSubstance EnglishLanguage \"The &%Class of &%Substances with constant composition. A &%PureSubstance can be either an element (&%ElementalSubstance) or a compound of elements (&%CompoundSubstance). Examples: Table salt").
:- assert_kif("(sodium chloride, NaCl), sugar (sucrose, C_{12}H_{22}O_{11}), water (H_2O), iron (Fe), copper (Cu), and oxygen (O_2).\")").
:- assert_kif("(subclass ElementalSubstance PureSubstance)").
:- assert_kif("(documentation ElementalSubstance EnglishLanguage \"The &%Class of &%PureSubstances that cannot be separated into two or more &%Substances by ordinary chemical").
:- assert_kif("(or physical) means. This excludes nuclear reactions. &%ElementalSubstances are composed of only one kind of atom. Examples: Iron (Fe), copper (Cu), and oxygen (O_2). &%ElementalSubstances are the simplest &%PureSubstances.\")").
:- assert_kif("(subclass Metal ElementalSubstance)").
:- assert_kif("(documentation Metal EnglishLanguage \"A &%Metal is an &%ElementalSubstance that conducts heat and electricity, is shiny and reflects many colors of light, and can be hammered into sheets or drawn into wire. About 80% of the known chemical elements"). (&%ElementalSubstances) are metals.\")").
:- assert_kif("(subclass Atom ElementalSubstance)").
:- assert_kif("(documentation Atom EnglishLanguage \"An extremely small unit of matter that retains its identity in Chemical reactions. It consists of an &%AtomicNucleus and &%Electrons surrounding the &%AtomicNucleus.\")").
:- assert_kif("(=> (instance ?ATOM Atom) (exists (?PROTON ?ELECTRON) (and (component ?PROTON ?ATOM) (component ?ELECTRON ?ATOM) (instance ?PROTON Proton) (instance ?ELECTRON Electron))))").
:- assert_kif("(=> (instance ?ATOM Atom) (forall (?NUCLEUS1 ?NUCLEUS2) (=> (and (component ?NUCLEUS1 ?ATOM) (component ?NUCLEUS2 ?ATOM) (instance ?NUCLEUS1 AtomicNucleus) (instance ?NUCLEUS2 AtomicNucleus)) (equal ?NUCLEUS1 ?NUCLEUS2))))").
:- assert_kif("(subclass SubatomicParticle ElementalSubstance)").
:- assert_kif("(documentation SubatomicParticle EnglishLanguage \"The class of &%ElementalSubstances that are smaller than &%Atoms and compose &%Atoms.\")").
:- assert_kif("(=> (instance ?PARTICLE SubatomicParticle) (exists (?ATOM) (and (instance ?ATOM Atom) (part ?PARTICLE ?ATOM))))").
:- assert_kif("(subclass AtomicNucleus SubatomicParticle)").
:- assert_kif("(documentation AtomicNucleus EnglishLanguage \"The core of the &%Atom. It is composed of &%Protons and &%Neutrons.\")").
:- assert_kif("(=> (instance ?NUCLEUS AtomicNucleus) (exists (?NEUTRON ?PROTON) (and (component ?NEUTRON ?NUCLEUS) (component ?PROTON ?NUCLEUS) (instance ?NEUTRON Neutron) (instance ?PROTON Proton))))").
:- assert_kif("(subclass Electron SubatomicParticle)").
:- assert_kif("(documentation Electron EnglishLanguage \"&%SubatomicParticles that surround the &%AtomicNucleus. They have a negative charge.\")").
:- assert_kif("(subclass Proton SubatomicParticle)").
:- assert_kif("(documentation Proton EnglishLanguage \"Components of the &%AtomicNucleus. They have a positive charge.\")").
:- assert_kif("(subclass Neutron SubatomicParticle)").
:- assert_kif("(documentation Neutron EnglishLanguage \"Components of the &%AtomicNucleus. They have no charge.\")").
:- assert_kif("(subclass CompoundSubstance PureSubstance)").
:- assert_kif("(documentation CompoundSubstance EnglishLanguage \"The &%Class of &%Substances that contain two or more elements (&%ElementalSubstances), in definite proportion by weight. The composition of a pure compound will be invariant, regardless of the method of preparation. Compounds are composed of more than one kind of atom (element). The term molecule is often used for the smallest unit of a compound that still retains all of the properties of the compound. Examples: Table salt (sodium chloride, NaCl), sugar (sucrose, C_{12}H_{22}O_{11}), and water (H_2O). \")").
:- assert_kif("(subclass Mixture Substance)").
:- assert_kif("(documentation Mixture EnglishLanguage \"A &%Mixture is two or more &%PureSubstances, combined in varying proportions - each retaining its own specific properties. The components of a &%Mixture can be separated by physical means, i.e. without the making and breaking of chemical bonds. Examples: Air, table salt thoroughly dissolved in water, milk, wood, and concrete. \")").
:- assert_kif("(=> (instance ?MIXTURE Mixture) (exists (?PURE1 ?PURE2) (and (instance ?PURE1 PureSubstance) (instance ?PURE2 PureSubstance) (not (equal ?PURE1 ?PURE2)) (part ?PURE1 ?MIXTURE) (part ?PURE2 ?MIXTURE))))").
:- assert_kif("(=> (and (instance ?MIXTURE Mixture) (part ?SUBSTANCE ?MIXTURE) (not (instance ?SUBSTANCE Mixture))) (instance ?SUBSTANCE PureSubstance))").
:- assert_kif("(subclass CorpuscularObject SelfConnectedObject)").
:- assert_kif("(disjoint CorpuscularObject Substance)").
:- assert_kif("(documentation CorpuscularObject EnglishLanguage \"A &%SelfConnectedObject whose parts have properties that are not shared by the whole.\")").
:- assert_kif("(=> (instance ?OBJ CorpuscularObject) (exists (?SUBSTANCE1 ?SUBSTANCE2) (and (subclass ?SUBSTANCE1 Substance) (subclass ?SUBSTANCE2 Substance) (material ?SUBSTANCE1 ?OBJ) (material ?SUBSTANCE2 ?OBJ) (not (equal ?SUBSTANCE1 ?SUBSTANCE2)))))").
:- assert_kif("(subclass Region Object)").
:- assert_kif("(documentation Region EnglishLanguage \"A topographic location. &%Regions encompass surfaces of &%Objects, imaginary places, and &%GeographicAreas. Note that a &%Region is the only kind of &%Object which can be located at itself. Note too that &%Region is not a subclass of &%SelfConnectedObject, because some &%Regions, e.g. archipelagos, have &%parts which are not &%connected with one another.\")").
:- assert_kif("(=> (instance ?REGION Region) (exists (?PHYS) (located ?PHYS ?REGION)))").
:- assert_kif("(subclass Collection Object)").
:- assert_kif("(disjoint Collection SelfConnectedObject)").
:- assert_kif("(documentation Collection EnglishLanguage \"Collections have &%members like &%Classes, but, unlike &%Classes, they have a position in space-time and &%members can be added and subtracted without thereby changing the identity of the &%Collection. Some examples are toolkits, football teams, and flocks of sheep.\")").
:- assert_kif("(=> (instance ?COLL Collection) (exists (?OBJ) (member ?OBJ ?COLL)))").
:- assert_kif("(subrelation member part)").
:- assert_kif("(instance member AsymmetricRelation)").
:- assert_kif("(instance member IntransitiveRelation)").
:- assert_kif("(domain member 1 SelfConnectedObject)").
:- assert_kif("(domain member 2 Collection)").
:- assert_kif("(relatedInternalConcept member instance)").
:- assert_kif("(relatedInternalConcept member element)").
:- assert_kif("(documentation member EnglishLanguage \"A specialized common sense notion of part for uniform parts of &%Collections. For example, each sheep in a flock of sheep would have the relationship of member to the flock.\")").
:- assert_kif("(instance subCollection BinaryPredicate)").
:- assert_kif("(instance subCollection PartialOrderingRelation)").
:- assert_kif("(domain subCollection 1 Collection)").
:- assert_kif("(domain subCollection 2 Collection)").
:- assert_kif("(documentation subCollection EnglishLanguage \"(&%subCollection ?COLL1 ?COLL2) means that the &%Collection ?COLL1 is a proper part of the &%Collection ?COLL2.\")").
:- assert_kif("(subrelation subCollection part)").
:- assert_kif("(<=> (subCollection ?COLL1 ?COLL2) (forall (?MEMBER) (=> (member ?MEMBER ?COLL1) (member ?MEMBER ?COLL2))))").
:- assert_kif("(subclass ContentBearingPhysical Physical)").
:- assert_kif("(documentation ContentBearingPhysical EnglishLanguage \"Any &%Object or &%Process that expresses content. This covers &%Objects that contain a &%Proposition, such as a book, as well as &%ManualSignLanguage, which may similarly contain a &%Proposition.\")").
:- assert_kif("(=> (instance ?OBJ ContentBearingPhysical) (exists (?THING) (represents ?OBJ ?THING)))").
:- assert_kif("(subclass ContentBearingProcess ContentBearingPhysical)").
% :- assert_kif("; NS: add. Missing!").
:- assert_kif("(subclass ContentBearingProcess Process)").
% :- assert_kif("; NS: cf. Note that &%ManualHumanLanguage is not a subclass of &%Process, despite the documentation statement below.").
:- assert_kif("(documentation ContentBearingProcess EnglishLanguage \"Any &%Process, for example &%ManualHumanLanguage, which may contain a &%Proposition.\")").
:- assert_kif("(subclass ContentBearingObject CorpuscularObject)").
:- assert_kif("(subclass ContentBearingObject ContentBearingPhysical)").
:- assert_kif("(relatedInternalConcept ContentBearingObject containsInformation)").
:- assert_kif("(documentation ContentBearingObject EnglishLanguage \"Any &%SelfConnectedObject that expresses content. This content may be a &%Proposition, e.g. when the &%ContentBearingObject is a &%Sentence or &%Text, or it may be a representation of an abstract or physical object, as with an &%Icon, a &%Word or a &%Phrase.\")").
:- assert_kif("(subclass SymbolicString ContentBearingObject)").
:- assert_kif("(documentation SymbolicString EnglishLanguage \"The &%Class of alphanumeric sequences.\")").
:- assert_kif("(subclass Character SymbolicString)").
:- assert_kif("(documentation Character EnglishLanguage \"An element of an alphabet, a set of numerals, etc. Note that a &%Character may or may not be part of a &%Language. &%Character is a subclass of &%SymbolicString, because every instance of &%Character is an alphanumeric sequence consisting of a single element.\")").
:- assert_kif("(=> (instance ?STRING SymbolicString) (exists (?PART) (and (part ?PART ?STRING) (instance ?PART Character))))").
:- assert_kif("(instance containsInformation BinaryPredicate)").
:- assert_kif("(instance containsInformation AsymmetricRelation)").
:- assert_kif("(subrelation containsInformation represents)").
:- assert_kif("(domain containsInformation 1 ContentBearingPhysical)").
:- assert_kif("(domain containsInformation 2 Proposition)").
:- assert_kif("(documentation containsInformation EnglishLanguage \"A subrelation of &%represents. This predicate relates a &%ContentBearingPhysical to the &%Proposition that is expressed by the &%ContentBearingPhysical. Examples include the relationships between a physical novel and its story and between a printed score and its musical content.\")").
:- assert_kif("(subclass Icon ContentBearingPhysical)").
:- assert_kif("(documentation Icon EnglishLanguage \"This is the subclass of &%ContentBearingPhysical which are not part of a &%Language and which have some sort of similarity with the &%Objects that they represent. This &%Class would include symbolic roadway signs, representational art works, photographs, etc.\")").
:- assert_kif("(subclass MotionPicture Text)").
:- assert_kif("(documentation MotionPicture EnglishLanguage \"A &%ContentBearingObject which depicts motion").
:- assert_kif("(and which may have an audio or text component as well). This &%Class covers films, videos, etc.\")").
:- assert_kif("(subclass LinguisticExpression ContentBearingPhysical)").
:- assert_kif("(disjoint LinguisticExpression Icon)").
:- assert_kif("(documentation LinguisticExpression EnglishLanguage \"This is the subclass of &%ContentBearingPhysical which are language-related. Note that this &%Class encompasses both &%Language and the the elements of &%Languages, e.g. &%Words.\")").
:- assert_kif("(subclass Language LinguisticExpression)").
:- assert_kif("(disjointDecomposition Language AnimalLanguage HumanLanguage ComputerLanguage)").
:- assert_kif("(documentation Language EnglishLanguage \"A system of signs for expressing thought. The system can be either natural or artificial, i.e. something that emerges gradually as a cultural artifact or something that is intentionally created by a person or group of people.\")").
:- assert_kif("(subclass AnimalLanguage Language)").
:- assert_kif("(documentation AnimalLanguage EnglishLanguage \"The &%subclass of &%Languages used by &%Animals other than &%Humans.\")").
:- assert_kif("(=> (and (instance ?LANG AnimalLanguage) (agent ?PROC ?AGENT) (instrument ?PROC ?LANG)) (and (instance ?AGENT Animal) (not (instance ?AGENT Human))))").
:- assert_kif("(subclass ArtificialLanguage Language)").
:- assert_kif("(documentation ArtificialLanguage EnglishLanguage \"The &%subclass of &%Languages that are designed by &%Humans.\")").
:- assert_kif("(subclass ComputerLanguage ArtificialLanguage)").
:- assert_kif("(documentation ComputerLanguage EnglishLanguage \"The class of &%Languages designed for and interpreted by a computer.\")").
:- assert_kif("(=> (and (instance ?LANG ComputerLanguage) (agent ?PROC ?AGENT) (instrument ?PROC ?LANG)) (instance ?AGENT Machine))").
:- assert_kif("(subclass HumanLanguage Language)").
:- assert_kif("(partition HumanLanguage NaturalLanguage ConstructedLanguage)").
:- assert_kif("(partition HumanLanguage SpokenHumanLanguage ManualHumanLanguage)").
:- assert_kif("(documentation HumanLanguage EnglishLanguage \"The &%subclass of &%Languages used by &%Humans.\")").
:- assert_kif("(=> (and (instance ?LANG HumanLanguage) (agent ?PROC ?AGENT) (instrument ?PROC ?LANG)) (instance ?AGENT Human))").
:- assert_kif("(subclass ConstructedLanguage HumanLanguage)").
:- assert_kif("(subclass ConstructedLanguage ArtificialLanguage)").
:- assert_kif("(documentation ConstructedLanguage EnglishLanguage \"An &%ConstructedLanguage is a &%HumanLanguage that did not evolve spontaneously within a language community, but rather had its core grammar and vocabulary invented by one or more language experts, often with an aim to produce a more grammatically regular language than any language that has evolved naturally. This &%Class includes languages like Esperanto that were created to facilitate international communication\")").
:- assert_kif("(=> (instance ?LANG ConstructedLanguage) (exists (?PLAN) (and (instance ?PLAN Planning) (result ?PLAN ?LANG))))").
:- assert_kif("(subclass NaturalLanguage HumanLanguage)").
:- assert_kif("(documentation NaturalLanguage EnglishLanguage \"The &%subclass of &%HumanLanguages which are not designed and which evolve from generation to generation. This &%Class includes all of the national languages, e.g. English, Spanish, Japanese, etc. Note that this class includes dialects of natural languages.\")").
:- assert_kif("(subclass ManualHumanLanguage HumanLanguage)").
:- assert_kif("(documentation ManualHumanLanguage EnglishLanguage \"A &%ManualHumanLanguage is a &%HumanLanguage which has as its medium gestures and movement, such as the shape, position, and movement of the hands.\")").
:- assert_kif("(subclass SpokenHumanLanguage HumanLanguage)").
:- assert_kif("(documentation SpokenHumanLanguage EnglishLanguage \"A &%SpokenHumanLanguage is a &%HumanLanguage which has as its medium the human voice. It can also berepresented visually through writing, although not all &%SpokenHumanLanguages have a codified written form.\")").
:- assert_kif("(instance EnglishLanguage NaturalLanguage)").
:- assert_kif("(instance EnglishLanguage SpokenHumanLanguage)").
:- assert_kif("(documentation EnglishLanguage EnglishLanguage \"A Germanic language that incorporates many roots from the Romance languages. It is the official language of the &%UnitedStates, the &%UnitedKingdom, and many other countries.\")").
:- assert_kif("(subclass Word LinguisticExpression)").
:- assert_kif("(documentation Word EnglishLanguage \"A term of a &%Language that represents a concept.\")").
:- assert_kif("(subclass Formula Sentence)").
:- assert_kif("(documentation Formula EnglishLanguage \"A syntactically well-formed formula in the SUO-KIF knowledge representation language.\")").
% :- assert_kif("; The following ground facts incorporate the 'Agent' hierarchy from the corresponding ontology on the Ontolingua server. It also includes predicates defined in the ITBM-CNR ontology \"Actors\".").
:- assert_kif("(subclass Agent Object)").
:- assert_kif("(documentation Agent EnglishLanguage \"Something or someone that can act on its own and produce changes in the world.\")").
:- assert_kif("(<=> (instance ?AGENT Agent) (exists (?PROC) (agent ?PROC ?AGENT)))").
:- assert_kif("(subclass SentientAgent Agent)").
% :- assert_kif("; NS: delete. (documentation SentientAgent EnglishLanguage \"An &%Agent that has rights but may or may not have responsibilities and the ability to reason. If the latter are present, then the &%Agent is also an instance of &%CognitiveAgent. Domesticated animals are an example of &%SentientAgents that are not also &%CognitiveAgents.\")").
% :- assert_kif("; NS: add.").
:- assert_kif("(documentation SentientAgent EnglishLanguage \"A &%SentientAgent is an &%Agent that is capable of &%Perception and experiences some level of consciousness (see &%ConsciousnessAttribute). If the &%Agent is able to reason at a comparatively high level (evinced by the ability to learn, plan, and feel emotions), then it is also an instance of &%CognitiveAgent. A &%DomesticAnimal is a &%SentientAgent, but may or may not be a &%CognitiveAgent, depending on the type of &%Animal.\")").
:- assert_kif("(subclass CognitiveAgent SentientAgent)").
% :- assert_kif("; NS: delete. (documentation CognitiveAgent EnglishLanguage \"A &%SentientAgent with responsibilities and the ability to reason, deliberate, make plans, etc. This is essentially the legal/ethical notion of a person. Note that, although &%Human is a subclass of &%CognitiveAgent, there may be instances of &%CognitiveAgent which are not also instances of &%Human. For example, chimpanzees, gorillas, dolphins, whales, and some extraterrestrials (if they exist) may be &%CognitiveAgents.\")").
% :- assert_kif("; NS: add.").
:- assert_kif("(documentation CognitiveAgent EnglishLanguage \"A &%CognitiveAgent is an &%Agent that has the ability to reason, deliberate, make plans, and experience emotions. Although &%Human is a subclass of &%CognitiveAgent, there may be instances of &%CognitiveAgent which are not also instances of &%Human. For example, &%Primates, dolphins, whales, and some extraterrestrials (if they exist) might be considered &%CognitiveAgents.\")").
% :- assert_kif("; NS: new. Since an Entity might or might not be considered a LegalAgent for its entire existence, depending on the circumstances, it might be better to represent &%LegalAgent as a &%RelationalAttribute.").
:- assert_kif("(subclass LegalAgent Agent)").
% :- assert_kif("; NS: add.").
:- assert_kif("(documentation LegalAgent EnglishLanguage \"A &%LegalAgent is an &%Agent that is allowed by law to to act and be treated as a legal person for certain purposes, such as being a party to a lawsuit, owning property, and entering into a contract. Typically, a &%LegalAgent is either an adult &%Human or some type of &%Organization. Depending on the prevailing legal system in a given time and location, &%Humans in general, as well as other &%CognitiveAgents, typically will have additional legal rights and obligations beyond those accorded to &%LegalAgents. See the Wikipedia description of <a href=http://en.wikipedia.org/wiki/Juristic_person>Juristic person</a>.\")").
% :- assert_kif("; NS: add.").
:- assert_kif("(<=> (holdsDuring ?TIME (instance ?AGENT LegalAgent)) (holdsDuring ?TIME (or (capability LegalAction agent ?AGENT) (capability LegalAction patient ?AGENT))))").
:- assert_kif("(instance leader BinaryPredicate)").
:- assert_kif("(instance leader AsymmetricRelation)").
:- assert_kif("(instance leader SingleValuedRelation)").
:- assert_kif("(domain leader 1 Agent)").
:- assert_kif("(domain leader 2 Human)").
:- assert_kif("(documentation leader EnglishLanguage \"(&%leader ?INSTITUTION ?PERSON) means that the leader of ?INSTITUTION is ?PERSON.\")").
:- assert_kif("(=> (holdsDuring ?TIME (leader ?X ?Y)) (holdsDuring ?TIME (attribute ?Y Living)))").
:- assert_kif("(subclass Process Physical)").
:- assert_kif("(documentation Process EnglishLanguage \"The class of things that happen and have temporal parts or stages. Examples include extended events like a football match or a race, actions like &%Pursuing and &%Reading, and biological processes. The formal definition is: anything that occurs in time but is not an &%Object. Note that a &%Process may have participants 'inside' it which are &%Objects, such as the players in a football match. In a 4D ontology, a &%Process is something whose spatiotemporal extent is thought of as dividing into temporal stages roughly perpendicular to the time-axis.\")").
:- assert_kif("(subclass DualObjectProcess Process)").
:- assert_kif("(documentation DualObjectProcess EnglishLanguage \"Any &%Process that requires two, nonidentical &%patients.\")").
:- assert_kif("(=> (instance ?PROCESS DualObjectProcess) (exists (?OBJ1 ?OBJ2) (and (patient ?PROCESS ?OBJ1) (patient ?PROCESS ?OBJ2) (not (equal ?OBJ1 ?OBJ2)))))").
:- assert_kif("(subclass SingleAgentProcess Process)").
:- assert_kif("(documentation SingleAgentProcess EnglishLanguage \"&%SingleAgentProcess is the &%Class of all &%Processes that require exactly one &%agent in order to occur.\")").
:- assert_kif("(=> (instance ?PROC SingleAgentProcess) (exists (?AGENT) (agent ?PROC ?AGENT)))").
:- assert_kif("(=> (and (instance ?PROC SingleAgentProcess) (agent ?PROC ?AGENT_1) (agent ?PROC ?AGENT_2)) (equal ?AGENT_1 ?AGENT_2))").
:- assert_kif("(subclass Abstract Entity)").
:- assert_kif("(disjointDecomposition Abstract Quantity Attribute SetOrClass Relation Proposition)").
:- assert_kif("(documentation Abstract EnglishLanguage \"Properties or qualities as distinguished from any particular embodiment of the properties/qualities in a physical medium. Instances of Abstract can be said to exist in the same sense as mathematical objects such as sets and relations, but they cannot exist at a particular place and time without some physical encoding or embodiment.\")").
% :- assert_kif("; Something is Abstract just in case it has neither a spatial nor temporal location.").
:- assert_kif("(<=> (instance ?ABS Abstract) (not (exists (?POINT) (or (located ?ABS ?POINT) (time ?ABS ?POINT)))))").
:- assert_kif("(subclass Quantity Abstract)").
:- assert_kif("(documentation Quantity EnglishLanguage \"Any specification of how many or how much of something there is. Accordingly, there are two subclasses of &%Quantity: &%Number (how many) and &%PhysicalQuantity (how much).\")").
:- assert_kif("(subclass Attribute Abstract)").
:- assert_kif("(partition Attribute InternalAttribute RelationalAttribute PerceptualAttribute)").
:- assert_kif("(documentation Attribute EnglishLanguage \"Qualities which we cannot or choose not to reify into subclasses of &%Object.\")").
:- assert_kif("(instance property BinaryPredicate)").
:- assert_kif("(domain property 1 Entity)").
:- assert_kif("(domain property 2 Attribute)").
:- assert_kif("(documentation property EnglishLanguage \"This &%Predicate holds between an instance of &%Entity and an instance of &%Attribute. (&%property ?ENTITY ?ATTR) means that ?ENTITY has the &%Attribute ?ATTR.\")").
:- assert_kif("(instance attribute AsymmetricRelation)").
:- assert_kif("(instance attribute IrreflexiveRelation)").
:- assert_kif("(subrelation attribute property)").
:- assert_kif("(domain attribute 1 Object)").
:- assert_kif("(documentation attribute EnglishLanguage \"(&%attribute ?OBJECT ?PROPERTY) means that ?PROPERTY is a &%Attribute of ?OBJECT. For example,"). (&%attribute &%MyLittleRedWagon &%Red).\")").
:- assert_kif("(instance manner AsymmetricRelation)").
:- assert_kif("(instance manner IrreflexiveRelation)").
:- assert_kif("(subrelation manner property)").
:- assert_kif("(domain manner 1 Process)").
:- assert_kif("(disjointRelation manner attribute)").
:- assert_kif("(documentation manner EnglishLanguage \"(&%manner ?PROCESS ?MANNER) means that the &%Process ?PROCESS is qualified by the &%Attribute ?MANNER. The &%Attributes of &%Processes are usually denoted by adverbs and include things like the speed of the wind, the style of a dance, or the intensity of a sports competition.\")").
% :- assert_kif("; Seldom used function that appears to cause a very complex contradiction").
% :- assert_kif(" (instance AbstractionFn UnaryFunction) (instance AbstractionFn PartialValuedRelation) (domain AbstractionFn 1 Class) (range AbstractionFn Attribute) (documentation AbstractionFn EnglishLanguage \"A &%UnaryFunction that maps a &%Class into the instance of &%Attribute that specifies the condition(s) for membership in the &%Class.\")").
% :- assert_kif(" (<=> (equal (AbstractionFn ?CLASS) ?ATTR) (forall (?INST) (<=> (instance ?INST ?CLASS) (property ?INST ?ATTR))))").
:- assert_kif("(instance ExtensionFn UnaryFunction)").
:- assert_kif("(instance ExtensionFn PartialValuedRelation)").
:- assert_kif("(domain ExtensionFn 1 Attribute)").
:- assert_kif("(range ExtensionFn Class)").
:- assert_kif("(documentation ExtensionFn EnglishLanguage \"A &%UnaryFunction that maps an &%Attribute into the &%Class whose condition for membership is the &%Attribute.\")").
% :- assert_kif(" (<=> (equal (ExtensionFn ?ATTRIBUTE) ?CLASS) (equal (AbstractionFn ?CLASS) ?ATTRIBUTE))").
:- assert_kif("(subclass InternalAttribute Attribute)").
:- assert_kif("(documentation InternalAttribute EnglishLanguage \"Any &%Attribute of an &%Entity that is an internal property of the &%Entity, e.g. its shape, its color, its fragility, etc.\")").
:- assert_kif("(documentation PhysicalAttribute EnglishLanguage \"An &%InternalAttribute given by physical properties of the object.\")").
:- assert_kif("(subclass PhysicalAttribute InternalAttribute)").
:- assert_kif("(subclass RelationalAttribute Attribute)").
:- assert_kif("(documentation RelationalAttribute EnglishLanguage \"Any &%Attribute that an &%Entity has by virtue of a relationship that it bears to another &%Entity or set of &%Entities, e.g. &%SocialRoles and &%PositionalAttributes.\")").
% :- assert_kif("; The following formulas incorporate the Number hierarchy from the ontology 'kif-numbers' on the Ontolingua server.").
:- assert_kif("(subclass Number Quantity)").
:- assert_kif("(partition Number RealNumber ImaginaryNumber ComplexNumber)").
:- assert_kif("(documentation Number EnglishLanguage \"A measure of how many things there are, or how much there is, of a certain kind. &%Numbers are subclassed into &%RealNumber, &%ComplexNumber, and &%ImaginaryNumber.\")").
:- assert_kif("(instance lessThan BinaryPredicate)").
:- assert_kif("(instance lessThan TransitiveRelation)").
:- assert_kif("(instance lessThan IrreflexiveRelation)").
:- assert_kif("(instance lessThan RelationExtendedToQuantities)").
:- assert_kif("(trichotomizingOn lessThan RealNumber)").
:- assert_kif("(domain lessThan 1 Quantity)").
:- assert_kif("(domain lessThan 2 Quantity)").
:- assert_kif("(documentation lessThan EnglishLanguage \"(&%lessThan ?NUMBER1 ?NUMBER2) is true just in case the &%Quantity ?NUMBER1 is less than the &%Quantity ?NUMBER2.\")").
:- assert_kif("(instance greaterThan BinaryPredicate)").
:- assert_kif("(instance greaterThan TransitiveRelation)").
:- assert_kif("(instance greaterThan IrreflexiveRelation)").
:- assert_kif("(instance greaterThan RelationExtendedToQuantities)").
:- assert_kif("(trichotomizingOn greaterThan RealNumber)").
:- assert_kif("(domain greaterThan 1 Quantity)").
:- assert_kif("(domain greaterThan 2 Quantity)").
:- assert_kif("(inverse greaterThan lessThan)").
:- assert_kif("(documentation greaterThan EnglishLanguage \"(&%greaterThan ?NUMBER1 ?NUMBER2) is true just in case the &%Quantity ?NUMBER1 is greater than the &%Quantity ?NUMBER2.\")").
:- assert_kif("(instance lessThanOrEqualTo BinaryPredicate)").
:- assert_kif("(instance lessThanOrEqualTo PartialOrderingRelation)").
:- assert_kif("(instance lessThanOrEqualTo RelationExtendedToQuantities)").
:- assert_kif("(trichotomizingOn lessThanOrEqualTo RealNumber)").
:- assert_kif("(domain lessThanOrEqualTo 1 Quantity)").
:- assert_kif("(domain lessThanOrEqualTo 2 Quantity)").
:- assert_kif("(documentation lessThanOrEqualTo EnglishLanguage \"(&%lessThanOrEqualTo ?NUMBER1 ?NUMBER2) is true just in case the &%Quantity ?NUMBER1 is less than or equal to the &%Quantity ?NUMBER2.\")").
:- assert_kif("(<=> (lessThanOrEqualTo ?NUMBER1 ?NUMBER2) (or (equal ?NUMBER1 ?NUMBER2) (lessThan ?NUMBER1 ?NUMBER2)))").
:- assert_kif("(instance greaterThanOrEqualTo BinaryPredicate)").
:- assert_kif("(instance greaterThanOrEqualTo PartialOrderingRelation)").
:- assert_kif("(instance greaterThanOrEqualTo RelationExtendedToQuantities)").
:- assert_kif("(trichotomizingOn greaterThanOrEqualTo RealNumber)").
:- assert_kif("(domain greaterThanOrEqualTo 1 Quantity)").
:- assert_kif("(domain greaterThanOrEqualTo 2 Quantity)").
:- assert_kif("(inverse greaterThanOrEqualTo lessThanOrEqualTo)").
:- assert_kif("(documentation greaterThanOrEqualTo EnglishLanguage \"(&%greaterThanOrEqualTo ?NUMBER1 ?NUMBER2) is true just in case the &%Quantity ?NUMBER1 is greater than the &%Quantity ?NUMBER2.\")").
:- assert_kif("(<=> (greaterThanOrEqualTo ?NUMBER1 ?NUMBER2) (or (equal ?NUMBER1 ?NUMBER2) (greaterThan ?NUMBER1 ?NUMBER2)))").
:- assert_kif("(subclass RealNumber Number)").
:- assert_kif("(partition RealNumber NegativeRealNumber NonnegativeRealNumber)").
:- assert_kif("(partition RealNumber RationalNumber IrrationalNumber)").
:- assert_kif("(documentation RealNumber EnglishLanguage \"Any &%Number that can be expressed as a").
:- assert_kif("(possibly infinite) decimal, i.e. any &%Number that has a position on the number line.\")").
:- assert_kif("(subclass ImaginaryNumber Number)").
:- assert_kif("(documentation ImaginaryNumber EnglishLanguage \"Any &%Number that is the result of multiplying a &%RealNumber by the square root of -1.\")").
:- assert_kif("(=> (instance ?NUMBER ImaginaryNumber) (exists (?REAL) (and (instance ?REAL RealNumber) (equal ?NUMBER (MultiplicationFn ?REAL (SquareRootFn -1))))))").
:- assert_kif("(subclass RationalNumber RealNumber)").
:- assert_kif("(documentation RationalNumber EnglishLanguage \"Any &%RealNumber that is the product of dividing two &%Integers.\")").
:- assert_kif("(subclass IrrationalNumber RealNumber)").
:- assert_kif("(documentation IrrationalNumber EnglishLanguage \"Any &%RealNumber that is not also a &%RationalNumber.\")").
:- assert_kif("(subclass NonnegativeRealNumber RealNumber)").
:- assert_kif("(documentation NonnegativeRealNumber EnglishLanguage \"A &%RealNumber that is greater than or equal to zero.\")").
:- assert_kif("(<=> (instance ?NUMBER NonnegativeRealNumber) (and (greaterThanOrEqualTo ?NUMBER 0) (instance ?NUMBER RealNumber)))").
:- assert_kif("(subclass PositiveRealNumber NonnegativeRealNumber)").
:- assert_kif("(documentation PositiveRealNumber EnglishLanguage \"A &%RealNumber that is greater than zero.\")").
:- assert_kif("(<=> (instance ?NUMBER PositiveRealNumber) (and (greaterThan ?NUMBER 0) (instance ?NUMBER RealNumber)))").
:- assert_kif("(subclass NegativeRealNumber RealNumber)").
:- assert_kif("(documentation NegativeRealNumber EnglishLanguage \"A &%RealNumber that is less than zero.\")").
:- assert_kif("(<=> (instance ?NUMBER NegativeRealNumber) (and (lessThan ?NUMBER 0) (instance ?NUMBER RealNumber)))").
:- assert_kif("(subclass Integer RationalNumber)").
:- assert_kif("(partition Integer OddInteger EvenInteger)").
:- assert_kif("(partition Integer NegativeInteger NonnegativeInteger)").
:- assert_kif("(documentation Integer EnglishLanguage \"A negative or nonnegative whole number.\")").
:- assert_kif("(subclass EvenInteger Integer)").
:- assert_kif("(documentation EvenInteger EnglishLanguage \"An &%Integer that is evenly divisible by 2.\")").
:- assert_kif("(subclass OddInteger Integer)").
:- assert_kif("(documentation OddInteger EnglishLanguage \"An &%Integer that is not evenly divisible by 2.\")").
:- assert_kif("(subclass PrimeNumber Integer)").
:- assert_kif("(documentation PrimeNumber EnglishLanguage \"An &%Integer that is evenly divisible only by itself and 1.\")").
:- assert_kif("(subclass NonnegativeInteger Integer)").
:- assert_kif("(subclass NonnegativeInteger NonnegativeRealNumber)").
:- assert_kif("(documentation NonnegativeInteger EnglishLanguage \"An &%Integer that is greater than or equal to zero.\")").
:- assert_kif("(=> (instance ?X NonnegativeInteger) (greaterThan ?X -1))").
:- assert_kif("(subclass NegativeInteger Integer)").
:- assert_kif("(subclass NegativeInteger NegativeRealNumber)").
:- assert_kif("(documentation NegativeInteger EnglishLanguage \"An &%Integer that is less than zero.\")").
:- assert_kif("(=> (instance ?X NegativeInteger) (greaterThan 0 ?X))").
:- assert_kif("(subclass PositiveInteger NonnegativeInteger)").
:- assert_kif("(subclass PositiveInteger PositiveRealNumber)").
:- assert_kif("(documentation PositiveInteger EnglishLanguage \"An &%Integer that is greater than zero.\")").
:- assert_kif("(=> (instance ?X PositiveInteger) (greaterThan ?X 0))").
:- assert_kif("(subclass BinaryNumber RealNumber)").
:- assert_kif("(documentation BinaryNumber EnglishLanguage \"Elements from the number system with base 2. Every &%BinaryNumber is expressed as a sequence of the digits 1 and 0.\")").
:- assert_kif("(subclass ComplexNumber Number)").
:- assert_kif("(disjoint ComplexNumber RealNumber)").
:- assert_kif("(documentation ComplexNumber EnglishLanguage \"A &%Number that has the form: x + yi, where x and y are &%RealNumbers and i is the square root of -1.\")").
:- assert_kif("(=> (instance ?NUMBER ComplexNumber) (exists (?REAL1 ?REAL2) (and (instance ?REAL1 RealNumber) (instance ?REAL2 RealNumber) (equal ?NUMBER (AdditionFn ?REAL1 (MultiplicationFn ?REAL2 (SquareRootFn -1)))))))").
:- assert_kif("(subclass PhysicalQuantity Quantity)").
:- assert_kif("(partition PhysicalQuantity ConstantQuantity FunctionQuantity)").
:- assert_kif("(documentation PhysicalQuantity EnglishLanguage \"A &%PhysicalQuantity is a measure of some quantifiable aspect of the modeled world, such as 'the earth's diameter' (a constant length) and 'the stress in a loaded deformable solid' (a measure of stress, which is a function of three spatial coordinates). Every &%PhysicalQuantity is either a &%ConstantQuantity or &%FunctionQuantity. Instances of &%ConstantQuantity are dependent on a &%UnitOfMeasure, while instances of &%FunctionQuantity are &%Functions that map instances of &%ConstantQuantity to other instances of &%ConstantQuantity (e.g., a &%TimeDependentQuantity is a &%FunctionQuantity). Although the name and definition of &%PhysicalQuantity is borrowed from physics, a &%PhysicalQuantity need not be material. Aside from the dimensions of length, time, velocity, etc., nonphysical dimensions such as currency are also possible. Accordingly, amounts of money would be instances of &%PhysicalQuantity. A &%PhysicalQuantity is distinguished from a pure &%Number by the fact that the former is associated with a dimension of measurement.\")").
:- assert_kif("(subclass ConstantQuantity PhysicalQuantity)").
:- assert_kif("(documentation ConstantQuantity EnglishLanguage \"A &%ConstantQuantity is a &%PhysicalQuantity that has a constant value, e.g. 3 &%Meters and 5 &%HourDurations. The magnitude (see &%MagnitudeFn) of every &%ConstantQuantity is a &%RealNumber. &%ConstantQuantity is distinguished from &%FunctionQuantity, in that each instance of the latter is formed through the mapping of one &%PhysicalQuantity to another &%PhysicalQuantity. Each instance of &%ConstantQuantity is expressed with the &%BinaryFunction &%MeasureFn, which takes a &%Number and a &%UnitOfMeasure as arguments. For example, 3 &%Meters is expressed as (&%MeasureFn 3 &%Meter). Instances of &%ConstantQuantity form a partial order (see &%PartialOrderingRelation) with the &%lessThan relation, since &%lessThan is a &%RelationExtendedToQuantities and &%lessThan is defined over the &%RealNumbers. The &%lessThan relation is not a total order (see &%TotalOrderingRelation) over the class &%ConstantQuantity since elements of some subclasses of &%ConstantQuantity (such as length quantities) are incomparable to elements of other subclasses of &%ConstantQuantity").
:- assert_kif("(such as mass quantities).\")").
:- assert_kif("(subclass TimeMeasure ConstantQuantity)").
:- assert_kif("(documentation TimeMeasure EnglishLanguage \"The class of temporal durations (instances of &%TimeDuration) and positions of &%TimePoints and &%TimeIntervals along the universal timeline (instances of &%TimePosition).\")").
:- assert_kif("(subclass TimeDuration TimeMeasure)").
:- assert_kif("(documentation TimeDuration EnglishLanguage \"Any measure of length of time, with or without respect to the universal timeline.\")").
:- assert_kif("(subclass TimePosition TimeMeasure)").
:- assert_kif("(partition TimePosition TimeInterval TimePoint)").
:- assert_kif("(documentation TimePosition EnglishLanguage \"Any &%TimePoint or &%TimeInterval along the universal timeline from &%NegativeInfinity to &%PositiveInfinity.\")").
:- assert_kif("(subclass TimeInterval TimePosition)").
:- assert_kif("(documentation TimeInterval EnglishLanguage \"An interval of time. Note that a &%TimeInterval has both an extent and a location on the universal timeline. Note too that a &%TimeInterval has no gaps, i.e. this class contains only convex time intervals.\")").
:- assert_kif("(subclass TimePoint TimePosition)").
:- assert_kif("(documentation TimePoint EnglishLanguage \"An extensionless point on the universal timeline. The &%TimePoints at which &%Processes occur can be known with various degrees of precision and approximation, but conceptually &%TimePoints are point-like and not interval-like. That is, it doesn't make sense to talk about how long a &%TimePoint lasts.\")").
:- assert_kif("(subclass FunctionQuantity PhysicalQuantity)").
:- assert_kif("(documentation FunctionQuantity EnglishLanguage \"A &%FunctionQuantity is a &%PhysicalQuantity that is returned by a &%Function that maps from one or more instances of &%ConstantQuantity to another instance of &%ConstantQuantity. For example, the velocity of a particle would be represented by a &%FunctionQuantity relating values of time (which are instances of &%ConstantQuantity) to values of distance").
:- assert_kif("(also instances of &%ConstantQuantity). Note that all elements of the range of the &%Function corresponding to a &%FunctionQuantity have the same physical dimension as the &%FunctionQuantity itself.\")").
:- assert_kif("(subclass UnaryConstantFunctionQuantity FunctionQuantity)").
:- assert_kif("(documentation UnaryConstantFunctionQuantity EnglishLanguage \"A &%subclass of &%FunctionQuantity, instances of which are returned by &%UnaryFunctions that map from one instance of the &%Class &%ConstantQuantity to another instance of the &%Class &%ConstantQuantity.\")").
:- assert_kif("(subclass TimeDependentQuantity UnaryConstantFunctionQuantity)").
:- assert_kif("(documentation TimeDependentQuantity EnglishLanguage \"A &%UnaryConstantFunctionQuantity of continuous time. All instances of this &%Class are returned by &%Functions that map a time quantity into another &%ConstantQuantity such as temperature. For example, 'the temperature at the top of the Empire State Building' is a &%TimeDependentQuantity, since its value depends on the time.\")").
:- assert_kif("(subclass SetOrClass Abstract)").
:- assert_kif("(partition SetOrClass Set Class)").
:- assert_kif("(documentation SetOrClass EnglishLanguage \"The &%SetOrClass of &%Sets and &%Classes, i.e. any instance of &%Abstract that has &%elements or &%instances.\")").
:- assert_kif("(subclass Class SetOrClass)").
:- assert_kif("(documentation Class EnglishLanguage \"&%Classes differ from &%Sets in three important respects. First, &%Classes are not assumed to be extensional. That is, distinct &%Classes might well have exactly the same instances. Second, &%Classes typically have an associated `condition' that determines the instances of the &%Class. So, for example, the condition `human' determines the &%Class of &%Humans. Note that some &%Classes might satisfy their own condition (e.g., the &%Class of &%Abstract things is &%Abstract) and hence be instances of themselves. Third, the instances of a class may occur only once within the class, i.e. a class cannot contain duplicate instances.\")").
:- assert_kif("(subclass Set SetOrClass)").
:- assert_kif("(documentation Set EnglishLanguage \"A &%SetOrClass that satisfies extensionality as well as other constraints specified by some choice of set theory. &%Sets differ from &%Classes in two important respects. First, &%Sets are extensional - two &%Sets with the same &%elements are identical. Second, a &%Set can be an arbitrary stock of objects. That is, there is no requirement that &%Sets have an associated condition that determines their membership. Note that &%Sets are not assumed to be unique sets, i.e. &%elements of a &%Set may occur more than once in the &%Set.\")").
:- assert_kif("(subclass Relation Abstract)").
:- assert_kif("(disjointDecomposition Relation BinaryRelation TernaryRelation QuaternaryRelation QuintaryRelation VariableArityRelation)").
:- assert_kif("(partition Relation Predicate Function List)").
:- assert_kif("(partition Relation TotalValuedRelation PartialValuedRelation)").
:- assert_kif("(documentation Relation EnglishLanguage \"The &%Class of relations. There are three kinds of &%Relation: &%Predicate, &%Function, and &%List. &%Predicates and &%Functions both denote sets of ordered n-tuples. The difference between these two &%Classes is that &%Predicates cover formula-forming operators, while &%Functions cover term-forming operators. A &%List, on the other hand, is a particular ordered n-tuple.\")").
% :- assert_kif("; The following part of the ontology covers the various classes under 'Relation'. Most of the content here is taken from frame-ontology, abstract-algebra, kif-relations, and kif-extensions (ontologies available on the Ontolingua server).").
:- assert_kif("(subclass SingleValuedRelation Relation)").
:- assert_kif("(subclass SingleValuedRelation InheritableRelation)").
:- assert_kif("(documentation SingleValuedRelation EnglishLanguage \"A &%Relation is a &%SingleValuedRelation just in case an assignment of values to every argument position except the last one determines at most one assignment for the last argument position. Note that not all &%SingleValuedRelations are &%TotalValuedRelations.\")").
:- assert_kif("(=> (instance ?REL SingleValuedRelation) (forall (@ROW ?ITEM1 ?ITEM2) (=> (and (?REL @ROW ?ITEM1) (?REL @ROW ?ITEM2)) (equal ?ITEM1 ?ITEM2))))").
:- assert_kif("(subclass TotalValuedRelation Relation)").
:- assert_kif("(subclass TotalValuedRelation InheritableRelation)").
:- assert_kif("(documentation TotalValuedRelation EnglishLanguage \"A &%Relation is a &%TotalValuedRelation just in case there exists an assignment for the last argument position of the &%Relation given any assignment of values to every argument position except the last one. Note that declaring a &%Relation to be both a &%TotalValuedRelation and a &%SingleValuedRelation means that it is a total function.\")").
:- assert_kif("(<=> (and (instance ?REL TotalValuedRelation) (instance ?REL Predicate)) (exists (?VALENCE) (and (instance ?REL Relation) (valence ?REL ?VALENCE) (=> (forall (?NUMBER ?ELEMENT ?CLASS) (=> (and (lessThan ?NUMBER ?VALENCE) (domain ?REL ?NUMBER ?CLASS) (equal ?ELEMENT (ListOrderFn (ListFn @ROW) ?NUMBER))) (instance ?ELEMENT ?CLASS))) (exists (?ITEM) (?REL @ROW ?ITEM))))))").
:- assert_kif("(subclass PartialValuedRelation Relation)").
:- assert_kif("(documentation PartialValuedRelation EnglishLanguage \"A &%Relation is a &%PartialValuedRelation just in case it is not a &%TotalValuedRelation, i.e. just in case assigning values to every argument position except the last one does not necessarily mean that there is a value assignment for the last argument position. Note that, if a &%Relation is both a &%PartialValuedRelation and a &%SingleValuedRelation, then it is a partial function.\")").
:- assert_kif("(subclass BinaryRelation Relation)").
:- assert_kif("(subclass BinaryRelation InheritableRelation)").
:- assert_kif("(documentation BinaryRelation EnglishLanguage \"&%BinaryRelations are relations that are true only of pairs of things. &%BinaryRelations are represented as slots in frame systems.\")").
:- assert_kif("(subclass ReflexiveRelation BinaryRelation)").
:- assert_kif("(documentation ReflexiveRelation EnglishLanguage \"&%Relation ?REL is reflexive iff").
:- assert_kif("(?REL ?INST ?INST) for all ?INST.\")").
:- assert_kif("(<=> (instance ?REL ReflexiveRelation) (?REL ?INST ?INST))").
:- assert_kif("(subclass IrreflexiveRelation BinaryRelation)").
:- assert_kif("(documentation IrreflexiveRelation EnglishLanguage \"&%Relation ?REL is irreflexive iff (?REL ?INST ?INST) holds for no value of ?INST.\")").
:- assert_kif("(<=> (instance ?REL IrreflexiveRelation) (forall (?INST) (not (?REL ?INST ?INST))))").
:- assert_kif("(subclass SymmetricRelation BinaryRelation)").
:- assert_kif("(documentation SymmetricRelation EnglishLanguage \"A &%BinaryRelation ?REL is symmetric just iff (?REL ?INST1 ?INST2) imples (?REL ?INST2 ?INST1), for all ?INST1 and ?INST2.\")").
:- assert_kif("(<=> (instance ?REL SymmetricRelation) (forall (?INST1 ?INST2) (=> (?REL ?INST1 ?INST2) (?REL ?INST2 ?INST1))))").
:- assert_kif("(subclass AsymmetricRelation IrreflexiveRelation)").
:- assert_kif("(subclass AsymmetricRelation AntisymmetricRelation)").
:- assert_kif("(documentation AsymmetricRelation EnglishLanguage \"A &%BinaryRelation is asymmetric if and only if it is both an &%AntisymmetricRelation and an &%IrreflexiveRelation.\")").
:- assert_kif("(<=> (instance ?REL AsymmetricRelation) (and (instance ?REL AntisymmetricRelation) (instance ?REL IrreflexiveRelation)))").
:- assert_kif("(subclass AntisymmetricRelation BinaryRelation)").
:- assert_kif("(documentation AntisymmetricRelation EnglishLanguage \"&%BinaryRelation ?REL is an &%AntisymmetricRelation if for distinct ?INST1 and ?INST2, (?REL ?INST1 ?INST2) implies not (?REL ?INST2 ?INST1). In other words, for all ?INST1 and ?INST2, (?REL ?INST1 ?INST2) and (?REL ?INST2 ?INST1) imply that ?INST1 and ?INST2 are identical. Note that it is possible for an &%AntisymmetricRelation to be a &%ReflexiveRelation.\")").
:- assert_kif("(<=> (instance ?REL AntisymmetricRelation) (forall (?INST1 ?INST2) (=> (and (?REL ?INST1 ?INST2) (?REL ?INST2 ?INST1)) (equal ?INST1 ?INST2))))").
:- assert_kif("(subclass TrichotomizingRelation BinaryRelation)").
:- assert_kif("(documentation TrichotomizingRelation EnglishLanguage \"A &%BinaryRelation ?REL is a &%TrichotomizingRelation just in case all ordered pairs consisting of distinct individuals are elements of ?REL.\")").
:- assert_kif("(<=> (instance ?REL TrichotomizingRelation) (forall (?INST1 ?INST2) (or (and (?REL ?INST1 ?INST2) (not (equal ?INST1 ?INST2)) (not (?REL ?INST2 ?INST1))) (and (not (?REL ?INST1 ?INST2)) (equal ?INST1 ?INST2) (not (?REL ?INST2 ?INST1))) (and (not (?REL ?INST1 ?INST2)) (not (equal ?INST1 ?INST2)) (?REL ?INST2 ?INST1)))))").
:- assert_kif("(subclass TransitiveRelation BinaryRelation)").
:- assert_kif("(documentation TransitiveRelation EnglishLanguage \"A &%BinaryRelation ?REL is transitive if (?REL ?INST1 ?INST2) and (?REL ?INST2 ?INST3) imply (?REL ?INST1 ?INST3), for all ?INST1, ?INST2, and ?INST3.\")").
:- assert_kif("(<=> (instance ?REL TransitiveRelation) (forall (?INST1 ?INST2 ?INST3) (=> (and (?REL ?INST1 ?INST2) (?REL ?INST2 ?INST3)) (?REL ?INST1 ?INST3))))").
:- assert_kif("(subclass IntransitiveRelation BinaryRelation)").
:- assert_kif("(documentation IntransitiveRelation EnglishLanguage \"A &%BinaryRelation ?REL is intransitive only if (?REL ?INST1 ?INST2) and (?REL ?INST2 ?INST3) imply not").
:- assert_kif("(?REL ?INST1 ?INST3), for all ?INST1, ?INST2, and ?INST3.\")").
:- assert_kif("(<=> (instance ?REL IntransitiveRelation) (forall (?INST1 ?INST2 ?INST3) (=> (and (?REL ?INST1 ?INST2) (?REL ?INST2 ?INST3)) (not (?REL ?INST1 ?INST3)))))").
:- assert_kif("(subclass PartialOrderingRelation TransitiveRelation)").
:- assert_kif("(subclass PartialOrderingRelation AntisymmetricRelation)").
:- assert_kif("(subclass PartialOrderingRelation ReflexiveRelation)").
:- assert_kif("(documentation PartialOrderingRelation EnglishLanguage \"A &%BinaryRelation is a partial ordering if it is a &%ReflexiveRelation, an &%AntisymmetricRelation, and a &%TransitiveRelation.\")").
:- assert_kif("(subclass TotalOrderingRelation PartialOrderingRelation)").
:- assert_kif("(subclass TotalOrderingRelation TrichotomizingRelation)").
:- assert_kif("(documentation TotalOrderingRelation EnglishLanguage \"A &%BinaryRelation is a &%TotalOrderingRelation if it is a &%PartialOrderingRelation and a &%TrichotomizingRelation.\")").
:- assert_kif("(<=> (instance ?REL TotalOrderingRelation) (forall (?INST1 ?INST2) (and (or (?REL ?INST1 ?INST2) (?REL ?INST2 ?INST1)) (or (not (?REL ?INST1 ?INST2)) (not (?REL ?INST2 ?INST1))))))").
:- assert_kif("(subclass EquivalenceRelation TransitiveRelation)").
:- assert_kif("(subclass EquivalenceRelation SymmetricRelation)").
:- assert_kif("(subclass EquivalenceRelation ReflexiveRelation)").
:- assert_kif("(documentation EquivalenceRelation EnglishLanguage \"A &%BinaryRelation is an equivalence relation if it is a &%ReflexiveRelation, a &%SymmetricRelation, and a &%TransitiveRelation.\")").
:- assert_kif("(subclass CaseRole BinaryPredicate)").
:- assert_kif("(subclass CaseRole InheritableRelation)").
:- assert_kif("(subclass CaseRole AsymmetricRelation)").
:- assert_kif("(documentation CaseRole EnglishLanguage \"The &%Class of &%Predicates relating the spatially distinguished parts of a &%Process. &%CaseRoles include, for example, the &%agent, &%patient or &%destination of an action, the flammable substance in a burning process, or the water that falls in rain.\")").
:- assert_kif("(documentation involvedInEvent EnglishLanguage \"(involvedInEvent ?EVENT ?THING) means that in the &%Process ?EVENT, the &%Entity ?THING plays some &%CaseRole.\")").
:- assert_kif("(instance involvedInEvent BinaryPredicate)").
:- assert_kif("(instance involvedInEvent AsymmetricRelation)").
:- assert_kif("(domain involvedInEvent 1 Process)").
:- assert_kif("(domain involvedInEvent 2 Entity)").
% :- assert_kif("; AP - this axiom below seems questionable, what about relations we just haven't \"discovered\" yet. ").
% :- assert_kif("(=> (involvedInEvent ?E ?T) (exists (?R) (and (instance ?R CaseRole) (subrelation ?R involvedInEvent) (?R ?E ?T))))").
:- assert_kif("(=> (instance ?R CaseRole) (subrelation ?R involvedInEvent))").
:- assert_kif("(instance agent CaseRole)").
:- assert_kif("(domain agent 1 Process)").
:- assert_kif("(domain agent 2 Agent)").
:- assert_kif("(subrelation agent involvedInEvent)").
:- assert_kif("(documentation agent EnglishLanguage \"(&%agent ?PROCESS ?AGENT) means that ?AGENT is an active determinant, either animate or inanimate, of the &%Process ?PROCESS, with or without voluntary intention. For example, Eve is an &%agent in the following proposition: Eve bit an apple.\")").
:- assert_kif("(instance destination CaseRole)").
:- assert_kif("(domain destination 1 Process)").
:- assert_kif("(domain destination 2 Entity)").
:- assert_kif("(subrelation destination involvedInEvent)").
:- assert_kif("(documentation destination EnglishLanguage \"(destination ?PROCESS ?GOAL) means that ?GOAL is the target or goal of the Process ?PROCESS. For example, Danbury would be the destination in the following proposition: Bob went to Danbury. Note that this is a very general &%CaseRole and, in particular, that it covers the concepts of 'recipient' and 'beneficiary'. Thus, John would be the &%destination in the following proposition: Tom gave a book to John.\")").
:- assert_kif("(instance experiencer CaseRole)").
:- assert_kif("(domain experiencer 1 Process)").
:- assert_kif("(domain experiencer 2 Agent)").
:- assert_kif("(subrelation experiencer involvedInEvent)").
:- assert_kif("(documentation experiencer EnglishLanguage \"(&%experiencer ?PROCESS ?AGENT) means that ?AGENT experiences the &%Process ?PROCESS. For example, Yojo is the &%experiencer of seeing in the following proposition: Yojo sees the fish. Note that &%experiencer, unlike &%agent, does not entail a causal relation between its arguments.\")").
:- assert_kif("(subrelation instrument patient)").
:- assert_kif("(domain instrument 1 Process)").
:- assert_kif("(domain instrument 2 Object)").
:- assert_kif("(documentation instrument EnglishLanguage \"(instrument ?EVENT ?TOOL) means that ?TOOL is used by an agent in bringing about ?EVENT and that ?TOOL is not changed by ?EVENT. For example, the key is an &%instrument in the following proposition: The key opened the door. Note that &%instrument and &%resource cannot be satisfied by the same ordered pair.\")").
:- assert_kif("(instance origin CaseRole)").
:- assert_kif("(domain origin 1 Process)").
:- assert_kif("(domain origin 2 Object)").
:- assert_kif("(subrelation origin involvedInEvent)").
:- assert_kif("(documentation origin EnglishLanguage \"(&%origin ?PROCESS ?SOURCE) means that ?SOURCE indicates where the ?Process began. Note that this relation implies that ?SOURCE is present at the beginning of the process, but need not participate throughout the process. For example, the submarine is the &%origin in the following proposition: the missile was launched from a submarine.\")").
:- assert_kif("(instance patient CaseRole)").
:- assert_kif("(domain patient 1 Process)").
:- assert_kif("(domain patient 2 Entity)").
:- assert_kif("(subrelation patient involvedInEvent)").
:- assert_kif("(documentation patient EnglishLanguage \"(&%patient ?PROCESS ?ENTITY) means that ?ENTITY is a participant in ?PROCESS that may be moved, said, experienced, etc. For example, the direct objects in the sentences 'The cat swallowed the canary' and 'Billy likes the beer' would be examples of &%patients. Note that the &%patient of a &%Process may or may not undergo structural change as a result of the &%Process. The &%CaseRole of &%patient is used when one wants to specify as broadly as possible the object of a &%Process.\")").
:- assert_kif("(subrelation resource patient)").
:- assert_kif("(domain resource 1 Process)").
:- assert_kif("(domain resource 2 Object)").
:- assert_kif("(disjointRelation resource result)").
:- assert_kif("(disjointRelation resource instrument)").
:- assert_kif("(disjointRelation result instrument)").
:- assert_kif("(documentation resource EnglishLanguage \"(&%resource ?PROCESS ?RESOURCE) means that ?RESOURCE is present at the beginning of ?PROCESS, is used by ?PROCESS, and as a consequence is changed by ?PROCESS. For example, soap is a &%resource in the following proposition: the gun was carved out of soap. Note that &%resource differs from &%instrument, another subrelation of &%patient, in that its internal or physical properties are altered in some way by the &%Process.\")").
:- assert_kif("(subrelation result patient)").
:- assert_kif("(domain result 1 Process)").
:- assert_kif("(domain result 2 Entity)").
:- assert_kif("(documentation result EnglishLanguage \"(result ?ACTION ?OUTPUT) means that ?OUTPUT is a product of ?ACTION. For example, house is a &%result in the following proposition: Eric built a house.\")").
:- assert_kif("(subclass InheritableRelation Relation)").
:- assert_kif("(documentation InheritableRelation EnglishLanguage \"The class of &%Relations whose properties can be inherited downward in the class hierarchy via the &%subrelation &%Predicate.\")").
:- assert_kif("(subclass ProbabilityRelation Relation)").
:- assert_kif("(subclass ProbabilityRelation InheritableRelation)").
:- assert_kif("(documentation ProbabilityRelation EnglishLanguage \"The &%Class of &%Relations that permit assessment of the probability of an event or situation.\")").
:- assert_kif("(instance ProbabilityFn ProbabilityRelation)").
:- assert_kif("(instance ProbabilityFn TotalValuedRelation)").
:- assert_kif("(instance ProbabilityFn UnaryFunction)").
:- assert_kif("(domain ProbabilityFn 1 Formula)").
:- assert_kif("(range ProbabilityFn RealNumber)").
:- assert_kif("(instance ProbabilityFn AsymmetricRelation)").
:- assert_kif("(documentation ProbabilityFn EnglishLanguage \"One of the basic &%ProbabilityRelations, &%ProbabilityFn is used to state the a priori probability of a state of affairs. (&%ProbabilityFn ?FORMULA) denotes the a priori probability of ?FORMULA.\")").
:- assert_kif("(instance conditionalProbability ProbabilityRelation)").
:- assert_kif("(instance conditionalProbability TernaryPredicate)").
:- assert_kif("(domain conditionalProbability 1 Formula)").
:- assert_kif("(domain conditionalProbability 2 Formula)").
:- assert_kif("(domain conditionalProbability 3 RealNumber)").
:- assert_kif("(documentation conditionalProbability EnglishLanguage \"One of the basic &%ProbabilityRelations. &%conditionalProbability is used to state the numeric value of a conditional probability. (&%conditionalProbability ?FORMULA1 ?FORMULA2 ?NUMBER) means that the probability of ?FORMULA2 being true given that ?FORMULA1 is true is ?NUMBER.\")").
:- assert_kif("(instance increasesLikelihood ProbabilityRelation)").
:- assert_kif("(instance increasesLikelihood BinaryPredicate)").
:- assert_kif("(instance increasesLikelihood IrreflexiveRelation)").
:- assert_kif("(domain increasesLikelihood 1 Formula)").
:- assert_kif("(domain increasesLikelihood 2 Formula)").
:- assert_kif("(disjointRelation increasesLikelihood decreasesLikelihood)").
:- assert_kif("(disjointRelation increasesLikelihood independentProbability)").
:- assert_kif("(disjointRelation decreasesLikelihood independentProbability)").
:- assert_kif("(documentation increasesLikelihood EnglishLanguage \"One of the basic &%ProbabilityRelations.  (&%increasesLikelihood ?FORMULA1 ?FORMULA2) means that ?FORMULA2 is more likely to be true if ?FORMULA1 is true.\")").
:- assert_kif("(=> (and (increasesLikelihood ?FORMULA1 ?FORMULA2) (equal (ProbabilityFn ?FORMULA2) ?NUMBER1) (conditionalProbability ?FORMULA1 ?FORMULA2 ?NUMBER2)) (greaterThan ?NUMBER2 ?NUMBER1))").
:- assert_kif("(instance decreasesLikelihood ProbabilityRelation)").
:- assert_kif("(instance decreasesLikelihood BinaryPredicate)").
:- assert_kif("(instance decreasesLikelihood IrreflexiveRelation)").
:- assert_kif("(domain decreasesLikelihood 1 Formula)").
:- assert_kif("(domain decreasesLikelihood 2 Formula)").
:- assert_kif("(documentation decreasesLikelihood EnglishLanguage \"One of the basic &%ProbabilityRelations.  (&%decreasesLikelihood ?FORMULA1 ?FORMULA2) means that ?FORMULA2 is less likely to be true if ?FORMULA1 is true.\")").
:- assert_kif("(=> (and (decreasesLikelihood ?FORMULA1 ?FORMULA2) (equal (ProbabilityFn ?FORMULA2) ?NUMBER1) (conditionalProbability ?FORMULA1 ?FORMULA2 ?NUMBER2)) (lessThan ?NUMBER2 ?NUMBER1))").
:- assert_kif("(instance independentProbability ProbabilityRelation)").
:- assert_kif("(instance independentProbability BinaryPredicate)").
:- assert_kif("(instance independentProbability SymmetricRelation)").
:- assert_kif("(domain independentProbability 1 Formula)").
:- assert_kif("(domain independentProbability 2 Formula)").
:- assert_kif("(documentation independentProbability EnglishLanguage \"One of the basic &%ProbabilityRelations.  (&%independentProbability ?FORMULA1 ?FORMULA2) means that the probabilities of ?FORMULA1 and ?FORMULA2 being true are independent.\")").
:- assert_kif("(=> (and (independentProbability ?FORMULA1 ?FORMULA2) (equal (ProbabilityFn ?FORMULA2) ?NUMBER1) (conditionalProbability ?FORMULA1 ?FORMULA2 ?NUMBER2)) (equal ?NUMBER2 ?NUMBER1))").
:- assert_kif("(=> (and (instance ?FORMULA1 Formula) (instance ?FORMULA2 Formula)) (or (increasesLikelihood ?FORMULA1 ?FORMULA2) (decreasesLikelihood ?FORMULA1 ?FORMULA2) (independentProbability ?FORMULA1 ?FORMULA2)))").
:- assert_kif("(subclass SpatialRelation Relation)").
:- assert_kif("(subclass SpatialRelation InheritableRelation)").
:- assert_kif("(documentation SpatialRelation EnglishLanguage \"The &%Class of &%Relations that are spatial in a wide sense. This &%Class includes mereological relations and topological relations.\")").
:- assert_kif("(subclass TemporalRelation Relation)").
:- assert_kif("(subclass TemporalRelation InheritableRelation)").
:- assert_kif("(documentation TemporalRelation EnglishLanguage \"The &%Class of temporal &%Relations. This &%Class includes notions of (temporal) topology of intervals,").
:- assert_kif("(temporal) schemata, and (temporal) extension.\")").
:- assert_kif("(subclass IntentionalRelation InheritableRelation)").
:- assert_kif("(subclass IntentionalRelation Relation)").
:- assert_kif("(documentation IntentionalRelation EnglishLanguage \"The &%Class of &%Relations between an &%Agent and one or more &%Entities, where the &%Relation requires that the &%Agent have awareness of the &%Entity.\")").
:- assert_kif("(=> (and (instance ?REL IntentionalRelation) (?REL ?AGENT @ROW) (inList ?OBJ (ListFn @ROW))) (inScopeOfInterest ?AGENT ?OBJ))").
:- assert_kif("(instance prefers TernaryPredicate)").
:- assert_kif("(instance prefers IntentionalRelation)").
:- assert_kif("(domain prefers 1 CognitiveAgent)").
:- assert_kif("(domain prefers 2 Formula)").
:- assert_kif("(domain prefers 3 Formula)").
:- assert_kif("(documentation prefers EnglishLanguage \"(&%prefers ?AGENT ?FORMULA1 ?FORMULA2) means that &%CognitiveAgent ?AGENT prefers the state of affairs expressed by ?FORMULA1 over the state of affairs expressed by ?FORMULA2 all things being equal.\")").
:- assert_kif("(subclass PropositionalAttitude IntentionalRelation)").
:- assert_kif("(subclass PropositionalAttitude AsymmetricRelation)").
:- assert_kif("(subclass PropositionalAttitude InheritableRelation)").
:- assert_kif("(documentation PropositionalAttitude EnglishLanguage \"The &%Class of &%IntentionalRelations where the &%Agent has awareness of a &%Proposition.\")").
:- assert_kif("(=> (and (instance ?REL PropositionalAttitude) (?REL ?AGENT ?FORMULA)) (instance ?FORMULA Formula))").
:- assert_kif("(subclass ObjectAttitude IntentionalRelation)").
:- assert_kif("(subclass ObjectAttitude InheritableRelation)").
:- assert_kif("(disjoint ObjectAttitude PropositionalAttitude)").
:- assert_kif("(documentation ObjectAttitude EnglishLanguage \"The &%Class of &%IntentionalRelations where the &%Agent has awareness of an instance of &%Physical.\")").
:- assert_kif("(=> (and (instance ?REL ObjectAttitude) (?REL ?AGENT ?THING)) (instance ?THING Physical))").
:- assert_kif("(instance inScopeOfInterest BinaryPredicate)").
:- assert_kif("(instance inScopeOfInterest IntentionalRelation)").
:- assert_kif("(domain inScopeOfInterest 1 CognitiveAgent)").
:- assert_kif("(domain inScopeOfInterest 2 Entity)").
:- assert_kif("(documentation inScopeOfInterest EnglishLanguage \"A very general &%Predicate.  (&%inScopeOfInterest ?AGENT ?ENTITY) means that ?ENTITY is within the scope of interest of ?AGENT. Note that the interest indicated can be either positive or negative, i.e. the ?AGENT can have an interest in avoiding or promoting ?ENTITY.\")").
:- assert_kif("(<=> (exists (?PROCESS) (and (instance ?PROCESS IntentionalProcess) (agent ?PROCESS ?AGENT) (patient ?PROCESS ?OBJECT))) (inScopeOfInterest ?AGENT ?OBJECT))").
:- assert_kif("(instance needs ObjectAttitude)").
:- assert_kif("(instance needs BinaryPredicate)").
:- assert_kif("(subrelation needs inScopeOfInterest)").
:- assert_kif("(domain needs 1 CognitiveAgent)").
:- assert_kif("(domain needs 2 Physical)").
:- assert_kif("(documentation needs EnglishLanguage \"(&%needs ?AGENT ?OBJECT) means that ?OBJECT is physically required for the continued existence of ?AGENT.\")").
:- assert_kif("(=> (needs ?AGENT ?OBJECT) (wants ?AGENT ?OBJECT))").
:- assert_kif("(instance wants ObjectAttitude)").
:- assert_kif("(instance wants BinaryPredicate)").
:- assert_kif("(subrelation wants inScopeOfInterest)").
:- assert_kif("(relatedInternalConcept wants desires)").
:- assert_kif("(domain wants 1 CognitiveAgent)").
:- assert_kif("(domain wants 2 Physical)").
:- assert_kif("(documentation wants EnglishLanguage \"(&%wants ?AGENT ?OBJECT) means that ?OBJECT is desired by ?AGENT, i.e. ?AGENT believes that ?OBJECT will satisfy one of its goals. Note that there is no implication that what is wanted by an agent is not already possessed by the agent.\")").
:- assert_kif("(=> (wants ?AGENT ?OBJ) (exists (?PURP) (hasPurposeForAgent ?OBJ ?PURP ?AGENT)))").
:- assert_kif("(=> (and (wants ?AGENT ?OBJ) (instance ?OBJ Object)) (desires ?AGENT (possesses ?AGENT ?OBJ)))").
:- assert_kif("(instance desires PropositionalAttitude)").
:- assert_kif("(instance desires BinaryPredicate)").
:- assert_kif("(subrelation desires inScopeOfInterest)").
:- assert_kif("(relatedInternalConcept desires wants)").
:- assert_kif("(domain desires 1 CognitiveAgent)").
:- assert_kif("(domain desires 2 Formula)").
:- assert_kif("(documentation desires EnglishLanguage \"(&%desires ?AGENT ?FORMULA) means that ?AGENT wants to bring about the state of affairs expressed by ?FORMULA. Note that there is no implication that what is desired by the agent is not already true. Note too that &%desires is distinguished from &%wants only in that the former is a &%PropositionalAttitude, while &%wants is an &%ObjectAttitude.\")").
:- assert_kif("(instance considers PropositionalAttitude)").
:- assert_kif("(instance considers BinaryPredicate)").
:- assert_kif("(subrelation considers inScopeOfInterest)").
:- assert_kif("(domain considers 1 CognitiveAgent)").
:- assert_kif("(domain considers 2 Formula)").
:- assert_kif("(documentation considers EnglishLanguage \"(&%considers ?AGENT ?FORMULA) means that ?AGENT considers or wonders about the truth of the proposition expressed by ?FORMULA.\")").
:- assert_kif("(instance believes PropositionalAttitude)").
:- assert_kif("(instance believes BinaryPredicate)").
:- assert_kif("(subrelation believes inScopeOfInterest)").
:- assert_kif("(domain believes 1 CognitiveAgent)").
:- assert_kif("(domain believes 2 Formula)").
:- assert_kif("(documentation believes EnglishLanguage \"The epistemic predicate of belief.  (&%believes ?AGENT ?FORMULA) means that ?AGENT believes the proposition expressed by ?FORMULA.\")").
:- assert_kif("(=> (believes ?AGENT ?FORMULA) (exists (?TIME) (holdsDuring ?TIME (considers ?AGENT ?FORMULA))))").
:- assert_kif("(instance knows PropositionalAttitude)").
:- assert_kif("(instance knows BinaryPredicate)").
:- assert_kif("(subrelation knows inScopeOfInterest)").
:- assert_kif("(domain knows 1 CognitiveAgent)").
:- assert_kif("(domain knows 2 Formula)").
:- assert_kif("(documentation knows EnglishLanguage \"The epistemic predicate of knowing. (&%knows ?AGENT ?FORMULA) means that ?AGENT knows the proposition expressed by ?FORMULA. Note that &%knows entails conscious awareness, so this &%Predicate cannot be used to express tacit or subconscious or unconscious knowledge.\")").
:- assert_kif("(=> (knows ?AGENT ?FORMULA) (believes ?AGENT ?FORMULA))").
:- assert_kif("(=> (knows ?AGENT ?FORMULA) (truth ?FORMULA True))").
:- assert_kif("(subclass TernaryRelation Relation)").
:- assert_kif("(subclass TernaryRelation InheritableRelation)").
:- assert_kif("(documentation TernaryRelation EnglishLanguage \"&%TernaryRelations relate three items. The two &%subclasses of &%TernaryRelation are &%TernaryPredicate and &%BinaryFunction.\")").
:- assert_kif("(subclass QuaternaryRelation Relation)").
:- assert_kif("(subclass QuaternaryRelation InheritableRelation)").
:- assert_kif("(documentation QuaternaryRelation EnglishLanguage \"&%QuaternaryRelations relate four items. The two &%subclasses of &%QuaternaryRelation are &%QuaternaryPredicate and &%TernaryFunction.\")").
:- assert_kif("(subclass QuintaryRelation Relation)").
:- assert_kif("(subclass QuintaryRelation InheritableRelation)").
:- assert_kif("(documentation QuintaryRelation EnglishLanguage \"&%QuintaryRelations relate five items. The two &%subclasses of &%QuintaryRelation are &%QuintaryPredicate and &%QuaternaryFunction.\")").
:- assert_kif("(subclass List Relation)").
:- assert_kif("(documentation List EnglishLanguage \"Every &%List is a particular ordered n-tuple of items. Generally speaking, &%Lists are created by means of the &%ListFn &%Function, which takes any number of items as arguments and returns a &%List with the items in the same order. Anything, including other &%Lists, may be an item in a &%List. Note too that &%Lists are extensional - two lists that have the same items in the same order are identical. Note too that a &%List may contain no items. In that case, the &%List is the &%NullList.\")").
:- assert_kif(" (=> (and (instance ?LIST List) (not (instance ?LIST NullList))) (exists (?NUMBER1 ?ITEM1) (and (not (equal (ListOrderFn ?LIST ?NUMBER1) ?ITEM1)) (forall (?NUMBER2) (=> (and (instance ?NUMBER2 PositiveInteger) (lessThan ?NUMBER2 ?NUMBER1)) (exists (?ITEM2) (equal (ListOrderFn ?LIST ?NUMBER2) ?ITEM2)))))))").
:- assert_kif("(subclass UniqueList List)").
:- assert_kif("(documentation UniqueList EnglishLanguage \"A &%List in which no item appears more than once, i.e. a &%List for which there are no distinct numbers ?NUMBER1 and ?NUMBER2 such that (&%ListOrderFn ?LIST ?NUMBER1) and (&%ListOrderFn ?LIST ?NUMBER2) return the same value.\")").
:- assert_kif("(=> (instance ?LIST UniqueList) (forall (?NUMBER1 ?NUMBER2) (=> (equal (ListOrderFn ?LIST ?NUMBER1) (ListOrderFn ?LIST ?NUMBER2)) (equal ?NUMBER1 ?NUMBER2))))").
:- assert_kif("(instance NullList List)").
:- assert_kif("(documentation NullList EnglishLanguage \"The &%List that has no items. The uniqueness of &%NullList follows from the extensionality of &%Lists, i.e. the fact that two &%Lists with the same items in the same order are identical.\")").
:- assert_kif(" (<=> (equal ?LIST NullList) (and (instance ?LIST List) (not (exists (?ITEM) (inList ?ITEM ?LIST)))))").
:- assert_kif("(instance ListFn Function)").
:- assert_kif("(instance ListFn VariableArityRelation) (instance ListFn TotalValuedRelation) - appears to be a contradiction with VariableArityRelation").
:- assert_kif("(range ListFn List)").
:- assert_kif("(documentation ListFn EnglishLanguage \"A &%Function that takes any number of arguments and returns the &%List containing those arguments in exactly the same order.\")").
:- assert_kif("(=> (exhaustiveDecomposition ?CLASS @ROW) (forall (?OBJ) (=> (instance ?OBJ ?CLASS) (exists (?ITEM) (and (inList ?ITEM (ListFn @ROW)) (instance ?OBJ ?ITEM))))))").
:- assert_kif("(=> (disjointDecomposition ?CLASS @ROW) (forall (?ITEM) (=> (inList ?ITEM (ListFn @ROW)) (subclass ?ITEM ?CLASS))))").
:- assert_kif("(=> (disjointDecomposition ?CLASS @ROW) (forall (?ITEM1 ?ITEM2) (=> (and (inList ?ITEM1 (ListFn @ROW)) (inList ?ITEM2 (ListFn @ROW)) (not (equal ?ITEM1 ?ITEM2))) (disjoint ?ITEM1 ?ITEM2))))").
:- assert_kif("(<=> (disjointDecomposition ?CLASS ?ROW1 ?ROW2 ?ROW3) (and (disjoint ?ROW1 ?ROW2) (disjoint ?ROW2 ?ROW3) (disjoint ?ROW3 ?ROW1)))").
:- assert_kif("(instance ListOrderFn BinaryFunction)").
:- assert_kif("(instance ListOrderFn PartialValuedRelation)").
:- assert_kif("(domain ListOrderFn 1 List)").
:- assert_kif("(domain ListOrderFn 2 PositiveInteger)").
:- assert_kif("(range ListOrderFn Entity)").
:- assert_kif("(documentation ListOrderFn EnglishLanguage \"(&%ListOrderFn ?LIST ?NUMBER) denotes the item that is in the ?NUMBER position in the &%List ?LIST. For example,"). (&%ListOrderFn (&%ListFn &%Monday &%Tuesday &%Wednesday) 2) would return the value &%Tuesday.\")").
:- assert_kif(" (=> (and (instance ?LIST1 List) (not (equal ?LIST1 NullList)) (not (equal ?LIST2 NullList)) (instance ?LIST2 List) (forall (?NUMBER) (equal (ListOrderFn ?LIST1 ?NUMBER) (ListOrderFn ?LIST2 ?NUMBER)))) (equal ?LIST1 ?LIST2))").
:- assert_kif("(=> (and (domain ?REL ?NUMBER ?CLASS) (instance ?REL Predicate) (?REL @ROW)) (instance (ListOrderFn (ListFn @ROW) ?NUMBER) ?CLASS))").
:- assert_kif("(=> (and (domainSubclass ?REL ?NUMBER ?CLASS) (instance ?REL Predicate) (?REL @ROW)) (subclass (ListOrderFn (ListFn @ROW) ?NUMBER) ?CLASS))").
:- assert_kif("(instance ListLengthFn UnaryFunction)").
:- assert_kif("(instance ListLengthFn TotalValuedRelation)").
:- assert_kif("(domain ListLengthFn 1 List)").
:- assert_kif("(range ListLengthFn NonnegativeInteger)").
:- assert_kif("(documentation ListLengthFn EnglishLanguage \"A &%Function that takes a &%List as its sole argument and returns the number of items in the &%List. For example,"). (&%ListLengthFn (&%ListFn &%Monday &%Tuesday &%Wednesday)) would return the value 3.\")").
:- assert_kif(" (=> (and (equal (ListLengthFn ?LIST) ?NUMBER1) (instance ?LIST List) (not (equal ?LIST NullList)) (instance ?NUMBER1 PositiveInteger)) (forall (?NUMBER2) (<=> (exists (?ITEM) (and (equal (ListOrderFn ?LIST ?NUMBER2) ?ITEM) (inList ?ITEM ?LIST))) (lessThanOrEqualTo ?NUMBER2 ?NUMBER1))))").
:- assert_kif("(forall (@ROW ?ITEM) (equal (ListLengthFn (ListFn @ROW ?ITEM)) (SuccessorFn (ListLengthFn (ListFn @ROW)))))").
:- assert_kif("(forall (@ROW ?ITEM) (equal (ListOrderFn (ListFn @ROW ?ITEM) (ListLengthFn (ListFn @ROW ?ITEM))) ?ITEM))").
:- assert_kif("(=> (and (valence ?REL ?NUMBER) (instance ?REL Predicate)) (forall (@ROW) (=> (?REL @ROW) (equal (ListLengthFn (ListFn @ROW)) ?NUMBER))))").
:- assert_kif(" (=> (and (equal (ListLengthFn ?LIST1) ?NUMBER) (instance ?LIST List) (not (equal ?LIST NullList)) (instance ?NUMBER1 PositiveInteger)) (exists (?LIST2 ?ITEM) (and (initialList ?LIST1 ?LIST2) (equal (SuccessorFn ?NUMBER) (ListLengthFn ?LIST2)) (equal (ListOrderFn ?LIST2 (SuccessorFn ?NUMBER)) ?ITEM))))").
:- assert_kif("(instance ListConcatenateFn BinaryFunction)").
:- assert_kif("(instance ListConcatenateFn TotalValuedRelation)").
:- assert_kif("(domain ListConcatenateFn 1 List)").
:- assert_kif("(domain ListConcatenateFn 2 List)").
:- assert_kif("(range ListConcatenateFn List)").
:- assert_kif("(documentation ListConcatenateFn EnglishLanguage \"A &%Function that returns the concatenation of the two &%Lists that are given as arguments. For example, the value of (&%ListConcatenateFn (&%ListFn &%Monday &%Tuesday) (&%ListFn &%Wednesday &%Thursday)) would be (&%ListFn &%Monday &%Tuesday &%Wednesday &%Thursday).\")").
% :- assert_kif("; removed to solve an obscure contradiction, but needs to be reexamined ").
% :- assert_kif(" (<=> (and (equal ?LIST3 (ListConcatenateFn ?LIST1 ?LIST2)) (not (equal ?LIST1 NullList)) (not (equal ?LIST2 NullList))) (forall (?NUMBER1 ?NUMBER2) (=> (and (lessThanOrEqualTo ?NUMBER1 (ListLengthFn ?LIST1)) (lessThanOrEqualTo ?NUMBER2 (ListLengthFn ?LIST2)) (instance ?NUMBER1 PositiveInteger) (instance ?NUMBER2 PositiveInteger)) (and (equal (ListOrderFn ?LIST3 ?NUMBER1) (ListOrderFn ?LIST1 ?NUMBER1)) (equal (ListOrderFn ?LIST3 (AdditionFn (ListLengthFn ?LIST1) ?NUMBER2)) (ListOrderFn ?LIST2 ?NUMBER2))))))").
:- assert_kif("(instance inList BinaryPredicate)").
:- assert_kif("(instance inList IrreflexiveRelation)").
:- assert_kif("(instance inList AsymmetricRelation)").
:- assert_kif("(domain inList 1 Entity)").
:- assert_kif("(domain inList 2 List)").
:- assert_kif("(documentation inList EnglishLanguage \"The analog of &%element and &%instance for &%Lists.  (&%inList ?OBJ ?LIST) means that ?OBJ is in the &%List ?LIST. For example,"). (&%inList &%Tuesday (&%ListFn &%Monday &%Tuesday &%Wednesday)) would be true.\")").
:- assert_kif("(=> (inList ?ITEM ?LIST) (exists (?NUMBER) (equal (ListOrderFn ?LIST ?NUMBER) ?ITEM)))").
:- assert_kif("(instance subList BinaryPredicate)").
:- assert_kif("(instance subList PartialOrderingRelation)").
:- assert_kif("(domain subList 1 List)").
:- assert_kif("(domain subList 2 List)").
:- assert_kif("(documentation subList EnglishLanguage \"(&%subList ?LIST1 ?LIST2) means that ?LIST1 is a sublist of ?LIST2, i.e. every element of ?LIST1 is an element of ?LIST2 and the elements that are common to both &%Lists have the same order in both &%Lists. Elements that are common to both Lists and are consecutive in one list must also be consecutive in the other list. (Therefore - the list of prime numbers smaller than 10 [1 2 3 5 7] is not a subList of the natural numbers smaller than 10 [1 2 3 4 5 6 7 8 9]).\")").
:- assert_kif(" (=> (and (subList ?LIST1 ?LIST2) (not (equal ?LIST1 NullList)) (not (equal ?LIST2 NullList))) (forall (?ITEM) (=> (inList ?ITEM ?LIST1) (inList ?ITEM ?LIST2))))").
:- assert_kif(" (=> (and (subList ?LIST1 ?LIST2) (not (equal ?LIST1 NullList)) (not (equal ?LIST2 NullList))) (exists (?NUMBER3) (forall (?ITEM) (=> (inList ?ITEM ?LIST1) (exists (?NUMBER1 ?NUMBER2) (and (equal (ListOrderFn ?LIST1 ?NUMBER1) ?ITEM) (equal (ListOrderFn ?LIST2 ?NUMBER2) ?ITEM) (equal ?NUMBER2 (AdditionFn ?NUMBER1 ?NUMBER3))))))))").
:- assert_kif("(instance initialList BinaryPredicate)").
:- assert_kif("(instance initialList PartialOrderingRelation)").
:- assert_kif("(subrelation initialList subList)").
:- assert_kif("(documentation initialList EnglishLanguage \"(&%initialList ?LIST1 ?LIST2) means that ?LIST1 is a &%subList of ?LIST2 and (&%ListOrderFn ?LIST1 ?NUMBER) returns the same value as (&%ListOrderFn ?LIST2 ?NUMBER) for all of the values of ?NUMBER over which (&%ListOrderFn ?LIST1 ?NUMBER) is defined.\")").
:- assert_kif(" (=> (and (initialList ?LIST1 ?LIST2) (not (equal ?LIST1 NullList)) (not (equal ?LIST2 NullList))) (forall (?NUMBER1 ?NUMBER2) (=> (and (equal (ListLengthFn ?LIST1) ?NUMBER1) (lessThanOrEqualTo ?NUMBER2 ?NUMBER1)) (equal (ListOrderFn ?LIST1 ?NUMBER2) (ListOrderFn ?LIST2 ?NUMBER2)))))").
:- assert_kif("(forall (@ROW ?ITEM) (initialList (ListFn @ROW) (ListFn @ROW ?ITEM)))").
:- assert_kif("(instance identicalListItems BinaryPredicate)").
:- assert_kif("(instance identicalListItems EquivalenceRelation)").
:- assert_kif("(domain identicalListItems 1 List)").
:- assert_kif("(domain identicalListItems 2 List)").
:- assert_kif("(documentation identicalListItems EnglishLanguage \"(&%identicalListItems ?LIST1 ?LIST2) means that ?LIST1 and ?LIST2 have exactly the same items in their respective lists. Although ?LIST1 and ?LIST2 are required to share exactly the same items, they may order these items differently.\")").
:- assert_kif(" (=> (and (identicalListItems ?LIST1 ?LIST2) (not (equal ?LIST1 NullList)) (not (equal ?LIST2 NullList))) (<=> (inList ?ITEM ?LIST1) (inList ?ITEM ?LIST2)))").
:- assert_kif("(subclass Predicate Relation)").
:- assert_kif("(subclass Predicate InheritableRelation)").
:- assert_kif("(documentation Predicate EnglishLanguage \"A &%Predicate is a sentence-forming &%Relation. Each tuple in the &%Relation is a finite, ordered sequence of objects. The fact that a particular tuple is an element of a &%Predicate is denoted by '(*predicate* arg_1 arg_2 .. arg_n)', where the arg_i are the objects so related. In the case of &%BinaryPredicates, the fact can be read as `arg_1 is *predicate* arg_2' or `a *predicate* of arg_1 is arg_2'.\")").
:- assert_kif("(subclass Function SingleValuedRelation)").
:- assert_kif("(subclass Function InheritableRelation)").
:- assert_kif("(documentation Function EnglishLanguage \"A &%Function is a term-forming &%Relation that maps from a n-tuple of arguments to a range and that associates this n-tuple with at most one range element. Note that the range is a &%SetOrClass, and each element of the range is an instance of the &%SetOrClass.\")").
:- assert_kif("(subclass UnaryFunction Function)").
:- assert_kif("(subclass UnaryFunction BinaryRelation)").
:- assert_kif("(subclass UnaryFunction InheritableRelation)").
:- assert_kif("(documentation UnaryFunction EnglishLanguage \"The &%Class of &%Functions that require a single argument.\")").
:- assert_kif("(=> (instance ?FUNCTION UnaryFunction) (valence ?FUNCTION 1))").
:- assert_kif("(subclass OneToOneFunction UnaryFunction)").
:- assert_kif("(documentation OneToOneFunction EnglishLanguage \"The &%Class of &%UnaryFunctions which are one to one. A function F is one to one just in case for all X, Y in the domain of F, if X is not identical to Y, then F(X) is not identical to F(Y).\")").
:- assert_kif("(=> (instance ?FUN OneToOneFunction) (forall (?ARG1 ?ARG2) (=> (and (domain ?FUN 1 ?CLASS) (instance ?ARG1 ?CLASS) (instance ?ARG2 ?CLASS) (not (equal ?ARG1 ?ARG2))) (not (equal (AssignmentFn ?FUN ?ARG1) (AssignmentFn ?FUN ?ARG2))))))").
:- assert_kif("(subclass SequenceFunction OneToOneFunction)").
:- assert_kif("(documentation SequenceFunction EnglishLanguage \"The &%Class of &%OneToOneFunctions whose range is a subclass of the &%PositiveIntegers.\")").
:- assert_kif("(=> (and (instance ?SEQ SequenceFunction) (range ?SEQ ?CLASS)) (subclass ?CLASS Integer))").
:- assert_kif("(subclass BinaryFunction Function)").
:- assert_kif("(subclass BinaryFunction TernaryRelation)").
:- assert_kif("(subclass BinaryFunction InheritableRelation)").
:- assert_kif("(documentation BinaryFunction EnglishLanguage \"The &%Class of &%Functions that require two arguments.\")").
:- assert_kif("(=> (instance ?FUNCTION BinaryFunction) (valence ?FUNCTION 2))").
:- assert_kif("(subclass AssociativeFunction BinaryFunction)").
:- assert_kif("(documentation AssociativeFunction EnglishLanguage \"A &%BinaryFunction is associative if bracketing has no effect on the value returned by the &%Function. More precisely, a &%Function ?FUNCTION is associative just in case").
:- assert_kif("(?FUNCTION ?INST1 (?FUNCTION ?INST2 ?INST3)) is equal to").
:- assert_kif("(?FUNCTION (?FUNCTION ?INST1 ?INST2) ?INST3), for all ?INST1, ?INST2, and ?INST3.\")").
:- assert_kif("(=> (instance ?FUNCTION AssociativeFunction) (forall (?INST1 ?INST2 ?INST3) (=> (and (domain ?FUNCTION 1 ?CLASS) (instance ?INST1 ?CLASS) (instance ?INST2 ?CLASS) (instance ?INST3 ?CLASS)) (equal (AssignmentFn ?FUNCTION ?INST1 (AssignmentFn ?FUNCTION ?INST2 ?INST3)) (AssignmentFn ?FUNCTION (AssignmentFn ?FUNCTION ?INST1 ?INST2) ?INST3)))))").
:- assert_kif("(subclass CommutativeFunction BinaryFunction)").
:- assert_kif("(documentation CommutativeFunction EnglishLanguage \"A &%BinaryFunction is commutative if the ordering of the arguments of the function has no effect on the value returned by the function. More precisely, a function ?FUNCTION is commutative just in case (?FUNCTION ?INST1 ?INST2) is equal to (?FUNCTION ?INST2 ?INST1), for all ?INST1 and ?INST2.\")").
:- assert_kif("(=> (instance ?FUNCTION CommutativeFunction) (forall (?INST1 ?INST2) (=> (and (domain ?FUNCTION 1 ?CLASS) (instance ?INST1 ?CLASS) (instance ?INST2 ?CLASS)) (equal (AssignmentFn ?FUNCTION ?INST1 ?INST2) (AssignmentFn ?FUNCTION ?INST2 ?INST1)))))").
:- assert_kif("(subclass TernaryFunction Function)").
:- assert_kif("(subclass TernaryFunction QuaternaryRelation)").
:- assert_kif("(subclass TernaryFunction InheritableRelation)").
:- assert_kif("(documentation TernaryFunction EnglishLanguage \"The &%Class of &%Functions that require exactly three arguments.\")").
:- assert_kif("(=> (instance ?FUNCTION TernaryFunction) (valence ?FUNCTION 3))").
:- assert_kif("(subclass QuaternaryFunction Function)").
:- assert_kif("(subclass QuaternaryFunction QuintaryRelation)").
:- assert_kif("(subclass QuaternaryFunction InheritableRelation)").
:- assert_kif("(documentation QuaternaryFunction EnglishLanguage \"The &%Class of &%Functions that require exactly four arguments.\")").
:- assert_kif("(=> (instance ?FUNCTION QuaternaryFunction) (valence ?FUNCTION 4))").
:- assert_kif("(subclass ContinuousFunction Function)").
:- assert_kif("(documentation ContinuousFunction EnglishLanguage \"&%Functions which are continuous. This concept is taken as primitive until representations for limits are devised.\")").
:- assert_kif("(subclass BinaryPredicate Predicate)").
:- assert_kif("(subclass BinaryPredicate BinaryRelation)").
:- assert_kif("(subclass BinaryPredicate InheritableRelation)").
:- assert_kif("(documentation BinaryPredicate EnglishLanguage \"A &%Predicate relating two items - its valence is two.\")").
:- assert_kif("(=> (instance ?REL BinaryPredicate) (valence ?REL 2))").
:- assert_kif("(subclass TernaryPredicate Predicate)").
:- assert_kif("(subclass TernaryPredicate TernaryRelation)").
:- assert_kif("(subclass TernaryPredicate InheritableRelation)").
:- assert_kif("(documentation TernaryPredicate EnglishLanguage \"The &%Class of &%Predicates that require exactly three arguments.\")").
:- assert_kif("(=> (instance ?REL TernaryPredicate) (valence ?REL 3))").
:- assert_kif("(subclass QuaternaryPredicate Predicate)").
:- assert_kif("(subclass QuaternaryPredicate QuaternaryRelation)").
:- assert_kif("(subclass QuaternaryPredicate InheritableRelation)").
:- assert_kif("(documentation QuaternaryPredicate EnglishLanguage \"The &%Class of &%Predicates that require four arguments.\")").
:- assert_kif("(=> (instance ?REL QuaternaryPredicate) (valence ?REL 4))").
:- assert_kif("(subclass QuintaryPredicate Predicate)").
:- assert_kif("(subclass QuintaryPredicate QuintaryRelation)").
:- assert_kif("(subclass QuintaryPredicate InheritableRelation)").
:- assert_kif("(documentation QuintaryPredicate EnglishLanguage \"The &%Class of &%Predicates that require five arguments.\")").
:- assert_kif("(=> (instance ?REL QuintaryPredicate) (valence ?REL 5))").
:- assert_kif("(subclass VariableArityRelation Relation)").
:- assert_kif("(documentation VariableArityRelation EnglishLanguage \"The &%Class of &%Relations that do not have a fixed number of arguments.\")").
:- assert_kif("(=> (instance ?REL VariableArityRelation) (not (exists (?INT) (valence ?REL ?INT))))").
:- assert_kif("(subclass RelationExtendedToQuantities Relation)").
:- assert_kif("(subclass RelationExtendedToQuantities InheritableRelation)").
:- assert_kif("(documentation RelationExtendedToQuantities EnglishLanguage \"A &%RelationExtendedToQuantities is a &%Relation that, when it is true on a sequence of arguments that are &%RealNumbers, it is also true on a sequence of instances of &%ConstantQuantity with those magnitudes in some unit of measure. For example, the &%lessThan relation is extended to quantities. This means that for all pairs of quantities ?QUANTITY1 and ?QUANTITY2,"). (&%lessThan ?QUANTITY1 ?QUANTITY2) if and only if, for some ?NUMBER1, ?NUMBER2, and ?UNIT, ?QUANTITY1 = (&%MeasureFn ?NUMBER1 ?UNIT), ?QUANTITY2 = (&%MeasureFn ?NUMBER2 ?UNIT), and (&%lessThan ?NUMBER1 ?NUMBER2), for all units ?UNIT on which ?QUANTITY1 and ?QUANTITY2 can be measured. Note that, when a &%RelationExtendedToQuantities is extended from &%RealNumbers to instances of &%ConstantQuantity, the &%ConstantQuantity must be measured along the same physical dimension.\")").
:- assert_kif("(subclass LogicalOperator Predicate)").
:- assert_kif("(documentation LogicalOperator EnglishLanguage \"This &%Class comprises all of the logical operators (viz. 'and', 'or', 'not', '=>', and '<=>').\")").
:- assert_kif("(subclass Proposition Abstract)").
:- assert_kif("(documentation Proposition EnglishLanguage \"&%Propositions are &%Abstract entities that express a complete thought or a set of such thoughts. As an example, the formula '(instance Yojo Cat)' expresses the &%Proposition that the entity named Yojo is an element of the &%Class of Cats. Note that propositions are not restricted to the content expressed by individual sentences of a &%Language. They may encompass the content expressed by theories, books, and even whole libraries. It is important to distinguish &%Propositions from the &%ContentBearingObjects that express them. A &%Proposition is a piece of information, e.g. that the cat is on the mat, but a &%ContentBearingObject is an &%Object that represents this information. A &%Proposition is an abstraction that may have multiple representations: strings, sounds, icons, etc. For example, the &%Proposition that the cat is on the mat is represented here as a string of graphical characters displayed on a monitor and/or printed on paper, but it can be represented by a sequence of sounds or by some non-latin alphabet or by some cryptographic form\")").
:- assert_kif("(instance closedOn BinaryPredicate)").
:- assert_kif("(instance closedOn AsymmetricRelation)").
:- assert_kif("(domain closedOn 1 Function)").
:- assert_kif("(domain closedOn 2 SetOrClass)").
:- assert_kif("(documentation closedOn EnglishLanguage \"A &%BinaryFunction is closed on a &%SetOrClass if it is defined for all instances of the &%SetOrClass and its value is always an instance of the &%SetOrClass.\")").
:- assert_kif("(=> (and (closedOn ?FUNCTION ?CLASS) (instance ?FUNCTION UnaryFunction)) (forall (?INST) (=> (instance ?INST ?CLASS) (instance (AssignmentFn ?FUNCTION ?INST) ?CLASS))))").
:- assert_kif("(=> (and (closedOn ?FUNCTION ?CLASS) (instance ?FUNCTION BinaryFunction)) (forall (?INST1 ?INST2) (=> (and (instance ?INST1 ?CLASS) (instance ?INST2 ?CLASS)) (instance (AssignmentFn ?FUNCTION ?INST1 ?INST2) ?CLASS))))").
:- assert_kif("(instance reflexiveOn BinaryPredicate)").
:- assert_kif("(instance reflexiveOn AsymmetricRelation)").
:- assert_kif("(domain reflexiveOn 1 BinaryRelation)").
:- assert_kif("(domain reflexiveOn 2 SetOrClass)").
:- assert_kif("(documentation reflexiveOn EnglishLanguage \"A &%BinaryRelation is reflexive on a &%SetOrClass only if every instance of the &%SetOrClass bears the relation to itself.\")").
:- assert_kif("(=> (and (reflexiveOn ?RELATION ?CLASS) (instance ?RELATION Predicate)) (forall (?INST) (=> (instance ?INST ?CLASS) (?RELATION ?INST ?INST))))").
:- assert_kif("(instance irreflexiveOn BinaryPredicate)").
:- assert_kif("(instance irreflexiveOn AsymmetricRelation)").
:- assert_kif("(domain irreflexiveOn 1 BinaryRelation)").
:- assert_kif("(domain irreflexiveOn 2 SetOrClass)").
:- assert_kif("(documentation irreflexiveOn EnglishLanguage \"A &%BinaryRelation is irreflexive on a &%SetOrClass only if no instance of the &%SetOrClass bears the relation to itself.\")").
:- assert_kif("(=> (and (irreflexiveOn ?RELATION ?CLASS) (instance ?RELATION Predicate)) (forall (?INST) (=> (instance ?INST ?CLASS) (not (?RELATION ?INST ?INST)))))").
:- assert_kif("(instance partialOrderingOn BinaryPredicate)").
:- assert_kif("(instance partialOrderingOn AsymmetricRelation)").
:- assert_kif("(domain partialOrderingOn 1 BinaryRelation)").
:- assert_kif("(domain partialOrderingOn 2 SetOrClass)").
:- assert_kif("(documentation partialOrderingOn EnglishLanguage \"A &%BinaryRelation is a partial ordering on a &%SetOrClass only if the relation is &%reflexiveOn the &%SetOrClass, and it is both an &%AntisymmetricRelation, and a &%TransitiveRelation.\")").
:- assert_kif("(=> (partialOrderingOn ?RELATION ?CLASS) (and (reflexiveOn ?RELATION ?CLASS) (instance ?RELATION TransitiveRelation) (instance ?RELATION AntisymmetricRelation)))").
:- assert_kif("(instance totalOrderingOn BinaryPredicate)").
:- assert_kif("(instance totalOrderingOn AsymmetricRelation)").
:- assert_kif("(domain totalOrderingOn 1 BinaryRelation)").
:- assert_kif("(domain totalOrderingOn 2 SetOrClass)").
:- assert_kif("(documentation totalOrderingOn EnglishLanguage \"A &%BinaryRelation ?REL is a total ordering on a &%SetOrClass only if it is a partial ordering for which either").
:- assert_kif("(?REL ?INST1 ?INST2) or (?REL ?INST2 ?INST1) for every ?INST1 and ?INST2 in the &%SetOrClass.\")").
:- assert_kif("(<=> (totalOrderingOn ?RELATION ?CLASS) (and (partialOrderingOn ?RELATION ?CLASS) (trichotomizingOn ?RELATION ?CLASS)))").
:- assert_kif("(instance trichotomizingOn BinaryPredicate)").
:- assert_kif("(instance trichotomizingOn AsymmetricRelation)").
:- assert_kif("(domain trichotomizingOn 1 BinaryRelation)").
:- assert_kif("(domain trichotomizingOn 2 SetOrClass)").
:- assert_kif("(documentation trichotomizingOn EnglishLanguage \"A &%BinaryRelation ?REL is trichotomizing on a &%SetOrClass only if, for all instances ?INST1 and ?INST2 of the &%SetOrClass, at least one of the following holds: (?REL ?INST1 ?INST2),").
:- assert_kif("(?REL ?INST2 ?INST1) or (equal ?INST1 ?INST2).\")").
:- assert_kif("(=> (and (trichotomizingOn ?RELATION ?CLASS) (instance ?RELATION Predicate)) (forall (?INST1 ?INST2) (=> (and (instance ?INST1 ?CLASS) (instance ?INST2 ?CLASS)) (or (?RELATION ?INST1 ?INST2) (?RELATION ?INST2 ?INST1) (equal ?INST1 ?INST2)))))").
:- assert_kif("(instance equivalenceRelationOn BinaryPredicate)").
:- assert_kif("(instance equivalenceRelationOn AsymmetricRelation)").
:- assert_kif("(domain equivalenceRelationOn 1 BinaryRelation)").
:- assert_kif("(domain equivalenceRelationOn 2 SetOrClass)").
:- assert_kif("(documentation equivalenceRelationOn EnglishLanguage \"A &%BinaryRelation is an &%equivalenceRelationOn a &%SetOrClass only if the relation is &%reflexiveOn the &%SetOrClass and it is both a &%TransitiveRelation and a &%SymmetricRelation.\")").
:- assert_kif("(=> (equivalenceRelationOn ?RELATION ?CLASS) (and (instance ?RELATION TransitiveRelation) (instance ?RELATION SymmetricRelation) (reflexiveOn ?RELATION ?CLASS)))").
:- assert_kif("(instance distributes BinaryPredicate)").
:- assert_kif("(domain distributes 1 BinaryFunction)").
:- assert_kif("(domain distributes 2 BinaryFunction)").
:- assert_kif("(documentation distributes EnglishLanguage \"A &%BinaryFunction ?FUNCTION1 is distributive over another &%BinaryFunction ?FUNCTION2 just in case").
:- assert_kif("(?FUNCTION1 ?INST1 (?FUNCTION2 ?INST2 ?INST3)) is equal to").
:- assert_kif("(?FUNCTION2 (?FUNCTION1 ?INST1 ?INST2) (?FUNCTION1 ?INST1 ?INST3)), for all ?INST1, ?INST2, and ?INST3.\")").
:- assert_kif("(=> (distributes ?FUNCTION1 ?FUNCTION2) (forall (?INST1 ?INST2 ?INST3) (=> (and (domain ?FUNCTION1 1 ?CLASS1) (instance ?INST1 ?CLASS1) (instance ?INST2 ?CLASS1) (instance ?INST3 ?CLASS1) (domain ?FUNCTION2 1 ?CLASS2) (instance ?INST1 ?CLASS2) (instance ?INST2 ?CLASS2) (instance ?INST3 ?CLASS2)) (equal (AssignmentFn ?FUNCTION1 ?INST1 (AssignmentFn ?FUNCTION2 ?INST2 ?INST3)) (AssignmentFn ?FUNCTION2 (AssignmentFn ?FUNCTION1 ?INST1 ?INST2) (AssignmentFn ?FUNCTION1 ?INST1 ?INST3))))))").
:- assert_kif("(documentation relatedEvent EnglishLanguage \"(relatedEvent ?EVENT1 ?EVENT2) means that the &%Process ?EVENT1 is related to the Process ?EVENT2. The relationship is between separate individual events, not events and their subprocesses. On the other hand, two &%subProcesses of the same overarching event may be &%relatedEvents. The argument order does not imply temporal ordering.\")").
:- assert_kif("(instance relatedEvent BinaryPredicate)").
:- assert_kif("(instance relatedEvent SymmetricRelation)").
:- assert_kif("(domain relatedEvent 1 Process)").
:- assert_kif("(domain relatedEvent 2 Process)").
:- assert_kif("(=> (and (subProcess ?S1 ?P) (subProcess ?S2 ?P)) (relatedEvent ?S1 ?S2))").
:- assert_kif("(instance causes BinaryPredicate)").
:- assert_kif("(instance causes AsymmetricRelation)").
:- assert_kif("(domain causes 1 Process)").
:- assert_kif("(domain causes 2 Process)").
:- assert_kif("(relatedInternalConcept causes causesSubclass)").
:- assert_kif("(subrelation causes relatedEvent)").
:- assert_kif("(documentation causes EnglishLanguage \"The causation relation between instances of &%Process.  (&%causes ?PROCESS1 ?PROCESS2) means that the instance of &%Process ?PROCESS1 brings about the instance of &%Process ?PROCESS2.\")").
:- assert_kif("(=> (instance ?PROC1 Process) (exists (?PROC2) (causes ?PROC2 ?PROC1)))").
:- assert_kif("(=> (causes ?P1 ?P2) (earlier (WhenFn ?P1) (WhenFn ?P2)))").
:- assert_kif("(instance causesSubclass BinaryPredicate)").
:- assert_kif("(instance causesSubclass AsymmetricRelation)").
:- assert_kif("(domainSubclass causesSubclass 1 Process)").
:- assert_kif("(domainSubclass causesSubclass 2 Process)").
:- assert_kif("(documentation causesSubclass EnglishLanguage \"The causation relation between subclasses of &%Process.  (&%causesSubclass ?PROCESS1 ?PROCESS2) means that the subclass of &%Process ?PROCESS1 brings about the subclass of &%Process ?PROCESS2, e.g. (&%causesSubclass &%Killing &%Death).\")").
:- assert_kif("(=> (causesSubclass ?PROC1 ?PROC2) (forall (?INST2) (=> (instance ?INST2 ?PROC2) (exists (?INST1) (and (instance ?INST1 ?PROC1) (causes ?INST1 ?INST2))))))").
:- assert_kif("(instance causesProposition BinaryPredicate)").
:- assert_kif("(instance causesProposition AsymmetricRelation)").
:- assert_kif("(domain causesProposition 1 Formula)").
:- assert_kif("(domain causesProposition 2 Formula)").
:- assert_kif("(documentation causesProposition EnglishLanguage \"(&%causesProposition ?FORMULA1 ?FORMULA2) means that the state of affairs described by ?FORMULA1 causes, or mechanistically brings about, the state of affairs described by ?FORMULA2. Note that unlike &%entails, the time during which ?FORMULA2 holds cannot precede the time during which ?FORMULA1 holds, although ?FORMULA1 and ?FORMULA2 can hold simultaneously. Note, also, that &%causesProposition is a predicate, not a truth function. The following rule").
:- assert_kif("(contraposition) does not hold: (=> (causesProp ?FORMULA1 ?FORMULA2) (causesProp (not ?FORMULA2) (not ?FORMULA1))).\")").
:- assert_kif("(=> (and (holdsDuring ?T2 ?SIT2) (holdsDuring ?T1 ?SIT1) (instance ?T1 TimeInterval) (instance ?T2 TimeInterval) (causesProposition ?SIT1 ?SIT2)) (beforeOrEqual (BeginFn ?T1) (BeginFn ?T2)))").
:- assert_kif("(instance copy BinaryPredicate)").
:- assert_kif("(instance copy EquivalenceRelation)").
:- assert_kif("(domain copy 1 Object)").
:- assert_kif("(domain copy 2 Object)").
:- assert_kif("(documentation copy EnglishLanguage \"relates an &%Object to an exact copy of the &%Object, where an exact copy is indistinguishable from the original with regard to every property except (possibly) spatial and/or temporal location.\")").
:- assert_kif("(=> (copy ?OBJ1 ?OBJ2) (forall (?ATTR) (=> (attribute ?OBJ1 ?ATTR) (attribute ?OBJ2 ?ATTR))))").
:- assert_kif("(instance time BinaryPredicate)").
:- assert_kif("(instance time TemporalRelation)").
:- assert_kif("(instance time AsymmetricRelation)").
:- assert_kif("(domain time 1 Physical)").
:- assert_kif("(domain time 2 TimePosition)").
:- assert_kif("(relatedInternalConcept time located)").
:- assert_kif("(relatedInternalConcept time holdsDuring)").
:- assert_kif("(documentation time EnglishLanguage \"This relation holds between an instance of &%Physical and an instance of &%TimePosition just in case the temporal lifespan of the former includes the latter. In other words, (&%time ?THING ?TIME) means that ?THING existed or occurred at ?TIME. Note that &%time does for instances of &%Physical what &%holdsDuring does for instances of &%Formula. The constants &%located and &%time are the basic spatial and temporal predicates, respectively.\")").
:- assert_kif("(instance holdsDuring BinaryPredicate)").
:- assert_kif("(instance holdsDuring AsymmetricRelation)").
:- assert_kif("(domain holdsDuring 1 TimePosition)").
:- assert_kif("(domain holdsDuring 2 Formula)").
:- assert_kif("(documentation holdsDuring EnglishLanguage \"(&%holdsDuring ?TIME ?FORMULA) means that the proposition denoted by ?FORMULA is true in the time frame ?TIME. Note that this implies that ?FORMULA is true at every &%TimePoint which is a &%temporalPart of ?TIME.\")").
:- assert_kif("(=> (and (holdsDuring ?TIME ?SITUATION1) (entails ?SITUATION1 ?SITUATION2)) (holdsDuring ?TIME ?SITUATION2))").
:- assert_kif("(=> (holdsDuring ?TIME (not ?SITUATION)) (not (holdsDuring ?TIME ?SITUATION)))").
:- assert_kif("(instance capability TernaryPredicate)").
:- assert_kif("(domainSubclass capability 1 Process)").
:- assert_kif("(domain capability 2 CaseRole)").
:- assert_kif("(domain capability 3 Object)").
:- assert_kif("(documentation capability EnglishLanguage \"(&%capability ?PROCESS ?ROLE ?OBJ) means that ?OBJ has the ability to play the role of ?ROLE in &%Processes of type ?PROCESS.\")").
:- assert_kif("(=> (and (instance ?ROLE CaseRole) (?ROLE ?ARG1 ?ARG2) (instance ?ARG1 ?PROC) (subclass ?PROC Process)) (capability ?PROC ?ROLE ?ARG2))").
:- assert_kif("(instance exploits BinaryPredicate)").
:- assert_kif("(instance exploits AsymmetricRelation)").
:- assert_kif("(domain exploits 1 Object)").
:- assert_kif("(domain exploits 2 Agent)").
:- assert_kif("(documentation exploits EnglishLanguage \"(&%exploits ?OBJ ?AGENT) means that ?OBJ is used by ?AGENT as a &%resource in an unspecified instance of &%Process. This &%Predicate, as its corresponding axiom indicates, is a composition of the relations &%agent and &%resource.\")").
:- assert_kif("(=> (exploits ?OBJ ?AGENT) (exists (?PROCESS) (and (agent ?PROCESS ?AGENT) (resource ?PROCESS ?OBJ))))").
:- assert_kif("(instance hasPurpose BinaryPredicate)").
:- assert_kif("(instance hasPurpose AsymmetricRelation)").
:- assert_kif("(domain hasPurpose 1 Physical)").
:- assert_kif("(domain hasPurpose 2 Formula)").
:- assert_kif("(documentation hasPurpose EnglishLanguage \"This &%Predicate expresses the concept of a conventional goal, i.e. a goal with a neutralized agent's intention. Accordingly, (&%hasPurpose ?THING ?FORMULA) means that the instance of &%Physical ?THING has, as its purpose, the &%Proposition expressed by ?FORMULA. Note that there is an important difference in meaning between the &%Predicates &%hasPurpose and &%result. Although the second argument of the latter can satisfy the second argument of the former, a conventional goal is an expected and desired outcome, while a result may be neither expected nor desired. For example, a machine process may have outcomes but no goals, aimless wandering may have an outcome but no goal, a learning process may have goals with no outcomes, and so on.\")").
:- assert_kif("(instance hasPurposeForAgent TernaryPredicate)").
:- assert_kif("(domain hasPurposeForAgent 1 Physical)").
:- assert_kif("(domain hasPurposeForAgent 2 Formula)").
:- assert_kif("(domain hasPurposeForAgent 3 CognitiveAgent)").
:- assert_kif("(documentation hasPurposeForAgent EnglishLanguage \"Expresses a cognitive attitude of an agent with respect to a particular instance of Physical. More precisely,"). (&%hasPurposeForAgent ?THING ?FORMULA ?AGENT) means that the purpose of ?THING for ?AGENT is the proposition expressed by ?FORMULA. Very complex issues are involved here. In particular, the rules of inference of the first order predicate calculus are not truth-preserving for the second argument position of this &%Predicate.\")").
:- assert_kif("(=> (hasPurpose ?THING ?PURPOSE) (exists (?AGENT) (hasPurposeForAgent ?THING ?PURPOSE ?AGENT)))").
:- assert_kif("(instance hasSkill BinaryPredicate)").
:- assert_kif("(instance hasSkill AsymmetricRelation)").
:- assert_kif("(domainSubclass hasSkill 1 Process)").
:- assert_kif("(domain hasSkill 2 Agent)").
:- assert_kif("(documentation hasSkill EnglishLanguage \"Similar to the &%capability &%Predicate with the additional restriction that the ability be practised/ demonstrated to some measurable degree.\")").
:- assert_kif("(=> (hasSkill ?PROC ?AGENT) (capability ?PROC agent ?AGENT))").
:- assert_kif("(instance confersNorm TernaryPredicate)").
:- assert_kif("(domain confersNorm 1 Entity)").
:- assert_kif("(domain confersNorm 2 Formula)").
:- assert_kif("(domain confersNorm 3 ObjectiveNorm)").
:- assert_kif("(documentation confersNorm EnglishLanguage \"Expresses the relationship between a &%Formula, an &%Entity, and an &%ObjectiveNorm when the &%Entity brings it about that the &%Formula has the &%ObjectiveNorm.\")").
:- assert_kif("(=> (holdsDuring ?TIME (confersNorm ?ENTITY ?FORMULA ?NORM)) (and (holdsDuring (ImmediatePastFn ?TIME) (not (modalAttribute ?FORMULA ?NORM))) (holdsDuring (ImmediateFutureFn ?TIME) (modalAttribute ?FORMULA ?NORM))))").
:- assert_kif("(instance deprivesNorm TernaryPredicate)").
:- assert_kif("(disjointRelation deprivesNorm confersNorm)").
:- assert_kif("(domain deprivesNorm 1 Entity)").
:- assert_kif("(domain deprivesNorm 2 Formula)").
:- assert_kif("(domain deprivesNorm 3 ObjectiveNorm)").
:- assert_kif("(documentation deprivesNorm EnglishLanguage \"Expresses the relationship between an &%Entity, a &%Formula, and an &%ObjectiveNorm when the &%Entity brings it about that the &%Formula does not have the &%ObjectiveNorm.\")").
:- assert_kif("(=> (holdsDuring ?TIME (deprivesNorm ?ENTITY ?FORMULA ?NORM)) (and (holdsDuring (ImmediatePastFn ?TIME) (modalAttribute ?FORMULA ?NORM)) (holdsDuring (ImmediateFutureFn ?TIME) (not (modalAttribute ?FORMULA ?NORM)))))").
:- assert_kif("(instance partlyLocated SpatialRelation)").
:- assert_kif("(instance partlyLocated BinaryPredicate)").
:- assert_kif("(domain partlyLocated 1 Physical)").
:- assert_kif("(domain partlyLocated 2 Object)").
:- assert_kif("(documentation partlyLocated EnglishLanguage \"(&%partlyLocated ?OBJ1 ?OBJ2) means that the instance of &%Physical ?OBJ1 is at least partially located at ?OBJ2. For example, Istanbul is partly located in &%Asia and partly located in &%Europe. Note that &%partlyLocated is the most basic localization relation: &%located is an immediate &%subrelation of &%partlyLocated and &%exactlyLocated is an immediate &%subrelation of &%located.\")").
:- assert_kif("(=> (and (instance ?OBJ1 Object) (partlyLocated ?OBJ1 ?OBJ2)) (overlapsSpatially ?OBJ1 ?OBJ2))").
:- assert_kif("(=> (and (instance ?OBJ1 Object) (partlyLocated ?OBJ1 ?OBJ2)) (exists (?SUB) (and (part ?SUB ?OBJ1) (located ?SUB ?OBJ2))))").
:- assert_kif("(instance located AntisymmetricRelation)").
:- assert_kif("(instance located TransitiveRelation)").
:- assert_kif("(subrelation located partlyLocated)").
:- assert_kif("(documentation located EnglishLanguage \"(&%located ?OBJ1 ?OBJ2) means that ?OBJ1 is &%partlyLocated at ?OBJ2, and there is no &%part of ?OBJ1 that is not &%located at ?OBJ2.\")").
:- assert_kif("(=> (located ?OBJ1 ?OBJ2) (forall (?SUB) (=> (part ?SUB ?OBJ1) (located ?SUB ?OBJ2))))").
:- assert_kif("(instance eventPartlyLocated CaseRole)").
:- assert_kif("(subrelation eventPartlyLocated partlyLocated)").
:- assert_kif("(domain eventPartlyLocated 1 Process)").
:- assert_kif("(domain eventPartlyLocated 2 Object)").
:- assert_kif("(documentation eventPartlyLocated EnglishLanguage \"(&%eventPartlyLocated ?PROC ?OBJ) means that some &%subProcess of &%Process ?PROC is located in &%Object ?OBJ.\")").
:- assert_kif("(termFormat EnglishLanguage eventPartlyLocated \"event partly located\")").
:- assert_kif("(=> (eventPartlyLocated ?PROC ?OBJ) (exists (?SUB) (and (subProcess ?SUB ?PROC) (eventLocated ?SUB ?OBJ))))").
:- assert_kif("(=> (origin ?PROCESS ?LOC) (eventPartlyLocated ?PROCESS ?LOC))").
:- assert_kif("(=> (destination ?PROCESS ?LOC) (eventPartlyLocated ?PROCESS ?LOC))").
:- assert_kif("(subrelation eventLocated eventPartlyLocated)").
:- assert_kif("(documentation eventLocated EnglishLanguage \"(&%eventLocated ?PROC ?OBJ) means that the entire &%Process ?PROC is located on &%Object ?OBJ, meaning that all &%subProcess of ?PROC is located on ?OBJ\")").
:- assert_kif("(termFormat EnglishLanguage eventLocated \"event located\")").
:- assert_kif("(=> (eventLocated ?PROCESS ?OBJ) (forall (?SUB) (=> (subProcess ?SUB ?PROCESS) (eventLocated ?SUB ?OBJ))))").
:- assert_kif("(subrelation exactlyLocated located)").
:- assert_kif("(documentation exactlyLocated EnglishLanguage \"The actual, minimal location of an Object. This is a subrelation of the more general &%Predicate &%located.\")").
:- assert_kif("(=> (exactlyLocated ?OBJ ?REGION) (not (exists (?OTHEROBJ) (and (exactlyLocated ?OTHEROBJ ?REGION) (not (equal ?OTHEROBJ ?OBJ))))))").
:- assert_kif("(instance between SpatialRelation)").
:- assert_kif("(instance between TernaryPredicate)").
:- assert_kif("(domain between 1 Object)").
:- assert_kif("(domain between 2 Object)").
:- assert_kif("(domain between 3 Object)").
:- assert_kif("(documentation between EnglishLanguage \"(between ?OBJ1 ?OBJ2 ?OBJ3) means that ?OBJ2 is spatially located between ?OBJ1 and ?OBJ3. Note that this implies that ?OBJ2 is directly between ?OBJ1 and ?OBJ3, i.e. the projections of ?OBJ1 and ?OBJ3 overlap with ?OBJ2.\")").
:- assert_kif("(=> (between ?END1 ?MID ?END2) (between ?END2 ?MID ?END1))").
:- assert_kif("(documentation betweenOnPath EnglishLanguage \"(betweenOnPath ?OBJ1 ?OBJ2 ?OBJ3 ?PATH) means that ?OBJ2 is spatially located between ?OBJ1 and ?OBJ3 on the path ?PATH. Note that this is a more specialized relation of between since any object that is between others with respect to a particular path is also simply between them.\")").
:- assert_kif("(instance betweenOnPath SpatialRelation)").
:- assert_kif("(instance betweenOnPath QuaternaryPredicate)").
:- assert_kif("(domain betweenOnPath 1 Object) 	").
:- assert_kif("(domain betweenOnPath 2 Object) 	").
:- assert_kif("(domain betweenOnPath 3 Object)").
:- assert_kif("(domain betweenOnPath 4 Object)").
:- assert_kif("(=> (betweenOnPath ?OBJ1 ?OBJ2 ?OBJ3 ?PATH) (between ?OBJ1 ?OBJ2 ?OBJ3))").
:- assert_kif("(instance traverses BinaryPredicate)").
:- assert_kif("(instance traverses SpatialRelation)").
:- assert_kif("(domain traverses 1 Object)").
:- assert_kif("(domain traverses 2 Object)").
:- assert_kif("(documentation traverses EnglishLanguage \"(&%traverses ?OBJ1 ?OBJ2) means that ?OBJ1 crosses or extends across ?OBJ2. Note that &%crosses and &%penetrates are subrelations of &%traverses.\")").
:- assert_kif("(=> (traverses ?OBJ1 ?OBJ2) (or (crosses ?OBJ1 ?OBJ2) (penetrates ?OBJ1 ?OBJ2)))").
:- assert_kif("(subrelation crosses traverses)").
:- assert_kif("(instance crosses AsymmetricRelation)").
:- assert_kif("(instance crosses TransitiveRelation)").
:- assert_kif("(disjointRelation crosses connected)").
:- assert_kif("(documentation crosses EnglishLanguage \"(crosses ?OBJ1 ?OBJ2) means that &%Object ?OBJ1 &%traverses Object ?OBJ2, without being &%connected to it.\")").
:- assert_kif("(subrelation penetrates traverses)").
:- assert_kif("(subrelation penetrates meetsSpatially)").
:- assert_kif("(instance penetrates AsymmetricRelation)").
:- assert_kif("(instance penetrates IntransitiveRelation)").
:- assert_kif("(documentation penetrates EnglishLanguage \"(penetrates ?OBJ1 ?OBJ2) means that ?OBJ1 is &%connected to ?OBJ2 along at least one whole dimension (length, width or depth).\")").
:- assert_kif("(instance WhereFn BinaryFunction)").
:- assert_kif("(instance WhereFn SpatialRelation)").
:- assert_kif("(instance WhereFn TotalValuedRelation)").
:- assert_kif("(domain WhereFn 1 Physical)").
:- assert_kif("(domain WhereFn 2 TimePoint)").
:- assert_kif("(range WhereFn Region)").
:- assert_kif("(relatedInternalConcept WhereFn WhenFn)").
:- assert_kif("(documentation WhereFn EnglishLanguage \"Maps an &%Object and a &%TimePoint at which the &%Object exists to the &%Region where the &%Object existed at that &%TimePoint.\")").
:- assert_kif("(<=> (equal (WhereFn ?THING ?TIME) ?REGION) (holdsDuring ?TIME (exactlyLocated ?THING ?REGION)))").
:- assert_kif("(instance possesses BinaryPredicate)").
:- assert_kif("(instance possesses AsymmetricRelation)").
:- assert_kif("(domain possesses 1 Agent)").
:- assert_kif("(domain possesses 2 Object)").
:- assert_kif("(documentation possesses EnglishLanguage \"&%Relation that holds between an &%Agent and an &%Object when the &%Agent has ownership of the &%Object.\")").
:- assert_kif("(=> (possesses ?PERSON ?OBJ) (modalAttribute (uses ?OBJ ?PERSON) Permission))").
:- assert_kif("(=> (and (instance ?TIME TimePosition) (holdsDuring ?TIME (possesses ?AGENT1 ?OBJ)) (holdsDuring ?TIME (possesses ?AGENT2 ?OBJ))) (equal ?AGENT1 ?AGENT2))").
:- assert_kif("(instance PropertyFn UnaryFunction)").
:- assert_kif("(instance PropertyFn TotalValuedRelation)").
:- assert_kif("(domain PropertyFn 1 Agent)").
:- assert_kif("(range PropertyFn Set)").
:- assert_kif("(documentation PropertyFn EnglishLanguage \"A &%UnaryFunction that maps an &%Agent to the &%Set of &%Objects owned by the &%Agent.\")").
:- assert_kif("(<=> (instance ?OBJ (PropertyFn ?PERSON)) (possesses ?PERSON ?OBJ))").
:- assert_kif("(instance precondition BinaryPredicate)").
:- assert_kif("(instance precondition AsymmetricRelation)").
:- assert_kif("(instance precondition TransitiveRelation)").
:- assert_kif("(domainSubclass precondition 1 Process)").
:- assert_kif("(domainSubclass precondition 2 Process)").
:- assert_kif("(documentation precondition EnglishLanguage \"A very general &%Predicate. (&%precondition ?PROC1 ?PROC2) means that an instance of ?PROC2 can exist only if an instance of ?PROC1 also exists.\")").
:- assert_kif("(=> (precondition ?PROC1 ?PROC2) (=> (exists (?INST2) (instance ?INST2 ?PROC2)) (exists (?INST1) (instance ?INST1 ?PROC1))))").
:- assert_kif("(instance hindersSubclass BinaryPredicate)").
:- assert_kif("(instance hindersSubclass IrreflexiveRelation)").
:- assert_kif("(domainSubclass hindersSubclass 1 Process)").
:- assert_kif("(domainSubclass hindersSubclass 2 Process)").
:- assert_kif("(documentation hindersSubclass EnglishLanguage \"A very general &%Predicate. (&%hindersSubclass ?PROC1 ?PROC2) means that the &%Process ?PROC1 hindersSubclass or hinders the occurrence of the &%Process ?PROC2. For example, obstructing an object hindersSubclass moving it. Note that this is a relation between types of &%Processes, not between instances.\")").
:- assert_kif("(=> (hindersSubclass ?PROC1 ?PROC2) (forall (?TIME ?PLACE) (decreasesLikelihood (holdsDuring ?TIME (exists (?INST1) (and (instance ?INST1 ?PROC1) (eventLocated ?INST1 ?PLACE)))) (holdsDuring ?TIME (exists (?INST2) (and (instance ?INST2 ?PROC2) (eventLocated ?INST2 ?PLACE)))))))").
:- assert_kif("(instance preventsSubclass BinaryPredicate)").
:- assert_kif("(instance preventsSubclass IrreflexiveRelation)").
:- assert_kif("(domainSubclass preventsSubclass 1 Process)").
:- assert_kif("(domainSubclass preventsSubclass 2 Process)").
:- assert_kif("(relatedInternalConcept preventsSubclass hindersSubclass)").
:- assert_kif("(documentation preventsSubclass EnglishLanguage \"A very general &%Predicate. (preventsSubclass ?PROC1 ?PROC2) means that ?PROC1 preventsSubclass the occurrence of ?PROC2. In other words, if ?PROC1 is occurring in a particular time and place, ?PROC2 cannot occur at the same time and place. For example, innoculating preventsSubclass contracting disease. Note that this is a relation between types of &%Processes, not between instances.\")").
:- assert_kif("(=> (preventsSubclass ?PROC1 ?PROC2) (forall (?TIME ?PLACE) (=> (holdsDuring ?TIME (exists (?INST1) (and (instance ?INST1 ?PROC1) (eventLocated ?INST1 ?PLACE)))) (not (holdsDuring ?TIME (exists (?INST2) (and (instance ?INST2 ?PROC2) (eventLocated ?INST2 ?PLACE))))))))").
:- assert_kif("(instance prevents BinaryPredicate)").
:- assert_kif("(instance prevents IrreflexiveRelation)").
:- assert_kif("(domain prevents 1 Process)").
:- assert_kif("(domainSubclass prevents 2 Process)").
:- assert_kif("(relatedInternalConcept prevents preventsSubclass)").
:- assert_kif("(relatedInternalConcept prevents hinders)").
:- assert_kif("(documentation prevents EnglishLanguage \"A very general &%Predicate. (prevents ?PROC1 ?PROC2) means that an instance of ?PROC1 prevents the occurrence of ?PROC2. Note the difference between this relation and &%preventsSubclass, which is relating classes and not instance-class.\")").
:- assert_kif("(=> (and (prevents ?X ?P) (equal (WhenFn ?X) ?T) (eventLocated ?X ?L)) (not (holdsDuring ?T (exists (?Y) (and (instance ?Y ?P) (eventLocated ?Y ?L))))))").
:- assert_kif("(instance hinders BinaryPredicate)").
:- assert_kif("(instance hinders IrreflexiveRelation)").
:- assert_kif("(domain hinders 1 Process)").
:- assert_kif("(domainSubclass hinders 2 Process)").
:- assert_kif("(relatedInternalConcept hinders hindersSubclass)").
:- assert_kif("(documentation hinders EnglishLanguage \"A genral &%Predicate, where (hinders ?PROC1 ?PROC2) means that an instance of ?PROC1 &%decreasesLikelihood of occurrence of ?PROC2. Compare with &%prevents which is stronger and &%hindersSubclass which relates classes of &%Processes.\")").
:- assert_kif("(=> (hinders ?X ?PROC) (decreasesLikelihood (and (equal (WhenFn ?X) ?T) (eventLocated ?X ?L)) (holdsDuring ?T (exists (?Y) (and (instance ?Y ?PROC) (eventLocated ?Y ?L))))))").
:- assert_kif("(instance refers BinaryPredicate)").
:- assert_kif("(domain refers 1 Entity)").
:- assert_kif("(domain refers 2 Entity)").
:- assert_kif("(documentation refers EnglishLanguage \"(&%refers ?OBJ1 ?OBJ2) means that ?OBJ1 mentions or includes a reference to ?OBJ2. Note that &%refers is more general in meaning than &%represents, because presumably something can represent something else only if it refers to this other thing. For example, an article whose topic is a recent change in the price of oil may refer to many other things, e.g. the general state of the economy, the weather in California, the prospect of global warming, the options for alternative energy sources, the stock prices of various oil companies, etc.\")").
:- assert_kif("(subrelation names refers)").
:- assert_kif("(domain names 1 SymbolicString)").
:- assert_kif("(documentation names EnglishLanguage \"(&%names ?STRING ?ENTITY) means that the thing ?ENTITY has the &%SymbolicString ?STRING as its name. Note that &%names and &%represents are the two immediate &%subrelations of &%refers. The predicate &%names is used when the referring item is merely a tag without connotative content, while the predicate &%represents is used for referring items that have such content.\")").
:- assert_kif("(subrelation uniqueIdentifier names)").
:- assert_kif("(instance uniqueIdentifier SingleValuedRelation)").
:- assert_kif("(documentation uniqueIdentifier EnglishLanguage \"The class of &%names that uniquely identify an instance of &%Entity. Some examples of &%uniqueIdentifiers are the keys of tables in database applications and the ISBN (International Standard Book Number).\")").
:- assert_kif("(subrelation represents refers)").
:- assert_kif("(documentation represents EnglishLanguage \"A very general semiotics &%Predicate.  (&%represents ?THING ?ENTITY) means that ?THING in some way indicates, expresses, connotes, pictures, describes, etc. ?ENTITY. The &%Predicates &%containsInformation and &%realization are subrelations of &%represents. Note that &%represents is a subrelation of &%refers, since something can represent something else only if it refers to this other thing. See the documentation string for &%names.\")").
:- assert_kif("(instance representsForAgent TernaryPredicate)").
:- assert_kif("(domain representsForAgent 1 Entity)").
:- assert_kif("(domain representsForAgent 2 Entity)").
:- assert_kif("(domain representsForAgent 3 Agent)").
:- assert_kif("(documentation representsForAgent EnglishLanguage \"A very general predicate.  (&%representsForAgent ?ENTITY1 ?ENTITY2 ?AGENT) means that the ?AGENT chooses to use ?ENTITY1 to 'stand for' ?ENTITY2.\")").
:- assert_kif("(=> (representsForAgent ?REP ?ENTITY ?AGENT) (represents ?REP ?ENTITY))").
:- assert_kif("(instance representsInLanguage TernaryPredicate)").
:- assert_kif("(domain representsInLanguage 1 LinguisticExpression)").
:- assert_kif("(domain representsInLanguage 2 Entity)").
:- assert_kif("(domain representsInLanguage 3 Language)").
:- assert_kif("(documentation representsInLanguage EnglishLanguage \"A very general predicate.  (&%representsInLanguage ?THING ?ENTITY ?LANGUAGE) means that the &%LinguisticExpression ?THING stands for ?ENTITY in the &%Language ?LANGUAGE.\")").
:- assert_kif("(=> (representsInLanguage ?REP ?ENTITY ?LANGUAGE) (exists (?AGENT) (representsForAgent ?REP ?ENTITY ?AGENT)))").
:- assert_kif("(subrelation equivalentContentClass subsumesContentClass)").
:- assert_kif("(instance equivalentContentClass EquivalenceRelation)").
:- assert_kif("(domainSubclass equivalentContentClass 1 ContentBearingPhysical)").
:- assert_kif("(domainSubclass equivalentContentClass 2 ContentBearingPhysical)").
:- assert_kif("(documentation equivalentContentClass EnglishLanguage \"A &%BinaryPredicate that relates two subclasses of &%ContentBearingPhysical. (&%equivalentContentClass ?CLASS1 ?CLASS2) means that the content expressed by each instance of ?CLASS1 is also expressed by each instance of ?CLASS2, and vice versa. An example would be the relationship between English and Russian editions of Agatha Christie's 'Murder on the Orient Express'. Note that"). (&%equivalentContentClass ?CLASS1 ?CLASS2) implies (&%subsumesContentClass ?CLASS1 ?CLASS2) and (&%subsumesContentClass ?CLASS2 ?CLASS1).\")").
:- assert_kif("(<=> (and (subsumesContentClass ?CLASS1 ?CLASS2) (subsumesContentClass ?CLASS2 ?CLASS1)) (equivalentContentClass ?CLASS1 ?CLASS2))").
:- assert_kif("(instance subsumesContentClass BinaryPredicate)").
:- assert_kif("(instance subsumesContentClass PartialOrderingRelation)").
:- assert_kif("(domainSubclass subsumesContentClass 1 ContentBearingPhysical)").
:- assert_kif("(domainSubclass subsumesContentClass 2 ContentBearingPhysical)").
:- assert_kif("(documentation subsumesContentClass EnglishLanguage \"A &%BinaryPredicate that relates two subclasses of &%ContentBearingPhysical. (&%subsumesContentClass ?CLASS1 ?CLASS2) means that the content expressed by each instance of ?CLASS2 is also expressed by each instance of ?CLASS1. Examples include the relationship between a poem and one of its stanzas or between a book and one of its chapters. Note that this is a relation between subclasses of &%ContentBearingObject, rather than instances. If one wants to relate instances, the &%Predicate &%subsumesContentInstance can be used. Note that &%subsumesContentClass is needed in many cases. Consider, for example, the relation between the King James edition of the Bible and its book of Genesis. This relation holds for every copy of this edition and not just for a single instance.\")").
:- assert_kif("(=> (subsumesContentClass ?CLASS1 ?CLASS2) (forall (?OBJ2 ?INFO) (=> (and (instance ?OBJ2 ?CLASS2) (containsInformation ?OBJ2 ?INFO)) (exists (?OBJ1) (and (instance ?OBJ1 ?CLASS1) (containsInformation ?OBJ1 ?INFO))))))").
:- assert_kif("(subrelation equivalentContentInstance subsumesContentInstance)").
:- assert_kif("(instance equivalentContentInstance EquivalenceRelation)").
:- assert_kif("(domain equivalentContentInstance 1 ContentBearingPhysical)").
:- assert_kif("(domain equivalentContentInstance 2 ContentBearingPhysical)").
:- assert_kif("(relatedInternalConcept equivalentContentInstance equivalentContentClass)").
:- assert_kif("(documentation equivalentContentInstance EnglishLanguage \"A &%BinaryPredicate relating two instances of &%ContentBearingPhysical. (&%equivalentContentInstance ?OBJ1 ?OBJ2) means that the content expressed by ?OBJ1 is identical to the content expressed by ?OBJ2. An example would be the relationship between a handwritten draft of a letter to one's lawyer and a typed copy of the same letter. Note that (&%equivalentContentInstance ?OBJ1 ?OBJ2) implies (&%subsumesContentInstance ?OBJ1 ?OBJ2) and"). (&%subsumesContentInstance ?OBJ2 ?OBJ2).\")").
:- assert_kif("(<=> (and (subsumesContentInstance ?OBJ1 ?OBJ2) (subsumesContentInstance ?OBJ2 ?OBJ1)) (equivalentContentInstance ?OBJ1 ?OBJ2))").
:- assert_kif("(instance subsumesContentInstance BinaryPredicate)").
:- assert_kif("(instance subsumesContentInstance PartialOrderingRelation)").
:- assert_kif("(domain subsumesContentInstance 1 ContentBearingPhysical)").
:- assert_kif("(domain subsumesContentInstance 2 ContentBearingPhysical)").
:- assert_kif("(relatedInternalConcept subsumesContentInstance subsumesContentClass)").
:- assert_kif("(documentation subsumesContentInstance EnglishLanguage \"A &%BinaryPredicate relating two instances of &%ContentBearingPhysical. (&%subsumesContentInstance ?OBJ1 ?OBJ2) means that the content expressed by ?OBJ2 is part of the content expressed by ?OBJ1. An example is the relationship between a handwritten poem and one of its stanzas. Note that this is a relation between instances, rather than &%Classes. If one wants to assert a content relationship between &%Classes, e.g. between the version of an intellectual work and a part of that work, the relation &%subsumesContentClass should be used.\")").
:- assert_kif("(=> (subsumesContentInstance ?OBJ1 ?OBJ2) (forall (?INFO) (=> (containsInformation ?OBJ2 ?INFO) (containsInformation ?OBJ1 ?INFO))))").
:- assert_kif("(subrelation realization represents)").
:- assert_kif("(instance realization AsymmetricRelation)").
:- assert_kif("(domain realization 1 Process)").
:- assert_kif("(domain realization 2 Proposition)").
:- assert_kif("(relatedInternalConcept realization equivalentContentInstance)").
:- assert_kif("(relatedInternalConcept realization containsInformation)").
:- assert_kif("(documentation realization EnglishLanguage \"A subrelation of &%represents.  (&%realization ?PROCESS ?PROP) means that ?PROCESS is a Process which expresses the content of ?PROP. Examples include a particular musical performance, which realizes the content of a musical score, or the reading of a poem.\")").
:- assert_kif("(=> (realization ?PROCESS ?PROP) (exists (?OBJ) (and (instance ?OBJ ContentBearingObject) (containsInformation ?OBJ ?PROP))))").
:- assert_kif("(instance expressedInLanguage BinaryPredicate)").
:- assert_kif("(instance expressedInLanguage AsymmetricRelation)").
:- assert_kif("(domain expressedInLanguage 1 LinguisticExpression)").
:- assert_kif("(domain expressedInLanguage 2 Language)").
:- assert_kif("(documentation expressedInLanguage EnglishLanguage \"(&%expressedInLanguage ?EXPRESS ?LANG) means that the &%LinguisticExpression ?EXPRESS is part of the &%Language ?LANG.\")").
:- assert_kif("(<=> (expressedInLanguage ?EXPRESS ?LANGUAGE) (exists (?PROP) (representsInLanguage ?EXPRESS ?PROP ?LANGUAGE)))").
:- assert_kif("(instance subProposition BinaryPredicate)").
:- assert_kif("(instance subProposition TransitiveRelation)").
:- assert_kif("(instance subProposition IrreflexiveRelation)").
:- assert_kif("(domain subProposition 1 Proposition)").
:- assert_kif("(domain subProposition 2 Proposition)").
:- assert_kif("(documentation subProposition EnglishLanguage \"(&%subProposition ?PROP1 ?PROP2) means that ?PROP1 is a &%Proposition which is a proper part of the &%Proposition ?PROP2. In other words, &%subProposition is the analogue of &%properPart for chunks of abstract content.\")").
:- assert_kif("(=> (subProposition ?PROP1 ?PROP2) (forall (?OBJ1 ?OBJ2) (=> (and (containsInformation ?OBJ1 ?PROP1) (containsInformation ?OBJ2 ?PROP2)) (subsumesContentInstance ?OBJ2 ?OBJ1))))").
:- assert_kif("(subrelation subPlan subProposition)").
:- assert_kif("(instance subPlan TransitiveRelation)").
:- assert_kif("(instance subPlan IrreflexiveRelation)").
:- assert_kif("(domain subPlan 1 Plan)").
:- assert_kif("(domain subPlan 2 Plan)").
:- assert_kif("(documentation subPlan EnglishLanguage \"(&%subPlan ?PLAN1 ?PLAN2) means that ?PLAN1 is a &%Plan which is a proper part of ?PLAN2. This relation is generally used to relate a supporting &%Plan to the overall &%Plan in a particular context.\")").
:- assert_kif("(instance uses BinaryPredicate)").
:- assert_kif("(instance uses AsymmetricRelation)").
:- assert_kif("(domain uses 1 Object)").
:- assert_kif("(domain uses 2 Agent)").
:- assert_kif("(documentation uses EnglishLanguage \"(&%uses ?OBJECT AGENT) means that ?OBJECT is used by ?AGENT as an instrument in an unspecified &%Process. This &%Predicate, as its corresponding axiom indicates, is a composition of the &%CaseRoles &%agent and &%instrument.\")").
:- assert_kif("(=> (uses ?OBJ ?AGENT) (exists (?PROC) (and (agent ?PROC ?AGENT) (instrument ?PROC ?OBJ))))").
% :- assert_kif("; END FILE").
% :- assert_kif("; BEGIN FILE").
% :- assert_kif(";  NUMERIC FUNCTIONS  ").
% :- assert_kif("; INCLUDES 'STRUCTURAL ONTOLOGY' INCLUDES 'BASE ONTOLOGY'").
:- assert_kif("(instance MultiplicationFn BinaryFunction)").
:- assert_kif("(instance MultiplicationFn AssociativeFunction)").
:- assert_kif("(instance MultiplicationFn CommutativeFunction)").
:- assert_kif("(instance MultiplicationFn RelationExtendedToQuantities)").
:- assert_kif("(instance MultiplicationFn TotalValuedRelation)").
:- assert_kif("(domain MultiplicationFn 1 Quantity)").
:- assert_kif("(domain MultiplicationFn 2 Quantity)").
:- assert_kif("(range MultiplicationFn Quantity)").
:- assert_kif("(documentation MultiplicationFn EnglishLanguage \"If ?NUMBER1 and ?NUMBER2 are &%Numbers, then (&%MultiplicationFn ?NUMBER1 ?NUMBER2) is the arithmetical product of these numbers.\")").
:- assert_kif("(instance AdditionFn BinaryFunction)").
:- assert_kif("(instance AdditionFn AssociativeFunction)").
:- assert_kif("(instance AdditionFn CommutativeFunction)").
:- assert_kif("(instance AdditionFn RelationExtendedToQuantities)").
:- assert_kif("(instance AdditionFn TotalValuedRelation)").
:- assert_kif("(domain AdditionFn 1 Quantity)").
:- assert_kif("(domain AdditionFn 2 Quantity)").
:- assert_kif("(range AdditionFn Quantity)").
:- assert_kif("(documentation AdditionFn EnglishLanguage \"If ?NUMBER1 and ?NUMBER2 are &%Numbers, then"). (&%AdditionFn ?NUMBER1 ?NUMBER2) is the arithmetical sum of these numbers.\")").
:- assert_kif("(forall (?NUMBER) (equal (SuccessorFn ?NUMBER) (AdditionFn ?NUMBER 1)))").
:- assert_kif("(instance SubtractionFn BinaryFunction)").
:- assert_kif("(instance SubtractionFn AssociativeFunction)").
:- assert_kif("(instance SubtractionFn RelationExtendedToQuantities)").
:- assert_kif("(instance SubtractionFn TotalValuedRelation)").
:- assert_kif("(domain SubtractionFn 1 Quantity)").
:- assert_kif("(domain SubtractionFn 2 Quantity)").
:- assert_kif("(range SubtractionFn Quantity)").
:- assert_kif("(documentation SubtractionFn EnglishLanguage \"If ?NUMBER1 and ?NUMBER2 are &%Numbers, then (&%SubtractionFn ?NUMBER1 ?NUMBER2) is the arithmetical difference between ?NUMBER1 and ?NUMBER2, i.e. ?NUMBER1 minus ?NUMBER2. An exception occurs when ?NUMBER1 is equal to 0, in which case"). (&%SubtractionFn ?NUMBER1 ?NUMBER2) is the negation of ?NUMBER2.\")").
:- assert_kif("(forall (?NUMBER) (equal (PredecessorFn ?NUMBER) (SubtractionFn ?NUMBER 1)))").
:- assert_kif("(instance DivisionFn BinaryFunction)").
:- assert_kif("(instance DivisionFn AssociativeFunction)").
:- assert_kif("(instance DivisionFn RelationExtendedToQuantities)").
:- assert_kif("(instance DivisionFn PartialValuedRelation)").
:- assert_kif("(domain DivisionFn 1 Quantity)").
:- assert_kif("(domain DivisionFn 2 Quantity)").
:- assert_kif("(range DivisionFn Quantity)").
:- assert_kif("(documentation DivisionFn EnglishLanguage \"If ?NUMBER1 and ?NUMBER2 are &%Numbers, then"). (&%DivisionFn ?NUMBER1 ?NUMBER2) is the result of dividing ?NUMBER1 by ?NUMBER2. Note that when ?NUMBER1 = 1 (&%DivisionFn ?NUMBER1 ?NUMBER2) is the reciprocal of ?NUMBER2. Note too that (&%DivisionFn ?NUMBER1 ?NUMBER2) is undefined when ?NUMBER2 = 0.\")").
:- assert_kif("(=> (instance ?NUMBER RationalNumber) (exists (?INT1 ?INT2) (and (instance ?INT1 Integer) (instance ?INT2 Integer) (equal ?NUMBER (DivisionFn ?INT1 ?INT2)))))").
:- assert_kif("(instance AbsoluteValueFn UnaryFunction)").
:- assert_kif("(instance AbsoluteValueFn TotalValuedRelation)").
:- assert_kif("(domain AbsoluteValueFn 1 RealNumber)").
:- assert_kif("(range AbsoluteValueFn NonnegativeRealNumber)").
:- assert_kif("(documentation AbsoluteValueFn EnglishLanguage \"The value of (&%AbsoluteValueFn ?NUMBER) is the absolute value of the &%RealNumber ?NUMBER.\")").
:- assert_kif("(<=> (and (equal (AbsoluteValueFn ?NUMBER1) ?NUMBER2) (instance ?NUMBER1 RealNumber) (instance ?NUMBER2 RealNumber)) (or (and (instance ?NUMBER1 NonnegativeRealNumber) (equal ?NUMBER1 ?NUMBER2)) (and (instance ?NUMBER1 NegativeRealNumber) (equal ?NUMBER2 (SubtractionFn 0 ?NUMBER1)))))").
:- assert_kif("(instance CeilingFn UnaryFunction)").
:- assert_kif("(instance CeilingFn TotalValuedRelation)").
:- assert_kif("(domain CeilingFn 1 RealNumber)").
:- assert_kif("(range CeilingFn Integer)").
:- assert_kif("(documentation CeilingFn EnglishLanguage \"(&%CeilingFn ?NUMBER) returns the smallest &%Integer greater than or equal to the &%RealNumber ?NUMBER.\")").
:- assert_kif("(=> (equal (CeilingFn ?NUMBER) ?INT) (not (exists (?OTHERINT) (and (instance ?OTHERINT Integer) (greaterThanOrEqualTo ?OTHERINT ?NUMBER) (lessThan ?OTHERINT ?INT)))))").
:- assert_kif("(instance CosineFn UnaryFunction)").
:- assert_kif("(instance CosineFn TotalValuedRelation)").
:- assert_kif("(domain CosineFn 1 PlaneAngleMeasure)").
:- assert_kif("(range CosineFn RealNumber)").
:- assert_kif("(documentation CosineFn EnglishLanguage \"(&%CosineFn ?DEGREE) returns the cosine of the &%PlaneAngleMeasure ?DEGREE. The cosine of ?DEGREE is the ratio of the side next to ?DEGREE to the hypotenuse in a right-angled triangle.\")").
:- assert_kif("(instance DenominatorFn UnaryFunction)").
:- assert_kif("(instance DenominatorFn TotalValuedRelation)").
:- assert_kif("(domain DenominatorFn 1 RealNumber)").
:- assert_kif("(range DenominatorFn Integer)").
:- assert_kif("(documentation DenominatorFn EnglishLanguage \"(&%DenominatorFn ?NUMBER) returns the denominator of the canonical reduced form of the &%RealNumber ?NUMBER.\")").
:- assert_kif("(instance ExponentiationFn BinaryFunction)").
:- assert_kif("(instance ExponentiationFn RelationExtendedToQuantities)").
:- assert_kif("(instance ExponentiationFn TotalValuedRelation)").
:- assert_kif("(domain ExponentiationFn 1 Quantity)").
:- assert_kif("(domain ExponentiationFn 2 Integer)").
:- assert_kif("(range ExponentiationFn Quantity)").
:- assert_kif("(documentation ExponentiationFn EnglishLanguage \"(&%ExponentiationFn ?NUMBER ?INT) returns the &%RealNumber ?NUMBER raised to the power of the &%Integer ?INT.\")").
:- assert_kif("(instance FloorFn UnaryFunction)").
:- assert_kif("(instance FloorFn TotalValuedRelation)").
:- assert_kif("(domain FloorFn 1 RealNumber)").
:- assert_kif("(range FloorFn Integer)").
:- assert_kif("(documentation FloorFn EnglishLanguage \"(&%FloorFn ?NUMBER) returns the largest &%Integer less than or equal to the &%RealNumber ?NUMBER.\")").
:- assert_kif("(=> (equal (FloorFn ?NUMBER) ?INT) (not (exists (?OTHERINT) (and (instance ?OTHERINT Integer) (lessThanOrEqualTo ?OTHERINT ?NUMBER) (greaterThan ?OTHERINT ?INT)))))").
:- assert_kif("(instance GreatestCommonDivisorFn Function)").
:- assert_kif("(instance GreatestCommonDivisorFn VariableArityRelation)").
:- assert_kif("(instance GreatestCommonDivisorFn PartialValuedRelation)").
:- assert_kif("(range GreatestCommonDivisorFn Integer)").
:- assert_kif("(documentation GreatestCommonDivisorFn EnglishLanguage \"(&%GreatestCommonDivisorFn ?NUMBER1 ?NUMBER2 ... ?NUMBER) returns the greatest common divisor of ?NUMBER1 through ?NUMBER.\")").
:- assert_kif("(=> (equal (GreatestCommonDivisorFn @ROW) ?NUMBER) (forall (?ELEMENT) (=> (inList ?ELEMENT (ListFn @ROW)) (equal (RemainderFn ?ELEMENT ?NUMBER) 0))))").
:- assert_kif("(=> (equal (GreatestCommonDivisorFn @ROW) ?NUMBER) (not (exists (?GREATER) (and (greaterThan ?GREATER ?NUMBER) (forall (?ELEMENT) (=> (inList ?ELEMENT (ListFn @ROW)) (equal (RemainderFn ?ELEMENT ?GREATER) 0)))))))").
:- assert_kif("(documentation multiplicativeFactor EnglishLanguage \"(multiplicativeFactor ?NUMBER1 ?NUMBER2) means that ?NUMBER1 is a factor of ?NUMBER2, i.e. ?NUMBER1 can be multiplied by some &%Integer to give ?NUMBER2 as a result.\")").
:- assert_kif("(instance multiplicativeFactor BinaryPredicate)").
:- assert_kif("(instance multiplicativeFactor TransitiveRelation)").
:- assert_kif("(domain multiplicativeFactor 1 Integer)").
:- assert_kif("(domain multiplicativeFactor 2 Integer)").
:- assert_kif("(=> (multiplicativeFactor ?N1 ?N2) (exists (?I) (and (instance ?I Integer) (equal ?N2 (MultiplicationFn ?N1 ?I)))))").
:- assert_kif("(instance ImaginaryPartFn UnaryFunction)").
:- assert_kif("(instance ImaginaryPartFn TotalValuedRelation)").
:- assert_kif("(domain ImaginaryPartFn 1 ComplexNumber)").
:- assert_kif("(range ImaginaryPartFn ImaginaryNumber)").
:- assert_kif("(documentation ImaginaryPartFn EnglishLanguage \"(&%ImaginaryPartFn ?NUMBER) returns the part of ?NUMBER that has the square root of -1 as its factor.\")").
:- assert_kif("(=> (instance ?NUMBER ComplexNumber) (exists (?PART1 ?PART2) (and (equal ?PART1 (RealNumberFn ?NUMBER)) (equal ?PART2 (ImaginaryPartFn ?NUMBER)))))").
:- assert_kif("(instance IntegerSquareRootFn UnaryFunction)").
:- assert_kif("(instance IntegerSquareRootFn PartialValuedRelation)").
:- assert_kif("(domain IntegerSquareRootFn 1 RealNumber)").
:- assert_kif("(range IntegerSquareRootFn NonnegativeInteger)").
:- assert_kif("(documentation IntegerSquareRootFn EnglishLanguage \"(&%IntegerSquareRootFn ?NUMBER) returns the integer square root of ?NUMBER.\")").
:- assert_kif("(instance LeastCommonMultipleFn Function)").
:- assert_kif("(instance LeastCommonMultipleFn PartialValuedRelation)").
:- assert_kif("(instance LeastCommonMultipleFn VariableArityRelation)").
:- assert_kif("(range LeastCommonMultipleFn Integer)").
:- assert_kif("(documentation LeastCommonMultipleFn EnglishLanguage \"(&%LeastCommonMultipleFn ?NUMBER1 ?NUMBER2 ... ?NUMBER) returns the least common multiple of ?NUMBER1 through ?NUMBER.\")").
:- assert_kif("(=> (equal (LeastCommonMultipleFn @ROW) ?NUMBER) (forall (?ELEMENT) (=> (inList ?ELEMENT (ListFn @ROW)) (equal (RemainderFn ?NUMBER ?ELEMENT) 0))))").
:- assert_kif("(=> (equal (LeastCommonMultipleFn @ROW) ?NUMBER) (not (exists (?LESS) (and (lessThan ?LESS ?NUMBER) (forall (?ELEMENT) (=> (inList ?ELEMENT (ListFn @ROW)) (equal (RemainderFn ?LESS ?ELEMENT) 0)))))))").
:- assert_kif("(instance LogFn BinaryFunction)").
:- assert_kif("(domain LogFn 1 RealNumber)").
:- assert_kif("(domain LogFn 2 PositiveInteger)").
:- assert_kif("(range LogFn RealNumber)").
:- assert_kif("(documentation LogFn EnglishLanguage \"(LogFn ?NUMBER ?INT) returns the logarithm of the &%RealNumber ?NUMBER in the base denoted by the &%Integer ?INT.\")").
:- assert_kif("(instance MaxFn BinaryFunction)").
:- assert_kif("(instance MaxFn AssociativeFunction)").
:- assert_kif("(instance MaxFn CommutativeFunction)").
:- assert_kif("(instance MaxFn RelationExtendedToQuantities)").
:- assert_kif("(instance MaxFn TotalValuedRelation)").
:- assert_kif("(domain MaxFn 1 Quantity)").
:- assert_kif("(domain MaxFn 2 Quantity)").
:- assert_kif("(range MaxFn Quantity)").
:- assert_kif("(documentation MaxFn EnglishLanguage \"(&%MaxFn ?NUMBER1 ?NUMBER2) is the largest of ?NUMBER1 and ?NUMBER2. In cases where ?NUMBER1 is equal to ?NUMBER2, &%MaxFn returns one of its arguments.\")").
:- assert_kif("(=> (equal (MaxFn ?NUMBER1 ?NUMBER2) ?NUMBER) (or (and (equal ?NUMBER ?NUMBER1) (greaterThan ?NUMBER1 ?NUMBER2)) (and (equal ?NUMBER ?NUMBER2) (greaterThan ?NUMBER2 ?NUMBER1)) (and (equal ?NUMBER ?NUMBER1) (equal ?NUMBER ?NUMBER2))))").
:- assert_kif("(instance MinFn BinaryFunction)").
:- assert_kif("(instance MinFn AssociativeFunction)").
:- assert_kif("(instance MinFn CommutativeFunction)").
:- assert_kif("(instance MinFn RelationExtendedToQuantities)").
:- assert_kif("(instance MinFn TotalValuedRelation)").
:- assert_kif("(domain MinFn 1 Quantity)").
:- assert_kif("(domain MinFn 2 Quantity)").
:- assert_kif("(range MinFn Quantity)").
:- assert_kif("(documentation MinFn EnglishLanguage \"(&%MinFn ?NUMBER1 ?NUMBER2) is the smallest of ?NUMBER1 and ?NUMBER2. In cases where ?NUMBER1 is equal to ?NUMBER2, &%MinFn returns one of its arguments.\")").
:- assert_kif("(=> (equal (MinFn ?NUMBER1 ?NUMBER2) ?NUMBER) (or (and (equal ?NUMBER ?NUMBER1) (lessThan ?NUMBER1 ?NUMBER2)) (and (equal ?NUMBER ?NUMBER2) (lessThan ?NUMBER2 ?NUMBER1)) (and (equal ?NUMBER ?NUMBER1) (equal ?NUMBER ?NUMBER2))))").
:- assert_kif("(instance NumeratorFn UnaryFunction)").
:- assert_kif("(instance NumeratorFn TotalValuedRelation)").
:- assert_kif("(domain NumeratorFn 1 RealNumber)").
:- assert_kif("(range NumeratorFn Integer)").
:- assert_kif("(documentation NumeratorFn EnglishLanguage \"(&%NumeratorFn ?NUMBER) returns the numerator of the canonical reduced form ?NUMBER.\")").
:- assert_kif("(instance Pi PositiveRealNumber)").
:- assert_kif("(documentation Pi EnglishLanguage \"&%Pi is the &%RealNumber that is the ratio of the perimeter of a circle to its diameter. It is approximately equal to 3.141592653589793.\")").
:- assert_kif("(instance NumberE PositiveRealNumber)").
:- assert_kif("(documentation NumberE EnglishLanguage \"&%NumberE is the &%RealNumber that is the base for natural logarithms. It is approximately equal to 2.718282.\")").
:- assert_kif("(instance RationalNumberFn UnaryFunction)").
:- assert_kif("(domain RationalNumberFn 1 Number)").
:- assert_kif("(range RationalNumberFn RationalNumber)").
:- assert_kif("(documentation RationalNumberFn EnglishLanguage \"(&%RationalNumberFn ?NUMBER) returns the rational representation of ?NUMBER.\")").
:- assert_kif("(instance RealNumberFn UnaryFunction)").
:- assert_kif("(domain RealNumberFn 1 Number)").
:- assert_kif("(range RealNumberFn RealNumber)").
:- assert_kif("(documentation RealNumberFn EnglishLanguage \"(RealNumberFn ?NUMBER) returns the part of ?NUMBER that is a &%RealNumber.\")").
:- assert_kif("(instance ReciprocalFn UnaryFunction)").
:- assert_kif("(instance ReciprocalFn RelationExtendedToQuantities)").
:- assert_kif("(instance ReciprocalFn TotalValuedRelation)").
:- assert_kif("(domain ReciprocalFn 1 Quantity)").
:- assert_kif("(range ReciprocalFn Quantity)").
:- assert_kif("(documentation ReciprocalFn EnglishLanguage \"(ReciprocalFn ?NUMBER) is the reciprocal element of ?NUMBER with respect to the multiplication operator"). (&%MultiplicationFn), i.e. 1/?NUMBER. Not all numbers have a reciprocal element. For example the number 0 does not. If a number ?NUMBER has a reciprocal ?RECIP, then the product of ?NUMBER and ?RECIP will be 1, e.g. 3*1/3 = 1. The reciprocal of an element is &%equal to applying the &%ExponentiationFn function to the element to the power -1.\")").
:- assert_kif("(=> (instance ?NUMBER Quantity) (equal (ReciprocalFn ?NUMBER) (ExponentiationFn ?NUMBER -1)))").
:- assert_kif("(=> (instance ?NUMBER Quantity) (equal 1 (MultiplicationFn ?NUMBER (ReciprocalFn ?NUMBER))))").
:- assert_kif("(instance RemainderFn BinaryFunction)").
:- assert_kif("(instance RemainderFn RelationExtendedToQuantities)").
:- assert_kif("(instance RemainderFn PartialValuedRelation)").
:- assert_kif("(domain RemainderFn 1 Quantity)").
:- assert_kif("(domain RemainderFn 2 Quantity)").
:- assert_kif("(range RemainderFn Quantity)").
:- assert_kif("(documentation RemainderFn EnglishLanguage \"(RemainderFn ?NUMBER ?DIVISOR) is the remainder of the number ?NUMBER divided by the number ?DIVISOR. The result has the same sign as ?DIVISOR.\")").
:- assert_kif("(<=> (equal (RemainderFn ?NUMBER1 ?NUMBER2) ?NUMBER) (equal (AdditionFn (MultiplicationFn (FloorFn (DivisionFn ?NUMBER1 ?NUMBER2)) ?NUMBER2) ?NUMBER) ?NUMBER1))").
:- assert_kif("(=> (equal (RemainderFn ?NUMBER1 ?NUMBER2) ?NUMBER) (equal (SignumFn ?NUMBER2) (SignumFn ?NUMBER)))").
:- assert_kif("(=> (instance ?NUMBER EvenInteger) (equal (RemainderFn ?NUMBER 2) 0))").
:- assert_kif("(=> (instance ?NUMBER OddInteger) (equal (RemainderFn ?NUMBER 2) 1))").
:- assert_kif("(=> (instance ?PRIME PrimeNumber) (forall (?NUMBER) (=> (equal (RemainderFn ?PRIME ?NUMBER) 0) (or (equal ?NUMBER 1) (equal ?NUMBER ?PRIME)))))").
:- assert_kif("(instance RoundFn UnaryFunction)").
:- assert_kif("(instance RoundFn RelationExtendedToQuantities)").
:- assert_kif("(instance RoundFn TotalValuedRelation)").
:- assert_kif("(domain RoundFn 1 Quantity)").
:- assert_kif("(range RoundFn Quantity)").
:- assert_kif("(documentation RoundFn EnglishLanguage \"(&%RoundFn ?NUMBER) is the &%Integer closest to ?NUMBER on the number line. If ?NUMBER is halfway between two &%Integers (for example 3.5), it denotes the larger &%Integer.\")").
:- assert_kif("(=> (equal (RoundFn ?NUMBER1) ?NUMBER2) (or (=> (lessThan (SubtractionFn ?NUMBER1 (FloorFn ?NUMBER1)) 0.5) (equal ?NUMBER2 (FloorFn ?NUMBER1))) (=> (greaterThanOrEqualTo (SubtractionFn ?NUMBER1 (FloorFn ?NUMBER1)) 0.5) (equal ?NUMBER2 (CeilingFn ?NUMBER1)))))").
:- assert_kif("(instance SignumFn UnaryFunction)").
:- assert_kif("(instance SignumFn TotalValuedRelation)").
:- assert_kif("(domain SignumFn 1 RealNumber)").
:- assert_kif("(range SignumFn Integer)").
:- assert_kif("(documentation SignumFn EnglishLanguage \"(SignumFn ?NUMBER) denotes the sign of ?NUMBER. This is one of the following values: -1, 1, or 0.\")").
:- assert_kif("(=> (instance ?NUMBER NonnegativeRealNumber) (or (equal (SignumFn ?NUMBER) 1) (equal (SignumFn ?NUMBER) 0)))").
:- assert_kif("(=> (instance ?NUMBER PositiveRealNumber) (equal (SignumFn ?NUMBER) 1))").
:- assert_kif("(=> (instance ?NUMBER NegativeRealNumber) (equal (SignumFn ?NUMBER) -1))").
:- assert_kif("(instance SineFn UnaryFunction)").
:- assert_kif("(instance SineFn TotalValuedRelation)").
:- assert_kif("(domain SineFn 1 PlaneAngleMeasure)").
:- assert_kif("(range SineFn RealNumber)").
:- assert_kif("(documentation SineFn EnglishLanguage \"(&%SineFn ?DEGREE) is the sine of the &%PlaneAngleMeasure ?DEGREE. The sine of ?DEGREE is the ratio of the side opposite ?DEGREE to the hypotenuse in a right-angled triangle.\")").
:- assert_kif("(instance SquareRootFn UnaryFunction)").
:- assert_kif("(domain SquareRootFn 1 RealNumber)").
:- assert_kif("(range SquareRootFn Number)").
:- assert_kif("(documentation SquareRootFn EnglishLanguage \"(SquareRootFn ?NUMBER) is the principal square root of ?NUMBER.\")").
:- assert_kif("(=> (equal (SquareRootFn ?NUMBER1) ?NUMBER2) (equal (MultiplicationFn ?NUMBER2 ?NUMBER2) ?NUMBER1))").
:- assert_kif("(instance TangentFn UnaryFunction)").
:- assert_kif("(instance TangentFn TotalValuedRelation)").
:- assert_kif("(domain TangentFn 1 PlaneAngleMeasure)").
:- assert_kif("(range TangentFn RealNumber)").
:- assert_kif("(documentation TangentFn EnglishLanguage \"(&%TangentFn ?DEGREE) is the tangent of the &%PlaneAngleMeasure ?DEGREE. The tangent of ?DEGREE is the ratio of the side opposite ?DEGREE to the side next to ?DEGREE in a right-angled triangle.\")").
:- assert_kif("(=> (instance ?DEGREE PlaneAngleMeasure) (equal (TangentFn ?DEGREE) (DivisionFn (SineFn ?DEGREE) (CosineFn ?DEGREE))))").
:- assert_kif("(instance identityElement BinaryPredicate)").
:- assert_kif("(instance identityElement AsymmetricRelation)").
:- assert_kif("(domain identityElement 1 BinaryFunction)").
:- assert_kif("(domain identityElement 2 Entity)").
:- assert_kif("(documentation identityElement EnglishLanguage \"An object ?ID is the identity element for BinaryFunction ?FUNCTION just in case, for every instance ?INST, applying ?FUNCTION to ?INST and ?ID results in ?INST.\")").
:- assert_kif("(=> (identityElement ?FUNCTION ?ID) (forall (?INST) (=> (and (domain ?FUNCTION 1 ?CLASS) (instance ?INST ?CLASS)) (equal (AssignmentFn ?FUNCTION ?ID ?INST) ?INST))))").
:- assert_kif("(identityElement MultiplicationFn 1)").
:- assert_kif("(identityElement AdditionFn 0)").
:- assert_kif("(identityElement SubtractionFn 0)").
:- assert_kif("(identityElement DivisionFn 1)").
:- assert_kif("(instance SuccessorFn UnaryFunction)").
:- assert_kif("(instance SuccessorFn TotalValuedRelation)").
:- assert_kif("(domain SuccessorFn 1 Integer)").
:- assert_kif("(range SuccessorFn Integer)").
:- assert_kif("(documentation SuccessorFn EnglishLanguage \"A &%UnaryFunction that maps an &%Integer to its successor, e.g. the successor of 5 is 6.\")").
:- assert_kif("(=> (equal (SuccessorFn ?INT1) (SuccessorFn ?INT2)) (equal ?INT1 ?INT2))").
:- assert_kif("(=> (instance ?INT Integer) (lessThan ?INT (SuccessorFn ?INT)))").
:- assert_kif("(=> (and (instance ?INT1 Integer) (instance ?INT2 Integer)) (not (and (lessThan ?INT1 ?INT2) (lessThan ?INT2 (SuccessorFn ?INT1)))))").
:- assert_kif("(=> (instance ?INT Integer) (equal ?INT (SuccessorFn (PredecessorFn ?INT))))").
:- assert_kif("(=> (instance ?INT Integer) (equal ?INT (PredecessorFn (SuccessorFn ?INT))))").
:- assert_kif("(instance PredecessorFn UnaryFunction)").
:- assert_kif("(instance PredecessorFn TotalValuedRelation)").
:- assert_kif("(domain PredecessorFn 1 Integer)").
:- assert_kif("(range PredecessorFn Integer)").
:- assert_kif("(documentation PredecessorFn EnglishLanguage \"A &%UnaryFunction that maps an &%Integer to its predecessor, e.g. the predecessor of 5 is 4.\")").
:- assert_kif("(=> (equal (PredecessorFn ?INT1) (PredecessorFn ?INT2)) (equal ?INT1 ?INT2))").
:- assert_kif("(=> (instance ?INT Integer) (greaterThan ?INT (PredecessorFn ?INT)))").
:- assert_kif("(=> (and (instance ?INT1 Integer) (instance ?INT2 Integer)) (not (and (lessThan ?INT2 ?INT1) (lessThan (PredecessorFn ?INT1) ?INT2))))").
:- assert_kif("(instance average PartialValuedRelation)").
:- assert_kif("(instance average BinaryPredicate)").
:- assert_kif("(instance average SingleValuedRelation)").
:- assert_kif("(domain average 1 List)").
:- assert_kif("(domain average 2 RealNumber)").
:- assert_kif("(termFormat EnglishLanguage average \"average\")").
:- assert_kif("(documentation average EnglishLanguage \"A partial function that relates a &%List to a &%RealNumber, provided that the &%List only has list elements that are &%RealNumbers. The &%RealNumber associated with the &%List is equal to the mathematical average of the &%RealNumbers in the &%List divided by the total number of list elements.\")").
:- assert_kif("(=> (average ?LIST ?AVERAGE) (forall (?LISTITEM) (=> (inList ?LISTITEM ?LIST) (instance ?LISTITEM RealNumber))))").
% :- assert_kif("; END FILE").
% :- assert_kif("; BEGIN FILE").
% :- assert_kif(";   SET/CLASS THEORY   ").
% :- assert_kif("; INCLUDES 'STRUCTURAL ONTOLOGY' INCLUDES 'BASE ONTOLOGY'").
% :- assert_kif("; The following part of the ontology covers set-theoretic predicates and functions. Most of the content here is taken from the kif-sets ontology (available on the Ontolingua server).").
:- assert_kif("(subrelation subset subclass)").
:- assert_kif("(domain subset 1 Set)").
:- assert_kif("(domain subset 2 Set)").
:- assert_kif("(documentation subset EnglishLanguage \"(subset ?SET1 ?SET2) is true just in case the &%elements of the &%Set ?SET1 are also &%elements of the &%Set ?SET2.\")").
:- assert_kif("(=> (subset ?SUBSET ?SET) (forall (?ELEMENT) (=> (element ?ELEMENT ?SUBSET) (element ?ELEMENT ?SET))))").
:- assert_kif("(instance element BinaryPredicate)").
:- assert_kif("(instance element AsymmetricRelation)").
:- assert_kif("(subrelation element instance)").
:- assert_kif("(domain element 1 Entity)").
:- assert_kif("(domain element 2 Set)").
:- assert_kif("(documentation element EnglishLanguage \"(element ?ENTITY ?SET) is true just in case ?ENTITY is contained in the &%Set ?SET. An &%Entity can be an &%element of another &%Entity only if the latter is a &%Set.\")").
:- assert_kif("(=> (forall (?ELEMENT) (<=> (element ?ELEMENT ?SET1) (element ?ELEMENT ?SET2))) (equal ?SET1 ?SET2))").
:- assert_kif("(instance UnionFn BinaryFunction)").
:- assert_kif("(instance UnionFn TotalValuedRelation)").
:- assert_kif("(domain UnionFn 1 SetOrClass)").
:- assert_kif("(domain UnionFn 2 SetOrClass)").
:- assert_kif("(range UnionFn SetOrClass)").
:- assert_kif("(documentation UnionFn EnglishLanguage \"A &%BinaryFunction that maps two &%SetOrClasses to the union of these &%SetOrClasses. An object is an &%element of the union of two &%SetOrClasses just in case it is an &%instance of either &%SetOrClass.\")").
:- assert_kif("(<=> (equal ?U (UnionFn ?C1 ?C2)) (forall (?I1 ?I2 ?I3) (=> (and (instance ?I1 ?C1) (instance ?I2 ?C2) (instance ?I3 ?U)) (and (instance ?I1 ?U) (instance ?I2 ?U) (or (instance ?I3 ?C1) (instance ?I3 ?C2))))))").
:- assert_kif("(instance IntersectionFn BinaryFunction)").
:- assert_kif("(instance IntersectionFn TotalValuedRelation)").
:- assert_kif("(domain IntersectionFn 1 SetOrClass)").
:- assert_kif("(domain IntersectionFn 2 SetOrClass)").
:- assert_kif("(range IntersectionFn SetOrClass)").
:- assert_kif("(documentation IntersectionFn EnglishLanguage \"A &%BinaryFunction that maps two &%SetOrClasses to the intersection of these &%SetOrClasses. An object is an instance of the intersection of two &%SetOrClasses just in case it is an instance of both of those &%SetOrClasses.\")").
:- assert_kif("(instance RelativeComplementFn BinaryFunction)").
:- assert_kif("(instance RelativeComplementFn TotalValuedRelation)").
:- assert_kif("(domain RelativeComplementFn 1 SetOrClass)").
:- assert_kif("(domain RelativeComplementFn 2 SetOrClass)").
:- assert_kif("(range RelativeComplementFn SetOrClass)").
:- assert_kif("(documentation RelativeComplementFn EnglishLanguage \"A &%BinaryFunction that maps two &%SetOrClasses to the difference between these &%SetOrClasses. More precisely, (&%RelativeComplementFn ?CLASS1 ?CLASS2) denotes the instances of ?CLASS1 that are not also instances of ?CLASS2.\")").
:- assert_kif("(instance ComplementFn UnaryFunction)").
:- assert_kif("(instance ComplementFn TotalValuedRelation)").
:- assert_kif("(domain ComplementFn 1 SetOrClass)").
:- assert_kif("(range ComplementFn SetOrClass)").
:- assert_kif("(documentation ComplementFn EnglishLanguage \"The complement of a given &%SetOrClass C is the &%SetOrClass of all things that are not instances of C. In other words, an object is an instance of the complement of a &%SetOrClass C just in case it is not an instance of C.\")").
:- assert_kif("(instance GeneralizedUnionFn UnaryFunction)").
:- assert_kif("(instance GeneralizedUnionFn TotalValuedRelation)").
:- assert_kif("(domainSubclass GeneralizedUnionFn 1 SetOrClass)").
:- assert_kif("(range GeneralizedUnionFn SetOrClass)").
:- assert_kif("(documentation GeneralizedUnionFn EnglishLanguage \"A &%UnaryFunction that takes a &%SetOrClass of &%Classes as its single argument and returns a &%SetOrClass which is the merge of all of the &%Classes in the original &%SetOrClass, i.e. the &%SetOrClass containing just those instances which are instances of an instance of the original &%SetOrClass.\")").
:- assert_kif("(instance GeneralizedIntersectionFn UnaryFunction)").
:- assert_kif("(instance GeneralizedIntersectionFn TotalValuedRelation)").
:- assert_kif("(domainSubclass GeneralizedIntersectionFn 1 SetOrClass)").
:- assert_kif("(range GeneralizedIntersectionFn SetOrClass)").
:- assert_kif("(documentation GeneralizedIntersectionFn EnglishLanguage \"A &%UnaryFunction that takes a &%SetOrClass of &%Classes as its single argument and returns a &%SetOrClass which is the intersection of all of the &%Classes in the original &%SetOrClass, i.e. the &%SetOrClass containing just those instances which are instances of all instances of the original &%SetOrClass.\")").
:- assert_kif("(instance CardinalityFn UnaryFunction)").
:- assert_kif("(instance CardinalityFn TotalValuedRelation)").
:- assert_kif("(instance CardinalityFn AsymmetricRelation)").
:- assert_kif("(domain CardinalityFn 1 (UnionFn SetOrClass Collection))").
:- assert_kif("(range CardinalityFn Number)").
:- assert_kif("(documentation CardinalityFn EnglishLanguage \"(CardinalityFn ?CLASS) returns the number of instances in the &%SetOrClass ?CLASS or the number of members in the ?CLASS &%Collection.\")").
:- assert_kif("(subclass NullSet SetOrClass)").
:- assert_kif("(documentation NullSet EnglishLanguage \"Any &%SetOrClass that contains no instances.\")").
:- assert_kif("(=> (instance ?SET NullSet) (not (exists (?INST) (instance ?INST ?SET))))").
:- assert_kif("(subclass NonNullSet SetOrClass)").
:- assert_kif("(documentation NonNullSet EnglishLanguage \"Any &%SetOrClass that contains at least one instance.\")").
:- assert_kif("(=> (instance ?SET NonNullSet) (exists (?INST) (instance ?INST ?SET)))").
:- assert_kif("(subclass FiniteSet Set)").
:- assert_kif("(documentation FiniteSet EnglishLanguage \"A &%Set containing a finite number of elements.\")").
:- assert_kif("(=> (instance ?SET FiniteSet) (exists (?NUMBER) (and (instance ?NUMBER NonnegativeInteger) (equal ?NUMBER (CardinalityFn ?SET)))))").
:- assert_kif("(subclass PairwiseDisjointClass SetOrClass)").
:- assert_kif("(documentation PairwiseDisjointClass EnglishLanguage \"A &%SetOrClass is a &%PairwiseDisjointClass just in case every instance of the &%SetOrClass is either &%equal to or &%disjoint from every other instance of the &%SetOrClass.\")").
:- assert_kif("(=> (instance ?SUPERCLASS PairwiseDisjointClass) (forall (?CLASS1 ?CLASS2) (=> (and (instance ?CLASS1 ?SUPERCLASS) (instance ?CLASS2 ?SUPERCLASS)) (or (equal ?CLASS1 ?CLASS2) (disjoint ?CLASS1 ?CLASS2)))))").
:- assert_kif("(subclass MutuallyDisjointClass SetOrClass)").
:- assert_kif("(documentation MutuallyDisjointClass EnglishLanguage \"A &%SetOrClass is a &%MutuallyDisjointClass just in case there exists nothing which is an instance of all of the instances of the original &%SetOrClass.\")").
:- assert_kif("(=> (instance ?CLASS MutuallyDisjointClass) (forall (?INST1 ?INST2) (=> (and (instance ?INST1 ?CLASS) (instance ?INST2 ?INST1)) (exists (?INST3) (and (instance ?INST3 ?CLASS) (not (instance ?INST2 ?INST3)))))))").
:- assert_kif("(instance KappaFn BinaryFunction)").
:- assert_kif("(domain KappaFn 1 SymbolicString)").
:- assert_kif("(domain KappaFn 2 Formula)").
:- assert_kif("(range KappaFn Class)").
:- assert_kif("(documentation KappaFn EnglishLanguage \"A class-forming operator that takes two arguments: a variable and a formula containing at least one unbound occurrence of the variable. The result of applying &%KappaFn to a variable and a formula is the &%SetOrClass of things that satisfy the formula. For example, we can denote the &%SetOrClass of prime numbers that are less than 100 with the following expression: (KappaFn ?NUMBER").
:- assert_kif("(and (instance ?NUMBER PrimeNumber) (lessThan ?NUMBER 100))). Note that the use of this function is discouraged, since there is currently no axiomatic support for it.\")").
% :- assert_kif("; At some point we may be able to make use of 'KappaFn' by implementing a macro that decomposes every occurrence of 'KappaFn' into a complex formula. For example the macro might replace every instance of Schema 1 with an instance of Schema 2. Schema 1: (KappaFn <variable> <formula>) Schema 2: (exists (?LIST) (and (instance ?LIST UniqueList) (forall (<variable>) (<=> (inList <variable> ?LIST) <formula>)))) ").
% :- assert_kif("; END FILE").
% :- assert_kif("; BEGIN FILE").
% :- assert_kif(";  GRAPH THEORY  ").
% :- assert_kif("; INCLUDES 'NUMERIC FUNCTIONS'").
:- assert_kif("(subclass Graph Abstract)").
:- assert_kif("(documentation Graph EnglishLanguage \"The &%Class of graphs, where a graph is understood to be a set of &%GraphNodes connected by &%GraphArcs. Note that this &%Class includes only connected graphs, i.e. graphs in which there is a &%GraphPath between any two &%GraphNodes. Note too that every &%Graph is required to contain at least two &%GraphArcs and three &%GraphNodes.\")").
:- assert_kif("(=> (and (instance ?GRAPH Graph) (instance ?NODE1 GraphNode) (instance ?NODE2 GraphNode) (graphPart ?NODE1 ?GRAPH) (graphPart ?NODE2 ?GRAPH) (not (equal ?NODE1 ?NODE2))) (exists (?ARC ?PATH) (or (links ?NODE1 ?NODE2 ?ARC) (and (subGraph ?PATH ?GRAPH) (instance ?PATH GraphPath) (or (and (equal (BeginNodeFn ?PATH) ?NODE1) (equal (EndNodeFn ?PATH) ?NODE2)) (and (equal (BeginNodeFn ?PATH) ?NODE2) (equal (EndNodeFn ?PATH) ?NODE1)))))))").
:- assert_kif("(=> (instance ?GRAPH Graph) (exists (?NODE1 ?NODE2 ?NODE3 ?ARC1 ?ARC2) (and (graphPart ?NODE1 ?GRAPH) (graphPart ?NODE2 ?GRAPH) (graphPart ?NODE3 ?GRAPH) (graphPart ?ARC1 ?GRAPH) (graphPart ?ARC2 ?GRAPH) (links ?NODE1 ?NODE2 ?ARC1) (links ?NODE2 ?NODE3 ?ARC2) (not (equal ?NODE1 ?NODE2)) (not (equal ?NODE2 ?NODE3)) (not (equal ?NODE1 ?NODE3)) (not (equal ?ARC1 ?ARC2)))))").
:- assert_kif("(subclass DirectedGraph Graph)").
:- assert_kif("(documentation DirectedGraph EnglishLanguage \"The &%Class of directed graphs. A directed graph is a &%Graph in which all &%GraphArcs have direction, i.e. every &%GraphArc has an initial node (see &%InitialNodeFn) and a terminal node (see &%TerminalNodeFn).\")").
:- assert_kif("(=> (and (instance ?GRAPH DirectedGraph) (instance ?ARC GraphArc) (graphPart ?ARC ?GRAPH)) (exists (?NODE1 ?NODE2) (and (equal (InitialNodeFn ?ARC) ?NODE1) (equal (TerminalNodeFn ?ARC) ?NODE2))))").
:- assert_kif("(subclass Tree DirectedGraph)").
:- assert_kif("(documentation Tree EnglishLanguage \"A Tree is a &%DirectedGraph that has no &%GraphLoops.\")").
:- assert_kif("(=> (instance ?GRAPH Tree) (not (exists (?LOOP) (and (instance ?LOOP GraphLoop) (graphPart ?LOOP ?GRAPH)))))").
:- assert_kif("(=> (instance ?GRAPH Tree) (not (exists (?LOOP) (and (instance ?LOOP GraphCircuit) (graphPart ?LOOP ?GRAPH)))))").
:- assert_kif("(=> (instance ?GRAPH Tree) (not (exists (?ARC1 ?ARC2 ?NODE) (and (graphPart ?ARC1 ?GRAPH) (graphPart ?ARC2 ?GRAPH) (graphPart ?NODE ?GRAPH) (equal (TerminalNodeFn ?ARC1) ?NODE) (equal (TerminalNodeFn ?ARC2) ?NODE) (not (equal ?ARC1 ?ARC2))))))").
:- assert_kif("(subclass GraphPath DirectedGraph)").
:- assert_kif("(documentation GraphPath EnglishLanguage \"Informally, a single, directed route between two &%GraphNodes in a &%Graph. Formally, a &%DirectedGraph that is a &%subGraph of the original &%Graph and such that no two &%GraphArcs in the &%DirectedGraph have the same intial node (see &%InitialNodeFn) or the same terminal node (see &%TerminalNodeFn).\")").
:- assert_kif("(=> (and (instance ?GRAPH GraphPath) (instance ?ARC GraphArc) (graphPart ?ARC ?GRAPH)) (=> (equal (InitialNodeFn ?ARC) ?NODE) (not (exists (?OTHER) (and (equal (InitialNodeFn ?OTHER) ?NODE) (not (equal ?OTHER ?ARC)))))))").
:- assert_kif("(=> (and (instance ?GRAPH GraphPath) (instance ?ARC GraphArc) (graphPart ?ARC ?GRAPH)) (=> (equal (TerminalNodeFn ?ARC) ?NODE) (not (exists (?OTHER) (and (equal (TerminalNodeFn ?OTHER) ?NODE) (not (equal ?OTHER ?ARC)))))))").
:- assert_kif("(subclass GraphCircuit GraphPath)").
:- assert_kif("(documentation GraphCircuit EnglishLanguage \"A &%GraphPath that begins (see &%BeginNodeFn) and ends (see &%EndNodeFn) at the same &%GraphNode.\")").
:- assert_kif("(<=> (instance ?GRAPH GraphCircuit) (exists (?NODE) (and (equal (BeginNodeFn ?GRAPH) ?NODE) (equal (EndNodeFn ?GRAPH) ?NODE))))").
:- assert_kif("(subclass MultiGraph Graph)").
:- assert_kif("(documentation MultiGraph EnglishLanguage \"The &%Class of multigraphs. A multigraph is a &%Graph containing at least one pair of &%GraphNodes that are connected by more than one &%GraphArc.\")").
:- assert_kif("(<=> (instance ?GRAPH MultiGraph) (exists (?ARC1 ?ARC2 ?NODE1 ?NODE2) (and (graphPart ?ARC1 ?GRAPH) (graphPart ?ARC2 ?GRAPH) (graphPart ?NODE1 ?GRAPH) (graphPart ?NODE2 ?GRAPH) (links ?NODE1 ?NODE2 ?ARC1) (links ?NODE1 ?NODE2 ?ARC2) (not (equal ?ARC1 ?ARC2)))))").
:- assert_kif("(subclass PseudoGraph Graph)").
:- assert_kif("(documentation PseudoGraph EnglishLanguage \"The &%Class of pseudographs. A pseudograph is a &%Graph containing at least one &%GraphLoop.\")").
:- assert_kif("(<=> (instance ?GRAPH PseudoGraph) (exists (?LOOP) (and (instance ?LOOP GraphLoop) (graphPart ?LOOP ?GRAPH))))").
:- assert_kif("(subclass GraphElement Abstract)").
:- assert_kif("(partition GraphElement GraphNode GraphArc)").
:- assert_kif("(documentation GraphElement EnglishLanguage \"Noncompositional parts of &%Graphs. These parts are restricted to &%GraphNodes and &%GraphArcs.\")").
:- assert_kif("(=> (instance ?PART GraphElement) (exists (?GRAPH) (and (instance ?GRAPH Graph) (graphPart ?PART ?GRAPH))))").
:- assert_kif("(subclass GraphNode GraphElement)").
:- assert_kif("(documentation GraphNode EnglishLanguage \"&%Graphs are comprised of &%GraphNodes and &%GraphArcs. Every &%GraphNode is linked by a &%GraphArc.\")").
:- assert_kif("(=> (instance ?NODE GraphNode) (exists (?OTHER ?ARC) (links ?NODE ?OTHER ?ARC)))").
:- assert_kif("(subclass GraphArc GraphElement)").
:- assert_kif("(documentation GraphArc EnglishLanguage \"&%Graphs are comprised of &%GraphNodes and &%GraphArcs. Every &%GraphArc links two &%GraphNodes.\")").
:- assert_kif("(=> (instance ?ARC GraphArc) (exists (?NODE1 ?NODE2) (links ?NODE1 ?NODE2 ?ARC)))").
:- assert_kif("(subclass GraphLoop GraphArc)").
:- assert_kif("(documentation GraphLoop EnglishLanguage \"A &%GraphArc in which a &%GraphNode is linked to itself.\")").
:- assert_kif("(<=> (instance ?LOOP GraphLoop) (exists (?NODE) (links ?NODE ?NODE ?LOOP)))").
:- assert_kif("(=> (and (equal (InitialNodeFn ?ARC) ?NODE) (equal (TerminalNodeFn ?ARC) ?NODE)) (instance ?ARC GraphLoop))").
:- assert_kif("(instance links TernaryPredicate)").
:- assert_kif("(domain links 1 GraphNode)").
:- assert_kif("(domain links 2 GraphNode)").
:- assert_kif("(domain links 3 GraphArc)").
:- assert_kif("(documentation links EnglishLanguage \"a &%TernaryPredicate that specifies the &%GraphArc connecting two &%GraphNodes.\")").
:- assert_kif("(=> (links ?NODE1 ?NODE2 ?ARC) (links ?NODE2 ?NODE1 ?ARC))").
:- assert_kif("(instance graphPart BinaryPredicate)").
:- assert_kif("(instance graphPart AsymmetricRelation)").
:- assert_kif("(instance graphPart IrreflexiveRelation)").
:- assert_kif("(domain graphPart 1 GraphElement)").
:- assert_kif("(domain graphPart 2 Graph)").
:- assert_kif("(documentation graphPart EnglishLanguage \"A basic relation for &%Graphs and their parts. (&%graphPart ?PART ?GRAPH) means that ?PART is a &%GraphArc or &%GraphNode of the &%Graph ?GRAPH.\")").
:- assert_kif("(instance subGraph BinaryPredicate)").
:- assert_kif("(instance subGraph ReflexiveRelation)").
:- assert_kif("(instance subGraph TransitiveRelation)").
:- assert_kif("(domain subGraph 1 Graph)").
:- assert_kif("(domain subGraph 2 Graph)").
:- assert_kif("(documentation subGraph EnglishLanguage \"The relation between two &%Graphs when one &%Graph is a part of the other. (&%subGraph ?GRAPH1 ?GRAPH2) means that ?GRAPH1 is a part of ?GRAPH2.\")").
:- assert_kif("(=> (and (subGraph ?GRAPH1 ?GRAPH2) (graphPart ?ELEMENT ?GRAPH1)) (graphPart ?ELEMENT ?GRAPH2))").
:- assert_kif("(instance pathLength BinaryPredicate)").
:- assert_kif("(instance pathLength AsymmetricRelation)").
:- assert_kif("(instance pathLength IrreflexiveRelation)").
:- assert_kif("(domain pathLength 1 GraphPath)").
:- assert_kif("(domain pathLength 2 PositiveInteger)").
:- assert_kif("(documentation pathLength EnglishLanguage \"A &%BinaryPredicate that specifies the length (in number of &%GraphNodes) of a &%GraphPath.  (&%pathLength ?PATH ?NUMBER) means that there are ?NUMBER nodes in the &%GraphPath ?PATH.\")").
:- assert_kif("(instance InitialNodeFn UnaryFunction)").
:- assert_kif("(instance InitialNodeFn PartialValuedRelation)").
:- assert_kif("(domain InitialNodeFn 1 GraphArc)").
:- assert_kif("(range InitialNodeFn GraphNode)").
:- assert_kif("(documentation InitialNodeFn EnglishLanguage \"A &%UnaryFunction that maps a &%GraphArc to the initial node of the &%GraphArc. Note that this is a partial function. In particular, the function is undefined for &%GraphArcs that are not part of a &%DirectedGraph.\")").
:- assert_kif("(instance TerminalNodeFn UnaryFunction)").
:- assert_kif("(instance TerminalNodeFn PartialValuedRelation)").
:- assert_kif("(domain TerminalNodeFn 1 GraphArc)").
:- assert_kif("(range TerminalNodeFn GraphNode)").
:- assert_kif("(documentation TerminalNodeFn EnglishLanguage \"A &%UnaryFunction that maps a &%GraphArc to the terminal node of the &%GraphArc. Note that this is a partial function. In particular, the function is undefined for &%GraphArcs that are not part of a &%DirectedGraph.\")").
:- assert_kif("(instance BeginNodeFn UnaryFunction)").
:- assert_kif("(instance BeginNodeFn TotalValuedRelation)").
:- assert_kif("(domain BeginNodeFn 1 GraphPath)").
:- assert_kif("(range BeginNodeFn GraphNode)").
:- assert_kif("(relatedInternalConcept BeginNodeFn InitialNodeFn)").
:- assert_kif("(documentation BeginNodeFn EnglishLanguage \"A &%UnaryFunction that maps a &%GraphPath to the &%GraphNode that is the beginning of the &%GraphPath. Note that, unlike &%InitialNodeFn (which relates a &%GraphArc to a &%GraphNode), &%BeginNodeFn is a total function - every &%GraphPath has a beginning.\")").
:- assert_kif("(instance EndNodeFn UnaryFunction)").
:- assert_kif("(instance EndNodeFn TotalValuedRelation)").
:- assert_kif("(domain EndNodeFn 1 GraphPath)").
:- assert_kif("(range EndNodeFn GraphNode)").
:- assert_kif("(relatedInternalConcept EndNodeFn TerminalNodeFn)").
:- assert_kif("(documentation EndNodeFn EnglishLanguage \"A &%UnaryFunction that maps a &%GraphPath to the &%GraphNode that is the end of the &%GraphPath. Note that, unlike &%TerminalNodeFn (which relates a &%GraphArc to a &%GraphNode), &%EndNodeFn is a total function - every &%GraphPath has a end.\")").
:- assert_kif("(instance arcWeight BinaryPredicate)").
:- assert_kif("(instance arcWeight SingleValuedRelation)").
:- assert_kif("(domain arcWeight 1 GraphArc)").
:- assert_kif("(domain arcWeight 2 Quantity)").
:- assert_kif("(documentation arcWeight EnglishLanguage \"This predicate indicates the value of a &%GraphArc in a &%Graph. This could map to the length of a road in a road network or the flow rate of a pipe in a plumbing system.\")").
:- assert_kif("(instance PathWeightFn UnaryFunction)").
:- assert_kif("(domain PathWeightFn 1 GraphPath)").
:- assert_kif("(range PathWeightFn Quantity)").
:- assert_kif("(documentation PathWeightFn EnglishLanguage \"A &%UnaryFunction that maps a &%GraphPath to the sum of the &%arcWeights on the &%GraphArcs in the &%GraphPath.\")").
:- assert_kif("(=> (and (equal (PathWeightFn ?PATH) ?SUM) (subGraph ?SUBPATH ?PATH) (graphPart ?ARC1 ?PATH) (arcWeight ?ARC1 ?NUMBER1) (forall (?ARC2) (=> (graphPart ?ARC2 ?PATH) (or (graphPart ?ARC2 ?SUBPATH) (equal ?ARC2 ?ARC1))))) (equal ?SUM (AdditionFn (PathWeightFn ?SUBPATH) ?NUMBER1)))").
:- assert_kif("(=> (and (equal (PathWeightFn ?PATH) ?SUM) (graphPart ?ARC1 ?PATH) (graphPart ?ARC2 ?PATH) (arcWeight ?ARC1 ?NUMBER1) (arcWeight ?ARC2 ?NUMBER2) (forall (?ARC3) (=> (graphPart ?ARC3 ?PATH) (or (equal ?ARC3 ?ARC1) (equal ?ARC3 ?ARC2))))) (equal (PathWeightFn ?PATH) (AdditionFn ?NUMBER1 ?NUMBER2)))").
:- assert_kif("(instance MinimalWeightedPathFn BinaryFunction)").
:- assert_kif("(domain MinimalWeightedPathFn 1 GraphNode)").
:- assert_kif("(domain MinimalWeightedPathFn 2 GraphNode)").
:- assert_kif("(range MinimalWeightedPathFn GraphPath)").
:- assert_kif("(documentation MinimalWeightedPathFn EnglishLanguage \"This &%BinaryFunction assigns two &%GraphNodes to the &%GraphPath with the smallest sum of weighted arcs between the two &%GraphNodes.\")").
:- assert_kif("(=> (equal (MinimalWeightedPathFn ?NODE1 ?NODE2) ?PATH) (instance ?PATH (GraphPathFn ?NODE1 ?NODE2)))").
:- assert_kif("(=> (and (equal (MinimalWeightedPathFn ?NODE1 ?NODE2) ?PATH) (equal (PathWeightFn ?PATH) ?NUMBER)) (forall (?PATH2) (=> (and (instance ?PATH2 (GraphPathFn ?NODE1 ?NODE2)) (equal (PathWeightFn ?PATH2) ?NUMBER2)) (greaterThanOrEqualTo ?NUMBER2 ?NUMBER1))))").
:- assert_kif("(instance MaximalWeightedPathFn BinaryFunction)").
:- assert_kif("(domain MaximalWeightedPathFn 1 GraphNode)").
:- assert_kif("(domain MaximalWeightedPathFn 2 GraphNode)").
:- assert_kif("(range MaximalWeightedPathFn GraphPath)").
:- assert_kif("(documentation MaximalWeightedPathFn EnglishLanguage \"This &%BinaryFunction assigns two &%GraphNodes to the &%GraphPath with the largest sum of weighted arcs between the two &%GraphNodes.\")").
:- assert_kif("(=> (equal (MaximalWeightedPathFn ?NODE1 ?NODE2) ?PATH) (instance ?PATH (GraphPathFn ?NODE1 ?NODE2)))").
:- assert_kif("(=> (and (equal (MaximalWeightedPathFn ?NODE1 ?NODE2) ?PATH) (equal (PathWeightFn ?PATH) ?NUMBER)) (forall (?PATH2) (=> (and (instance ?PATH2 (GraphPathFn ?NODE1 ?NODE2)) (equal (PathWeightFn ?PATH2) ?NUMBER2)) (lessThanOrEqualTo ?NUMBER2 ?NUMBER1))))").
:- assert_kif("(instance GraphPathFn BinaryFunction)").
:- assert_kif("(instance GraphPathFn TotalValuedRelation)").
:- assert_kif("(domain GraphPathFn 1 GraphNode)").
:- assert_kif("(domain GraphPathFn 2 GraphNode)").
:- assert_kif("(rangeSubclass GraphPathFn GraphPath)").
:- assert_kif("(documentation GraphPathFn EnglishLanguage \"A &%BinaryFunction that maps two &%GraphNodes to the &%Class of &%GraphPaths between those two nodes. Note that the two &%GraphNodes must belong to the same &%Graph.\")").
:- assert_kif("(=> (and (graphPart ?PATH ?GRAPH) (not (instance ?GRAPH DirectedGraph))) (<=> (equal (GraphPathFn ?NODE1 ?NODE2) ?PATH) (equal (GraphPathFn ?NODE2 ?NODE1) ?PATH)))").
:- assert_kif("(instance CutSetFn UnaryFunction)").
:- assert_kif("(domain CutSetFn 1 Graph)").
:- assert_kif("(rangeSubclass CutSetFn GraphPath)").
:- assert_kif("(documentation CutSetFn EnglishLanguage \"A &%UnaryFunction that assigns a &%Graph the &%Class of &%GraphPaths that partition the graph into two separate graphs if cut. There may be more than one cutset for a given graph.\")").
:- assert_kif("(instance MinimalCutSetFn UnaryFunction)").
:- assert_kif("(domain MinimalCutSetFn 1 Graph)").
:- assert_kif("(rangeSubclass MinimalCutSetFn GraphPath)").
:- assert_kif("(relatedInternalConcept MinimalCutSetFn CutSetFn)").
:- assert_kif("(documentation MinimalCutSetFn EnglishLanguage \"A &%UnaryFunction that assigns a &%Graph the &%Class of &%GraphPaths which comprise cutsets for the &%Graph and which have the least number of &%GraphArcs.\")").
:- assert_kif("(=> (instance ?GRAPH Graph) (subclass (MinimalCutSetFn ?GRAPH) (CutSetFn ?GRAPH)))").
:- assert_kif("(=> (equal (MinimalCutSetFn ?GRAPH) ?PATHCLASS) (exists (?NUMBER) (forall (?PATH) (=> (instance ?PATH ?PATHCLASS) (pathLength ?PATH ?NUMBER)))))").
:- assert_kif("(not (exists (?PATH1 ?PATH2) (and (instance ?PATH1 (CutSetFn ?GRAPH)) (instance ?PATH2 (MinimalCutSetFn ?GRAPH)) (pathLength ?PATH1 ?NUMBER1) (pathLength ?PATH2 ?NUMBER2) (lessThan ?NUMBER1 ?NUMBER2))))").
% :- assert_kif("; link the physical system to the abstract graph").
:- assert_kif("(instance abstractCounterpart BinaryPredicate)").
:- assert_kif("(domain abstractCounterpart 1 Abstract)").
:- assert_kif("(domain abstractCounterpart 2 Physical)").
:- assert_kif("(subrelation abstractCounterpart represents)").
:- assert_kif("(documentation abstractCounterpart EnglishLanguage \"(abstractCounterpart ?AB ?PHYS relates a &%Physical entity to an &%Abstract one which is an idealized model in some dimension of the &%Physical entity. For example, an &%Abstract &%GraphNode could be stated to be the counterpart of an actual &%Computer in a &%ComputerNetwork.\")").
:- assert_kif("(subclass PhysicalSystem Physical)").
:- assert_kif("(documentation PhysicalSystem EnglishLanguage \"&%PhysicalSystem is the class of complex &%Physical things. A &%PhysicalSystem may have one or more corresponding abstract &%Graph representations.\")").
:- assert_kif("(instance subSystem BinaryPredicate)").
:- assert_kif("(domain subSystem 1 PhysicalSystem)").
:- assert_kif("(domain subSystem 2 PhysicalSystem)").
:- assert_kif("(documentation subSystem EnglishLanguage \"(&%subSystem ?SUB ?SYSTEM) means that the &%PhysicalSystem ?SUB is a part of the &%PhysicalSystem ?SYSTEM.\")").
:- assert_kif("(instance systemPart BinaryPredicate)").
:- assert_kif("(domain systemPart 1 Physical)").
:- assert_kif("(domain systemPart 2 PhysicalSystem)").
:- assert_kif("(documentation systemPart EnglishLanguage \"(&%systemPart ?PART ?SYSTEM) means that the &%Physical thing ?PART is a &%SystemElement in the &%PhysicalSystem ?SYSTEM.\")").
:- assert_kif("(=> (and (subSystem ?SUB ?SYSTEM) (systemPart ?PART ?SUB)) (systemPart ?PART ?SYSTEM))").
:- assert_kif("(instance graphMeasure BinaryPredicate)").
:- assert_kif("(domain graphMeasure 1 Graph)").
:- assert_kif("(domain graphMeasure 2 UnitOfMeasure)").
:- assert_kif("(documentation graphMeasure EnglishLanguage \"(graphMeasure ?GRAPH ?MEAS) fixes a &%UnitOfMeasure that is used for the &%arcWeight of a given &%Graph. Stating such a relationship entails that the components of given graph are the &%abstractCounterparts of sets of &%Physical &%Entity(ies).\")").
:- assert_kif("(=> (graphMeasure ?G ?M) (forall (?AC) (and (graphPart ?AC ?G) (exists (?PC) (abstractCounterpart ?AC ?PC)))))").
:- assert_kif("(=> (and (graphMeasure ?G ?M) (instance ?AN GraphNode) (instance ?AA GraphArc) (abstractCounterpart ?AN ?PN) (abstractCounterpart ?AA ?PA) (arcWeight ?AA (MeasureFn ?N ?M))) (measure ?PA (MeasureFn ?N ?M)))").
% :- assert_kif("; END FILE").
% :- assert_kif("; BEGIN FILE").
% :- assert_kif(";  UNITS OF MEASURE  ").
% :- assert_kif("; INCLUDES 'NUMERIC FUNCTIONS'").
% :- assert_kif("; This section was originally based on the relations in the Quantities ontology (developed by ITBM-CNR) and the units of measure in the \"Standard Units\" and \"Standard Dimensions\" ontologies on the Ontolingua server. This content has been extensively revised by Helena Sofia Pinto of the Instituto Superior Tecnico in Portugal. The sources for these revisions were: - Barry Taylor, NIST Special Publication 811, Guide for the Use of the International System of Units (SI), 1995. - Encyclopaedia Britannica (on-line version at http://www.britannica.com)").
:- assert_kif("(subclass UnitOfMeasure PhysicalQuantity)").
:- assert_kif("(documentation UnitOfMeasure EnglishLanguage \"A standard of measurement for some dimension. For example, the &%Meter is a &%UnitOfMeasure for the dimension of length, as is the &%Inch. There is no intrinsic property of a &%UnitOfMeasure that makes it primitive or fundamental, rather, a system of units (e.g. &%SystemeInternationalUnit) defines a set of orthogonal dimensions and assigns units for each.\")").
:- assert_kif("(subclass CompositeUnitOfMeasure UnitOfMeasure)").
:- assert_kif("(documentation CompositeUnitOfMeasure EnglishLanguage \"Instances of this &%Class are &%UnitsOfMeasure defined by the functional composition of other units, each of which might be a &%CompositeUnitOfMeasure or a &%NonCompositeUnitOfMeasure.\")").
:- assert_kif("(subclass NonCompositeUnitOfMeasure UnitOfMeasure)").
:- assert_kif("(documentation NonCompositeUnitOfMeasure EnglishLanguage \"Instances of this &%Class are &%UnitsOfMeasure that are applied to a single dimension, and so are not intrinsically defined by the functional composition of other units.\")").
:- assert_kif("(partition UnitOfMeasure CompositeUnitOfMeasure NonCompositeUnitOfMeasure)").
:- assert_kif("(=> (and (instance ?QUANT (MeasureFn ?N ?UNIT)) (instance ?UNIT CompositeUnitOfMeasure)) (instance ?QUANT FunctionQuantity))").
:- assert_kif("(=> (and (instance ?QUANT (MeasureFn ?N ?UNIT)) (instance ?UNIT NonCompositeUnitOfMeasure)) (instance ?QUANT ConstantQuantity))").
:- assert_kif("(subclass SystemeInternationalUnit UnitOfMeasure)").
:- assert_kif("(documentation SystemeInternationalUnit EnglishLanguage \"The &%Class of Systeme International (SI) units.\")").
:- assert_kif("(subclass LengthMeasure ConstantQuantity)").
:- assert_kif("(documentation LengthMeasure EnglishLanguage \"A &%subclass of &%ConstantQuantity, instances of which are measures of length.\")").
:- assert_kif("(subclass UnitOfLength NonCompositeUnitOfMeasure)").
:- assert_kif("(documentation UnitOfLength EnglishLanguage \"Every instance of this &%Class is a &%UnitOfMeasure that can be used with &%MeasureFn to form instances of &%LengthMeasure.\")").
:- assert_kif("(subclass MassMeasure ConstantQuantity)").
:- assert_kif("(documentation MassMeasure EnglishLanguage \"A &%subclass of &%ConstantQuantity, instances of which are measures of the amount of matter in an &%Object.\")").
:- assert_kif("(subclass UnitOfMass NonCompositeUnitOfMeasure)").
:- assert_kif("(documentation UnitOfMass EnglishLanguage \"Every instance of this &%Class is a &%UnitOfMeasure that can be used with &%MeasureFn to form instances of &%MassMeasure, which denote the amount of matter in &%PhysicalObjects.\")").
:- assert_kif("(subclass AreaMeasure FunctionQuantity)").
:- assert_kif("(documentation AreaMeasure EnglishLanguage \"Measures of the amount of space in two dimensions.\")").
:- assert_kif("(subclass UnitOfArea CompositeUnitOfMeasure)").
:- assert_kif("(documentation UnitOfArea EnglishLanguage \"Every instance of this &%Class is a &%UnitOfMeasure that can be used with &%MeasureFn to form instances of &%AreaMeasure.\")").
:- assert_kif("(subclass VolumeMeasure FunctionQuantity)").
:- assert_kif("(documentation VolumeMeasure EnglishLanguage \"Measures of the amount of space in three dimensions.\")").
:- assert_kif("(subclass UnitOfVolume CompositeUnitOfMeasure)").
:- assert_kif("(documentation UnitOfVolume EnglishLanguage \"Every instance of this &%Class is a &%UnitOfMeasure that can be used with &%MeasureFn to form instances of &%VolumeMeasure.\")").
:- assert_kif("(subclass TemperatureMeasure ConstantQuantity)").
:- assert_kif("(documentation TemperatureMeasure EnglishLanguage \"Measures of temperature. In scientific circles, the temperature of something is understood as the average velocity of the atoms or molecules that make up the thing.\")").
:- assert_kif("(subclass UnitOfTemperature NonCompositeUnitOfMeasure)").
:- assert_kif("(documentation UnitOfTemperature EnglishLanguage \"Every instance of this &%Class is a &%UnitOfMeasure that can be used with &%MeasureFn to form instances of &%TemperatureMeasure.\")").
:- assert_kif("(subclass CurrencyMeasure ConstantQuantity)").
:- assert_kif("(documentation CurrencyMeasure EnglishLanguage \"Instances of this &%subclass of &%ConstantQuantity are measures of &%monetaryValue stated in terms of some &%UnitOfCurrency such as &%UnitedStatesDollar, &%UnitedStatesCent, Lire, Yen, etc.\")").
:- assert_kif("(subclass UnitOfCurrency NonCompositeUnitOfMeasure)").
:- assert_kif("(documentation UnitOfCurrency EnglishLanguage \"Every instance of this &%Class is a &%UnitOfMeasure that can be used with &%MeasureFn to form instances of &%CurrencyMeasure.\")").
:- assert_kif("(subclass AngleMeasure ConstantQuantity)").
:- assert_kif("(documentation AngleMeasure EnglishLanguage \"The value of an angle in a plane or in a solid.\")").
:- assert_kif("(subclass UnitOfAngularMeasure NonCompositeUnitOfMeasure)").
:- assert_kif("(documentation UnitOfAngularMeasure EnglishLanguage \"Every instance of this &%Class is a &%UnitOfMeasure that can be used with &%MeasureFn to form instances of &%AngleMeasure.\")").
:- assert_kif("(subclass PlaneAngleMeasure AngleMeasure)").
:- assert_kif("(documentation PlaneAngleMeasure EnglishLanguage \"The value of an angle in a plane.\")").
:- assert_kif("(subclass SolidAngleMeasure AngleMeasure)").
:- assert_kif("(disjoint SolidAngleMeasure PlaneAngleMeasure)").
:- assert_kif("(documentation SolidAngleMeasure EnglishLanguage \"The value of an angle in a solid.\")").
:- assert_kif("(subclass UnitOfInformation NonCompositeUnitOfMeasure)").
:- assert_kif("(documentation UnitOfInformation EnglishLanguage \"Every instance of this &%Class is a &%UnitOfMeasure that can be used with &%MeasureFn to form instances of &%InformationMeasure.\")").
:- assert_kif("(subclass UnitOfDuration NonCompositeUnitOfMeasure)").
:- assert_kif("(documentation UnitOfDuration EnglishLanguage \"Every instance of this &%Class is a &%UnitOfMeasure that can be used with &%MeasureFn to form instances of &%TimeDuration. Note that &%TimeDuration is a &%subclass of &%TimeMeasure.\")").
:- assert_kif("(instance MeasureFn BinaryFunction)").
:- assert_kif("(instance MeasureFn TotalValuedRelation)").
:- assert_kif("(domain MeasureFn 1 RealNumber)").
:- assert_kif("(domain MeasureFn 2 UnitOfMeasure)").
:- assert_kif("(range MeasureFn PhysicalQuantity)").
:- assert_kif("(documentation MeasureFn EnglishLanguage \"This &%BinaryFunction maps a &%RealNumber and a &%UnitOfMeasure to that &%Number of units. It is used to express `measured' instances of &%PhysicalQuantity. Example: the concept of three meters is represented as (&%MeasureFn 3 &%Meter).\")").
:- assert_kif("(=> (and (equal (MeasureFn ?NUMBER ?UNIT) ?QUANT) (instance ?UNIT UnitOfLength)) (instance ?QUANT LengthMeasure))").
:- assert_kif("(=> (and (equal (MeasureFn ?NUMBER ?UNIT) ?QUANT) (instance ?UNIT UnitOfMass)) (instance ?QUANT MassMeasure))").
:- assert_kif("(=> (and (equal (MeasureFn ?NUMBER ?UNIT) ?QUANT) (instance ?UNIT UnitOfArea)) (instance ?QUANT AreaMeasure))").
:- assert_kif("(=> (and (equal (MeasureFn ?NUMBER ?UNIT) ?QUANT) (instance ?UNIT UnitOfVolume)) (instance ?QUANT VolumeMeasure))").
:- assert_kif("(=> (and (equal (MeasureFn ?NUMBER ?UNIT) ?QUANT) (instance ?UNIT UnitOfTemperature)) (instance ?QUANT TemperatureMeasure))").
:- assert_kif("(=> (and (equal (MeasureFn ?NUMBER ?UNIT) ?QUANT) (instance ?UNIT UnitOfCurrency)) (instance ?QUANT CurrencyMeasure))").
:- assert_kif("(=> (and (equal (MeasureFn ?NUMBER ?UNIT) ?QUANT) (instance ?UNIT UnitOfAngularMeasure)) (instance ?QUANT AngleMeasure))").
:- assert_kif("(=> (and (equal (MeasureFn ?NUMBER ?UNIT) ?QUANT) (instance ?UNIT UnitOfDuration)) (instance ?QUANT TimeDuration))").
:- assert_kif("(=> (and (equal (MeasureFn ?NUMBER ?UNIT) ?QUANT) (instance ?UNIT UnitOfInformation)) (instance ?QUANT InformationMeasure))").
% :- assert_kif("; AP - this axiom below doesn't look right, what about functions that return unitless ratios").
:- assert_kif(" (=> (and (instance ?REL RelationExtendedToQuantities) (instance ?REL TernaryRelation) (instance ?NUMBER1 RealNumber) (instance ?NUMBER2 RealNumber) (?REL ?NUMBER1 ?NUMBER2 ?VALUE)) (forall (?UNIT) (=> (instance ?UNIT UnitOfMeasure) (?REL (MeasureFn ?NUMBER1 ?UNIT) (MeasureFn ?NUMBER2 ?UNIT) (MeasureFn ?VALUE ?UNIT)))))").
:- assert_kif("(=> (and (instance ?REL RelationExtendedToQuantities) (instance ?REL BinaryRelation) (instance ?NUMBER1 RealNumber) (instance ?NUMBER2 RealNumber) (?REL ?NUMBER1 ?NUMBER2)) (forall (?UNIT) (=> (instance ?UNIT UnitOfMeasure) (?REL (MeasureFn ?NUMBER1 ?UNIT) (MeasureFn ?NUMBER2 ?UNIT)))))").
:- assert_kif("(subclass UnitOfMeasureMultiplier UnaryFunction)").
:- assert_kif("(subclass UnitOfMeasureMultiplier TotalValuedRelation)").
:- assert_kif("(documentation UnitOfMeasureMultiplier EnglishLanguage \"Each &%instance of this &%Class is a &%UnaryFunction that, when evaluated on its single argument, a &%UnitOfMeasure, produces another &%UnitOfMeasure that is a numeric multiple of the argument.\")").
:- assert_kif("(=> (and (instance ?FUNCTION UnitOfMeasureMultiplier) (instance ?UNIT CompositeUnitOfMeasure)) (instance (?FUNCTION ?UNIT) CompositeUnitOfMeasure))").
:- assert_kif("(=> (and (instance ?FUNCTION UnitOfMeasureMultiplier) (instance ?UNIT NonCompositeUnitOfMeasure)) (instance (?FUNCTION ?UNIT) NonCompositeUnitOfMeasure))").
:- assert_kif("(instance KiloFn UnitOfMeasureMultiplier)").
:- assert_kif("(domain KiloFn 1 UnitOfMeasure)").
:- assert_kif("(range KiloFn UnitOfMeasure)").
:- assert_kif("(documentation KiloFn EnglishLanguage \"A &%UnaryFunction that maps a &%UnitOfMeasure into a &%UnitOfMeasure that is equal to 1,000 units of the original &%UnitOfMeasure. For example, (&%KiloFn &%Gram) is 1,000 &%Grams.\")").
:- assert_kif("(=> (and (instance ?UNIT UnitOfMeasure) (equal ?KILOUNIT (KiloFn ?UNIT))) (equal (MeasureFn 1 ?KILOUNIT) (MeasureFn 1000 ?UNIT)))").
:- assert_kif("(instance MegaFn UnitOfMeasureMultiplier)").
:- assert_kif("(domain MegaFn 1 UnitOfMeasure)").
:- assert_kif("(range MegaFn UnitOfMeasure)").
:- assert_kif("(documentation MegaFn EnglishLanguage \"A &%UnaryFunction that maps a &%UnitOfMeasure into a &%UnitOfMeasure that is equal to 1,000,000 units of the original &%UnitOfMeasure. For example, (&%MegaFn &%Hertz) is 1,000,000 &%Hertz.\")").
:- assert_kif("(=> (and (instance ?UNIT UnitOfMeasure) (equal ?MEGAUNIT (MegaFn ?UNIT))) (equal (MeasureFn 1 ?MEGAUNIT) (MeasureFn 1000000 ?UNIT)))").
:- assert_kif("(instance GigaFn UnitOfMeasureMultiplier)").
:- assert_kif("(domain GigaFn 1 UnitOfMeasure)").
:- assert_kif("(range GigaFn UnitOfMeasure)").
:- assert_kif("(documentation GigaFn EnglishLanguage \"A &%UnaryFunction that maps a &%UnitOfMeasure into a &%UnitOfMeasure that is equal to 1,000,000,000 units of the original &%UnitOfMeasure. For example, (&%GigaFn &%Hertz) is 1,000,000,000 &%Hertz.\")").
:- assert_kif("(=> (and (instance ?UNIT UnitOfMeasure) (equal ?GIGAUNIT (GigaFn ?UNIT))) (equal (MeasureFn 1 ?GIGAUNIT) (MeasureFn 1000000000 ?UNIT)))").
:- assert_kif("(instance TeraFn UnitOfMeasureMultiplier)").
:- assert_kif("(domain TeraFn 1 UnitOfMeasure)").
:- assert_kif("(range TeraFn UnitOfMeasure)").
:- assert_kif("(documentation TeraFn EnglishLanguage \"A &%UnaryFunction that maps a &%UnitOfMeasure into a &%UnitOfMeasure that is equal to 1,000,000,000,000 units of the original &%UnitOfMeasure. For example, (&%TeraFn &%Hertz) is 1,000,000,000,000 &%Hertz.\")").
:- assert_kif("(=> (and (instance ?UNIT UnitOfMeasure) (equal ?TERAUNIT (TeraFn ?UNIT))) (equal (MeasureFn 1 ?TERAUNIT) (MeasureFn 1000000000000 ?UNIT)))").
:- assert_kif("(instance MilliFn UnitOfMeasureMultiplier)").
:- assert_kif("(domain MilliFn 1 UnitOfMeasure)").
:- assert_kif("(range MilliFn UnitOfMeasure)").
:- assert_kif("(documentation MilliFn EnglishLanguage \"A &%UnaryFunction that maps a &%UnitOfMeasure into a &%UnitOfMeasure that is equal to .001 units of the original &%UnitOfMeasure. For example, (&%MilliFn &%Gram) is .001 &%Grams.\")").
:- assert_kif("(=> (and (instance ?UNIT UnitOfMeasure) (equal ?MILLIUNIT (MilliFn ?UNIT))) (equal (MeasureFn 1 ?MILLIUNIT) (MeasureFn 0.001 ?UNIT)))").
:- assert_kif("(instance MicroFn UnitOfMeasureMultiplier)").
:- assert_kif("(domain MicroFn 1 UnitOfMeasure)").
:- assert_kif("(range MicroFn UnitOfMeasure)").
:- assert_kif("(documentation MicroFn EnglishLanguage \"A &%UnaryFunction that maps a &%UnitOfMeasure into a &%UnitOfMeasure that is equal to .000001 units of the original &%UnitOfMeasure. For example, (&%MicroFn &%Meter) is .000001 &%Meters.\")").
:- assert_kif("(=> (and (instance ?UNIT UnitOfMeasure) (equal ?MICROUNIT (MicroFn ?UNIT))) (equal (MeasureFn 1 ?MICROUNIT) (MeasureFn 0.000001 ?UNIT)))").
:- assert_kif("(instance NanoFn UnitOfMeasureMultiplier)").
:- assert_kif("(domain NanoFn 1 UnitOfMeasure)").
:- assert_kif("(range NanoFn UnitOfMeasure)").
:- assert_kif("(documentation NanoFn EnglishLanguage \"A &%UnaryFunction that maps a &%UnitOfMeasure into a &%UnitOfMeasure that is equal to .000000001 units of the original &%UnitOfMeasure. For example, (&%MicroFn &%SecondDuration) is .000000001 &%SecondDurations.\")").
:- assert_kif("(=> (and (instance ?UNIT UnitOfMeasure) (equal ?NANOUNIT (NanoFn ?UNIT))) (equal (MeasureFn 1 ?NANOUNIT) (MeasureFn 0.000000001 ?UNIT)))").
:- assert_kif("(instance PicoFn UnitOfMeasureMultiplier)").
:- assert_kif("(domain PicoFn 1 UnitOfMeasure)").
:- assert_kif("(range PicoFn UnitOfMeasure)").
:- assert_kif("(documentation PicoFn EnglishLanguage \"A &%UnaryFunction that maps a &%UnitOfMeasure into a &%UnitOfMeasure that is equal to .000000000001 units of the original &%UnitOfMeasure. For example, (&%PicoFn &%SecondDuration) is .000000000001 &%SecondDurations.\")").
:- assert_kif("(=> (and (instance ?UNIT UnitOfMeasure) (equal ?PICOUNIT (PicoFn ?UNIT))) (equal (MeasureFn 1 ?PICOUNIT) (MeasureFn 0.000000000001 ?UNIT)))").
:- assert_kif("(instance IntervalFn BinaryFunction)").
:- assert_kif("(domain IntervalFn 1 ConstantQuantity)").
:- assert_kif("(domain IntervalFn 2 ConstantQuantity)").
:- assert_kif("(rangeSubclass IntervalFn ConstantQuantity)").
:- assert_kif("(relatedInternalConcept IntervalFn RecurrentTimeIntervalFn)").
:- assert_kif("(documentation IntervalFn EnglishLanguage \"A &%BinaryFunction that maps two instances of &%ConstantQuantity to the &%subclass of &%ConstantQuantity that comprises the interval from the first &%ConstantQuantity to the second &%ConstantQuantity. For example, (&%IntervalFn (&%MeasureFn 8 &%Meter) (&%MeasureFn 14 &%Meter)) would return the &%subclass of &%ConstantQuantity comprising quantities between 8 and 14 meters in length.\")").
:- assert_kif("(=> (and (instance ?QUANTITY (IntervalFn ?FROM ?TO)) (instance ?FROM ?CLASS) (instance ?TO ?CLASS)) (instance ?QUANTITY ?CLASS))").
:- assert_kif("(<=> (instance ?QUANTITY (IntervalFn ?FROM ?TO)) (and (greaterThanOrEqualTo ?QUANTITY ?FROM) (lessThanOrEqualTo ?QUANTITY ?TO)))").
:- assert_kif("(instance MagnitudeFn UnaryFunction)").
:- assert_kif("(domain MagnitudeFn 1 PhysicalQuantity)").
:- assert_kif("(range MagnitudeFn RealNumber)").
:- assert_kif("(documentation MagnitudeFn EnglishLanguage \"The magnitude of a &%PhysicalQuantity is the numeric value for the quantity. In other words, &%MagnitudeFn converts a &%PhysicalQuantity with an associated &%UnitOfMeasure into an ordinary &%RealNumber. For example, the magnitude of the &%ConstantQuantity 2 &%Kilometers is the &%RealNumber 2. Note that the magnitude of a quantity in a given unit times that unit is equal to the original quantity.\")").
:- assert_kif("(=> (and (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (instance ?UNIT UnitOfMeasure) (equal ?QUANT (MeasureFn ?NUMBER ?UNIT))) (equal (MagnitudeFn ?QUANT) ?NUMBER))").
:- assert_kif("(instance UnitFn UnaryFunction)").
:- assert_kif("(domain UnitFn 1 PhysicalQuantity)").
:- assert_kif("(range UnitFn UnitOfMeasure)").
:- assert_kif("(documentation UnitFn EnglishLanguage \"&%UnitFn returns just the &%UnitOfMeasure of a &%PhysicalQuantity with an associated &%UnitOfMeasure and &%RealNumber magnitude. For example, the unit of the &%ConstantQuantity (&%MeasureFn 2 &%Kilometer) is the &%UnitOfMeasure &%Kilometer.\")").
:- assert_kif("(=> (and (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (instance ?UNIT UnitOfMeasure) (equal ?QUANT (MeasureFn ?NUMBER ?UNIT))) (equal (UnitFn ?QUANT) ?UNIT))").
:- assert_kif("(instance PerFn BinaryFunction)").
:- assert_kif("(instance PerFn TotalValuedRelation)").
:- assert_kif("(domain PerFn 1 PhysicalQuantity)").
:- assert_kif("(domain PerFn 2 PhysicalQuantity)").
:- assert_kif("(range PerFn FunctionQuantity)").
:- assert_kif("(documentation PerFn EnglishLanguage \"&%PerFn maps two instances of &%PhysicalQuantity to the &%FunctionQuantity composed of these two instances. For example,"). (&%PerFn (&%MeasureFn 2 (&%MicroFn &%Gram)) (&%MeasureFn 1 (&%KiloFn &%Gram))) denotes the &%FunctionQuantity of 2 micrograms per kiogram. This function is useful, because it allows the knowledge engineer to dynamically generate instances of &%FunctionQuantity.\")").
:- assert_kif("(subrelation DensityFn PerFn)").
:- assert_kif("(instance DensityFn TotalValuedRelation)").
:- assert_kif("(domain DensityFn 1 MassMeasure)").
:- assert_kif("(domain DensityFn 2 VolumeMeasure)").
:- assert_kif("(range DensityFn FunctionQuantity)").
:- assert_kif("(documentation DensityFn EnglishLanguage \"&%DensityFn maps an instance of &%MassMeasure and an instance of &%VolumeMeasure to the density represented by this proportion of mass and volume. For example, (&%DensityFn (&%MeasureFn 3 &%Gram)"). (&%MeasureFn 1 &%Liter)) represents the density of 3 grams per liter.\")").
:- assert_kif("(subrelation SpeedFn PerFn)").
:- assert_kif("(instance SpeedFn TotalValuedRelation)").
:- assert_kif("(domain SpeedFn 1 LengthMeasure)").
:- assert_kif("(domain SpeedFn 2 TimeDuration)").
:- assert_kif("(range SpeedFn FunctionQuantity)").
:- assert_kif("(documentation SpeedFn EnglishLanguage \"Maps an instance of &%LengthMeasure and an instance of &%TimeDuration to the speed represented by this proportion of distance and time. For example, (&%SpeedFn (&%MeasureFn 55 &%Mile)(&%MeasureFn 1 &%HourDuration)) represents the velocity of 55 miles per hour.\")").
:- assert_kif("(instance VelocityFn QuaternaryFunction)").
:- assert_kif("(instance VelocityFn TotalValuedRelation)").
:- assert_kif("(domain VelocityFn 1 LengthMeasure)").
:- assert_kif("(domain VelocityFn 2 TimeDuration)").
:- assert_kif("(domain VelocityFn 3 Region)").
:- assert_kif("(domain VelocityFn 4 DirectionalAttribute)").
:- assert_kif("(range VelocityFn FunctionQuantity)").
:- assert_kif("(documentation VelocityFn EnglishLanguage \"Specifies the velocity of an object, i.e. the speed and the direction of the speed. For example (&%VelocityFn (&%MeasureFn 55 &%Mile)"). (&%MeasureFn 2 &%HourDuration) ?REFERENCE &%North) denotes the velocity of 55 miles per hour North of the given reference point ?REFERENCE.\")").
:- assert_kif("(=> (measure ?OBJECT (VelocityFn ?DISTANCE ?TIME ?REF ?DIRECTION)) (measure ?OBJECT (SpeedFn ?DISTANCE ?TIME)))").
% :- assert_kif("; Now the units of measure:").
% :- assert_kif("; First base units for the SI system. No conversion functions are provided for these units.").
% :- assert_kif("; Length Base Unit").
:- assert_kif("(instance Meter UnitOfLength)").
:- assert_kif("(instance Meter SystemeInternationalUnit)").
:- assert_kif("(documentation Meter EnglishLanguage \"SI &%UnitOfLength. Symbol: m. It is one of the base units in SI, and it is currently defined as follows: the &%Meter is the length of the path traveled by light in a vacuum during a time interval of 1/299792458 of a &%SecondDuration.\")").
% :- assert_kif("; Mass Base Unit").
:- assert_kif("(instance Gram UnitOfMass)").
:- assert_kif("(instance Gram SystemeInternationalUnit)").
:- assert_kif("(documentation Gram EnglishLanguage \"Submultiple of kilogram. Symbol: g. 1 kilogram = 1000 &%Grams.\")").
% :- assert_kif("; Time Base Unit").
:- assert_kif("(instance SecondDuration UnitOfDuration)").
:- assert_kif("(instance SecondDuration SystemeInternationalUnit)").
:- assert_kif("(documentation SecondDuration EnglishLanguage \"SI &%UnitOfDuration. Symbol: s. It is one of the base units in SI, and it is currently defined as follows: the &%SecondDuration is the duration of 9192631770 periods of the radiation corresponding to the transition between the two hyperfine levels of the ground state of the cesium 133 atom.\")").
% :- assert_kif("; Electric Current Base Unit").
:- assert_kif("(instance Ampere CompositeUnitOfMeasure)").
:- assert_kif("(instance Ampere SystemeInternationalUnit)").
:- assert_kif("(documentation Ampere EnglishLanguage \"SI electric current measure. Symbol: A. It is one of the base units in SI. It is defined as follows: the &%Ampere is that constant current which, if maintained in two straight parallel conductors of infinite length, of negligible circular cross-section, and placed 1 &%Meter apart in a vacuum, would produce between these conductors a force equal to 2*10^(-7) &%Newton per &%Meter of length.\")").
% :- assert_kif("; Thermodynamic Temperature Base Unit").
:- assert_kif("(instance KelvinDegree UnitOfTemperature)").
:- assert_kif("(instance KelvinDegree SystemeInternationalUnit)").
:- assert_kif("(documentation KelvinDegree EnglishLanguage \"SI &%UnitOfMeasure used with &%MeasureFn to produce terms denoting instances of &%TemperatureMeasure. Symbol: K. It is one of the base units in SI (it is also a unit in the ITS system). Kelvin differs from the Celsius scale in that the triple point of water is defined to be 273.16 &%KelvinDegrees while it is 0 &%CelsiusDegrees. The magnitudes of intervals in the two scales are the same. By definition the conversion constant is 273.15.\")").
% :- assert_kif("; Amount Of Substance Base Unit").
:- assert_kif("(instance Mole UnitOfMass)").
:- assert_kif("(instance Mole SystemeInternationalUnit)").
:- assert_kif("(documentation Mole EnglishLanguage \"SI amount of substance unit. symbol: mol. It is one of the base units in SI. It is defined as follows: the &%Mole is the amount of substance of a system which contains as many elementary entities as there are atoms in 0.012 &%Kilograms of carbon 12. Note that, when this &%UnitOfMeasure is used, the elementary entities must be specified - they may be atoms, molecules, ions, electrons, etc. or groups of such particles.\")").
% :- assert_kif("; Luminosity Intensity Base Unit").
:- assert_kif("(instance Candela CompositeUnitOfMeasure)").
:- assert_kif("(instance Candela SystemeInternationalUnit)").
:- assert_kif("(documentation Candela EnglishLanguage \"SI luminosity intensity measure. Symbol: cd. It is one of the base units in SI, and it is currently defined as follows: the &%Candela is the luminous intensity, in a given direction, of a source that emits monochromatic radiation of frequency 540*10^12 &%Hertz and that has a radiant intensity in that direction of 1/683 &%Watt per &%Steradian.\")").
:- assert_kif("(instance Liter UnitOfVolume)").
:- assert_kif("(documentation Liter EnglishLanguage \"Unit of volume in the metric system. It is currently defined to be equal to one cubic decimeter (0.001 cubic meter). Symbol: l.\")").
:- assert_kif("(instance Centimeter UnitOfLength)").
:- assert_kif("(documentation Centimeter EnglishLanguage \"Submultiple of &%Meter. Symbol: cm. It is the 100th part of a &%Meter\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER Centimeter) (MeasureFn (MultiplicationFn ?NUMBER 0.01) Meter)))").
:- assert_kif("(documentation Millimeter EnglishLanguage \"Submultiple of Meter. Symbol: mm. A millimeter is the 1000th part of a meter\")").
:- assert_kif("(instance Millimeter UnitOfLength)").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER Millimeter) (MeasureFn (MultiplicationFn ?NUMBER 0.001) Meter)))").
:- assert_kif("(instance Kilometer UnitOfLength)").
:- assert_kif("(documentation Kilometer EnglishLanguage \"Supermultiple of &%Meter. Symbol: km. A &%Meter is the 1000th part of a &%Kilometer\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER Kilometer) (MeasureFn (MultiplicationFn ?NUMBER 1000) Meter)))").
% :- assert_kif("; What follows are derived SI units with special names and symbols (multiples and submultiples are together since they represent quantities of the same kind).").
% :- assert_kif("; Plane angle unit").
:- assert_kif("(instance Radian UnitOfAngularMeasure)").
:- assert_kif("(instance Radian SystemeInternationalUnit)").
:- assert_kif("(documentation Radian EnglishLanguage \"SI plane angle measure. Symbol: rad. It is the angle of a circle subtended by an arc equal in length to the circle's radius. Another definition is: the plane angle between two radii of a circle which cut off on the circumference an arc equal in length to the radius. &%Radian = m/m = 1.\")").
% :- assert_kif("; Solid angle unit").
:- assert_kif("(instance Steradian UnitOfAngularMeasure)").
:- assert_kif("(instance Steradian SystemeInternationalUnit)").
:- assert_kif("(documentation Steradian EnglishLanguage \"SI solid angle measure. Symbol: sr. It is the solid angle of a sphere subtended by a portion of the surface whose area is equal to the square of the sphere's radius. Another definition is: the solid angle which, having its vertex in the center of the sphere, cuts off an area of the surface of the sphere equal to that of a square with sides of length equal to the radius of the sphere. &%Steradian = m^2/m^2 = 1.\")").
% :- assert_kif("; Frequency units").
:- assert_kif("(subclass FrequencyMeasure TimeDependentQuantity)").
:- assert_kif("(documentation FrequencyMeasure EnglishLanguage \"A &%subclass of &%TimeDependentQuantity, instances of which are measures of the frequency with which some &%Process occurs.\")").
:- assert_kif("(subclass UnitOfFrequency CompositeUnitOfMeasure)").
:- assert_kif("(documentation UnitOfFrequency EnglishLanguage \"Every instance of this &%Class is a &%UnitOfMeasure that can be used with &%MeasureFn to form instances of &%FrequencyMeasure.\")").
:- assert_kif("(=> (and (equal (MeasureFn ?NUMBER ?UNIT) ?QUANT) (instance ?UNIT UnitOfFrequency)) (instance ?QUANT FrequencyMeasure))").
:- assert_kif("(instance Hertz UnitOfFrequency)").
:- assert_kif("(instance Hertz SystemeInternationalUnit)").
:- assert_kif("(documentation Hertz EnglishLanguage \"SI frequency measure. Symbol: Hz. It is the number of cycles per second. &%Hertz = s^(-1). Note that &%Hertz does not have a conversion function.\")").
% :- assert_kif("; Force Unit").
:- assert_kif("(instance Newton CompositeUnitOfMeasure)").
:- assert_kif("(instance Newton SystemeInternationalUnit)").
:- assert_kif("(documentation Newton EnglishLanguage \"SI force measure. Symbol: N. It is that force which gives to a mass of 1 kilogram an acceleration of 1 &%Meter per &%SecondDuration. &%Newton = m*kg*s^(-2).\")").
% :- assert_kif("; Pressure unit").
:- assert_kif("(instance Pascal CompositeUnitOfMeasure)").
:- assert_kif("(instance Pascal SystemeInternationalUnit)").
:- assert_kif("(documentation Pascal EnglishLanguage \"SI pressure measure. Symbol:Pa. It is the pressure of one &%Newton per square &%Meter. &%Pascal = N/m^2 = m^(-1)*kg*s^(-2).\")").
% :- assert_kif("; Energy Unit").
:- assert_kif("(instance Joule CompositeUnitOfMeasure)").
:- assert_kif("(instance Joule SystemeInternationalUnit)").
:- assert_kif("(documentation Joule EnglishLanguage \"SI energy measure. Symbol: J. It is the work done when the point of application of 1 &%Newton is displaced a distance of 1 &%Meter in the direction of the force. &%Joule = N*m = m^2*kg*s^(-2).\")").
% :- assert_kif("; Power Units").
:- assert_kif("(instance Watt CompositeUnitOfMeasure)").
:- assert_kif("(instance Watt SystemeInternationalUnit)").
:- assert_kif("(documentation Watt EnglishLanguage \"SI power measure. Symbol: W. A &%UnitOfMeasure that measures power, i.e. energy produced or expended divided by &%TimeDuration. It is the power which gives rise to the production of energy (or work) at the rate of one &%Joule per &%SecondDuration. &%Watt = J/s = m^2*kg*s^(-3).\")").
:- assert_kif("(instance Horsepower CompositeUnitOfMeasure)").
:- assert_kif("(documentation Horsepower EnglishLanguage \"A power measure that is equal to 746 &%Watts.\")").
:- assert_kif("(=> (instance ?N RealNumber) (equal (MeasureFn ?N Horsepower) (MeasureFn (MultiplicationFn ?N 746) Watt)))").
% :- assert_kif("; Note: According to SI one should not use the expression \"per unit of.\"").
% :- assert_kif("; Electric Charge Units").
:- assert_kif("(instance Coulomb CompositeUnitOfMeasure)").
:- assert_kif("(instance Coulomb SystemeInternationalUnit)").
:- assert_kif("(documentation Coulomb EnglishLanguage \"SI electric charge measure. Symbol: C. It is the quantity of electric charge transported through a cross section of a conductor in an electric circuit during each &%SecondDuration by a current of 1 &%Ampere. Coulomb = s*A.\")").
:- assert_kif("(=> (equal ?QUANTITY (MeasureFn ?NUMBER Coulomb)) (instance ?QUANTITY TimeDependentQuantity))").
% :- assert_kif("; Electric Potential Units").
:- assert_kif("(instance Volt CompositeUnitOfMeasure)").
:- assert_kif("(instance Volt SystemeInternationalUnit)").
:- assert_kif("(documentation Volt EnglishLanguage \"SI electric potential measure. Symbol: V. It is the difference of electric potential between two points of a conducting wire carrying a constant current of 1 &%Ampere, when the power dissipated between these points is equal to 1 &%Watt. &%Volt = W/A = m^2*kg*s^(-3)*A^(-1).\")").
% :- assert_kif("; Capacitance Units").
:- assert_kif("(instance Farad CompositeUnitOfMeasure)").
:- assert_kif("(instance Farad SystemeInternationalUnit)").
:- assert_kif("(documentation Farad EnglishLanguage \"SI capacitance measure. Symbol: F. It is the capacitance of a capacitator between the plates of which there appears a difference of potential of 1 &%Volt when it is charged by a quantity of electricity equal to 1 Coulomb. &%Farad = C/V = m^(-2)*kg(-1)*s^4*A^2.\")").
:- assert_kif(" Electric Resistance Units").
:- assert_kif("(instance Ohm CompositeUnitOfMeasure)").
:- assert_kif("(instance Ohm SystemeInternationalUnit)").
:- assert_kif("(documentation Ohm EnglishLanguage \"SI electric resistance measure. It is the electric resistance between two points of a conductor when a constant difference of potential of 1 &%Volt, applied between these two points, produces in this conductor a current of 1 &%Ampere, this conductor not being the force of any electromotive force. &%Ohm = V/A = m^2*kg*s^(-3)*A^(-2).\")").
% :- assert_kif("; Electric Conductance Units").
:- assert_kif("(instance Siemens CompositeUnitOfMeasure)").
:- assert_kif("(instance Siemens SystemeInternationalUnit)").
:- assert_kif("(documentation Siemens EnglishLanguage \"SI electric conductance measure. Symbol: S. In the case of direct current, the conductance in &%Siemens is the reciprocal of the resistance in &%Ohms, in the case of alternating current, it is the reciprocal of the impedance in ohms. siemens = A/V = m^(-2)*kg(-1)*s^(3)*A^2.\")").
% :- assert_kif("; Magnetic Flux Units").
:- assert_kif("(instance Weber CompositeUnitOfMeasure)").
:- assert_kif("(instance Weber SystemeInternationalUnit)").
:- assert_kif("(documentation Weber EnglishLanguage \"SI magnetic flux measure. Symbol: Wb. It is the magnetic flux which, linking a circuit of one turn, produces in it an electromotive force of 1 &%Volt as it is reduced to zero at a uniform rate in 1 &%SecondDuration. &%Weber = V*s = m^2*kg*s^(-2)*A^(-1).\" )").
% :- assert_kif("; Magnetic Flux Density Units").
:- assert_kif("(instance Tesla CompositeUnitOfMeasure)").
:- assert_kif("(instance Tesla SystemeInternationalUnit)").
:- assert_kif("(documentation Tesla EnglishLanguage \"SI magnetic flux density measure. Symbol: T. One &%Tesla equals one &%Weber per square &%Meter. &%Tesla = Wb/m^2 = kg*s^(-2)*A^(-1).\")").
% :- assert_kif("; Inductance Units").
:- assert_kif("(instance Henry CompositeUnitOfMeasure)").
:- assert_kif("(instance Henry SystemeInternationalUnit)").
:- assert_kif("(documentation Henry EnglishLanguage \"SI inductance measure. Symbol: H. One &%Henry is equivalent to one &%Volt divided by one &%Ampere per &%SecondDuration. If a current changing at the rate of one &%Ampere per &%SecondDuration induces an electromotive force of one &%Volt, the circuit has an inductance of one &%Henry. &%Henry = Wb/A = m^2*kg*s^(-2)*A^(-2).\")").
% :- assert_kif("; Celsius Temperature unit").
:- assert_kif("(instance CelsiusDegree UnitOfTemperature)").
:- assert_kif("(instance CelsiusDegree SystemeInternationalUnit)").
:- assert_kif("(documentation CelsiusDegree EnglishLanguage \"A &%TemperatureMeasure. The freezing point and the boiling point of water are, respectively, 0 &%CelsiusDegrees and 100 &%CelsiusDegrees.\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER CelsiusDegree) (MeasureFn (SubtractionFn ?NUMBER 273.15) KelvinDegree)))").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER CelsiusDegree) (MeasureFn (DivisionFn (SubtractionFn ?NUMBER 32) 1.8) FahrenheitDegree)))").
% :- assert_kif("; Luminous Flux Units").
:- assert_kif("(instance Lumen CompositeUnitOfMeasure)").
:- assert_kif("(instance Lumen SystemeInternationalUnit)").
:- assert_kif("(documentation Lumen EnglishLanguage \"SI luminous flux measure. Symbol: lm. It is the amount streaming outward through one solid angle of 1 &%Steradian from a uniform point source having an intensity of one &%Candela. &%Lumen = cd*sr = cd * 1.\")").
% :- assert_kif("; Illuminance Units").
:- assert_kif("(instance Lux CompositeUnitOfMeasure)").
:- assert_kif("(instance Lux SystemeInternationalUnit)").
:- assert_kif("(documentation Lux EnglishLanguage \"SI illuminance measure. Symbol: lx. It is the amount of illumination provided when one &%Lumen is evenly distributed over an area of 1 square &%Meter. This is also equivalent to the illumination that would exist on a surface all points of which are one &%Meter from a point source of one &%Candela. &%Lux = lm/m^2 = m^(-2)*cd.\")").
% :- assert_kif("; Activity Units").
:- assert_kif("(instance Becquerel CompositeUnitOfMeasure)").
:- assert_kif("(instance Becquerel SystemeInternationalUnit)").
:- assert_kif("(documentation Becquerel EnglishLanguage \"SI activity measure. Symbol: Bq. It measures the amount of radioactivity contained in a given sample of matter. It is that quantity of a radioactive element in which there is one atomic disintegration per &%SecondDuration. &%Becquerel = s^(-1).\")").
:- assert_kif("(=> (equal ?QUANTITY (MeasureFn ?NUMBER Becquerel)) (instance ?QUANTITY TimeDependentQuantity))").
% :- assert_kif("; Absorbed Dose Units").
:- assert_kif("(instance Gray CompositeUnitOfMeasure)").
:- assert_kif("(instance Gray SystemeInternationalUnit)").
:- assert_kif("(documentation Gray EnglishLanguage \"SI absorbed dose measure. Symbol: Gy. It measures the dose of radiation absorbed in living tissue. It is equal approximately to the absorbed dose delivered when the energy per unit mass imparted to matter by ionizing radiation is 1 &%Joule per kilogram. &%Gray = J/kg = m^2*s^(-2).\")").
% :- assert_kif("; Dose Equivalent Units").
:- assert_kif("(instance Sievert CompositeUnitOfMeasure)").
:- assert_kif("(instance Sievert SystemeInternationalUnit)").
:- assert_kif("(documentation Sievert EnglishLanguage \"SI dose equivalent measure. Symbol: Sv. It is a unit of biologic dose of ionizing radiation. The &%Sievert makes it possible to normalize doses of different types of radiation. It takes into account the relative biologic effectiveness of ionizing radiation, since each form of such radiation--e.g., X rays, gamma rays, neutrons-- has a slightly different effect on living tissue for a given absorbed dose. The dose equivalent of a given type of radiation (in &%Sievert) is the dose of the radiation in &%Gray multiplied by a quality factor that is based on the relative biologic effectiveness of the radiation. Accordingly, one &%Sievert is generally defined as the amount of radiation roughly equivalent in biologic effectiveness to one &%Gray of gamma radiation. &%Sievert = J/kg = m^2*s^(-2)\")").
% :- assert_kif("; Units that are accepted for -use- with SI").
:- assert_kif("(instance DayDuration UnitOfDuration)").
:- assert_kif("(documentation DayDuration EnglishLanguage \"Time unit. 1 day = 24 hours.\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER DayDuration) (MeasureFn (MultiplicationFn ?NUMBER 24) HourDuration)))").
:- assert_kif("(instance HourDuration UnitOfDuration)").
:- assert_kif("(documentation HourDuration EnglishLanguage \"Time unit. 1 hour = 60 minutes.\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER HourDuration) (MeasureFn (MultiplicationFn ?NUMBER 60) MinuteDuration)))").
:- assert_kif("(instance MinuteDuration UnitOfDuration)").
:- assert_kif("(documentation MinuteDuration EnglishLanguage \"Time unit. 1 minute = 60 seconds. \")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER MinuteDuration) (MeasureFn (MultiplicationFn ?NUMBER 60) SecondDuration)))").
:- assert_kif("(instance WeekDuration UnitOfDuration)").
:- assert_kif("(documentation WeekDuration EnglishLanguage \"Time unit. A week's duration is seven days.\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER WeekDuration) (MeasureFn (MultiplicationFn ?NUMBER 7) DayDuration)))").
:- assert_kif("(instance MonthDuration UnitOfDuration)").
:- assert_kif("(documentation MonthDuration EnglishLanguage \"Time unit. A month's duration is at least 28 days, and no more than 31 days. Note that this unit is a range, rather than an exact amount, unlike most other units.\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (greaterThanOrEqualTo (MeasureFn ?NUMBER MonthDuration) (MeasureFn (MultiplicationFn ?NUMBER 28) DayDuration)))").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (lessThanOrEqualTo (MeasureFn ?NUMBER MonthDuration) (MeasureFn (MultiplicationFn ?NUMBER 31) DayDuration)))").
:- assert_kif("(instance YearDuration UnitOfDuration)").
:- assert_kif("(documentation YearDuration EnglishLanguage \"Time unit. one calendar year. 1 year = 365 days = 31536000 seconds.\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER YearDuration) (MeasureFn (MultiplicationFn ?NUMBER 365) DayDuration)))").
% :- assert_kif("; What follows are units that are also accepted for use with SI. The SI equivalents for these units are obtained experimentally.").
:- assert_kif("(instance Amu UnitOfMass)").
:- assert_kif("(documentation Amu EnglishLanguage \"Atomic mass unit. Symbol: u. It is the mass of the twelfth part of an atom of the Carbon 12 isotope.\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER Amu) (MeasureFn (MultiplicationFn ?NUMBER 1.6605402E-24) Gram)))").
:- assert_kif("(instance ElectronVolt CompositeUnitOfMeasure)").
:- assert_kif("(documentation ElectronVolt EnglishLanguage \"The &%ElectronVolt is an energy measure. Symbol: eV. It is the kinetic energy acquired by an electron in passing through a potential difference of 1 &%Volt in a vacuum.\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER ElectronVolt) (MeasureFn (MultiplicationFn ?NUMBER 1.60217733E-19) Joule)))").
% :- assert_kif("; The following units have been temporarily accepted for use with SI units.").
:- assert_kif("(instance Angstrom UnitOfLength)").
:- assert_kif("(documentation Angstrom EnglishLanguage \"The &%Angstrom is a &%LengthMeasure. 1 &%Angstrom = 10^(-10) m\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER Angstrom) (MeasureFn (MultiplicationFn ?NUMBER 1.0E-10) Meter)))").
% :- assert_kif("; The following units are unacceptable in SI but are part of other systems of measurement that are widely used.").
% :- assert_kif("; More Length units").
:- assert_kif("(instance FootLength UnitOfLength)").
:- assert_kif("(documentation FootLength EnglishLanguage \"English length unit of feet.\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER FootLength) (MeasureFn (MultiplicationFn ?NUMBER 0.3048) Meter)))").
:- assert_kif("(instance Inch UnitOfLength)").
:- assert_kif("(documentation Inch EnglishLanguage \"English length unit of inches.\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER Inch) (MeasureFn (MultiplicationFn ?NUMBER 0.0254) Meter)))").
:- assert_kif("(instance Mile UnitOfLength)").
:- assert_kif("(documentation Mile EnglishLanguage \"English length unit of miles.\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER Mile) (MeasureFn (MultiplicationFn ?NUMBER 1609.344) Meter)))").
% :- assert_kif("; More Volume units").
:- assert_kif("(instance UnitedStatesGallon UnitOfVolume)").
:- assert_kif("(relatedInternalConcept UnitedStatesGallon UnitedKingdomGallon)").
:- assert_kif("(documentation UnitedStatesGallon EnglishLanguage \"Unit of volume commonly used in the United States.\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER UnitedStatesGallon) (MeasureFn (MultiplicationFn ?NUMBER 3.785411784) Liter)))").
:- assert_kif("(instance Quart UnitOfVolume)").
:- assert_kif("(documentation Quart EnglishLanguage \"English unit of volume equal to 1/4 of a &%UnitedStatesGallon.\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER Quart) (MeasureFn (DivisionFn ?NUMBER 4) UnitedStatesGallon)))").
:- assert_kif("(instance Pint UnitOfVolume)").
:- assert_kif("(documentation Pint EnglishLanguage \"English unit of volume equal to 1/2 of a &%Quart.\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER Pint) (MeasureFn (DivisionFn ?NUMBER 2) Quart)))").
:- assert_kif("(instance Cup UnitOfVolume)").
:- assert_kif("(documentation Cup EnglishLanguage \"English unit of volume equal to 1/2 of a &%Pint.\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER Cup) (MeasureFn (DivisionFn ?NUMBER 2) Pint)))").
:- assert_kif("(instance Ounce UnitOfVolume)").
:- assert_kif("(documentation Ounce EnglishLanguage \"English unit of volume equal to 1/8 of a &%Cup.\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER Ounce) (MeasureFn (DivisionFn ?NUMBER 8) Cup)))").
:- assert_kif("(instance UnitedKingdomGallon UnitOfVolume)").
:- assert_kif("(documentation UnitedKingdomGallon EnglishLanguage \"Unit of volume commonly used in the United Kingdom.\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER UnitedKingdomGallon) (MeasureFn (MultiplicationFn ?NUMBER 4.54609) Liter)))").
% :- assert_kif("; More Mass units").
:- assert_kif("(instance AtomGram UnitOfMass)").
:- assert_kif("(documentation AtomGram EnglishLanguage \"&%MassMeasure that is also known as the gram-atom. Defined as the mass in grams of 1 &%Mole of pure substance. For example, 1 &%AtomGram of Carbon 12 will be 12 &%Grams of pure Carbon 12. 2 &%AtomGrams of the same substance will be 24 &%Grams of it. This is an unusual unit in that it is essentially 1 &%Mole of 'stuff' measured in grams, so that the actual value (i.e. mass) depends on the type of substance.\")").
:- assert_kif("(documentation Kilogram EnglishLanguage \"Supermultiple of &%Gramm. Symbol: kg. 1 &%Kilogram = 1000 Grams.\")").
:- assert_kif("(instance Kilogram SystemeInternationalUnit)").
:- assert_kif("(instance Kilogram UnitOfMass)").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER Kilogram) (MeasureFn (MultiplicationFn ?NUMBER 1000) Gram)))").
:- assert_kif("(domain weight 1 SelfConnectedObject)").
:- assert_kif("(domain weight 2 MassMeasure)").
:- assert_kif("(instance weight BinaryPredicate)").
:- assert_kif("(subrelation weight measure)").
:- assert_kif("(documentation weight EnglishLanguage \"(&%weight ?O ?MM) means that on planet earth the &%SelfConnectedObject ?O has the weight ?MM.\")").
:- assert_kif("(instance PoundMass UnitOfMass)").
:- assert_kif("(documentation PoundMass EnglishLanguage \"English mass unit of pounds.\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER PoundMass) (MeasureFn (MultiplicationFn ?NUMBER 453.59237) Gram)))").
:- assert_kif("(instance Slug UnitOfMass)").
:- assert_kif("(documentation Slug EnglishLanguage \"English mass unit of slugs.\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER Slug) (MeasureFn (MultiplicationFn ?NUMBER 14593.90) Gram)))").
% :- assert_kif("; More Temperature units").
:- assert_kif("(instance RankineDegree UnitOfTemperature)").
:- assert_kif("(documentation RankineDegree EnglishLanguage \"A &%TemperatureMeasure. Note that 0 &%RankineDegrees is the same as the absolute zero (i.e. 0 &%KelvinDegrees).\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER RankineDegree) (MeasureFn (MultiplicationFn ?NUMBER 1.8) KelvinDegree)))").
:- assert_kif("(instance FahrenheitDegree UnitOfTemperature)").
:- assert_kif("(documentation FahrenheitDegree EnglishLanguage \"A &%UnitOfTemperature that is commonly used in the United States. On the Fahrenheit scale, the freezing point of water is 32 &%FahrenheitDegrees, and the boiling point of water is 212 &%FahrenheitDegrees.\")").
% :- assert_kif("; More Force units").
:- assert_kif("(instance PoundForce CompositeUnitOfMeasure)").
:- assert_kif("(documentation PoundForce EnglishLanguage \"English pound of force. The conversion factor depends on the local value of the acceleration of free fall. A mean value is used in the conversion axiom associated with this constant.\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER PoundForce) (MeasureFn (MultiplicationFn ?NUMBER 4.448222) Newton)))").
% :- assert_kif("; More Energy units").
:- assert_kif("(instance Calorie CompositeUnitOfMeasure)").
:- assert_kif("(documentation Calorie EnglishLanguage \"A &%Calorie is an energy measure.\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER Calorie) (MeasureFn (MultiplicationFn ?NUMBER 4.1868) Joule)))").
:- assert_kif("(instance BritishThermalUnit CompositeUnitOfMeasure)").
:- assert_kif("(documentation BritishThermalUnit EnglishLanguage \"An energy measure.\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER BritishThermalUnit) (MeasureFn (MultiplicationFn ?NUMBER 1055.05585262) Joule)))").
% :- assert_kif("; More plane angle units").
:- assert_kif("(instance AngularDegree UnitOfAngularMeasure)").
:- assert_kif("(documentation AngularDegree EnglishLanguage \"A plane angle measure.\")").
:- assert_kif("(=> (equal ?QUANT (MeasureFn ?N AngularDegree)) (instance ?QUANT PlaneAngleMeasure))").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER AngularDegree) (MeasureFn (MultiplicationFn ?NUMBER (DivisionFn Pi 180)) Radian)))").
:- assert_kif("(=> (measure ?ANGLE (MeasureFn ?NUMBER AngularDegree)) (and (greaterThanOrEqualTo ?NUMBER 0) (lessThanOrEqualTo ?NUMBER 360)))").
:- assert_kif("(equal (MeasureFn 0 AngularDegree) (MeasureFn 360 AngularDegree))").
% :- assert_kif("; Other interesting units of measure").
% :- assert_kif("; Currency units").
:- assert_kif("(instance UnitedStatesDollar UnitOfCurrency)").
:- assert_kif("(documentation UnitedStatesDollar EnglishLanguage \"A currency measure.\")").
:- assert_kif("(instance UnitedStatesCent UnitOfCurrency)").
:- assert_kif("(documentation UnitedStatesCent EnglishLanguage \"A currency measure. 1 &%UnitedStatesCent is equal to .01 &%UnitedStatesDollars.\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER UnitedStatesCent) (MeasureFn (MultiplicationFn ?NUMBER 0.01) UnitedStatesDollar)))").
:- assert_kif("(instance EuroDollar UnitOfCurrency)").
:- assert_kif("(documentation EuroDollar EnglishLanguage \"A currency measure of most European Union countries.\")").
:- assert_kif("(instance EuroCent UnitOfCurrency)").
:- assert_kif("(documentation EuroCent EnglishLanguage \"A currency measure. 1 &%EuroCent is equal to .01 &%EuroDollars.\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER EuroCent) (MeasureFn (MultiplicationFn ?NUMBER 0.01) EuroDollar)))").
% :- assert_kif("; Information units").
:- assert_kif("(subclass InformationMeasure ConstantQuantity)").
:- assert_kif("(documentation InformationMeasure EnglishLanguage \"Measures of the amount of information. Includes &%Bit, &%Byte, and multiples of these, e.g. &%KiloByte and &%MegaByte.\")").
:- assert_kif("(instance Bit UnitOfInformation)").
:- assert_kif("(documentation Bit EnglishLanguage \"One &%Bit of information. A one or a zero.\")").
:- assert_kif("(instance Byte UnitOfInformation)").
:- assert_kif("(documentation Byte EnglishLanguage \"One &%Byte of information. A &%Byte is eight &%Bits.\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER Byte) (MeasureFn (MultiplicationFn ?NUMBER 8) Bit)))").
:- assert_kif("(instance KiloByte UnitOfInformation)").
:- assert_kif("(documentation KiloByte EnglishLanguage \"One &%KiloByte (KB) of information. One &%KiloByte is 1024 &%Bytes. Note that this sense of 'kilo' is different from the one accepted in the SI system.\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER KiloByte) (MeasureFn (MultiplicationFn ?NUMBER 1024) Byte)))").
:- assert_kif("(instance MegaByte UnitOfInformation)").
:- assert_kif("(documentation MegaByte EnglishLanguage \"One &%MegaByte (MB) of information. One &%MegaByte is 1024 &%KiloBytes. Note that this sense of 'mega' is different from the one accepted in the SI system.\")").
:- assert_kif("(=> (equal ?NUMBER (MultiplicationFn 1 ?NUMBER)) (equal (MeasureFn ?NUMBER MegaByte) (MeasureFn (MultiplicationFn ?NUMBER 1024) KiloByte)))").
% :- assert_kif("; The following content was inspired by the Quantities ontology developed by ITBM-CNR.").
:- assert_kif("(instance measure BinaryPredicate)").
:- assert_kif("(instance measure AsymmetricRelation)").
:- assert_kif("(domain measure 1 Object)").
:- assert_kif("(domain measure 2 PhysicalQuantity)").
:- assert_kif("(documentation measure EnglishLanguage \"A very general &%Predicate for asserting that a particular &%Object is measured by a particular &%PhysicalQuantity. In general, the second argument of this &%Predicate will be a term produced with the &%Function &%MeasureFn.\")").
:- assert_kif("(instance age SingleValuedRelation)").
:- assert_kif("(subrelation age measure)").
:- assert_kif("(domain age 2 TimeDuration)").
:- assert_kif("(documentation age EnglishLanguage \"Simply relates an &%Object to a &%ConstantQuantity specifying the age of the &%Object.\")").
:- assert_kif("(=> (and (instance ?TIME TimePoint) (holdsDuring ?TIME (age ?OBJ ?DURATION))) (duration (TimeIntervalFn (BeginFn (WhenFn ?OBJ)) ?TIME) ?DURATION))").
:- assert_kif("(subrelation linearExtent measure)").
:- assert_kif("(domain linearExtent 2 LengthMeasure)").
:- assert_kif("(documentation linearExtent EnglishLanguage \"&%BinaryPredicate that is used to state the measure of an &%Object from one point to another point along its surface. Note that the difference between the predicates &%length and &%distance is that the &%length is used to state the &%LengthMeasure of one of the dimensions of a single object, while &%distance is used to state the &%LengthMeasure that separates two distinct objects.\")").
:- assert_kif("(instance width SingleValuedRelation)").
:- assert_kif("(subrelation width linearExtent)").
:- assert_kif("(documentation width EnglishLanguage \"&%BinaryPredicate that is used to state the measure of an &%Object from side to side at its widest span.\")").
:- assert_kif("(subrelation height linearExtent)").
:- assert_kif("(domain height 1 SelfConnectedObject)").
:- assert_kif("(domain height 2 LengthMeasure)").
:- assert_kif("(documentation height EnglishLanguage \"The height of an &%Object is the distance between its &%top and its &%bottom.\")").
:- assert_kif("(instance length SingleValuedRelation)").
:- assert_kif("(subrelation length linearExtent)").
:- assert_kif("(documentation length EnglishLanguage \"&%BinaryPredicate that is used to state the measure of an &%Object along its longest span.\")").
:- assert_kif("(=> (length ?O ?M) (not (exists (?M2) (and (linearExtent ?O ?M2) (greaterThan ?M2 ?M)))))").
:- assert_kif("(subclass Oval ClosedTwoDimensionalFigure)").
:- assert_kif("(documentation Oval EnglishLanguage \"The class of &%ClosedTwoDimensionalFigures that are produced by the intersection of a &%Cone with a &%ClosedTwoDimensionalFigure.\")").
:- assert_kif("(subclass Circle Oval)").
:- assert_kif("(documentation Circle EnglishLanguage \"The class of &%Ovals such that all &%GeometricPoints that make up the &%Circle are equidistant from a single &%GeometricPoint, known as the center of the &%Circle.\")").
:- assert_kif("(=> (instance ?C Circle) (exists (?R) (radius ?C ?R)))").
:- assert_kif("(=> (instance ?C Circle) (exists (?P) (equal (CenterOfCircleFn ?C) ?P)))").
:- assert_kif("(documentation CenterOfCircleFn EnglishLanguage \"(CenterOfCircleFn ?CIRCLE) denotes the &%GeometricPoint that is the center of the &%Circle ?CIRCLE.\")").
:- assert_kif("(instance CenterOfCircleFn UnaryFunction)").
:- assert_kif("(instance CenterOfCircleFn TotalValuedRelation)").
:- assert_kif("(domain CenterOfCircleFn 1 Circle)").
:- assert_kif("(range CenterOfCircleFn GeometricPoint)").
:- assert_kif("(instance radius BinaryPredicate)").
:- assert_kif("(instance radius SingleValuedRelation)").
:- assert_kif("(instance radius TotalValuedRelation)").
:- assert_kif("(domain radius 1 Circle)").
:- assert_kif("(domain radius 2 LengthMeasure)").
:- assert_kif("(documentation radius EnglishLanguage \"(&%radius ?CIRCLE ?LENGTH) means that the radius of the &%Circle ?CIRCLE has a length of ?LENGTH.\")").
:- assert_kif("(=> (radius ?CIRCLE ?RADIUS) (exists (?POINT) (forall (?PART) (=> (pointOfFigure ?PART ?CIRCLE) (geometricDistance ?PART ?POINT ?RADIUS)))))").
:- assert_kif("(subrelation diameter width)").
:- assert_kif("(instance diameter BinaryPredicate)").
:- assert_kif("(instance diameter SingleValuedRelation)").
:- assert_kif("(instance diameter TotalValuedRelation)").
:- assert_kif("(domain diameter 1 Circle)").
:- assert_kif("(domain diameter 2 LengthMeasure)").
:- assert_kif("(documentation diameter EnglishLanguage \"(&%diameter ?CIRCLE ?LENGTH) means that the diameter of the &%Circle ?CIRCLE has a length of ?LENGTH.\")").
:- assert_kif("(=> (diameter ?CIRCLE ?LENGTH) (exists (?HALF) (and (radius ?CIRCLE ?HALF) (equal (MultiplicationFn ?HALF 2) ?LENGTH))))").
:- assert_kif("(instance distance SingleValuedRelation)").
:- assert_kif("(instance distance SpatialRelation)").
:- assert_kif("(instance distance TernaryPredicate)").
:- assert_kif("(domain distance 1 Physical)").
:- assert_kif("(domain distance 2 Physical)").
:- assert_kif("(domain distance 3 LengthMeasure)").
:- assert_kif("(documentation distance EnglishLanguage \"(&%distance ?OBJ1 ?OBJ2 ?QUANT) means that the shortest distance between the two objects ?OBJ1 and ?OBJ2 is ?QUANT. Note that the difference between the predicates &%length and &%distance is that the &%length is used to state the &%LengthMeasure of one of the dimensions of a single object, while &%distance is used to state the &%LengthMeasure that separates two distinct objects.\")").
:- assert_kif("(=> (distance ?OBJ1 ?OBJ2 ?QUANT) (distance ?OBJ2 ?OBJ1 ?QUANT))").
:- assert_kif("(subrelation altitude distance)").
:- assert_kif("(instance altitude SingleValuedRelation)").
:- assert_kif("(documentation altitude EnglishLanguage \"A &%TernaryPredicate that is used to state the &%distance between the &%top of an &%Object and another point that is below the &%top of the &%Object (often this other point will be sea level). Note that this &%Predicate can be used to specify, for example, the height of geographic features, e.g. mountains, the altitude of aircraft, and the orbit of satellites around the Earth.\")").
:- assert_kif("(=> (altitude ?OBJ1 ?OBJ2 ?HEIGHT) (orientation ?OBJ1 ?OBJ2 Above))").
:- assert_kif("(=> (altitude ?OBJ1 ?OBJ2 ?HEIGHT) (exists (?TOP) (and (top ?TOP ?OBJ1) (distance ?TOP ?OBJ2 ?HEIGHT))))").
:- assert_kif("(subrelation depth distance)").
:- assert_kif("(instance depth SingleValuedRelation)").
:- assert_kif("(documentation depth EnglishLanguage \"A &%TernaryPredicate that is used to state the &%distance between the &%top of an &%Object and another point that is above the &%top of the &%Object (often this other point will be sea level). Note that this &%Predicate can be used to specify, for example, the depth of marine life or submarines, for example.\")").
:- assert_kif("(=> (depth ?OBJ1 ?OBJ2 ?DEPTH) (orientation ?OBJ1 ?OBJ2 Below))").
:- assert_kif("(=> (depth ?OBJ1 ?OBJ2 ?DEPTH) (exists (?BOTTOM) (and (bottom ?BOTTOM ?OBJ1) (distance ?BOTTOM ?OBJ2 ?DEPTH))))").
:- assert_kif("(instance larger BinaryPredicate)").
:- assert_kif("(instance larger SpatialRelation)").
:- assert_kif("(instance larger TransitiveRelation)").
:- assert_kif("(instance larger IrreflexiveRelation)").
:- assert_kif("(domain larger 1 Object)").
:- assert_kif("(domain larger 2 Object)").
:- assert_kif("(documentation larger EnglishLanguage \"(&%larger ?OBJ1 ?OBJ2) means that ?OBJ1 is larger, with respect to all &%LengthMeasures, than ?OBJ2.\")").
:- assert_kif("(<=> (larger ?OBJ1 ?OBJ2) (forall (?QUANT1 ?QUANT2 ?UNIT) (=> (and (measure ?OBJ1 (MeasureFn ?QUANT1 ?UNIT)) (measure ?OBJ2 (MeasureFn ?QUANT2 ?UNIT)) (instance ?UNIT UnitOfLength)) (greaterThan ?QUANT1 ?QUANT2))))").
:- assert_kif("(instance smaller BinaryPredicate)").
:- assert_kif("(instance smaller SpatialRelation)").
:- assert_kif("(instance smaller TransitiveRelation)").
:- assert_kif("(instance smaller IrreflexiveRelation)").
:- assert_kif("(domain smaller 1 Object)").
:- assert_kif("(domain smaller 2 Object)").
:- assert_kif("(inverse smaller larger)").
:- assert_kif("(documentation smaller EnglishLanguage \"(&%smaller ?OBJ1 ?OBJ2) means that ?OBJ1 is smaller, with respect to all &%LengthMeasures, than ?OBJ2.\")").
:- assert_kif("(instance monetaryValue SingleValuedRelation)").
:- assert_kif("(subrelation monetaryValue measure)").
:- assert_kif("(domain monetaryValue 1 Physical)").
:- assert_kif("(domain monetaryValue 2 CurrencyMeasure)").
:- assert_kif("(documentation monetaryValue EnglishLanguage \"A &%BinaryPredicate that associates an &%Object or &%Process with its value expressed as an instance of &%CurrencyMeasure.\")").
:- assert_kif("(instance WealthFn UnaryFunction)").
:- assert_kif("(domain WealthFn 1 Agent)").
:- assert_kif("(range WealthFn CurrencyMeasure)").
:- assert_kif("(documentation WealthFn EnglishLanguage \"A &%UnaryFunction that maps an &%Agent to a &%CurrencyMeasure specifying the value of the property owned by the &%Agent. Note that this &%Function is generally used in conjunction with the &%Function &%PropertyFn, e.g. (&%WealthFn (&%PropertyFn BillGates)) would return the monetary value of the sum of Bill Gates' holdings.\")").
:- assert_kif("(<=> (equal (WealthFn ?PERSON) ?AMOUNT) (monetaryValue (PropertyFn ?PERSON) ?AMOUNT))").
:- assert_kif("(instance barometricPressure BinaryPredicate)").
:- assert_kif("(instance barometricPressure AsymmetricRelation)").
:- assert_kif("(subrelation barometricPressure measure)").
:- assert_kif("(domain barometricPressure 1 Object)").
:- assert_kif("(domain barometricPressure 2 UnitOfAtmosphericPressure)").
:- assert_kif("(documentation barometricPressure EnglishLanguage \"(&%barometricPressure ?AREA ?PRESSURE) means that the atmospheric pressure measured at ?AREA is ?PRESSURE. Barometric pressure is typically expressed in units of &%InchMercury or &%MmMercury. For example, standard sea level pressure is 29.92 inches (760 mm) of mercury:"). (&%barometricPressure &%SeaLevel (&%MeasureFn 29.92 &%InchMercury)).\")").
:- assert_kif("(subclass UnitOfAtmosphericPressure CompositeUnitOfMeasure)").
:- assert_kif("(documentation UnitOfAtmosphericPressure EnglishLanguage \"&%UnitOfAtmosphericPressure includes those instances of &%UnitOfMeasure used to measure atmospheric pressure (&%barometricPressure), e.g., &%InchMercury.\")").
:- assert_kif("(instance InchMercury UnitOfAtmosphericPressure)").
:- assert_kif("(documentation InchMercury EnglishLanguage \"&%InchMercury is a &%UnitOfMeasure for &%barometricPressure. It is used to express the number of inches of mercury supported in a mercurial barometer by the surrounding air pressure.\")").
:- assert_kif("(instance MmMercury UnitOfAtmosphericPressure)").
:- assert_kif("(documentation MmMercury EnglishLanguage \"&%MmMercury is a &%UnitOfMeasure for &%barometricPressure. It is used to express the number of millimeters of mercury supported in a mercurial barometer by the surrounding air pressure.\")").
% :- assert_kif("; END FILE").
% :- assert_kif("; BEGIN FILE").
% :- assert_kif(";  TEMPORAL CONCEPTS  ").
% :- assert_kif("; INCLUDES 'STRUCTURAL ONTOLOGY' INCLUDES 'BASE ONTOLOGY'").
% :- assert_kif("; The first part of this section contains definitions relations involving temporal notions. Most of these definitions and axioms were derived from the work of James Allen. This part of the section was extensively revised on the basis of comments from Pat Hayes. The second part of this section is an attempt to incorporate the Simple-Time ontology from the Ontolingua server into the SUMO.").
:- assert_kif("(instance PositiveInfinity TimePoint)").
:- assert_kif("(documentation PositiveInfinity EnglishLanguage \"The &%TimePoint that is after all other &%TimePoints.\")").
:- assert_kif("(=> (and (instance ?POINT TimePoint) (not (equal ?POINT PositiveInfinity))) (before ?POINT PositiveInfinity))").
:- assert_kif("(=> (and (instance ?POINT TimePoint) (not (equal ?POINT PositiveInfinity))) (exists (?OTHERPOINT) (temporallyBetween ?POINT ?OTHERPOINT PositiveInfinity)))").
:- assert_kif("(instance NegativeInfinity TimePoint)").
:- assert_kif("(documentation NegativeInfinity EnglishLanguage \"The &%TimePoint that is before all other &%TimePoints.\")").
:- assert_kif("(=> (and (instance ?POINT TimePoint) (not (equal ?POINT NegativeInfinity))) (before NegativeInfinity ?POINT))").
:- assert_kif("(=> (and (instance ?POINT TimePoint) (not (equal ?POINT NegativeInfinity))) (exists (?OTHERPOINT) (temporallyBetween NegativeInfinity ?OTHERPOINT ?POINT)))").
:- assert_kif("(instance duration BinaryPredicate)").
:- assert_kif("(instance duration AsymmetricRelation)").
:- assert_kif("(instance duration TotalValuedRelation)").
:- assert_kif("(domain duration 1 TimeInterval)").
:- assert_kif("(domain duration 2 TimeDuration)").
:- assert_kif("(documentation duration EnglishLanguage \"(&%duration ?POS ?TIME) means that the duration of the &%TimePosition ?POS is ?TIME. Note that this &%Predicate can be used in conjunction with the &%Function &%WhenFn to specify the duration of any instance of &%Physical.\")").
:- assert_kif("(instance frequency BinaryPredicate)").
:- assert_kif("(instance frequency AsymmetricRelation)").
:- assert_kif("(domainSubclass frequency 1 Process)").
:- assert_kif("(domain frequency 2 TimeDuration)").
:- assert_kif("(documentation frequency EnglishLanguage \"(&%frequency ?PROC ?TIME) means that the &%Process type of ?PROC recurs after every interval of ?TIME.\")").
:- assert_kif("(=> (frequency ?PROC ?TIME1) (forall (?TIME2) (=> (duration ?TIME2 ?TIME1) (exists (?POSITION) (and (temporalPart ?POSITION ?TIME2) (holdsDuring ?POSITION (exists (?INST) (instance ?INST ?PROC))))))))").
:- assert_kif("(instance temporalPart BinaryPredicate)").
:- assert_kif("(instance temporalPart TemporalRelation)").
:- assert_kif("(instance temporalPart PartialOrderingRelation)").
:- assert_kif("(domain temporalPart 1 TimePosition)").
:- assert_kif("(domain temporalPart 2 TimePosition)").
:- assert_kif("(documentation temporalPart EnglishLanguage \"The temporal analogue of the spatial &%part predicate. (&%temporalPart ?POS1 ?POS2) means that &%TimePosition ?POS1 is part of &%TimePosition ?POS2. Note that since &%temporalPart is a &%ReflexiveRelation every &%TimePostion is a &%temporalPart of itself.\")").
:- assert_kif("(=> (instance ?POINT TimePoint) (exists (?INTERVAL) (and (instance ?INTERVAL TimeInterval) (temporalPart ?POINT ?INTERVAL))))").
:- assert_kif("(=> (instance ?INTERVAL TimeInterval) (exists (?POINT) (and (instance ?POINT TimePoint) (temporalPart ?POINT ?INTERVAL))))").
:- assert_kif("(=> (and (holdsDuring ?TIME1 ?SITUATION) (temporalPart ?TIME2 ?TIME1)) (holdsDuring ?TIME2 ?SITUATION))").
:- assert_kif("(=> (and (holdsDuring ?INTERVAL (?REL ?INST1 ?INST2)) (instance ?INST1 Physical) (instance ?INST2 Physical)) (and (time ?INST1 ?INTERVAL) (time ?INST2 ?INTERVAL)))").
:- assert_kif("(<=> (temporalPart ?POS (WhenFn ?THING)) (time ?THING ?POS))").
:- assert_kif("(instance BeginFn TemporalRelation)").
:- assert_kif("(instance BeginFn UnaryFunction)").
:- assert_kif("(instance BeginFn TotalValuedRelation)").
:- assert_kif("(domain BeginFn 1 TimeInterval)").
:- assert_kif("(range BeginFn TimePoint)").
:- assert_kif("(documentation BeginFn EnglishLanguage \"A &%UnaryFunction that maps a &%TimeInterval to the &%TimePoint at which the interval begins.\")").
:- assert_kif("(=> (origin ?PROCESS ?OBJ) (eventLocated (WhereFn ?PROCESS (BeginFn (WhenFn ?PROCESS))) (WhereFn ?OBJ (BeginFn (WhenFn ?OBJ)))))").
:- assert_kif("(=> (equal (BeginFn ?INTERVAL) ?POINT) (forall (?OTHERPOINT) (=> (and (temporalPart ?OTHERPOINT ?INTERVAL) (not (equal ?OTHERPOINT ?POINT))) (before ?POINT ?OTHERPOINT))))").
:- assert_kif("(instance EndFn TemporalRelation)").
:- assert_kif("(instance EndFn UnaryFunction)").
:- assert_kif("(instance EndFn TotalValuedRelation)").
:- assert_kif("(domain EndFn 1 TimeInterval)").
:- assert_kif("(range EndFn TimePoint)").
:- assert_kif("(documentation EndFn EnglishLanguage \"A &%UnaryFunction that maps a &%TimeInterval to the &%TimePoint at which the interval ends.\")").
:- assert_kif("(=> (equal (EndFn ?INTERVAL) ?POINT) (forall (?OTHERPOINT) (=> (and (temporalPart ?OTHERPOINT ?INTERVAL) (not (equal ?OTHERPOINT ?POINT))) (before ?OTHERPOINT ?POINT))))").
:- assert_kif("(=> (and (resource ?PROC ?OBJ) (holdsDuring (BeginFn (WhenFn ?PROC)) (measure ?OBJ ?QUANT1)) (holdsDuring (EndFn (WhenFn ?PROC)) (measure ?OBJ ?QUANT2))) (greaterThan ?QUANT1 ?QUANT2))").
:- assert_kif("(subrelation starts temporalPart)").
:- assert_kif("(instance starts TemporalRelation)").
:- assert_kif("(instance starts TransitiveRelation)").
:- assert_kif("(instance starts IrreflexiveRelation)").
:- assert_kif("(domain starts 1 TimeInterval)").
:- assert_kif("(domain starts 2 TimeInterval)").
:- assert_kif("(documentation starts EnglishLanguage \"(&%starts ?INTERVAL1 ?INTERVAL2) means that ?INTERVAL1 and ?INTERVAL2 are both &%TimeIntervals that have the same initial &%TimePoint and that ?INTERVAL1 ends before ?INTERVAL2.\")").
:- assert_kif("(<=> (starts ?INTERVAL1 ?INTERVAL2) (and (equal (BeginFn ?INTERVAL1) (BeginFn ?INTERVAL2)) (before (EndFn ?INTERVAL1) (EndFn ?INTERVAL2))))").
:- assert_kif("(subrelation finishes temporalPart)").
:- assert_kif("(instance finishes TemporalRelation)").
:- assert_kif("(instance finishes TransitiveRelation)").
:- assert_kif("(instance finishes IrreflexiveRelation)").
:- assert_kif("(domain finishes 1 TimeInterval)").
:- assert_kif("(domain finishes 2 TimeInterval)").
:- assert_kif("(documentation finishes EnglishLanguage \"(&%finishes ?INTERVAL1 ?INTERVAL2) means that ?INTERVAL1 and ?INTERVAL2 are both &%TimeIntervals that have the same ending &%TimePoint and that ?INTERVAL2 begins before ?INTERVAL1.\")").
:- assert_kif("(<=> (finishes ?INTERVAL1 ?INTERVAL2) (and (before (BeginFn ?INTERVAL2) (BeginFn ?INTERVAL1)) (equal (EndFn ?INTERVAL2) (EndFn ?INTERVAL1))))").
:- assert_kif("(instance before TemporalRelation)").
:- assert_kif("(instance before IrreflexiveRelation)").
:- assert_kif("(instance before TransitiveRelation)").
:- assert_kif("(subrelation before beforeOrEqual)").
:- assert_kif("(relatedInternalConcept before earlier)").
:- assert_kif("(domain before 1 TimePoint)").
:- assert_kif("(domain before 2 TimePoint)").
:- assert_kif("(documentation before EnglishLanguage \"(&%before ?POINT1 ?POINT2) means that ?POINT1 precedes ?POINT2 on the universal timeline.\")").
% :- assert_kif("; An Object exists (and, hence, retains its identity) over time, i.e., an object exists at every point over some interval of time.").
:- assert_kif("(=> (instance ?OBJ Object) (exists (?TIME1 ?TIME2) (and (instance ?TIME1 TimePoint) (instance ?TIME2 TimePoint) (before ?TIME1 ?TIME2) (forall (?TIME) (=> (and (beforeOrEqual ?TIME1 ?TIME) (beforeOrEqual ?TIME ?TIME2)) (time ?OBJ ?TIME))))))").
:- assert_kif("(=> (result ?PROC ?OBJ) (forall (?TIME) (=> (before ?TIME (BeginFn (WhenFn ?PROC))) (not (time ?OBJ ?TIME)))))").
:- assert_kif("(=> (instance ?INTERVAL TimeInterval) (before (BeginFn ?INTERVAL) (EndFn ?INTERVAL)))").
:- assert_kif("(instance beforeOrEqual BinaryPredicate)").
:- assert_kif("(instance beforeOrEqual TemporalRelation)").
:- assert_kif("(instance beforeOrEqual PartialOrderingRelation)").
:- assert_kif("(domain beforeOrEqual 1 TimePoint)").
:- assert_kif("(domain beforeOrEqual 2 TimePoint)").
:- assert_kif("(documentation beforeOrEqual EnglishLanguage \"(&%beforeOrEqual ?POINT1 ?POINT2) means that ?POINT1 is identical with ?POINT2 or occurs before it on the universal timeline.\")").
:- assert_kif("(=> (beforeOrEqual ?POINT1 ?POINT2) (or (before ?POINT1 ?POINT2) (equal ?POINT1 ?POINT2)))").
:- assert_kif("(instance temporallyBetween TemporalRelation)").
:- assert_kif("(instance temporallyBetween TernaryPredicate)").
:- assert_kif("(subrelation temporallyBetween temporallyBetweenOrEqual)").
:- assert_kif("(domain temporallyBetween 1 TimePoint)").
:- assert_kif("(domain temporallyBetween 2 TimePoint)").
:- assert_kif("(domain temporallyBetween 3 TimePoint)").
:- assert_kif("(documentation temporallyBetween EnglishLanguage \"(&%temporallyBetween ?POINT1 ?POINT2 ?POINT3) means that the &%TimePoint ?POINT2 is between the &%TimePoints ?POINT1 and ?POINT3, i.e. ?POINT1 is before ?POINT2 and ?POINT2 is before ?POINT3.\")").
:- assert_kif("(<=> (temporallyBetween ?POINT1 ?POINT2 ?POINT3) (and (before ?POINT1 ?POINT2) (before ?POINT2 ?POINT3)))").
:- assert_kif("(instance temporallyBetweenOrEqual TemporalRelation)").
:- assert_kif("(instance temporallyBetweenOrEqual TernaryPredicate)").
:- assert_kif("(domain temporallyBetweenOrEqual 1 TimePoint)").
:- assert_kif("(domain temporallyBetweenOrEqual 2 TimePoint)").
:- assert_kif("(domain temporallyBetweenOrEqual 3 TimePoint)").
:- assert_kif("(documentation temporallyBetweenOrEqual EnglishLanguage \"(&%temporallyBetweenOrEqual ?POINT1 ?POINT2 ?POINT3) means that the &%TimePoint ?POINT1 is before or equal to the &%TimePoint ?POINT2 and ?POINT2 is before or equal to the &%TimePoint ?POINT3.\")").
:- assert_kif("(<=> (temporallyBetweenOrEqual ?POINT1 ?POINT2 ?POINT3) (and (beforeOrEqual ?POINT1 ?POINT2) (beforeOrEqual ?POINT2 ?POINT3)))").
:- assert_kif("(<=> (and (time ?PHYS ?TIME) (instance ?TIME TimePoint)) (temporallyBetweenOrEqual (BeginFn (WhenFn ?PHYS)) ?TIME (EndFn (WhenFn ?PHYS))))").
:- assert_kif("(instance overlapsTemporally BinaryPredicate)").
:- assert_kif("(instance overlapsTemporally TemporalRelation)").
:- assert_kif("(instance overlapsTemporally ReflexiveRelation)").
:- assert_kif("(instance overlapsTemporally SymmetricRelation)").
:- assert_kif("(domain overlapsTemporally 1 TimeInterval)").
:- assert_kif("(domain overlapsTemporally 2 TimeInterval)").
:- assert_kif("(documentation overlapsTemporally EnglishLanguage \"(&%overlapsTemporally ?INTERVAL1 ?INTERVAL2) means that the &%TimeIntervals ?INTERVAL1 and ?INTERVAL2 have a &%TimeInterval as a common part.\")").
:- assert_kif("(<=> (overlapsTemporally ?INTERVAL1 ?INTERVAL2) (exists (?INTERVAL3) (and (instance ?INTERVAL3 TimeInterval) (temporalPart ?INTERVAL3 ?INTERVAL1) (temporalPart ?INTERVAL3 ?INTERVAL2))))").
:- assert_kif("(=> (and (instance ?REL BinaryPredicate) (instance ?REL SpatialRelation) (?REL ?OBJ1 ?OBJ2)) (overlapsTemporally (WhenFn ?OBJ1) (WhenFn ?OBJ2)))").
:- assert_kif("(subrelation during temporalPart)").
:- assert_kif("(instance during TransitiveRelation)").
:- assert_kif("(instance during IrreflexiveRelation)").
:- assert_kif("(subrelation during overlapsTemporally)").
:- assert_kif("(domain during 1 TimeInterval)").
:- assert_kif("(domain during 2 TimeInterval)").
:- assert_kif("(documentation during EnglishLanguage \"(&%during ?INTERVAL1 ?INTERVAL2) means that ?INTERVAL1 starts after and ends before ?INTERVAL2.\")").
:- assert_kif("(=> (during ?INTERVAL1 ?INTERVAL2) (and (before (EndFn ?INTERVAL1) (EndFn ?INTERVAL2)) (before (BeginFn ?INTERVAL2) (BeginFn ?INTERVAL1))))").
:- assert_kif("(instance meetsTemporally BinaryPredicate)").
:- assert_kif("(instance meetsTemporally TemporalRelation)").
:- assert_kif("(instance meetsTemporally AsymmetricRelation)").
:- assert_kif("(instance meetsTemporally IntransitiveRelation)").
:- assert_kif("(domain meetsTemporally 1 TimeInterval)").
:- assert_kif("(domain meetsTemporally 2 TimeInterval)").
:- assert_kif("(documentation meetsTemporally EnglishLanguage \"(&%meetsTemporally ?INTERVAL1 ?INTERVAL2) means that the terminal point of the &%TimeInterval ?INTERVAL1 is the initial point of the &%TimeInterval ?INTERVAL2.\")").
:- assert_kif("(<=> (meetsTemporally ?INTERVAL1 ?INTERVAL2) (equal (EndFn ?INTERVAL1) (BeginFn ?INTERVAL2)))").
:- assert_kif("(=> (and (equal (BeginFn ?INTERVAL1) (BeginFn ?INTERVAL2)) (equal (EndFn ?INTERVAL1) (EndFn ?INTERVAL2))) (equal ?INTERVAL1 ?INTERVAL2))").
:- assert_kif("(instance earlier BinaryPredicate)").
:- assert_kif("(instance earlier TemporalRelation)").
:- assert_kif("(instance earlier TransitiveRelation)").
:- assert_kif("(instance earlier IrreflexiveRelation)").
:- assert_kif("(domain earlier 1 TimeInterval)").
:- assert_kif("(domain earlier 2 TimeInterval)").
:- assert_kif("(documentation earlier EnglishLanguage \"(&%earlier ?INTERVAL1 ?INTERVAL2) means that the &%TimeInterval ?INTERVAL1 ends before the &%TimeInterval ?INTERVAL2 begins.\")").
:- assert_kif("(<=> (earlier ?INTERVAL1 ?INTERVAL2) (before (EndFn ?INTERVAL1) (BeginFn ?INTERVAL2)))").
:- assert_kif("(instance cooccur BinaryPredicate)").
:- assert_kif("(instance cooccur TemporalRelation)").
:- assert_kif("(instance cooccur EquivalenceRelation)").
:- assert_kif("(domain cooccur 1 Physical)").
:- assert_kif("(domain cooccur 2 Physical)").
:- assert_kif("(documentation cooccur EnglishLanguage \"(&%cooccur ?THING1 ?THING2) means that the &%Object or &%Process ?THING1 occurs at the same time as, together with, or jointly with the &%Object or &%Process ?THING2. This covers the following temporal relations: is co-incident with, is concurrent with, is contemporaneous with, and is concomitant with.\")").
:- assert_kif("(<=> (cooccur ?PHYS1 ?PHYS2) (equal (WhenFn ?PHYS1) (WhenFn ?PHYS2)))").
% :- assert_kif("; The following functions generate &%TimeIntervals.").
:- assert_kif("(instance TimeIntervalFn BinaryFunction)").
:- assert_kif("(instance TimeIntervalFn TemporalRelation)").
:- assert_kif("(domain TimeIntervalFn 1 TimePoint)").
:- assert_kif("(domain TimeIntervalFn 2 TimePoint)").
:- assert_kif("(range TimeIntervalFn TimeInterval)").
:- assert_kif("(documentation TimeIntervalFn EnglishLanguage \"A &%BinaryFunction that takes two &%TimePoints as arguments and returns the &%TimeInterval defined by these two &%TimePoints. Note that the first &%TimePoint must occur earlier than the second &%TimePoint.\")").
:- assert_kif("(=> (and (instance ?POINT1 TimePoint) (instance ?POINT2 TimePoint) (instance ?INTERVAL TimeInterval) (equal (TimeIntervalFn ?POINT1 ?POINT2) ?INTERVAL)) (and (equal (BeginFn ?INTERVAL) ?POINT1) (equal (EndFn ?INTERVAL) ?POINT2)))").
:- assert_kif("(=> (and (instance ?POINT1 TimePoint) (instance ?POINT2 TimePoint) (instance ?INTERVAL TimeInterval) (equal (TimeIntervalFn ?POINT1 ?POINT2) ?INTERVAL)) (forall (?POINT) (<=> (temporallyBetweenOrEqual ?POINT1 ?POINT ?POINT2) (temporalPart ?POINT ?INTERVAL))))").
:- assert_kif("(instance RecurrentTimeIntervalFn TemporalRelation)").
:- assert_kif("(instance RecurrentTimeIntervalFn BinaryFunction)").
:- assert_kif("(domainSubclass RecurrentTimeIntervalFn 1 TimeInterval)").
:- assert_kif("(domainSubclass RecurrentTimeIntervalFn 2 TimeInterval)").
:- assert_kif("(rangeSubclass RecurrentTimeIntervalFn TimeInterval)").
:- assert_kif("(documentation RecurrentTimeIntervalFn EnglishLanguage \"A function that is useful for generating recurring time intervals. For example, (&%RecurrentTimeIntervalFn (&%HourFn 6 &%Day)"). (&%HourFn 12 &%Day)) returns the &%Class of &%TimeIntervals beginning at 6 in the morning and ending at 12 noon. For another example, (&%RecurrentTimeInterval &%Saturday &%Sunday) returns the &%Class of all weekends. For still another example,"). (&%RecurrentTimeInterval &%June &%August) returns the &%Class containing the academic summer period.\")").
:- assert_kif("(=> (instance ?INTERVAL (RecurrentTimeIntervalFn ?TIMECLASS1 ?TIMECLASS2)) (exists (?TIME1 ?TIME2) (and (instance ?TIME1 ?TIMECLASS1) (instance ?TIME2 ?TIMECLASS2) (starts ?TIME1 ?INTERVAL) (finishes ?TIME2 ?INTERVAL))))").
:- assert_kif("(instance WhenFn TemporalRelation)").
:- assert_kif("(instance WhenFn UnaryFunction)").
:- assert_kif("(instance WhenFn TotalValuedRelation)").
:- assert_kif("(domain WhenFn 1 Physical)").
:- assert_kif("(range WhenFn TimeInterval)").
:- assert_kif("(documentation WhenFn EnglishLanguage \"A &%UnaryFunction that maps an &%Object or &%Process to the exact &%TimeInterval during which it exists. Note that, for every &%TimePoint ?TIME outside of the &%TimeInterval").
:- assert_kif("(WhenFn ?THING), (time ?THING ?TIME) does not hold.\")").
:- assert_kif("(instance PastFn TemporalRelation)").
:- assert_kif("(instance PastFn UnaryFunction)").
:- assert_kif("(instance PastFn TotalValuedRelation)").
:- assert_kif("(domain PastFn 1 TimePosition)").
:- assert_kif("(range PastFn TimeInterval)").
:- assert_kif("(documentation PastFn EnglishLanguage \"A &%UnaryFunction that maps a &%TimePosition to the &%TimeInterval that meets it and that begins at &%NegativeInfinity.\")").
:- assert_kif("(=> (instance ?INTERVAL TimeInterval) (meetsTemporally (PastFn ?INTERVAL) ?INTERVAL))").
:- assert_kif("(=> (instance ?INTERVAL TimeInterval) (equal (PastFn ?INTERVAL) (TimeIntervalFn NegativeInfinity (BeginFn ?INTERVAL))))").
:- assert_kif("(instance ImmediatePastFn TemporalRelation)").
:- assert_kif("(instance ImmediatePastFn UnaryFunction)").
:- assert_kif("(instance ImmediatePastFn TotalValuedRelation)").
:- assert_kif("(domain ImmediatePastFn 1 TimePosition)").
:- assert_kif("(range ImmediatePastFn TimeInterval)").
:- assert_kif("(documentation ImmediatePastFn EnglishLanguage \"A &%UnaryFunction that maps a &%TimePosition to a short, indeterminate &%TimeInterval that immediately precedes the &%TimePosition.\")").
:- assert_kif("(=> (instance ?INTERVAL TimeInterval) (finishes (ImmediatePastFn ?INTERVAL) (PastFn ?INTERVAL)))").
:- assert_kif("(instance FutureFn TemporalRelation)").
:- assert_kif("(instance FutureFn UnaryFunction)").
:- assert_kif("(instance FutureFn TotalValuedRelation)").
:- assert_kif("(domain FutureFn 1 TimePosition)").
:- assert_kif("(range FutureFn TimeInterval)").
:- assert_kif("(documentation FutureFn EnglishLanguage \"A &%UnaryFunction that maps a &%TimePosition to the &%TimeInterval which it meets and which ends at &%PositiveInfinity.\")").
:- assert_kif("(=> (instance ?INTERVAL TimeInterval) (meetsTemporally ?INTERVAL (FutureFn ?INTERVAL)))").
:- assert_kif("(=> (instance ?INTERVAL TimeInterval) (equal (FutureFn ?INTERVAL) (TimeIntervalFn (EndFn ?INTERVAL) PositiveInfinity)))").
:- assert_kif("(instance ImmediateFutureFn TemporalRelation)").
:- assert_kif("(instance ImmediateFutureFn UnaryFunction)").
:- assert_kif("(instance ImmediateFutureFn TotalValuedRelation)").
:- assert_kif("(domain ImmediateFutureFn 1 TimePosition)").
:- assert_kif("(range ImmediateFutureFn TimeInterval)").
:- assert_kif("(documentation ImmediateFutureFn EnglishLanguage \"A &%UnaryFunction that maps a &%TimePosition to a short, indeterminate &%TimeInterval that immediately follows the &%TimePosition.\")").
:- assert_kif("(=> (instance ?INTERVAL TimeInterval) (starts (ImmediateFutureFn ?INTERVAL) (FutureFn ?INTERVAL)))").
% :- assert_kif("; The following definitions and axioms (down to the next section break) cover the content in the Simple-Time ontology on the Ontolingua server.").
:- assert_kif("(instance date BinaryPredicate)").
:- assert_kif("(instance date SingleValuedRelation)").
:- assert_kif("(instance date AsymmetricRelation)").
:- assert_kif("(domain date 1 Physical)").
:- assert_kif("(domain date 2 Day)").
:- assert_kif("(subrelation date time)").
:- assert_kif("(documentation date EnglishLanguage \"A &%BinaryPredicate that specifies a &%TimePosition in absolute calendar time, at the resolution of one day, for a particular &%Object or &%Process.\")").
:- assert_kif("(instance YearFn TemporalRelation)").
:- assert_kif("(instance YearFn UnaryFunction)").
:- assert_kif("(domain YearFn 1 Integer)").
:- assert_kif("(rangeSubclass YearFn Year)").
:- assert_kif("(documentation YearFn EnglishLanguage \"A &%UnaryFunction that maps a number to the corresponding calendar &%Year. For example, (&%YearFn 1912) returns the &%Class containing just one instance, the year of 1912. As might be expected, positive integers return years in the Common Era, while negative integers return years in B.C.E. Note that this function returns a &%Class as a value. The reason for this is that the related functions, viz. &%MonthFn, &%DayFn, &%HourFn, &%MinuteFn, and &%SecondFn, are used to generate both specific &%TimeIntervals and recurrent intervals, and the only way to do this is to make the domains and ranges of these functions classes rather than individuals.\")").
:- assert_kif("(instance MonthFn TemporalRelation)").
:- assert_kif("(instance MonthFn BinaryFunction)").
:- assert_kif("(domainSubclass MonthFn 1 Month)").
:- assert_kif("(domainSubclass MonthFn 2 Year)").
:- assert_kif("(rangeSubclass MonthFn Month)").
:- assert_kif("(documentation MonthFn EnglishLanguage \"A &%BinaryFunction that maps a subclass of &%Month and a subclass of &%Year to the class containing the &%Months corresponding to thos &%Years. For example (&%MonthFn &%January (&%YearFn 1912)) is the class containing the eighth &%Month, i.e. August, of the &%Year 1912. For another example, (&%MonthFn &%August &%Year) is equal to &%August, the class of all months of August. Note that this function returns a &%Class as a value. The reason for this is that the related functions, viz. DayFn, HourFn, MinuteFn, and SecondFn, are used to generate both specific &%TimeIntervals and recurrent intervals, and the only way to do this is to make the domains and ranges of these functions classes rather than individuals.\")").
:- assert_kif("(instance DayFn TemporalRelation)").
:- assert_kif("(instance DayFn BinaryFunction)").
:- assert_kif("(domain DayFn 1 PositiveInteger)").
:- assert_kif("(domainSubclass DayFn 2 Month)").
:- assert_kif("(rangeSubclass DayFn Day)").
:- assert_kif("(documentation DayFn EnglishLanguage \"A &%BinaryFunction that assigns a &%PositiveRealNumber and a subclass of &%Months to the &%Days within each &%Month corresponding to that &%PositiveRealNumber. For example, (&%DayFn 16 &%August) is the &%Class of all sixteenth days of August. For another example, (&%DayFn 9 &%Month) would return the class of all ninth days of any month. For still another example, (&%DayFn 18"). (&%MonthFn &%August (&%YearFn 1912))) denotes the 18th day of August 1912.\")").
:- assert_kif("(=> (instance ?DAY (DayFn ?NUMBER ?MONTH)) (lessThanOrEqualTo ?NUMBER 31))").
:- assert_kif("(=> (and (instance ?DAY1 (DayFn ?NUMBER1 ?MONTH)) (instance ?DAY2 (DayFn ?NUMBER2 ?MONTH)) (equal (SubtractionFn ?NUMBER2 ?NUMBER1) 1)) (meetsTemporally ?DAY1 ?DAY2))").
:- assert_kif("(instance HourFn TemporalRelation)").
:- assert_kif("(instance HourFn BinaryFunction)").
:- assert_kif("(domain HourFn 1 NonnegativeInteger)").
:- assert_kif("(domainSubclass HourFn 2 Day)").
:- assert_kif("(rangeSubclass HourFn Hour)").
:- assert_kif("(documentation HourFn EnglishLanguage \"A &%BinaryFunction that assigns a &%PositiveRealNumber and a subclass of &%Days to the &%Hours within each &%Day corresponding to that &%NonnegativeInteger. For example, (&%HourFn 12 &%Thursday) is the &%Class of all instances of noon Thursday. For another example, (&%HourFn 0 &%Day) would return the class of all instances of midnight. For still another example, (&%HourFn 14"). (&%DayFn 18 (&%MonthFn &%August (&%YearFn 1912)))) denotes 2 PM on the 18th day of August 1912.\")").
:- assert_kif("(=> (instance ?HOUR (HourFn ?NUMBER ?DAY)) (lessThan ?NUMBER 24))").
:- assert_kif("(=> (and (instance ?HOUR1 (HourFn ?NUMBER1 ?DAY)) (instance ?HOUR2 (HourFn ?NUMBER2 ?DAY)) (equal (SubtractionFn ?NUMBER2 ?NUMBER1) 1)) (meetsTemporally ?HOUR1 ?HOUR2))").
:- assert_kif("(instance MinuteFn TemporalRelation)").
:- assert_kif("(instance MinuteFn BinaryFunction)").
:- assert_kif("(domain MinuteFn 1 NonnegativeInteger)").
:- assert_kif("(domainSubclass MinuteFn 2 Hour)").
:- assert_kif("(rangeSubclass MinuteFn Minute)").
:- assert_kif("(documentation MinuteFn EnglishLanguage \"A &%BinaryFunction that assigns a &%PositiveRealNumber and a subclass of &%Hours to the &%Minutes within each &%Hour corresponding to that &%NonnegativeInteger. For example, (&%MinuteFn 30 (&%HourFn 17 &%Day)) is the &%Class of all 5:30's in the afternoon. For another example, (&%MinuteFn 15 &%Hour) would return the class of all instances of quarter past the hour. For still another example,"). (&%MinuteFn 15 (&%HourFn 14 (&%DayFn 18 (&%MonthFn &%August (&%YearFn 1912))))) denotes 15 minutes after 2 PM on the 18th day of August 1912.\")").
:- assert_kif("(=> (instance ?MINUTE (MinuteFn ?NUMBER ?HOUR)) (lessThan ?NUMBER 60))").
:- assert_kif("(=> (and (instance ?MINUTE1 (MinuteFn ?NUMBER1 ?HOUR)) (instance ?MINUTE2 (MinuteFn ?NUMBER2 ?HOUR)) (equal (SubtractionFn ?NUMBER2 ?NUMBER1) 1)) (meetsTemporally ?MINUTE1 ?MINUTE2))").
:- assert_kif("(instance SecondFn TemporalRelation)").
:- assert_kif("(instance SecondFn BinaryFunction)").
:- assert_kif("(domain SecondFn 1 PositiveRealNumber)").
:- assert_kif("(domainSubclass SecondFn 2 Minute)").
:- assert_kif("(rangeSubclass SecondFn Second)").
:- assert_kif("(documentation SecondFn EnglishLanguage \"A &%BinaryFunction that assigns a &%PositiveRealNumber and a subclass of &%Minutes to the &%Seconds within each &%Minute corresponding to that &%PositiveRealNumber. For example, (&%SecondFn 4 (&%MinuteFn 5 &%Hour)) is the &%Class of all fourth &%Seconds of every fifth &%Minute of every hour. For another example,"). (&%SecondFn 8 &%Minute) would return the eighth second of every minute. For still another example, (&%SecondFn 9 (&%MinuteFn 15 (&%HourFn 14 (&%DayFn 18 (&%MonthFn &%August (&%YearFn 1912)))))) denotes 9 seconds and 15 minutes after 2 PM on the 18th day of August 1912.\")").
:- assert_kif("(=> (instance ?SECOND (SecondFn ?NUMBER ?MINUTE)) (lessThan ?NUMBER 60))").
:- assert_kif("(=> (and (instance ?SECOND1 (SecondFn ?NUMBER1 ?MINUTE)) (instance ?SECOND2 (SecondFn ?NUMBER2 ?MINUTE)) (equal (SubtractionFn ?NUMBER2 ?NUMBER1) 1)) (meetsTemporally ?SECOND1 ?SECOND2))").
:- assert_kif("(subclass Year TimeInterval)").
:- assert_kif("(relatedInternalConcept Year YearFn)").
:- assert_kif("(relatedInternalConcept Year YearDuration)").
:- assert_kif("(documentation Year EnglishLanguage \"The &%Class of all calendar &%Years.\")").
:- assert_kif("(=> (instance ?YEAR Year) (duration ?YEAR (MeasureFn 1 YearDuration)))").
:- assert_kif("(=> (and (instance ?YEAR1 Year) (instance ?YEAR2 Year) (equal (SubtractionFn ?YEAR2 ?YEAR1) 1)) (meetsTemporally ?YEAR1 ?YEAR2))").
:- assert_kif("(subclass LeapYear Year)").
:- assert_kif("(documentation LeapYear EnglishLanguage \"The &%Class of all leap years. These are years which are either (i.) evenly divisible by 4 and not by 100 or (ii.) evenly divisible by 400 (this latter case is known as a leap century).\")").
:- assert_kif("(=> (and (instance ?LEAP LeapYear) (instance ?LEAP (YearFn ?NUMBER))) (or (and (equal (RemainderFn ?NUMBER 4) 0) (not (equal (RemainderFn ?NUMBER 100) 0))) (equal (RemainderFn ?NUMBER 400) 0)))").
:- assert_kif("(subclass Month TimeInterval)").
:- assert_kif("(relatedInternalConcept Month MonthFn)").
:- assert_kif("(documentation Month EnglishLanguage \"The &%Class of all calendar &%Months.\")").
:- assert_kif("(subclass January Month)").
:- assert_kif("(documentation January EnglishLanguage \"The &%Class of all &%Months which are January.\")").
:- assert_kif("(=> (instance ?MONTH January) (duration ?MONTH (MeasureFn 31 DayDuration)))").
:- assert_kif("(=> (and (instance ?MONTH1 (MonthFn January ?YEAR)) (instance ?MONTH2 (MonthFn February ?YEAR))) (meetsTemporally ?MONTH1 ?MONTH2))").
:- assert_kif("(subclass February Month)").
:- assert_kif("(documentation February EnglishLanguage \"The &%Class of all &%Months which are February.\")").
:- assert_kif("(=> (and (instance ?MONTH (MonthFn February ?YEAR)) (instance ?Y ?YEAR) (not (instance ?Y LeapYear))) (duration ?MONTH (MeasureFn 28 DayDuration)))").
:- assert_kif("(=> (and (instance ?MONTH (MonthFn February ?YEAR)) (instance ?Y ?YEAR) (instance ?Y LeapYear)) (duration ?MONTH (MeasureFn 29 DayDuration)))").
:- assert_kif("(=> (and (instance ?MONTH1 (MonthFn February ?YEAR)) (instance ?MONTH2 (MonthFn March ?YEAR))) (meetsTemporally ?MONTH1 ?MONTH2))").
:- assert_kif("(subclass March Month)").
:- assert_kif("(documentation March EnglishLanguage \"The &%Class of all &%Months which are March.\")").
:- assert_kif("(=> (instance ?MONTH March) (duration ?MONTH (MeasureFn 31 DayDuration)))").
:- assert_kif("(=> (and (instance ?MONTH1 (MonthFn March ?YEAR)) (instance ?MONTH2 (MonthFn April ?YEAR))) (meetsTemporally ?MONTH1 ?MONTH2))").
:- assert_kif("(subclass April Month)").
:- assert_kif("(documentation April EnglishLanguage \"The &%Class of all &%Months which are April.\")").
:- assert_kif("(=> (instance ?MONTH April) (duration ?MONTH (MeasureFn 30 DayDuration)))").
:- assert_kif("(=> (and (equal ?MONTH1 (MonthFn April ?YEAR)) (equal ?MONTH2 (MonthFn May ?YEAR))) (meetsTemporally ?MONTH1 ?MONTH2))").
:- assert_kif("(subclass May Month)").
:- assert_kif("(documentation May EnglishLanguage \"The &%Class of all &%Months which are May.\")").
:- assert_kif("(=> (instance ?MONTH May) (duration ?MONTH (MeasureFn 31 DayDuration)))").
:- assert_kif("(=> (and (instance ?MONTH1 (MonthFn May ?YEAR)) (instance ?MONTH2 (MonthFn June ?YEAR))) (meetsTemporally ?MONTH1 ?MONTH2))").
:- assert_kif("(subclass June Month)").
:- assert_kif("(documentation June EnglishLanguage \"The &%Class of all &%Months which are June.\")").
:- assert_kif("(=> (instance ?MONTH June) (duration ?MONTH (MeasureFn 30 DayDuration)))").
:- assert_kif("(=> (and (instance ?MONTH1 (MonthFn June ?YEAR)) (instance ?MONTH2 (MonthFn July ?YEAR))) (meetsTemporally ?MONTH1 ?MONTH2))").
:- assert_kif("(subclass July Month)").
:- assert_kif("(documentation July EnglishLanguage \"The &%Class of all &%Months which are July.\")").
:- assert_kif("(=> (instance ?MONTH July) (duration ?MONTH (MeasureFn 31 DayDuration)))").
:- assert_kif("(=> (and (instance ?MONTH1 (MonthFn July ?YEAR)) (instance ?MONTH2 (MonthFn August ?YEAR))) (meetsTemporally ?MONTH1 ?MONTH2))").
:- assert_kif("(subclass August Month)").
:- assert_kif("(documentation August EnglishLanguage \"The &%Class of all &%Months which are August.\")").
:- assert_kif("(=> (instance ?MONTH August) (duration ?MONTH (MeasureFn 31 DayDuration)))").
:- assert_kif("(=> (and (instance ?MONTH1 (MonthFn August ?YEAR)) (instance ?MONTH2 (MonthFn September ?YEAR))) (meetsTemporally ?MONTH1 ?MONTH2))").
:- assert_kif("(subclass September Month)").
:- assert_kif("(documentation September EnglishLanguage \"The &%Class of all &%Months which are September.\")").
:- assert_kif("(=> (instance ?MONTH September) (duration ?MONTH (MeasureFn 30 DayDuration)))").
:- assert_kif("(=> (and (instance ?MONTH1 (MonthFn September ?YEAR)) (instance ?MONTH2 (MonthFn October ?YEAR))) (meetsTemporally ?MONTH1 ?MONTH2))").
:- assert_kif("(subclass October Month)").
:- assert_kif("(documentation October EnglishLanguage \"The &%Class of all &%Months which are October.\")").
:- assert_kif("(=> (instance ?MONTH October) (duration ?MONTH (MeasureFn 31 DayDuration)))").
:- assert_kif("(=> (and (instance ?MONTH1 (MonthFn October ?YEAR)) (instance ?MONTH2 (MonthFn November ?YEAR))) (meetsTemporally ?MONTH1 ?MONTH2))").
:- assert_kif("(subclass November Month)").
:- assert_kif("(documentation November EnglishLanguage \"The &%Class of all &%Months which are November.\")").
:- assert_kif("(=> (instance ?MONTH November) (duration ?MONTH (MeasureFn 30 DayDuration)))").
:- assert_kif("(=> (and (instance ?MONTH1 (MonthFn November ?YEAR)) (instance ?MONTH2 (MonthFn December ?YEAR))) (meetsTemporally ?MONTH1 ?MONTH2))").
:- assert_kif("(subclass December Month)").
:- assert_kif("(documentation December EnglishLanguage \"The &%Class of all &%Months which are December.\")").
:- assert_kif("(=> (instance ?MONTH December) (duration ?MONTH (MeasureFn 31 DayDuration)))").
:- assert_kif("(=> (and (instance ?MONTH1 (MonthFn December ?YEAR1)) (instance ?MONTH2 (MonthFn January ?YEAR2)) (instance ?Y1 ?YEAR1) (instance ?Y2 ?YEAR2) (meetsTemporally ?Y1 ?Y2)) (meetsTemporally ?MONTH1 ?MONTH2))").
:- assert_kif("(subclass Day TimeInterval)").
:- assert_kif("(relatedInternalConcept Day DayFn)").
:- assert_kif("(relatedInternalConcept Day DayDuration)").
:- assert_kif("(documentation Day EnglishLanguage \"The &%Class of all calendar &%Days.\")").
:- assert_kif("(=> (instance ?DAY Day) (duration ?DAY (MeasureFn 1 DayDuration)))").
:- assert_kif("(subclass Monday Day)").
:- assert_kif("(documentation Monday EnglishLanguage \"The &%Class of all calendar Mondays.\")").
:- assert_kif("(subclass Tuesday Day)").
:- assert_kif("(documentation Tuesday EnglishLanguage \"The &%Class of all calendar Tuesdays.\")").
:- assert_kif("(=> (and (instance ?DAY1 Monday) (instance ?DAY2 Tuesday) (instance ?WEEK Week) (temporalPart ?DAY1 ?WEEK) (temporalPart ?DAY2 ?WEEK)) (meetsTemporally ?DAY1 ?DAY2))").
:- assert_kif("(subclass Wednesday Day)").
:- assert_kif("(documentation Wednesday EnglishLanguage \"The &%Class of all calendar Wednesdays.\")").
:- assert_kif("(=> (and (instance ?DAY1 Tuesday) (instance ?DAY2 Wednesday) (instance ?WEEK Week) (temporalPart ?DAY1 ?WEEK) (temporalPart ?DAY2 ?WEEK)) (meetsTemporally ?DAY1 ?DAY2))").
:- assert_kif("(subclass Thursday Day)").
:- assert_kif("(documentation Thursday EnglishLanguage \"The &%Class of all calendar Thursdays.\")").
:- assert_kif("(=> (and (instance ?DAY1 Wednesday) (instance ?DAY2 Thursday) (instance ?WEEK Week) (temporalPart ?DAY1 ?WEEK) (temporalPart ?DAY2 ?WEEK)) (meetsTemporally ?DAY1 ?DAY2))").
:- assert_kif("(subclass Friday Day)").
:- assert_kif("(documentation Friday EnglishLanguage \"The &%Class of all calendar Fridays.\")").
:- assert_kif("(=> (and (instance ?DAY1 Thursday) (instance ?DAY2 Friday) (instance ?WEEK Week) (temporalPart ?DAY1 ?WEEK) (temporalPart ?DAY2 ?WEEK)) (meetsTemporally ?DAY1 ?DAY2))").
:- assert_kif("(subclass Saturday Day)").
:- assert_kif("(documentation Saturday EnglishLanguage \"The &%Class of all calendar Saturdays.\")").
:- assert_kif("(=> (and (instance ?DAY1 Friday) (instance ?DAY2 Saturday) (instance ?WEEK Week) (temporalPart ?DAY1 ?WEEK) (temporalPart ?DAY2 ?WEEK)) (meetsTemporally ?DAY1 ?DAY2))").
:- assert_kif("(subclass Sunday Day)").
:- assert_kif("(documentation Sunday EnglishLanguage \"The &%Class of all calendar Sundays.\")").
:- assert_kif("(=> (and (instance ?DAY1 Saturday) (instance ?DAY2 Sunday) (instance ?WEEK Week) (temporalPart ?DAY1 ?WEEK) (temporalPart ?DAY2 ?WEEK)) (meetsTemporally ?DAY1 ?DAY2))").
:- assert_kif("(=> (and (instance ?DAY1 Sunday) (instance ?DAY2 Monday) (instance ?WEEK1 Week) (instance ?WEEK2 Week) (temporalPart ?DAY1 ?WEEK1) (temporalPart ?DAY2 ?WEEK2) (meetsTemporally ?WEEK1 ?WEEK2)) (meetsTemporally ?DAY1 ?DAY2))").
:- assert_kif("(subclass Week TimeInterval)").
:- assert_kif("(documentation Week EnglishLanguage \"The &%Class of all calendar weeks.\")").
:- assert_kif("(=> (instance ?WEEK Week) (duration ?WEEK (MeasureFn 1 WeekDuration)))").
:- assert_kif("(subclass Hour TimeInterval)").
:- assert_kif("(relatedInternalConcept Hour HourFn)").
:- assert_kif("(relatedInternalConcept Hour HourDuration)").
:- assert_kif("(documentation Hour EnglishLanguage \"The &%Class of all clock &%Hours.\")").
:- assert_kif("(=> (instance ?HOUR Hour) (duration ?HOUR (MeasureFn 1 HourDuration)))").
:- assert_kif("(subclass Minute TimeInterval)").
:- assert_kif("(relatedInternalConcept Minute MinuteFn)").
:- assert_kif("(relatedInternalConcept Minute MinuteDuration)").
:- assert_kif("(documentation Minute EnglishLanguage \"The &%Class of all clock &%Minutes.\")").
:- assert_kif("(=> (instance ?MINUTE Minute) (duration ?MINUTE (MeasureFn 1 MinuteDuration)))").
:- assert_kif("(subclass Second TimeInterval)").
:- assert_kif("(relatedInternalConcept Second SecondDuration)").
:- assert_kif("(relatedInternalConcept Second SecondFn)").
:- assert_kif("(documentation Second EnglishLanguage \"The &%Class of all clock &%Seconds.\")").
:- assert_kif("(=> (instance ?SECOND Second) (duration ?SECOND (MeasureFn 1 SecondDuration)))").
:- assert_kif("(instance TemporalCompositionFn TemporalRelation)").
:- assert_kif("(instance TemporalCompositionFn BinaryFunction)").
:- assert_kif("(domain TemporalCompositionFn 1 TimeInterval)").
:- assert_kif("(domainSubclass TemporalCompositionFn 2 TimeInterval)").
:- assert_kif("(rangeSubclass TemporalCompositionFn TimeInterval)").
:- assert_kif("(documentation TemporalCompositionFn EnglishLanguage \"The basic &%Function for expressing the composition of larger &%TimeIntervals out of smaller &%TimeIntervals. For example, if &%ThisSeptember is an &%instance of &%September,"). (&%TemporalCompositionFn &%ThisSeptember &%Day) denotes the &%Class of consecutive days that make up &%ThisSeptember. Note that one can obtain the number of instances of this &%Class by using the function &%CardinalityFn.\")").
:- assert_kif("(=> (equal (TemporalCompositionFn ?INTERVAL ?INTERVAL-TYPE) ?CLASS) (forall (?TIME1 ?TIME2) (=> (and (instance ?TIME1 ?INTERVAL-TYPE) (instance ?TIME2 ?CLASS)) (exists (?DURATION) (and (duration ?TIME1 ?DURATION) (duration ?TIME2 ?DURATION))))))").
:- assert_kif("(=> (equal (TemporalCompositionFn ?INTERVAL ?INTERVAL-TYPE) ?CLASS) (forall (?TIME1 ?TIME2) (=> (and (instance ?TIME1 ?CLASS) (instance ?TIME2 ?CLASS) (not (equal ?TIME1 ?TIME2))) (or (meetsTemporally ?TIME1 ?TIME2) (meetsTemporally ?TIME2 ?TIME1) (earlier ?TIME1 ?TIME2) (earlier ?TIME2 ?TIME1)))))").
:- assert_kif("(=> (equal (TemporalCompositionFn ?INTERVAL ?INTERVAL-TYPE) ?CLASS) (exists (?TIME) (and (instance ?TIME ?CLASS) (starts ?TIME ?INTERVAL))))").
:- assert_kif("(=> (equal (TemporalCompositionFn ?INTERVAL ?INTERVAL-TYPE) ?CLASS) (exists (?TIME) (and (instance ?TIME ?CLASS) (finishes ?TIME ?INTERVAL))))").
:- assert_kif("(=> (equal (TemporalCompositionFn ?INTERVAL ?INTERVAL-TYPE) ?CLASS) (forall (?TIME1) (=> (and (instance ?TIME1 ?CLASS) (not (finishes ?TIME1 ?INTERVAL))) (exists (?TIME2) (and (instance ?TIME2 ?CLASS) (meetsTemporally ?TIME1 ?TIME2))))))").
:- assert_kif("(=> (equal (TemporalCompositionFn ?INTERVAL ?INTERVAL-TYPE) ?CLASS) (forall (?TIME1) (=> (and (instance ?TIME1 ?CLASS) (not (starts ?TIME1 ?INTERVAL))) (exists (?TIME2) (and (instance ?TIME2 ?CLASS) (meetsTemporally ?TIME2 ?TIME1))))))").
:- assert_kif("(=> (equal (TemporalCompositionFn ?INTERVAL ?INTERVAL-TYPE) ?CLASS) (forall (?TIME) (=> (and (instance ?TIME TimePoint) (temporalPart ?TIME ?INTERVAL)) (exists (?INSTANCE) (and (instance ?INSTANCE ?CLASS) (temporalPart ?TIME ?INSTANCE))))))").
:- assert_kif("(=> (instance ?YEAR Year) (equal (CardinalityFn (TemporalCompositionFn ?YEAR Month)) 12))").
:- assert_kif("(=> (and (instance ?MONTH Month) (duration ?MONTH (MeasureFn ?NUMBER DayDuration))) (equal (CardinalityFn (TemporalCompositionFn ?MONTH Day)) ?NUMBER))").
:- assert_kif("(=> (instance ?WEEK Week) (equal (CardinalityFn (TemporalCompositionFn ?WEEK Day)) 7))").
:- assert_kif("(=> (instance ?DAY Day) (equal (CardinalityFn (TemporalCompositionFn ?DAY Hour)) 24))").
:- assert_kif("(=> (instance ?HOUR Hour) (equal (CardinalityFn (TemporalCompositionFn ?HOUR Minute)) 60))").
:- assert_kif("(=> (instance ?MINUTE Minute) (equal (CardinalityFn (TemporalCompositionFn ?MINUTE Second)) 60))").
% :- assert_kif("; END FILE").
% :- assert_kif("; BEGIN FILE").
% :- assert_kif(";  MEREOTOPOLOGY  ").
% :- assert_kif("; INCLUDES 'STRUCTURAL ONTOLOGY' INCLUDES 'BASE ONTOLOGY'").
% :- assert_kif("; Most of this content is taken from Barry Smith's and Nicola Guarino's papers on the subject.").
:- assert_kif("(instance connected BinaryPredicate)").
:- assert_kif("(instance connected SpatialRelation)").
:- assert_kif("(instance connected ReflexiveRelation)").
:- assert_kif("(instance connected SymmetricRelation)").
:- assert_kif("(domain connected 1 Object)").
:- assert_kif("(domain connected 2 Object)").
:- assert_kif("(documentation connected EnglishLanguage \"(connected ?OBJ1 ?OBJ2) means that ?OBJ1 &%meetsSpatially ?OBJ2 or that ?OBJ1 &%overlapsSpatially ?OBJ2.\")").
:- assert_kif("(=> (connected ?OBJ1 ?OBJ2) (or (meetsSpatially ?OBJ1 ?OBJ2) (overlapsSpatially ?OBJ1 ?OBJ2)))").
:- assert_kif("(<=> (instance ?OBJ SelfConnectedObject) (forall (?PART1 ?PART2) (=> (equal ?OBJ (MereologicalSumFn ?PART1 ?PART2)) (connected ?PART1 ?PART2))))").
:- assert_kif("(instance connects SpatialRelation)").
:- assert_kif("(instance connects TernaryPredicate)").
:- assert_kif("(domain connects 1 SelfConnectedObject)").
:- assert_kif("(domain connects 2 SelfConnectedObject)").
:- assert_kif("(domain connects 3 SelfConnectedObject)").
:- assert_kif("(documentation connects EnglishLanguage \"The relationship between three things, when one of the three things connects the other two. More formally, (&%connects ?OBJ1 ?OBJ2 ?OBJ3) means that (&%connected ?OBJ1 ?OBJ2) and (&%connected ?OBJ1 ?OBJ3) and not (&%connected ?OBJ2 ?OBJ3).\")").
:- assert_kif("(<=> (connects ?OBJ1 ?OBJ2 ?OBJ3) (between ?OBJ2 ?OBJ1 ?OBJ3))").
:- assert_kif("(<=> (connects ?OBJ1 ?OBJ2 ?OBJ3) (and (connected ?OBJ1 ?OBJ2) (connected ?OBJ1 ?OBJ3) (not (connected ?OBJ2 ?OBJ3))))").
:- assert_kif("(=> (connects ?ARC ?NODE1 ?NODE2) (connects ?ARC ?NODE2 ?NODE1))").
:- assert_kif("(subrelation meetsSpatially connected)").
:- assert_kif("(instance meetsSpatially IrreflexiveRelation)").
:- assert_kif("(instance meetsSpatially SymmetricRelation)").
:- assert_kif("(disjointRelation meetsSpatially overlapsSpatially)").
:- assert_kif("(documentation meetsSpatially EnglishLanguage \"(&%meetsSpatially ?OBJ1 ?OBJ2) means that ?OBJ1 and ?OBJ2 are &%connected but that neither ?OBJ1 nor ?OBJ2 &%overlapsSpatially the other.\")").
:- assert_kif("(subrelation overlapsSpatially connected)").
:- assert_kif("(instance overlapsSpatially ReflexiveRelation)").
:- assert_kif("(instance overlapsSpatially SymmetricRelation)").
:- assert_kif("(documentation overlapsSpatially EnglishLanguage \"(&%overlapsSpatially ?OBJ1 ?OBJ2) means that the &%Objects ?OBJ1 and ?OBJ2 have some parts in common. This is a reflexive and symmetric (but not transitive) relation.\")").
:- assert_kif("(<=> (overlapsSpatially ?OBJ1 ?OBJ2) (exists (?OBJ3) (and (part ?OBJ3 ?OBJ1) (part ?OBJ3 ?OBJ2))))").
:- assert_kif("(=> (and (member ?OBJ1 ?COLL) (member ?OBJ2 ?COLL) (not (equal ?OBJ1 ?OBJ2))) (not (overlapsSpatially ?OBJ1 ?OBJ2)))").
:- assert_kif("(=> (and (instance ?REL CaseRole) (instance ?OBJ Object) (?REL ?PROCESS ?OBJ)) (exists (?TIME) (overlapsSpatially (WhereFn ?PROCESS ?TIME) ?OBJ)))").
:- assert_kif("(instance overlapsPartially SymmetricRelation)").
:- assert_kif("(instance overlapsPartially IrreflexiveRelation)").
:- assert_kif("(subrelation overlapsPartially overlapsSpatially)").
:- assert_kif("(documentation overlapsPartially EnglishLanguage \"(&%overlapsPartially ?OBJ1 ?OBJ2) means that ?OBJ1 and ?OBJ2 have part(s) in common, but neither ?OBJ1 nor ?OBJ2 is a &%part of the other.\")").
:- assert_kif("(<=> (overlapsPartially ?OBJ1 ?OBJ2) (and (not (part ?OBJ1 ?OBJ2)) (not (part ?OBJ2 ?OBJ1)) (exists (?OBJ3) (and (part ?OBJ3 ?OBJ1) (part ?OBJ3 ?OBJ2)))))").
:- assert_kif("(subrelation superficialPart part)").
:- assert_kif("(instance superficialPart IrreflexiveRelation)").
:- assert_kif("(instance superficialPart TransitiveRelation)").
:- assert_kif("(documentation superficialPart EnglishLanguage \"(&%superficialPart ?OBJ1 ?OBJ2) means that ?OBJ1 is a part of ?OBJ2 that has no interior parts of its own").
:- assert_kif("(or, intuitively, that only overlaps those parts of ?OBJ2 that are externally connected with the mereological complement of ?OBJ2). This too is a transitive relation closed under &%MereologicalSumFn and &%MereologicalProductFn.\")").
:- assert_kif("(=> (superficialPart ?OBJ1 ?OBJ2) (and (not (interiorPart ?OBJ1 ?OBJ2)) (not (exists (?OBJ3) (interiorPart ?OBJ3 ?OBJ1)))))").
:- assert_kif("(instance surface AsymmetricRelation)").
:- assert_kif("(subrelation surface superficialPart)").
:- assert_kif("(domain surface 1 SelfConnectedObject)").
:- assert_kif("(domain surface 2 SelfConnectedObject)").
:- assert_kif("(documentation surface EnglishLanguage \"(&%surface ?OBJ1 ?OBJ2) means that ?OBJ1 is a maximally connected &%superficialPart of ?OBJ2. Note that some &%SelfConnectedObjects have more than one surface, e.g. a hollow object like a tennis ball has both an inner and an outer surface.\")").
:- assert_kif("(=> (surface ?OBJ1 ?OBJ2) (forall (?OBJ3) (=> (superficialPart ?OBJ3 ?OBJ2) (part ?OBJ3 ?OBJ1))))").
:- assert_kif("(subrelation interiorPart part)").
:- assert_kif("(instance interiorPart AsymmetricRelation)").
:- assert_kif("(instance interiorPart TransitiveRelation)").
:- assert_kif("(documentation interiorPart EnglishLanguage \"(&%interiorPart ?OBJ1 ?OBJ2) means that ?OBJ1 is part ?OBJ2 and there is no overlap between ?OBJ1 and any &%superficialPart ?OBJ2.\")").
:- assert_kif("(=> (interiorPart ?OBJ1 ?OBJ2) (forall (?PART) (=> (superficialPart ?PART ?OBJ2) (not (overlapsSpatially ?OBJ1 ?PART)))))").
:- assert_kif("(subrelation bottom superficialPart)").
:- assert_kif("(domain bottom 1 SelfConnectedObject)").
:- assert_kif("(domain bottom 2 SelfConnectedObject)").
:- assert_kif("(documentation bottom EnglishLanguage \"(&%bottom ?BOTTOM ?OBJECT) holds if ?BOTTOM is the lowest or deepest maximal superficial part of ?OBJECT.\")").
:- assert_kif("(=> (and (bottom ?BOTTOM ?OBJECT) (part ?PART ?OBJECT) (not (connected ?PART ?BOTTOM))) (orientation ?PART ?BOTTOM Above))").
:- assert_kif("(subrelation top superficialPart)").
:- assert_kif("(domain top 1 SelfConnectedObject)").
:- assert_kif("(domain top 2 SelfConnectedObject)").
:- assert_kif("(documentation top EnglishLanguage \"(&%top ?TOP ?OBJECT) means that ?TOP is the highest maximal superficial part of ?OBJECT.\")").
:- assert_kif("(=> (and (top ?TOP ?OBJECT) (part ?PART ?OBJECT) (not (connected ?PART ?TOP))) (orientation ?PART ?TOP Below))").
:- assert_kif("(subrelation side superficialPart)").
:- assert_kif("(domain side 1 SelfConnectedObject)").
:- assert_kif("(domain side 2 SelfConnectedObject)").
:- assert_kif("(documentation side EnglishLanguage \"(&%side ?SIDE ?OBJECT) means that ?SIDE is a side of the object, as opposed to the &%top or &%bottom.\")").
:- assert_kif("(=> (and (side ?SIDE ?OBJECT) (part ?PART ?OBJECT) (not (connected ?PART ?SIDE))) (exists (?DIRECT) (orientation ?SIDE ?PART ?DIRECT)))").
:- assert_kif("(=> (and (top ?TOP ?O) (side ?S ?O)) (not (equal ?TOP ?S)))").
:- assert_kif("(<=> (width ?OBJECT ?WIDTH) (exists (?SIDE1 ?SIDE2) (and (side ?SIDE1 ?OBJECT) (side ?SIDE2 ?OBJECT) (distance ?SIDE1 ?SIDE2 ?WIDTH))))").
:- assert_kif("(=> (and (height ?OBJECT ?HEIGHT) (top ?TOP ?OBJECT) (bottom ?BOTTOM ?OBJECT)) (distance ?TOP ?BOTTOM ?HEIGHT))").
:- assert_kif("(instance MereologicalSumFn SpatialRelation)").
:- assert_kif("(instance MereologicalSumFn BinaryFunction)").
:- assert_kif("(instance MereologicalSumFn TotalValuedRelation)").
:- assert_kif("(domain MereologicalSumFn 1 Object)").
:- assert_kif("(domain MereologicalSumFn 2 Object)").
:- assert_kif("(range MereologicalSumFn Object)").
:- assert_kif("(relatedInternalConcept MereologicalSumFn MereologicalProductFn)").
:- assert_kif("(relatedInternalConcept MereologicalSumFn MereologicalDifferenceFn)").
:- assert_kif("(documentation MereologicalSumFn EnglishLanguage \"(&%MereologicalSumFn ?OBJ1 ?OBJ2) denotes the &%Object consisting of the parts which belong to either ?OBJ1 or ?OBJ2.\")").
:- assert_kif("(=> (equal ?OBJ3 (MereologicalSumFn ?OBJ1 ?OBJ2)) (forall (?PART) (<=> (part ?PART ?OBJ3) (or (part ?PART ?OBJ1) (part ?PART ?OBJ2)))))").
:- assert_kif("(instance MereologicalProductFn SpatialRelation)").
:- assert_kif("(instance MereologicalProductFn BinaryFunction)").
:- assert_kif("(instance MereologicalProductFn TotalValuedRelation)").
:- assert_kif("(domain MereologicalProductFn 1 Object)").
:- assert_kif("(domain MereologicalProductFn 2 Object)").
:- assert_kif("(range MereologicalProductFn Object)").
:- assert_kif("(relatedInternalConcept MereologicalProductFn MereologicalDifferenceFn)").
:- assert_kif("(documentation MereologicalProductFn EnglishLanguage \"(&%MereologicalProductFn ?OBJ1 ?OBJ2) denotes the &%Object consisting of the parts which belong to both ?OBJ1 and ?OBJ2.\")").
:- assert_kif("(=> (equal ?OBJ3 (MereologicalProductFn ?OBJ1 ?OBJ2)) (forall (?PART) (<=> (part ?PART ?OBJ3) (and (part ?PART ?OBJ1) (part ?PART ?OBJ2)))))").
:- assert_kif("(instance MereologicalDifferenceFn SpatialRelation)").
:- assert_kif("(instance MereologicalDifferenceFn BinaryFunction)").
:- assert_kif("(instance MereologicalDifferenceFn TotalValuedRelation)").
:- assert_kif("(domain MereologicalDifferenceFn 1 Object)").
:- assert_kif("(domain MereologicalDifferenceFn 2 Object)").
:- assert_kif("(range MereologicalDifferenceFn Object)").
:- assert_kif("(documentation MereologicalDifferenceFn EnglishLanguage \"(&%MereologicalDifferenceFn ?OBJ1 ?OBJ2) denotes the &%Object consisting of the parts which belong to ?OBJ1 and not to ?OBJ2.\")").
:- assert_kif("(=> (equal ?OBJ3 (MereologicalDifferenceFn ?OBJ1 ?OBJ2)) (forall (?PART) (<=> (properPart ?PART ?OBJ3) (and (properPart ?PART ?OBJ1) (not (properPart ?PART ?OBJ2))))))").
% :- assert_kif("; What follows is an alignment of the Casati and Varzi theory of holes with the SUMO.").
:- assert_kif("(instance hole BinaryPredicate)").
:- assert_kif("(instance hole SpatialRelation)").
:- assert_kif("(instance hole AsymmetricRelation)").
:- assert_kif("(domain hole 1 Hole)").
:- assert_kif("(domain hole 2 SelfConnectedObject)").
:- assert_kif("(documentation hole EnglishLanguage \"(&%hole ?HOLE ?OBJ) means that ?HOLE is a &%Hole in ?OBJ. A &%Hole is a fillable body located at the &%surface an &%Object.\")").
:- assert_kif("(subclass Hole Region)").
:- assert_kif("(documentation Hole EnglishLanguage \"A hole is an immaterial body located at the surface of an &%Object. Since every &%Hole is ontologically dependent on its host").
:- assert_kif("(i.e., the object in which it is a hole), being a &%Hole is defined as being a &%hole in something. Note that two &%Holes may occupy the same region, or part of the same region, without sharing any parts. Any two hosts of a hole have a common proper part that entirely hosts the hole. A common host of two holes hosts all parts of the sum of those holes. Any object that includes the host of a hole is a host of that hole, unless its parts also include parts of that very hole. Overlapping holes have overlapping hosts. No hole is atomic. Holes are connected with their hosts. No hole can have a proper part that is externally connected with exactly the same things as the hole itself.\")").
:- assert_kif("(<=> (instance ?HOLE Hole) (exists (?OBJ) (hole ?HOLE ?OBJ)))").
:- assert_kif("(=> (hole ?HOLE ?OBJ) (not (instance ?OBJ Hole)))").
:- assert_kif("(=> (hole ?HOLE ?OBJ) (not (overlapsSpatially ?HOLE ?OBJ)))").
:- assert_kif("(=> (and (hole ?HOLE ?OBJ1) (hole ?HOLE ?OBJ2)) (exists (?OBJ3) (and (properPart ?OBJ3 (MereologicalProductFn ?OBJ1 ?OBJ2)) (hole ?HOLE ?OBJ3))))").
:- assert_kif("(=> (and (hole ?HOLE1 ?OBJ) (hole ?HOLE2 ?OBJ)) (forall (?HOLE3) (=> (part ?HOLE3 (MereologicalSumFn ?HOLE1 ?HOLE2)) (hole ?HOLE3 ?OBJ))))").
:- assert_kif("(=> (and (hole ?HOLE ?OBJ1) (part ?OBJ1 ?OBJ2)) (or (overlapsSpatially ?HOLE ?OBJ2) (hole ?HOLE ?OBJ2)))").
:- assert_kif("(=> (and (hole ?HOLE1 ?OBJ1) (hole ?HOLE2 ?OBJ2) (overlapsSpatially ?HOLE1 ?HOLE2)) (overlapsSpatially ?OBJ1 ?OBJ2))").
:- assert_kif("(=> (instance ?HOLE1 Hole) (exists (?HOLE2) (properPart ?HOLE2 ?HOLE1)))").
:- assert_kif("(instance HoleHostFn SpatialRelation)").
:- assert_kif("(instance HoleHostFn UnaryFunction)").
:- assert_kif("(instance HoleHostFn TotalValuedRelation)").
:- assert_kif("(instance HoleHostFn AsymmetricRelation)").
:- assert_kif("(domain HoleHostFn 1 Hole)").
:- assert_kif("(range HoleHostFn Object)").
:- assert_kif("(documentation HoleHostFn EnglishLanguage \"A &%UnaryFunction that maps a &%Hole to the &%Object which is its principal host. The principle host of a &%Hole is its maximally connected host (a notion taken here to be defined only when the argument is a hole).\")").
:- assert_kif("(=> (hole ?HOLE ?OBJ) (connected ?HOLE ?OBJ))").
:- assert_kif("(=> (and (instance ?HOLE1 Hole) (properPart ?HOLE2 ?HOLE1)) (exists (?OBJ) (and (meetsSpatially ?HOLE1 ?OBJ) (not (meetsSpatially ?HOLE2 ?OBJ)))))").
:- assert_kif("(instance Fillable ShapeAttribute)").
:- assert_kif("(documentation Fillable EnglishLanguage \"Something is &%Fillable if it can be filled by something else. Note that 'filled' here means perfectly filled. Something is fillable just in case it is part of a hole, i.e., fillability is an exclusive property of holes and their parts.\")").
:- assert_kif("(=> (exists (?TIME) (holdsDuring ?TIME (fills ?OBJ ?HOLE))) (attribute ?HOLE Fillable))").
:- assert_kif("(<=> (attribute ?HOLE1 Fillable) (exists (?HOLE2) (and (instance ?HOLE2 Hole) (part ?HOLE1 ?HOLE2))))").
:- assert_kif("(subrelation partiallyFills located)").
:- assert_kif("(instance partiallyFills SpatialRelation)").
:- assert_kif("(instance partiallyFills AsymmetricRelation)").
:- assert_kif("(domain partiallyFills 1 Object)").
:- assert_kif("(domain partiallyFills 2 Hole)").
:- assert_kif("(documentation partiallyFills EnglishLanguage \"(&%partiallyFills ?OBJ ?HOLE) means that ?OBJ &%completelyFills some part of ?HOLE. Note that if (&%partiallyFills ?OBJ1 ?HOLE) and (&%part ?OBJ1 ?OBJ2), then (&%partiallyFills ?OBJ2 ?HOLE). Note too that a partial filler need not be wholly inside a hole (it may stick out), which means that every complete filler also qualifies as").
:- assert_kif("(is a limit case of) a partial one.\")").
:- assert_kif("(=> (partiallyFills ?OBJ ?HOLE1) (exists (?HOLE2) (and (part ?HOLE2 ?HOLE1) (completelyFills ?OBJ ?HOLE2))))").
:- assert_kif("(instance properlyFills AsymmetricRelation)").
:- assert_kif("(subrelation properlyFills partiallyFills)").
:- assert_kif("(domain properlyFills 1 Object)").
:- assert_kif("(domain properlyFills 2 Hole)").
:- assert_kif("(documentation properlyFills EnglishLanguage \"(&%properlyFills ?OBJ ?HOLE) means that ?HOLE is properly (though perhaps incompletely) filled by ?OBJ, i.e. some part of ?HOLE is perfectly filled by ?OBJ. Note that &%properlyFills is the dual of &%completelyFills, and is so related to &%partiallyFills that ?OBJ &%properlyFills ?HOLE just in case ?OBJ &%partiallyFills every part of ?HOLE. (Thus, every perfect filler is both complete and proper in this sense). Every hole is connected with everything with which a proper filler of the hole is connected. Every proper part of a perfect filler of (a part of) a hole properly fills (that part of) that hole.\")").
:- assert_kif("(=> (properlyFills ?OBJ ?HOLE1) (exists (?HOLE2) (and (part ?HOLE2 ?HOLE1) (fills ?OBJ ?HOLE2))))").
:- assert_kif("(instance completelyFills AsymmetricRelation)").
:- assert_kif("(subrelation completelyFills partiallyFills)").
:- assert_kif("(documentation completelyFills EnglishLanguage \"(&%completelyFills ?OBJ ?HOLE) means that some &%part of the &%Object ?OBJ fills the &%Hole ?HOLE. Note that if (&%completelyFills ?OBJ1 ?HOLE) and (&%part ?OBJ1 ?OBJ2), then (&%completelyFills ?OBJ2 ?HOLE). A complete filler of (a part of) a hole is connected with everything with which (that part of) the hole itself is connected. A perfect filler of (a part of) a hole completely fills every proper part of (that part of) that hole.\")").
:- assert_kif("(=> (completelyFills ?OBJ1 ?HOLE) (exists (?OBJ2) (and (part ?OBJ2 ?OBJ1) (fills ?OBJ2 ?HOLE))))").
:- assert_kif("(instance fills AsymmetricRelation)").
:- assert_kif("(subrelation fills completelyFills)").
:- assert_kif("(subrelation fills properlyFills)").
:- assert_kif("(domain fills 1 Object)").
:- assert_kif("(domain fills 2 Hole)").
:- assert_kif("(relatedInternalConcept fills Fillable)").
:- assert_kif("(documentation fills EnglishLanguage \"Holes can be filled. (&%fills ?OBJ ?HOLE) means that the &%Object ?OBJ fills the &%Hole ?HOLE. Note that &%fills here means perfectly filled. Perfect fillers and fillable entities have no parts in common (rather, they may occupy the same spatial region).\")").
:- assert_kif("(=> (and (fills ?OBJ1 ?HOLE) (attribute ?OBJ2 Fillable)) (not (overlapsSpatially ?OBJ1 ?OBJ2)))").
:- assert_kif("(=> (completelyFills ?OBJ1 ?HOLE) (forall (?OBJ2) (=> (connected ?OBJ2 ?HOLE) (connected ?OBJ2 ?OBJ1))))").
:- assert_kif("(=> (and (properlyFills ?OBJ1 ?HOLE) (connected ?OBJ2 ?OBJ1)) (connected ?HOLE ?OBJ2))").
:- assert_kif("(=> (and (fills ?OBJ ?HOLE1) (properPart ?HOLE2 ?HOLE1)) (completelyFills ?OBJ ?HOLE2))").
:- assert_kif("(=> (and (fills ?OBJ1 ?HOLE) (properPart ?OBJ2 ?OBJ1)) (properlyFills ?OBJ2 ?HOLE))").
:- assert_kif("(instance HoleSkinFn SpatialRelation)").
:- assert_kif("(instance HoleSkinFn UnaryFunction)").
:- assert_kif("(instance HoleSkinFn TotalValuedRelation)").
:- assert_kif("(instance HoleSkinFn AsymmetricRelation)").
:- assert_kif("(domain HoleSkinFn 1 Hole)").
:- assert_kif("(range HoleSkinFn Object)").
:- assert_kif("(documentation HoleSkinFn EnglishLanguage \"A &%UnaryFunction that maps a &%Hole to the skin of the &%Hole. The skin of a &%Hole is the fusion of those superficial parts (see &%superficialPart) of the &%Hole's principal host (see &%HoleHostFn) with which the &%Hole is externally connected.\")").
:- assert_kif("(=> (equal ?OBJ1 (HoleSkinFn ?HOLE)) (forall (?OBJ2) (<=> (overlapsSpatially ?OBJ2 ?OBJ1) (exists (?OBJ3) (and (superficialPart ?OBJ3 (HoleHostFn ?HOLE)) (meetsSpatially ?HOLE ?OBJ3) (overlapsSpatially ?OBJ2 ?OBJ3))))))").
% :- assert_kif("; END FILE").
% :- assert_kif("; BEGIN FILE").
% :- assert_kif(";  PROCESSES  ").
% :- assert_kif("; INCLUDES 'TEMPORAL CONCEPTS' INCLUDES 'OBJECTS' INCLUDES 'QUALITIES'").
:- assert_kif("(instance subProcess BinaryPredicate)").
:- assert_kif("(instance subProcess PartialOrderingRelation)").
:- assert_kif("(domain subProcess 1 Process)").
:- assert_kif("(domain subProcess 2 Process)").
:- assert_kif("(documentation subProcess EnglishLanguage \"(&%subProcess ?SUBPROC ?PROC) means that ?SUBPROC is a subprocess of ?PROC. A subprocess is here understood as a temporally distinguished part (proper or not) of a &%Process.\")").
:- assert_kif("(=> (subProcess ?SUBPROC ?PROC) (temporalPart (WhenFn ?SUBPROC) (WhenFn ?PROC)))").
% :- assert_kif("; NS: delete. This rule is stated above with different (but equivalent) antecedent order. ").
% :- assert_kif("; (=> (subProcess ?SUBPROC ?PROC) (forall (?REGION) (=> (located ?PROC ?REGION) (located ?SUBPROC ?REGION))))").
% :- assert_kif("; NS: delete. Redundant ... we've already stated elsewhere that every Physical exists at some time and at some location. ").
% :- assert_kif("; (=> (and (instance ?PROC Process) (subProcess ?SUBPROC ?PROC)) (exists (?TIME) (time ?SUBPROC ?TIME)))").
% :- assert_kif("; The following formulas cover the hierarchy of &%Classes under &%BiologicalProcess.").
:- assert_kif("(subclass BiologicalProcess InternalChange)").
:- assert_kif("(documentation BiologicalProcess EnglishLanguage \"A &%Process embodied in an &%Organism.\")").
:- assert_kif("(=> (instance ?PROC BiologicalProcess) (exists (?OBJ) (and (instance ?OBJ Organism) (eventLocated ?PROC ?OBJ))))").
:- assert_kif("(=> (and (instance ?PROC BiologicalProcess) (experiencer ?PROC ?ORG)) (instance ?ORG Organism))").
:- assert_kif("(subclass PhysiologicProcess BiologicalProcess)").
:- assert_kif("(documentation PhysiologicProcess EnglishLanguage \"A normal process of an &%Organism or part of an &%Organism.\")").
:- assert_kif("(subclass AutonomicProcess PhysiologicProcess)").
:- assert_kif("(disjoint AutonomicProcess IntentionalProcess)").
:- assert_kif("(documentation AutonomicProcess EnglishLanguage \"The class of &%PhysiologicProcesses of which there is not conscious awareness and control.\")").
:- assert_kif("(subclass OrganOrTissueProcess AutonomicProcess)").
:- assert_kif("(disjoint OrganOrTissueProcess OrganismProcess)").
:- assert_kif("(documentation OrganOrTissueProcess EnglishLanguage \"A &%PhysiologicProcess of a particular &%Organ or &%Tissue.\")").
:- assert_kif("(=> (instance ?PROC OrganOrTissueProcess) (exists (?THING) (and (eventLocated ?PROC ?THING) (or (instance ?THING Organ) (instance ?THING Tissue)))))").
:- assert_kif("(subclass OrganismProcess PhysiologicProcess)").
:- assert_kif("(documentation OrganismProcess EnglishLanguage \"A physiologic function of the &%Organism as a whole, of multiple organ systems or of multiple &%Organs or &%Tissues.\")").
:- assert_kif("(subclass Birth OrganismProcess)").
:- assert_kif("(documentation Birth EnglishLanguage \"The &%Process of being born.\")").
% :- assert_kif("; NS: We need to provide more explanation of the intended meaning of &%Birth.").
:- assert_kif("(=> (and (instance ?BIRTH Birth) (experiencer ?BIRTH ?AGENT)) (exists (?DEATH) (and (instance ?DEATH Death) (experiencer ?DEATH ?AGENT))))").
:- assert_kif("(subclass Death OrganismProcess)").
:- assert_kif("(documentation Death EnglishLanguage \"The &%Process of dying.\")").
% :- assert_kif("; NS: delete. Organisms cannot be Dead. (=> (and (instance ?DEATH Death) (experiencer ?DEATH ?AGENT)) (holdsDuring (FutureFn (WhenFn ?DEATH)) (attribute ?AGENT Dead)))").
% :- assert_kif("; NS: add. The result of an Organism's Death is a Dead OrganicObject, the parts of which were parts of the Organism immediately before its Death. This rule should be considered true only by default, since it is not really accurate for an organism that dies, e.g., by being instantaneously vaporized.").
:- assert_kif("(=> (and (instance ?DEATH Death) (instance ?ORG Organism) (experiencer ?DEATH ?ORG)) (exists (?REM) (and (result ?DEATH ?REM) (instance ?REM OrganicObject) (holdsDuring (FutureFn (WhenFn ?DEATH)) (attribute ?REM Dead)) (=> (holdsDuring (ImmediateFutureFn (WhenFn ?DEATH)) (part ?OBJ ?REM)) (holdsDuring (ImmediatePastFn (WhenFn ?DEATH)) (part ?OBJ ?ORG))))))").
:- assert_kif("(subclass Breathing OrganismProcess)").
:- assert_kif("(subclass Breathing AutonomicProcess)").
:- assert_kif("(documentation Breathing EnglishLanguage \"The &%Process of respiration, by which oxygen is made available to an &%Animal. This covers processes of inhalation, exhalation, and alternations between the two.\")").
:- assert_kif("(subclass Ingesting OrganismProcess)").
:- assert_kif("(documentation Ingesting EnglishLanguage \"The &%Process by which food is taken into an &%Animal.\")").
:- assert_kif("(=> (and (instance ?ACT Ingesting) (resource ?ACT ?FOOD)) (instance ?FOOD (FoodForFn Organism)))").
:- assert_kif("(subclass Eating Ingesting)").
:- assert_kif("(documentation Eating EnglishLanguage \"The &%Process by which solid food is incorporated into an &%Animal.\")").
:- assert_kif("(=> (and (instance ?ACT Eating) (resource ?ACT ?FOOD)) (attribute ?FOOD Solid))").
:- assert_kif("(subclass Drinking Ingesting)").
:- assert_kif("(documentation Drinking EnglishLanguage \"The &%Process by which liquid food, i.e. &%Beverages, are incorporated into an &%Animal.\")").
:- assert_kif("(=> (and (instance ?ACT Drinking) (resource ?ACT ?FOOD)) (attribute ?FOOD Liquid))").
:- assert_kif("(subclass Digesting OrganismProcess)").
:- assert_kif("(subclass Digesting AutonomicProcess)").
:- assert_kif("(documentation Digesting EnglishLanguage \"The &%Process by which &%Food that has been ingested is broken down into simpler chemical compounds and absorbed by the &%Organism.\")").
:- assert_kif("(=> (and (instance ?DIGEST Digesting) (agent ?DIGEST ?ORGANISM)) (exists (?INGEST) (and (instance ?INGEST Ingesting) (agent ?INGEST ?ORGANISM) (overlapsTemporally (WhenFn ?INGEST) (WhenFn ?DIGEST)))))").
:- assert_kif("(=> (instance ?DIGEST Digesting) (exists (?DECOMP) (and (instance ?DECOMP ChemicalDecomposition) (subProcess ?DECOMP ?DIGEST))))").
:- assert_kif("(subclass Growth AutonomicProcess)").
:- assert_kif("(documentation Growth EnglishLanguage \"The &%Process of biological development in which an &%Organism or part of an &%Organism changes its form or its size.\")").
:- assert_kif("(subclass Replication OrganismProcess)").
:- assert_kif("(documentation Replication EnglishLanguage \"The &%Process of biological reproduction. This can be either a sexual or an asexual process.\")").
:- assert_kif("(=> (and (instance ?REP Replication) (agent ?REP ?PARENT) (result ?REP ?CHILD)) (parent ?CHILD ?PARENT))").
:- assert_kif("(=> (instance ?REP Replication) (exists (?BODY) (and (instance ?BODY ReproductiveBody) (result ?REP ?BODY))))").
:- assert_kif("(subclass SexualReproduction Replication)").
:- assert_kif("(disjoint SexualReproduction AsexualReproduction)").
:- assert_kif("(documentation SexualReproduction EnglishLanguage \"Sexual &%Processes of biological reproduction.\")").
:- assert_kif("(=> (and (instance ?REP SexualReproduction) (result ?REP ?ORGANISM)) (exists (?MOTHER ?FATHER) (and (mother ?ORGANISM ?MOTHER) (father ?ORGANISM ?FATHER))))").
:- assert_kif("(subclass AsexualReproduction Replication)").
:- assert_kif("(documentation AsexualReproduction EnglishLanguage \"Asexual &%Processes of biological reproduction.\")").
% :- assert_kif("; NS: delete. (=> (and (instance ?REP AsexualReproduction) (result ?REP ?ORGANISM)) (not (exists (?PARENT1 ?PARENT2) (and (parent ?ORGANISM ?PARENT1) (parent ?ORGANISM ?PARENT2) (not (equal ?PARENT1 ?PARENT2))))))").
% :- assert_kif("; NS: add.").
:- assert_kif("(=> (and (instance ?REP AsexualReproduction) (result ?REP ?ORGANISM) (parent ?ORGANISM ?PARENT1) (parent ?ORGANISM ?PARENT2)) (equal ?PARENT1 ?PARENT2))").
:- assert_kif("(subclass PsychologicalProcess BiologicalProcess)").
:- assert_kif("(documentation PsychologicalProcess EnglishLanguage \"A &%BiologicalProcess which takes place in the mind or brain of an &%Organism and which may be manifested in the behavior of the &%Organism.\")").
:- assert_kif("(=> (instance ?PROCESS PsychologicalProcess) (exists (?ANIMAL) (and (instance ?ANIMAL Animal) (experiencer ?PROCESS ?ANIMAL))))").
:- assert_kif("(subclass PathologicProcess BiologicalProcess)").
:- assert_kif("(disjoint PathologicProcess PhysiologicProcess)").
:- assert_kif("(documentation PathologicProcess EnglishLanguage \"A disordered process, activity, or state of the &%Organism as a whole, of a body system or systems, or of multiple &%Organs or &%Tissues. Included here are normal responses to a negative stimulus as well as patholologic conditions or states that are less specific than a disease. Pathologic functions frequently have systemic effects.\")").
:- assert_kif("(=> (and (instance ?PATH PathologicProcess) (experiencer ?PATH ?ORG)) (exists (?PART ?DISEASE) (and (part ?PART ?ORG) (instance ?DISEASE DiseaseOrSyndrome) (attribute ?PART ?DISEASE))))").
:- assert_kif("(subclass Injuring PathologicProcess)").
:- assert_kif("(subclass Injuring Damaging)").
:- assert_kif("(documentation Injuring EnglishLanguage \"The process of creating a traumatic wound or injury. Since &%Injuring is not possible without some biologic function of the organism being injured, it is a subclass of &%BiologicalProcess.\")").
:- assert_kif("(=> (instance ?INJ Injuring) (exists (?STRUCT) (and (instance ?STRUCT AnatomicalStructure) (patient ?INJ ?STRUCT))))").
:- assert_kif("(<=> (instance ?INJ Injuring) (and (instance ?INJ Damaging) (exists (?ORGANISM) (and (instance ?ORGANISM Organism) (patient ?INJ ?ORGANISM)))))").
:- assert_kif("(subclass Poisoning Injuring)").
:- assert_kif("(documentation Poisoning EnglishLanguage \"A &%Poisoning is caused by an external substance. Since &%Poisoning is not possible without some biologic function which affects the &%Organism being injured, it is a subclass of &%BiologicalProcess.\")").
:- assert_kif("(=> (instance ?POISON Poisoning) (exists (?THING) (and (patient ?POISON ?THING) (or (instance ?THING Organism) (instance ?THING AnatomicalStructure)))))").
:- assert_kif("(=> (instance ?POISON Poisoning) (exists (?SUBSTANCE) (and (instance ?SUBSTANCE BiologicallyActiveSubstance) (instrument ?POISON ?SUBSTANCE))))").
:- assert_kif("(documentation NaturalProcess EnglishLanguage \"A &%Process that take place in nature spontanously.\")").
:- assert_kif("(subclass NaturalProcess Process)").
:- assert_kif("(disjoint NaturalProcess IntentionalProcess)").
:- assert_kif("(subclass IntentionalProcess Process)").
:- assert_kif("(documentation IntentionalProcess EnglishLanguage \"A &%Process that has a specific purpose for the &%CognitiveAgent who performs it.\")").
:- assert_kif("(=> (and (instance ?PROC IntentionalProcess) (agent ?PROC ?AGENT)) (exists (?PURP) (hasPurposeForAgent ?PROC ?PURP ?AGENT)))").
:- assert_kif("(=> (instance ?PROC IntentionalProcess) (exists (?AGENT) (and (instance ?AGENT CognitiveAgent) (agent ?PROC ?AGENT))))").
:- assert_kif("(=> (and (instance ?PROC IntentionalProcess) (agent ?PROC ?HUMAN) (instance ?HUMAN Animal)) (holdsDuring (WhenFn ?PROC) (attribute ?HUMAN Awake)))").
:- assert_kif("(subclass IntentionalPsychologicalProcess IntentionalProcess)").
:- assert_kif("(subclass IntentionalPsychologicalProcess PsychologicalProcess)").
:- assert_kif("(documentation IntentionalPsychologicalProcess EnglishLanguage \"An &%IntentionalProcess that can be realized entirely within the mind or brain of an &%Organism. Thus, for example, &%Reasoning is a subclass of &%IntentionalPsychologicalProcess, because one can reason simply by exercising one's mind/brain. On the other hand, &%RecreationOrExercise is not a subclass of &%IntentionalPsychologicalProcess, because many instances of &%RecreationOrExercise necessarily have &%subProcesses of &%BodyMotion.\")").
:- assert_kif("(subclass RecreationOrExercise IntentionalProcess)").
:- assert_kif("(documentation RecreationOrExercise EnglishLanguage \"A &%Process that is carried out for the purpose of recreation or exercise. Since &%RecreationOrExercise is a subclass of &%IntentionalProcess, the intent of a process determines whether or not it is an instance of the class. Hence, if John and Bill watch the same program on television, and John watches it to relax while Bill watches it solely to satisfy an educational requirement, then John's watching the movie is an instance of &%RecreationOrExercise, while Bill's is not (both cases of watching the television program would however be in the class of &%Seeing, since being an instance of this latter class is not determined by intention).\")").
:- assert_kif("(subclass OrganizationalProcess IntentionalProcess)").
:- assert_kif("(documentation OrganizationalProcess EnglishLanguage \"An &%IntentionalProcess that involves an &%Organization.\")").
:- assert_kif("(=> (and (instance ?ACT OrganizationalProcess) (agent ?ACT ?AGENT)) (or (instance ?AGENT Organization) (exists (?ORG) (and (instance ?ORG Organization) (member ?AGENT ?ORG)))))").
:- assert_kif("(subclass Election OrganizationalProcess)").
:- assert_kif("(documentation Election EnglishLanguage \"&%Election is the class of events conducted by an organization, in which qualified participants vote for officers, adopt resolutions, or settle other issues in that &%Organization.\")").
:- assert_kif("(subclass ReligiousProcess OrganizationalProcess)").
:- assert_kif("(documentation ReligiousProcess EnglishLanguage \"An &%OrganizationalProcess that is carried out within or by a &%ReligiousOrganization.\")").
:- assert_kif("(=> (and (instance ?ACT ReligiousProcess) (agent ?ACT ?AGENT)) (or (instance ?AGENT ReligiousOrganization) (exists (?ORG) (and (member ?AGENT ?ORG) (instance ?ORG ReligiousOrganization)))))").
:- assert_kif("(subclass JoiningAnOrganization OrganizationalProcess)").
:- assert_kif("(documentation JoiningAnOrganization EnglishLanguage \"The &%OrganizationalProcess of becoming a &%member of an &%Organization.\")").
:- assert_kif("(=> (and (instance ?JOIN JoiningAnOrganization) (instance ?ORG Organization) (agent ?JOIN ?PERSON) (patient ?JOIN ?ORG)) (and (holdsDuring (BeginFn (WhenFn ?JOIN)) (not (member ?PERSON ?ORG))) (holdsDuring (EndFn (WhenFn ?JOIN)) (member ?PERSON ?ORG))))").
:- assert_kif("(subclass LeavingAnOrganization OrganizationalProcess)").
:- assert_kif("(disjoint LeavingAnOrganization JoiningAnOrganization)").
:- assert_kif("(documentation LeavingAnOrganization EnglishLanguage \"The &%OrganizationalProcess of leaving an &%Organization, whether voluntarily or involuntarily.\")").
:- assert_kif("(=> (and (instance ?LEAVE LeavingAnOrganization) (instance ?ORG Organization) (agent ?LEAVE ?PERSON) (patient ?LEAVE ?ORG)) (and (holdsDuring (BeginFn (WhenFn ?LEAVE)) (member ?PERSON ?ORG)) (holdsDuring (EndFn (WhenFn ?LEAVE)) (not (member ?PERSON ?ORG)))))").
:- assert_kif("(subclass Graduation LeavingAnOrganization)").
:- assert_kif("(documentation Graduation EnglishLanguage \"The &%OrganizationalProcess of graduating from an &%EducationalOrganization.\")").
:- assert_kif("(=> (and (instance ?GRAD Graduation) (agent ?GRAD ?ORG)) (instance ?ORG EducationalOrganization))").
:- assert_kif("(subclass Matriculation JoiningAnOrganization)").
:- assert_kif("(documentation Matriculation EnglishLanguage \"The &%OrganizationalProcess of joining an &%EducationalOrganization as a student.\")").
:- assert_kif("(=> (and (instance ?MAT Matriculation) (agent ?MAT ?ORG)) (instance ?ORG EducationalOrganization))").
:- assert_kif("(subclass Hiring JoiningAnOrganization)").
:- assert_kif("(documentation Hiring EnglishLanguage \"&%OrganizationalProcesses where someone is made an employee of an &%Organization.\")").
:- assert_kif("(=> (and (instance ?HIRE Hiring) (instance ?ORG Organization) (agent ?HIRE ?ORG) (patient ?HIRE ?PERSON)) (and (holdsDuring (BeginFn (WhenFn ?HIRE)) (not (employs ?ORG ?PERSON))) (holdsDuring (EndFn (WhenFn ?HIRE)) (employs ?ORG ?PERSON))))").
:- assert_kif("(subclass TerminatingEmployment LeavingAnOrganization)").
:- assert_kif("(documentation TerminatingEmployment EnglishLanguage \"&%OrganizationalProcesses where someone ceases to be an employee of an &%Organization. Note that this covers being laid off, being fired, and voluntarily leaving a job.\")").
:- assert_kif("(=> (and (instance ?FIRE TerminatingEmployment) (instance ?ORG Organization) (agent ?FIRE ?ORG) (patient ?FIRE ?PERSON)) (and (holdsDuring (BeginFn (WhenFn ?FIRE)) (employs ?ORG ?PERSON)) (holdsDuring (EndFn (WhenFn ?FIRE)) (not (employs ?ORG ?PERSON)))))").
:- assert_kif("(subclass PoliticalProcess OrganizationalProcess)").
:- assert_kif("(documentation PoliticalProcess EnglishLanguage \"An &%OrganizationalProcess carried out by, for or against officially constituted governments. Some examples would be voting on proposed legislation, electing a government representative, or even overthrowing a government in a revolution.\")").
:- assert_kif("(=> (instance ?PROC PoliticalProcess) (exists (?POL) (and (or (instance ?POL Government) (exists (?GOV) (and (instance ?GOV Government) (member ?POL ?GOV)))) (or (agent ?PROC ?POL) (patient ?PROC ?POL)))))").
:- assert_kif("(subclass JudicialProcess PoliticalProcess)").
:- assert_kif("(documentation JudicialProcess EnglishLanguage \"Any legal proceeding which is conducted by a &%JudicialOrganization. Note that there is an important difference between the concepts &%LegalAction and &%JudicialProcess. The former refers to legal claims that are brought by a plaintiff, e.g. law suits, while the second refers to trials and other sorts of judicial hearings where the merits of a &%LegalAction are decided.\")").
:- assert_kif("(=> (and (instance ?PROCESS JudicialProcess) (agent ?PROCESS ?ORG) (instance ?ORG Organization)) (instance ?ORG JudicialOrganization))").
:- assert_kif("(subclass LegalDecision JudicialProcess)").
:- assert_kif("(subclass LegalDecision Declaring)").
:- assert_kif("(documentation LegalDecision EnglishLanguage \"A decision issued by a court with respect to a &%LegalAction. Note that a &%LegalDecision is the act of &%Declaring a decision of a court, it is not the act of judge or jury &%Deciding the merits of a particular &%LegalAction.\")").
:- assert_kif("(=> (instance ?DECISION LegalDecision) (exists (?ACTION) (and (instance ?ACTION LegalAction) (refers ?DECISION ?ACTION))))").
:- assert_kif("(=> (instance ?DECISION LegalDecision) (exists (?DECIDE) (and (instance ?DECIDE Deciding) (earlier (WhenFn ?DECIDE) (WhenFn ?DECISION)))))").
:- assert_kif("(subclass MilitaryProcess PoliticalProcess)").
:- assert_kif("(subclass MilitaryProcess OrganizationalProcess)").
:- assert_kif("(documentation MilitaryProcess EnglishLanguage \"Any &%Process that is carried out by a military organization. Note that this class covers &%Processes, e.g. military operations, that are the result of careful planning, as well as those which are unscripted.\")").
:- assert_kif("(subclass RegulatoryProcess Guiding)").
:- assert_kif("(documentation RegulatoryProcess EnglishLanguage \"an &%Guiding whose aim is the enforcement of rules or regulations. Note the key differences between &%RegulatoryProcess and the related concept &%Managing. The latter implies a long-term relationship between a single manager and limited number of agents who are managed, while the former implies a normative standard to which the activities of the regulated are referred.\")").
:- assert_kif("(subclass Managing OrganizationalProcess)").
:- assert_kif("(subclass Managing Guiding)").
:- assert_kif("(documentation Managing EnglishLanguage \"&%OrganizationalProcesses that involve overseeing the activities of others. Note the key differences between &%RegulatoryProcess and its sibling &%Managing. The latter implies a long-term relationship between the manager and the managed, while the former implies a normative standard to which the activities of the regulated are referred.\")").
:- assert_kif("(subclass Planning IntentionalPsychologicalProcess)").
:- assert_kif("(documentation Planning EnglishLanguage \"Specifying a set of actions in order to meet a set of goals or objectives.\")").
:- assert_kif("(=> (and (instance ?EVENT Planning) (result ?EVENT ?CBO) (instance ?CBO ContentBearingObject)) (exists (?PLAN) (and (instance ?PLAN Plan) (containsInformation ?CBO ?PLAN))))").
:- assert_kif("(subclass Designing IntentionalPsychologicalProcess)").
:- assert_kif("(documentation Designing EnglishLanguage \"The spatial analogue of &%Planning. &%Designing a &%Collection of &%Objects involves determining a placement of the &%Objects with respect to one another and perhaps other &%Objects as well, in order to satisfy a particular purpose.\")").
:- assert_kif("(subclass Interpreting IntentionalPsychologicalProcess)").
:- assert_kif("(documentation Interpreting EnglishLanguage \"Any &%Process of assigning a &%Proposition to a &%Text, i.e. understanding the &%Text.\")").
:- assert_kif("(=> (and (instance ?INTERPRET Interpreting) (agent ?INTERPRET ?AGENT) (patient ?INTERPRET ?CONTENT) (instance ?CONTENT ContentBearingObject)) (exists (?PROP) (holdsDuring (EndFn (WhenFn ?INTERPRET)) (believes ?AGENT (containsInformation ?CONTENT ?PROP)))))").
:- assert_kif("(subclass QuantityChange InternalChange)").
:- assert_kif("(partition QuantityChange Increasing Decreasing)").
:- assert_kif("(documentation QuantityChange EnglishLanguage \"Any &%InternalChange where a &%PhysicalQuantity associated with the &%patient is altered.\")").
:- assert_kif("(subclass Increasing QuantityChange)").
:- assert_kif("(relatedInternalConcept Increasing Putting)").
:- assert_kif("(documentation Increasing EnglishLanguage \"Any &%QuantityChange where the &%PhysicalQuantity is increased.\")").
:- assert_kif("(=> (and (instance ?INCREASE Increasing) (patient ?INCREASE ?OBJ)) (exists (?UNIT ?QUANT1 ?QUANT2) (and (holdsDuring (BeginFn (WhenFn ?INCREASE)) (equal (MeasureFn ?OBJ ?UNIT) ?QUANT1)) (holdsDuring (EndFn (WhenFn ?INCREASE)) (equal (MeasureFn ?OBJ ?UNIT) ?QUANT2)) (greaterThan ?QUANT2 ?QUANT1))))").
:- assert_kif("(subclass Heating Increasing)").
:- assert_kif("(disjoint Heating Cooling)").
:- assert_kif("(documentation Heating EnglishLanguage \"Any &%Increasing &%Process where the &%PhysicalQuantity increased is a &%TemperatureMeasure.\")").
:- assert_kif("(=> (and (instance ?HEAT Heating) (patient ?HEAT ?OBJ)) (exists (?UNIT ?QUANT1 ?QUANT2) (and (instance ?UNIT TemperatureMeasure) (holdsDuring (BeginFn (WhenFn ?HEAT)) (equal (MeasureFn ?OBJ ?UNIT) ?QUANT1)) (holdsDuring (EndFn (WhenFn ?HEAT)) (equal (MeasureFn ?OBJ ?UNIT) ?QUANT2)) (greaterThan ?QUANT2 ?QUANT1))))").
:- assert_kif("(subclass Decreasing QuantityChange)").
:- assert_kif("(relatedInternalConcept Decreasing Removing)").
:- assert_kif("(documentation Decreasing EnglishLanguage \"Any &%QuantityChange where the &%PhysicalQuantity is decreased.\")").
:- assert_kif("(=> (and (instance ?DECREASE Decreasing) (patient ?DECREASE ?OBJ)) (exists (?UNIT ?QUANT1 ?QUANT2) (and (holdsDuring (BeginFn (WhenFn ?DECREASE)) (equal (MeasureFn ?OBJ ?UNIT) ?QUANT1)) (holdsDuring (EndFn (WhenFn ?DECREASE)) (equal (MeasureFn ?OBJ ?UNIT) ?QUANT2)) (lessThan ?QUANT2 ?QUANT1))))").
:- assert_kif("(subclass Cooling Decreasing)").
:- assert_kif("(documentation Cooling EnglishLanguage \"Any &%Decreasing &%Process where the &%PhysicalQuantity decreased is a &%TemperatureMeasure.\")").
:- assert_kif("(=> (and (instance ?COOL Cooling) (patient ?COOL ?OBJ)) (exists (?UNIT ?QUANT1 ?QUANT2) (and (instance ?UNIT TemperatureMeasure) (holdsDuring (BeginFn (WhenFn ?COOL)) (equal (MeasureFn ?OBJ ?UNIT) ?QUANT1)) (holdsDuring (EndFn (WhenFn ?COOL)) (equal (MeasureFn ?OBJ ?UNIT) ?QUANT2)) (lessThan ?QUANT2 ?QUANT1))))").
% :- assert_kif("; NS: moved from Mid-level-ontology.kif").
:- assert_kif("(instance moves CaseRole)").
:- assert_kif("(domain moves 1 Motion)").
:- assert_kif("(domain moves 2 Object)").
:- assert_kif("(documentation moves EnglishLanguage \"(&%moves ?MOTION ?OBJECT) means that during the &%Motion event ?MOTION, ?OBJECT moves. This does not necessarily imply that the location of ?OBJECT changes during ?MOTION. See also &%changesLocation and &%Translocation.\")").
:- assert_kif("(subrelation moves involvedInEvent)").
% :- assert_kif("; NS: moved from Mid-level-ontology.kif").
:- assert_kif("(instance changesLocation CaseRole)").
:- assert_kif("(domain changesLocation 1 Translocation)").
:- assert_kif("(domain changesLocation 2 Object)").
:- assert_kif("(documentation changesLocation EnglishLanguage \"(&%changesLocation ?EVENT ?OBJECT) means that during the &%Translocation event ?EVENT, ?OBJECT's location changes. ?OBJECT might also be the &%agent, &%patient, or &%experiencer of ?EVENT.\")").
:- assert_kif("(subrelation changesLocation moves) MS: added rule.").
:- assert_kif("(=> (changesLocation ?EVENT ?OBJ) (and (instance ?EVENT Translocation) (instance ?OBJ Object) (or (patient ?EVENT ?OBJ) (agent ?EVENT ?OBJ) (experiencer ?EVENT ?OBJ))))").
:- assert_kif("(subclass Motion Process)").
:- assert_kif("(documentation Motion EnglishLanguage \"Any &%Process of movement.\")").
% :- assert_kif("; NS: add.").
:- assert_kif("(=> (instance ?MOTION Motion) (exists (?OBJ) (and (instance ?OBJ Object) (moves ?MOTION ?OBJ))))").
% :- assert_kif("; NS: delete. The imprecision of &%patient here will be a problem if this rule is ever used in inference, given the number and variety of subclasses of Motion. (=> (and (instance ?MOTION Motion) (patient ?MOTION ?OBJ) (origin ?MOTION ?PLACE)) (holdsDuring (BeginFn (WhenFn ?MOTION)) (located ?OBJ ?PLACE)))").
% :- assert_kif("; NS: add.").
:- assert_kif("(=> (and (instance ?MOTION Motion) (moves ?MOTION ?OBJ) (origin ?MOTION ?PLACE)) (holdsDuring (BeginFn (WhenFn ?MOTION)) (located ?OBJ ?PLACE)))").
% :- assert_kif("; NS: delete. (=> (and (instance ?MOTION Motion) (patient ?MOTION ?OBJ) (destination ?MOTION ?PLACE)) (holdsDuring (EndFn (WhenFn ?MOTION)) (located ?OBJ ?PLACE)))").
% :- assert_kif("; NS: add.").
:- assert_kif("(=> (and (instance ?MOTION Motion) (moves ?MOTION ?OBJ) (destination ?MOTION ?PLACE)) (holdsDuring (EndFn (WhenFn ?MOTION)) (located ?OBJ ?PLACE)))").
:- assert_kif("(subclass MotionUpward Motion)").
:- assert_kif("(disjoint MotionUpward MotionDownward)").
:- assert_kif("(documentation MotionUpward EnglishLanguage \"&%Motion where an &%Object is moving away from the ground.\")").
:- assert_kif("(subclass MotionDownward Motion)").
:- assert_kif("(documentation MotionDownward EnglishLanguage \"&%Motion where an &%Object is moving toward the ground.\")").
:- assert_kif("(instance path CaseRole) KJN: Deleting this as it is redundant. (subrelation path involvedInEvent)").
:- assert_kif("(subrelation path eventPartlyLocated)").
:- assert_kif("(domain path 1 Motion)").
:- assert_kif("(domain path 2 Object)").
:- assert_kif("(documentation path EnglishLanguage \"(&%path ?MOTION ?PATH) means that ?PATH is a route along which ?MOTION occurs. For example, Highway 101 is the path in the following proposition: the car drove up Highway 101.\")").
:- assert_kif("(=> (and (path ?PROCESS ?PATH1) (origin ?PROCESS ?SOURCE) (destination ?PROCESS ?DEST) (length ?PATH1 ?MEASURE1) (distance ?SOURCE ?DEST ?DISTANCE) (not (greaterThan ?MEASURE1 ?DISTANCE))) (forall (?OBJ) (=> (part ?OBJ ?PATH1) (between ?SOURCE ?OBJ ?DEST))))").
:- assert_kif("(subclass BodyMotion Motion)").
:- assert_kif("(documentation BodyMotion EnglishLanguage \"Any &%Motion where the &%agent is an &%Organism and the &%patient is a &%BodyPart.\")").
% :- assert_kif("; NS: delete. (=> (instance ?MOTION BodyMotion) (exists (?OBJ ?AGENT) (and (instance ?OBJ BodyPart) (patient ?MOTION ?OBJ) (instance ?AGENT Organism) (agent ?MOTION ?AGENT))))").
% :- assert_kif("; NS: add.").
:- assert_kif("(=> (and (instance ?MOTION BodyMotion) (moves ?MOTION ?OBJ)) (and (instance ?OBJ BodyPart) (patient ?MOTION ?OBJ)))").
% :- assert_kif("; NS: add.").
:- assert_kif("(=> (instance ?MOTION BodyMotion) (exists (?AGENT) (and (instance ?AGENT Organism) (agent ?MOTION ?AGENT))))").
:- assert_kif("(subclass VocalCords Organ)").
:- assert_kif("(documentation VocalCords EnglishLanguage \"The vocal cords, are composed of two folds of mucous membrane stretched horizontally across the larynx. They vibrate, modulating the flow of air being expelled from the lungs during &%Vocalizing. \")").
:- assert_kif("(typicalPart VocalCords Human)").
:- assert_kif("(typicallyContainsPart VocalCords Human)").
:- assert_kif("(initialPart VocalCords Human) NS: delete. (=> (instance ?VOCAL Vocalizing) (exists (?HUMAN) (and (instance ?HUMAN Human) (agent ?VOCAL ?HUMAN) (instrument ?VOCAL ?HUMAN))))").
% :- assert_kif("; NS: add. This probably is too restrictive, given that primates and many other types of mammals, as well as birds, also vocalize. Create VocalCord, and add the instrument part of the rule above, in Mid-level-ontology.kif.").
:- assert_kif("(subclass Vocalizing RadiatingSound)").
:- assert_kif("(documentation Vocalizing EnglishLanguage \"Any instance of &%RadiatingSound where the instrument is the vocal cord. This covers grunts, screams, raors, as well as &%Speaking.\")").
:- assert_kif("(=> (instance ?VOCAL Vocalizing) (exists (?CORD ?ORGANISM) (and (instance ?CORD VocalCords) (instrument ?VOCAL ?CORD) (part ?VOCAL ?ORGANISM) (instance ?ORGANISM Organism))))").
:- assert_kif("(subclass Speaking LinguisticCommunication)").
:- assert_kif("(subclass Speaking Vocalizing)").
% :- assert_kif("; NS: delete. &%LinguisticGeneration does not exist. (documentation Speaking EnglishLanguage \"Any &%LinguisticGeneration which is also a &%Vocalizing, i.e. any &%LinguisticCommunication by a &%Human which involves his/her vocal cords.\")").
% :- assert_kif("; NS: add.").
:- assert_kif("(documentation Speaking EnglishLanguage \"Any &%LinguisticCommunication by a &%Human which involves his/her vocal cords.\")").
% :- assert_kif("; KJN: Deleting. Fixed Music ontology and replacing it with concepts from that. (subclass Singing Speaking) (subclass Singing Music) (documentation Singing EnglishLanguage \"&%Speaking that is also &%Music.\")").
:- assert_kif("(subclass Ambulating BodyMotion)").
:- assert_kif("(subclass Ambulating Translocation)").
:- assert_kif("(partition Ambulating Walking Running)").
:- assert_kif("(documentation Ambulating EnglishLanguage \"Any &%BodyMotion which is accomplished by means of the legs of an &%Animal for the purpose of moving from one point to another.\")").
:- assert_kif("(subclass Walking Ambulating)").
:- assert_kif("(documentation Walking EnglishLanguage \"&%Ambulating relatively slowly, i.e. moving in such a way that at least one foot is always in contact with the ground.\")").
:- assert_kif("(subclass Running Ambulating)").
:- assert_kif("(documentation Running EnglishLanguage \"&%Ambulating relatively quickly, i.e. moving in such a way that, with each step, neither foot is in contact with the ground for a period of time.\")").
:- assert_kif("(=> (and (instance ?WALK Walking) (instance ?RUN Running) (agent ?WALK ?AGENT) (agent ?RUN ?AGENT) (holdsDuring (WhenFn ?WALK) (measure ?AGENT (SpeedFn ?LENGTH1 ?TIME))) (holdsDuring (WhenFn ?RUN) (measure ?AGENT (SpeedFn ?LENGTH2 ?TIME)))) (greaterThan ?LENGTH2 ?LENGTH1))").
:- assert_kif("(subclass Swimming BodyMotion)").
:- assert_kif("(documentation Swimming EnglishLanguage \"Any deliberate and controlled &%BodyMotion through water that is accomplished by an &%Organism.\")").
:- assert_kif("(=> (and (instance ?SWIM Swimming) (agent ?SWIM ?AGENT)) (exists (?AREA) (and (instance ?AREA WaterArea) (located ?AGENT ?AREA))))").
:- assert_kif("(subclass Dancing BodyMotion)").
:- assert_kif("(documentation Dancing EnglishLanguage \"Any &%BodyMotion of &%Humans which is deliberately coordinated with music.\")").
:- assert_kif("(subclass GeologicalProcess Motion)").
:- assert_kif("(subclass GeologicalProcess InternalChange)").
:- assert_kif("(disjoint GeologicalProcess IntentionalProcess)").
:- assert_kif("(documentation GeologicalProcess EnglishLanguage \"The class of activities that are caused by geological forces and affect geological features, and which may affect the biosphere as well.\")").
:- assert_kif("(subclass WeatherProcess Motion)").
:- assert_kif("(disjoint WeatherProcess IntentionalProcess)").
:- assert_kif("(documentation WeatherProcess EnglishLanguage \"&%WeatherProcess is the broadest class of processes that involve weather, including weather seasons (not to be confused with instances of &%SeasonOfYear), weather systems, and short-term weather events.\")").
:- assert_kif("(subclass Precipitation WeatherProcess)").
:- assert_kif("(subclass Precipitation WaterMotion)").
:- assert_kif("(subclass Precipitation Falling)").
:- assert_kif("(documentation Precipitation EnglishLanguage \"&%Precipitation is the process of water molecules falling from the air to the ground, in either a liquid or frozen state.\")").
:- assert_kif("(=> (instance ?PROCESS Precipitation) (exists (?STUFF) (and (instance ?STUFF Water) (patient ?PROCESS ?STUFF))))").
:- assert_kif("(subclass LiquidMotion Motion)").
:- assert_kif("(documentation LiquidMotion EnglishLanguage \"Any &%Motion where the &%patient is a &%Liquid. This class would cover, in particular, the flow of &%Water.\")").
:- assert_kif("(=> (and (instance ?MOTION LiquidMotion) (patient ?MOTION ?OBJ)) (attribute ?OBJ Liquid))").
:- assert_kif("(subclass WaterMotion LiquidMotion)").
:- assert_kif("(documentation WaterMotion EnglishLanguage \"Any &%LiquidMotion where the &%Liquid is &%Water.\")").
:- assert_kif("(=> (instance ?MOTION WaterMotion) (exists (?WATER) (and (patient ?MOTION ?WATER) (instance ?WATER Water))))").
:- assert_kif("(subclass GasMotion Motion)").
:- assert_kif("(documentation GasMotion EnglishLanguage \"Any &%Motion where the &%patient is a &%Gas. This class would cover, in particular, the motion of &%Air, e.g. a breeze or wind.\")").
:- assert_kif("(=> (and (instance ?MOTION GasMotion) (patient ?MOTION ?OBJ)) (attribute ?OBJ Gas))").
:- assert_kif("(subclass Wind GasMotion)").
:- assert_kif("(documentation Wind EnglishLanguage \"Any &%Motion of &%Air.\")").
:- assert_kif("(subclass DirectionChange Motion)").
:- assert_kif("(documentation DirectionChange EnglishLanguage \"The act of changing the direction in which the &%patient of the act is oriented.\")").
:- assert_kif("(=> (instance ?PROC DirectionChange) (exists (?ATTR) (and (instance ?ATTR DirectionalAttribute) (or (and (holdsDuring (BeginFn (WhenFn ?PROC)) (manner ?PROC ?ATTR)) (holdsDuring (EndFn (WhenFn ?PROC)) (not (manner ?PROC ?ATTR)))) (and (holdsDuring (EndFn (WhenFn ?PROC)) (manner ?PROC ?ATTR)) (holdsDuring (BeginFn (WhenFn ?PROC)) (not (manner ?PROC ?ATTR))))))))").
:- assert_kif("(subclass Transfer Translocation)").
:- assert_kif("(documentation Transfer EnglishLanguage \"Any &%instance of &%Translocation where the &%agent and the &%patient are not the same thing.\")").
:- assert_kif("(=> (and (instance ?TRANSFER Transfer) (agent ?TRANSFER ?AGENT) (patient ?TRANSFER ?PATIENT)) (not (equal ?AGENT ?PATIENT)))").
:- assert_kif("(=> (and (instance ?T1 Translocation) (instance ?T2 Translocation) (origin ?T1 ?O1) (origin ?T2 ?D1) (destination ?T1 ?D1) (destination ?T2 ?D2) (experiencer ?T1 ?P) (experiencer ?T2 ?P)) (exists (?T) (and (instance ?T Translocation) (origin ?T ?O1) (destination ?T ?D2) (subProcess ?T1 ?T) (subProcess ?T2 ?T) (experiencer ?T ?P) (starts (WhenFn ?T1) (WhenFn ?T)) (finishes (WhenFn ?T2) (WhenFn ?T)))))").
:- assert_kif("(subclass Carrying Transfer)").
:- assert_kif("(documentation Carrying EnglishLanguage \"&%Transfer from one point to another by means of an &%Animal or &%Human.\")").
:- assert_kif("(=> (instance ?CARRY Carrying) (exists (?ANIMAL) (and (instance ?ANIMAL Animal) (instrument ?CARRY ?ANIMAL))))").
:- assert_kif("(subclass Removing Transfer)").
:- assert_kif("(documentation Removing EnglishLanguage \"The &%Class of &%Processes where something is taken away from a location. Note that the thing removed and the location are specified with the &%CaseRoles &%patient and &%origin, respectively.\")").
:- assert_kif("(=> (and (instance ?REMOVE Removing) (origin ?REMOVE ?PLACE) (patient ?REMOVE ?OBJ)) (and (holdsDuring (BeginFn (WhenFn ?REMOVE)) (located ?OBJ ?PLACE)) (holdsDuring (EndFn (WhenFn ?REMOVE)) (not (located ?OBJ ?PLACE)))))").
:- assert_kif("(subclass Uncovering Removing)").
:- assert_kif("(disjoint Uncovering Covering)").
:- assert_kif("(documentation Uncovering EnglishLanguage \"The &%Class of &%Removing processes where the &%agent uncovers the &%patient, either completely or only partially.\")").
:- assert_kif("(subclass Putting Transfer)").
:- assert_kif("(documentation Putting EnglishLanguage \"The &%Class of &%Processes where something is put in a location. Note that the location is specified with the &%CaseRole &%destination.\")").
:- assert_kif("(=> (and (instance ?PUT Putting) (destination ?PUT ?PLACE) (patient ?PUT ?OBJ)) (and (holdsDuring (BeginFn (WhenFn ?PUT)) (not (located ?OBJ ?PLACE))) (holdsDuring (EndFn (WhenFn ?PUT)) (located ?OBJ ?PLACE))))").
:- assert_kif("(subclass Covering Putting)").
:- assert_kif("(documentation Covering EnglishLanguage \"The &%Class of &%Putting processes where the &%agent covers the &%patient, either completely or only partially, with something else.\")").
:- assert_kif("(subclass Inserting Putting)").
:- assert_kif("(documentation Inserting EnglishLanguage \"&%Putting one thing inside of another thing.\")").
:- assert_kif("(=> (and (instance ?INSERT Inserting) (patient ?INSERT ?OBJ1) (destination ?INSERT ?OBJ2)) (and (holdsDuring (BeginFn (WhenFn ?INSERT)) (not (contains ?OBJ2 ?OBJ1))) (holdsDuring (EndFn (WhenFn ?INSERT)) (contains ?OBJ2 ?OBJ1))))").
:- assert_kif("(subclass Injecting Inserting)").
:- assert_kif("(documentation Injecting EnglishLanguage \"&%Inserting a &%BiologicallyActiveSubstance into an &%Animal or a &%Human with a syringe.\")").
:- assert_kif("(=> (instance ?INJECT Injecting) (exists (?SUBSTANCE ?ANIMAL) (and (patient ?INJECT ?SUBSTANCE) (instance ?SUBSTANCE BiologicallyActiveSubstance) (attribute ?SUBSTANCE Liquid) (destination ?INJECT ?ANIMAL) (instance ?ANIMAL Animal))))").
:- assert_kif("(subclass Substituting Transfer)").
:- assert_kif("(subclass Substituting DualObjectProcess)").
:- assert_kif("(documentation Substituting EnglishLanguage \"The &%Class of &%Transfers where one thing is replaced with something else.\")").
:- assert_kif("(=> (instance ?SUB Substituting) (exists (?PUT ?REMOVE ?OBJ1 ?OBJ2 ?PLACE) (and (instance ?PUT Putting) (instance ?REMOVE Removing) (subProcess ?PUT ?SUB) (subProcess ?REMOVE ?SUB) (patient ?REMOVE ?OBJ1) (origin ?REMOVE ?PLACE) (patient ?PUT ?OBJ2) (destination ?PUT ?PLACE) (not (equal ?OBJ1 ?OBJ2)))))").
:- assert_kif("(subclass Impelling Transfer)").
:- assert_kif("(documentation Impelling EnglishLanguage \"The &%subclass of &%Transfer where the &%patient travels through space by means of a sudden, forceful event. Some examples would be shooting, throwing, tossing, etc.\")").
:- assert_kif("(subclass Shooting Impelling)").
:- assert_kif("(documentation Shooting EnglishLanguage \"The &%subclass of &%Impelling where the &%patient is a projectile that is fired through the air by means of some sort of &%Device.\")").
:- assert_kif("(subclass Touching Transfer)").
:- assert_kif("(documentation Touching EnglishLanguage \"Any &%Transfer where two &%Objects are brought into immediate physical contact with one another.\")").
:- assert_kif("(=> (and (instance ?TOUCH Touching) (agent ?TOUCH ?OBJ1) (patient ?TOUCH ?OBJ2)) (and (holdsDuring (BeginFn (WhenFn ?TOUCH)) (not (connected ?OBJ1 ?OBJ2))) (holdsDuring (EndFn (WhenFn ?TOUCH)) (connected ?OBJ1 ?OBJ2))))").
:- assert_kif("(subrelation grasps meetsSpatially)").
:- assert_kif("(domain grasps 1 Animal)").
:- assert_kif("(domain grasps 2 Object)").
:- assert_kif("(documentation grasps EnglishLanguage \"The state of grasping an &%Object. (&%grasps ?ANIMAL ?OBJ) means that the &%Animal ?ANIMAL is intentionally holding on to the &%Object ?OBJ.\")").
:- assert_kif("(subclass Grabbing Touching)").
:- assert_kif("(subclass Grabbing Attaching)").
:- assert_kif("(documentation Grabbing EnglishLanguage \"Any instance of &%Touching which results in a situation where the &%agent &%grasps the &%patient of the &%Touching.\")").
:- assert_kif("(=> (and (instance ?GRAB Grabbing) (agent ?GRAB ?AGENT) (patient ?GRAB ?THING)) (and (holdsDuring (BeginFn (WhenFn ?GRAB)) (not (grasps ?AGENT ?THING))) (holdsDuring (EndFn (WhenFn ?GRAB)) (grasps ?AGENT ?THING))))").
:- assert_kif("(subclass Releasing Transfer)").
:- assert_kif("(documentation Releasing EnglishLanguage \"Any instance of &%Transfer which results in a situation where it is not the case that the &%agent &%grasps something which he/she &%grasps previously.\")").
:- assert_kif("(=> (and (instance ?RELEASE Releasing) (agent ?GRAB ?AGENT) (patient ?GRAB ?THING)) (and (holdsDuring (BeginFn (WhenFn ?RELEASE)) (grasps ?AGENT ?THING)) (holdsDuring (EndFn (WhenFn ?RELEASE)) (not (grasps ?AGENT ?THING)))))").
:- assert_kif("(subclass Impacting Touching)").
:- assert_kif("(documentation Impacting EnglishLanguage \"Any &%Touching where something comes into sudden, forceful, physical contact with something else. Some examples would be striking, knocking, whipping etc.\")").
:- assert_kif("(=> (and (instance ?IMPACT Impacting) (patient ?IMPACT ?OBJ)) (exists (?IMPEL) (and (instance ?IMPEL Impelling) (patient ?IMPEL ?OBJ) (earlier (WhenFn ?IMPEL) (WhenFn ?IMPACT)))))").
:- assert_kif("(subclass Translocation Motion)").
:- assert_kif("(documentation Translocation EnglishLanguage \"&%Translocation is that class of &%Motions in which an object moves from one place to another. In the case of round trips, the &%origin and &%destination are the same, but the intervening motion passes through other locations. &%Translocation represents linear motion, in contrast to rotation or other movement in place. A vehicle is not necessary, &%Ambulating is a kind of &%Translocation.\")").
:- assert_kif("(=> (and (instance ?MOVEMENT Translocation) (origin ?MOVEMENT ?PLACE1)) (exists (?PLACE2 ?STAGE) (and (instance ?PLACE2 Region) (not (equal ?PLACE1 ?PLACE2)) (subProcess ?STAGE ?MOVEMENT) (located ?STAGE ?PLACE2))))").
:- assert_kif("(=> (instance ?T Translocation) (exists (?O ?D ?P) (and (instance ?O Object) (instance ?D Object) (instance ?P Object) (path ?T ?P) (origin ?T ?O) (destination ?T ?D))))").
:- assert_kif("(subclass Falling Translocation)").
:- assert_kif("(subclass Falling MotionDownward)").
:- assert_kif("(documentation Falling EnglishLanguage \"&%Falling is the class of events in which something moves from a higher location to a lower location under the force of gravity.\")").
:- assert_kif("(=> (and (instance ?DROP Falling) (origin ?DROP ?START) (destination ?DROP ?FINISH)) (orientation ?FINISH ?START Below))").
:- assert_kif("(subclass Transportation Translocation)").
:- assert_kif("(relatedInternalConcept Transportation TransportationDevice)").
:- assert_kif("(documentation Transportation EnglishLanguage \"&%Motion from one point to another by means of a &%TransportationDevice.\")").
:- assert_kif("(=> (instance ?TRANS Transportation) (exists (?DEVICE) (and (instance ?DEVICE TransportationDevice) (instrument ?TRANS ?DEVICE))))").
:- assert_kif("(subclass Guiding IntentionalProcess)").
:- assert_kif("(documentation Guiding EnglishLanguage \"Any &%IntentionalProcess where the &%agent tries to direct the behavior of another &%Object, whether an &%Agent or not.\")").
:- assert_kif("(subclass Driving Guiding)").
:- assert_kif("(documentation Driving EnglishLanguage \"Controlling the direction and/or speed of a &%Vehicle. This includes navigating a ship, driving a car or truck, operating a train, etc.\")").
:- assert_kif("(=> (instance ?DRIVE Driving) (exists (?VEHICLE) (and (instance ?VEHICLE Vehicle) (patient ?DRIVE ?VEHICLE))))").
:- assert_kif("(subclass EducationalProcess Guiding)").
:- assert_kif("(documentation EducationalProcess EnglishLanguage \"Any &%Process which is intended to result in &%Learning.\")").
:- assert_kif("(=> (and (instance ?EDUCATION EducationalProcess) (patient ?EDUCATION ?PERSON)) (hasPurpose ?EDUCATION (exists (?LEARN) (and (instance ?LEARN Learning) (patient ?LEARN ?PERSON)))))").
:- assert_kif("(subclass ChangeOfPossession SocialInteraction)").
:- assert_kif("(relatedInternalConcept ChangeOfPossession possesses)").
:- assert_kif("(documentation ChangeOfPossession EnglishLanguage \"The &%Class of &%Processes where ownership of something is transferred from one &%Agent to another.\")").
:- assert_kif("(=> (and (instance ?CHANGE ChangeOfPossession) (patient ?CHANGE ?OBJ) (holdsDuring (BeginFn (WhenFn ?CHANGE)) (possesses ?AGENT1 ?OBJ)) (holdsDuring (EndFn (WhenFn ?CHANGE)) (possesses ?AGENT2 ?OBJ))) (not (equal ?AGENT1 ?AGENT2)))").
:- assert_kif("(=> (and (instance ?CHANGE ChangeOfPossession) (origin ?CHANGE ?AGENT1) (destination ?CHANGE ?AGENT2) (instance ?AGENT1 Agent) (instance ?AGENT2 Agent) (patient ?CHANGE ?OBJ)) (and (holdsDuring (BeginFn (WhenFn ?CHANGE)) (possesses ?AGENT1 ?OBJ)) (holdsDuring (EndFn (WhenFn ?CHANGE)) (possesses ?AGENT2 ?OBJ))))").
:- assert_kif("(subclass Giving ChangeOfPossession)").
:- assert_kif("(documentation Giving EnglishLanguage \"The &%subclass of &%ChangeOfPossession where the &%agent gives the &%destination something.\")").
:- assert_kif("(=> (and (instance ?GIVE Giving) (agent ?GIVE ?AGENT1) (destination ?GIVE ?AGENT2) (instance ?AGENT2 Agent) (patient ?GIVE ?OBJ)) (exists (?GET) (and (instance ?GET Getting) (agent ?GET ?AGENT2) (origin ?GET ?AGENT1) (patient ?GET ?OBJ))))").
:- assert_kif("(=> (and (instance ?GIVE Giving) (agent ?GIVE ?AGENT)) (origin ?GIVE ?AGENT))").
:- assert_kif("(subclass Funding Giving)").
:- assert_kif("(documentation Funding EnglishLanguage \"Any instance of &%Giving where the &%patient is an instance of &%Currency. Note that this class covers both financing, e.g. where a firm funds a software company with venture capital with the agreement that a certain percentage of the profits on the investment will be returned to the firm, and instances of &%UnilateralGiving, e.g. providing a tuition waiver and/or a stipend to a student as part of scholarship or fellowship.\")").
:- assert_kif("(=> (instance ?FUND Funding) (exists (?MONEY) (and (instance ?MONEY Currency) (patient ?FUND ?MONEY))))").
:- assert_kif("(subclass UnilateralGiving Giving)").
:- assert_kif("(documentation UnilateralGiving EnglishLanguage \"Any instance of &%Giving that is not part of a &%Transaction. In other words, any instance of &%Giving where nothing is received in return. Some examples of &%UnilateralGiving are: honorary awards, gifts, and financial grants.\")").
:- assert_kif("(=> (instance ?GIVE UnilateralGiving) (not (exists (?TRANS) (and (instance ?TRANS Transaction) (subProcess ?GIVE ?TRANS)))))").
:- assert_kif("(subclass Lending Giving)").
:- assert_kif("(documentation Lending EnglishLanguage \"The &%subclass of &%Giving &%Processes where the &%agent gives the &%destination something for a limited period of time with the expectation that it will be returned later (perhaps with interest).\")").
:- assert_kif("(<=> (exists (?BORROW) (and (instance ?BORROW Borrowing) (agent ?BORROW ?AGENT1) (origin ?BORROW ?AGENT2) (patient ?BORROW ?OBJECT))) (exists (?LEND) (and (instance ?LEND Lending) (agent ?LEND ?AGENT2) (destination ?LEND ?AGENT1) (patient ?LEND ?OBJECT))))").
:- assert_kif("(subclass GivingBack Giving)").
:- assert_kif("(documentation GivingBack EnglishLanguage \"Any instance of &%Giving where the &%agent gives something to the &%destination which was previously given to the &%agent by the &%destination, e.g. returing a book that was borrowed from someone.\")").
:- assert_kif("(=> (and (instance ?RETURN GivingBack) (agent ?RETURN ?AGENT) (destination ?RETURN ?DEST)) (exists (?GIVE) (and (instance ?GIVE Giving) (agent ?GIVE ?DEST) (destination ?GIVE ?AGENT) (earlier (WhenFn ?GIVE) (WhenFn ?RETURN)))))").
:- assert_kif("(subclass Getting ChangeOfPossession)").
:- assert_kif("(documentation Getting EnglishLanguage \"The &%subclass of &%ChangeOfPossession where the &%agent gets something. Note that the source from which something is obtained is specified with the &%origin &%CaseRole.\")").
:- assert_kif("(=> (and (instance ?GET Getting) (agent ?GET ?AGENT)) (destination ?GET ?AGENT))").
:- assert_kif("(subclass UnilateralGetting Getting)").
:- assert_kif("(relatedInternalConcept UnilateralGetting UnilateralGiving)").
:- assert_kif("(documentation UnilateralGetting EnglishLanguage \"Any instance of &%Getting that is not part of a &%Transaction. In other words, any instance of &%Getting where nothing is given in return. Some examples of &%UnilateralGetting are: appropriating, commandeering, stealing, etc.\")").
:- assert_kif("(=> (instance ?GET UnilateralGetting) (not (exists (?TRANS) (and (instance ?TRANS Transaction) (subProcess ?GET ?TRANS)))))").
:- assert_kif("(subclass Borrowing Getting)").
:- assert_kif("(documentation Borrowing EnglishLanguage \"The &%subclass of &%Getting &%Processes where the &%agent gets something for a limited period of time with the expectation that it will be returned later (perhaps with interest).\")").
:- assert_kif("(subclass Transaction ChangeOfPossession)").
:- assert_kif("(subclass Transaction DualObjectProcess)").
:- assert_kif("(documentation Transaction EnglishLanguage \"The &%subclass of &%ChangeOfPossession where something is exchanged for something else.\")").
:- assert_kif("(=> (instance ?TRANS Transaction) (exists (?AGENT1 ?AGENT2 ?GIVE1 ?GIVE2 ?OBJ1 ?OBJ2) (and (instance ?GIVE1 Giving) (instance ?GIVE2 Giving) (subProcess ?GIVE1 ?TRANS) (subProcess ?GIVE2 ?TRANS) (agent ?GIVE1 ?AGENT1) (agent ?GIVE2 ?AGENT2) (patient ?GIVE1 ?OBJ1) (patient ?GIVE2 ?OBJ2) (destination ?GIVE1 ?AGENT2) (destination ?GIVE2 ?AGENT1) (not (equal ?AGENT1 ?AGENT2)) (not (equal ?OBJ1 ?OBJ2)))))").
:- assert_kif("(subclass FinancialTransaction Transaction)").
:- assert_kif("(documentation FinancialTransaction EnglishLanguage \"A &%Transaction where an instance of &%FinancialInstrument is the subject of the action, and often is exchanged for something else.\")").
:- assert_kif("(=> (instance ?TRANS FinancialTransaction) (exists (?OBJ) (and (patient ?TRANS ?OBJ) (instance ?OBJ FinancialInstrument))))").
:- assert_kif("(instance transactionAmount BinaryPredicate)").
:- assert_kif("(instance transactionAmount SingleValuedRelation)").
:- assert_kif("(instance transactionAmount TotalValuedRelation)").
:- assert_kif("(domain transactionAmount 1 FinancialTransaction)").
:- assert_kif("(domain transactionAmount 2 CurrencyMeasure)").
:- assert_kif("(documentation transactionAmount EnglishLanguage \"(&%transactionAmount ?TRANSACTION ?AMOUNT) means that ?AMOUNT is an instance of &%CurrencyMeasure being exhanged in the &%FinancialTransaction ?TRANSACTION.\")").
:- assert_kif("(=> (transactionAmount ?TRANS ?AMOUNT) (exists (?OBJ) (and (patient ?TRANS ?OBJ) (monetaryValue ?OBJ ?AMOUNT))))").
:- assert_kif("(subclass ServiceProcess SocialInteraction)").
:- assert_kif("(documentation ServiceProcess EnglishLanguage \"&%ServiceProcess denotes the class of events in which one agent performs a service for another. The service need not be commercial, and it need not be the case that the &%serviceRecipient pays or recompenses the &%serviceProvider for the service.\")").
:- assert_kif("(subclass CommercialService FinancialTransaction)").
:- assert_kif("(documentation CommercialService EnglishLanguage \"Any &%FinancialTransaction by a &%CommercialAgent where the aim is to produce a profit.\")").
:- assert_kif("(subclass CommercialService ServiceProcess)").
:- assert_kif("(=> (instance ?BUSINESS CommercialService) (exists (?AGENT) (and (instance ?AGENT CommercialAgent) (agent ?BUSINESS ?AGENT))))").
:- assert_kif("(subclass Betting FinancialTransaction)").
:- assert_kif("(documentation Betting EnglishLanguage \"A &%FinancialTransaction where an instance of &%CurrencyMeasure is exchanged for the possibility of winning a larger instance of &%CurrencyMeasure within the context of some sort of &%Game.\")").
:- assert_kif("(subclass Buying FinancialTransaction)").
:- assert_kif("(relatedInternalConcept Buying Selling)").
:- assert_kif("(documentation Buying EnglishLanguage \"A &%FinancialTransaction in which an instance of &%CurrencyMeasure is exchanged for an instance of &%Physical.\")").
:- assert_kif("(=> (and (instance ?BUY Buying) (agent ?BUY ?AGENT)) (destination ?BUY ?AGENT))").
:- assert_kif("(subclass Selling FinancialTransaction)").
:- assert_kif("(documentation Selling EnglishLanguage \"A &%FinancialTransaction in which an instance of &%Physical is exchanged for an instance of &%CurrencyMeasure.\")").
:- assert_kif("(<=> (exists (?BUY) (and (instance ?BUY Buying) (agent ?BUY ?AGENT1) (origin ?BUY ?AGENT2) (patient ?BUY ?OBJECT))) (exists (?SELL) (and (instance ?SELL Selling) (agent ?SELL ?AGENT2) (destination ?SELL ?AGENT1) (patient ?SELL ?OBJECT))))").
:- assert_kif("(=> (and (instance ?SELL Selling) (agent ?SELL ?AGENT)) (origin ?SELL ?AGENT))").
:- assert_kif("(subclass Learning IntentionalPsychologicalProcess)").
:- assert_kif("(documentation Learning EnglishLanguage \"The &%Class of &%Processes which relate to the acquisition of information.\")").
:- assert_kif("(=> (and (instance ?LEARN Learning) (agent ?LEARN ?AGENT)) (instance ?AGENT CognitiveAgent))").
:- assert_kif("(=> (and (instance ?LEARN Learning) (agent ?LEARN ?AGENT) (patient ?LEARN ?PROP)) (and (holdsDuring (BeginFn (WhenFn ?LEARN)) (not (knows ?AGENT ?PROP))) (holdsDuring (EndFn (WhenFn ?LEARN)) (knows ?AGENT ?PROP))))").
:- assert_kif("(subclass Discovering IntentionalPsychologicalProcess)").
:- assert_kif("(documentation Discovering EnglishLanguage \"Finding something that was sought. Note that this class is restricted to cases of discovering something &%Physical. For cases involving the acquisition of knowledge, the class &%Learning should be used.\")").
:- assert_kif("(=> (and (instance ?DISCOVER Discovering) (patient ?DISCOVER ?OBJ)) (exists (?PURSUE) (and (instance ?PURSUE Pursuing) (meetsTemporally (WhenFn ?PURSUE) (WhenFn ?DISCOVER)))))").
:- assert_kif("(=> (and (instance ?DISCOVER Discovering) (patient ?DISCOVER ?OBJ) (holdsDuring (WhenFn ?DISCOVER) (located ?OBJ ?PLACE))) (exists (?LEARN) (and (instance ?LEARN Learning) (subProcess ?LEARN ?DISCOVER) (patient ?LEARN (located ?OBJ ?PLACE)))))").
:- assert_kif("(subclass Classifying IntentionalPsychologicalProcess)").
:- assert_kif("(documentation Classifying EnglishLanguage \"The &%Class of &%IntentionalPsychologicalProcesses which involve attaching a name or category to a thing or set of things. Note that &%Classifying is distinguished from &%Learning by the fact that the latter covers the acquisition by a &%CognitiveAgent of any &%Proposition, while the former involves the assignment of a label or category.\")").
:- assert_kif("(subclass Reasoning IntentionalPsychologicalProcess)").
:- assert_kif("(documentation Reasoning EnglishLanguage \"The &%Class of &%IntentionalPsychologicalProcesses which involve concluding, on the basis of either deductive or inductive evidence, that a particular &%Proposition or &%Sentence is true.\")").
:- assert_kif("(=> (instance ?AGENT CognitiveAgent) (capability Reasoning agent ?AGENT))").
:- assert_kif("(subclass Selecting IntentionalPsychologicalProcess)").
:- assert_kif("(documentation Selecting EnglishLanguage \"The &%Class of &%IntentionalPsychologicalProcesses which involve opting for one or more &%Entity out of a larger set of &%Entities. Note that this covers all cases of judging or evaluating.\")").
:- assert_kif("(subclass Deciding Selecting)").
:- assert_kif("(documentation Deciding EnglishLanguage \"The subclass of &%Selecting where the &%agent opts for one course of action out of a set of multiple possibilities that are open to him/her.\")").
:- assert_kif("(=> (and (instance ?DECIDE Deciding) (agent ?DECIDE ?AGENT) (patient ?DECIDE ?PROCESS)) (and (instance ?PROCESS IntentionalProcess) (agent ?PROCESS ?AGENT)))").
:- assert_kif("(subclass Voting Deciding)").
:- assert_kif("(documentation Voting EnglishLanguage \"&%Voting is the activity of voting in an &%Election. Voting is typically done by individuals, while &%Elections are conducted by &%Organizations. The voting process by an individual voter is part of an &%Election process.\")").
:- assert_kif("(=> (instance ?VOTE Voting) (exists (?ELECT) (and (instance ?ELECT Election) (subProcess ?VOTE ?ELECT))))").
:- assert_kif("(subclass Judging Selecting)").
:- assert_kif("(documentation Judging EnglishLanguage \"The subclass of &%Selecting where the &%agent opts for one belief out of a set of multiple possibilities that are available to him/her.\")").
:- assert_kif("(=> (and (instance ?JUDGE Judging) (agent ?JUDGE ?AGENT) (patient ?JUDGE ?PROPOSITION)) (and (holdsDuring (BeginFn (WhenFn ?JUDGE)) (not (believes ?AGENT ?PROPOSITION))) (holdsDuring (EndFn (WhenFn ?JUDGE)) (believes ?AGENT ?PROPOSITION))))").
:- assert_kif("(subclass Comparing IntentionalPsychologicalProcess)").
:- assert_kif("(subclass Comparing DualObjectProcess)").
:- assert_kif("(documentation Comparing EnglishLanguage \"The &%Class of &%IntentionalPsychologicalProcesses which involve comparing, relating, contrasting, etc. the properties of two or more &%Entities.\")").
:- assert_kif("(subclass Calculating IntentionalPsychologicalProcess)").
:- assert_kif("(documentation Calculating EnglishLanguage \"&%IntentionalPsychologicalProcesses which involve the consideration and/or manipulation of instances of &%Quantity.\")").
:- assert_kif("(subclass Measuring Calculating)").
:- assert_kif("(documentation Measuring EnglishLanguage \"The &%Class of &%Calculating &%Processes where the aim is to determine the &%PhysicalQuantity of some aspect of the &%patient.\")").
:- assert_kif("(=> (and (instance ?MEAS Measuring) (agent ?MEAS ?AGENT) (patient ?MEAS ?OBJ)) (exists (?QUANT ?UNIT) (holdsDuring (EndFn (WhenFn ?MEAS)) (knows ?AGENT (measure ?OBJ (MeasureFn ?QUANT ?UNIT))))))").
:- assert_kif("(subclass Counting Calculating)").
:- assert_kif("(documentation Counting EnglishLanguage \"Enumerating something. The &%Class of &%Calculating &%Processes where the aim is to determine the &%Number corresponding to the &%patient.\")").
:- assert_kif("(=> (and (instance ?COUNT Counting) (agent ?COUNT ?AGENT) (patient ?COUNT ?ENTITY)) (exists (?NUMBER) (knows ?AGENT (equal (CardinalityFn ?ENTITY) ?NUMBER))))").
:- assert_kif("(subclass Predicting IntentionalPsychologicalProcess)").
:- assert_kif("(documentation Predicting EnglishLanguage \"The &%Class of &%IntentionalPsychologicalProcesses which involve the formulation of a &%Proposition about a state of affairs which might be realized in the future.\")").
:- assert_kif("(=> (and (instance ?PREDICT Predicting) (patient ?PREDICT ?FORMULA)) (exists (?TIME) (and (holdsDuring ?TIME ?FORMULA) (or (before ?TIME (WhenFn ?PREDICT)) (earlier ?TIME (WhenFn ?PREDICT))))))").
:- assert_kif("(subclass Remembering PsychologicalProcess)").
:- assert_kif("(documentation Remembering EnglishLanguage \"The &%Class of &%PsychologicalProcesses which involve the recollection of prior experiences and/or of knowledge which was previously acquired.\")").
:- assert_kif("(=> (and (instance ?REMEMBER Remembering) (patient ?REMEMBER ?FORMULA)) (exists (?TIME) (and (holdsDuring ?TIME ?FORMULA) (or (before ?TIME (WhenFn ?REMEMBER)) (earlier ?TIME (WhenFn ?REMEMBER))))))").
:- assert_kif("(subclass Keeping IntentionalProcess)").
:- assert_kif("(documentation Keeping EnglishLanguage \"The &%Class of &%Processes where the &%agent keeps something in a particular location for an extended period of time.\")").
:- assert_kif("(=> (and (instance ?KEEP Keeping) (agent ?KEEP ?AGENT) (patient ?KEEP ?OBJ)) (exists (?PUT) (and (instance ?PUT Putting) (agent ?PUT ?AGENT) (patient ?PUT ?OBJ) (earlier (WhenFn ?PUT) (WhenFn ?KEEP)))))").
:- assert_kif("(=> (and (instance ?KEEP Keeping) (patient ?KEEP ?OBJ)) (exists (?PLACE) (forall (?TIME) (=> (temporalPart ?TIME (WhenFn ?KEEP)) (holdsDuring ?TIME (located ?OBJ ?PLACE))))))").
:- assert_kif("(subclass Confining Keeping)").
:- assert_kif("(documentation Confining EnglishLanguage \"The &%Class of &%Keeping &%Processes where the &%patient is a &%Human or an &%Animal and is kept involuntarily. This covers caging, imprisonment, jailing, etc.\")").
:- assert_kif("(=> (instance ?CONFINE Confining) (exists (?AGENT) (and (instance ?AGENT Animal) (patient ?CONFINE ?AGENT))))").
:- assert_kif("(=> (and (instance ?CONFINE Confining) (patient ?CONFINE ?PERSON) (instance ?PERSON Human)) (not (desires ?PERSON (patient ?CONFINE ?PERSON))))").
:- assert_kif("(subclass Maintaining IntentionalProcess)").
:- assert_kif("(documentation Maintaining EnglishLanguage \"The &%Class of &%Processes where the &%agent cares for or maintains the &%Object.\")").
:- assert_kif("(subclass Repairing IntentionalProcess)").
:- assert_kif("(relatedInternalConcept Repairing Maintaining)").
:- assert_kif("(documentation Repairing EnglishLanguage \"The &%Class of &%Processes where the &%agent makes a modification or series of modifications to an &%Object that is not functioning as intended so that it works properly.\")").
:- assert_kif("(=> (and (instance ?REPAIR Repairing) (patient ?REPAIR ?OBJ)) (exists (?DAMAGE) (and (instance ?DAMAGE Damaging) (patient ?DAMAGE ?OBJ) (earlier (WhenFn ?DAMAGE) (WhenFn ?REPAIR)))))").
:- assert_kif("(subclass TherapeuticProcess Repairing)").
:- assert_kif("(documentation TherapeuticProcess EnglishLanguage \"A &%Process that is carried out for the purpose of curing, improving or reducing the pain associated with a &%DiseaseOrSyndrome.\")").
:- assert_kif("(=> (and (instance ?PROC TherapeuticProcess) (patient ?PROC ?BIO)) (or (instance ?BIO Organism) (exists (?ORG) (and (instance ?ORG Organism) (part ?BIO ?ORG)))))").
:- assert_kif("(subclass Surgery TherapeuticProcess)").
:- assert_kif("(documentation Surgery EnglishLanguage \"Any &%TherapeuticProcess that involves making an incision in the &%Animal that is the &%patient of the &%TherapeuticProcess.\")").
:- assert_kif("(=> (and (instance ?ACT Surgery) (patient ?ACT ?ANIMAL)) (exists (?SUBACT) (and (instance ?SUBACT Cutting) (instance ?ANIMAL Animal) (patient ?SUBACT ?ANIMAL) (subProcess ?SUBACT ?ACT))))").
:- assert_kif("(subclass Damaging InternalChange)").
:- assert_kif("(disjoint Damaging Repairing)").
:- assert_kif("(documentation Damaging EnglishLanguage \"The &%Class of &%Processes where the &%agent brings about a situation where the &%patient no longer functions normally or as intended.\")").
:- assert_kif("(subclass Destruction Damaging)").
:- assert_kif("(documentation Destruction EnglishLanguage \"The &%subclass of &%Damagings in which the &%patient (or an essential element of the &%patient) is destroyed. Note that the difference between this concept and its superclass is solely one of extent.\")").
:- assert_kif("(<=> (instance ?PROCESS Destruction) (exists (?PATIENT) (and (patient ?PROCESS ?PATIENT) (time ?PATIENT (BeginFn (WhenFn ?PROCESS))) (not (time ?PATIENT (EndFn (WhenFn ?PROCESS)))))))").
:- assert_kif("(subclass Killing Destruction)").
:- assert_kif("(documentation Killing EnglishLanguage \"The &%subclass of &%Destruction in which the death of an &%Organism is caused by an &%Organism. Note that in cases of suicide the &%Organism would be the same in both cases.\")").
:- assert_kif("(=> (and (instance ?KILL Killing) (agent ?KILL ?AGENT) (patient ?KILL ?PATIENT)) (and (instance ?AGENT Organism) (instance ?PATIENT Organism)))").
:- assert_kif("(=> (and (instance ?KILL Killing) (patient ?KILL ?PATIENT)) (and (holdsDuring (BeginFn (WhenFn ?KILL)) (attribute ?PATIENT Living)) (holdsDuring (FutureFn (WhenFn ?KILL)) (attribute ?PATIENT Dead))))").
:- assert_kif("(=> (and (instance ?KILL Killing) (patient ?KILL ?OBJ)) (exists (?DEATH) (and (instance ?DEATH Death) (experiencer ?DEATH ?OBJ) (causes ?KILL ?DEATH))))").
:- assert_kif("(subclass Poking IntentionalProcess)").
:- assert_kif("(documentation Poking EnglishLanguage \"The &%Class of &%Processes where the &%agent pierces the surface of the &%Object with an &%instrument.\")").
:- assert_kif("(=> (and (instance ?POKE Poking) (agent ?POKE ?AGENT) (patient ?POKE ?OBJ) (instrument ?POKE ?INST)) (holdsDuring (WhenFn ?POKE) (connects ?INST ?AGENT ?OBJ)))").
:- assert_kif("(subclass Cutting Poking)").
:- assert_kif("(documentation Cutting EnglishLanguage \"The &%subclass of &%Poking &%Processes which involve a sharp &%instrument.\")").
:- assert_kif("(subclass Attaching DualObjectProcess)").
:- assert_kif("(disjoint Attaching Detaching)").
:- assert_kif("(relatedInternalConcept Attaching Putting)").
:- assert_kif("(documentation Attaching EnglishLanguage \"A &%Process where one &%Object becomes attached to another &%Object. Note that this differs from &%Putting in that two things which are attached may already be in the same location. Note that &%Combining is different from &%Attaching in that the former applies to &%Substances, while the latter applies to &%CorpuscularObjects. Note too that &%Attaching is different from &%Putting in that one or both of the two things which are attached may or may not be moved from the location where they were combined.\")").
:- assert_kif("(=> (and (instance ?ATTACH Attaching) (patient ?ATTACH ?OBJ1) (patient ?ATTACH ?OBJ2)) (and (holdsDuring (BeginFn (WhenFn ?ATTACH)) (not (connected ?OBJ1 ?OBJ2))) (holdsDuring (EndFn (WhenFn ?ATTACH)) (connected ?OBJ1 ?OBJ2))))").
:- assert_kif("(=> (instance ?ATTACH Attaching) (exists (?OBJ) (and (instance ?OBJ CorpuscularObject) (patient ?ATTACH ?OBJ))))").
:- assert_kif("(subclass Detaching DualObjectProcess)").
:- assert_kif("(documentation Detaching EnglishLanguage \"A &%Process where the &%agent detaches one thing from something else. Note that &%Detaching is different from &%Separating in that the latter applies to &%Substances, while the former applies to &%CorpuscularObjects. Note too that &%Detaching is different from &%Removing in that one or both of the two things which are detached may or may not be moved from the location where they were attached.\")").
:- assert_kif("(=> (and (instance ?DETACH Detaching) (patient ?DETACH ?OBJ1) (patient ?DETACH ?OBJ2)) (and (holdsDuring (BeginFn (WhenFn ?DETACH)) (connected ?OBJ1 ?OBJ2)) (holdsDuring (EndFn (WhenFn ?DETACH)) (not (connected ?OBJ1 ?OBJ2)))))").
:- assert_kif("(=> (instance ?DETACH Detaching) (exists (?OBJ) (and (instance ?OBJ CorpuscularObject) (patient ?DETACH ?OBJ))))").
:- assert_kif("(subclass Ungrasping Detaching)").
:- assert_kif("(documentation Ungrasping EnglishLanguage \"Any instance of &%Detaching which results in a situation where it is not the case that the &%agent &%grasps something which he/she &%grasps previously.\")").
:- assert_kif("(=> (and (instance ?RELEASE Ungrasping) (agent ?GRAB ?AGENT) (patient ?GRAB ?THING)) (and (holdsDuring (BeginFn (WhenFn ?RELEASE)) (grasps ?AGENT ?THING)) (holdsDuring (EndFn (WhenFn ?RELEASE)) (not (grasps ?AGENT ?THING)))))").
:- assert_kif("(subclass Combining DualObjectProcess)").
:- assert_kif("(documentation Combining EnglishLanguage \"A &%Process where two or more &%SelfConnectedObjects are incorporated into a single &%SelfConnectedObject. Note that &%Combining is different from &%Attaching in that the former results in one of the objects being &%part of the other, while &%Attaching only results in the two objects being &%connected with one another. Note too that &%Combining is different from &%Putting in that one or both of the two things which are combined may or may not be moved from the location where they were combined.\")").
:- assert_kif("(<=> (and (instance ?COMBINE Combining) (resource ?COMBINE ?OBJ1) (result ?COMBINE ?OBJ2)) (and (holdsDuring (BeginFn (WhenFn ?COMBINE)) (not (part ?OBJ1 ?OBJ2))) (holdsDuring (EndFn (WhenFn ?COMBINE)) (part ?OBJ1 ?OBJ2))))").
:- assert_kif("(=> (instance ?COMBINE Combining) (exists (?OBJ) (and (instance ?OBJ SelfConnectedObject) (patient ?COMBINE ?OBJ))))").
:- assert_kif("(subclass Separating DualObjectProcess)").
:- assert_kif("(disjoint Separating Combining)").
:- assert_kif("(documentation Separating EnglishLanguage \"A &%Process where a &%SelfConnectedObject is separated into (some of) its &%parts. Note that &%Separating is different from &%Detaching in that the latter only results in the two objects not being &%connected. Note too that &%Separating is different from &%Removing in that one or both of the two things which are separated may or may not be moved from the location where they were separated.\")").
:- assert_kif("(=> (instance ?SEPARATE Separating) (exists (?OBJ) (and (instance ?OBJ SelfConnectedObject) (patient ?SEPARATE ?OBJ))))").
:- assert_kif("(subclass ChemicalProcess InternalChange)").
:- assert_kif("(partition ChemicalProcess ChemicalSynthesis ChemicalDecomposition)").
:- assert_kif("(documentation ChemicalProcess EnglishLanguage \"A &%ChemicalProcess occurs whenever chemical compounds (&%CompoundSubstances) are formed or decomposed. For example, reactants disappear as chemical change occurs, and products appear as chemical change occurs. In a chemical change a chemical reaction takes place. Catalysts in a &%ChemicalProcess may speed up the reaction, but aren't themselves produced or consumed. Examples: rusting of iron and the decomposition of water, induced by an electric current, to gaseous hydrogen and gaseous oxygen.\")").
:- assert_kif("(=> (and (instance ?PROC ChemicalProcess) (or (resource ?PROC ?STUFF) (result ?PROC ?STUFF))) (instance ?STUFF PureSubstance))").
:- assert_kif("(subclass ChemicalSynthesis ChemicalProcess)").
:- assert_kif("(subclass ChemicalSynthesis Combining)").
:- assert_kif("(documentation ChemicalSynthesis EnglishLanguage \"The &%Class of &%ChemicalProcesses in which a &%CompoundSubstance is formed from simpler reactants.\")").
:- assert_kif("(=> (and (resource ?PROC ?SUBSTANCE1) (result ?PROC ?SUBSTANCE2) (instance ?SUBSTANCE1 ElementalSubstance) (instance ?SUBSTANCE2 CompoundSubstance)) (instance ?PROC ChemicalSynthesis))").
:- assert_kif("(<=> (instance ?COMPOUND CompoundSubstance) (exists (?ELEMENT1 ?ELEMENT2 ?PROCESS) (and (instance ?ELEMENT1 ElementalSubstance) (instance ?ELEMENT2 ElementalSubstance) (not (equal ?ELEMENT1 ?ELEMENT2)) (instance ?PROCESS ChemicalSynthesis) (resource ?PROCESS ?ELEMENT1) (resource ?PROCESS ?ELEMENT2) (result ?PROCESS ?COMPOUND))))").
:- assert_kif("(subclass ChemicalDecomposition ChemicalProcess)").
:- assert_kif("(subclass ChemicalDecomposition Separating)").
:- assert_kif("(documentation ChemicalDecomposition EnglishLanguage \"The &%Class of &%ChemicalProcesses in which a &%CompoundSubstance breaks down into simpler products.\")").
:- assert_kif("(=> (and (resource ?PROC ?SUBSTANCE1) (result ?PROC ?SUBSTANCE2) (instance ?SUBSTANCE1 CompoundSubstance) (instance ?SUBSTANCE2 ElementalSubstance)) (instance ?PROC ChemicalDecomposition))").
:- assert_kif("(subclass Combustion ChemicalDecomposition)").
:- assert_kif("(documentation Combustion EnglishLanguage \"The &%Class of &%ChemicalProcesses in which an &%Object reacts with oxygen and gives off heat. This includes all &%Processes in which something is burning.\")").
:- assert_kif("(=> (instance ?COMBUSTION Combustion) (exists (?HEAT ?LIGHT) (and (instance ?HEAT Heating) (instance ?LIGHT RadiatingLight) (subProcess ?HEAT ?COMBUSTION) (subProcess ?LIGHT ?COMBUSTION))))").
:- assert_kif("(instance Flammable PhysicalAttribute)").
:- assert_kif("(documentation Flammable EnglishLanguage \"The &%Attribute of being flammable at normal temperatures").
:- assert_kif("(i.e. not while a &%Plasma).\")").
:- assert_kif("(=> (attribute ?X Flammable) (capability Combustion patient ?X))").
:- assert_kif("(subclass InternalChange Process)").
:- assert_kif("(documentation InternalChange EnglishLanguage \"&%Processes which involve altering an internal property of an &%Object, e.g. the shape of the &%Object, its coloring, its structure, etc. &%Processes that are not instances of this class include changes that only affect the relationship to other objects, e.g. changes in spatial or temporal location.\")").
:- assert_kif("(=> (and (instance ?CHANGE InternalChange) (patient ?CHANGE ?OBJ)) (exists (?PROPERTY) (or (and (holdsDuring (BeginFn (WhenFn ?CHANGE)) (attribute ?OBJ ?PROPERTY)) (holdsDuring (EndFn (WhenFn ?CHANGE)) (not (attribute ?OBJ ?PROPERTY)))) (and (holdsDuring (BeginFn (WhenFn ?CHANGE)) (not (attribute ?OBJ ?PROPERTY))) (holdsDuring (EndFn (WhenFn ?CHANGE)) (attribute ?OBJ ?PROPERTY))))))").
:- assert_kif("(subclass SurfaceChange InternalChange)").
:- assert_kif("(documentation SurfaceChange EnglishLanguage \"&%Processes which involve altering the properties that apply to the surface of an &%Object.\")").
:- assert_kif("(=> (and (instance ?ALT SurfaceChange) (patient ?ALT ?OBJ)) (exists (?PART ?PROPERTY) (and (superficialPart ?PART ?OBJ) (or (and (holdsDuring (BeginFn (WhenFn ?ALT)) (attribute ?PART ?PROPERTY)) (holdsDuring (EndFn (WhenFn ?ALT)) (not (attribute ?PART ?PROPERTY)))) (and (holdsDuring (BeginFn (WhenFn ?ALT)) (not (attribute ?PART ?PROPERTY))) (holdsDuring (EndFn (WhenFn ?ALT)) (attribute ?PART ?PROPERTY)))))))").
:- assert_kif("(subclass Coloring SurfaceChange)").
:- assert_kif("(documentation Coloring EnglishLanguage \"The &%subclass of &%SurfaceChange where a &%ColorAttribute of the &%patient is altered. Note that the change in color may apply to just part of the object.\")").
:- assert_kif("(=> (and (instance ?COLORING Coloring) (patient ?COLORING ?OBJ)) (exists (?PROPERTY ?PART) (and (part ?PART ?OBJ) (instance ?PROPERTY ColorAttribute) (or (and (holdsDuring (BeginFn (WhenFn ?COLORING)) (attribute ?PART ?PROPERTY)) (holdsDuring (EndFn (WhenFn ?COLORING)) (not (attribute ?PART ?PROPERTY)))) (and (holdsDuring (BeginFn (WhenFn ?COLORING)) (not (attribute ?PART ?PROPERTY))) (holdsDuring (EndFn (WhenFn ?COLORING)) (attribute ?PART ?PROPERTY)))))))").
:- assert_kif("(subclass ShapeChange InternalChange)").
:- assert_kif("(documentation ShapeChange EnglishLanguage \"The &%Process of changing the shape of an &%Object.\")").
:- assert_kif("(=> (and (instance ?ALT ShapeChange) (patient ?ALT ?OBJ)) (exists (?PROPERTY) (and (instance ?PROPERTY ShapeAttribute) (or (and (holdsDuring (BeginFn (WhenFn ?ALT)) (attribute ?OBJ ?PROPERTY)) (holdsDuring (EndFn (WhenFn ?ALT)) (not (attribute ?OBJ ?PROPERTY)))) (and (holdsDuring (BeginFn (WhenFn ?ALT)) (not (attribute ?OBJ ?PROPERTY))) (holdsDuring (EndFn (WhenFn ?ALT)) (attribute ?OBJ ?PROPERTY)))))))").
:- assert_kif("(subclass ContentDevelopment IntentionalProcess)").
:- assert_kif("(documentation ContentDevelopment EnglishLanguage \"A &%subclass of &%IntentionalProcess in which content is modified, its form is altered or it is created anew.\")").
:- assert_kif("(=> (instance ?DEVELOP ContentDevelopment) (exists (?OBJ) (and (instance ?OBJ ContentBearingObject) (result ?DEVELOP ?OBJ))))").
:- assert_kif("(subclass Reading ContentDevelopment)").
:- assert_kif("(relatedInternalConcept Reading Interpreting)").
:- assert_kif("(documentation Reading EnglishLanguage \"A &%subclass of &%ContentDevelopment in which content is converted from a written form into a spoken representation. Note that the class &%Interpreting should be used in cases where a &%Text is read silently.\")").
:- assert_kif("(=> (instance ?READ Reading) (exists (?TEXT ?PROP) (and (instance ?TEXT Text) (containsInformation ?TEXT ?PROP) (realization ?READ ?PROP))))").
:- assert_kif("(subclass Writing ContentDevelopment)").
:- assert_kif("(documentation Writing EnglishLanguage \"A &%subclass of &%ContentDevelopment in which content is converted from one form (e.g. uttered, written or represented mentally) into a written form. Note that this class covers both transcription and original creation of written &%Texts.\")").
:- assert_kif("(subclass Encoding Writing)").
:- assert_kif("(documentation Encoding EnglishLanguage \"Converting a document or message into a formal language or into a code that can be understood only by a relatively small body of &%Agents. Generally speaking, this hinders wide dissemination of the content in the original document or message.\")").
:- assert_kif("(subclass Decoding Writing)").
:- assert_kif("(disjoint Decoding Encoding)").
:- assert_kif("(documentation Decoding EnglishLanguage \"Converting a document or message that has previously been encoded (see &%Encoding) into a &%Language that can be understood by a relatively large number of speakers.\")").
:- assert_kif("(=> (and (instance ?DECODE Decoding) (patient ?DECODE ?DOC1)) (exists (?ENCODE ?DOC2 ?TIME) (and (containsInformation ?DOC2 ?PROP) (containsInformation ?DOC1 ?PROP) (temporalPart ?TIME (PastFn (WhenFn ?DECODE))) (holdsDuring ?TIME (and (instance ?ENCODE Encoding) (patient ?ENCODE ?DOC2))))))").
:- assert_kif("(subclass Translating ContentDevelopment)").
:- assert_kif("(subclass Translating DualObjectProcess)").
:- assert_kif("(documentation Translating EnglishLanguage \"Converting content from one &%Language into another. This covers oral translation (i.e. interpreting) as well as written translation.\")").
:- assert_kif("(=> (and (instance ?TRANSLATE Translating) (patient ?TRANSLATE ?EXPRESSION1) (result ?TRANSLATE ?EXPRESSION2)) (exists (?LANGUAGE1 ?LANGUAGE2 ?ENTITY) (and (representsInLanguage ?EXPRESSION1 ?ENTITY ?LANGUAGE1) (representsInLanguage ?EXPRESSION2 ?ENTITY ?LANGUAGE2) (not (equal ?LANGUAGE1 ?LANGUAGE2)))))").
:- assert_kif("(subclass Wetting Putting)").
:- assert_kif("(documentation Wetting EnglishLanguage \"The &%Class of &%Processes where a &%Liquid is added to an &%Object.\")").
:- assert_kif("(=> (instance ?WET Wetting) (exists (?OBJ) (and (patient ?WET ?OBJ) (holdsDuring (BeginFn (WhenFn ?WET)) (not (attribute ?OBJ Damp))) (holdsDuring (EndFn (WhenFn ?WET)) (attribute ?OBJ Damp)))))").
:- assert_kif("(=> (instance ?WET Wetting) (exists (?OBJ) (and (attribute ?OBJ Liquid) (patient ?WET ?OBJ))))").
:- assert_kif("(subclass Drying Removing)").
:- assert_kif("(documentation Drying EnglishLanguage \"The &%Class of &%Processes where a &%Liquid is removed from an &%Object.\")").
:- assert_kif("(=> (and (instance ?DRY Drying) (patient ?DRY ?OBJ)) (holdsDuring (EndFn (WhenFn ?DRY)) (attribute ?OBJ Dry)))").
:- assert_kif("(subclass Creation InternalChange)").
:- assert_kif("(relatedInternalConcept Creation Destruction)").
:- assert_kif("(documentation Creation EnglishLanguage \"The &%subclass of &%Process in which something is created. Note that the thing created is specified with the &%result &%CaseRole.\")").
:- assert_kif("(=> (instance ?ACTION Creation) (exists (?RESULT) (result ?ACTION ?RESULT)))").
:- assert_kif("(<=> (instance ?PROCESS Creation) (exists (?PATIENT) (and (patient ?PROCESS ?PATIENT) (time ?PATIENT (EndFn (WhenFn ?PROCESS))) (not (time ?PATIENT (BeginFn (WhenFn ?PROCESS)))))))").
:- assert_kif("(subclass Making Creation)").
:- assert_kif("(subclass Making IntentionalProcess)").
:- assert_kif("(documentation Making EnglishLanguage \"The &%subclass of &%Creation in which an individual &%Artifact or a type of &%Artifact is made.\")").
:- assert_kif("(subclass Constructing Making)").
:- assert_kif("(documentation Constructing EnglishLanguage \"The &%subclass of &%Making in which a &%StationaryArtifact is built.\")").
:- assert_kif("(<=> (exists (?BUILD) (and (instance ?BUILD Constructing) (result ?BUILD ?ARTIFACT))) (instance ?ARTIFACT StationaryArtifact))").
:- assert_kif("(subclass Manufacture Making)").
:- assert_kif("(documentation Manufacture EnglishLanguage \"The &%Making of &%Artifacts on a mass scale.\")").
:- assert_kif("(subclass Publication Manufacture)").
:- assert_kif("(subclass Publication ContentDevelopment)").
:- assert_kif("(documentation Publication EnglishLanguage \"The &%Manufacture of &%Texts. Note that there is no implication that the &%Texts are distributed. Such distribution, when it occurs, is an instance of &%Dissemination.\")").
:- assert_kif("(=> (and (instance ?PUB Publication) (patient ?PUB ?TEXT)) (subclass ?TEXT Text))").
:- assert_kif("(subclass Cooking Making)").
:- assert_kif("(documentation Cooking EnglishLanguage \"The &%Making of an &%instance of &%Food. Note that this can cover any preparation of &%Food, e.g. making a salad, cutting up fruit, etc. It does not necessarily involve the application of heat.\")").
:- assert_kif("(=> (instance ?COOK Cooking) (exists (?FOOD) (and (instance ?FOOD (FoodForFn Organism)) (result ?COOK ?FOOD))))").
:- assert_kif("(subclass Pursuing IntentionalProcess)").
:- assert_kif("(documentation Pursuing EnglishLanguage \"The class of &%IntentionalProcesses where something is sought. Some examples would be hunting, shopping, trawling, and stalking.\")").
:- assert_kif("(=> (instance ?PURSUE Pursuing) (exists (?OBJ) (and (instance ?OBJ Object) (patient ?PURSUE ?OBJ))))").
:- assert_kif("(=> (and (instance ?PURSUE Pursuing) (agent ?PURSUE ?AGENT) (patient ?PURSUE ?OBJ)) (holdsDuring ?PURSUE (wants ?AGENT ?OBJ)))").
:- assert_kif("(=> (and (instance ?PURSUE Pursuing) (agent ?PURSUE ?AGENT) (patient ?PURSUE ?OBJ)) (holdsDuring ?PURSUE (not (possesses ?AGENT ?OBJ))))").
:- assert_kif("(subclass Hunting Pursuing)").
:- assert_kif("(documentation Hunting EnglishLanguage \"Hunting is the class of &%Processes in which an animal or animals are pursued and sometimes captured and/or killed.\")").
:- assert_kif("(=> (instance ?H Hunting) (exists (?T) (and (instance ?T Animal) (patient ?H ?T))))").
:- assert_kif("(=> (and (instance ?H Hunting) (patient ?H ?P)) (hasPurpose ?H (exists (?PROC) (and (patient ?PROC ?P) (or (instance ?PROC Confining) (instance ?PROC Killing))))))").
:- assert_kif("(subclass Investigating IntentionalPsychologicalProcess)").
:- assert_kif("(documentation Investigating EnglishLanguage \"The class of &%IntentionalPsychologicalProcesses where the &%agent attempts to obtaina information (i.e. a &%Proposition denoted by a &%Formula).\")").
:- assert_kif("(=> (and (instance ?INVESTIGATE Investigating) (patient ?INVESTIGATE ?PROP)) (instance ?PROP Formula))").
:- assert_kif("(=> (and (instance ?INVESTIGATE Investigating) (agent ?INVESTIGATE ?AGENT) (patient ?INVESTIGATE ?PROP)) (holdsDuring (WhenFn ?INVESTIGATE) (not (knows ?AGENT ?PROP))))").
:- assert_kif("(subclass Experimenting Investigating)").
:- assert_kif("(documentation Experimenting EnglishLanguage \"&%Investigating the truth of a &%Proposition by constructing and observing a trial. Note that the trial may be either controlled or uncontrolled, blind or not blind.\")").
:- assert_kif("(subclass DiagnosticProcess Investigating)").
:- assert_kif("(documentation DiagnosticProcess EnglishLanguage \"A &%Process that is carried out for the purpose of determining the nature of a &%DiseaseOrSyndrome.\")").
:- assert_kif("(=> (and (instance ?PROC DiagnosticProcess) (agent ?PROC ?AGENT)) (exists (?CAUSE) (hasPurposeForAgent ?PROC (knows ?AGENT (causes ?CAUSE ?PROC)) ?AGENT)))").
:- assert_kif("(subclass SocialInteraction IntentionalProcess)").
:- assert_kif("(documentation SocialInteraction EnglishLanguage \"The &%subclass of &%IntentionalProcess that involves interactions between &%CognitiveAgents.\")").
:- assert_kif("(=> (instance ?INTERACTION SocialInteraction) (exists (?AGENT1 ?AGENT2) (and (involvedInEvent ?INTERACTION ?AGENT1) (involvedInEvent ?INTERACTION ?AGENT2) (instance ?AGENT1 Agent) (instance ?AGENT2 Agent) (not (equal ?AGENT1 ?AGENT2)))))").
:- assert_kif("(subclass Pretending SocialInteraction)").
:- assert_kif("(documentation Pretending EnglishLanguage \"Any &%SocialInteraction where a &%CognitiveAgent or &%Group of &%CognitiveAgents attempts to make another &%CognitiveAgent or &%Group of &%CognitiveAgents believe something that is false. This covers deceit, affectation, impersonation, and entertainment productions, to give just a few examples.\")").
:- assert_kif("(=> (instance ?PRETEND Pretending) (exists (?PERSON ?PROP) (and (hasPurpose ?PRETEND (believes ?PERSON ?PROP)) (truth ?PROP False))))").
:- assert_kif("(subclass Communication SocialInteraction)").
:- assert_kif("(subclass Communication ContentBearingProcess)").
:- assert_kif("(partition Communication Stating Supposing Directing Committing Expressing Declaring)").
:- assert_kif("(relatedInternalConcept Communication ContentDevelopment)").
:- assert_kif("(documentation Communication EnglishLanguage \"A &%SocialInteraction that involves the transfer of information between two or more &%CognitiveAgents. Note that &%Communication is closely related to, but essentially different from, &%ContentDevelopment. The latter involves the creation or modification of a &%ContentBearingObject, while &%Communication is the transfer of information for the purpose of conveying a message.\")").
:- assert_kif("(=> (instance ?COMMUNICATE Communication) (exists (?PHYS ?ENTITY ?AGENT1 ?AGENT2) (and (refers ?PHYS ?ENTITY) (patient ?COMMUNICATE ?PHYS) (instance ?AGENT1 CognitiveAgent) (agent ?COMMUNICATE ?AGENT1) (instance ?AGENT2 CognitiveAgent) (destination ?COMMUNICATE ?AGENT2))))").
:- assert_kif("(subclass Disseminating Communication)").
:- assert_kif("(documentation Disseminating EnglishLanguage \"Any &%Communication that involves a single &%agent and many &%destinations. This covers the release of a published book, broadcasting, a theatrical performance, giving orders to assembled troops, delivering a public lecture, etc.\")").
:- assert_kif("(=> (instance ?DISSEMINATE Disseminating) (exists (?AGENT1 ?AGENT2) (and (destination ?DISSEMINATE ?AGENT1) (instance ?AGENT1 CognitiveAgent) (destination ?DISSEMINATE ?AGENT2) (instance ?AGENT2 CognitiveAgent) (not (equal ?AGENT1 ?AGENT2)))))").
:- assert_kif("(subclass Demonstrating Disseminating)").
:- assert_kif("(documentation Demonstrating EnglishLanguage \"Exhibiting something or a range of things before the public in a particular location. This would cover software demos, theatrical plays, lectures, dance and music recitals, museum exhibitions, etc.\")").
:- assert_kif("(=> (instance ?DEMO Demonstrating) (exists (?PERSON) (attends ?DEMO ?PERSON)))").
:- assert_kif("(subrelation attends experiencer)").
:- assert_kif("(domain attends 1 Demonstrating)").
:- assert_kif("(domain attends 2 Human)").
:- assert_kif("(documentation attends EnglishLanguage \"(&%attends ?DEMO ?PERSON) means that ?PERSON attends, i.e. is a member of the audience, of the performance event ?DEMO.\")").
:- assert_kif("(subclass Gesture Communication)").
:- assert_kif("(subclass Gesture BodyMotion)").
:- assert_kif("(documentation Gesture EnglishLanguage \"Any &%BodyMotion, e.g. a hand wave, a nod of the head, a smile, which is also an instance of &%Communication.\")").
:- assert_kif("(subclass Advertising Disseminating)").
:- assert_kif("(documentation Advertising EnglishLanguage \"A &%Disseminating whose purpose is to promote the sale of an &%Object represented in a &%Text or &%Icon").
:- assert_kif("(the advertisement).\")").
:- assert_kif("(=> (instance ?ADVERT Advertising) (exists (?OBJ) (and (refers ?ADVERT ?OBJ) (hasPurpose ?ADVERT (exists (?SALE) (and (instance ?SALE Selling) (patient ?SALE ?OBJ)))))))").
:- assert_kif("(subclass Expressing Communication)").
:- assert_kif("(documentation Expressing EnglishLanguage \"Instances of this &%Class express a state of the &%agent. For example, Jane thanked Barbara for the present she had given her. The thanking in this case expresses the gratitude of Jane towards Barbara. Note that &%Expressing, unlike the other speech act types, is not a subclass of &%LinguisticCommunication. This is because emotions, for example, can be expressed without language, e.g. by smiling.\")").
:- assert_kif("(=> (and (instance ?EXPRESS Expressing) (agent ?EXPRESS ?AGENT)) (exists (?STATE) (and (instance ?STATE StateOfMind) (attribute ?AGENT ?STATE) (represents ?EXPRESS ?STATE))))").
:- assert_kif("(subclass LinguisticCommunication Communication)").
:- assert_kif("(documentation LinguisticCommunication EnglishLanguage \"A &%Communication that involves the transfer of information via a &%LinguisticExpression.\")").
:- assert_kif("(=> (instance ?COMMUNICATE LinguisticCommunication) (exists (?OBJ) (and (represents ?COMMUNICATE ?OBJ) (instance ?OBJ LinguisticExpression) (patient ?COMMUNICATE ?OBJ))))").
:- assert_kif("(subclass Stating LinguisticCommunication)").
:- assert_kif("(documentation Stating EnglishLanguage \"Instances of this &%Class commit the &%agent to some truth. For example, John claimed that the moon is made of green cheese.\")").
:- assert_kif("(=> (and (instance ?STATE Stating) (agent ?STATE ?AGENT) (patient ?STATE ?FORMULA) (instance ?FORMULA Formula)) (holdsDuring (WhenFn ?STATE) (believes ?AGENT ?FORMULA)))").
:- assert_kif("(subclass Disagreeing Stating)").
:- assert_kif("(documentation Disagreeing EnglishLanguage \"A &%Stating in which two &%Agents have contradictory statements. This is distinguished from &%Arguing in that the statement in dispute may be a simple assertion, rather than a chain of deduction, and that two entities must be disagreeing with each other, whereas a single entity may craft an argument for a given point of view, without the need for another agent to disagree with.\")").
:- assert_kif("(=> (instance ?DIS Disagreeing) (exists (?A1 ?A2 ?STATE1 ?STATE2 ?STMT1 ?STMT2) (and (subProcess ?STATE1 ?DIS) (subProcess ?STATE2 ?DIS) (agent ?STATE1 ?A1) (agent ?STATE2 ?A2) (not (equal ?A1 ?A2)) (containsInformation ?STATE1 ?STMT1) (containsInformation ?STATE2 ?STMT2) (not (consistent ?STMT1 ?STMT2)))))").
:- assert_kif("(subclass Supposing LinguisticCommunication)").
:- assert_kif("(documentation Supposing EnglishLanguage \"Instances of this &%Class suppose, for the sake of argument, that a proposition is true. For example, John considered what he would do if he won the lottery.\")").
:- assert_kif("(subclass Directing LinguisticCommunication)").
:- assert_kif("(documentation Directing EnglishLanguage \"Instances of this &%Class urge some further action among the receivers. A &%Directing can be an &%Ordering, a &%Requesting or a &%Questioning.\")").
:- assert_kif("(subclass Ordering Directing)").
:- assert_kif("(documentation Ordering EnglishLanguage \"A &%Directing in which the receiver is commanded to realize the content of a &%ContentBearingObject. Orders are injunctions, the disobedience of which involves sanctions, or which express an obligation upon the part of the orderee.\")").
:- assert_kif("(=> (and (instance ?ORDER Ordering) (patient ?ORDER ?FORMULA)) (modalAttribute ?FORMULA Obligation))").
:- assert_kif("(subclass Requesting Directing)").
:- assert_kif("(documentation Requesting EnglishLanguage \"A request expresses a desire that some future action be performed. For example, the 5th Battalion requested air support from the 3rd Bomber Group. Note that this class covers proposals, recommendations, suggestions, etc.\")").
:- assert_kif("(=> (and (instance ?REQUEST Requesting) (agent ?REQUEST ?AGENT) (patient ?REQUEST ?FORMULA) (instance ?FORMULA Formula)) (desires ?AGENT ?FORMULA))").
:- assert_kif("(subclass Questioning Directing)").
:- assert_kif("(documentation Questioning EnglishLanguage \"A request for information. For example, John asked bill if the President had said anything about taxes in his State of the Union address.\")").
:- assert_kif("(=> (and (instance ?QUESTION Questioning) (agent ?QUESTION ?AGENT) (patient ?QUESTION ?FORMULA) (instance ?FORMULA Formula)) (holdsDuring (WhenFn ?QUESTION) (not (knows ?AGENT ?FORMULA))))").
:- assert_kif("(subclass Committing LinguisticCommunication)").
:- assert_kif("(documentation Committing EnglishLanguage \"Instances of this &%Class commit the &%agent to some future course. For example, Bob promised Susan that he would be home by 11pm.\")").
:- assert_kif("(=> (and (instance ?COMMIT Committing) (patient ?COMMIT ?FORMULA) (instance ?FORMULA Formula)) (modalAttribute ?FORMULA Promise))").
:- assert_kif("(subclass Offering Committing)").
:- assert_kif("(documentation Offering EnglishLanguage \"The subclass of &%Committing in which a &%CognitiveAgent offers something &%Physical to another agent. Offerings may be unconditional (in which case they are a promise to effect a &%UnilateralGiving) or conditional (in which case they are a promise to effect a &%Transaction of some sort).\")").
:- assert_kif("(subclass Declaring LinguisticCommunication)").
:- assert_kif("(documentation Declaring EnglishLanguage \"The &%Class of &%LinguisticCommunications that effect an institutional alteration when performed by competent authority. Some examples are nominating, marrying, and excommunicating.\")").
:- assert_kif("(=> (instance ?DECLARE Declaring) (exists (?PROP ?NORM) (or (confersNorm ?DECLARE ?PROP ?NORM) (deprivesNorm ?DECLARE ?PROP ?NORM))))").
:- assert_kif("(subclass Naming Declaring)").
:- assert_kif("(documentation Naming EnglishLanguage \"The &%Process of assigning a name to someone or something.\")").
:- assert_kif("(=> (and (instance ?PROCESS Naming) (patient ?PROCESS ?THING) (destination ?PROCESS ?NAME)) (holdsDuring (FutureFn (WhenFn ?PROCESS)) (names ?NAME ?THING)))").
:- assert_kif("(subclass Cooperation SocialInteraction)").
:- assert_kif("(documentation Cooperation EnglishLanguage \"The &%subclass of &%SocialInteraction where the participants involved work together for the achievement of a common goal.\")").
:- assert_kif("(=> (instance ?COOPERATE Cooperation) (exists (?PURP) (forall (?AGENT) (=> (agent ?COOPERATE ?AGENT) (hasPurposeForAgent ?COOPERATE ?PURP ?AGENT)))))").
:- assert_kif("(subclass Meeting SocialInteraction)").
:- assert_kif("(documentation Meeting EnglishLanguage \"The coming together of two or more &%CognitiveAgents for the purpose of &%Communication. This covers informal meetings, e.g. visits with family members, and formal meetings, e.g. a board of directors meeting.\")").
:- assert_kif("(=> (and (instance ?MEET Meeting) (agent ?MEET ?AGENT1) (agent ?MEET ?AGENT2)) (holdsDuring (WhenFn ?MEET) (orientation ?AGENT1 ?AGENT2 Near)))").
:- assert_kif("(=> (instance ?MEET Meeting) (exists (?AGENT1 ?AGENT2) (and (agent ?MEET ?AGENT1) (agent ?MEET ?AGENT2) (hasPurpose ?MEET (exists (?COMM) (and (instance ?COMM Communication) (agent ?COMM ?AGENT1) (agent ?COMM ?AGENT2)))))))").
:- assert_kif("(subclass Contest SocialInteraction)").
:- assert_kif("(documentation Contest EnglishLanguage \"A &%SocialInteraction where the &%agent and &%patient are &%CognitiveAgents who are trying to defeat one another. Note that this concept is often applied in a metaphorical sense in natural language, when we speak, e.g., of the struggle of plants for space or sunlight, or of bacteria for food resources in some environment.\")").
:- assert_kif("(=> (instance ?CONTEST Contest) (exists (?AGENT1 ?AGENT2 ?PURP1 ?PURP2) (and (agent ?CONTEST ?AGENT1) (agent ?CONTEST ?AGENT2) (hasPurposeForAgent ?CONTEST ?PURP1 ?AGENT1) (hasPurposeForAgent ?CONTEST ?PURP2 ?AGENT2) (not (equal ?AGENT1 ?AGENT2)) (not (equal ?PURP1 ?PURP2)))))").
:- assert_kif("(subclass ViolentContest Contest)").
:- assert_kif("(documentation ViolentContest EnglishLanguage \"A &%Contest where one participant attempts to physically injure another participant.\")").
:- assert_kif("(subclass War ViolentContest)").
:- assert_kif("(documentation War EnglishLanguage \"A military confrontation between two or more &%GeopoliticalAreas or &%Organizations whose members are &%GeopoliticalAreas. As the corresponding axiom specifies, a &%War is made up of &%Battles.\")").
:- assert_kif("(=> (instance ?WAR War) (exists (?BATTLE) (and (instance ?BATTLE Battle) (subProcess ?BATTLE ?WAR))))").
:- assert_kif("(=> (and (instance ?WAR War) (agent ?WAR ?AGENT)) (or (instance ?AGENT GeopoliticalArea) (and (instance ?AGENT Organization) (forall (?MEMBER) (=> (member ?MEMBER ?AGENT) (instance ?MEMBER GeopoliticalArea))))))").
:- assert_kif("(subclass Battle ViolentContest)").
:- assert_kif("(documentation Battle EnglishLanguage \"A &%ViolentContest between two or more military units within the context of a war. Note that this does not cover the metaphorical sense of 'battle', which simply means a struggle of some sort. This sense should be represented with the more general concept of &%Contest.\")").
:- assert_kif("(=> (instance ?BATTLE Battle) (exists (?WAR) (and (instance ?WAR War) (subProcess ?BATTLE ?WAR))))").
:- assert_kif("(=> (instance ?BATTLE Battle) (exists (?ATTACK) (and (instance ?ATTACK ViolentContest) (subProcess ?ATTACK ?BATTLE))))").
:- assert_kif("(subclass Game Contest)").
:- assert_kif("(subclass Game RecreationOrExercise)").
:- assert_kif("(documentation Game EnglishLanguage \"A &%Contest whose purpose is the enjoyment/stimulation of the participants or spectators of the &%Game.\")").
:- assert_kif("(subclass Sport Game)").
:- assert_kif("(documentation Sport EnglishLanguage \"A &%Game which requires some degree of physical exercion from the participants of the game.\")").
:- assert_kif("(subclass LegalAction Contest)").
:- assert_kif("(documentation LegalAction EnglishLanguage \"Any &%Process where a &%CognitiveAgent seeks to obtain something through a court of law.\")").
:- assert_kif("(subclass Maneuver IntentionalProcess)").
:- assert_kif("(documentation Maneuver EnglishLanguage \"An intentional move or play within a &%Contest. In many cases, a &%Maneuver is a realization of part of a strategy for winning the &%Contest, but it also may be just an arbitrary or semi-arbitrary division of the overarching &%Contest, e.g. innings in a baseball game.\")").
:- assert_kif("(=> (instance ?MOVE Maneuver) (exists (?CONTEST) (and (instance ?CONTEST Contest) (subProcess ?MOVE ?CONTEST))))").
:- assert_kif("(subclass Attack Maneuver)").
:- assert_kif("(documentation Attack EnglishLanguage \"A &%Maneuver in a &%ViolentContest where the &%agent attempts to inflict damage on the &%patient.\")").
:- assert_kif("(=> (instance ?ATTACK Attack) (exists (?CONTEST) (and (instance ?CONTEST ViolentContest) (subProcess ?ATTACK ?CONTEST))))").
:- assert_kif("(=> (and (instance ?ATTACK Attack) (agent ?ATTACK ?AGENT) (patient ?ATTACK ?OBJ)) (hasPurposeForAgent ?ATTACK (exists (?DAMAGE) (and (instance ?DAMAGE Damaging) (patient ?DAMAGE ?OBJ))) ?AGENT))").
:- assert_kif("(subclass DefensiveManeuver Maneuver)").
:- assert_kif("(documentation DefensiveManeuver EnglishLanguage \"A &%Maneuver in a &%ViolentContest where the &%agent attempts to avoid being damaged.\")").
:- assert_kif("(=> (instance ?DEFENSE DefensiveManeuver) (exists (?CONTEST) (and (instance ?CONTEST ViolentContest) (subProcess ?DEFENSE ?CONTEST))))").
:- assert_kif("(=> (and (instance ?DEFENSE DefensiveManeuver) (agent ?DEFENSE ?AGENT)) (hasPurposeForAgent ?DEFENSE (not (exists (?DAMAGE) (and (instance ?DAMAGE Damaging) (patient ?DAMAGE ?AGENT)))) ?AGENT))").
:- assert_kif("(=> (and (instance ?MANEUVER Maneuver) (instance ?CONTEST ViolentContest) (subProcess ?MANEUVER ?CONTEST)) (or (instance ?MANEUVER Attack) (instance ?MANEUVER DefensiveManeuver)))").
:- assert_kif("(subclass Perception PsychologicalProcess)").
:- assert_kif("(documentation Perception EnglishLanguage \"Sensing some aspect of the material world. Note that the &%agent of this sensing is assumed to be an &%Animal.\")").
:- assert_kif("(=> (and (instance ?PERCEPT Perception) (agent ?PERCEPT ?AGENT)) (instance ?AGENT Animal))").
:- assert_kif("(=> (instance ?AGENT SentientAgent) (capability Perception experiencer ?AGENT))").
:- assert_kif("(subclass Seeing Perception)").
:- assert_kif("(documentation Seeing EnglishLanguage \"The &%subclass of &%Perception in which the sensing is done by an ocular &%Organ.\")").
:- assert_kif("(=> (and (instance ?SEE Seeing) (agent ?SEE ?AGENT) (patient ?SEE ?OBJ)) (exists (?PROP) (and (instance ?PROP ColorAttribute) (knows ?AGENT (attribute ?OBJ ?PROP)))))").
:- assert_kif("(=> (and (instance ?SEE Seeing) (patient ?SEE ?OBJ)) (holdsDuring (WhenFn ?SEE) (attribute ?OBJ Illuminated)))").
:- assert_kif("(=> (and (instance ?SEE Seeing) (patient ?SEE ?OBJ)) (exists (?ATTR) (and (instance ?ATTR ColorAttribute) (holdsDuring (WhenFn ?SEE) (attribute ?OBJ ?ATTR)))))").
:- assert_kif("(subclass Looking Seeing)").
:- assert_kif("(subclass Looking IntentionalProcess)").
:- assert_kif("(documentation Looking EnglishLanguage \"Any instance of &%Seeing which is intentional.\")").
:- assert_kif("(subclass Smelling Perception)").
:- assert_kif("(documentation Smelling EnglishLanguage \"The &%subclass of &%Perception in which the sensing is done by an olefactory &%Organ.\")").
:- assert_kif("(=> (and (instance ?SMELL Smelling) (patient ?SMELL ?OBJ)) (exists (?ATTR) (and (instance ?ATTR OlfactoryAttribute) (attribute ?OBJ ?ATTR))))").
:- assert_kif("(subclass Tasting Perception)").
:- assert_kif("(documentation Tasting EnglishLanguage \"The &%subclass of &%Perception in which the sensing is done by of an &%Organ which can discriminate various tastes.\")").
:- assert_kif("(=> (and (instance ?TASTE Tasting) (patient ?TASTE ?OBJ)) (exists (?ATTR) (and (instance ?ATTR TasteAttribute) (attribute ?OBJ ?ATTR))))").
:- assert_kif("(subclass Hearing Perception)").
:- assert_kif("(documentation Hearing EnglishLanguage \"The &%subclass of &%Perception in which the sensing is done by an auditory &%Organ.\")").
:- assert_kif("(=> (and (instance ?HEAR Hearing) (patient ?HEAR ?OBJ)) (exists (?ATTR) (and (instance ?ATTR SoundAttribute) (attribute ?OBJ ?ATTR))))").
% :- assert_kif("; NS: add.").
:- assert_kif("(subclass SoundAttribute PerceptualAttribute)").
:- assert_kif("(subclass SoundAttribute RelationalAttribute)").
:- assert_kif("(documentation SoundAttribute EnglishLanguage \"The volume of sound relative to a listener.\")").
:- assert_kif("(instance Audible SoundAttribute)").
:- assert_kif("(documentation Audible EnglishLanguage \"A sound level capable of being heard by a &%Human.\")").
:- assert_kif("(=> (and (instance ?SOUND RadiatingSound) (agent ?SOUND ?OBJ) (attribute ?SOUND Audible)) (exists (?HUMAN) (and (instance ?HUMAN Human) (capability (KappaFn ?HEAR (and (instance ?HEAR Hearing) (agent ?HEAR ?HUMAN) (destination ?HEAR ?HUMAN) (origin ?HEAR ?OBJ))) agent ?HUMAN))))").
:- assert_kif("(subclass Listening Hearing)").
:- assert_kif("(subclass Listening IntentionalProcess)").
:- assert_kif("(documentation Listening EnglishLanguage \"Any instance of &%Hearing which is intentional.\")").
:- assert_kif("(subclass TactilePerception Perception)").
:- assert_kif("(documentation TactilePerception EnglishLanguage \"The &%subclass of &%Perception in which the sensing is done by &%Touching. Note that &%Touching need not involve &%TactilePerception. For example, a person who has lost all sensation in both of his legs would have no &%TactilePerception of anything his legs were &%Touching.\")").
:- assert_kif("(=> (instance ?TACTILE TactilePerception) (exists (?TOUCH) (and (instance ?TOUCH Touching) (subProcess ?TOUCH ?TACTILE))))").
:- assert_kif("(subclass Radiating Motion)").
:- assert_kif("(documentation Radiating EnglishLanguage \"Processes in which some form of electromagnetic radiation, e.g. radio waves, light waves, electrical energy, etc., is given off or absorbed by something else.\")").
:- assert_kif("(subclass RadiatingLight RadiatingElectromagnetic)").
:- assert_kif("(documentation RadiatingLight EnglishLanguage \"The &%subclass of &%Radiating in which light is given off or absorbed. Some examples include blinking, flashing, and glittering.\")").
:- assert_kif("(<=> (exists (?EMIT) (and (instance ?EMIT RadiatingLight) (patient ?EMIT ?REGION) (instance ?REGION Region))) (attribute ?REGION Illuminated))").
:- assert_kif("(subclass RadiatingInfrared RadiatingElectromagnetic)").
:- assert_kif("(subclass RadiatingXRay RadiatingElectromagnetic)").
:- assert_kif("(subclass RadiatingSound Radiating)").
:- assert_kif("(documentation RadiatingSound EnglishLanguage \"The &%subclass of &%Radiating in which sound waves are given off or absorbed. Some examples include creaking, roaring, and whistling.\")").
:- assert_kif("(=> (and (instance ?EMIT RadiatingSound) (agent ?EMIT ?SOUND)) (exists (?ATTR) (and (instance ?ATTR SoundAttribute) (attribute ?SOUND ?ATTR))))").
% :- assert_kif("; KJN: Removing this and renaming it to MakingMusic to be consistent with the Verb form of most Processes (subclass Music RadiatingSound) (documentation Music EnglishLanguage \"The &%subclass of &%RadiatingSound where the sound is intended to be melodic and is produced deliberately.\")").
:- assert_kif("(subclass MakingMusic RadiatingSound)").
:- assert_kif("(documentation MakingMusic EnglishLanguage \"&%MakingMusic is a type of &%RadiatingSound where the &%result is intended to be melodic and is produced delibrately\")").
:- assert_kif("(termFormat EnglishLanguage MakingMusic \"making music\")").
:- assert_kif("(comment MakingMusic \"Changing the old Music to &%MakingMusic to be more consistent with the verb-form that &%Process seem to take. (09-14-2011)\" \"KJN\")").
:- assert_kif("(partition MakingMusic MakingInstrumentalMusic MakingVocalMusic)").
:- assert_kif("(subclass MakingInstrumentalMusic MakingMusic)").
:- assert_kif("(documentation MakingInstrumentalMusic EnglishLanguage \"&%MakingInstrumentalMusic is a type of &%MakingMusic which is produced using some kind of &%MusicalInstrument\")").
:- assert_kif("(termFormat EnglishLanguage MakingInstrumentalMusic \"instrumental music\")").
:- assert_kif("(=> (instance ?M MakingInstrumentalMusic) (exists (?I) (and (instance ?I MusicalInstrument) (instrument ?M ?I))))").
:- assert_kif("(subclass MakingVocalMusic MakingMusic)").
:- assert_kif("(subclass MakingVocalMusic Vocalizing)").
:- assert_kif("(documentation MakingVocalMusic EnglishLanguage \"&%MakingVocalMusic is a type of &%MakingMusic which is produced by using the vocal cords\")").
:- assert_kif("(termFormat EnglishLanguage MakingVocalMusic \"singing\")").
:- assert_kif("(comment MakingVocalMusic \"Currently, &%VocalMusic also inherits from &%Speaking. Changing this to more general &%Vocalizing. Acapella groups today use their &%VocalCord to create music in ways that are more than just speaking. (09-14-2011)\" \"KJN\")").
:- assert_kif("(subclass Singing MakingVocalMusic)").
:- assert_kif("(documentation Singing EnglishLanguage \"&%Singing is a type of &%MakingVocalMusic wherein words are produced by the singer. This is different from other forms of &%MakingVocalMusic such as humming or scatting or beatboxing , where the vocal cords are used to create the music but no words are formed.\")").
:- assert_kif("(=> (instance ?S Singing) (exists (?W) (and (patient ?S ?W) (instance ?W Word))))").
:- assert_kif("(subclass RadiatingElectromagnetic Radiating)").
:- assert_kif("(documentation RadiatingElectromagnetic EnglishLanguage \"&%RadiatingElectromagnetic is the subclass of &%Radiating processes in which electromagnetic radiation is transmitted or absorbed.\")").
:- assert_kif("(subclass RadiatingNuclear Radiating)").
:- assert_kif("(documentation RadiatingNuclear EnglishLanguage \"Releasing atomic energy, i.e. energy from a nuclear reaction.\")").
:- assert_kif("(subclass StateChange InternalChange)").
:- assert_kif("(documentation StateChange EnglishLanguage \"Any &%Process where the &%PhysicalState of &%part of the &%patient of the &%Process changes.\")").
:- assert_kif("(=> (and (instance ?PROCESS StateChange) (patient ?PROCESS ?OBJ)) (exists (?PART ?STATE1 ?STATE2) (and (part ?PART ?OBJ) (instance ?STATE1 PhysicalState) (instance ?STATE2 PhysicalState) (not (equal ?STATE1 ?STATE2)) (holdsDuring (BeginFn (WhenFn ?PROCESS)) (attribute ?PART ?STATE1)) (holdsDuring (EndFn (WhenFn ?PROCESS)) (attribute ?PART ?STATE2)))))").
:- assert_kif("(instance atomicNumber BinaryPredicate)").
:- assert_kif("(instance atomicNumber AsymmetricRelation)").
:- assert_kif("(domainSubclass atomicNumber 1 ElementalSubstance)").
:- assert_kif("(domain atomicNumber 2 PositiveInteger)").
:- assert_kif("(documentation atomicNumber EnglishLanguage \"(&%atomicNumber ?ELEMENT ?NUMBER) means that the &%ElementalSubstance ?ELEMENT has the atomic number ?NUMBER. The atomic number is the number of &%Protons in the nucleus of an &%Atom.\")").
:- assert_kif("(=> (atomicNumber ?TYPE ?NUMBER) (=> (and (instance ?SUBSTANCE ?TYPE) (part ?ATOM ?SUBSTANCE) (instance ?ATOM Atom)) (equal ?NUMBER (CardinalityFn (KappaFn ?PROTON (and (part ?PROTON ?ATOM) (instance ?PROTON Proton)))))))").
:- assert_kif("(instance boilingPoint BinaryPredicate)").
:- assert_kif("(domainSubclass boilingPoint 1 PureSubstance)").
:- assert_kif("(domain boilingPoint 2 TemperatureMeasure)").
:- assert_kif("(documentation boilingPoint EnglishLanguage \"The temperature at which a &%PureSubstance changes state from a &%Liquid to a &%Gas.\")").
:- assert_kif("(=> (and (instance ?X ?Y) (subclass ?Y PureSubstance) (barometricPressure ?X (MeasureFn ?PRES InchMercury)) (greaterThan 29.92 ?PRES) (boilingPoint ?Y (MeasureFn ?BOIL KelvinDegree)) (measure ?X (MeasureFn ?TEMP KelvinDegree)) (greaterThan ?TEMP ?BOIL)) (attribute ?X Gas))").
:- assert_kif("(=> (and (instance ?X ?Y) (subclass ?Y PureSubstance) (boilingPoint ?Y (MeasureFn ?BOIL KelvinDegree)) (meltingPoint ?Y (MeasureFn ?MELT KelvinDegree)) (measure ?X (MeasureFn ?TEMP KelvinDegree)) (greaterThan ?TEMP ?MELT) (lessThan ?TEMP ?BOIL)) (attribute ?X Liquid))").
:- assert_kif("(=> (and (instance ?X ?Y) (subclass ?Y PureSubstance) (meltingPoint ?Y (MeasureFn ?MELT KelvinDegree)) (barometricPressure ?X (MeasureFn ?PRES InchMercury)) (greaterThan ?PRES 29.92) (measure ?X (MeasureFn ?TEMP KelvinDegree)) (lessThan ?TEMP ?MELT)) (attribute ?X Solid))").
:- assert_kif("(=> (and (instance ?BOILING Boiling) (boilingPoint ?TYPE (MeasureFn ?TEMP1 ?MEASURE)) (instance ?SUBSTANCE ?TYPE) (patient ?BOILING ?SUBSTANCE) (holdsDuring (WhenFn ?BOILING) (measure ?SUBSTANCE (MeasureFn ?TEMP2 ?MEASURE))) (instance ?MEASURE UnitOfTemperature)) (greaterThanOrEqualTo ?TEMP2 ?TEMP1))").
:- assert_kif("(=> (and (boilingPoint ?TYPE (MeasureFn ?TEMP1 ?MEASURE)) (instance ?SUBSTANCE ?TYPE) (holdsDuring ?TIME (measure ?SUBSTANCE (MeasureFn ?TEMP2 ?MEASURE))) (instance ?MEASURE UnitOfTemperature) (greaterThanOrEqualTo ?TEMP2 ?TEMP1)) (or (holdsDuring ?TIME (attribute ?SUBSTANCE Gas)) (exists (?BOIL) (and (overlapsTemporally (WhenFn ?BOIL) ?TIME) (instance ?BOIL Boiling) (patient ?BOIL ?SUBSTANCE)))))").
:- assert_kif("(instance meltingPoint BinaryPredicate)").
:- assert_kif("(domainSubclass meltingPoint 1 PureSubstance)").
:- assert_kif("(domain meltingPoint 2 TemperatureMeasure)").
:- assert_kif("(documentation meltingPoint EnglishLanguage \"The temperature at which a &%PureSubstance changes state from a &%Solid to a &%Liquid. Note that &%Arsenic can sublimate directly from &%Solid to &%Gas which means that its melting and boiling points are equal.\")").
:- assert_kif("(=> (and (instance ?SUBSTANCE ?TYPE) (boilingPoint ?TYPE (MeasureFn ?TEMP1 ?MEASURE)) (meltingPoint ?TYPE (MeasureFn ?TEMP2 ?MEASURE)) (instance ?MEASURE UnitOfTemperature) (holdsDuring ?TIME (measure ?SUBSTANCE (MeasureFn ?TEMP3 ?MEASURE))) (greaterThan ?TEMP3 ?TEMP2) (lessThan ?TEMP3 ?TEMP1)) (or (holdsDuring ?TIME (attribute ?SUBSTANCE Liquid)) (exists (?MELT) (and (overlapsTemporally (WhenFn ?MELT) ?TIME) (instance ?MELT Melting) (patient ?BOIL ?SUBSTANCE)))))").
:- assert_kif("(=> (and (instance ?SUBSTANCE ?TYPE) (meltingPoint ?TYPE (MeasureFn ?TEMP1 ?MEASURE)) (holdsDuring ?TIME (measure ?SUBSTANCE (MeasureFn ?TEMP2 ?MEASURE))) (instance ?MEASURE UnitOfTemperature) (lessThan ?TEMP2 ?TEMP1)) (or (holdsDuring ?TIME (attribute ?SUBSTANCE Solid)) (exists (?FREEZE) (and (overlapsTemporally (WhenFn ?FREEZE) ?TIME) (instance ?FREEZE Freezing) (patient ?FREEZE ?SUBSTANCE)))))").
:- assert_kif("(=> (and (meltingPoint ?TYPE ?MELT) (boilingPoint ?TYPE ?BOIL)) (greaterThanOrEqualTo ?BOIL ?MELT))").
:- assert_kif("(subclass Melting StateChange)").
:- assert_kif("(documentation Melting EnglishLanguage \"The &%Class of &%Processes where an &%Object is heated and converted from a &%Solid to a &%Liquid.\")").
:- assert_kif("(=> (instance ?MELT Melting) (exists (?HEAT) (and (instance ?HEAT Heating) (subProcess ?HEAT ?MELT))))").
:- assert_kif("(=> (and (instance ?MELT Melting) (patient ?MELT ?OBJ)) (exists (?PART) (and (part ?PART ?OBJ) (holdsDuring (BeginFn (WhenFn ?MELT)) (attribute ?PART Solid)) (holdsDuring (EndFn (WhenFn ?MELT)) (attribute ?PART Liquid)))))").
:- assert_kif("(subclass Boiling StateChange)").
:- assert_kif("(documentation Boiling EnglishLanguage \"The &%Class of &%Processes where a &%Substance is heated and converted from a &%Liquid to a &%Gas.\")").
:- assert_kif("(=> (instance ?BOIL Boiling) (exists (?HEAT) (and (instance ?HEAT Heating) (subProcess ?HEAT ?BOIL))))").
:- assert_kif("(=> (and (instance ?BOIL Boiling) (patient ?BOIL ?OBJ)) (exists (?PART) (and (part ?PART ?OBJ) (holdsDuring (BeginFn (WhenFn ?BOIL)) (attribute ?PART Liquid)) (holdsDuring (EndFn (WhenFn ?BOIL)) (attribute ?PART Gas)))))").
:- assert_kif("(subclass Evaporating StateChange)").
:- assert_kif("(documentation Evaporating EnglishLanguage \"The &%Class of &%Processes where a &%Substance is converted from a &%Liquid to a &%Gas at a temperature below its &%Boiling point.\")").
:- assert_kif("(=> (and (instance ?EVAP Evaporating) (boilingPoint ?OBJ (MeasureFn ?BOILVAL ?MEAS)) (measure ?OBJ (MeasureFn ?VAL ?MEAS)) (instance ?MEAS UnitOfTemperature) (patient ?EVAP ?OBJ)) (exists (?PART) (and (part ?PART ?OBJ) (greaterThan ?BOILVAL ?VAL) (holdsDuring (BeginFn (WhenFn ?EVAP)) (attribute ?PART Liquid)) (holdsDuring (EndFn (WhenFn ?EVAP)) (attribute ?PART Gas)))))").
:- assert_kif("(subclass Condensing StateChange)").
:- assert_kif("(documentation Condensing EnglishLanguage \"The &%Class of &%Processes where an &%Object is cooled and converted from a &%Gas to a &%Liquid.\")").
:- assert_kif("(=> (instance ?COND Condensing) (exists (?COOL) (and (instance ?COOL Cooling) (subProcess ?COOL ?COND))))").
:- assert_kif("(=> (and (instance ?COND Condensing) (patient ?COND ?OBJ)) (exists (?PART) (and (part ?PART ?OBJ) (holdsDuring (BeginFn (WhenFn ?COND)) (attribute ?PART Gas)) (holdsDuring (EndFn (WhenFn ?COND)) (attribute ?PART Liquid)))))").
:- assert_kif("(subclass Freezing StateChange)").
:- assert_kif("(documentation Freezing EnglishLanguage \"The &%Class of &%Processes where an &%Object is cooled and converted from a &%Liquid to a &%Solid.\")").
:- assert_kif("(=> (instance ?FREEZE Freezing) (exists (?COOL) (and (instance ?COOL Cooling) (subProcess ?COOL ?FREEZE))))").
:- assert_kif("(=> (and (instance ?FREEZE Freezing) (patient ?FREEZE ?OBJ)) (exists (?PART) (and (part ?PART ?OBJ) (holdsDuring (BeginFn (WhenFn ?FREEZE)) (attribute ?PART Liquid)) (holdsDuring (EndFn (WhenFn ?FREEZE)) (attribute ?PART Solid)))))").
% :- assert_kif("; END FILE").
% :- assert_kif("; BEGIN FILE").
% :- assert_kif(";  OBJECTS  ").
% :- assert_kif("; INCLUDES 'MEREOTOPOLOGY' INCLUDES 'PROCESSES' INCLUDES 'QUALITIES'").
:- assert_kif("(subclass AstronomicalBody Object)").
:- assert_kif("(disjoint AstronomicalBody GeographicArea)").
:- assert_kif("(documentation AstronomicalBody EnglishLanguage \"The &%Class of all astronomical objects of significant size. It includes &%SelfConnectedObjects like planets, stars, and asteroids, as well as &%Collections like nebulae, galaxies, and constellations. Note that the planet Earth is an &%AstronomicalBody, but every &%Region of Earth is a &%GeographicArea.\")").
:- assert_kif("(subclass GeographicArea Region)").
:- assert_kif("(partition GeographicArea WaterArea LandArea)").
:- assert_kif("(documentation GeographicArea EnglishLanguage \"A geographic location, generally having definite boundaries. Note that this differs from its immediate superclass &%Region in that a &%GeographicArea is a three-dimensional &%Region of the earth. Accordingly, all astronomical objects other than earth and all one-dimensional and two-dimensional &%Regions are not classed under &%GeographicArea.\")").
:- assert_kif("(subclass LocalizablePlace GeographicArea)").
:- assert_kif("(instance geographicSubregion BinaryPredicate)").
:- assert_kif("(instance geographicSubregion TransitiveRelation)").
:- assert_kif("(instance geographicSubregion AsymmetricRelation)").
:- assert_kif("(subrelation geographicSubregion properPart)").
:- assert_kif("(subrelation geographicSubregion located)").
:- assert_kif("(domain geographicSubregion 1 GeographicArea)").
:- assert_kif("(domain geographicSubregion 2 GeographicArea)").
:- assert_kif("(documentation geographicSubregion EnglishLanguage \"(&%geographicSubregion ?PART ?WHOLE) means that the &%GeographicArea ?PART is part of the &%GeographicArea ?WHOLE.\")").
:- assert_kif("(subclass GeopoliticalArea GeographicArea)").
:- assert_kif("(subclass GeopoliticalArea Agent)").
:- assert_kif("(documentation GeopoliticalArea EnglishLanguage \"Any &%GeographicArea which is associated with some sort of political structure. This class includes &%Lands, &%Cities, districts of cities, counties, etc. Note that the identity of a &%GeopoliticalArea may remain constant after a change in borders.\")").
:- assert_kif("(=> (and (instance ?AREA GeopoliticalArea) (leader (GovernmentFn ?AREA) ?PERSON)) (leader ?AREA ?PERSON))").
:- assert_kif("(=> (and (instance ?AREA GeopoliticalArea) (leader ?AREA ?PERSON)) (leader (GovernmentFn ?AREA) ?PERSON))").
:- assert_kif("(=> (and (instance ?EVENT Election) (agent ?EVENT ?AGENT) (instance ?AGENT GeopoliticalArea)) (instance ?EVENT PoliticalProcess))").
:- assert_kif("(=> (and (instance ?EVENT Election) (agent ?EVENT ?AGENT) (instance ?AREA GeopoliticalArea) (instance ?AGENT (GovernmentFn ?AREA))) (instance ?EVENT PoliticalProcess))").
:- assert_kif("(instance geopoliticalSubdivision AsymmetricRelation)").
:- assert_kif("(instance geopoliticalSubdivision TransitiveRelation)").
:- assert_kif("(subrelation geopoliticalSubdivision geographicSubregion)").
:- assert_kif("(domain geopoliticalSubdivision 1 GeopoliticalArea)").
:- assert_kif("(domain geopoliticalSubdivision 2 GeopoliticalArea)").
:- assert_kif("(documentation geopoliticalSubdivision EnglishLanguage \"(&%geopoliticalSubdivision ?AREA1 ?AREA2) means that ?AREA1 is any geopolitical part of ?AREA2, that is, ?AREA1 is an integral &%geographicSubregion of ?AREA2 (not a &%DependencyOrSpecialSovereigntyArea), having its own associated &%GovernmentOrganization which is subordinated to or constrained by the government of ?AREA2. Cf. &%dependentGeopoliticalArea.\")").
% :- assert_kif("; NS: delete. (=> (geopoliticalSubdivision ?SUB ?AREA) (not (instance ?SUB Nation)))").
% :- assert_kif("; NS: Note that Government.kif contains the following formulae:").
% :- assert_kif("(subclass IndependentState Nation) (=> (geopoliticalSubdivision ?SUB ?AREA) (not (instance ?SUB IndependentState)))").
% :- assert_kif("; It would be best to rewrite all rules in which &%Nation is used in the sense of &%IndependentState so that they use &%IndependentState. This would allow &%Nation to be interpreted in a more general \"cultural\" or \"homeland\" sense, as suggested by (subclass IndependentState Nation). England, Scotland, Wales, and NorthernIreland, for example, would be &%Nations, but not (currently) &%IndependentStates.").
:- assert_kif("(subclass WaterArea GeographicArea)").
:- assert_kif("(documentation WaterArea EnglishLanguage \"A body which is made up predominantly of water, e.g. rivers, lakes, oceans, etc.\")").
:- assert_kif("(=> (instance ?AREA WaterArea) (exists (?BED ?HOLE ?WATER) (and (equal (HoleHostFn ?HOLE) ?BED) (instance ?WATER Water) (properlyFills ?WATER ?HOLE) (equal (MereologicalSumFn ?BED ?WATER) ?AREA))))").
:- assert_kif("(subclass SaltWaterArea WaterArea)").
:- assert_kif("(disjoint SaltWaterArea FreshWaterArea)").
:- assert_kif("(documentation SaltWaterArea EnglishLanguage \"A &%WaterArea whose &%Water is saline, e.g. oceans and seas.\")").
:- assert_kif("(subclass FreshWaterArea WaterArea)").
:- assert_kif("(documentation FreshWaterArea EnglishLanguage \"A &%WaterArea whose &%Water is not saline, e.g. most rivers and lakes.\")").
% :- assert_kif("; KJN: Moving this to MILO to remove dependencies (subclass StreamWaterArea WaterArea) (disjoint StreamWaterArea StaticWaterArea) (documentation StreamWaterArea EnglishLanguage \"A relatively narrow &%WaterArea where the water flows constantly and in the same direction, e.g. a river, a stream, etc.\")").
% :- assert_kif(" (subclass StaticWaterArea WaterArea) (documentation StaticWaterArea EnglishLanguage \"A &%WaterArea in which water does not flow constantly or in the same direction, e.g. most lakes and ponds.\")").
:- assert_kif("(subclass LandArea GeographicArea)").
:- assert_kif("(documentation LandArea EnglishLanguage \"An area which is predominantly solid ground, e.g. a &%Nation, a mountain, a desert, etc. Note that a &%LandArea may contain some relatively small &%WaterAreas. For example, Australia is a &%LandArea even though it contains various rivers and lakes.\")").
:- assert_kif("(=> (instance ?LAND1 LandArea) (exists (?LAND2) (and (part ?LAND1 ?LAND2) (or (instance ?LAND2 Continent) (instance ?LAND2 Island)))))").
:- assert_kif("(subclass ShoreArea LandArea)").
:- assert_kif("(documentation ShoreArea EnglishLanguage \"A &%ShoreArea is a &%LandArea approximately 1-3 km wide bordering a body of water, such as an ocean, bay, river, or lake. A &%ShoreArea may comprise a variety of &%LandForms, such as dunes, sloughs, and marshes.\")").
:- assert_kif("(=> (instance ?BANK ShoreArea) (exists (?WATER) (and (instance ?WATER WaterArea) (meetsSpatially ?BANK ?WATER))))").
:- assert_kif("(subclass Continent LandArea)").
:- assert_kif("(equal (CardinalityFn Continent) 7)").
:- assert_kif("(documentation Continent EnglishLanguage \"As defined in the CIA World Fact Book, &%Continent covers seven land masses: &%Africa, &%NorthAmerica, &%SouthAmerica, &%Antarctica, &%Europe, &%Asia, and &%Oceania. Note that &%Australia, counted as a continent in some other systems, is included in &%Oceania in the Fact Book. As a consequence, there is no &%Nation which is also a &%Continent.\")").
:- assert_kif("(subclass Island LandArea)").
:- assert_kif("(documentation Island EnglishLanguage \"A &%LandArea that is completely surrounded by a &%WaterArea.\")").
:- assert_kif("(=> (instance ?ISLAND Island) (not (exists (?AREA ?PART1 ?PART2) (and (instance ?AREA LandArea) (part ?PART1 ?ISLAND) (part ?PART2 ?AREA) (not (part ?ISLAND ?AREA)) (not (part ?AREA ?ISLAND)) (meetsSpatially ?PART1 ?PART2)))))").
:- assert_kif("(=> (and (instance ?ISLE Island) (instance ?AREA GeographicArea) (meetsSpatially ?ISLE ?AREA)) (not (instance ?AREA LandArea)))").
:- assert_kif("(=> (instance ?ISLE Island) (exists (?WATER) (and (instance ?WATER WaterArea) (meetsSpatially ?ISLE ?WATER))))").
:- assert_kif("(subclass Nation GeopoliticalArea)").
:- assert_kif("(subclass Nation LandArea)").
:- assert_kif("(documentation Nation EnglishLanguage \"The broadest &%GeopoliticalArea, i.e. &%Nations are &%GeopoliticalAreas that are not part of any other overarching and comprehensive governance structure (excepting commonwealths and other sorts of loose international organizations).\")").
:- assert_kif("(subclass StateOrProvince GeopoliticalArea)").
:- assert_kif("(subclass StateOrProvince LandArea)").
:- assert_kif("(documentation StateOrProvince EnglishLanguage \"Administrative subdivisions of a &%Nation that are broader than any other political subdivisions that may exist. This &%Class includes the states of the United States, as well as the provinces of Canada and European countries.\")").
:- assert_kif("(=> (instance ?STATE StateOrProvince) (exists (?LAND) (and (instance ?LAND Nation) (properPart ?STATE ?LAND))))").
:- assert_kif("(subclass City GeopoliticalArea)").
:- assert_kif("(subclass City LandArea)").
:- assert_kif("(documentation City EnglishLanguage \"A &%LandArea of relatively small size, inhabited by a community of people, and having some sort of political structure. Note that this class includes both large cities and small settlements like towns, villages, hamlets, etc.\")").
:- assert_kif("(subclass County GeopoliticalArea)").
:- assert_kif("(subclass County LandArea)").
:- assert_kif("(documentation County EnglishLanguage \"A &%GeopoliticalArea that is larger than a city, usually encompassing several cities, and smaller than a &%StateOrProvince. Aside from City, this is the smallest geopolitical subdivision, and it is known by various names in various counties, e.g. parrish, commune, etc.\")").
:- assert_kif("(=> (instance ?STATE County) (exists (?LAND) (and (instance ?LAND StateOrProvince) (properPart ?STATE ?LAND))))").
:- assert_kif("(subclass Transitway Region)").
:- assert_kif("(subclass Transitway SelfConnectedObject)").
:- assert_kif("(documentation Transitway EnglishLanguage \"&%Transitway is the broadest class of regions which may be passed through as a &%path in instances of &%Translocation. &%Transitway includes land, air, and sea regions, and it includes both natural and artificial transitways.\")").
:- assert_kif("(subclass LandTransitway Transitway)").
:- assert_kif("(subclass LandTransitway LandArea)").
:- assert_kif("(documentation LandTransitway EnglishLanguage \"&%LandTransitway is the subclass of &%Transitway that represents areas intended for motion over the ground.\")").
:- assert_kif("(=> (instance ?WAY Transitway) (hasPurpose ?WAY (exists (?TRANSPORT) (and (instance ?TRANSPORT Transportation) (path ?TRANSPORT ?WAY)))))").
:- assert_kif("(subclass Roadway LandTransitway)").
:- assert_kif("(documentation Roadway EnglishLanguage \"&%Roadway is the subclass of &%LandTransitways that are areas intended for surface travel by self-powered, wheeled vehicles, excluding those that travel on tracks. &%Roadways have been at least minimally improved to enable the passage of vehicles. &%Roadways include dirt and gravelled roads, paved streets, and expressways.\")").
:- assert_kif("(subclass Water CompoundSubstance)").
:- assert_kif("(documentation Water EnglishLanguage \"The &%Class of samples of the compound H20. Note that this &%Class covers both pure and impure &%Water.\")").
:- assert_kif("(subclass Mineral Substance)").
:- assert_kif("(documentation Mineral EnglishLanguage \"Any of various naturally occurring homogeneous substances (such as stone, coal, salt, sulfur, sand, petroleum), or synthetic substances having the chemical composition and crystalline form and properties of a naturally occurring mineral.\")").
:- assert_kif("(instance developmentalForm BinaryPredicate)").
:- assert_kif("(instance developmentalForm AsymmetricRelation)").
:- assert_kif("(instance developmentalForm TransitiveRelation)").
:- assert_kif("(subrelation developmentalForm attribute)").
:- assert_kif("(domain developmentalForm 1 OrganicObject)").
:- assert_kif("(domain developmentalForm 2 DevelopmentalAttribute)").
% :- assert_kif("; NS: delete. (documentation developmentalForm EnglishLanguage \"(&%developmentalForm ?OBJECT ?FORM) means that ?FORM is an earlier stage in the individual maturation of ?OBJECT. For example, tadpole and caterpillar are &%developmentalForms of frogs and butterflies, respectively.\")").
% :- assert_kif("; NS: add.").
:- assert_kif("(documentation developmentalForm EnglishLanguage \"(&%developmentalForm ?OBJECT ?FORM) means that ?FORM describes a stage in the individual maturation of ?OBJECT. For example, tadpole and caterpillar are &%developmentalForms of frogs and butterflies, respectively.\")").
:- assert_kif("(=> (and (holdsDuring ?TIME1 (developmentalForm ?OBJ ?ATTR1)) (successorAttributeClosure ?ATTR2 ?ATTR1)) (exists (?TIME2) (and (earlier ?TIME2 ?TIME1) (holdsDuring ?TIME2 (developmentalForm ?OBJ ?ATTR2)))))").
:- assert_kif("(subclass OrganicObject CorpuscularObject)").
:- assert_kif("(subclass OrganicObject OrganicThing)").
:- assert_kif("(partition OrganicObject Organism AnatomicalStructure)").
:- assert_kif("(documentation OrganicObject EnglishLanguage \"This class encompasses &%Organisms, &%CorpuscularObjects that are parts of &%Organisms, i.e. &%BodyParts, and &%CorpuscularObjects that are nonintentionally produced by &%Organisms, e.g. &%ReproductiveBodies.\")").
:- assert_kif("(subclass Organism OrganicObject)").
:- assert_kif("(subclass Organism Agent)").
:- assert_kif("(disjoint Organism Artifact)").
:- assert_kif("(partition Organism Animal Plant Microorganism)").
:- assert_kif("(documentation Organism EnglishLanguage \"Generally, a living individual, including all &%Plants and &%Animals.\")").
:- assert_kif("(=> (instance ?ORGANISM Organism) (exists (?BIRTH) (and (instance ?BIRTH Birth) (experiencer ?BIRTH ?ORGANISM))))").
:- assert_kif("(instance inhabits BinaryPredicate)").
:- assert_kif("(instance inhabits AsymmetricRelation)").
:- assert_kif("(domain inhabits 1 Organism)").
:- assert_kif("(domain inhabits 2 Object)").
:- assert_kif("(documentation inhabits EnglishLanguage \"A very basic notion of living within something else. (&%inhabits ?ORGANISM ?OBJECT) means that ?OBJECT is the residence").
:- assert_kif("(either permanent or temporary), nest, etc. of ?ORGANISM.\")").
:- assert_kif("(=> (holdsDuring ?T1 (inhabits ?ORGANISM ?OBJ)) (exists (?TIME) (and (instance ?TIME TimeInterval) (temporalPart ?TIME ?T1) (holdsDuring ?TIME (located ?ORGANISM ?OBJ)))))").
:- assert_kif("(subrelation home inhabits)").
:- assert_kif("(domain home 1 Human)").
:- assert_kif("(domain home 2 PermanentResidence)").
:- assert_kif("(documentation home EnglishLanguage \"The relation between a &%Human and a &%PermanentResidence of the &%Human.\")").
:- assert_kif("(subrelation stays inhabits)").
:- assert_kif("(disjointRelation stays home)").
:- assert_kif("(domain stays 1 Human)").
:- assert_kif("(domain stays 2 TemporaryResidence)").
:- assert_kif("(documentation stays EnglishLanguage \"The relation between a &%Human and a &%TemporaryResidence of the &%Human.\")").
:- assert_kif("(subclass Plant Organism)").
:- assert_kif("(documentation Plant EnglishLanguage \"An &%Organism having cellulose cell walls, growing by synthesis of &%Substances, generally distinguished by the presence of chlorophyll, and lacking the power of locomotion.\")").
:- assert_kif("(subclass FloweringPlant Plant)").
:- assert_kif("(documentation FloweringPlant EnglishLanguage \"A &%Plant that produces seeds and flowers. This class includes trees, shrubs, herbs, and flowers.\")").
:- assert_kif("(subclass NonFloweringPlant Plant)").
:- assert_kif("(disjoint NonFloweringPlant FloweringPlant)").
:- assert_kif("(disjointDecomposition NonFloweringPlant Alga Fern Moss)").
:- assert_kif("(documentation NonFloweringPlant EnglishLanguage \"A &%Plant that reproduces with spores and does not produce flowers.\")").
:- assert_kif("(subclass Alga NonFloweringPlant)").
:- assert_kif("(documentation Alga EnglishLanguage \"A chiefly aquatic plant that contains chlorophyll, but does not form embryos during development and lacks vascular tissue.\")").
:- assert_kif("(=> (instance ?ALGA Alga) (exists (?WATER) (and (inhabits ?ALGA ?WATER) (instance ?WATER Water))))").
:- assert_kif("(subclass Fungus Organism)").
:- assert_kif("(documentation Fungus EnglishLanguage \"A eukaryotic &%Organism characterized by the absence of chlorophyll and the presence of rigid cell walls. Included here are both slime molds and true fungi such as yeasts, molds, mildews, and mushrooms.\")").
:- assert_kif("(=> (and (instance ?FUNGUS Fungus) (inhabits ?FUNGUS ?OBJ)) (instance ?OBJ Organism))").
:- assert_kif("(subclass Moss NonFloweringPlant)").
:- assert_kif("(documentation Moss EnglishLanguage \"A &%NonFloweringPlant without true roots and little if any vascular tissue.\")").
:- assert_kif("(subclass Fern NonFloweringPlant)").
:- assert_kif("(documentation Fern EnglishLanguage \"A &%NonFloweringPlant that contains vascular tissue. This class includes true ferns, as well as horsetails, club mosses, and whisk ferns.\")").
:- assert_kif("(subclass Animal Organism)").
:- assert_kif("(partition Animal Vertebrate Invertebrate)").
:- assert_kif("(documentation Animal EnglishLanguage \"An &%Organism with eukaryotic &%Cells, and lacking stiff cell walls, plastids, and photosynthetic pigments.\")").
:- assert_kif("(subclass Microorganism Organism)").
:- assert_kif("(documentation Microorganism EnglishLanguage \"An &%Organism that can be seen only with the aid of a microscope.\")").
:- assert_kif("(subclass Bacterium Microorganism)").
:- assert_kif("(documentation Bacterium EnglishLanguage \"A small, typically one-celled, prokaryotic &%Microorganism.\")").
:- assert_kif("(=> (instance ?BACTERIUM Bacterium) (exists (?CELL1) (and (component ?CELL1 ?BACTERIUM) (instance ?CELL1 Cell) (forall (?CELL2) (=> (and (component ?CELL2 ?BACTERIUM) (instance ?CELL2 Cell)) (equal ?CELL1 ?CELL2))))))").
:- assert_kif("(=> (and (instance ?BACTERIUM Bacterium) (inhabits ?BACTERIUM ?OBJ)) (instance ?OBJ Organism))").
:- assert_kif("(subclass Virus Microorganism)").
:- assert_kif("(documentation Virus EnglishLanguage \"An &%Organism consisting of a core of a single nucleic acid enclosed in a protective coat of protein. A virus may replicate only inside a host living cell. A virus exhibits some but not all of the usual characteristics of living things.\")").
:- assert_kif("(=> (and (instance ?VIRUS Virus) (inhabits ?VIRUS ?OBJ)) (instance ?OBJ Organism))").
:- assert_kif("(=> (and (instance ?VIRUS Virus) (instance ?PROC Replication) (agent ?PROC ?VIRUS)) (exists (?CELL) (and (located ?PROC ?CELL) (instance ?CELL Cell))))").
:- assert_kif("(subclass Vertebrate Animal)").
:- assert_kif("(documentation Vertebrate EnglishLanguage \"An &%Animal which has a spinal column.\")").
:- assert_kif("(subclass Invertebrate Animal)").
:- assert_kif("(disjointDecomposition Invertebrate Worm Mollusk Arthropod)").
:- assert_kif("(documentation Invertebrate EnglishLanguage \"An &%Animal which has no spinal column.\")").
:- assert_kif("(subclass Worm Invertebrate)").
:- assert_kif("(documentation Worm EnglishLanguage \"Long, narrow, soft-bodied &%Invertebrates.\")").
:- assert_kif("(subclass Mollusk Invertebrate)").
:- assert_kif("(documentation Mollusk EnglishLanguage \"Soft-bodied &%Invertebrate that is usually contained in a shell. Includes oysters, clams, mussels, snails, slugs, octopi, and squid.\")").
:- assert_kif("(subclass Arthropod Invertebrate)").
:- assert_kif("(disjointDecomposition Arthropod Arachnid Myriapod Insect Crustacean)").
:- assert_kif("(documentation Arthropod EnglishLanguage \"A &%Class of &%Invertebrate that includes &%Arachnids and &%Insects.\")").
:- assert_kif("(subclass Arachnid Arthropod)").
:- assert_kif("(documentation Arachnid EnglishLanguage \"A &%Class of &%Arthropods that includes ticks and spiders.\")").
:- assert_kif("(subclass Myriapod Arthropod)").
:- assert_kif("(documentation Myriapod EnglishLanguage \"A &%Class of &%Arthropods that includes centipedes and millipedes.\")").
:- assert_kif("(subclass Insect Arthropod)").
:- assert_kif("(documentation Insect EnglishLanguage \"A &%Class of small &%Arthropods that are air-breathing and that are distinguished by appearance.\")").
:- assert_kif("(subclass Crustacean Arthropod)").
:- assert_kif("(documentation Crustacean EnglishLanguage \"A &%Class of &%Arthropods that mainly dwells in water and has a segmented body and a chitinous exoskeleton. Includes lobsters, crabs, shrimp, and barnacles.\")").
:- assert_kif("(subclass ColdBloodedVertebrate Vertebrate)").
:- assert_kif("(disjointDecomposition ColdBloodedVertebrate Amphibian Fish Reptile)").
:- assert_kif("(documentation ColdBloodedVertebrate EnglishLanguage \"&%Vertebrates whose body temperature is not internally regulated.\")").
:- assert_kif("(subclass WarmBloodedVertebrate Vertebrate)").
:- assert_kif("(disjoint WarmBloodedVertebrate ColdBloodedVertebrate)").
:- assert_kif("(documentation WarmBloodedVertebrate EnglishLanguage \"&%Vertebrates whose body temperature is internally regulated.\")").
:- assert_kif("(subclass Amphibian ColdBloodedVertebrate)").
:- assert_kif("(documentation Amphibian EnglishLanguage \"A cold-blooded, smooth-skinned &%Vertebrate which characteristically hatches as an aquatic larva, breathing by gills. When mature, the &%Amphibian breathes with &%Lungs.\")").
:- assert_kif("(subclass Bird WarmBloodedVertebrate)").
:- assert_kif("(disjoint Bird Mammal)").
:- assert_kif("(documentation Bird EnglishLanguage \"A &%Vertebrate having a constant body temperature and characterized by the presence of feathers.\")").
:- assert_kif("(subclass Fish ColdBloodedVertebrate)").
:- assert_kif("(documentation Fish EnglishLanguage \"A cold-blooded aquatic &%Vertebrate characterized by fins and breathing by gills. Included here are &%Fish having either a bony skeleton, such as a perch, or a cartilaginous skeleton, such as a shark. Also included are those &%Fish lacking a jaw, such as a lamprey or hagfish.\")").
:- assert_kif("(=> (instance ?FISH Fish) (exists (?WATER) (and (inhabits ?FISH ?WATER) (instance ?WATER Water))))").
:- assert_kif("(subclass Mammal WarmBloodedVertebrate)").
:- assert_kif("(disjointDecomposition Mammal AquaticMammal HoofedMammal Marsupial Rodent Primate)").
:- assert_kif("(documentation Mammal EnglishLanguage \"A &%Vertebrate having a constant body temperature and characterized by the presence of hair, mammary glands, and sweat glands.\")").
:- assert_kif("(subclass AquaticMammal Mammal)").
:- assert_kif("(documentation AquaticMammal EnglishLanguage \"The &%Class of &%Mammals that dwell chiefly in the water. Includes whales, dolphins, manatees, seals, and walruses.\")").
:- assert_kif("(subclass HoofedMammal Mammal)").
:- assert_kif("(documentation HoofedMammal EnglishLanguage \"The &%Class of quadruped &%Mammals with hooves. Includes horses, cows, sheep, pigs, antelope, etc.\")").
:- assert_kif("(subclass Marsupial Mammal)").
:- assert_kif("(documentation Marsupial EnglishLanguage \"The &%Class of &%Mammals which have a pouch for their young.\")").
:- assert_kif("(subclass Carnivore Mammal)").
:- assert_kif("(documentation Carnivore EnglishLanguage \"The &%Class of flesh-eating &%Mammals. Members of this &%Class typically have four or five claws on each paw. Includes cats, dogs, bears, racoons, and skunks.\")").
:- assert_kif("(=> (and (instance ?CARNIVORE Carnivore) (instance ?EAT Eating) (agent ?EAT ?CARNIVORE) (patient ?EAT ?PREY)) (instance ?PREY Animal))").
:- assert_kif("(subclass Canine Carnivore)").
:- assert_kif("(disjoint Canine Feline)").
:- assert_kif("(documentation Canine EnglishLanguage \"The &%Class of &%Carnivores with completely separable toes, nonretractable claws, and long muzzles.\")").
:- assert_kif("(subclass Feline Carnivore)").
:- assert_kif("(documentation Feline EnglishLanguage \"The &%Class of &%Carnivores with completely separable toes, slim bodies, and rounded heads. All felines other than the cheetah have retractable claws.\")").
:- assert_kif("(subclass Rodent Mammal)").
:- assert_kif("(documentation Rodent EnglishLanguage \"The &%Class of &%Mammals with one or two pairs of incisors for gnawing. Includes rats, mice, guinea pigs, and rabbits.\")").
:- assert_kif("(subclass Primate Mammal)").
:- assert_kif("(disjointDecomposition Primate Ape Monkey Hominid)").
:- assert_kif("(documentation Primate EnglishLanguage \"The &%Class of &%Mammals which are &%Primates.\")").
:- assert_kif("(subclass Ape Primate)").
:- assert_kif("(documentation Ape EnglishLanguage \"Various &%Primates with no tails or only short tails.\")").
:- assert_kif("(subclass Monkey Primate)").
:- assert_kif("(documentation Monkey EnglishLanguage \"Various &%Primates with relatively long tails.\")").
:- assert_kif("(subclass Hominid Primate)").
:- assert_kif("(documentation Hominid EnglishLanguage \"Includes &%Humans and relatively recent ancestors of &%Humans.\")").
:- assert_kif("(subclass Human Hominid)").
:- assert_kif("(subclass Human CognitiveAgent)").
:- assert_kif("(partition Human Man Woman)").
:- assert_kif("(documentation Human EnglishLanguage \"Modern man, the only remaining species of the Homo genus.\")").
:- assert_kif("(subclass Man Human)").
:- assert_kif("(documentation Man EnglishLanguage \"The class of &%Male &%Humans.\")").
:- assert_kif("(=> (instance ?MAN Man) (attribute ?MAN Male))").
:- assert_kif("(subclass Woman Human)").
:- assert_kif("(documentation Woman EnglishLanguage \"The class of &%Female &%Humans.\")").
:- assert_kif("(=> (instance ?WOMAN Woman) (attribute ?WOMAN Female))").
:- assert_kif("(subclass Reptile ColdBloodedVertebrate)").
:- assert_kif("(documentation Reptile EnglishLanguage \"A &%ColdBloodedVertebrate having an external covering of scales or horny plates. &%Reptiles breathe by means of &%Lungs and generally lay eggs.\")").
% :- assert_kif("; The following formulas cover biologically related &%Classes under &%Substance.").
:- assert_kif("(subclass BiologicallyActiveSubstance Substance)").
:- assert_kif("(documentation BiologicallyActiveSubstance EnglishLanguage \"A &%Substance that is capable of inducing a change in the structure or functioning of an &%Organism. This &%Class includes &%Substances used in the treatment, diagnosis, prevention or analysis of normal and abnormal body function. This &%Class also includes &%Substances that occur naturally in the body and are administered therapeutically. Finally, &%BiologicallyActiveSubstance includes &%Nutrients, most drugs of abuse, and agents that require special handling because of their toxicity.\")").
:- assert_kif("(subclass Nutrient BiologicallyActiveSubstance)").
:- assert_kif("(disjointDecomposition Nutrient Protein Carbohydrate Vitamin)").
:- assert_kif("(documentation Nutrient EnglishLanguage \"A &%BiologicallyActiveSubstance required by an &%Organism. It is generally ingested as &%Food, and it is of primary interest because of its role in the biologic functioning of the &%Organism.\")").
:- assert_kif("(subclass Protein Nutrient)").
:- assert_kif("(documentation Protein EnglishLanguage \"A &%Nutrient made up of amino acids joined by peptide bonds.\")").
:- assert_kif("(subclass Enzyme Protein)").
:- assert_kif("(documentation Enzyme EnglishLanguage \"A complex &%Protein that is produced by living cells and which catalyzes specific biochemical reactions. There are six main types of enzymes: oxidoreductases, transferases, hydrolases, lyases, isomerases, and ligases.\")").
:- assert_kif("(subclass Carbohydrate Nutrient)").
:- assert_kif("(documentation Carbohydrate EnglishLanguage \"An element of living cells and a source of energy for &%Animals. This class includes both simple &%Carbohydrates, i.e. sugars, and complex &%Carbohydrates, i.e. starches.\")").
:- assert_kif("(subclass Vitamin Nutrient)").
:- assert_kif("(documentation Vitamin EnglishLanguage \"A &%Nutrient present in natural products or made synthetically, which is essential in the diet of &%Humans and other higher &%Animals. Included here are &%Vitamin precursors and provitamins.\")").
:- assert_kif("(subclass LiquidMixture Mixture)").
:- assert_kif("(partition LiquidMixture Solution Suspension)").
:- assert_kif("(documentation LiquidMixture EnglishLanguage \"Any &%Mixture that satisfies two conditions, viz. it is made up predominantly of things which are a &%Liquid and any component other than &%Liquid in the &%Mixture is in the form of fine particles which are suspended in the &%Liquid.\")").
:- assert_kif("(=> (instance ?MIX LiquidMixture) (exists (?PART) (and (part ?PART ?MIX) (attribute ?PART Liquid))))").
:- assert_kif("(subclass Solution LiquidMixture)").
:- assert_kif("(documentation Solution EnglishLanguage \"A liquid mixture. The most abundant component in a solution is called the solvent. Other components are called solutes. A solution, though homogeneous, may nonetheless have variable composition. Any amount of salt, up to a maximum limit, can be dissolved in a given amount of water.\")").
:- assert_kif("(subclass Suspension LiquidMixture)").
:- assert_kif("(documentation Suspension EnglishLanguage \"A &%LiquidMixture where at least one of the components of the &%Mixture is equally distributed throughout the &%Mixture but is not dissolved in it.\")").
:- assert_kif("(subclass GasMixture Mixture)").
:- assert_kif("(disjoint GasMixture LiquidMixture)").
:- assert_kif("(documentation GasMixture EnglishLanguage \"Any &%Mixture that satisfies two conditions, viz. it is made up predominantly of things which are a &%Gas and any component other than &%Gas in the &%Mixture is in the form of fine particles which are suspended in the &%Gas.\")").
:- assert_kif("(=> (instance ?MIX GasMixture) (exists (?PART) (and (part ?PART ?MIX) (attribute ?PART Gas))))").
:- assert_kif("(subclass Cloud GasMixture)").
:- assert_kif("(documentation Cloud EnglishLanguage \"Any &%GasMixture that is visible, e.g. &%Smoke produced by a fire or clouds of water vapor in the sky.\")").
:- assert_kif("(=> (instance ?CLOUD Cloud) (capability Seeing patient ?CLOUD))").
:- assert_kif("(subclass Smoke Cloud)").
:- assert_kif("(documentation Smoke EnglishLanguage \"A mixture of fine particles suspended in a gas that is produced by &%Combustion.\")").
:- assert_kif("(=> (instance ?SMOKE Smoke) (exists (?BURNING) (and (instance ?BURNING Combustion) (result ?BURNING ?SMOKE))))").
:- assert_kif("(subclass WaterCloud Cloud)").
:- assert_kif("(documentation WaterCloud EnglishLanguage \"Any &%Cloud that is composed primarily of water vapor.\")").
:- assert_kif("(=> (instance ?CLOUD WaterCloud) (exists (?WATER) (and (instance ?WATER Water) (part ?WATER ?CLOUD))))").
:- assert_kif("(=> (instance ?CLOUD WaterCloud) (forall (?PART) (=> (and (part ?PART ?CLOUD) (not (instance ?PART Water))) (exists (?WATER) (and (instance ?WATER Water) (part ?WATER ?CLOUD) (measure ?WATER ?MEASURE1) (measure ?PART ?MEASURE2) (greaterThan ?MEASURE1 ?MEASURE2))))))").
:- assert_kif("(subclass Air GasMixture)").
:- assert_kif("(documentation Air EnglishLanguage \"&%Air is the gaseous stuff that makes up the atmosphere surrounding Earth.\")").
:- assert_kif("(=> (instance ?WIND Wind) (exists (?AIR) (and (patient ?WIND ?AIR) (instance ?AIR Air))))").
:- assert_kif("(subclass BodySubstance Substance)").
:- assert_kif("(documentation BodySubstance EnglishLanguage \"Extracellular material and mixtures of cells and extracellular material that are produced, excreted or accreted by an &%Organism. Included here are &%Substances such as saliva, dental enamel, sweat, hormones, and gastric acid.\")").
:- assert_kif("(subclass AnimalSubstance BodySubstance)").
:- assert_kif("(documentation AnimalSubstance EnglishLanguage \"&%BodySubstances that are produced exclusively by &%Animals.\")").
:- assert_kif("(=> (and (instance ?SUBSTANCE AnimalSubstance) (instance ?ANIMAL Organism) (part ?SUBSTANCE ?ANIMAL)) (instance ?ANIMAL Animal))").
:- assert_kif("(subclass PlantSubstance BodySubstance)").
:- assert_kif("(documentation PlantSubstance EnglishLanguage \"&%BodySubstances that are produced exclusively by &%Plants.\")").
:- assert_kif("(=> (and (instance ?SUBSTANCE PlantSubstance) (instance ?PLANT Organism) (part ?SUBSTANCE ?PLANT)) (instance ?PLANT Plant))").
:- assert_kif("(subclass Hormone BodySubstance)").
:- assert_kif("(subclass Hormone BiologicallyActiveSubstance)").
:- assert_kif("(documentation Hormone EnglishLanguage \"In &%Animals, a chemical secreted by an endocrine gland whose products are released into the circulating fluid. &%Plant hormones or synthetic hormones which are used only to alter or control various physiologic processes, e.g., reproductive control agents, are assigned to the &%Class &%BiologicallyActiveSubstance. &%Hormones act as chemical messengers and regulate various physiologic processes such as growth, reproduction, metabolism, etc. They usually fall into two broad categories, viz. steroid hormones and peptide hormones.\")").
:- assert_kif("(=> (instance ?HORMONE Hormone) (exists (?PROCESS ?GLAND) (and (instance ?GLAND Gland) (instrument ?PROCESS ?GLAND) (result ?PROCESS ?HORMONE))))").
:- assert_kif("(subclass Blood BodySubstance)").
:- assert_kif("(documentation Blood EnglishLanguage \"A fluid present in &%Animals that transports &%Nutrients to and waste products away from various &%BodyParts.\")").
:- assert_kif("(instance FoodForFn UnaryFunction)").
:- assert_kif("(domainSubclass FoodForFn 1 Organism)").
:- assert_kif("(rangeSubclass FoodForFn SelfConnectedObject)").
:- assert_kif("(documentation FoodForFn EnglishLanguage \"A &%Function that denotes &%SelfConnectedObject containing &%Nutrients, such as carbohydrates, proteins, and fats, that can be ingested by a the given class of living &%Animal and metabolized into energy and body tissue.\")").
:- assert_kif("(=> (instance ?FOOD (FoodForFn ?A)) (exists (?NUTRIENT) (and (instance ?NUTRIENT Nutrient) (part ?NUTRIENT ?FOOD))))").
:- assert_kif("(subclass Meat SelfConnectedObject)").
:- assert_kif("(documentation Meat EnglishLanguage \"Any food which was originally part of an &%Animal and is not ingested by drinking, including eggs and animal blood that is eaten as food. Note that this class covers both raw meat and meat that has been prepared in some way, e.g. by cooking. Note too that preparations involving &%Meat and &%FruitOrVegetable are classed directly under &%Food.\")").
:- assert_kif("(=> (instance ?MEAT Meat) (forall (?PART) (=> (part ?PART ?MEAT) (exists (?SUBPART ?TIME ?ANIMAL) (and (part ?SUBPART ?PART) (holdsDuring ?TIME (and (instance ?ANIMAL Animal) (part ?SUBPART ?ANIMAL))))))))").
% :- assert_kif("; KJN: Moving this to Mid-level-ontology.kif as it is causing dependency errors. (subclass Beverage Substance) (disjoint Meat Beverage) (documentation Beverage EnglishLanguage \"Any food that is ingested by &%Drinking. Note that this class is disjoint &%Meat and &%FruitOrVegetable.\")").
% :- assert_kif(" (=> (instance ?BEV Beverage) (attribute ?BEV Liquid))").
% :- assert_kif(" (=> (and (instance ?DRINK Drinking) (patient ?DRINK ?BEV)) (instance ?BEV Beverage))").
:- assert_kif("(subclass AnatomicalStructure OrganicObject)").
:- assert_kif("(partition AnatomicalStructure BodyPart AbnormalAnatomicalStructure)").
:- assert_kif("(partition AnatomicalStructure AnimalAnatomicalStructure PlantAnatomicalStructure)").
:- assert_kif("(documentation AnatomicalStructure EnglishLanguage \"A normal or pathological part of the anatomy or structural organization of an &%Organism. This class covers &%BodyParts, as well as structures that are given off by &%Organisms, e.g. &%ReproductiveBodies.\")").
:- assert_kif("(=> (instance ?ANAT AnatomicalStructure) (exists (?ORGANISM ?TIME) (and (instance ?ORGANISM Organism) (temporalPart ?TIME (WhenFn ?ORGANISM)) (holdsDuring ?TIME (part ?ANAT ?ORGANISM)))))").
:- assert_kif("(=> (instance ?PART AnatomicalStructure) (exists (?CELL) (and (instance ?CELL Cell) (part ?CELL ?PART))))").
:- assert_kif("(subclass AbnormalAnatomicalStructure AnatomicalStructure)").
:- assert_kif("(documentation AbnormalAnatomicalStructure EnglishLanguage \"Any &%AnatomicalStructure which is not normally found in the &%Organism of which it is a part, i.e. it is the result of a &%PathologicProcess. This class covers tumors, birth marks, goiters, etc.\")").
:- assert_kif("(=> (instance ?STRUCTURE AbnormalAnatomicalStructure) (exists (?PROC) (and (instance ?PROC PathologicProcess) (result ?PROC ?STRUCTURE))))").
:- assert_kif("(subclass BodyPart AnatomicalStructure)").
:- assert_kif("(documentation BodyPart EnglishLanguage \"A collection of &%Cells and &%Tissues which are localized to a specific area of an &%Organism and which are not pathological. The instances of this &%Class range from gross structures to small components of complex &%Organs.\")").
:- assert_kif("(=> (instance ?PART BodyPart) (exists (?ORGANISM ?TIME) (and (instance ?ORGANISM Organism) (temporalPart ?TIME (WhenFn ?ORGANISM)) (holdsDuring ?TIME (component ?PART ?ORGANISM)))))").
:- assert_kif("(=> (instance ?PART BodyPart) (exists (?PROC) (and (instance ?PROC PhysiologicProcess) (result ?PROC ?PART))))").
:- assert_kif("(subclass AnimalAnatomicalStructure AnatomicalStructure)").
:- assert_kif("(documentation AnimalAnatomicalStructure EnglishLanguage \"&%AnatomicalStructures that are possessed exclusively by &%Animals.\")").
:- assert_kif("(=> (and (instance ?STRUCTURE AnimalAnatomicalStructure) (instance ?ANIMAL Organism) (part ?STRUCTURE ?ANIMAL)) (instance ?ANIMAL Animal))").
:- assert_kif("(subclass PlantAnatomicalStructure AnatomicalStructure)").
:- assert_kif("(documentation PlantAnatomicalStructure EnglishLanguage \"&%AnatomicalStructures that are possessed exclusively by &%Plants.\")").
:- assert_kif("(=> (and (instance ?STRUCTURE PlantAnatomicalStructure) (instance ?PLANT Organism) (part ?STRUCTURE ?PLANT)) (instance ?PLANT Plant))").
:- assert_kif("(subclass ReproductiveBody BodyPart)").
:- assert_kif("(documentation ReproductiveBody EnglishLanguage \"Reproductive structure of &%Organisms. Consists of an &%Embryonic &%Object and a nutritive/protective envelope. Note that this class includes seeds, spores, and &%FruitOrVegetables, as well as the eggs produced by &%Animals.\")").
:- assert_kif("(subclass Egg ReproductiveBody)").
:- assert_kif("(subclass Egg AnimalAnatomicalStructure)").
:- assert_kif("(documentation Egg EnglishLanguage \"The fertilized or unfertilized female &%ReproductiveBody of an &%Animal. This includes &%Bird and &%Reptile eggs, as well as mammalian ova.\")").
% :- assert_kif("; KJN: This is moved from Economy.kif. Seed being subclassed from FruitOrVegetable seems incorrect, though, as FruitOrVegetable talks about a ripened Reproductive Body (although no formal rule states it) while a seed may not necessarily be so. commenting it out for now. (subclass Seed FruitOrVegetable)").
:- assert_kif("(subclass Seed ReproductiveBody)").
:- assert_kif("(subclass Seed PlantAnatomicalStructure)").
:- assert_kif("(documentation Seed EnglishLanguage \"The fertilized or unfertilized female &%ReproductiveBody of a &%FloweringPlant.\")").
:- assert_kif("(=> (instance ?SEED Seed) (exists (?PLANT ?TIME) (and (instance ?PLANT FloweringPlant) (holdsDuring ?TIME (part ?SEED ?PLANT)))))").
:- assert_kif("(subclass Pollen ReproductiveBody)").
:- assert_kif("(subclass Pollen PlantAnatomicalStructure)").
:- assert_kif("(documentation Pollen EnglishLanguage \"A powder produced by &%FloweringPlants that contains male gametes and is capable of fertilizing the seeds of &%FloweringPlants of the same species.\")").
:- assert_kif("(subclass FruitOrVegetable PlantAnatomicalStructure)").
:- assert_kif("(subclass FruitOrVegetable ReproductiveBody)").
:- assert_kif("(documentation FruitOrVegetable EnglishLanguage \"Any fruit or vegetable, i.e. a ripened &%ReproductiveBody of a &%Plant. Note that &%FruitOrVegetable is not a subclass of &%Food, because some fruits, e.g. poisonous berries, are not edible.\")").
:- assert_kif("(subclass Spore ReproductiveBody)").
:- assert_kif("(subclass Spore PlantAnatomicalStructure)").
:- assert_kif("(documentation Spore EnglishLanguage \"Any &%ReproductiveBody of a &%NonFloweringPlant.\")").
:- assert_kif("(=> (instance ?SPORE Spore) (exists (?PLANT ?TIME) (and (instance ?PLANT NonFloweringPlant) (holdsDuring ?TIME (part ?SPORE ?PLANT)))))").
:- assert_kif("(subclass BodyCovering BodyPart)").
:- assert_kif("(documentation BodyCovering EnglishLanguage \"Any &%BodyPart which is a covering of another &%BodyPart or of an entire &%Organism. This would include the rinds of &%FruitOrVegetables and the skins of &%Animals.\")").
:- assert_kif("(=> (instance ?COVER BodyCovering) (exists (?BODY) (and (superficialPart ?COVER ?BODY) (or (instance ?BODY Organism) (instance ?BODY BodyPart)))))").
:- assert_kif("(subclass BodyJunction BodyPart)").
:- assert_kif("(documentation BodyJunction EnglishLanguage \"The place where two &%BodyParts meet or connect.\")").
:- assert_kif("(=> (instance ?JUNCT BodyJunction) (exists (?OBJ1 ?OBJ2) (and (instance ?OBJ1 BodyPart) (instance ?OBJ2 BodyPart) (connects ?JUNCT ?OBJ1 ?OBJ2))))").
:- assert_kif("(subclass BodyCavity BodyPart)").
:- assert_kif("(documentation BodyCavity EnglishLanguage \"Any &%BodyPart which contains an unfilled space, e.g. &%BodyVessels, the atria and ventricles of the heart, the lungs, etc.\")").
:- assert_kif("(subclass BodyVessel BodyCavity)").
:- assert_kif("(documentation BodyVessel EnglishLanguage \"Any tube-like structure which occurs naturally in an &%Organism and through which a &%BodySubstance can circulate.\")").
:- assert_kif("(subclass Cell BodyPart)").
:- assert_kif("(documentation Cell EnglishLanguage \"The fundamental structural and functional unit of living &%Organisms.\")").
:- assert_kif("(subclass Organ BodyPart)").
:- assert_kif("(documentation Organ EnglishLanguage \"A somewhat independent &%BodyPart that performs a specialized function. Note that this functional definition covers bodily systems, e.g. the digestive system or the central nervous system.\")").
:- assert_kif("(=> (instance ?ORGAN Organ) (exists (?PURP) (hasPurpose ?ORGAN ?PURP)))").
:- assert_kif("(subclass Gland Organ)").
:- assert_kif("(documentation Gland EnglishLanguage \"An &%Organ that removes &%Substances from the &%Blood, alters them in some way, and then releases them.\")").
:- assert_kif("(subclass Tissue BodySubstance)").
:- assert_kif("(disjointDecomposition Tissue Bone Muscle FatTissue)").
:- assert_kif("(documentation Tissue EnglishLanguage \"An aggregation of similarly specialized &%Cells and the associated intercellular substance. &%Tissues are relatively non-localized in comparison to &%BodyParts, &%Organs or &%Organ components. The main features of &%Tissues are self-connectivity (see &%SelfConnectedObject) and being a homogeneous mass (all parts in the same granularity are instances of &%Tissue as well).\")").
:- assert_kif("(=> (instance ?STUFF Tissue) (exists (?PART) (and (instance ?PART Cell) (part ?PART ?STUFF))))").
:- assert_kif("(=> (instance ?STUFF Tissue) (exists (?ORGANISM) (and (instance ?ORGANISM Organism) (part ?STUFF ?ORGANISM))))").
:- assert_kif("(subclass Bone Tissue)").
:- assert_kif("(subclass Bone AnimalSubstance)").
:- assert_kif("(documentation Bone EnglishLanguage \"Rigid &%Tissue composed largely of calcium that makes up the skeleton of &%Vertebrates. Note that this &%Class also includes teeth.\")").
:- assert_kif("(=> (instance ?BONE Bone) (exists (?VERT) (and (instance ?VERT Vertebrate) (part ?BONE ?VERT))))").
:- assert_kif("(subclass Muscle Tissue)").
:- assert_kif("(subclass Muscle AnimalSubstance)").
:- assert_kif("(documentation Muscle EnglishLanguage \"Nonrigid &%Tissue appearing only in &%Animals and composed largely of contractile cells.\")").
:- assert_kif("(subclass FatTissue Tissue)").
:- assert_kif("(documentation FatTissue EnglishLanguage \"Nonrigid &%Tissue that is composed largely of fat cells.\")").
:- assert_kif("(subclass Noun Word)").
:- assert_kif("(partition Word Noun Verb Adjective Adverb ParticleWord)").
:- assert_kif("(documentation Noun EnglishLanguage \"One of the parts of speech. The &%Class of &%Words that conventionally denote &%Objects.\")").
:- assert_kif("(subclass Verb Word)").
:- assert_kif("(documentation Verb EnglishLanguage \"One of the parts of speech. The &%Class of &%Words that conventionally denote &%Processes.\")").
:- assert_kif("(subclass Adjective Word)").
:- assert_kif("(documentation Adjective EnglishLanguage \"One of the parts of speech. The &%Class of &%Words that conventionally denote &%Attributes of &%Objects.\")").
:- assert_kif("(subclass Adverb Word)").
:- assert_kif("(documentation Adverb EnglishLanguage \"One of the parts of speech. The &%Class of &%Words that conventionally denote &%Attributes of &%Processes.\")").
:- assert_kif("(subclass ParticleWord Word)").
:- assert_kif("(documentation ParticleWord EnglishLanguage \"An umbrella &%Class for any &%Word that does not fit into the other subclasses of &%Word. A &%ParticleWord is generally a small term that serves a grammatical or logical function, e.g. 'and', 'of', 'since', etc. At some point, this class might be broken up into the subclasses 'Connective', 'Preposition', etc. Note that the class &%ParticleWord includes both personal and possessive pronouns, e.g. 'she', 'hers', 'it', 'its', etc.\")").
:- assert_kif("(subclass Morpheme LinguisticExpression)").
:- assert_kif("(documentation Morpheme EnglishLanguage \"Part of a &%Word which cannot be subdivided and which expresses a meaning.\")").
:- assert_kif("(=> (instance ?MORPH Morpheme) (not (exists (?OTHERMORPH) (and (instance ?OTHERMORPH Morpheme) (part ?OTHERMORPH ?MORPH) (not (equal ?OTHERMORPH ?MORPH))))))").
:- assert_kif("(=> (instance ?MORPH Morpheme) (exists (?WORD) (and (instance ?WORD Word) (part ?MORPH ?WORD))))").
:- assert_kif("(=> (instance ?WORD Word) (exists (?PART) (and (part ?PART ?WORD) (instance ?PART Morpheme))))").
:- assert_kif("(subclass Phrase LinguisticExpression)").
:- assert_kif("(disjointDecomposition Phrase VerbPhrase NounPhrase PrepositionalPhrase)").
:- assert_kif("(documentation Phrase EnglishLanguage \"A set of &%Words in a &%Language which form a unit, i.e. express a meaning in the &%Language.\")").
:- assert_kif("(=> (instance ?PHRASE Phrase) (exists (?PART1 ?PART2) (and (part ?PART1 ?PHRASE) (part ?PART2 ?PHRASE) (instance ?PART1 Word) (instance ?PART2 Word) (not (equal ?PART1 ?PART2)))))").
:- assert_kif("(subclass VerbPhrase Phrase)").
:- assert_kif("(documentation VerbPhrase EnglishLanguage \"A &%Phrase that has the same function as a &%Verb.\")").
:- assert_kif("(=> (instance ?PHRASE VerbPhrase) (exists (?VERB) (and (instance ?VERB Verb) (part ?VERB ?PHRASE))))").
:- assert_kif("(subclass NounPhrase Phrase)").
:- assert_kif("(disjoint NounPhrase VerbPhrase)").
:- assert_kif("(documentation NounPhrase EnglishLanguage \"A &%Phrase that has the same function as a &%Noun.\")").
:- assert_kif("(=> (instance ?SENTENCE Sentence) (exists (?PHRASE1 ?PHRASE2) (and (instance ?PHRASE1 NounPhrase) (instance ?PHRASE2 VerbPhrase) (part ?PHRASE1 ?SENTENCE) (part ?PHRASE2 ?SENTENCE))))").
:- assert_kif("(=> (instance ?PHRASE NounPhrase) (exists (?NOUN) (and (instance ?NOUN Noun) (part ?NOUN ?PHRASE))))").
:- assert_kif("(subclass PrepositionalPhrase Phrase)").
:- assert_kif("(documentation PrepositionalPhrase EnglishLanguage \"A &%Phrase that begins with a preposition and that functions as an &%Adjective or an &%Adverb.\")").
:- assert_kif("(=> (instance ?PHRASE PrepositionalPhrase) (exists (?PREP) (and (instance ?PREP ParticleWord) (part ?PREP ?PHRASE))))").
:- assert_kif("(subclass Text LinguisticExpression)").
:- assert_kif("(subclass Text ContentBearingObject)").
:- assert_kif("(subclass Text Artifact)").
:- assert_kif("(documentation Text EnglishLanguage \"A &%LinguisticExpression or set of &%LinguisticExpressions that perform a specific function related to &%Communication, e.g. express a discourse about a particular topic, and that are inscribed in a &%CorpuscularObject by &%Humans.\")").
:- assert_kif("(=> (instance ?TEXT Text) (exists (?PART) (and (part ?PART ?TEXT) (instance ?PART LinguisticExpression))))").
:- assert_kif("(=> (instance ?TEXT Text) (exists (?WRITE) (and (instance ?WRITE Writing) (result ?WRITE ?TEXT))))").
:- assert_kif("(subclass FactualText Text)").
:- assert_kif("(disjoint FactualText FictionalText)").
:- assert_kif("(documentation FactualText EnglishLanguage \"The class of &%Texts that purport to reveal facts about the world. Such texts are often known as information or as non-fiction. Note that something can be an instance of &%FactualText, even if it is wholly inaccurate. Whether something is a &%FactualText is determined by the beliefs of the agent creating the text.\")").
% :- assert_kif("; NS: delete. The 2nd argument to &%authors must be a &%Class. (=> (and (instance ?TEXT FactualText) (authors ?AGENT ?TEXT) (subsumesContentInstance ?TEXT ?CONTENT) (instance ?CONTENT Formula)) (believes ?AGENT ?CONTENT))").
% :- assert_kif("; NS: add.").
:- assert_kif("(=> (and (instance ?TEXT ?CLASS) (subclass ?CLASS FactualText) (authors ?AGENT ?CLASS) (subsumesContentInstance ?TEXT ?CONTENT) (instance ?CONTENT Formula)) (believes ?AGENT ?CONTENT))").
:- assert_kif("(subclass FictionalText Text)").
:- assert_kif("(documentation FictionalText EnglishLanguage \"The class of &%Texts that purport to be largely a product of the author's imagination, i.e. the author does not believe that most of the content conveyed by the text is an accurate depiction of the real world. Note that something can be an instance of &%FictionalText, even if it is completely true. Whether something is a &%FictionalText is determined by the beliefs of the agent creating the text.\")").
% :- assert_kif("; NS: delete. Wrong use of &%authors. Also, the rule is supposed to be about &%FictionalText, not &%FactualText. (=> (and (instance ?TEXT FactualText) (authors ?AGENT ?TEXT)) (exists (?CONTENT) (and (subsumesContentInstance ?TEXT ?CONTENT) (instance ?CONTENT Formula) (not (believes ?AGENT ?CONTENT)))))").
% :- assert_kif("; NS: add.").
:- assert_kif("(=> (and (instance ?TEXT ?CLASS) (subclass ?CLASS FictionalText) (authors ?AGENT ?CLASS)) (exists (?CONTENT) (and (subsumesContentInstance ?TEXT ?CONTENT) (instance ?CONTENT Formula) (not (believes ?AGENT ?CONTENT)))))").
:- assert_kif("(subclass Sentence LinguisticExpression)").
:- assert_kif("(documentation Sentence EnglishLanguage \"A syntactically well-formed formula of a &%Language. It includes, at minimum, a predicate and a subject (which may be explicit or implicit), and it expresses a &%Proposition.\")").
:- assert_kif("(=> (instance ?SENT Sentence) (exists (?PROP) (and (instance ?PROP Proposition) (containsInformation ?SENT ?PROP))))").
:- assert_kif("(instance authors BinaryPredicate)").
:- assert_kif("(instance authors AsymmetricRelation)").
:- assert_kif("(domain authors 1 Agent)").
:- assert_kif("(domainSubclass authors 2 Text)").
% :- assert_kif("; NS: edit.").
:- assert_kif("(documentation authors EnglishLanguage \"(&%authors ?AGENT ?TEXTCLASS) means that ?AGENT is creatively responsible for the content of all instances of ?TEXTCLASS. For example, Agatha Christie is author of Murder_on_the_Orient_Express.\")").
% :- assert_kif("; NS: edit.").
:- assert_kif("(=> (authors ?AGENT ?TEXTCLASS) (exists (?PROCESS ?INSTANCE) (and (agent ?PROCESS ?AGENT) (instance ?INSTANCE ?TEXTCLASS) (result ?PROCESS ?INSTANCE))))").
:- assert_kif("(instance editor BinaryPredicate)").
:- assert_kif("(instance editor AsymmetricRelation)").
:- assert_kif("(domain editor 1 Agent)").
:- assert_kif("(domainSubclass editor 2 Text)").
% :- assert_kif("; NS: edit.").
:- assert_kif("(documentation editor EnglishLanguage \"(&%editor ?AGENT ?TEXTCLASS) means that ?AGENT is an editor of the content contained (or realized) in all instances of ?TEXTCLASS.\")").
:- assert_kif("(instance publishes BinaryPredicate)").
:- assert_kif("(instance publishes AsymmetricRelation)").
:- assert_kif("(domain publishes 1 Organization)").
:- assert_kif("(domainSubclass publishes 2 Text)").
% :- assert_kif("; NS: edit.").
:- assert_kif("(documentation publishes EnglishLanguage \"(&%publishes ?ORG ?TEXTCLASS) means that ?ORG publishes all instances of ?TEXTCLASS. For example, Bantam Books publishes Agatha Christie's Murder_on_the_Orient_Express.\")").
% :- assert_kif("; NS: edit.").
:- assert_kif("(=> (and (publishes ?ORG ?TEXTCLASS) (instance ?INST ?TEXTCLASS)) (exists (?PUB) (and (instance ?PUB Publication) (agent ?PUB ?ORG) (patient ?PUB ?INST))))").
:- assert_kif("(instance EditionFn BinaryFunction)").
:- assert_kif("(instance EditionFn PartialValuedRelation)").
:- assert_kif("(domainSubclass EditionFn 1 ContentBearingObject)").
:- assert_kif("(domain EditionFn 2 PositiveInteger)").
:- assert_kif("(rangeSubclass EditionFn ContentBearingObject)").
:- assert_kif("(documentation EditionFn EnglishLanguage \"A &%BinaryFunction that maps a type of text").
:- assert_kif("(e.g. Agatha Christie's Murder_on_the_Orient_Express) and a number to the edition of the text type corresponding to the number.\")").
:- assert_kif("(=> (and (equal (EditionFn ?TEXT ?INT1) ?EDITION1) (equal (EditionFn ?TEXT ?INT2) ?EDITION2) (greaterThan ?INT2 ?INT1) (instance ?PUB1 Publication) (instance ?PUB2 Publication) (instance ?CBO1 ?EDITION1) (instance ?CBO2 ?EDITION2) (patient ?PUB1 ?CBO1) (patient ?PUB2 ?CBO2) (date ?PUB1 ?DATE1) (date ?PUB2 ?DATE2)) (before (EndFn ?DATE1) (EndFn ?DATE2)))").
:- assert_kif("(=> (equal (EditionFn ?TEXT1 ?NUMBER) ?TEXT2) (subsumesContentClass ?TEXT1 ?TEXT2))").
% :- assert_kif("; KJN: Moving to MILO (instance SeriesVolumeFn BinaryFunction) (instance SeriesVolumeFn PartialValuedRelation) (domainSubclass SeriesVolumeFn 1 Series) (domain SeriesVolumeFn 2 PositiveInteger) (rangeSubclass SeriesVolumeFn Text) (documentation SeriesVolumeFn EnglishLanguage \"A &%BinaryFunction that maps a type of &%Series (e.g. the Encyclopedia_Britannica or the Popular_Mechanics periodical) and a number to the volumes of the text type designated by the number.\")").
% :- assert_kif(" (=> (and (subclass ?TEXT Periodical) (equal (SeriesVolumeFn ?TEXT ?INT1) ?VOLUME1) (equal (SeriesVolumeFn ?TEXT ?INT2) ?VOLUME2) (greaterThan ?INT2 ?INT1) (instance ?PUB1 Publication) (instance ?PUB2 Publication) (instance ?CBO1 ?VOLUME1) (instance ?CBO2 ?VOLUME2) (patient ?PUB1 ?CBO1) (patient ?PUB2 ?CBO2) (date ?PUB1 ?DATE1) (date ?PUB2 ?DATE2)) (before (EndFn ?DATE1) (EndFn ?DATE2)))").
% :- assert_kif(" (=> (equal (SeriesVolumeFn ?SERIES ?NUMBER) ?VOLUME) (subsumesContentClass ?SERIES ?VOLUME))").
% :- assert_kif("; KJN: Moving to MILO (instance PeriodicalIssueFn BinaryFunction) (instance PeriodicalIssueFn PartialValuedRelation) (domainSubclass PeriodicalIssueFn 1 Periodical) (domain PeriodicalIssueFn 2 PositiveInteger) (rangeSubclass PeriodicalIssueFn Periodical) (documentation PeriodicalIssueFn EnglishLanguage \"A &%BinaryFunction that maps a subclass of &%Periodical and a number to all of the issues of the &%Periodical corresponding to the number.\")").
% :- assert_kif(" (=> (equal (PeriodicalIssueFn ?PERIODICAL ?NUMBER) ?ISSUE) (subsumesContentClass ?PERIODICAL ?ISSUE))").
% :- assert_kif("; KJN: Moving to MILO (subclass Book Text) (documentation Book EnglishLanguage \"A &%Text that has pages and is bound.\")").
:- assert_kif("(subclass Summary Text)").
:- assert_kif("(documentation Summary EnglishLanguage \"A short &%Text that is a summary of another, longer &%Text.\")").
:- assert_kif("(=> (instance ?TEXT Summary) (exists (?TEXT2) (and (instance ?TEXT2 Text) (subsumesContentInstance ?TEXT2 ?TEXT))))").
% :- assert_kif("; KJN: Moving to MILO (subclass Series Text) (documentation Series EnglishLanguage \"A &%Text consisting of multiple self-contained units. Some examples are an encyclopedia containing a couple dozen volumes, a television series made up of many episodes, a film serial, etc.\")").
% :- assert_kif(" (=> (instance ?SERIES Series) (exists (?BOOK1 ?BOOK2) (and (instance ?BOOK1 Book) (instance ?BOOK2 Book) (subsumesContentInstance ?SERIES ?BOOK1) (subsumesContentInstance ?SERIES ?BOOK2) (not (equal ?BOOK1 ?BOOK2)))))").
% :- assert_kif(" (subclass Periodical Series) (documentation Periodical EnglishLanguage \"A &%Series whose elements are published separately and on a periodic basis.\")").
% :- assert_kif(" (subclass Article Text) (disjoint Article Book) (documentation Article EnglishLanguage \"A relatively short &%Text that either is unbound or is bound with other &%Articles in a &%Book.\")").
% :- assert_kif(" (=> (and (instance ?ARTICLE1 Article) (instance ?BOOK Book) (subsumesContentInstance ?BOOK ?ARTICLE1)) (exists (?ARTICLE2) (and (instance ?ARTICLE2 Article) (not (equal ?ARTICLE2 ?ARTICLE1)) (subsumesContentInstance ?BOOK ?ARTICLE2))))").
:- assert_kif("(subclass Certificate Text)").
:- assert_kif("(documentation Certificate EnglishLanguage \"A &%Text that confers a right or obligation on the holder of the &%Certificate. Note that the right or obligation need not be a legal one, as in the case of an academic diploma that grants certain privileges in the professional world.\")").
:- assert_kif("(=> (instance ?DOC Certificate) (exists (?PROP ?NORM) (or (confersNorm ?DOC ?PROP ?NORM) (deprivesNorm ?DOC ?PROP ?NORM))))").
:- assert_kif("(subclass FinancialInstrument Certificate)").
:- assert_kif("(documentation FinancialInstrument EnglishLanguage \"A document having monetary value or recording a monetary transaction\")").
:- assert_kif("(subclass Currency FinancialInstrument)").
:- assert_kif("(documentation Currency EnglishLanguage \"Any element of the official currrency of some &%Nation. This covers both &%CurrencyBills and &%CurrencyCoins.\")").
:- assert_kif("(=> (instance ?CURRENCY Currency) (exists (?MEASURE) (monetaryValue ?CURRENCY ?MEASURE)))").
:- assert_kif("(subclass Patent Certificate)").
:- assert_kif("(documentation Patent EnglishLanguage \"A &%Certificate that expresses the content of an invention that has been accorded legal protection by a governemental entity.\")").
:- assert_kif("(subclass Molecule CompoundSubstance)").
:- assert_kif("(documentation Molecule EnglishLanguage \"A molecule is the smallest unit of matter of a &%CompoundSubstance that retains all the physical and chemical properties of that substance, e.g., Ne, H2, H2O. A molecule is two or more &%Atoms linked by a chemical bond.\")").
:- assert_kif("(=> (instance ?MOLE Molecule) (exists (?ATOM1 ?ATOM2) (and (instance ?ATOM1 Atom) (instance ?ATOM2 Atom) (part ?ATOM1 ?MOLE) (part ?ATOM2 ?MOLE) (not (equal ?ATOM1 ?ATOM2)))))").
:- assert_kif("(subclass Artifact Object)").
:- assert_kif("(documentation Artifact EnglishLanguage \"An &%Object that is the product of a &%Making.\")").
:- assert_kif("(<=> (instance ?ARTIFACT Artifact) (exists (?MAKING) (and (instance ?MAKING Making) (result ?MAKING ?ARTIFACT))))").
:- assert_kif("(subclass Product Artifact)").
:- assert_kif("(documentation Product EnglishLanguage \"An &%Artifact that is produced by &%Manufacture.\")").
:- assert_kif("(=> (instance ?PRODUCT Product) (exists (?MANUFACTURE) (and (instance ?MANUFACTURE Manufacture) (result ?MANUFACTURE ?PRODUCT))))").
:- assert_kif("(instance version BinaryPredicate)").
:- assert_kif("(instance version AsymmetricRelation)").
:- assert_kif("(instance version TransitiveRelation)").
:- assert_kif("(domainSubclass version 1 Artifact)").
:- assert_kif("(domainSubclass version 2 Artifact)").
:- assert_kif("(documentation version EnglishLanguage \"Some &%Artifacts have a life cycle with discrete stages or versions. (&%version ARTIFACT1 ARTIFACT2) means that ARTIFACT1 is a version of ARTIFACT2. Note that this &%Predicate relates subclasses of &%Artifact and not instances.\")").
:- assert_kif("(=> (version ?ARTIFACT1 ?ARTIFACT2) (subclass ?ARTIFACT1 ?ARTIFACT2))").
% :- assert_kif("; The following part of the ontology will eventually encompass all artifacts. For the time being, it is mostly restricted to the content of the Ontolingua ontology component-assemblies, which covers the types of elements used to construct engineering systems.").
:- assert_kif("(subclass StationaryArtifact Artifact)").
:- assert_kif("(documentation StationaryArtifact EnglishLanguage \"A &%StationaryArtifact is an &%Artifact that has a fixed spatial location. Most instances of this &%Class are architectural works, e.g. the Eiffel Tower, the Great Pyramids, office towers, single-family houses, etc.\")").
:- assert_kif("(=> (instance ?ARTIFACT StationaryArtifact) (exists (?PLACE) (and (holdsDuring (WhenFn ?ARTIFACT) (located ?ARTIFACT ?PLACE)) (not (exists (?P2) (and (holdsDuring (WhenFn ?ARTIFACT) (located ?ARTIFACT ?P2)) (not (equal ?PLACE ?P2))))))))").
:- assert_kif("(subclass Building StationaryArtifact)").
:- assert_kif("(documentation Building EnglishLanguage \"The Class of &%StationaryArtifacts which are intended to house &%Humans and their activities.\")").
:- assert_kif("(=> (instance ?BUILDING Building) (exists (?HUMAN) (and (instance ?HUMAN Human) (or (inhabits ?HUMAN ?BUILDING) (exists (?ACT) (and (agent ?ACT ?HUMAN) (located ?ACT ?BUILDING)))))))").
:- assert_kif("(subclass Room StationaryArtifact)").
:- assert_kif("(disjoint Room Building)").
:- assert_kif("(documentation Room EnglishLanguage \"A &%properPart of a &%Building which is separated from the exterior of the &%Building and/or other &%Rooms of the &%Building by walls. Some &%Rooms may have a specific purpose, e.g. sleeping, bathing, cooking, entertainment, etc.\")").
:- assert_kif("(=> (instance ?ROOM Room) (exists (?BUILD) (and (instance ?BUILD Building) (properPart ?ROOM ?BUILD))))").
:- assert_kif("(subclass House ResidentialBuilding)").
:- assert_kif("(subclass House SingleFamilyResidence)").
:- assert_kif("(documentation House EnglishLanguage \"A &%ResidentialBuilding which is intended to be inhabited by members of the same &%SocialUnit. &%Houses are distinguished from temporary housing like hotels and multi-family dwellings like condominium and apartment buildings.\")").
:- assert_kif("(subclass Residence StationaryArtifact)").
:- assert_kif("(partition Residence PermanentResidence TemporaryResidence)").
:- assert_kif("(documentation Residence EnglishLanguage \"A &%Building or part of a &%Building which provides some accomodation for sleeping.\")").
:- assert_kif("(=> (instance ?RESIDENCE Residence) (or (instance ?RESIDENCE House) (exists (?BUILDING) (and (instance ?BUILDING ResidentialBuilding) (part ?RESIDENCE ?BUILDING)))))").
:- assert_kif("(subclass PermanentResidence Residence)").
:- assert_kif("(documentation PermanentResidence EnglishLanguage \"A &%Residence where people live, i.e. where people have a &%home.\")").
:- assert_kif("(=> (instance ?RESIDENCE PermanentResidence) (exists (?PERSON) (home ?PERSON ?RESIDENCE)))").
:- assert_kif("(subclass TemporaryResidence Residence)").
:- assert_kif("(documentation TemporaryResidence EnglishLanguage \"A &%Residence which is strictly temporary, i.e. where no one makes his/her &%home.\")").
:- assert_kif("(=> (instance ?RESIDENCE TemporaryResidence) (not (exists (?PERSON) (home ?PERSON ?RESIDENCE))))").
:- assert_kif("(subclass ResidentialBuilding Building)").
:- assert_kif("(subclass ResidentialBuilding Residence)").
:- assert_kif("(documentation ResidentialBuilding EnglishLanguage \"A &%Building which provides some accomodation for sleeping. Note that this class does not cover just permanent residences, e.g. &%Houses and condominium and apartment buildings, but also temporary residences, e.g. hotels and dormitories. &%ResidentialBuildings are also distinguished from &%CommercialBuildings, which are intended to serve an organizational rather than a residential function.\")").
% :- assert_kif("; Moved hotel definition to Hotel.kif. (subclass Hotel ResidentialBuilding) (subclass Hotel TemporaryResidence) (subclass Hotel CommercialAgent) (documentation Hotel EnglishLanguage \"A &%ResidentialBuilding which provides temporary accommodations to guests in exchange for money.\")").
:- assert_kif("(subclass SingleFamilyResidence PermanentResidence)").
:- assert_kif("(documentation SingleFamilyResidence EnglishLanguage \"A &%PermanentResidence which is intended to be the &%home of a single &%SocialUnit. This class covers &%Houses, &%ApartmentUnits, and &%CondominiumUnits.\")").
:- assert_kif("(=> (instance ?RESIDENCE SingleFamilyResidence) (hasPurpose ?RESIDENCE (forall (?AGENT1 ?AGENT2) (=> (and (home ?AGENT1 ?RESIDENCE) (home ?AGENT2 ?RESIDENCE)) (exists (?UNIT) (and (instance ?UNIT SocialUnit) (member ?AGENT1 ?UNIT) (member ?AGENT2 ?UNIT)))))))").
:- assert_kif("(subclass ArtWork Artifact)").
:- assert_kif("(documentation ArtWork EnglishLanguage \"&%Artifacts that are created primarily for aesthetic appreciation. Note that this &%Class does not include most examples of architecture, which belong under &%StationaryArtifact.\")").
:- assert_kif("(=> (instance ?AW ArtWork) (hasPurpose ?AW (exists (?H ?P) (and (instance ?H Human) (instance ?P Perception) (experiencer ?P ?H) (patient ?P ?AW)))))").
:- assert_kif("(=> (instance ?AW ArtWork) (hasPurpose ?AW (exists (?P) (and (instance ?H Human) (desires ?H (exists (?P) (and (instance ?P Perception) (experiencer ?P ?H) (patient ?P ?AW))))))))").
:- assert_kif("(subclass RepresentationalArtWork ArtWork)").
:- assert_kif("(subclass RepresentationalArtWork Icon)").
:- assert_kif("(documentation RepresentationalArtWork EnglishLanguage \"Any &%ArtWork that &%represents something &%Physical.\")").
:- assert_kif("(=> (instance ?RA RepresentationalArtWork) (exists (?P) (and (instance ?P Physical) (represents ?RA ?P))))").
:- assert_kif("(subclass Fabric Artifact)").
:- assert_kif("(disjoint Fabric StationaryArtifact)").
:- assert_kif("(documentation Fabric EnglishLanguage \"&%Artifacts that are created by weaving together natural or synthetic fibers or by treating the skins of certain sorts of &%Animals. Note that this &%Class includes articles that are created by stitching together various types of fabrics, e.g. bedspreads. On the other hand, &%Clothing is not a &%subclass of &%Fabric, because many clothing items contain elements that are not fabrics.\")").
:- assert_kif("(subclass WearableItem Artifact)").
:- assert_kif("(documentation WearableItem EnglishLanguage \"&%WearableItem is the subclass of &%Artifacts that are made to be worn on the body.\")").
:- assert_kif("(=> (instance ?WI WearableItem) (hasPurpose ?WI (exists (?H) (and (instance ?H Human) (wears ?H ?WI)))))").
:- assert_kif("(subclass Clothing WearableItem)").
:- assert_kif("(disjoint Clothing StationaryArtifact)").
:- assert_kif("(documentation Clothing EnglishLanguage \"&%Artifact made out of fabrics and possibly other materials that are used to cover the bodies of &%Humans.\")").
:- assert_kif("(=> (instance ?CLOTHING Clothing) (exists (?FABRIC) (and (instance ?FABRIC Fabric) (part ?FABRIC ?CLOTHING))))").
:- assert_kif("(instance wears BinaryPredicate)").
:- assert_kif("(domain wears 1 Animal)").
:- assert_kif("(domain wears 2 WearableItem)").
:- assert_kif("(documentation wears EnglishLanguage \"(&%wears ?AGENT ?WI) means that ?AGENT is wearing the &%WearableItem item ?WI.\")").
:- assert_kif("(=> (wears ?AGENT ?WI) (located ?WI ?AGENT))").
:- assert_kif("(=> (and (wears ?A ?C) (part ?P ?C)) (wears ?A ?P))").
:- assert_kif("(subclass Device Artifact)").
:- assert_kif("(documentation Device EnglishLanguage \"A &%Device is an &%Artifact whose purpose is to serve as an &%instrument in a specific subclass of &%Process.\")").
:- assert_kif("(=> (instance ?DEVICE Device) (exists (?PROC) (capability ?PROC instrument ?DEVICE)))").
:- assert_kif("(=> (instance ?DEVICE Device) (exists (?PROC) (hasPurpose ?DEVICE (exists (?INST) (and (instance ?INST ?PROC) (instrument ?INST ?DEVICE))))))").
:- assert_kif("(subclass MusicalInstrument Device)").
:- assert_kif("(documentation MusicalInstrument EnglishLanguage \"A &%Device which is manipulated by a &%Human and whose purpose is &%MakingMusic.\")").
:- assert_kif("(=> (instance ?INSTRUMENT MusicalInstrument) (capability MakingMusic instrument ?INSTRUMENT))").
:- assert_kif("(subclass TransportationDevice Device)").
:- assert_kif("(documentation TransportationDevice EnglishLanguage \"A &%TransportationDevice is a &%Device which serves as the &%instrument in a &%Transportation &%Process which carries the &%patient of the &%Process from one point to another.\")").
:- assert_kif("(=> (instance ?DEVICE TransportationDevice) (capability Transportation instrument ?DEVICE))").
:- assert_kif("(subclass Vehicle TransportationDevice)").
:- assert_kif("(documentation Vehicle EnglishLanguage \"&%Vehicle is the subclass of &%TransportationDevices that transport passengers or goods from one place to another by moving from one place to the other with them, e.g., cars, trucks, ferries, and airplanes. Contrast with devices such as pipelines, escalators, or supermarket checkout belts, which carry items from one place to another by means of a moving part, without the device removing from the origin to the destination.\")").
:- assert_kif("(=> (and (instance ?TRANSPORT Vehicle) (instance ?MOVE Translocation) (instrument ?MOVE ?TRANSPORT) (origin ?MOVE ?FROM)) (holdsDuring (BeginFn (WhenFn ?MOVE)) (located ?TRANSPORT ?FROM)))").
:- assert_kif("(=> (and (instance ?TRANSPORT Vehicle) (instance ?MOVE Translocation) (instrument ?MOVE ?TRANSPORT) (destination ?MOVE ?TO)) (holdsDuring (BeginFn (WhenFn ?MOVE)) (located ?TRANSPORT ?TO)))").
:- assert_kif("(subclass MeasuringDevice Device)").
:- assert_kif("(documentation MeasuringDevice EnglishLanguage \"Any &%Device whose purpose is to measure a &%PhysicalQuantity.\")").
:- assert_kif("(=> (instance ?DEVICE MeasuringDevice) (hasPurpose ?DEVICE (exists (?MEASURE) (and (instance ?MEASURE Measuring) (instrument ?MEASURE ?DEVICE)))))").
:- assert_kif("(subclass AttachingDevice Device)").
:- assert_kif("(documentation AttachingDevice EnglishLanguage \"A &%Device whose purpose is to attach one thing to something else, e.g. nails, screws, buttons, etc.\")").
:- assert_kif("(=> (instance ?DEVICE AttachingDevice) (exists (?ATTACH) (and (instance ?ATTACH Attaching) (instrument ?ATTACH ?DEVICE))))").
:- assert_kif("(subclass Weapon Device)").
:- assert_kif("(documentation Weapon EnglishLanguage \"The &%Class of &%Devices that are designed primarily to damage or destroy &%Humans/&%Animals, &%StationaryArtifacts or the places inhabited by &%Humans/&%Animals.\")").
:- assert_kif("(=> (instance ?WEAPON Weapon) (capability Damaging instrument ?WEAPON))").
:- assert_kif("(=> (instance ?WEAPON Weapon) (hasPurpose ?WEAPON (exists (?D ?PATIENT) (and (instance ?D Damaging) (instrument ?D ?WEAPON) (patient ?D ?PATIENT)))))").
:- assert_kif("(subclass Machine Device)").
:- assert_kif("(documentation Machine EnglishLanguage \"&%Machines are &%Devices that that have a well-defined &%resource and &%result and that automatically convert the &%resource into the &%result.\")").
:- assert_kif("(=> (instance ?MACHINE Machine) (forall (?PROC) (=> (instrument ?PROC ?MACHINE) (exists (?RESOURCE ?RESULT) (and (resource ?PROC ?RESOURCE) (result ?PROC ?RESULT))))))").
:- assert_kif("(subclass EngineeringComponent Device)").
:- assert_kif("(documentation EngineeringComponent EnglishLanguage \"A fundamental concept that applies in many engineering domains. An &%EngineeringComponent is an element of a &%Device that is a physically whole object, such as one might see listed as standard parts in a catalog. The main difference betweeen &%EngineeringComponents and arbitrary globs of matter is that &%EngineeringComponents are object-like in a modeling sense. Thus, an &%EngineeringComponent is not an arbtrary subregion, but a part of a system with a stable identity.\")").
:- assert_kif("(=> (instance ?COMP EngineeringComponent) (exists (?DEVICE) (and (instance ?DEVICE Device) (component ?COMP ?DEVICE))))").
:- assert_kif("(=> (instance ?MACHINE Machine) (exists (?COMP1 ?COMP2) (and (instance ?COMP1 EngineeringComponent) (instance ?COMP2 EngineeringComponent) (not (equal ?COMP1 ?COMP2)) (part ?COMP1 ?MACHINE) (part ?COMP2 ?MACHINE))))").
:- assert_kif("(subrelation engineeringSubcomponent properPart)").
:- assert_kif("(domain engineeringSubcomponent 1 EngineeringComponent)").
:- assert_kif("(domain engineeringSubcomponent 2 EngineeringComponent)").
:- assert_kif("(documentation engineeringSubcomponent EnglishLanguage \"(&%engineeringSubcomponent ?SUB ?SUPER) means that the &%EngineeringComponent ?SUB is structurally a &%properPart of ?SUPER. This relation is an &%AsymmetricRelation, since two &%EngineeringComponents cannot be subcomponents of each other.\")").
:- assert_kif("(instance connectedEngineeringComponents SymmetricRelation)").
:- assert_kif("(instance connectedEngineeringComponents IrreflexiveRelation)").
:- assert_kif("(subrelation connectedEngineeringComponents connected)").
:- assert_kif("(domain connectedEngineeringComponents 1 EngineeringComponent)").
:- assert_kif("(domain connectedEngineeringComponents 2 EngineeringComponent)").
:- assert_kif("(documentation connectedEngineeringComponents EnglishLanguage \"This is the most general connection relation between &%EngineeringComponents. If"). (&%connectedEngineeringComponents ?COMP1 ?COMP2), then neither ?COMP1 nor ?COMP2 can be an &%engineeringSubcomponent of the other. The relation &%connectedEngineeringComponents is a &%SymmetricRelation, there is no information in the direction of connection between two components. It is also an &%IrreflexiveRelation, no &%EngineeringComponent bears this relation to itself. Note that this relation does not associate a name or type with the connection.\")").
:- assert_kif("(=> (connectedEngineeringComponents ?COMP1 ?COMP2) (and (not (engineeringSubcomponent ?COMP1 ?COMP2)) (not (engineeringSubcomponent ?COMP2 ?COMP1))))").
:- assert_kif("(subclass EngineeringConnection EngineeringComponent)").
:- assert_kif("(documentation EngineeringConnection EnglishLanguage \"An &%EngineeringConnection is an &%EngineeringComponent that represents a connection relationship between two other &%EngineeringComponents. It is a reification of the &%Predicate &%connectedEngineeringComponents. That means that whenever this &%Predicate holds between two &%EngineeringComponents, there exists an &%EngineeringConnection. The practical reason for reifying a relationship is to be able to attach other information about it. For example, one might want to say that a particular connection is associated with some shared parameters, or that it is of a particular type. &%EngineeringConnections are &%EngineeringComponents and can therefore be an &%engineeringSubcomponent of other &%EngineeringComponents. However, to provide for modular regularity in component systems, &%EngineeringConnections cannot be connected. For each pair of &%EngineeringComponents related by &%connectedEngineeringComponents, there exists at least one &%EngineeringConnection. However, that object may not be unique, and the same &%EngineeringConnection may be associated with several pairs of &%EngineeringComponents.\")").
:- assert_kif("(=> (instance ?CONNECTION EngineeringConnection) (exists (?COMP1 ?COMP2) (connectsEngineeringComponents ?CONNECTION ?COMP1 ?COMP2)))").
:- assert_kif("(=> (connectedEngineeringComponents ?COMP1 ?COMP2) (not (or (instance ?COMP1 EngineeringConnection) (instance ?COMP2 EngineeringConnection))))").
:- assert_kif("(<=> (connectedEngineeringComponents ?COMP1 ?COMP2) (exists (?CONNECTION) (connectsEngineeringComponents ?CONNECTION ?COMP1 ?COMP2)))").
:- assert_kif("(subrelation connectsEngineeringComponents connects)").
:- assert_kif("(domain connectsEngineeringComponents 1 EngineeringConnection)").
:- assert_kif("(domain connectsEngineeringComponents 2 EngineeringComponent)").
:- assert_kif("(domain connectsEngineeringComponents 3 EngineeringComponent)").
:- assert_kif("(documentation connectsEngineeringComponents EnglishLanguage \"&%connectsEngineeringComponents is a &%TernaryPredicate that maps from an &%EngineeringConnection to the &%EngineeringComponents it connects. Since &%EngineeringComponents cannot be connected to themselves and there cannot be an &%EngineeringConnection without a &%connectedEngineeringComponents &%Predicate, the second and third arguments of any &%connectsEngineeringComponents relationship will always be distinct for any given first argument.\")").
% :- assert_kif("; This following part contains definitions and axioms relating to social groups and the relations between them.").
:- assert_kif("(subclass CommercialAgent Agent)").
:- assert_kif("(documentation CommercialAgent EnglishLanguage \"An &%Agent that provides products and/or services for a fee with the aim of making a profit.\")").
% :- assert_kif("; KJN: Moved from Media.kif").
:- assert_kif("(subclass Business CommercialAgent)").
:- assert_kif("(subclass Business Organization)").
:- assert_kif("(documentation Business EnglishLanguage \"An &%instance of &%Business is an &%Organization that is a &%CommercialAgent.\")").
% :- assert_kif("; KJN: Removing this and putting in definition of Corporation that subclasses it from Business (subclass Corporation CommercialAgent) (subclass Corporation Organization)").
:- assert_kif("(subclass Corporation Business) NS: add.").
:- assert_kif("(subclass Corporation LegalAgent)").
:- assert_kif("(documentation Corporation EnglishLanguage \"An &%Organization that has a special legal status that allows a group of persons to act as a &%CommercialAgent and that insulates the owners (shareholders) from many liabilities that might result from the corporation's operation.\")").
:- assert_kif("(subclass Manufacturer Corporation)").
:- assert_kif("(documentation Manufacturer EnglishLanguage \"Any &%Corporation which manufactures &%Products.\")").
:- assert_kif("(=> (instance ?ORG Manufacturer) (hasPurpose ?ORG (exists (?MANUFACTURE) (and (instance ?MANUFACTURE Manufacture) (instance ?MANUFACTURE CommercialService) (agent ?MANUFACTURE ?ORG)))))").
:- assert_kif("(subclass MercantileOrganization Corporation)").
:- assert_kif("(documentation MercantileOrganization EnglishLanguage \"Any &%Corporation which sells goods or services to customers for a profit.\")").
:- assert_kif("(=> (instance ?ORG MercantileOrganization) (hasPurpose ?ORG (exists (?SELL) (and (instance ?SELL Selling) (instance ?SELL CommercialService) (agent ?SELL ?ORG)))))").
:- assert_kif("(subclass Group Collection)").
:- assert_kif("(subclass Group Agent)").
:- assert_kif("(documentation Group EnglishLanguage \"A &%Collection of &%Agents, e.g. a flock of sheep, a herd of goats, or the local Boy Scout troop.\")").
:- assert_kif("(=> (and (instance ?GROUP Group) (member ?MEMB ?GROUP)) (instance ?MEMB Agent))").
:- assert_kif("(subclass GroupOfPeople Group)").
:- assert_kif("(documentation GroupOfPeople EnglishLanguage \"Any &%Group whose &%members are exclusively &%Humans.\")").
:- assert_kif("(=> (and (instance ?GROUP GroupOfPeople) (member ?MEMBER ?GROUP)) (instance ?MEMBER Human))").
:- assert_kif("(subclass AgeGroup GroupOfPeople)").
:- assert_kif("(documentation AgeGroup EnglishLanguage \"A &%GroupOfPeople whose &%members all have the same &%age.\")").
:- assert_kif("(=> (instance ?GROUP AgeGroup) (forall (?MEMB1 ?MEMB2 ?AGE1 ?AGE2) (=> (and (member ?MEMB1 ?GROUP) (member ?MEMB2 ?GROUP) (age ?MEMB1 ?AGE1) (age ?MEMB2 ?AGE2)) (equal ?AGE1 ?AGE2))))").
:- assert_kif("(subclass FamilyGroup GroupOfPeople)").
:- assert_kif("(documentation FamilyGroup EnglishLanguage \"A &%GroupOfPeople whose &%members bear &%familyRelations to one another.\")").
:- assert_kif("(=> (instance ?GROUP FamilyGroup) (forall (?MEMB1 ?MEMB2) (=> (and (member ?MEMB1 ?GROUP) (member ?MEMB2 ?GROUP)) (familyRelation ?MEMB1 ?MEMB2))))").
:- assert_kif("(subclass SocialUnit GroupOfPeople)").
:- assert_kif("(documentation SocialUnit EnglishLanguage \"A &%GroupOfPeople who all have the same &%home.\")").
:- assert_kif("(=> (instance ?UNIT SocialUnit) (exists (?HOME) (=> (member ?MEMBER ?UNIT) (home ?MEMBER ?HOME))))").
:- assert_kif("(instance ImmediateFamilyFn UnaryFunction)").
:- assert_kif("(domain ImmediateFamilyFn 1 Human)").
:- assert_kif("(range ImmediateFamilyFn FamilyGroup)").
:- assert_kif("(documentation ImmediateFamilyFn EnglishLanguage \"(&%ImmediateFamilyFn ?PERSON) denotes the immediate family of ?PERSON, i.e. the &%Group consisting of the &%parents of ?PERSON and anyone of whom ?PERSON is a &%parent.\")").
:- assert_kif("(=> (equal (ImmediateFamilyFn ?P) ?FAMILY) (forall (?MEMBER) (=> (member ?MEMBER ?FAMILY) (exists (?OTHER) (or (parent ?MEMBER ?OTHER) (parent ?OTHER ?MEMBER))))))").
:- assert_kif("(=> (equal (ImmediateFamilyFn ?PERSON) ?FAMILY) (exists (?MEMBER) (and (member ?MEMBER ?FAMILY) (or (parent ?MEMBER ?PERSON) (parent ?PERSON ?MEMBER)))))").
:- assert_kif("(instance relative BinaryPredicate)").
:- assert_kif("(instance relative SymmetricRelation)").
:- assert_kif("(domain relative 1 Organism)").
:- assert_kif("(domain relative 2 Organism)").
:- assert_kif("(documentation relative EnglishLanguage \"(&%relative ?O1 ?O2) means that ?O1 and ?O2 are relatives, whether through common ancestry (consanguinity), someone's marriage (affinity), or someone's adoption. This definition is intentionally broad, so as to capture a wide array of `familial' relations. The notion of who counts as `family' also varies between cultures, but that aspect of meaning is not addressed here.\")").
:- assert_kif("(subrelation familyRelation relative)").
:- assert_kif("(subrelation spouse relative)").
:- assert_kif("(=> (and (holdsDuring ?T1 (legalRelation ?A1 ?A2)) (instance ?A1 Organism) (instance ?A2 Organism)) (holdsDuring ?T1 (relative ?A1 ?A2)))").
:- assert_kif("(instance familyRelation BinaryPredicate)").
:- assert_kif("(instance familyRelation EquivalenceRelation)").
:- assert_kif("(domain familyRelation 1 Organism)").
:- assert_kif("(domain familyRelation 2 Organism)").
:- assert_kif("(documentation familyRelation EnglishLanguage \"A very general &%Predicate for biological relationships. (&%familyRelation ?ORGANISM1 ?ORGANISM2) means that ?ORGANISM1 and ?ORGANISM2 are biologically derived from a common ancestor.\")").
:- assert_kif("(=> (familyRelation ?ORGANISM1 ?ORGANISM2) (exists (?ORGANISM3) (and (ancestor ?ORGANISM3 ?ORGANISM1) (ancestor ?ORGANISM3 ?ORGANISM2))))").
:- assert_kif("(subrelation ancestor familyRelation)").
:- assert_kif("(instance ancestor TransitiveRelation)").
:- assert_kif("(instance ancestor IrreflexiveRelation)").
:- assert_kif("(domain ancestor 1 Organism)").
:- assert_kif("(domain ancestor 2 Organism)").
:- assert_kif("(documentation ancestor EnglishLanguage \"The transitive closure of the &%parent predicate.  (&%ancestor ?DESCENDANT ?ANCESTOR) means that ?ANCESTOR is either the &%parent of ?DESCENDANT or the &%parent of the &%parent of &%DESCENDANT or etc.\")").
:- assert_kif("(subrelation parent ancestor)").
:- assert_kif("(instance parent BinaryPredicate)").
:- assert_kif("(subrelation parent familyRelation)").
:- assert_kif("(instance parent AsymmetricRelation)").
:- assert_kif("(instance parent IntransitiveRelation)").
:- assert_kif("(domain parent 1 Organism)").
:- assert_kif("(domain parent 2 Organism)").
:- assert_kif("(documentation parent EnglishLanguage \"The general relationship of parenthood.  (&%parent ?CHILD ?PARENT) means that ?PARENT is a biological parent of ?CHILD.\")").
:- assert_kif("(=> (parent ?CHILD ?PARENT) (before (BeginFn (WhenFn ?PARENT)) (BeginFn (WhenFn ?CHILD))))").
:- assert_kif("(=> (and (parent ?CHILD ?PARENT) (subclass ?CLASS Organism) (instance ?PARENT ?CLASS)) (instance ?CHILD ?CLASS))").
:- assert_kif("(=> (and (parent ?CHILD ?PARENT) (instance ?REP SexualReproduction) (agent ?REP ?PARENT) (result ?REP ?CHILD)) (or (mother ?CHILD ?PARENT) (father ?CHILD ?PARENT)))").
:- assert_kif("(=> (instance ?ORGANISM Organism) (exists (?PARENT) (parent ?ORGANISM ?PARENT)))").
:- assert_kif("(instance mother SingleValuedRelation)").
:- assert_kif("(subrelation mother parent)").
:- assert_kif("(domain mother 1 Organism)").
:- assert_kif("(domain mother 2 Organism)").
:- assert_kif("(documentation mother EnglishLanguage \"The general relationship of motherhood.  (&%mother ?CHILD ?MOTHER) means that ?MOTHER is the biological mother of ?CHILD.\")").
:- assert_kif("(=> (mother ?CHILD ?MOTHER) (attribute ?MOTHER Female))").
:- assert_kif("(instance father SingleValuedRelation)").
:- assert_kif("(subrelation father parent)").
:- assert_kif("(domain father 1 Organism)").
:- assert_kif("(domain father 2 Organism)").
:- assert_kif("(documentation father EnglishLanguage \"The general relationship of fatherhood.  (&%father ?CHILD ?FATHER) means that ?FATHER is the biological father of ?CHILD.\")").
:- assert_kif("(=> (father ?CHILD ?FATHER) (attribute ?FATHER Male))").
:- assert_kif("(subrelation daughter parent)").
:- assert_kif("(domain daughter 1 Organism)").
:- assert_kif("(domain daughter 2 Organism)").
:- assert_kif("(documentation daughter EnglishLanguage \"The general relationship of daughterhood.  (&%daughter ?CHILD ?PARENT) means that ?CHILD is the biological daughter of ?PARENT.\")").
:- assert_kif("(=> (daughter ?CHILD ?PARENT) (attribute ?CHILD Female))").
:- assert_kif("(subrelation son parent)").
:- assert_kif("(domain son 1 Organism)").
:- assert_kif("(domain son 2 Organism)").
:- assert_kif("(documentation son EnglishLanguage \"The general relationship of being a son.  (&%son ?CHILD ?PARENT) means that ?CHILD is the biological son of ?PARENT.\")").
:- assert_kif("(=> (son ?CHILD ?PARENT) (attribute ?CHILD Male))").
:- assert_kif("(instance sibling BinaryPredicate)").
:- assert_kif("(subrelation sibling familyRelation)").
:- assert_kif("(instance sibling SymmetricRelation)").
:- assert_kif("(instance sibling IrreflexiveRelation)").
:- assert_kif("(domain sibling 1 Organism)").
:- assert_kif("(domain sibling 2 Organism)").
:- assert_kif("(documentation sibling EnglishLanguage \"The relationship between two &%Organisms that have the same &%mother and &%father. Note that this relationship does not hold between half-brothers, half-sisters, etc.\")").
:- assert_kif("(=> (and (parent ?ORGANISM1 ?PARENT1) (parent ?ORGANISM2 ?PARENT1) (parent ?ORGANISM1 ?PARENT2) (parent ?ORGANISM2 ?PARENT2) (not (equal ?ORGANISM1 ?ORGANISM2)) (not (equal ?PARENT1 ?PARENT2))) (sibling ?ORGANISM1 ?ORGANISM2))").
:- assert_kif("(=> (and (sibling ?ORG1 ?ORG2) (parent ?ORG1 ?PARENT)) (parent ?ORG2 ?PARENT))").
:- assert_kif("(=> (and (parent ?CHILD ?PARENT) (attribute ?PARENT Male)) (father ?CHILD ?PARENT))").
:- assert_kif("(=> (and (parent ?CHILD ?PARENT) (attribute ?PARENT Female)) (mother ?CHILD ?PARENT))").
:- assert_kif("(subrelation brother sibling)").
:- assert_kif("(instance brother IrreflexiveRelation)").
:- assert_kif("(instance brother TransitiveRelation)").
:- assert_kif("(domain brother 1 Man)").
:- assert_kif("(domain brother 2 Human)").
:- assert_kif("(documentation brother EnglishLanguage \"The general relationship of being a brother.  (&%brother ?MAN ?PERSON) means that ?MAN is the brother of ?PERSON.\")").
:- assert_kif("(subrelation sister sibling)").
:- assert_kif("(instance sister IrreflexiveRelation)").
:- assert_kif("(instance sister TransitiveRelation)").
:- assert_kif("(domain sister 1 Woman)").
:- assert_kif("(domain sister 2 Human)").
:- assert_kif("(documentation sister EnglishLanguage \"The general relationship of being a sister.  (&%sister ?WOMAN ?PERSON) means that ?WOMAN is the sister of ?PERSON.\")").
:- assert_kif("(instance legalRelation BinaryPredicate)").
:- assert_kif("(instance legalRelation SymmetricRelation)").
:- assert_kif("(domain legalRelation 1 Human)").
:- assert_kif("(domain legalRelation 2 Human)").
:- assert_kif("(documentation legalRelation EnglishLanguage \"(&%legalRelation ?AGENT1 ?AGENT2) means that ?AGENT1 and ?AGENT2 are relatives by virtue of a legal relationship. Some examples include marriage, adoption, etc.\")").
:- assert_kif("(=> (legalRelation ?AGENT1 ?AGENT2) (exists (?DECLARE ?OBLIGATION) (and (instance ?DECLARE Declaring) (confersObligation ?OBLIGATION ?DECLARE ?AGENT1) (confersObligation ?OBLIGATION ?DECLARE ?AGENT2))))").
:- assert_kif("(instance acquaintance BinaryPredicate)").
:- assert_kif("(documentation acquaintance EnglishLanguage \"(&%acquaintance ?H1 ?H2) means that ?H1 has met and knows something about ?H2, such as ?H2's name and appearance. Statements made with this predicate should be temporally specified with &%holdsDuring. Note that &%acquaintance is not symmetric. For the symmetric version, see &%mutualAcquaintance.\")").
:- assert_kif("(domain acquaintance 1 Human)").
:- assert_kif("(domain acquaintance 2 Human)").
:- assert_kif("(instance mutualAcquaintance BinaryPredicate)").
:- assert_kif("(instance mutualAcquaintance SymmetricRelation)").
:- assert_kif("(documentation mutualAcquaintance EnglishLanguage \"(&%mutualAcquaintance ?H1 ?H2) means that ?H1 and ?H2 have met each other and know something about each other, such as name and appearance. Statements made with this predicate should be temporally specified with &%holdsDuring. See also the weaker, non-symmetric version of this predicate, &%acquaintance.\")").
:- assert_kif("(domain mutualAcquaintance 1 Human)").
:- assert_kif("(domain mutualAcquaintance 2 Human)").
:- assert_kif("(subrelation mutualAcquaintance acquaintance)").
:- assert_kif("(subrelation spouse mutualAcquaintance)").
:- assert_kif("(subrelation spouse legalRelation)").
:- assert_kif("(instance spouse IrreflexiveRelation)").
:- assert_kif("(instance spouse SymmetricRelation)").
:- assert_kif("(domain spouse 1 Human)").
:- assert_kif("(domain spouse 2 Human)").
:- assert_kif("(documentation spouse EnglishLanguage \"The relationship of marriage between two &%Humans.\")").
:- assert_kif("(subrelation husband spouse)").
:- assert_kif("(instance husband AsymmetricRelation)").
:- assert_kif("(instance husband IrreflexiveRelation)").
:- assert_kif("(domain husband 1 Man)").
:- assert_kif("(domain husband 2 Woman)").
:- assert_kif("(inverse husband wife)").
:- assert_kif("(documentation husband EnglishLanguage \"(&%husband ?MAN ?WOMAN) means that ?MAN is the husband of ?WOMAN.\")").
:- assert_kif("(subrelation wife spouse)").
:- assert_kif("(instance wife AsymmetricRelation)").
:- assert_kif("(instance wife IrreflexiveRelation)").
:- assert_kif("(domain wife 1 Woman)").
:- assert_kif("(domain wife 2 Man)").
:- assert_kif("(documentation wife EnglishLanguage \"(&%wife ?WOMAN ?MAN) means that ?WOMAN is the wife of ?MAN.\")").
:- assert_kif("(subclass EthnicGroup GroupOfPeople)").
:- assert_kif("(documentation EthnicGroup EnglishLanguage \"A &%GroupOfPeople whose &%members originate from the same &%GeographicArea or share the same &%Language and/or cultural practices.\")").
:- assert_kif("(subclass BeliefGroup GroupOfPeople)").
:- assert_kif("(documentation BeliefGroup EnglishLanguage \"A &%GroupOfPeople whose &%members share a belief or set of beliefs.\")").
:- assert_kif("(=> (instance ?GROUP BeliefGroup) (exists (?BELIEF) (forall (?MEMB) (=> (member ?MEMB ?GROUP) (believes ?MEMB ?BELIEF)))))").
:- assert_kif("(subclass Organization Group)").
% :- assert_kif("; NS: delete. (subclass Organization CognitiveAgent)").
% :- assert_kif("; NS: add.").
:- assert_kif("(subclass Organization Agent)").
:- assert_kif("(documentation Organization EnglishLanguage \"An &%Organization is a corporate or similar institution. The &%members of an &%Organization typically have a common purpose or function. Note that this class also covers divisions, departments, etc. of organizations. For example, both the Shell Corporation and the accounting department at Shell would both be instances of &%Organization. Note too that the existence of an &%Organization is dependent on the existence of at least one &%member (since &%Organization is a subclass of &%Collection). Accordingly, in cases of purely legal organizations, a fictitious &%member should be assumed.\")").
:- assert_kif("(=> (instance ?ORG Organization) (exists (?PURP) (forall (?MEMBER) (=> (member ?MEMBER ?ORG) (hasPurpose ?MEMBER ?PURP)))))").
:- assert_kif("(=> (and (instance ?ORG Organization) (member ?AGENT ?ORG)) (instance ?AGENT Agent))").
:- assert_kif("(instance employs BinaryPredicate)").
:- assert_kif("(domain employs 1 Organization)").
:- assert_kif("(domain employs 2 CognitiveAgent)").
:- assert_kif("(documentation employs EnglishLanguage \"(&%employs ?ORG ?PERSON) means that ?ORG has hired ?PERSON and currently retains ?PERSON, on a salaried, hourly or contractual basis, to provide services in exchange for monetary compensation.\")").
:- assert_kif("(subclass PoliticalOrganization Organization)").
:- assert_kif("(documentation PoliticalOrganization EnglishLanguage \"An &%Organization that is attempting to bring about some sort of political change.\")").
:- assert_kif("(=> (instance ?POL PoliticalOrganization) (exists (?PROC) (and (instance ?PROC PoliticalProcess) (agent ?PROC ?POL))))").
:- assert_kif("(subclass MilitaryForce PoliticalOrganization)").
:- assert_kif("(documentation MilitaryForce EnglishLanguage \"&%MilitaryForce is the subclass of &%Organizations that are organized along military lines and for the purpose of either defensive or offensive combat, whether or not the force is an official &%GovernmentOrganization.\")").
:- assert_kif("(=> (instance ?ORG MilitaryForce) (capability ViolentContest agent ?ORG))").
:- assert_kif("(subclass MilitaryOrganization MilitaryForce)").
:- assert_kif("(subclass MilitaryOrganization GovernmentOrganization)").
:- assert_kif("(documentation MilitaryOrganization EnglishLanguage \"Any heavily armed &%Organization that is part of a &%Government and that is charged with representing the &%Government in international conflicts.\")").
:- assert_kif("(subclass ParamilitaryOrganization MilitaryForce)").
:- assert_kif("(disjoint ParamilitaryOrganization GovernmentOrganization)").
:- assert_kif("(documentation ParamilitaryOrganization EnglishLanguage \"An &%Organization which is much like a &%MilitaryOrganization, e.g. it is made up of armed fighters, except that it is not associated with a &%Government.\")").
:- assert_kif("(subclass GovernmentOrganization Organization)").
:- assert_kif("(documentation GovernmentOrganization EnglishLanguage \"&%GovernmentOrganization is the class of official &%Organizations that are concerned with the government of a &%GeopoliticalArea at some level. They may be a &%subOrganization of a government.\")").
:- assert_kif("(<=> (instance ?ORG GovernmentOrganization) (exists (?GOV) (and (instance ?GOV Government) (subOrganization ?ORG ?GOV))))").
:- assert_kif("(=> (and (subOrganization ?ORG ?GOV) (instance ?GOV GovernmentOrganization)) (instance ?ORG GovernmentOrganization))").
:- assert_kif("(subclass Government GovernmentOrganization)").
% :- assert_kif("; NS: add.").
:- assert_kif("(subclass Government LegalAgent)").
:- assert_kif("(documentation Government EnglishLanguage \"The ruling body of a &%GeopoliticalArea.\")").
:- assert_kif("(instance GovernmentFn UnaryFunction)").
:- assert_kif("(domain GovernmentFn 1 GeopoliticalArea)").
:- assert_kif("(range GovernmentFn Government)").
:- assert_kif("(documentation GovernmentFn EnglishLanguage \"(&%GovernmentFn ?AREA) denotes the &%Government of the &%GeopoliticalArea ?AREA. For example,"). (&%GovernmentFn &%UnitedStates) denotes the Federal-level government of the United States, (&%GovernmentFn &%PuertoRico) denotes the government of the Commonwealth of Puerto Rico.\")").
:- assert_kif("(subclass PoliceOrganization GovernmentOrganization)").
:- assert_kif("(documentation PoliceOrganization EnglishLanguage \"Any &%GovernmentOrganization that is charged with domestic enforcement of the laws of the &%Government.\")").
:- assert_kif("(subclass JudicialOrganization Organization)").
:- assert_kif("(documentation JudicialOrganization EnglishLanguage \"&%JudicialOrganization is the class of &%Organizations whose primary purpose is to render judgments according to the statutes or regulations of a government or other organization. Judicial bodies are not necessarily government organizations, for example, those associated with sporting associations.\")").
:- assert_kif("(subclass EducationalOrganization Organization)").
:- assert_kif("(documentation EducationalOrganization EnglishLanguage \"A &%EducationalOrganization is an institution of learning. Some examples are public and private K-12 schools, and colleges and universities.\")").
:- assert_kif("(subclass ReligiousOrganization Organization)").
:- assert_kif("(subclass ReligiousOrganization BeliefGroup)").
:- assert_kif("(documentation ReligiousOrganization EnglishLanguage \"An &%Organization whose members share a set of religious beliefs.\")").
:- assert_kif("(subrelation subOrganization subCollection)").
:- assert_kif("(instance subOrganization PartialOrderingRelation)").
:- assert_kif("(domain subOrganization 1 Organization)").
:- assert_kif("(domain subOrganization 2 Organization)").
:- assert_kif("(documentation subOrganization EnglishLanguage \"(&%subOrganization ?ORG1 ?ORG2) means that ?ORG1 is an &%Organization which is a part of the &%Organization ?ORG2. Note that &%subOrganization is a &%ReflexiveRelation, so every &%Organization is a &%subOrganization of itself.\")").
:- assert_kif("(instance citizen BinaryPredicate)").
:- assert_kif("(instance citizen AsymmetricRelation)").
:- assert_kif("(domain citizen 1 Human)").
:- assert_kif("(domain citizen 2 Nation)").
:- assert_kif("(documentation citizen EnglishLanguage \"(&%citizen ?PERSON ?NATION) means that the &%Human ?PERSON is a citizen of &%Nation ?NATION.\")").
% :- assert_kif("; END FILE").
% :- assert_kif("; BEGIN FILE").
% :- assert_kif(";  QUALITIES  ").
% :- assert_kif("; INCLUDES 'MEREOTOPOLOGY' INCLUDES 'PROCESSES' INCLUDES 'OBJECTS'").
:- assert_kif("(subclass FieldOfStudy Proposition)").
:- assert_kif("(documentation FieldOfStudy EnglishLanguage \"An academic or applied discipline with recognized experts and with a core of accepted theory or practice. Note that &%FieldOfStudy is a &%subclass of &%Proposition, because a &%FieldOfStudy is understood to be a body of abstract, informational content, with varying degrees of certainty attached to each element of this content.\")").
:- assert_kif("(subclass Procedure Proposition)").
:- assert_kif("(documentation Procedure EnglishLanguage \"A sequence-dependent specification. Some examples are &%ComputerPrograms, finite-state machines, cooking recipes, musical scores, conference schedules, driving directions, and the scripts of plays and movies.\")").
:- assert_kif("(subclass ComputerProgram Procedure)").
:- assert_kif("(documentation ComputerProgram EnglishLanguage \"A set of instructions in a computer programming language that can be executed by a computer.\")").
:- assert_kif("(subclass ComputerProgramming ContentDevelopment)").
:- assert_kif("(documentation ComputerProgramming EnglishLanguage \"The process of developing a &%ComputerProgram\")").
:- assert_kif("(=> (instance ?CP ComputerProgramming) (exists (?C) (and (instance ?C ComputerProgram) (result ?CP ?C))))").
:- assert_kif("(subclass Plan Procedure)").
:- assert_kif("(documentation Plan EnglishLanguage \"A specification of a sequence of &%Processes which is intended to satisfy a specified purpose at some future time.\")").
:- assert_kif("(=> (and (instance ?PLAN Plan) (instance ?OBJ ContentBearingObject) (containsInformation ?OBJ ?PLAN)) (exists (?PLANNING) (and (instance ?PLANNING Planning) (result ?PLANNING ?OBJ))))").
:- assert_kif("(subclass Argument Proposition)").
:- assert_kif("(partition Argument DeductiveArgument InductiveArgument)").
:- assert_kif("(documentation Argument EnglishLanguage \"Any proposition which has the form of a deductive or inductive argument, i.e. a set of premises which, it is claimed, imply a conclusion.\")").
:- assert_kif("(=> (instance ?REASON Reasoning) (exists (?ARGUMENT) (and (instance ?ARGUMENT Argument) (realization ?REASON ?ARGUMENT))))").
:- assert_kif("(=> (instance ?ARGUMENT Argument) (exists (?PREMISES ?CONCLUSION) (and (equal (PremisesFn ?ARGUMENT) ?PREMISES) (conclusion ?CONCLUSION ?ARGUMENT))))").
:- assert_kif("(subclass DeductiveArgument Argument)").
:- assert_kif("(partition DeductiveArgument ValidDeductiveArgument InvalidDeductiveArgument)").
:- assert_kif("(documentation DeductiveArgument EnglishLanguage \"An &%Argument which has the form of a deduction, i.e. it is claimed that the set of &%premises &%entails the &%conclusion.\")").
:- assert_kif("(subclass ValidDeductiveArgument DeductiveArgument)").
:- assert_kif("(documentation ValidDeductiveArgument EnglishLanguage \"A &%DeductiveArgument which is valid, i.e. the set of &%premises in fact &%entails the &%conclusion.\")").
:- assert_kif("(=> (and (instance ?ARGUMENT ValidDeductiveArgument) (equal ?PREMISES (PremisesFn ?ARGUMENT)) (conclusion ?CONCLUSION ?ARGUMENT)) (exists (?FORMULA1 ?FORMULA2) (and (containsInformation ?FORMULA1 ?PREMISES) (containsInformation ?FORMULA2 ?CONCLUSION) (entails ?PREMISES ?CONCLUSION))))").
:- assert_kif("(subclass InvalidDeductiveArgument DeductiveArgument)").
:- assert_kif("(documentation InvalidDeductiveArgument EnglishLanguage \"&%DeductiveArguments that are not &%ValidDeductiveArguments, i.e. it is not the case that the set of &%premises in fact &%entails the &%conclusion.\")").
:- assert_kif("(subclass Explanation DeductiveArgument)").
:- assert_kif("(documentation Explanation EnglishLanguage \"An &%Argument where the conclusion is an observed fact and the premises are other facts which collectively imply the conclusion. Note that this is the they hypothetico-deductive model of explanation.\")").
:- assert_kif("(subclass InductiveArgument Argument)").
:- assert_kif("(documentation InductiveArgument EnglishLanguage \"An &%Argument which is inductive, i.e. it is claimed that a set of specific cases makes the &%conclusion, which generalizes these cases, more likely to be true.\")").
:- assert_kif("(instance premise BinaryPredicate)").
:- assert_kif("(instance premise TotalValuedRelation)").
:- assert_kif("(domain premise 1 Argument)").
:- assert_kif("(domain premise 2 Proposition)").
:- assert_kif("(documentation premise EnglishLanguage \"(&%premise ?ARGUMENT ?PROPOSITION) means that the &%Proposition ?PROPOSITION is an explicit assumption of the &%Argument ?ARGUMENT.\")").
:- assert_kif("(instance PremisesFn UnaryFunction)").
:- assert_kif("(domain PremisesFn 1 Argument)").
:- assert_kif("(range PremisesFn Proposition)").
:- assert_kif("(documentation PremisesFn EnglishLanguage \"(&%PremisesFn ?ARGUMENT) returns the complete set of &%premises of the &%Argument ?ARGUMENT.\")").
:- assert_kif("(=> (and (instance ?ARGUMENT Argument) (equal ?PREMISES (PremisesFn ?ARGUMENT))) (<=> (subProposition ?PROPOSITION ?PREMISES) (premise ?ARGUMENT ?PROPOSITION)))").
:- assert_kif("(instance conclusion BinaryPredicate)").
:- assert_kif("(instance conclusion SingleValuedRelation)").
:- assert_kif("(instance conclusion TotalValuedRelation)").
:- assert_kif("(domain conclusion 1 Argument)").
:- assert_kif("(domain conclusion 2 Proposition)").
:- assert_kif("(documentation conclusion EnglishLanguage \"(&%conclusion ?ARGUMENT ?PROPOSITION) means that the &%Proposition ?PROPOSITION is the conclusion explicitly drawn from the &%Argument ?ARGUMENT. Note that it may or may not be the case that ?ARGUMENT &%entails ?PROPOSITION.\")").
:- assert_kif("(instance consistent BinaryPredicate)").
:- assert_kif("(instance consistent SymmetricRelation)").
:- assert_kif("(domain consistent 1 Proposition)").
:- assert_kif("(domain consistent 2 Proposition)").
:- assert_kif("(documentation consistent EnglishLanguage \"(&%consistent ?PROP1 ?PROP2) means that the two &%Propositions ?PROP1 and ?PROP2 are consistent with one another, i.e. it is possible for both of them to be true at the same time.\")").
:- assert_kif("(instance orientation SpatialRelation)").
:- assert_kif("(instance orientation TernaryPredicate)").
:- assert_kif("(domain orientation 1 Object)").
:- assert_kif("(domain orientation 2 Object)").
:- assert_kif("(domain orientation 3 PositionalAttribute)").
:- assert_kif("(documentation orientation EnglishLanguage \"A general &%Predicate for indicating how two &%Objects are oriented with respect to one another. For example,").
:- assert_kif("(orientation ?OBJ1 ?OBJ2 North) means that ?OBJ1 is north of ?OBJ2, and").
:- assert_kif("(orientation ?OBJ1 ?OBJ2 Vertical) means that ?OBJ1 is positioned vertically with respect to ?OBJ2.\")").
:- assert_kif("(=> (and (orientation ?OBJ1 ?OBJ2 ?ATTR1) (contraryAttribute @ROW) (inList ?ATTR1 (ListFn @ROW)) (inList ?ATTR2 (ListFn @ROW)) (not (equal ?ATTR1 ?ATTR2))) (not (orientation ?OBJ1 ?OBJ2 ?ATTR2)))").
:- assert_kif("(instance direction CaseRole)").
:- assert_kif("(domain direction 1 Process)").
:- assert_kif("(domain direction 2 PositionalAttribute)").
:- assert_kif("(subrelation direction involvedInEvent)").
:- assert_kif("(documentation direction EnglishLanguage \"(&%direction ?PROC ?ATTR) means that the &%Process ?PROC is moving in the direction ?ATTR. For example, one would use this &%Predicate to represent the fact that Max is moving &%North.\")").
:- assert_kif("(=> (holdsDuring ?TIME (direction ?PROC ?ATTR1)) (forall (?ATTR2) (=> (holdsDuring ?TIME (direction ?PROC ?ATTR2)) (equal ?ATTR2 ?ATTR1))))").
:- assert_kif("(instance faces BinaryPredicate)").
:- assert_kif("(domain faces 1 Object)").
:- assert_kif("(domain faces 2 DirectionalAttribute)").
:- assert_kif("(documentation faces EnglishLanguage \"(&%faces ?OBJ ?DIRECTION) means that the front of ?OBJ (see &%FrontFn) is positioned towards the compass direction ?DIRECTION. More precisely, it means that if a line were extended from the center of ?DIRECTION, the line would intersect with the front of ?OBJ before it intersected with its back (see &%BackFn).\")").
:- assert_kif("(=> (holdsDuring ?TIME (faces ?PROC ?ATTR1)) (forall (?ATTR2) (=> (holdsDuring ?TIME (faces ?PROC ?ATTR2)) (equal ?ATTR2 ?ATTR1))))").
:- assert_kif("(subclass TruthValue RelationalAttribute)").
:- assert_kif("(documentation TruthValue EnglishLanguage \"The &%Class of truth values, e.g. &%True and &%False. These are &%Attributes of &%Sentences and &%Propositions.\")").
:- assert_kif("(=> (and (property ?ITEM ?VALUE) (instance ?VALUE TruthValue)) (or (instance ?ITEM Sentence) (instance ?ITEM Proposition)))").
:- assert_kif("(instance True TruthValue)").
:- assert_kif("(documentation True EnglishLanguage \"The &%TruthValue of being true.\")").
:- assert_kif("(instance False TruthValue)").
:- assert_kif("(contraryAttribute False True)").
:- assert_kif("(documentation False EnglishLanguage \"The &%TruthValue of being false.\")").
:- assert_kif("(subrelation truth property)").
:- assert_kif("(domain truth 1 Sentence)").
:- assert_kif("(domain truth 2 TruthValue)").
:- assert_kif("(documentation truth EnglishLanguage \"The &%BinaryPredicate that relates a &%Sentence to its &%TruthValue.\")").
:- assert_kif("(subclass PositionalAttribute RelationalAttribute)").
:- assert_kif("(documentation PositionalAttribute EnglishLanguage \"&%Attributes characterizing the orientation of an &%Object, e.g. &%Vertical versus &%Horizontal, &%Left versus &%Right etc.\")").
:- assert_kif("(subclass DirectionalAttribute PositionalAttribute)").
:- assert_kif("(documentation DirectionalAttribute EnglishLanguage \"The subclass of &%PositionalAttributes that concern compass directions.\")").
:- assert_kif("(=> (and (instance ?DIRECT DirectionalAttribute) (orientation ?OBJ1 ?OBJ2 ?DIRECT) (orientation ?OBJ2 ?OBJ3 ?DIRECT)) (between ?OBJ1 ?OBJ2 ?OBJ3))").
:- assert_kif("(instance North DirectionalAttribute)").
:- assert_kif("(contraryAttribute North South East West)").
:- assert_kif("(documentation North EnglishLanguage \"The compass direction of &%North.\")").
:- assert_kif("(instance South DirectionalAttribute)").
:- assert_kif("(documentation South EnglishLanguage \"The compass direction of &%South.\")").
:- assert_kif("(<=> (orientation ?OBJ1 ?OBJ2 North) (orientation ?OBJ2 ?OBJ1 South))").
:- assert_kif("(instance East DirectionalAttribute)").
:- assert_kif("(documentation East EnglishLanguage \"The compass direction of &%East.\")").
:- assert_kif("(instance West DirectionalAttribute)").
:- assert_kif("(documentation West EnglishLanguage \"The compass direction of &%West.\")").
:- assert_kif("(<=> (orientation ?OBJ1 ?OBJ2 East) (orientation ?OBJ2 ?OBJ1 West))").
:- assert_kif("(instance Vertical PositionalAttribute)").
:- assert_kif("(documentation Vertical EnglishLanguage \"Attribute used to indicate that an &%Object is positioned height-wise with respect to another &%Object.\")").
:- assert_kif("(<=> (orientation ?OBJ1 ?OBJ2 Vertical) (orientation ?OBJ2 ?OBJ1 Vertical))").
:- assert_kif("(instance Horizontal PositionalAttribute)").
:- assert_kif("(contraryAttribute Horizontal Vertical)").
:- assert_kif("(documentation Horizontal EnglishLanguage \"Attribute used to indicate that an &%Object is positioned width-wise with respect to another &%Object.\")").
:- assert_kif("(<=> (orientation ?OBJ1 ?OBJ2 Horizontal) (orientation ?OBJ2 ?OBJ1 Horizontal))").
:- assert_kif("(subclass SymmetricPositionalAttribute PositionalAttribute)").
:- assert_kif("(documentation SymmetricPositionalAttribute EnglishLanguage \"&%SymmetricAttribute is the class of &%PositionalAttribute that hold between two items regardless of their order or orientation.\")").
:- assert_kif("(=> (and (instance ?P SymmetricPositionalAttribute) (orientation ?O1 ?O2 ?P)) (orientation ?O2 ?O1 ?P))").
:- assert_kif("(subclass AntiSymmetricPositionalAttribute PositionalAttribute)").
:- assert_kif("(documentation AntiSymmetricPositionalAttribute EnglishLanguage \"&%AntiSymmetricPositionalAttribute is the class of &%PositionalAttribute that hold in only one direction. I.e. two objects cannot simulataneously be &%On each other.\")").
:- assert_kif("(=> (and (instance ?P AntiSymmetricPositionalAttribute) (orientation ?O1 ?O2 ?P)) (not (orientation ?O2 ?O1 ?P)))").
:- assert_kif("(instance Above PositionalAttribute)").
:- assert_kif("(instance Above AntiSymmetricPositionalAttribute)").
:- assert_kif("(contraryAttribute Above Below)").
:- assert_kif("(documentation Above EnglishLanguage \"This is a &%PositionalAttribute derived from the up/down schema and not involving contact. Note that this means directly above, i.e., if one object is &%Above another object, then the projections of the two objects overlap.\")").
:- assert_kif("(=> (orientation ?OBJ1 ?OBJ2 Above) (not (connected ?OBJ1 ?OBJ2)))").
:- assert_kif("(instance Below PositionalAttribute)").
:- assert_kif("(instance Below AntiSymmetricPositionalAttribute)").
:- assert_kif("(documentation Below EnglishLanguage \"This &%PositionalAttribute is derived from the up/down schema and may or may not involve contact. Note that this means directly below, i.e., if one object is &%Below another object, then the projections of the two objects overlap.\")").
:- assert_kif("(<=> (orientation ?OBJ1 ?OBJ2 Below) (or (orientation ?OBJ2 ?OBJ1 On) (orientation ?OBJ2 ?OBJ1 Above)))").
:- assert_kif("(instance Adjacent SymmetricPositionalAttribute)").
:- assert_kif("(documentation Adjacent EnglishLanguage \"Used to assert that an object ?OBJ1 is close to, near or abutting ?OBJ2. This &%PositionalAttribute covers the following common sense notions: adjoins, abuts, is contiguous to, is juxtaposed, and is close to.\")").
:- assert_kif("(<=> (orientation ?OBJ1 ?OBJ2 Adjacent) (or (orientation ?OBJ1 ?OBJ2 Near) (connected ?OBJ1 ?OBJ2)))").
:- assert_kif("(instance Left PositionalAttribute)").
:- assert_kif("(instance Left AntiSymmetricPositionalAttribute)").
:- assert_kif("(documentation Left EnglishLanguage \"This &%PositionalAttribute is derived from the left/right schema. Note that this means directly to the left, so that, if one object is to the left of another, then the projections of the two objects overlap.\")").
:- assert_kif("(instance Right PositionalAttribute)").
:- assert_kif("(instance Right AntiSymmetricPositionalAttribute)").
:- assert_kif("(contraryAttribute Right Left)").
:- assert_kif("(documentation Right EnglishLanguage \"This &%PositionalAttribute is derived from the left/right schema. Note that this means directly to the right, so that, if one object is to the right of another, then the projections of the two objects overlap.\")").
:- assert_kif("(<=> (orientation ?OBJ1 ?OBJ2 Right) (orientation ?OBJ2 ?OBJ1 Left))").
:- assert_kif("(instance Near SymmetricPositionalAttribute)").
:- assert_kif("(documentation Near EnglishLanguage \"The relation of common sense adjacency. Note that, if an object is &%Near another object, then the objects are not &%connected.\")").
:- assert_kif("(=> (orientation ?OBJ1 ?OBJ2 Near) (not (connected ?OBJ1 ?OBJ2)))").
:- assert_kif("(=> (orientation ?OBJ1 ?OBJ2 Near) (orientation ?OBJ2 ?OBJ1 Near))").
:- assert_kif("(instance On AntiSymmetricPositionalAttribute)").
:- assert_kif("(documentation On EnglishLanguage \"This is used to assert that an object is on top of another object, and it is derived from the up/down schema and involves contact.\")").
:- assert_kif("(=> (orientation ?OBJ1 ?OBJ2 On) (connected ?OBJ1 ?OBJ2))").
:- assert_kif("(=> (orientation ?OBJ1 ?OBJ2 On) (located ?OBJ1 ?OBJ2))").
:- assert_kif("(=> (orientation ?OBJ1 ?OBJ2 On) (not (orientation ?OBJ2 ?OBJ1 On)))").
:- assert_kif("(subclass TimeZone RelationalAttribute)").
:- assert_kif("(documentation TimeZone EnglishLanguage \"An &%Attribute which is used to specify coordinates in which time measures are uniform, i.e. all time devices are synchronized to the same &%TimePositions.\")").
:- assert_kif("(instance CoordinatedUniversalTimeZone TimeZone)").
:- assert_kif("(documentation CoordinatedUniversalTimeZone EnglishLanguage \"A &%TimeZone which functions as the standard time zone. It is also known as Zulu time (in the military), Greenwich Mean Time, and the Western European time zone. Note that whenever a &%TimeZone is not specified, the &%TimePosition is understood to be with respect to the &%CoordinatedUniversalTimeZone.\")").
:- assert_kif("(instance PacificTimeZone TimeZone)").
:- assert_kif("(documentation PacificTimeZone EnglishLanguage \"A &%TimeZone that covers much of the western part of the United States.\")").
:- assert_kif("(=> (equal (RelativeTimeFn ?TIME1 PacificTimeZone) ?TIME2) (equal ?TIME2 (AdditionFn ?TIME1 8)))").
:- assert_kif("(instance MountainTimeZone TimeZone)").
:- assert_kif("(documentation MountainTimeZone EnglishLanguage \"A &%TimeZone that covers much of the Rocky Mountain region of the United States.\")").
:- assert_kif("(=> (equal (RelativeTimeFn ?TIME1 MountainTimeZone) ?TIME2) (equal ?TIME2 (AdditionFn ?TIME1 7)))").
:- assert_kif("(instance CentralTimeZone TimeZone)").
:- assert_kif("(documentation CentralTimeZone EnglishLanguage \"A &%TimeZone that covers much of the midwestern United States.\")").
:- assert_kif("(=> (equal (RelativeTimeFn ?TIME1 CentralTimeZone) ?TIME2) (equal ?TIME2 (AdditionFn ?TIME1 6)))").
:- assert_kif("(instance EasternTimeZone TimeZone)").
:- assert_kif("(documentation EasternTimeZone EnglishLanguage \"A &%TimeZone that covers much of the eastern United States.\")").
:- assert_kif("(=> (equal (RelativeTimeFn ?TIME1 EasternTimeZone) ?TIME2) (equal ?TIME2 (AdditionFn ?TIME1 5)))").
:- assert_kif("(instance RelativeTimeFn BinaryFunction)").
:- assert_kif("(instance RelativeTimeFn TemporalRelation)").
:- assert_kif("(instance RelativeTimeFn TotalValuedRelation)").
:- assert_kif("(domain RelativeTimeFn 1 TimePosition)").
:- assert_kif("(domain RelativeTimeFn 2 TimeZone)").
:- assert_kif("(range RelativeTimeFn TimePosition)").
:- assert_kif("(documentation RelativeTimeFn EnglishLanguage \"A means of converting &%TimePositions between different &%TimeZones. (&%RelativeTimeFn ?TIME ?ZONE) denotes the &%TimePosition in &%CoordinatedUniversalTime that is contemporaneous with the &%TimePosition ?TIME in &%TimeZone ?ZONE. For example, (&%RelativeTimeFn (&%MeasureFn 14 &%HourDuration) &%EasternTimeZone) would return the value (&%MeasureFn 19 &%HourDuration).\")").
:- assert_kif("(subclass SocialRole RelationalAttribute)").
:- assert_kif("(documentation SocialRole EnglishLanguage \"The &%Class of all &%Attributes that specify the position or status of a &%CognitiveAgent within an &%Organization or other &%Group.\")").
:- assert_kif("(=> (and (attribute ?PERSON ?ATTRIBUTE) (instance ?ATTRIBUTE SocialRole)) (instance ?PERSON Human))").
:- assert_kif("(instance Unemployed SocialRole)").
:- assert_kif("(documentation Unemployed EnglishLanguage \"The &%Attribute of a &%CognitiveAgent when he/she is unemployed.\")").
:- assert_kif("(<=> (and (instance ?PERSON Human) (forall (?ORG) (not (employs ?ORG ?PERSON)))) (attribute ?PERSON Unemployed))").
:- assert_kif("(subclass Position SocialRole)").
:- assert_kif("(documentation Position EnglishLanguage \"A formal position of reponsibility within an &%Organization. Examples of &%Positions include president, laboratory director, senior researcher, sales representative, etc.\")").
:- assert_kif("(instance occupiesPosition TernaryPredicate)").
:- assert_kif("(domain occupiesPosition 1 Human)").
:- assert_kif("(domain occupiesPosition 2 Position)").
:- assert_kif("(domain occupiesPosition 3 Organization)").
:- assert_kif("(documentation occupiesPosition EnglishLanguage \"(&%occupiesPosition ?PERSON ?POSITION ?ORG) means that ?PERSON holds the &%Position ?POSITION at &%Organization ?ORG. For example, (&%occupiesPosition &%TomSmith &%ResearchDirector &%AcmeLaboratory) means that &%TomSmith is a research director at Acme Labs.\")").
:- assert_kif("(=> (occupiesPosition ?AGENT ?POSITION ?ORG) (attribute ?AGENT ?POSITION))").
:- assert_kif("(=> (employs ?ORG ?PERSON) (exists (?POSITION) (occupiesPosition ?PERSON ?POSITION ?ORG)))").
:- assert_kif("(=> (occupiesPosition ?PERSON ?POSITION ?ORGANIZATION) (member ?PERSON ?ORGANIZATION))").
:- assert_kif("(subclass NormativeAttribute RelationalAttribute)").
:- assert_kif("(documentation NormativeAttribute EnglishLanguage \"A &%Class containing all of the &%Attributes that are specific to morality, legality, aesthetics, etiquette, etc. Many of these attributes express a judgement that something ought or ought not to be the case.\")").
:- assert_kif("(instance modalAttribute BinaryPredicate)").
:- assert_kif("(instance modalAttribute AsymmetricRelation)").
:- assert_kif("(instance modalAttribute IrreflexiveRelation)").
:- assert_kif("(subrelation modalAttribute property)").
:- assert_kif("(domain modalAttribute 1 Formula)").
:- assert_kif("(domain modalAttribute 2 NormativeAttribute)").
:- assert_kif("(documentation modalAttribute EnglishLanguage \"A &%BinaryRelation that is used to state the normative force of a &%Proposition. (&%modalAttribute ?FORMULA ?PROP) means that the &%Proposition expressed by ?FORMULA has the &%NormativeAttribute ?PROP. For example, (&%modalAttribute (&%exists (?ACT ?OBJ) (&%and"). (&%instance ?ACT &%Giving) (&%agent ?ACT John) (&%patient ?ACT ?OBJ)"). (&%destination ?ACT Tom))) &%Obligation) means that John is obligated to give Tom something.\")").
:- assert_kif("(=> (and (modalAttribute ?FORMULA1 ?PROP) (entails ?FORMULA1 ?FORMULA2)) (modalAttribute ?FORMULA2 ?PROP))").
:- assert_kif("(=> (modalAttribute ?FORMULA Permission) (modalAttribute ?FORMULA Possibility))").
:- assert_kif("(subclass SubjectiveAssessmentAttribute NormativeAttribute)").
:- assert_kif("(disjoint SubjectiveAssessmentAttribute ObjectiveNorm)").
:- assert_kif("(documentation SubjectiveAssessmentAttribute EnglishLanguage \"The &%Class of &%NormativeAttributes which lack an objective criterion for their attribution, i.e. the attribution of these &%Attributes varies from subject to subject and even with respect to the same subject over time. This &%Class is, generally speaking, only used when mapping external knowledge sources to the SUMO. If a term from such a knowledge source seems to lack objective criteria for its attribution, it is assigned to this &%Class.\")").
:- assert_kif("(=> (and (attribute ?OBJ ?ATR) (instance ?ATR SubjectiveAssessmentAttribute)) (exists (?TIME ?JUDGE ?AGENT) (and (instance ?JUDGE Judging) (agent ?JUDGE ?AGENT) (patient ?JUDGE ?OBJ) (patient ?JUDGE (attribute ?OBJ ?ATR)) (holdsDuring ?TIME (believes ?AGENT (property ?OBJ ?ATR))))))").
:- assert_kif("(subclass SubjectiveStrongPositiveAttribute SubjectiveAssessmentAttribute)").
:- assert_kif("(documentation SubjectiveStrongPositiveAttribute EnglishLanguage \"The &%Class of &%NormativeAttributes which lack an objective criterion for their attribution, though statistically tends to be used in a strongly positive sense. This &%Class is, generally speaking, only used when mapping external knowledge sources to the SUMO. If a term from such a knowledge source seems to lack objective criteria for its attribution, it is assigned to this &%Class.\")").
:- assert_kif("(subclass SubjectiveWeakPositiveAttribute SubjectiveAssessmentAttribute)").
:- assert_kif("(documentation SubjectiveWeakPositiveAttribute EnglishLanguage \"The &%Class of &%NormativeAttributes which lack an objective criterion for their attribution, though statistically tends to be used in a weakly positive sense. This &%Class is, generally speaking, only used when mapping external knowledge sources to the SUMO. If a term from such a knowledge source seems to lack objective criteria for its attribution, it is assigned to this &%Class.\")").
:- assert_kif("(subclass SubjectiveStrongNegativeAttribute SubjectiveAssessmentAttribute)").
:- assert_kif("(documentation SubjectiveStrongNegativeAttribute EnglishLanguage \"The &%Class of &%NormativeAttributes which lack an objective criterion for their attribution, though statistically tends to be used in a strongly negative sense. This &%Class is, generally speaking, only used when mapping external knowledge sources to the SUMO. If a term from such a knowledge source seems to lack objective criteria for its attribution, it is assigned to this &%Class.\")").
:- assert_kif("(subclass SubjectiveWeakNegativeAttribute SubjectiveAssessmentAttribute)").
:- assert_kif("(documentation SubjectiveWeakNegativeAttribute EnglishLanguage \"The &%Class of &%NormativeAttributes which lack an objective criterion for their attribution, though statistically tends to be used in a weakly negative sense. This &%Class is, generally speaking, only used when mapping external knowledge sources to the SUMO. If a term from such a knowledge source seems to lack objective criteria for its attribution, it is assigned to this &%Class.\")").
:- assert_kif("(subclass ObjectiveNorm NormativeAttribute)").
:- assert_kif("(documentation ObjectiveNorm EnglishLanguage \"The &%Class of &%NormativeAttributes that are associated with an objective criterion for their attribution, i.e. there is broad consensus about the cases where these attributes are applicable.\")").
:- assert_kif("(subclass ContestAttribute ObjectiveNorm)").
:- assert_kif("(documentation ContestAttribute EnglishLanguage \"A &%Class containing &%Attributes that are specific to participants in a &%Contest. In particular, these &%Attributes indicate the position of one of the &%agents in the &%Contest with respect to other &%agent(s) in the &%Contest. Some examples of these &%Attributes are winning, losing, won, lost, etc.\")").
:- assert_kif("(=> (and (property ?THING ?ATTR) (instance ?ATTR ContestAttribute)) (exists (?CONTEST) (and (instance ?CONTEST Contest) (or (agent ?CONTEST ?THING) (patient ?CONTEST ?THING) (subProcess ?THING ?CONTEST)))))").
:- assert_kif("(subclass AlethicAttribute ObjectiveNorm)").
:- assert_kif("(documentation AlethicAttribute EnglishLanguage \"A &%Class containing all of the &%Attributes relating to the notions of possibility and necessity.\")").
:- assert_kif("(instance Possibility AlethicAttribute)").
:- assert_kif("(documentation Possibility EnglishLanguage \"Attribute that applies to &%Propositions that are possible, i.e. true in at least one possible world.\")").
:- assert_kif("(instance Necessity AlethicAttribute)").
:- assert_kif("(documentation Necessity EnglishLanguage \"Attribute that applies to &%Propositions that are necessary, i.e. true in every possible world.\")").
:- assert_kif("(<=> (modalAttribute ?FORMULA Necessity) (not (modalAttribute (not ?FORMULA) Possibility)))").
:- assert_kif("(=> (modalAttribute ?FORMULA Necessity) (modalAttribute ?FORMULA Possibility))").
:- assert_kif("(instance holdsRight BinaryPredicate)").
:- assert_kif("(instance holdsRight AsymmetricRelation)").
:- assert_kif("(domain holdsRight 1 Formula)").
:- assert_kif("(domain holdsRight 2 CognitiveAgent)").
:- assert_kif("(documentation holdsRight EnglishLanguage \"Expresses a relationship between a &%Formula and a &%CognitiveAgent whereby the &%CognitiveAgent has the right to bring it about that the &%Formula is true.\")").
:- assert_kif("(instance confersRight TernaryPredicate)").
:- assert_kif("(domain confersRight 1 Formula)").
:- assert_kif("(domain confersRight 2 Entity)").
:- assert_kif("(domain confersRight 3 CognitiveAgent)").
:- assert_kif("(documentation confersRight EnglishLanguage \"Expresses the relationship between a &%Formula, an &%Entity, and a &%CognitiveAgent when the &%Entity authorizes the &%CognitiveAgent to bring it about that the &%Formula is true.\")").
:- assert_kif("(=> (confersRight ?FORMULA ?AGENT1 ?AGENT2) (holdsRight ?FORMULA ?AGENT2))").
:- assert_kif("(instance holdsObligation BinaryPredicate)").
:- assert_kif("(instance holdsObligation AsymmetricRelation)").
:- assert_kif("(domain holdsObligation 1 Formula)").
:- assert_kif("(domain holdsObligation 2 CognitiveAgent)").
:- assert_kif("(relatedInternalConcept holdsObligation holdsRight)").
:- assert_kif("(documentation holdsObligation EnglishLanguage \"Expresses a relationship between a &%Formula and a &%CognitiveAgent whereby the &%CognitiveAgent has the obligation to bring it about that the &%Formula is true.\")").
:- assert_kif("(instance confersObligation TernaryPredicate)").
:- assert_kif("(domain confersObligation 1 Formula)").
:- assert_kif("(domain confersObligation 2 Entity)").
:- assert_kif("(domain confersObligation 3 CognitiveAgent)").
:- assert_kif("(relatedInternalConcept confersObligation confersRight)").
:- assert_kif("(documentation confersObligation EnglishLanguage \"Expresses the relationship between a a &%Formula, an &%Entity, and a &%CognitiveAgent when the &%Entity obligates the &%CognitiveAgent to bring it about that the &%Formula is true.\")").
:- assert_kif("(=> (confersObligation ?FORMULA ?AGENT1 ?AGENT2) (holdsObligation ?FORMULA ?AGENT2))").
:- assert_kif("(subclass DeonticAttribute ObjectiveNorm)").
:- assert_kif("(documentation DeonticAttribute EnglishLanguage \"A &%Class containing all of the &%Attributes relating to the notions of permission, obligation, and prohibition.\")").
:- assert_kif("(instance Permission DeonticAttribute)").
:- assert_kif("(documentation Permission EnglishLanguage \"&%Attribute that applies to &%Propositions that an &%Agent is permitted, by some authority, to make true.\")").
:- assert_kif("(instance Obligation DeonticAttribute)").
:- assert_kif("(documentation Obligation EnglishLanguage \"&%Attribute that applies to &%Propositions that an &%Agent is required, by some authority, to make true.\")").
:- assert_kif("(<=> (modalAttribute ?FORMULA Obligation) (not (modalAttribute (not ?FORMULA) Permission)))").
:- assert_kif("(=> (modalAttribute ?FORMULA Obligation) (modalAttribute ?FORMULA Permission))").
:- assert_kif("(subAttribute Law Obligation)").
:- assert_kif("(instance Law DeonticAttribute)").
:- assert_kif("(documentation Law EnglishLanguage \"&%Attribute that applies to &%Propositions that are required by a government or a branch of the government and that are enforced with penalties for noncompliance. These &%Propositions may be codified as legislation or they may be more informal, as in the case of government policy.\")").
:- assert_kif("(subAttribute Promise Obligation)").
:- assert_kif("(documentation Promise EnglishLanguage \"&%Attribute that applies to &%Propositions that an &%Agent promises to make true. &%Promises may be implicit or explicit. They may be expressed in a written or verbal or gestural manner.\")").
% :- assert_kif("; KJN: Moving this to Mid-level-ontology as the definition for Contract is all there. ").
% :- assert_kif(" (=> (property ?ENTITY Promise) (or (property ?ENTITY Contract) (property ?ENTITY NakedPromise)))").
% :- assert_kif(" (subAttribute NakedPromise Promise) (documentation NakedPromise EnglishLanguage \"A &%Promise where nothing is promised in return, i.e. a nudum pactum.\")").
:- assert_kif("(instance Prohibition DeonticAttribute)").
:- assert_kif("(documentation Prohibition EnglishLanguage \"&%Prohibition is the &%DeonticAttribute that applies to &%Formulas that an &%Agent is forbidden, by some authority, to make true.\")").
:- assert_kif("(<=> (modalAttribute ?FORMULA Prohibition) (not (modalAttribute ?FORMULA Permission)))").
:- assert_kif("(subclass ProbabilityAttribute ObjectiveNorm)").
:- assert_kif("(documentation ProbabilityAttribute EnglishLanguage \"A class containing all of the &%Attributes relating to objective, qualitative assessments of probability, e.g. &%Likely and &%Unlikely.\")").
:- assert_kif("(instance Likely ProbabilityAttribute)").
:- assert_kif("(contraryAttribute Likely Unlikely)").
:- assert_kif("(documentation Likely EnglishLanguage \"The &%ProbabilityAttribute of being probable, i.e. more likely than not to be &%True.\")").
:- assert_kif("(=> (modalAttribute ?FORMULA Likely) (greaterThan (ProbabilityFn (truth ?FORMULA True)) (ProbabilityFn (truth ?FORMULA False))))").
:- assert_kif("(instance Unlikely ProbabilityAttribute)").
:- assert_kif("(documentation Unlikely EnglishLanguage \"The &%ProbabilityAttribute of being improbable, i.e. more likely than not to be &%False.\")").
:- assert_kif("(=> (modalAttribute ?FORMULA Unlikely) (greaterThan (ProbabilityFn (truth ?FORMULA False)) (ProbabilityFn (truth ?FORMULA True))))").
:- assert_kif("(subclass PhysicalState InternalAttribute)").
:- assert_kif("(contraryAttribute Solid Liquid Gas Plasma)").
:- assert_kif("(exhaustiveAttribute PhysicalState Solid Fluid Liquid Gas Plasma)").
:- assert_kif("(documentation PhysicalState EnglishLanguage \"The physical state of an &%Object. There are three reified instances of this &%Class: &%Solid, &%Liquid, and &%Gas. Physical changes are not characterized by the transformation of one substance into another, but rather by the change of the form (physical states) of a given substance. For example, melting an iron nail yields a substance still called iron.\")").
:- assert_kif("(instance Solid PhysicalState)").
:- assert_kif("(documentation Solid EnglishLanguage \"An &%Object has the &%Attribute of &%Solid if it has a fixed shape and a fixed volume.\")").
:- assert_kif("(instance Fluid PhysicalState)").
:- assert_kif("(documentation Fluid EnglishLanguage \"&%Fluid is the &%PhysicalState attribute of an &%Object that does not have a fixed shape and thus tends to flow or to conform to the shape of a container.\")").
:- assert_kif("(instance Liquid PhysicalState)").
:- assert_kif("(subAttribute Liquid Fluid)").
:- assert_kif("(documentation Liquid EnglishLanguage \"An &%Object has the &%Attribute of &%Liquid if it has a fixed volume but not a fixed shape.\")").
:- assert_kif("(=> (instance ?OBJ Solution) (attribute ?OBJ Liquid))").
:- assert_kif("(instance Gas PhysicalState)").
:- assert_kif("(subAttribute Gas Fluid)").
:- assert_kif("(documentation Gas EnglishLanguage \"An &%Object has the &%Attribute of &%Gas if it has neither a fixed volume nor a fixed shape.\")").
:- assert_kif("(<=> (instance ?OBJ Substance) (exists (?ATTR) (and (instance ?ATTR PhysicalState) (attribute ?OBJ ?ATTR))))").
:- assert_kif("(instance Plasma PhysicalState)").
:- assert_kif("(subAttribute Plasma Fluid)").
:- assert_kif("(documentation Plasma EnglishLanguage \"An extremely energetic &%PhysicalState that consists of atomic nuclei stripped of electrons. That is, a plasma is composed of positive ions and free electrons. &%Plasma behaves differently enough from &%Gas that it is referred to as the fourth state of matter.\")").
% :- assert_kif("; NS: delete. Instances of SoundAttribute should also be instances of PerceptualAttribute, but SoundAttribute is a subclass of RelationalAttribute, not of InternalAttribute. Some PerceptualAttributes are InternalAttributes. Others are RelationalAttributes. (subclass PerceptualAttribute InternalAttribute)").
% :- assert_kif("; NS: add.").
:- assert_kif("(subclass PerceptualAttribute Attribute)").
:- assert_kif("(documentation PerceptualAttribute EnglishLanguage \"Any &%Attribute whose presence is detected by an act of &%Perception.\")").
:- assert_kif("(=> (and (instance ?PERCEPTION Perception) (patient ?PERCEPTION ?OBJ)) (exists (?PROP) (and (instance ?PROP PerceptualAttribute) (attribute ?OBJ ?PROP))))").
:- assert_kif("(subclass TasteAttribute PerceptualAttribute)").
:- assert_kif("(documentation TasteAttribute EnglishLanguage \"The &%Class of &%Attributes relating to the taste of &%Objects.\")").
:- assert_kif("(=> (instance ?OBJ (FoodForFn Animal)) (exists (?ATTR) (and (instance ?ATTR TasteAttribute) (attribute ?OBJ ?ATTR))))").
:- assert_kif("(subclass OlfactoryAttribute PerceptualAttribute)").
:- assert_kif("(documentation OlfactoryAttribute EnglishLanguage \"The &%Class of properties that are detectable by smell.\")").
:- assert_kif("(subclass VisualAttribute PerceptualAttribute)").
:- assert_kif("(documentation VisualAttribute EnglishLanguage \"The &%Class of visually discernible properties.\")").
:- assert_kif("(instance Illuminated VisualAttribute)").
:- assert_kif("(documentation Illuminated EnglishLanguage \"The &%Attribute of &%Regions that are illuminated to some degree, i.e. in which some shapes are visually discernable.\")").
:- assert_kif("(instance Unilluminated VisualAttribute)").
:- assert_kif("(contraryAttribute Unilluminated Illuminated)").
:- assert_kif("(documentation Unilluminated EnglishLanguage \"The &%Attribute of &%Regions that are unilluminated, i.e in which no shapes are visually discernable.\")").
% :- assert_kif("; NS: delete. (subclass ColorAttribute InternalAttribute)").
% :- assert_kif("; NS: add.").
:- assert_kif("(subclass ColorAttribute VisualAttribute)").
:- assert_kif("(documentation ColorAttribute EnglishLanguage \"The &%Class of &%Attributes relating to the color of &%Objects.\")").
:- assert_kif("(subclass PrimaryColor ColorAttribute)").
:- assert_kif("(documentation PrimaryColor EnglishLanguage \"Colors which can be blended to form any color and which cannot be derived from any other colors.\")").
:- assert_kif("(instance Red PrimaryColor)").
:- assert_kif("(documentation Red EnglishLanguage \"The &%Attribute of redness.\")").
:- assert_kif("(instance Blue PrimaryColor)").
:- assert_kif("(documentation Blue EnglishLanguage \"The &%Attribute of being blue in color.\")").
:- assert_kif("(instance Yellow PrimaryColor)").
:- assert_kif("(documentation Yellow EnglishLanguage \"The &%Attribute of being yellow in color.\")").
:- assert_kif("(instance White PrimaryColor)").
:- assert_kif("(documentation White EnglishLanguage \"The &%Attribute of being white in color.\")").
:- assert_kif("(instance Black PrimaryColor)").
:- assert_kif("(documentation Black EnglishLanguage \"The &%Attribute of being black in color.\")").
:- assert_kif("(instance Monochromatic ColorAttribute)").
:- assert_kif("(documentation Monochromatic EnglishLanguage \"An &%Object with this &%Attribute has the same color on every part of its surface.\")").
:- assert_kif("(=> (and (attribute ?OBJ Monochromatic) (superficialPart ?PART ?OBJ) (attribute ?PART ?COLOR) (instance ?COLOR PrimaryColor)) (forall (?ELEMENT) (=> (superficialPart ?ELEMENT ?OBJ) (attribute ?ELEMENT ?COLOR))))").
:- assert_kif("(=> (instance ?OBJ Object) (or (attribute ?OBJ Monochromatic) (attribute ?OBJ Polychromatic)))").
:- assert_kif("(instance Polychromatic ColorAttribute)").
:- assert_kif("(contraryAttribute Polychromatic Monochromatic)").
:- assert_kif("(documentation Polychromatic EnglishLanguage \"An &%Object with this &%Attribute has different colors on different parts of its surface.\")").
:- assert_kif("(=> (attribute ?OBJ Polychromatic) (exists (?PART1 ?PART2 ?COLOR1 ?COLOR2) (and (superficialPart ?PART1 ?OBJ) (superficialPart ?PART2 ?OBJ) (attribute ?PART1 ?COLOR1) (attribute ?PART2 ?COLOR2) (instance ?COLOR1 ColorAttribute) (instance ?COLOR2 ColorAttribute) (not (equal ?COLOR1 ?COLOR2)))))").
% :- assert_kif("; KJN: Moved in from Media.kif").
:- assert_kif("(subclass StructureAttribute InternalAttribute)").
:- assert_kif("(documentation StructureAttribute EnglishLanguage \"Each &%subclass of &%StructureAttribute denotes some facet of the structure of physical entities. Each &%instance of &%StructureAttribute denotes some structural characteristic that may pertain to some &%Physical entity.\")").
:- assert_kif("(subclass ShapeAttribute StructureAttribute)").
% :- assert_kif("; KJN: Delete as StructureAttribute already subclasses from InternalAttribute (subclass ShapeAttribute InternalAttribute)").
:- assert_kif("(documentation ShapeAttribute EnglishLanguage \"Any &%Attribute that relates to the shape of an &%Object.\")").
:- assert_kif("(=> (and (instance ?ATTRIBUTE ShapeAttribute) (attribute ?OBJ ?ATTRIBUTE) (surface ?SURFACE ?OBJ)) (attribute ?SURFACE ?ATTRIBUTE))").
:- assert_kif("(instance Pliable InternalAttribute)").
:- assert_kif("(documentation Pliable EnglishLanguage \"The shape of an &%Object with this &%Attribute can easily be altered.\")").
:- assert_kif("(=> (and (instance ?OBJ Object) (attribute ?OBJ Pliable)) (exists (?CHANGE) (and (instance ?CHANGE ShapeChange) (patient ?CHANGE ?OBJ))))").
:- assert_kif("(instance Rigid InternalAttribute)").
:- assert_kif("(contraryAttribute Rigid Pliable)").
:- assert_kif("(documentation Rigid EnglishLanguage \"The shape of an &%Object with this &%Attribute cannot be altered without breaking.\")").
:- assert_kif("(subclass TextureAttribute PerceptualAttribute)").
:- assert_kif("(documentation TextureAttribute EnglishLanguage \"Any &%Attribute that characterizes the texture of an &%Object.\")").
:- assert_kif("(=> (and (instance ?ATTRIBUTE TextureAttribute) (attribute ?OBJ ?ATTRIBUTE) (surface ?SURFACE ?OBJ)) (attribute ?SURFACE ?ATTRIBUTE))").
:- assert_kif("(instance Smooth TextureAttribute)").
:- assert_kif("(documentation Smooth EnglishLanguage \"An &%Object with this &%Attribute has a smooth surface.\")").
:- assert_kif("(instance Rough TextureAttribute)").
:- assert_kif("(contraryAttribute Smooth Rough)").
:- assert_kif("(documentation Rough EnglishLanguage \"An &%Object with this &%Attribute has a rough surface.\")").
:- assert_kif("(subclass GeometricFigure ShapeAttribute)").
:- assert_kif("(partition GeometricFigure GeometricPoint OneDimensionalFigure TwoDimensionalFigure ThreeDimensionalFigure)").
:- assert_kif("(documentation GeometricFigure EnglishLanguage \"The class of all geometric figures, i.e. the class of all abstract, spatial representations. The instances of this class are &%GeometricPoints, &%TwoDimensionalFigures or &%ThreeDimensionalFigures.\")").
:- assert_kif("(subclass GeometricPoint GeometricFigure)").
:- assert_kif("(documentation GeometricPoint EnglishLanguage \"The class of zero-dimensional &%GeometricFigures, i.e. the class of &%GeometricFigures that have position but lack extension in any dimension.\")").
:- assert_kif("(subclass OneDimensionalFigure GeometricFigure)").
:- assert_kif("(documentation OneDimensionalFigure EnglishLanguage \"The class of &%GeometricFigures that have position and an extension along a single dimension, viz. straight lines.\")").
:- assert_kif("(subclass TwoDimensionalFigure GeometricFigure)").
:- assert_kif("(partition TwoDimensionalFigure OpenTwoDimensionalFigure ClosedTwoDimensionalFigure)").
:- assert_kif("(documentation TwoDimensionalFigure EnglishLanguage \"The class of &%GeometricFigures that have position and an extension along two dimensions, viz. plane figures like circles and polygons.\")").
:- assert_kif("(subclass OpenTwoDimensionalFigure TwoDimensionalFigure)").
:- assert_kif("(documentation OpenTwoDimensionalFigure EnglishLanguage \"The class of &%TwoDimensionalFigures that are not &%ClosedTwoDimensionalFigures.\")").
:- assert_kif("(subclass TwoDimensionalAngle OpenTwoDimensionalFigure)").
:- assert_kif("(documentation TwoDimensionalAngle EnglishLanguage \"Any two &%OneDimensionalFigures (i.e. straight lines) meeting at a single &%GeometricPoint.\")").
:- assert_kif("(subclass ClosedTwoDimensionalFigure TwoDimensionalFigure)").
:- assert_kif("(documentation ClosedTwoDimensionalFigure EnglishLanguage \"Any &%TwoDimensionalFigure which has a well defined interior and exterior.\")").
:- assert_kif("(subclass ThreeDimensionalFigure GeometricFigure)").
:- assert_kif("(documentation ThreeDimensionalFigure EnglishLanguage \"The class of &%GeometricFigures that have position and an extension along three dimensions, viz. geometric solids like polyhedrons and cylinders.\")").
:- assert_kif("(instance geometricPart BinaryPredicate)").
:- assert_kif("(instance geometricPart PartialOrderingRelation)").
:- assert_kif("(domain geometricPart 1 GeometricFigure)").
:- assert_kif("(domain geometricPart 2 GeometricFigure)").
:- assert_kif("(documentation geometricPart EnglishLanguage \"(&%geometricPart ?PART ?WHOLE) means that the &%GeometricFigure ?PART is part of the &%GeometricFigure ?WHOLE.\")").
:- assert_kif("(subrelation pointOfFigure geometricPart)").
:- assert_kif("(domain pointOfFigure 1 GeometricPoint)").
:- assert_kif("(domain pointOfFigure 2 GeometricFigure)").
:- assert_kif("(documentation pointOfFigure EnglishLanguage \"(&%pointOfFigure ?POINT ?FIGURE) means that the &%GeometricPoint ?POINT is part of the &%GeometricFigure ?FIGURE.\")").
:- assert_kif("(subrelation angleOfFigure geometricPart)").
:- assert_kif("(domain angleOfFigure 1 TwoDimensionalAngle)").
:- assert_kif("(domain angleOfFigure 2 GeometricFigure)").
:- assert_kif("(documentation angleOfFigure EnglishLanguage \"(&%angleOfFigure ?ANGLE ?FIGURE) means that the &%TwoDimensionalAngle ?ANGLE is part of the &%GeometricFigure ?FIGURE.\")").
:- assert_kif("(instance pointOfIntersection TernaryPredicate)").
:- assert_kif("(domain pointOfIntersection 1 OneDimensionalFigure)").
:- assert_kif("(domain pointOfIntersection 2 OneDimensionalFigure)").
:- assert_kif("(domain pointOfIntersection 3 GeometricPoint)").
:- assert_kif("(documentation pointOfIntersection EnglishLanguage \"(&%pointOfIntersection ?FIGURE1 ?FIGURE2 ?POINT) means that the two straight lines ?FIGURE1 and ?FIGURE2 meet at the point ?POINT.\")").
:- assert_kif("(=> (pointOfIntersection ?FIGURE1 ?FIGURE2 ?POINT) (and (pointOfFigure ?POINT ?FIGURE1) (pointOfFigure ?POINT ?FIGURE2)))").
:- assert_kif("(instance parallel BinaryPredicate)").
:- assert_kif("(domain parallel 1 OneDimensionalFigure)").
:- assert_kif("(domain parallel 2 OneDimensionalFigure)").
:- assert_kif("(documentation parallel EnglishLanguage \"(&%parallel ?LINE1 ?LINE2) means that the &%OneDimensionalFigures ?LINE1 and ?LINE2 are parallel to one another, i.e. they are equidistant from one another at every point.\")").
:- assert_kif("(=> (parallel ?LINE1 ?LINE2) (not (exists (?POINT) (pointOfIntersection ?LINE1 ?LINE2 ?POINT))))").
:- assert_kif("(instance angularMeasure BinaryPredicate)").
:- assert_kif("(instance angularMeasure TotalValuedRelation)").
:- assert_kif("(domain angularMeasure 1 TwoDimensionalAngle)").
:- assert_kif("(domain angularMeasure 2 PlaneAngleMeasure)").
:- assert_kif("(documentation angularMeasure EnglishLanguage \"(&%angularMeasure ?ANGLE ?MEASURE) means that the two-dimensional geometric angle ?ANGLE has the &%PlaneAngleMeasure of ?MEASURE.\")").
:- assert_kif("(instance lineMeasure BinaryPredicate)").
:- assert_kif("(instance lineMeasure TotalValuedRelation)").
:- assert_kif("(domain lineMeasure 1 OneDimensionalFigure)").
:- assert_kif("(domain lineMeasure 2 LengthMeasure)").
:- assert_kif("(documentation lineMeasure EnglishLanguage \"(&%lineMeasure ?LINE ?MEASURE) means that the straight line ?LINE has the &%LengthMeasure of ?MEASURE.\")").
:- assert_kif("(instance geometricDistance TernaryPredicate)").
:- assert_kif("(instance geometricDistance SingleValuedRelation)").
:- assert_kif("(instance geometricDistance TotalValuedRelation)").
:- assert_kif("(domain geometricDistance 1 GeometricPoint)").
:- assert_kif("(domain geometricDistance 2 GeometricPoint)").
:- assert_kif("(domain geometricDistance 3 LengthMeasure)").
:- assert_kif("(documentation geometricDistance EnglishLanguage \"(&%geometricDistance ?POINT1 ?POINT2 ?LENGTH) means that ?LENGTH is the distance between the two &%GeometricPoints ?POINT1 and ?POINT2.\")").
:- assert_kif("(=> (geometricDistance ?POINT1 ?POINT2 ?LENGTH) (geometricDistance ?POINT2 ?POINT1 ?LENGTH))").
:- assert_kif("(subclass SaturationAttribute InternalAttribute)").
:- assert_kif("(documentation SaturationAttribute EnglishLanguage \"A &%Class of &%Attributes that specify, in a qualitative manner, the extent of the presence of one kind of &%Object in another kind of &%Object.\")").
:- assert_kif("(instance Dry SaturationAttribute)").
:- assert_kif("(contraryAttribute Dry Damp)").
:- assert_kif("(documentation Dry EnglishLanguage \"An &%Attribute which indicates that the associated &%Object contains no &%Liquid.\")").
:- assert_kif("(=> (attribute ?OBJ Dry) (not (exists (?SUBOBJ) (and (part ?SUBOBJ ?OBJ) (attribute ?SUBOBJ Liquid)))))").
:- assert_kif("(instance Damp SaturationAttribute)").
:- assert_kif("(documentation Damp EnglishLanguage \"An &%Attribute which indicates that the associated &%Object contains some &%Liquid.\")").
:- assert_kif("(instance Wet SaturationAttribute)").
:- assert_kif("(subAttribute Wet Damp)").
:- assert_kif("(documentation Wet EnglishLanguage \"An &%Attribute which indicates that the associated &%Object is fully saturated with a &%Liquid, i.e. every part of the &%Object has a subpart which is a &%Liquid.\")").
:- assert_kif("(=> (attribute ?OBJ Wet) (forall (?PART) (=> (part ?PART ?OBJ) (exists (?SUBPART) (and (part ?SUBPART ?PART) (attribute ?SUBPART Liquid))))))").
:- assert_kif("(subclass BiologicalAttribute InternalAttribute)").
:- assert_kif("(documentation BiologicalAttribute EnglishLanguage \"&%Attributes that apply specifically to instances of &%Organism.\")").
% :- assert_kif("; NS: delete. Many current instances of BiologicalAttribute apply to OrganicObjects that are not Organisms. (=> (and (attribute ?ORG ?ATT) (instance ?ATT BiologicalAttribute)) (instance ?ORG Organism))").
% :- assert_kif("; NS: add.").
:- assert_kif("(=> (and (attribute ?ORG ?ATT) (instance ?ATT BiologicalAttribute)) (instance ?ORG OrganicObject))").
:- assert_kif("(subclass BodyPosition BiologicalAttribute)").
:- assert_kif("(documentation BodyPosition EnglishLanguage \"The class of &%Attributes expressing configurations of bodies or parts of bodies of animals or humans, e.g. standing, sitting, kneeling, lying down, etc.\")").
:- assert_kif("(=> (instance ?ANIMAL Animal) (or (exists (?MOTION) (and (instance ?MOTION BodyMotion) (agent ?MOTION ?ANIMAL))) (exists (?ATTR) (and (instance ?ATTR BodyPosition) (attribute ?ANIMAL ?ATTR)))))").
:- assert_kif("(instance Standing BodyPosition)").
:- assert_kif("(documentation Standing EnglishLanguage \"The &%BodyPosition of being upright, i.e. being fully extended and supported by nothing other than one's own feet.\")").
:- assert_kif("(=> (and (instance ?AMBULATE Ambulating) (agent ?AMBULATE ?AGENT)) (attribute ?AGENT Standing))").
:- assert_kif("(instance Sitting BodyPosition)").
:- assert_kif("(documentation Sitting EnglishLanguage \"The &%BodyPosition of being recumbent, i.e. knees bent and back side supported.\")").
:- assert_kif("(instance Prostrate BodyPosition)").
:- assert_kif("(documentation Prostrate EnglishLanguage \"The &%BodyPosition of lying down, being in a horizontal position.\")").
:- assert_kif("(subclass AnimacyAttribute BiologicalAttribute)").
:- assert_kif("(exhaustiveAttribute AnimacyAttribute Living Dead)").
:- assert_kif("(documentation AnimacyAttribute EnglishLanguage \"&%Attributes that indicate whether an &%Organism is alive or not.\")").
:- assert_kif("(instance Living AnimacyAttribute)").
:- assert_kif("(documentation Living EnglishLanguage \"This &%Attribute applies to &%Organisms that are alive.\")").
:- assert_kif("(=> (and (instance ?ORGANISM Organism) (agent ?PROCESS ?ORGANISM)) (holdsDuring (WhenFn ?PROCESS) (attribute ?ORGANISM Living)))").
:- assert_kif("(instance Dead AnimacyAttribute)").
:- assert_kif("(subAttribute Dead Unconscious)").
:- assert_kif("(contraryAttribute Dead Living)").
:- assert_kif("(documentation Dead EnglishLanguage \"This &%Attribute applies to &%Organisms that are not alive.\")").
:- assert_kif("(=> (instance ?ORG Organism) (exists (?ATTR) (and (instance ?ATTR AnimacyAttribute) (attribute ?ORG ?ATTR))))").
:- assert_kif("(subclass SexAttribute BiologicalAttribute)").
:- assert_kif("(exhaustiveAttribute SexAttribute Female Male)").
:- assert_kif("(documentation SexAttribute EnglishLanguage \"&%Attributes that indicate the sex of an &%Organism.\")").
:- assert_kif("(instance Female SexAttribute)").
:- assert_kif("(documentation Female EnglishLanguage \"An &%Attribute indicating that an &%Organism is female in nature.\")").
:- assert_kif("(=> (and (instance ?BODY ReproductiveBody) (part ?BODY ?ORG) (instance ?ORG Organism)) (attribute ?ORG Female))").
:- assert_kif("(instance Male SexAttribute)").
:- assert_kif("(contraryAttribute Male Female)").
:- assert_kif("(documentation Male EnglishLanguage \"An &%Attribute indicating that an &%Organism is male in nature.\")").
:- assert_kif("(=> (instance ?ANIMAL Animal) (exists (?ATTR) (and (instance ?ATTR SexAttribute) (attribute ?ANIMAL ?ATTR))))").
:- assert_kif("(subclass DevelopmentalAttribute BiologicalAttribute)").
:- assert_kif("(exhaustiveAttribute DevelopmentalAttribute FullyFormed NonFullyFormed)").
:- assert_kif("(documentation DevelopmentalAttribute EnglishLanguage \"&%Attributes that indicate the stage of development of an &%Organism.\")").
:- assert_kif("(instance FullyFormed DevelopmentalAttribute)").
:- assert_kif("(documentation FullyFormed EnglishLanguage \"The stage of an &%Organism when it has reached the end of its growth phase.\")").
:- assert_kif("(=> (attribute ?OBJ FullyFormed) (exists (?GROWTH) (and (instance ?GROWTH Growth) (experiencer ?GROWTH ?OBJ) (holdsDuring (BeginFn (WhenFn ?OBJ)) (attribute ?OBJ NonFullyFormed)))))").
:- assert_kif("(instance NonFullyFormed DevelopmentalAttribute)").
:- assert_kif("(contraryAttribute NonFullyFormed FullyFormed)").
:- assert_kif("(successorAttribute NonFullyFormed FullyFormed)").
:- assert_kif("(documentation NonFullyFormed EnglishLanguage \"The stage of an &%Organism before it is &%FullyFormed.\")").
:- assert_kif("(=> (instance ?ORG Organism) (exists (?ATTR) (and (instance ?ATTR DevelopmentalAttribute) (attribute ?ORG ?ATTR))))").
:- assert_kif("(subAttribute Larval NonFullyFormed)").
:- assert_kif("(documentation Larval EnglishLanguage \"Form of most &%Invertebrates, &%Amphibians, and &%Fish immediately after they hatch. This form is fundamentally unlike the adult form, and metamorphosis is required to reach the latter form.\")").
% :- assert_kif("; NS: delete. (=> (holdsDuring ?TIME (attribute ?ORG Larval)) (holdsDuring (PastFn ?TIME) (exists (?BIRTH) (and (instance ?BIRTH Birth) (experiencer ?BIRTH ?ORG)))))").
% :- assert_kif("; NS: add.").
:- assert_kif("(=> (and (holdsDuring ?TIME (attribute ?ORG Larval)) (instance ?BIRTH Birth) (equal ?BW (WhenFn ?BIRTH)) (experiencer ?BIRTH ?ORG)) (meetsTemporally ?BW ?TIME))").
:- assert_kif("(subAttribute Embryonic NonFullyFormed)").
:- assert_kif("(contraryAttribute Embryonic Larval)").
:- assert_kif("(documentation Embryonic EnglishLanguage \"The stage of an &%Organism or an &%AnatomicalStructure that exists only before the &%Organism is born. &%Mammals, for example, have this &%Attribute only prior to their birth.\")").
:- assert_kif("(=> (attribute ?ORG Embryonic) (exists (?BODY) (and (instance ?BODY ReproductiveBody) (located ?ORG ?BODY))))").
% :- assert_kif("; NS: delete. It's best not to put either (exists ... or (not (exists ... inside the scope of holdsDuring. (=> (holdsDuring ?TIME (attribute ?ORG Embryonic)) (holdsDuring ?TIME (not (exists (?BIRTH) (and (instance ?BIRTH Birth) (experiencer ?BIRTH ?ORG))))))").
% :- assert_kif("; NS: add.").
:- assert_kif("(=> (and (holdsDuring ?TIME (attribute ?ORG Embryonic)) (instance ?BIRTH Birth) (equal ?BW (WhenFn ?BIRTH)) (experiencer ?BIRTH ?ORG)) (not (overlapsTemporally ?TIME ?BW)))").
:- assert_kif("(subclass DiseaseOrSyndrome BiologicalAttribute)").
:- assert_kif("(documentation DiseaseOrSyndrome EnglishLanguage \"A &%BiologicalAttribute which qualifies something that alters or interferes with a normal process, state or activity of an &%Organism. It is usually characterized by the abnormal functioning of one or more of the host's systems, parts, or &%Organs.\")").
% :- assert_kif("; NS: If we wanted to ascribe PsychologicalAttributes to a non-OrganicObject robot or an AI, this statement would have to be changed.").
:- assert_kif("(subclass PsychologicalAttribute BiologicalAttribute)").
:- assert_kif("(partition PsychologicalAttribute StateOfMind TraitAttribute)").
:- assert_kif("(documentation PsychologicalAttribute EnglishLanguage \"&%Attributes that characterize the mental or behavioral life of an &%Organism.\")").
% :- assert_kif("; NS: delete. (=> (instance ?ATTR PsychologicalAttribute) (=> (holdsDuring ?TIME (attribute ?ORGANISM ?ATTR)) (holdsDuring ?TIME (attribute ?ORGANISM Living))))").
% :- assert_kif("; NS: add.").
:- assert_kif("(=> (instance ?ATTR PsychologicalAttribute) (=> (and (holdsDuring ?TIME (attribute ?ORGANISM ?ATTR)) (instance ?ORGANISM Organism)) (holdsDuring ?TIME (attribute ?ORGANISM Living))))").
:- assert_kif("(=> (and (instance ?ATTR PsychologicalAttribute) (attribute ?AGENT ?ATTR)) (instance ?AGENT SentientAgent))").
:- assert_kif("(subclass StateOfMind PsychologicalAttribute)").
:- assert_kif("(documentation StateOfMind EnglishLanguage \"The class &%StateOfMind is distinguished from its complement &%TraitAttribute by the fact that instances of the former are transient while instances of the latter are persistent features of a creature's behavioral/psychological make-up.\")").
:- assert_kif("(subclass EmotionalState StateOfMind)").
:- assert_kif("(documentation EmotionalState EnglishLanguage \"The &%Class of &%Attributes that denote emotional states of &%Organisms.\")").
:- assert_kif("(subclass ConsciousnessAttribute StateOfMind)").
:- assert_kif("(documentation ConsciousnessAttribute EnglishLanguage \"&%Attributes that indicate whether an &%Organism is conscious or the qualitative degree of consciousness of an &%Organism.\")").
:- assert_kif("(<=> (and (instance ?AGENT SentientAgent) (attribute ?AGENT Living)) (exists (?ATTR) (and (instance ?ATTR ConsciousnessAttribute) (attribute ?AGENT ?ATTR))))").
:- assert_kif("(instance Asleep ConsciousnessAttribute)").
:- assert_kif("(documentation Asleep EnglishLanguage \"&%Attribute that applies to &%Organisms that are sleeping.\")").
:- assert_kif("(instance Unconscious ConsciousnessAttribute)").
:- assert_kif("(contraryAttribute Unconscious Awake)").
:- assert_kif("(documentation Unconscious EnglishLanguage \"&%Attribute that applies to &%Organisms that are unconscious. An &%Organism may be &%Unconscious because it is &%Dead or because of a blow to the head, a drug, etc.\")").
:- assert_kif("(instance Awake ConsciousnessAttribute)").
:- assert_kif("(documentation Awake EnglishLanguage \"&%Attribute that applies to &%Organisms that are neither &%Unconscious nor &%Asleep.\")").
:- assert_kif("(=> (or (attribute ?AGENT Asleep) (attribute ?AGENT Awake)) (attribute ?AGENT Living))").
:- assert_kif("(subclass TraitAttribute PsychologicalAttribute)").
:- assert_kif("(documentation TraitAttribute EnglishLanguage \"&%Attributes that indicate the the behavior/personality traits of an &%Organism.\")").
:- assert_kif("(subclass PsychologicalDysfunction PsychologicalAttribute)").
:- assert_kif("(subclass PsychologicalDysfunction DiseaseOrSyndrome)").
:- assert_kif("(documentation PsychologicalDysfunction EnglishLanguage \"A clinically significant dysfunction whose major manifestation is behavioral or psychological. These dysfunctions may have identified or presumed biological etiologies or manifestations.\")").
:- assert_kif("(instance comment TernaryPredicate)").
:- assert_kif("(documentation comment EnglishLanguage \"(&%comment ?ENT ?STR ?PER) is a convenience relationship that allows ontologists represented by &%SymbolicString ?PER to write down commentaries ?STR on a defined &%Entity ?ENT\")").
:- assert_kif("(termFormat EnglishLanguage comment \"comment\")").
:- assert_kif("(domain comment 1 Entity)").
:- assert_kif("(domain comment 2 SymbolicString)").
:- assert_kif("(domain comment 3 SymbolicString)").
:- assert_kif("(instance MakingFn UnaryFunction)").
:- assert_kif("(domainSubclass MakingFn 1 Making)").
:- assert_kif("(rangeSubclass MakingFn Object)").
:- assert_kif("(documentation MakingFn EnglishLanguage \"A &%Function that denotes the creation of an &%Object.\")").
:- assert_kif("(=> (instance ?X (MakingFn ?Y)) (exists (?OBJECT) (and (instance ?OBJECT ?Y) (result ?X ?OBJECT))))").
end_of_file.
% :- assert_kif("; END FILE").
% :- assert_kif("; BEGIN FILE").
% :- assert_kif(";  Sequestered Axioms  ").
% :- assert_kif("; This section is not a subontology of the SUMO. It contains axioms from other sections of the ontology that may cause problems for an inference engine. In particular, they can be used to construct arbitrarily complex terms that often appear in proofs with unhelpful conclusions. Before this file is loaded into the inference engine, the axioms in this section should be commented out.").
% :- assert_kif(" (<=> (instance ?ENTITY (UnionFn ?CLASS1 ?CLASS2)) (or (instance ?ENTITY ?CLASS1) (instance ?ENTITY ?CLASS2)))").
% :- assert_kif(" (<=> (instance ?ENTITY (IntersectionFn ?CLASS1 ?CLASS2)) (and (instance ?ENTITY ?CLASS1) (instance ?ENTITY ?CLASS2)))").
% :- assert_kif(" (<=> (instance ?ENTITY (ComplementFn ?CLASS)) (not (instance ?ENTITY ?CLASS)))").
% :- assert_kif(" (=> (and (instance ?CLASS1 SetOrClass) (instance ?CLASS2 SetOrClass)) (equal (RelativeComplementFn ?CLASS1 ?CLASS2) (IntersectionFn ?CLASS1 (ComplementFn ?CLASS2))))").
% :- assert_kif(" (<=> (instance ?ENTITY (GeneralizedUnionFn ?SUPERCLASS)) (exists (?CLASS) (and (instance ?CLASS ?SUPERCLASS) (instance ?ENTITY ?CLASS))))").
% :- assert_kif(" (<=> (instance ?ENTITY (GeneralizedIntersectionFn ?SUPERCLASS)) (forall (?CLASS) (=> (instance ?CLASS ?SUPERCLASS) (instance ?ENTITY ?CLASS))))").
% :- assert_kif(" (<=> (instance ?SUBCLASS (PowerSetFn ?CLASS)) (subclass ?SUBCLASS ?CLASS))").
% :- assert_kif(" (=> (instance ?REL Function) (<=> (equal (AssignmentFn ?REL @ROW) ?INST) (?REL @ROW ?INST)))").
%  NS: sequestered 2007-08-01 
% :- assert_kif(";  (<=> (instance ?REL BinaryRelation) (not (exists (?ITEM1 ?ITEM2 ?ITEM3 @ROW) (?REL ?ITEM1 ?ITEM2 ?ITEM3 @ROW))))").
% :- assert_kif(";  (=> (instance ?REL TernaryRelation) (not (exists (?ITEM1 ?ITEM2 ?ITEM3 ?ITEM4 @ROW) (?REL ?ITEM1 ?ITEM2 ?ITEM3 ?ITEM4 @ROW))))").
% :- assert_kif(";  (=> (instance ?REL QuaternaryRelation) (not (exists (?ITEM1 ?ITEM2 ?ITEM3 ?ITEM4 ?ITEM5 @ROW) (?REL ?ITEM1 ?ITEM2 ?ITEM3 ?ITEM4 ?ITEM5 @ROW))))").
% :- assert_kif(";  (=> (instance ?REL QuintaryRelation) (not (exists (?ITEM1 ?ITEM2 ?ITEM3 ?ITEM4 ?ITEM5 ?ITEM6 @ROW) (?REL ?ITEM1 ?ITEM2 ?ITEM3 ?ITEM4 ?ITEM5 ?ITEM6 @ROW))))").
