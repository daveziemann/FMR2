"
A MatchplayEventTest is a test class for testing the behavior of MatchplayEvent
"
Class {
	#name : #MatchplayEventTest,
	#superclass : #FMRTestCase,
	#category : #'FMR-Tests'
}

{ #category : #tests }
MatchplayEventTest >> testIntegrity [
self
	assert: MatchplayEvent activeRecordingCharacters asSortedCollection
	equals: MatchplayEvent characterToClassMap keys asSortedCollection
]
