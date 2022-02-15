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
PseudoRod >> rduFromGoal: aGoal [
"The ball does not travel from the goal to any rod"

^0
]

{ #category : #access }
PseudoRod >> rduToRodOrGoal: anotherRodOrGoal [
^self subclassResponsibility 
]
