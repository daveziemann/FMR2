Class {
	#name : #SwapPositions,
	#superclass : #TeamEvent,
	#category : #FMR
}

{ #category : #accessing }
SwapPositions class >> representation [ 
^$:
]

{ #category : #'UI - graphics' }
SwapPositions >> explainEvent [
^self teamWithOwnership teamName,' swapped positions'
]

{ #category : #testing }
SwapPositions >> isDurationRecordingEvent [
"Most actual matchplay events record their duration"

^false
]
