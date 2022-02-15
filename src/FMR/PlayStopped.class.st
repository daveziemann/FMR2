Class {
	#name : #PlayStopped,
	#superclass : #MatchplayEvent,
	#category : #FMR
}

{ #category : #accessing }
PlayStopped class >> representation [ 
^$s
]

{ #category : #'UI - graphics' }
PlayStopped >> boxColour [
"Answer the colour for the box, generally the colour of the owning event, except all pauses are neutral"

^FMRColour neutralColour
]

{ #category : #printing }
PlayStopped >> colour [

^FMRColour neutralColour
]

{ #category : #'UI - graphics' }
PlayStopped >> explainEvent [
^'There was a stoppage of play'
]

{ #category : #access }
PlayStopped >> reasonableMaximumDuration [
^30 seconds
]
