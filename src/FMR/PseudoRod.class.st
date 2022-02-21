Class {
	#name : #PseudoRod,
	#superclass : #MatchplayEvent,
	#category : #FMR
}

{ #category : #printing }
PseudoRod class >> printPseudoRod [
^self subclassResponsibility 
]

{ #category : #access }
PseudoRod >> distanceToRodOrGoal: anotherRodOrGoal [
^(self rduToRodOrGoal: anotherRodOrGoal) * self matchState table rduSize
]

{ #category : #testing }
PseudoRod >> isPseudoRod [
^true

]

{ #category : #access }
PseudoRod >> isUncontrolledPossessionEvent [
"Answer if I am an uncontrolled possession event"

^self isControlledPossessionEvent not
]

{ #category : #printing }
PseudoRod >> printPseudoRod [
^self class printPseudoRod
]

{ #category : #access }
PseudoRod >> pseudoRodLocation [
"Answer the displacement of the specified pseudoRod from team two's goal"

^self distanceToRodOrGoal: (Goal new
	matchState: self matchState;
	teamWithPossession_: self matchState teamTwo;
	yourself)
]

{ #category : #access }
PseudoRod >> rduFromGoal: aGoal [
^self subclassResponsibility 
]

{ #category : #access }
PseudoRod >> rduToRodOrGoal: anotherRodOrGoal [
^self subclassResponsibility 
]

{ #category : #access }
PseudoRod >> travelDistanceToRodOrGoal: anotherRodOrGoal [
^(self rduToRodOrGoal: anotherRodOrGoal) * self matchState table rduSize
]
