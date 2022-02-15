Class {
	#name : #TransitionTableGenerator1,
	#superclass : #FMRStatistics,
	#instVars : [
		'matchState',
		'transitionTableForMatch',
		'unifiedTransitionTableForMatch',
		'unifiedTransitionTableForMatches'
	],
	#category : #FMR
}

{ #category : #arithmetic }
TransitionTableGenerator1 >> addDictionary: aDictionary to: anotherDictionary [
| summedDictionary |

summedDictionary := aDictionary veryDeepCopy.
anotherDictionary keysAndValuesDo: [ :key :number |
	| oldNumber |
	oldNumber := summedDictionary at: key ifAbsent: [ 0 ].	 
	summedDictionary at: key	put: oldNumber + number ].
^summedDictionary
]

{ #category : #arithmetic }
TransitionTableGenerator1 >> addIntoGenericTransitionTableForMatches: aTransitionTable [

self genericTransitionTableForMatches: (self
	transitionTable: self genericTransitionTableForMatches
	plusTransitionTable: aTransitionTable)

]

{ #category : #generating }
TransitionTableGenerator1 >> canonicaliseDictionary: aDictionary [
| canonicalDictionary |

canonicalDictionary := OrderedDictionary new.
#(1 2) do: [ :eachTeam |
	{Rod2.Rod5.Rod3.Goal}
		do: [ :eachRod |
			canonicalDictionary
				at: eachTeam->eachRod
				put: (aDictionary at: eachTeam->eachRod ifAbsent: [0]) ]].
^canonicalDictionary
		
	
]

{ #category : #generating }
TransitionTableGenerator1 >> canonicaliseForMatch: aDictionary [
| canonicalDictionary |

canonicalDictionary := OrderedDictionary new.
#(1 2) do: [ :eachTeam |
	{Rod2.Rod5.Rod3.Goal}
		do: [ :eachRod |
			canonicalDictionary
				at: eachTeam->eachRod
				put: (self canonicaliseDictionary: (aDictionary at: eachTeam->eachRod)) ]].
^canonicalDictionary
		
	
]

{ #category : #generating }
TransitionTableGenerator1 >> generateGenericTransitionTableForAllMatches [

MatchStateEnumerator new allMatchesDo: [ :eachMatchState |
	self addIntoGenericTransitionTableForMatches: (self class new matchState: eachMatchState) generateInstanceTransitionTableForMatch generateGenericTransitionTableForMatch genericTransitionTableForMatch ]


]

{ #category : #generating }
TransitionTableGenerator1 >> generateGenericTransitionTableForMatch [

self genericTransitionTableForMatch: Dictionary new.	
self instanceTransitionTableForMatch keysAndValuesDo: [ :thisKey :dictionary |
	dictionary keysAndValuesDo: [ :nextKey :tally |
		| oldTally newKeyKey thisMergedKey nextMergedKey |
		newKeyKey := #(#otherTeam #sameTeam) at: (thisKey key = nextKey key) asBit + 1.
		thisMergedKey := #anyTeam -> thisKey value.
		nextMergedKey := newKeyKey -> nextKey value.

		oldTally := (self genericTransitionTableForMatch
			at: thisMergedKey
			ifAbsentPut: [ Dictionary new ])
				at: nextMergedKey
				ifAbsent: [ 0 ].

		"Exclude transitions from #anyTeam->aRod to #sameTeam->sameRod, which are caused by time-outs or Ball off table"
		thisKey value = nextKey value & (newKeyKey = #sameTeam) ifFalse: [ 
				(self genericTransitionTableForMatch at: thisMergedKey)
					at: nextMergedKey
					put: oldTally + tally ]]]


]

{ #category : #generating }
TransitionTableGenerator1 >> generateInstanceTransitionTableForMatch [
| thisPseudoRod nextPseudoRod |
"self matchState teamOne teamName = 'Will Hawkes & Paul Martin' ifTrue:[self halt]."
self instanceTransitionTableForMatch: Dictionary new.	
nextPseudoRod := self matchState matchplayEvents first nextControlledPossessionEvent.
[	thisPseudoRod := nextPseudoRod.
	nextPseudoRod := thisPseudoRod nextControlledPossessionEvent.
	nextPseudoRod notNil ] whileTrue: [
		| thisKey nextKey transitionTally |
		thisKey := thisPseudoRod teamWithOwnershipIndex -> thisPseudoRod class.
		nextKey := nextPseudoRod teamWithOwnershipIndex -> nextPseudoRod class.
		"thisPseudoRod class==Rod2 & (nextPseudoRod class==Goal) & (thisKey key~=nextKey key) ifTrue:[self halt]."
		transitionTally := (self instanceTransitionTableForMatch at: thisKey ifAbsentPut: [ Dictionary new ]) at: nextKey ifAbsent: [ 0 ].
		(self instanceTransitionTableForMatch at: thisKey) at: nextKey put: transitionTally + 1 ].

]

{ #category : #accessing }
TransitionTableGenerator1 >> genericTransitionTableForMatch [

	^ unifiedTransitionTableForMatch
]

{ #category : #accessing }
TransitionTableGenerator1 >> genericTransitionTableForMatch: anObject [

	unifiedTransitionTableForMatch := anObject
]

{ #category : #accessing }
TransitionTableGenerator1 >> genericTransitionTableForMatches [

	^ unifiedTransitionTableForMatches
]

{ #category : #accessing }
TransitionTableGenerator1 >> genericTransitionTableForMatches: anObject [

	unifiedTransitionTableForMatches := anObject
]

{ #category : #initializing }
TransitionTableGenerator1 >> initialize [ 

]

{ #category : #accessing }
TransitionTableGenerator1 >> instanceTransitionTableForMatch [

	^ transitionTableForMatch
]

{ #category : #accessing }
TransitionTableGenerator1 >> instanceTransitionTableForMatch: anObject [

	transitionTableForMatch := anObject
]

{ #category : #accessing }
TransitionTableGenerator1 >> matchState [

	^ matchState
]

{ #category : #accessing }
TransitionTableGenerator1 >> matchState: anObject [

	matchState := anObject
]

{ #category : #arithmetic }
TransitionTableGenerator1 >> normaliseTransitionTable: aTransitionTable [
"Convert the counts into percentages"

| normalisedTransitionTable |

normalisedTransitionTable := Dictionary new.
aTransitionTable keysAndValuesDo: [ :thisKey :dictionary |
	| sum |
	sum := dictionary values sumNumbers.
	dictionary keysAndValuesDo: [ :nextKey :tally |
		(normalisedTransitionTable at: thisKey ifAbsentPut: [ Dictionary new ])
			at: nextKey put: ((tally asFloat / sum) round: 2) ]].
^normalisedTransitionTable
	
]

{ #category : #API }
TransitionTableGenerator1 >> normalisedForAllMatches [
^self normaliseTransitionTable: self genericTransitionTableForMatches
]

{ #category : #API }
TransitionTableGenerator1 >> normalisedForMatch [
^self normaliseTransitionTable: self instanceTransitionTableForMatch
]

{ #category : #arithmetic }
TransitionTableGenerator1 >> transitionTable: aTransitionTable plusTransitionTable: anotherTransitionTable [
| summedTransitionTable |

aTransitionTable ifNil: [ ^anotherTransitionTable veryDeepCopy ].

summedTransitionTable := Dictionary new.
aTransitionTable keysAndValuesDo: [ :thisKey :dictionary |
	summedTransitionTable
		at: thisKey 
		put: (	self
			addDictionary: dictionary
			to: (anotherTransitionTable at: thisKey ifAbsent: [ Dictionary new ])).
			"thisKey=(#anyTeam->Goal) ifTrue:[self assert: (summedTransitionTable at: thisKey) size=1" ].
^summedTransitionTable
]
