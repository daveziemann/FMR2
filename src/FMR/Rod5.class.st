Class {
	#name : #Rod5,
	#superclass : #RodOfPossession,
	#category : #FMR
}

{ #category : #accessing }
Rod5 class >> representation [ 
^$5
]

{ #category : #access }
Rod5 >> rduFrom2Rod: a2Rod [
^self teamWithPossession = a2Rod teamWithPossession
	ifTrue: [ 2 ]
	ifFalse: [ 3 ]
]

{ #category : #access }
Rod5 >> rduFrom3Rod: a3Rod [
^self teamWithPossession = a3Rod teamWithPossession
	ifTrue: [ 2 ]
	ifFalse: [ 1 ]
]

{ #category : #access }
Rod5 >> rduFrom5Rod: a5Rod [
^self teamWithPossession = a5Rod teamWithPossession
	ifTrue: [ 0 ]
	ifFalse: [ 1 ]
]

{ #category : #access }
Rod5 >> rduFromGoal: aGoal [
^(self teamWithPossession = aGoal teamWithPossession
	ifTrue: [ 4 ]
	ifFalse: [ 3 ]) + aGoal goalOffsetFraction
]

{ #category : #access }
Rod5 >> rduToRodOrGoal: anotherRodOrGoal [
^anotherRodOrGoal rduFrom5Rod: self
]

{ #category : #access }
Rod5 >> reasonableMaximumDuration [
^self timeLimit
]

{ #category : #access }
Rod5 >> timeLimit [
"Answer the maximum duration allowed for this event in the rules"

^10 seconds
]
