Class {
	#name : #PSTeamResult,
	#superclass : #PSResult,
	#instVars : [
		'teamNumber'
	],
	#category : #FMR
}

{ #category : #arithmetic }
PSTeamResult class >> newFrom: aTeamResult plus: anotherTeamResult [
^aTeamResult copy
	gameNumber: (aTeamResult gameNumber max: anotherTeamResult gameNumber);
	result: (aTeamResult result + anotherTeamResult result)
	
]

{ #category : #arithmetic }
PSTeamResult >> + anotherTeamResult [
^self class newFrom: self plus: anotherTeamResult
	
]

{ #category : #arithmetic }
PSTeamResult >> delta: anotherTeamResult [
"^(((anotherTeamResult singletonValue asFloat - self singletonValue) divideBy: self singletonValue) * 100) rounded"
^anotherTeamResult singletonValue asFloat - self singletonValue
]

{ #category : #testing }
PSTeamResult >> isBoring [
^self result isCollection
	ifTrue: [ self result last isZero ]
	ifFalse: [ self result isZero ]
]

{ #category : #arithmetic }
PSTeamResult >> plus: anotherTeamResult [
^self class newFrom: self plus: anotherTeamResult
	
]

{ #category : #printing }
PSTeamResult >> printAsNumber [
"^self result isZero
	ifTrue: [ '' ]
	ifFalse: [ self result asString ]"
^self result asString
]

{ #category : #printing }
PSTeamResult >> printAsRatioAndPercentage [
"self result second isZero ifTrue: [ ^'' ]."

^String streamContents: [ :s |
	s
		<< self result second asString;
		<< ' / ';
		<< self result first asString;	
		<< ' = ';
		<< self printRatioAsPercentage ]
]

{ #category : #printing }
PSTeamResult >> printOn: aStream [
| gameOrMatch |

gameOrMatch := { 'G',self gameNumber asString . 'M' } at: self gameNumber isZero asBit + 1.
aStream << gameOrMatch; << 'T'; << self teamNumber asString; << ': '; << self result asString
]

{ #category : #accessing }
PSTeamResult >> teamNumber [

	^ teamNumber
]

{ #category : #accessing }
PSTeamResult >> teamNumber: anObject [

	teamNumber := anObject
]
