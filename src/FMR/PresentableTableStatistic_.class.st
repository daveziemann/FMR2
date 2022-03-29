Class {
	#name : #'PresentableTableStatistic_',
	#superclass : #'PresentableStatistic_',
	#category : #FMR
}

{ #category : #testing }
PresentableTableStatistic_ class >> isMatchStatistic [
^true
]

{ #category : #'meta stats' }
PresentableTableStatistic_ class >> metaAverage [
| c ps |

c := OrderedCollection new.
MatchStateEnumerator new allCompletedStandardMatchesDo: [ :eachMatchState |
	ps := (self new matchState: eachMatchState) generate.
	c add: ps getResultForMatch ].
^(c collect:[:e | e singletonValue ]) average
]

{ #category : #enumerating }
PresentableTableStatistic_ >> allConfigurationsDo: aBlock [
^self allGamesDo: aBlock
]

{ #category : #generation }
PresentableTableStatistic_ >> computeResult [
^self subclassResponsibility
]

{ #category : #UI }
PresentableTableStatistic_ >> displayResultForMatchInGame: eachGameNumber [ 

^self displayResult: (self getResultForGame: eachGameNumber)
]

{ #category : #UI }
PresentableTableStatistic_ >> displayResultForTeamAndGame [

^self displayResult: (self getResultForGame: self gameNumber)
]

{ #category : #generation }
PresentableTableStatistic_ >> generateForGame: aGameNumber [
self scanner gameNumber: aGameNumber.
^self newResult
	gameNumber: aGameNumber;
	result: self computeResult
	
]

{ #category : #access }
PresentableTableStatistic_ >> getResult [
"get the result for the game configured in the receiver"

^self getResultForGame: self gameNumber
]

{ #category : #generation }
PresentableTableStatistic_ >> newResult [

^PSMatchResult new statistic: self
]

{ #category : #generation }
PresentableTableStatistic_ >> scanner_ [
^super scanner_ teamNumber: 0
]

{ #category : #UI }
PresentableTableStatistic_ >> statisticGroup [
^'Table'
]

{ #category : #UI }
PresentableTableStatistic_ >> teamIDBalloonText [
^self expandMacros: 'This statistic row is for both teams considered together.'
]

{ #category : #UI }
PresentableTableStatistic_ >> teamNumber [
^0
]

{ #category : #UI }
PresentableTableStatistic_ >> teamNumber: n [
"Swallow"
]
