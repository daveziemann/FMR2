Class {
	#name : #'PSGoalsScoredCleanPassAndScore_',
	#superclass : #'PSGoalsScored_',
	#category : #FMR
}

{ #category : #generation }
PSGoalsScoredCleanPassAndScore_ >> computeResult [
| goalsScored |

goalsScored := self sequences collect: [ :eachSequence |
	(self scanner sequence: eachSequence) scan lastSequenceSize ].

^goalsScored sum

]

{ #category : #UI }
PSGoalsScoredCleanPassAndScore_ >> statisticBalloonMacro [
^'In <g> <tt> passed from the <r1> to the <r2> and then scored <s> times.'
]

{ #category : #UI }
PSGoalsScoredCleanPassAndScore_ >> statisticName [
^self expandMacros: '<r1> pass to <r2> and score'

]

{ #category : #UI }
PSGoalsScoredCleanPassAndScore_ >> statisticNameBalloonText [
^self expandMacros: 'The number of clean <r1> to <r2> pass and score events by each team.'
]
