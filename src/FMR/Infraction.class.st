Class {
	#name : #Infraction,
	#superclass : #TeamEvent,
	#category : #FMR
}

{ #category : #accessing }
Infraction class >> representation [ 
^$!
]

{ #category : #'UI - graphics' }
Infraction >> explainEvent [
^'There was a rule infraction by ',self teamWithOwnership teamName 
]

{ #category : #access }
Infraction >> reasonableMaximumDuration [
^30 seconds
]
