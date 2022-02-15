Class {
	#name : #DeadBall,
	#superclass : #MatchplayEvent,
	#category : #FMR
}

{ #category : #accessing }
DeadBall class >> representation [ 
^$_
]

{ #category : #'UI - graphics' }
DeadBall >> boxColour [
"Answer the colour for the box, generally the colour of the owning event, except all pauses are neutral"

^FMRColour neutralColour
]

{ #category : #'UI - graphics' }
DeadBall >> explainEvent [
^'The ball went dead between the rods'
]

{ #category : #access }
DeadBall >> reasonableMaximumDuration [
^10 seconds
]

{ #category : #'UI - graphics' }
DeadBall >> shouldShowLine [
^true
]
