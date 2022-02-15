Class {
	#name : #TimeOut,
	#superclass : #TeamEvent,
	#category : #FMR
}

{ #category : #accessing }
TimeOut class >> representation [ 
^$t
]

{ #category : #'UI - graphics' }
TimeOut >> explainEvent [
^self teamWithOwnership teamName,' called a Time-out'
]

{ #category : #access }
TimeOut >> reasonableMaximumDuration [
^self timeLimit
]

{ #category : #access }
TimeOut >> timeLimit [
"Answer the maximum duration allowed for this event in the rules"

^30 seconds
]
