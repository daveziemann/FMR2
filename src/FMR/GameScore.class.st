Class {
	#name : #GameScore,
	#superclass : #FMRStatistics,
	#instVars : [
		'gameNumber',
		'matchScore',
		'pointScore'
	],
	#category : #FMR
}

{ #category : #printing }
GameScore >> asText [
| colour |

colour := self matchScore matchState colourForTeam: self currentlyWinningTeam inGame: self gameNumber.
^self asString asText addAttribute: (TextColor color: colour)
]

{ #category : #printing }
GameScore >> closeIndicator [
^self isComplete ifTrue: [ $] ] ifFalse: [ $) ]
]

{ #category : #access }
GameScore >> currentlyWinningTeam [
"Answer the index of the team that's currently winning this game, or 0 if drawn"

self pointScore first > self pointScore second ifTrue: [ ^1 ].
self pointScore first < self pointScore second ifTrue: [ ^2 ].
^0
]

{ #category : #accessing }
GameScore >> gameNumber [

	^ gameNumber
]

{ #category : #accessing }
GameScore >> gameNumber: anObject [

	gameNumber := anObject
]

{ #category : #scoring }
GameScore >> goalScoredByTeam: n [
self pointScore at: n put: (self pointScore at: n) + 1
]

{ #category : #initialization }
GameScore >> initialize [ 
self pointScore: (OrderedCollection new: 2 withAll: 0)
]

{ #category : #testing }
GameScore >> isComplete [
"Answer if I represent the score in a complete game
	- I am complete if I am not the current game"

^self ~~ self matchScore gameScores last
]

{ #category : #accessing }
GameScore >> matchScore [

	^ matchScore
]

{ #category : #accessing }
GameScore >> matchScore: anObject [

	matchScore := anObject
]

{ #category : #access }
GameScore >> maximum [ 
^self pointScore max
]

{ #category : #access }
GameScore >> numberOfGoalsScored [
"Answer the total number of goals scored at this point in the match"

^self pointScore sumNumbers
]

{ #category : #printing }
GameScore >> openIndicator [
^self isComplete ifTrue: [ $[ ] ifFalse: [ $( ]
]

{ #category : #accessing }
GameScore >> pointScore [

	^ pointScore
]

{ #category : #accessing }
GameScore >> pointScore: anObject [

	pointScore := anObject
]

{ #category : #printing }
GameScore >> printOn: aStream [

aStream
	<< self openIndicator;
	<< self printPointScore;
	<< self closeIndicator
]

{ #category : #printing }
GameScore >> printPointScore [

^self pointScore first asString,'-',self pointScore second asString
]

{ #category : #accessing }
GameScore >> team1Score [
^self pointScore first
]

{ #category : #accessing }
GameScore >> team2Score [
^self pointScore second
]
