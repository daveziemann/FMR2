Class {
	#name : #PSMatchResult,
	#superclass : #PSResult,
	#category : #FMR
}

{ #category : #testing }
PSMatchResult >> isBoring [
^self result isCollection
	ifTrue: [ self result last isZero ]
	ifFalse: [ self result isZero ]
]

{ #category : #printing }
PSMatchResult >> printAsRatioAndPercentage [
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
PSMatchResult >> printOn: aStream [
| gameOrMatch |
gameOrMatch := { 'G',self gameNumber asString . 'M' } at: self gameNumber isZero asBit + 1.
aStream << gameOrMatch; <<': '; << self result asString
]
