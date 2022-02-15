Class {
	#name : #SwapSides,
	#superclass : #MatchplayEvent,
	#category : #FMR
}

{ #category : #printing }
SwapSides >> colour [

^FMRColour neutralColour
]

{ #category : #'UI - graphics' }
SwapSides >> explainEvent [
^'The two teams swapped table sides'
]

{ #category : #access }
SwapSides >> isDurationRecordingEvent [
"Most actual matchplay events record their duration"

^false
]

{ #category : #testing }
SwapSides >> isSideSwap [
^true
]

{ #category : #printing }
SwapSides >> printRep [
^'<>'

]

{ #category : #'UI - graphics' }
SwapSides >> shouldShowLine [
^true
]
