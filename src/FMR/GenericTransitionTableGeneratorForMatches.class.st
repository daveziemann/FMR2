Class {
	#name : #GenericTransitionTableGeneratorForMatches,
	#superclass : #GenericTransitionTableGenerator,
	#category : #FMR
}

{ #category : #generating }
GenericTransitionTableGeneratorForMatches >> generateTransitionTable [

self transitionTable: GenericTransitionTable new populate.	

MatchStateEnumerator new allMatchesDo: [ :eachMatchState |
	| eachTransitionTable |
	eachTransitionTable := (GenericTransitionTableGenerator new matchState: eachMatchState) generateTransitionTable transitionTable.
	self transitionTable addTransitionTable: eachTransitionTable ].

self transitionTable normalise
]
