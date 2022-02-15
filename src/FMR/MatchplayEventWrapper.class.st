Class {
	#name : #MatchplayEventWrapper,
	#superclass : #FMRObject,
	#instVars : [
		'matchplayEvent'
	],
	#category : #FMR
}

{ #category : #accessing }
MatchplayEventWrapper >> matchplayEvent [

	^ matchplayEvent
]

{ #category : #accessing }
MatchplayEventWrapper >> matchplayEvent: anObject [

	matchplayEvent := anObject
]
