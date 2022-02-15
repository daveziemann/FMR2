Class {
	#name : #'PSGoalsScoredCleanly_',
	#superclass : #'PSGoalsScored_',
	#category : #FMR
}

{ #category : #UI }
PSGoalsScoredCleanly_ >> statisticBalloonMacro [
^'In <g> <tt> scored a total of <s> clean goals from their <r1>.'
]

{ #category : #UI }
PSGoalsScoredCleanly_ >> statisticName [
^self expandMacros: '<r1> goals scored'

]

{ #category : #UI }
PSGoalsScoredCleanly_ >> statisticNameBalloonText [
^self expandMacros: 'The number of clean goals each team scored from their <r1>. A clean goal is one scored directly, i.e. without deflection. This statistics includes goals scored from either controlled or uncontrolled possessions.'
]
