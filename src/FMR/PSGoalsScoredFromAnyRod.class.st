Class {
	#name : #PSGoalsScoredFromAnyRod,
	#superclass : #'PSGoalsScoredCleanly_',
	#category : #FMR
}

{ #category : #UI }
PSGoalsScoredFromAnyRod >> relativeInterestingnessMacro [
| thisTeamGoals otherTeamGoals |
"Interesting if this team scored more than a certain % of the total goals"
thisTeamGoals := self getResult result.
otherTeamGoals := self getResultForOtherTeamAndGame result.
^((thisTeamGoals divideBy: thisTeamGoals + otherTeamGoals) > 0.8)
	ifTrue: [ 'This was a decisive ', thisTeamGoals asString, '-',otherTeamGoals asString,' victory for <tt>.' ]
]

{ #category : #generation }
PSGoalsScoredFromAnyRod >> sequence [
^'?|#'
]

{ #category : #UI }
PSGoalsScoredFromAnyRod >> statisticBalloonMacro [
^'In <g> <tt> scored a total of <s> goals.'
]

{ #category : #UI }
PSGoalsScoredFromAnyRod >> statisticName [
^'Total goals scored'
]

{ #category : #UI }
PSGoalsScoredFromAnyRod >> statisticNameBalloonText [
^'The number of goals scored from any rod against the other team. This does not count any own-goals.'
]
