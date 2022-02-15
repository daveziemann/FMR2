Class {
	#name : #InstanceTransitionTableGenerator,
	#superclass : #TransitionTableGenerator,
	#category : #FMR
}

{ #category : #generating }
InstanceTransitionTableGenerator >> generateTransitionTable [
| thisPseudoRod nextPseudoRod |

self transitionTable: (InstanceTransitionTable new matchState: self matchState) populate.

nextPseudoRod := self matchState matchplayEvents first nextControlledPossessionEvent.
[	thisPseudoRod := nextPseudoRod.
	nextPseudoRod := thisPseudoRod nextControlledPossessionEvent.
	nextPseudoRod notNil ] whileTrue: [
		| transition |
		transition := (InstanceTransition fromEvent: thisPseudoRod toEvent: nextPseudoRod)
			matchState: self transitionTable matchState;
			yourself. 
		self transitionTable addTransition: transition ].

self transitionTable normalise
]
