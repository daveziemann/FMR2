Class {
	#name : #TransitionTableGenerator2,
	#superclass : #FMRStatistics,
	#instVars : [
		'matchState',
		'instanceTransitionTableForMatch',
		'genericTransitionTableForMatch',
		'genericTransitionTableForMatches'
	],
	#category : #FMR
}

{ #category : #API }
TransitionTableGenerator2 class >> normalisedMetaTable [
"Answer the normalised transition table across all matches"

^self new generateGenericTransitionTableForAllMatches genericTransitionTableForMatches normalise
]

{ #category : #arithmetic }
TransitionTableGenerator2 >> addDictionary: aDictionary to: anotherDictionary [
| summedDictionary |

summedDictionary := aDictionary veryDeepCopy.
anotherDictionary keysAndValuesDo: [ :key :number |
	| oldNumber |
	oldNumber := summedDictionary at: key ifAbsent: [ 0 ].	 
	summedDictionary at: key	put: oldNumber + number ].
^summedDictionary
]

{ #category : #arithmetic }
TransitionTableGenerator2 >> addIntoGenericTransitionTableForMatches: aTransitionTable [

self genericTransitionTableForMatches addTransitionTable: aTransitionTable
]

{ #category : #generating }
TransitionTableGenerator2 >> generateGenericTransitionTableForAllMatches [

self genericTransitionTableForMatches: GenericTransitionTable new.	

MatchStateEnumerator new allMatchesDo: [ :eachMatchState |
	| eachGenericTransitionTableForMatch |
	eachGenericTransitionTableForMatch := (self class new matchState: eachMatchState)
		generateInstanceTransitionTableForMatch generateGenericTransitionTableForMatch genericTransitionTableForMatch.
	self addIntoGenericTransitionTableForMatches: eachGenericTransitionTableForMatch ].


self genericTransitionTableForMatches normalise
]

{ #category : #generating }
TransitionTableGenerator2 >> generateGenericTransitionTableForMatch [

self genericTransitionTableForMatch: GenericTransitionTable new.	
	
self instanceTransitionTableForMatch transitionsDo: [ :eachInstanceTransition |
		self genericTransitionTableForMatch addInstanceTransition: eachInstanceTransition ].

self instanceTransitionTableForMatch normalise
]

{ #category : #generating }
TransitionTableGenerator2 >> generateInstanceTransitionTableForMatch [
| thisPseudoRod nextPseudoRod |

self instanceTransitionTableForMatch: InstanceTransitionTable new.	

nextPseudoRod := self matchState matchplayEvents first nextControlledPossessionEvent.
[	thisPseudoRod := nextPseudoRod.
	nextPseudoRod := thisPseudoRod nextControlledPossessionEvent.
	nextPseudoRod notNil ] whileTrue: [
		| transition |
		transition := InstanceTransition fromEvent: thisPseudoRod toEvent: nextPseudoRod.
		transition isSelfTransition ifFalse: [
			self instanceTransitionTableForMatch addTransition: transition ]].

self instanceTransitionTableForMatch normalise
]

{ #category : #accessing }
TransitionTableGenerator2 >> genericTransitionTableForMatch [

	^ genericTransitionTableForMatch
]

{ #category : #accessing }
TransitionTableGenerator2 >> genericTransitionTableForMatch: anObject [

	genericTransitionTableForMatch := anObject
]

{ #category : #accessing }
TransitionTableGenerator2 >> genericTransitionTableForMatches [

	^ genericTransitionTableForMatches
]

{ #category : #accessing }
TransitionTableGenerator2 >> genericTransitionTableForMatches: anObject [

	genericTransitionTableForMatches := anObject
]

{ #category : #initializing }
TransitionTableGenerator2 >> initialize [ 

]

{ #category : #accessing }
TransitionTableGenerator2 >> instanceTransitionTableForMatch [

	^ instanceTransitionTableForMatch
]

{ #category : #accessing }
TransitionTableGenerator2 >> instanceTransitionTableForMatch: anObject [

	instanceTransitionTableForMatch := anObject
]

{ #category : #accessing }
TransitionTableGenerator2 >> matchState [

	^ matchState
]

{ #category : #accessing }
TransitionTableGenerator2 >> matchState: anObject [

	matchState := anObject
]

{ #category : #arithmetic }
TransitionTableGenerator2 >> transitionTable: aTransitionTable plusTransitionTable: anotherTransitionTable [
| summedTransitionTable |

aTransitionTable ifNil: [ ^anotherTransitionTable veryDeepCopy ].

summedTransitionTable := OrderedDictionary new.
aTransitionTable keysAndValuesDo: [ :thisKey :dictionary |
	summedTransitionTable
		at: thisKey 
		put: (	self
			addDictionary: dictionary
			to: (anotherTransitionTable at: thisKey ifAbsent: [ OrderedDictionary new ])) ].
^summedTransitionTable
]
