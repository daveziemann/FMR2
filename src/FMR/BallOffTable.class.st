Class {
	#name : #BallOffTable,
	#superclass : #MatchplayEvent,
	#category : #FMR
}

{ #category : #accessing }
BallOffTable class >> representation [ 
^$^
]

{ #category : #'UI - graphics' }
BallOffTable >> boxColour [
"Answer the colour for the box, generally the colour of the owning event, except all pauses are neutral"

^FMRColour neutralColour
]

{ #category : #'UI - graphics' }
BallOffTable >> explainEvent [
^self teamWithOwnership teamName,' shot the ball off the table from their ',self latestRodOfPossession printRod
]

{ #category : #access }
BallOffTable >> reasonableMaximumDuration [
^1 minute
]

{ #category : #'UI - graphics' }
BallOffTable >> shouldShowLine [
^true
]
