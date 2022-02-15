Class {
	#name : #Goal,
	#superclass : #PseudoRod,
	#category : #FMR
}

{ #category : #printing }
Goal class >> printPseudoRod [
^'Goal'
]

{ #category : #accessing }
Goal class >> representation [ 
^$#
]

{ #category : #scoring }
Goal >> adjustScore: aMatchScore [
^aMatchScore goalScoredByTeam: (self matchState teams indexOf: self teamWithPossession)
]

{ #category : #'UI - graphics' }
Goal >> boxColour [
"Answer the colour for the box, generally the colour of the owning event, except all pauses are neutral"

^FMRColour neutralColour
]

{ #category : #'UI - graphics' }
Goal >> explainEvent [
^self teamWithOwnership teamName,' scored a goal'
]

{ #category : #access }
Goal >> goalOffsetFraction [
"The distance from goalkeeper to goal as a fraction of one rod-distance-unit
	- it depends on table type"
	
^self matchState table goalOffsetFraction
]

{ #category : #access }
Goal >> isControlledPossessionEvent [
"Answer if I am a controlled possession event; this includes being in the Goal"

^true
]

{ #category : #testing }
Goal >> isEndOfMatch [
"Answer true if we can infer from the receiver that the match is over"

^self nextMatchplayEvent
	ifNil: [ false ]
	ifNotNil: [ :nme | nme isEndOfMatch ]
]

{ #category : #testing }
Goal >> isGoal [
^true
]

{ #category : #testing }
Goal >> isLastGoalOfGame [
^self nextMatchplayEvent 
	ifNil: [ false ]
	ifNotNil: [ :nme | nme isEndGame ]
]

{ #category : #access }
Goal >> rduFrom2Rod: a2Rod [
^(self teamWithPossession = a2Rod teamWithPossession
	ifTrue: [ 6 ]
	ifFalse: [ 1 ]) + self goalOffsetFraction
]

{ #category : #access }
Goal >> rduFrom3Rod: a3Rod [
^(self teamWithPossession = a3Rod teamWithPossession
	ifTrue: [ 2 ]
	ifFalse: [ 5 ]) + self goalOffsetFraction
]

{ #category : #access }
Goal >> rduFrom5Rod: a5Rod [
^(self teamWithPossession = a5Rod teamWithPossession
	ifTrue: [ 4 ]
	ifFalse: [ 3 ]) + self goalOffsetFraction
]

{ #category : #access }
Goal >> rduToRodOrGoal: anotherRodOrGoal [
^anotherRodOrGoal rduFromGoal: self
]

{ #category : #access }
Goal >> reasonableMaximumDuration [
^10 seconds
]

{ #category : #'UI - graphics' }
Goal >> shouldShowLine [
^true
]

{ #category : #testing }
Goal >> takesTheLead [
"Answer if the team that scored this goal now takes the lead"

^self currentlyWinningTeamInGame in: [ :cwtig |
	cwtig isZero not and: [ cwtig ~= self previousEvent currentlyWinningTeamInGame ]]
]

{ #category : #access }
Goal >> timeLimit [
"Answer the maximum duration allowed for this event in the rules"

^5 seconds
]
