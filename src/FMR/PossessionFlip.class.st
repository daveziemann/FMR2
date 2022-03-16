Class {
	#name : #PossessionFlip,
	#superclass : #MatchplayEvent,
	#category : #FMR
}

{ #category : #accessing }
PossessionFlip class >> representation [ 
^$.
]

{ #category : #printing }
PossessionFlip >> colour [ 

^self sideWithPossession colour 
]

{ #category : #'UI - graphics' }
PossessionFlip >> explainEvent [
^'The team with possession changed to ',self teamWithOwnership teamName
]

{ #category : #testing }
PossessionFlip >> isActivePlay [
^true
]

{ #category : #testing }
PossessionFlip >> isPossessionFlip [

^true
]

{ #category : #printing }
PossessionFlip >> printDurationToS [
"It's prettier if the Possession Flip does not show a time unless it exceeds a certain value
	- use 1000ms to avoid seeing .{0s} in the Recording Output Field"

^(self duration notNil and: [ self duration >= 1000 ])
	ifTrue: [ super printDurationToS ]
	ifFalse: [ '' ]
]

{ #category : #access }
PossessionFlip >> reasonableMaximumDuration [
^4 seconds
]
