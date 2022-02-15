Class {
	#name : #PSGoalsScoredInOwnGoal,
	#superclass : #'PSGoalsScored_',
	#category : #FMR
}

{ #category : #generation }
PSGoalsScoredInOwnGoal >> sequence [
^'?c|.|#'
]

{ #category : #UI }
PSGoalsScoredInOwnGoal >> statisticBalloonMacro [
^'In <g> <tt> scored <s> own-goals.'
]

{ #category : #UI }
PSGoalsScoredInOwnGoal >> statisticName [
^'Own goals'
]

{ #category : #UI }
PSGoalsScoredInOwnGoal >> statisticNameBalloonText [
^'The number of own-goals scored by each team. A goal is registered as an own-goal if the recording shows a controlled possession immediately prior to scoring in the same team''s goal. Deflections (momentary uncontrolled possessions) are not counted as own-goals.'
]
