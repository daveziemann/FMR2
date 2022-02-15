Class {
	#name : #PSResult,
	#superclass : #FMRStatistics,
	#instVars : [
		'statistic',
		'gameNumber',
		'result'
	],
	#category : #FMR
}

{ #category : #accessing }
PSResult >> gameNumber [

	^ gameNumber
]

{ #category : #accessing }
PSResult >> gameNumber: anObject [

	gameNumber := anObject
]

{ #category : #access }
PSResult >> largestValue [
^self singletonValue
]

{ #category : #printing }
PSResult >> prettyPrintToRoundedSeconds [
^self result prettyPrintToRoundedSeconds
]

{ #category : #access }
PSResult >> primitiveResults [
"Answer an Array of the receiver's primitive results"

^self result isCollection
	ifTrue: [ self result collect: [ :e | self primitiveResults: e ] ]
	ifFalse: [ {self primitiveResults: self result} ]
]

{ #category : #access }
PSResult >> primitiveResults: aResult [
"Answer an Array of the receiver's primitive results"
aResult class = Duration ifTrue: [ ^aResult asMilliSeconds ].
aResult isNumber ifTrue: [ ^aResult ].
^aResult primitiveResults

]

{ #category : #printing }
PSResult >> printAsPercentage [
^self result rounded asString,'%'
]

{ #category : #printing }
PSResult >> printDurationsAsRatioAndPercentage [
"self result second isZero ifTrue: [ ^'' ]."

^String streamContents: [ :s |
	s
		<< self result second prettyPrintToRoundedSeconds;
		<< ' / ';
		<< self result first prettyPrintToRoundedSeconds;	
		<< ' = ';
		<< (self ratio * 100) rounded asString;
		<< $% ]
]

{ #category : #printing }
PSResult >> printOn: aStream [
aStream << self result asString
]

{ #category : #printing }
PSResult >> printRatioAsPercentage [
^(self ratio * 100) rounded asString,'%'
]

{ #category : #printing }
PSResult >> printResult [
^self printResult: self theResult

]

{ #category : #printing }
PSResult >> printResult1 [
^self printResult: self theResult1

]

{ #category : #printing }
PSResult >> printResult2 [
^self printResult: self theResult2

]

{ #category : #printing }
PSResult >> printResult: aSingleResult [
aSingleResult isNumber ifTrue: [ ^aSingleResult asString ].
aSingleResult class = Duration ifTrue: [ ^aSingleResult prettyPrintToRoundedSeconds ].
self error: 'Ooops'
]

{ #category : #printing }
PSResult >> ratio [
^self result second divideBy: self result first
]

{ #category : #accessing }
PSResult >> result [

	^ result
]

{ #category : #accessing }
PSResult >> result: anObject [

	result := anObject
]

{ #category : #access }
PSResult >> singletonValue [
"Answer a single numeric quantity that represents the receiver"

^self result isCollection
	ifTrue: [ self ratio ]
	ifFalse: [ self result ]
]

{ #category : #accessing }
PSResult >> statistic [

	^ statistic
]

{ #category : #accessing }
PSResult >> statistic: anObject [

	statistic := anObject
]

{ #category : #printing }
PSResult >> theResult [
^self result

]

{ #category : #printing }
PSResult >> theResult1 [
^self result first

]

{ #category : #printing }
PSResult >> theResult2 [
^self result second

]
