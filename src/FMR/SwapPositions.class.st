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
^self teamWithOwnership
	in: [ :team |
		team teamName,' swapped positions (',self forwardPlayer,' is now forward)' ]
]

{ #category : #testing }
SwapPositions >> isDurationRecordingEvent [
"Most actual matchplay events record their duration"

^false
]

{ #category : #testing }
SwapPositions >> isPositionSwap [
^true
]
