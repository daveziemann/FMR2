Class {
	#name : #'PresentableTeamStatistic_',
	#superclass : #'PresentableStatistic_',
	#instVars : [
		'teamNumber'
	],
	#category : #FMR
}

{ #category : #testing }
PresentableTeamStatistic_ class >> isTeamStatistic [
^true
]

{ #category : #'meta stats' }
PresentableTeamStatistic_ class >> metaAverage [
| c ps |

c := OrderedCollection new.
MatchStateEnumerator new allCompletedStandardMatchesDo: [ :eachMatchState |
	ps := (self new matchState: eachMatchState) generate.
	c add: (ps getResultForGame: 0 teamNumber: 1).
	c add: (ps getResultForGame: 0 teamNumber: 2) ].
^(c collect:[:e | e singletonValue ]) average
]

{ #category : #enumerating }
PresentableTeamStatistic_ >> allConfigurationsDo: aBlock [
^self allGamesDo: [ self bothTeamsDo: aBlock ]
]

{ #category : #UI }
PresentableTeamStatistic_ >> asString [
^String streamContents: [ :s | s
	<< self statisticCategory;
	cr;
	<< ' for ';
	<< self thisTeamName;
	cr;
	<< ' on the ';
	<< self statisticGroup;
	<< ' in ';
	<< self printGameOrMatch;
	cr;
	<< ' was ';
	<< self displayResultForTeamAndGame ]
	
]

{ #category : #UI }
PresentableTeamStatistic_ >> bestTeam [
"Answer the best team for this statistic for the whole match"

^self getResultForMatch teamWithLargestValue
]

{ #category : #enumerating }
PresentableTeamStatistic_ >> bothTeamsDo: aBlock [
#(1 2) do: [ :eachTeamNumber |
	self teamNumber: eachTeamNumber.
	aBlock value ]
]

{ #category : #generation }
PresentableTeamStatistic_ >> computeResult [
self scanner scan.
^self extractScannerResult
]

{ #category : #generation }
PresentableTeamStatistic_ >> computeResultForGameNumber: aGameNumber teamNumber: aTeamNumber [

self scanner gameNumber: aGameNumber.
self scanner teamNumber: aTeamNumber.

^PSTeamResult new
	gameNumber: aGameNumber;
	teamNumber: aTeamNumber;
	result: self computeResult;
	yourself
]

{ #category : #UI }
PresentableTeamStatistic_ >> displayResultForTeam: eachTeamNumber inGame: eachGameNumber [ 

^self displayResult: ((self getResultForGame: eachGameNumber) atTeamNumber: eachTeamNumber)
]

{ #category : #UI }
PresentableTeamStatistic_ >> displayResultForTeamAndGame [
^self displayResult: self getResult
]

{ #category : #'UI - delta' }
PresentableTeamStatistic_ >> displayResultForWithDeltaTeamAndGame [
^self displayResultForTeamAndGame,self printDelta
]

{ #category : #generation }
PresentableTeamStatistic_ >> extractScannerResult [

^nil
]

{ #category : #generation }
PresentableTeamStatistic_ >> generateForGame: aGameNumber [
| resultTeam1 resultTeam2 results |

resultTeam1 := self computeResultForGameNumber: aGameNumber teamNumber: 1.
resultTeam2 := self computeResultForGameNumber: aGameNumber teamNumber: 2.
results := self shouldReverseTeamResults ifTrue: [ {resultTeam2.resultTeam1} ] ifFalse: [ {resultTeam1.resultTeam2} ].
^(PSTeamsResult new statistic: self)
	gameNumber: aGameNumber;
	result: results
	
]

{ #category : #'UI - delta' }
PresentableTeamStatistic_ >> getDelta [
"Assume "

^(self rawDelta * 100) rounded
]

{ #category : #'UI - delta' }
PresentableTeamStatistic_ >> getMeanResultForGamesUpTo: aGameNumber [
| results |

self gameNumber isZero ifTrue: [ ^0 ].

results := (1 to: aGameNumber)
	collect: [ :eachGameNumber | self getResultForGame: eachGameNumber teamNumber: self teamNumber ].
^self mean: results 
	
]

{ #category : #'UI - delta' }
PresentableTeamStatistic_ >> getMeanResultForPreviousGames [
^self getMeanResultForGamesUpTo: self gameNumber - 1
	
]

{ #category : #'UI - delta' }
PresentableTeamStatistic_ >> getMeanResultForThisAndPreviousGames [
^self getMeanResultForGamesUpTo: self gameNumber
	
]

{ #category : #access }
PresentableTeamStatistic_ >> getResult [
"get the result for the game and team configured in the receiver"

^(self getResultForGame: self gameNumber) atTeamNumber: self teamNumber
]

{ #category : #access }
PresentableTeamStatistic_ >> getResultForGame: eachGameNumber teamNumber: eachTeamNumber [
^(self getResultForGame: eachGameNumber) atTeamNumber: eachTeamNumber
]

{ #category : #access }
PresentableTeamStatistic_ >> getResultForOtherTeamAndGame [

^(self getResultForGame: self gameNumber) atTeamNumber: 3-self teamNumber
]

{ #category : #UI }
PresentableTeamStatistic_ >> otherTeamName [
^(self matchState teams at: 3-self teamNumber) teamName
]

{ #category : #'UI - delta' }
PresentableTeamStatistic_ >> printDelta [
self gameNumber < 2 ifTrue: [ ^'' ].
^self getDelta in: [ :delta |
	delta isZero
		ifTrue: [ ' (=)' ]
		ifFalse: [ ' (',('-=+' at: delta sign + 2) asString,delta abs asString,'pp)' ]]

]

{ #category : #'UI - delta' }
PresentableTeamStatistic_ >> printDeltaText [
^String streamContents: [ :s |
	s << self getResult printRatioAsPercentage.
	self gameNumber > 1 ifTrue: [
		self getDelta in: [ :delta |
			delta abs < 2 ifTrue: [ s << ', which is similar to their previous average' ].
			delta > 1 ifTrue: [ s << ', which is '; << delta asString; << ' percentage points higher than their previous average' ].
			delta < -1 ifTrue: [ s << ', which is '; << delta abs asString; << ' percentage points lower than their previous average' ]]]]
			
]

{ #category : #'UI - delta' }
PresentableTeamStatistic_ >> rawDelta [
"Zero delta for first game or entire match"

^self gameNumber < 2
	ifTrue: [ 0 ]
	ifFalse: [ self getResult singletonValue - self getMeanResultForPreviousGames ]
]

{ #category : #UI }
PresentableTeamStatistic_ >> rods [
"extract the primary rod or rods from the first sequence
	- using this method assumes that the rods in the first sequence are the same as in the others"

^((self sequences first tokensBasedOn: '|') collect: [ :ee | ee asInteger ]) reject: [ :e | e isNil ]
]

{ #category : #generation }
PresentableTeamStatistic_ >> shouldReverseTeamResults [
"Some statistics are computed from the perspective of the other team, in which case the order of the reults must be reversed"

^false
]

{ #category : #UI }
PresentableTeamStatistic_ >> statisticGroup [
| rods |
rods := self shouldReverseTeamResults ifTrue: [ self rods reversed ] ifFalse: [ self rods ].
rods isEmpty ifTrue: [ ^'Team' ].
^rods first asString,'-rod'
]

{ #category : #UI }
PresentableTeamStatistic_ >> teamIDBalloonText [
^self expandMacros: 'This statsitic row is for the team of <tt>.'
]

{ #category : #accessing }
PresentableTeamStatistic_ >> teamNumber [

	^ teamNumber
]

{ #category : #accessing }
PresentableTeamStatistic_ >> teamNumber: anObject [

	teamNumber := anObject
]

{ #category : #UI }
PresentableTeamStatistic_ >> thisTeamName [
^(self matchState teams at: self teamNumber) teamName
]

{ #category : #generation }
PresentableTeamStatistic_ >> trawlForWinCorrelation [
"Generate the statistic and answer if the winning team had the higher value"

| winningTeamNumber winningTeamResult losingTeamResult |

self generate.
winningTeamNumber := self matchState teamThatWonGame: 0.
winningTeamResult := self getResultForGame: 0 teamNumber: winningTeamNumber.
losingTeamResult := self getResultForGame: 0 teamNumber: 3-winningTeamNumber.
^winningTeamResult singletonValue > losingTeamResult singletonValue

]
