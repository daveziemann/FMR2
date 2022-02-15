Class {
	#name : #Referee,
	#superclass : #TeamEvent,
	#category : #FMR
}

{ #category : #accessing }
Referee class >> representation [ 
^$r
]

{ #category : #'UI - graphics' }
Referee >> explainEvent [
^self teamWithOwnership teamName,' called a referee'
]

{ #category : #access }
Referee >> reasonableMaximumDuration [
^2 minutes
]
