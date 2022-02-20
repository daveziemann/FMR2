Class {
	#name : #FMRTransition,
	#superclass : #FMRStatistics,
	#instVars : [
		'matchState',
		'fromRod',
		'toRod',
		'fromRodTally',
		'transitionTally',
		'transitionProbability'
	],
	#category : #FMR
}

{ #category : #'instance creation' }
FMRTransition class >> fromRod: fromAssociation toRod: toAssociation [
^self new
	fromRod: fromAssociation;
	toRod: toAssociation;
	transitionTally: 0;
	yourself
]

{ #category : #arithmetic }
FMRTransition >> addToTally: aNumber [
self transitionTally: self transitionTally + aNumber
]

{ #category : #accessing }
FMRTransition >> fromRod [

	^ fromRod
]

{ #category : #accessing }
FMRTransition >> fromRod: anObject [

	fromRod := anObject
]

{ #category : #accessing }
FMRTransition >> fromRodTally [

	^ fromRodTally
]

{ #category : #accessing }
FMRTransition >> fromRodTally: anObject [

	fromRodTally := anObject
]

{ #category : #testing }
FMRTransition >> isSameTeamTransition [
"Answer if the transition is between rods of the same team"

^self fromRod key = self toRod key
]

{ #category : #testing }
FMRTransition >> isSelfTransition [
"Answer if the transition is from one rod of one team to the same rod of the same team
	- this happens when there is an active play time-out or a Ball off table,
		or when an intervening uncontrolled possession has been skipped"

^self fromRod = self toRod
]

{ #category : #accessing }
FMRTransition >> matchState [

	^ matchState
]

{ #category : #accessing }
FMRTransition >> matchState: anObject [

	matchState := anObject
]

{ #category : #printing }
FMRTransition >> printOn: aStream [
self subclassResponsibility 
]

{ #category : #accessing }
FMRTransition >> toRod [

	^ toRod
]

{ #category : #accessing }
FMRTransition >> toRod: anObject [

	toRod := anObject
]

{ #category : #accessing }
FMRTransition >> transitionProbability [

	^ transitionProbability
]

{ #category : #accessing }
FMRTransition >> transitionProbability: anObject [

	transitionProbability := anObject
]

{ #category : #accessing }
FMRTransition >> transitionTally [

	^ transitionTally
]

{ #category : #accessing }
FMRTransition >> transitionTally: anObject [

	transitionTally := anObject
]

{ #category : #arithmetic }
FMRTransition >> transitionTallyNonSelf [
^self isSelfTransition
	ifTrue: [ 0 ]
	ifFalse: [ self transitionTally ]
]
