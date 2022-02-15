Class {
	#name : #GenericTransitionTableGenerator,
	#superclass : #TransitionTableGenerator,
	#category : #FMR
}

{ #category : #generating }
GenericTransitionTableGenerator >> generateTransitionTable [

self transitionTable: (GenericTransitionTable new matchState: self matchState) populate.
	
self instanceTransitionTable transitionsDo: [ :eachInstanceTransition |
		self transitionTable addInstanceTransition: eachInstanceTransition ].

self transitionTable normalise
]

{ #category : #generating }
GenericTransitionTableGenerator >> instanceTransitionTable [
^(InstanceTransitionTableGenerator new matchState: self matchState) generateTransitionTable transitionTable
]
