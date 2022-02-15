Class {
	#name : #MatchScore,
	#superclass : #FMRStatistics,
	#instVars : [
		'matchState',
		'gameScores'
	],
	#category : #FMR
}

{ #category : #scoring }
MatchScore >> completedGameScores [
"Every time a game ends a new game score is added"

^self gameScores allButLast 
]

{ #category : #scoring }
MatchScore >> completedGameScoresByTeam [

^Array
	with: (self gameScores allButLast select: [ :e | e pointScore first > e pointScore second ])
	with: 	(self gameScores allButLast select: [ :e | e pointScore first < e pointScore second ])
]

{ #category : #scoring }
MatchScore >> completedMatchScore [

^self completedGameScoresByTeam collect: [ :e | e size ]
]

{ #category : #scoring }
MatchScore >> currentGameScore [

^self gameScores last 
]

{ #category : #scoring }
MatchScore >> currentlyWinningTeam [
"Answer the index of the team that's currently winning the match, or 0 if drawn"

| cgs |
cgs := self completedGameScoresByTeam.
cgs first size > cgs second size ifTrue: [ ^1 ].
cgs first size < cgs second size ifTrue: [ ^2 ].
^self currentGameScore currentlyWinningTeam
]

{ #category : #accessing }
MatchScore >> gameScores [

	^ gameScores
]

{ #category : #accessing }
MatchScore >> gameScores: anObject [

	gameScores := anObject
]

{ #category : #scoring }
MatchScore >> goalScoredByTeam: n [
self currentGameScore goalScoredByTeam: n
]

{ #category : #initialization }
MatchScore >> initialize [ 
self gameScores: (OrderedCollection new: 5).
self newGame.
]

{ #category : #scoring }
MatchScore >> lastCompletedGameScore [

^self gameScores reversed
	detect: [ :eachGameScore | eachGameScore isComplete ]
	ifFound: [ :eachGameScore | ^eachGameScore ]
]

{ #category : #accessing }
MatchScore >> matchState [

	^ matchState
]

{ #category : #accessing }
MatchScore >> matchState: anObject [

	matchState := anObject
]

{ #category : #'instance creation' }
MatchScore >> newGame [

self gameScores add: (GameScore new
	gameNumber: self gameScores size + 1;
	matchScore: self) 
]

{ #category : #scoring }
MatchScore >> numberOfGamesCompleted [

^self gameScores size - 1
]

{ #category : #scoring }
MatchScore >> numberOfGoalsScored [
"Answer the total number of goals scored at this point in the match"

^self gameScores inject: 0 into: [ :c :e| c + e numberOfGoalsScored ]
]

{ #category : #printing }
MatchScore >> printCompletedGameScores [

^Text streamContents: [ :s |
	self completedGameScores
		do: [ :eachGameScore | s << eachGameScore asText ]
		separatedBy: [ s << $, ]]
]

{ #category : #printing }
MatchScore >> printCompletedMatchScore [

^String streamContents: [ :s |
	self completedMatchScore
		do: [ :e | s << e asString ]
		separatedBy: [ s << $- ]]
]

{ #category : #printing }
MatchScore >> printCompletedMatchScoreFromWinnersPerspective [
"Print the match result with the winner's game count first"

^String streamContents: [ :s |
	self completedMatchScore asSortedCollection reversed
		do: [ :e | s << e asString ]
		separatedBy: [ s << $- ]]
]

{ #category : #printing }
MatchScore >> printOn: aStream [

self gameScores
	do: [ :eachGameScore | aStream << eachGameScore asString ]
	separatedBy: [ aStream << $, ]
]
