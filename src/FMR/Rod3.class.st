Class {
	#name : #Rod3,
	#superclass : #RodOfPossession,
	#category : #FMR
}

{ #category : #accessing }
Rod3 class >> representation [ 
^$3
]

{ #category : #access }
Rod3 >> rduFrom2Rod: a2Rod [
^self teamWithPossession = a2Rod teamWithPossession
	ifTrue: [ 4 ]
	ifFalse: [ 1 ]
]

{ #category : #access }
Rod3 >> rduFrom3Rod: a3Rod [
^self teamWithPossession = a3Rod teamWithPossession
	ifTrue: [ 0 ]
	ifFalse: [ 3 ]
]

{ #category : #access }
Rod3 >> rduFrom5Rod: a5Rod [
^self teamWithPossession = a5Rod teamWithPossession
	ifTrue: [ 2 ]
	ifFalse: [ 1 ]
]

{ #category : #access }
Rod3 >> rduToRodOrGoal: anotherRodOrGoal [
^anotherRodOrGoal rduFrom3Rod: self
]

{ #category : #access }
Rod3 >> reasonableMaximumDuration [
^self timeLimit
]

{ #category : #access }
Rod3 >> timeLimit [
"Answer the maximum duration allowed for this event in the rules"

^15 seconds
]
