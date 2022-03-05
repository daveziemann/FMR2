Class {
	#name : #EndGame,
	#superclass : #MatchplayEvent,
	#category : #FMR
}

{ #category : #accessing }
EndGame class >> representation [ 
^$/
]

{ #category : #scoring }
EndGame >> adjustScore: aMatchScore [
^aMatchScore newGame
]

{ #category : #printing }
EndGame >> asTextWithAttributes: aString [

^aString asText
	addAttribute: (TextColor new color: self colour);
	addAttribute: (TextEmphasis bold);
	yourself
	
]

{ #category : #'UI - graphics' }
EndGame >> explainEvent [
^'The end of game ',self gameNumber asString
]

{ #category : #testing }
EndGame >> isBold [
"Answer if the event should be displayed using bold font"
^true
]

{ #category : #testing }
EndGame >> isEndGame [
^true
]

{ #category : #testing }
EndGame >> isEndOfMatch [
"Answer true if we can infer from the receiver that the match is over"

^self nextMatchplayEvent
	ifNil: [ false ]
	ifNotNil: [ :nme | nme isEndOfMatch ]
]

{ #category : #printing }
EndGame >> printCurrentGameScore [
^''
]

{ #category : #access }
EndGame >> reasonableMaximumDuration [
^self timeLimit
]

{ #category : #'UI - graphics' }
EndGame >> shouldShowLine [
^true
]

{ #category : #access }
EndGame >> teamWithOwnership [
"Answer the team that 'owns' the event - for EndGame a useful interpretation might be the winner of the game"
| teamIndex |

"On an EndGame event the last game is always a new game with score 0-0"
teamIndex := self score gameScores nextToLast currentlyWinningTeam.

"Of course it shouldn't be zero, but we don't prevent ending a game on a draw"
teamIndex isZero ifTrue: [ ^nil ].

^self matchState teams at: teamIndex.

]

{ #category : #access }
EndGame >> timeLimit [
"Answer the maximum duration allowed for this event in the rules"

^90 seconds
]

{ #category : #printing }
EndGame >> timeOutTallyForSide: aTableSide [
"Answer the number of time-outs at this point in the game by the team on the specified side"

^0
]
