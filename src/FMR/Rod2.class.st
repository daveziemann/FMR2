Class {
	#name : #Rod2,
	#superclass : #RodOfPossession,
	#category : #FMR
}

{ #category : #accessing }
Rod2 class >> representation [ 
^$2
]

{ #category : #access }
Rod2 >> rduFrom2Rod: a2Rod [
^self teamWithPossession = a2Rod teamWithPossession
	ifTrue: [ 0 ]
	ifFalse: [ 5 ]
]

{ #category : #access }
Rod2 >> rduFrom3Rod: a3Rod [
^self teamWithPossession = a3Rod teamWithPossession
	ifTrue: [ 4 ]
	ifFalse: [ 1 ]
]

{ #category : #access }
Rod2 >> rduFrom5Rod: a5Rod [
^self teamWithPossession = a5Rod teamWithPossession
	ifTrue: [ 2 ]
	ifFalse: [ 3 ]
]

{ #category : #access }
Rod2 >> rduToRodOrGoal: anotherRodOrGoal [
^anotherRodOrGoal rduFrom2Rod: self
]

{ #category : #access }
Rod2 >> reasonableMaximumDuration [
^self timeLimit
]

{ #category : #access }
Rod2 >> timeLimit [
"Answer the maximum duration allowed for this event in the rules"

^15 seconds
]
