Class {
	#name : #'PSGoalsScoredByDeflection_',
	#superclass : #'PSGoalsScored_',
	#category : #FMR
}

{ #category : #UI }
PSGoalsScoredByDeflection_ >> statisticBalloonMacro [
^'In <g> <tt> scored a total of <s> deflection goals from their <r1>.'
]

{ #category : #UI }
PSGoalsScoredByDeflection_ >> statisticName [
^self expandMacros: '<r1> goals scored by deflection'
]

{ #category : #UI }
PSGoalsScoredByDeflection_ >> statisticNameBalloonText [
^self expandMacros: 'The number of goals each team scored from their <r1>, but via a single deflection from any other rod.'
]
