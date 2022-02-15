Class {
	#name : #PSScoringFrom3RodStuffTest,
	#superclass : #FMRTestCase,
	#category : #'FMR-Tests'
}

{ #category : #tests }
PSScoringFrom3RodStuffTest >> testStuff [
| ms ps teamsResult |

ms := MatchState fromString: '5{5000}\.\2{5000}\.\3{5}\#{10000}\/\//'.
ps := (PSGoalsScoredFrom3RodStuff new matchState: ms) generate.
teamsResult := ps resultsPerGame first.

self assert: teamsResult class equals: PSTeamsResult.
self assert: teamsResult result size equals: 2.
self assert: teamsResult result first class equals: PSTeamResult.
self assert: teamsResult result second class equals: PSTeamResult.
self assert: teamsResult result first result equals: 1.
self assert: teamsResult result second result equals: 0.
]
