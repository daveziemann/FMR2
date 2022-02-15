"
A MatchStateTest is a test class for testing the behavior of MatchState
"
Class {
	#name : #MatchStateTest,
	#superclass : #FMRTestCase,
	#category : #'FMR-Tests'
}

{ #category : #tests }
MatchStateTest >> testCreation [
| ms |
ms := self matchState.
self assert: ms matchplayEvents size equals: 414.
self assert: ms numberOfGames equals: 5.
]

{ #category : #tests }
MatchStateTest >> testDateValidation [
| sameDateStrings sameDates someNonDateStrings sameNonDates |

sameDateStrings := #('1Feb2021' '1-2-2021' '1-FEB-2021' '1 2 2021' '01.02.2021').
sameDates := sameDateStrings collect: [ :e | MatchState dateFromDayMonthYear: e ].
sameDates do: [ :e | self assert: e class equals: Date ].
self assert: sameDates asSet size equals: 1.

someNonDateStrings := #('1Feb201' '1-2' 'FEB-2021' '2021' '111.02.2021').
sameNonDates := someNonDateStrings collect: [ :e | MatchState dateFromDayMonthYear: e ].
sameNonDates do: [ :e | self assert: e equals: nil ]
]
