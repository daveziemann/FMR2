Class {
	#name : #EndMatch,
	#superclass : #MatchplayEvent,
	#category : #FMR
}

{ #category : #accessing }
EndMatch class >> representation [ 
^'//'
]

{ #category : #'UI - graphics' }
EndMatch >> explainEvent [
^'The end of the match'
]

{ #category : #access }
EndMatch >> gameNumber [ 
"Answer the number of the game that the receiver is in, or 0 if the event is not in any game, e.g. a command"

^super gameNumber - 1
]

{ #category : #testing }
EndMatch >> isBold [
"Answer if the event should be displayed using bold font"
^true
]

{ #category : #testing }
EndMatch >> isEndMatch [
^true
]

{ #category : #testing }
EndMatch >> isEndOfMatch [
"Answer true if we can infer from the receiver that the match is over"

^true
]

{ #category : #action }
EndMatch >> prepareToAdd [
"Let the receiver have something to say before being added to the collection of events"

"If the preceding event is not an EndGame event, then add one first"
self matchState latestMatchplayEvent ifNotNil: [ :latestMatchplayEvent |
	latestMatchplayEvent isEndGame ifFalse: [
		self matchState addMatchplayEvent: (EndGame new matchState: self matchState) ]]
]

{ #category : #printing }
EndMatch >> printCurrentGameScore [
^''
]

{ #category : #'UI - graphics' }
EndMatch >> shouldShowLine [
^true
]

{ #category : #access }
EndMatch >> teamWithOwnership [
"Answer the team that 'owns' the event - for EndMatch a useful interpretation might be the winner of the match"

^self score currentlyWinningTeam in: [ :teamIndex |
		"Of course it shouldn't be zero, but we don't prevent ending a match on a draw"
		teamIndex isZero ifFalse:[ self matchState teams at: teamIndex ]]
]

{ #category : #printing }
EndMatch >> timeOutTallyForSide: aTableSide [
"Answer the number of time-outs at this point in the game by the team on the specified side"

^0
]
