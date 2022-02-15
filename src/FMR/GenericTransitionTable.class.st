Class {
	#name : #GenericTransitionTable,
	#superclass : #FMRTransitionTable,
	#category : #FMR
}

{ #category : #adding }
GenericTransitionTable >> addInstanceTransition: anInstanceTransition [

self addTransition: anInstanceTransition genericTransition
]

{ #category : #access }
GenericTransitionTable >> fromTeams [
^#(#eitherTeam)
]

{ #category : #access }
GenericTransitionTable >> toTeams [
^#(#sameTeam #otherTeam)
]

{ #category : #'instance creation' }
GenericTransitionTable >> transitionClass [
^GenericTransition
]
