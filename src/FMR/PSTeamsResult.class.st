Class {
	#name : #PSTeamsResult,
	#superclass : #PSResult,
	#category : #FMR
}

{ #category : #arithmetic }
PSTeamsResult class >> newFrom: aTeamsResult plus: anotherTeamsResult [
^aTeamsResult copy
	gameNumber: (aTeamsResult gameNumber max: anotherTeamsResult gameNumber);
	result: (aTeamsResult result + anotherTeamsResult result)
	
]

{ #category : #arithmetic }
PSTeamsResult >> + anotherTeamsResult [
^self class newFrom: self plus: anotherTeamsResult
	
]

{ #category : #access }
PSTeamsResult >> atTeamNumber: aTeamNumber [
^self result at: aTeamNumber
]

{ #category : #arithmetic }
PSTeamsResult >> delta: anotherTeamsResult [
^{self result first delta: anotherTeamsResult result first
.
self result second delta: anotherTeamsResult result second}
]

{ #category : #testing }
PSTeamsResult >> isBoring [
^self result allSatisfy: [ :eachResult | eachResult isBoring ]
]

{ #category : #access }
PSTeamsResult >> largestValue [
"Answer a single numeric quantity, the largest value between the two teams"

^self result first largestValue max: self result second largestValue
]

{ #category : #arithmetic }
PSTeamsResult >> plus: anotherTeamsResult [
^self class newFrom: self plus: anotherTeamsResult
	
]

{ #category : #printing }
PSTeamsResult >> printOn: aStream [
self result first printOn: aStream.
aStream << ', '.
self result second printOn: aStream.

]

{ #category : #access }
PSTeamsResult >> teamWithLargestValue [
"Answer the team with the largest value"

^(self result first largestValue < self result second largestValue) asBit + 1
]
