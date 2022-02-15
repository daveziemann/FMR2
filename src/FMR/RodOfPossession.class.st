Class {
	#name : #RodOfPossession,
	#superclass : #PseudoRod,
	#category : #FMR
}

{ #category : #printing }
RodOfPossession class >> printPseudoRod [
^self printRod
]

{ #category : #printing }
RodOfPossession class >> printRod [
^self representation asString,'-rod' 
]

{ #category : #'UI - graphics' }
RodOfPossession >> explainEvent [
^'The ball is on ',self teamWithOwnership teamName,'''s ',self printRod
]

{ #category : #testing }
RodOfPossession >> isActivePlay [
^true
]

{ #category : #access }
RodOfPossession >> isControlledPossessionEvent [
"Answer if I am a controlled possession event; this includes being in the Goal"

^self durationOrZero >= StatisticsGenerator minimumDurationForControlledPossession
]

{ #category : #testing }
RodOfPossession >> isRod [
^true

]

{ #category : #printing }
RodOfPossession >> printRod [
^self class printRod
]

{ #category : #access }
RodOfPossession >> timeLimit [
"Answer the maximum duration allowed for this event in the rules"

^self subclassResponsibility 
]
