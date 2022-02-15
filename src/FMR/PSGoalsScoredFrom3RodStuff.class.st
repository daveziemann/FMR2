Class {
	#name : #PSGoalsScoredFrom3RodStuff,
	#superclass : #'PSGoalsScoredCleanly_',
	#category : #FMR
}

{ #category : #generation }
PSGoalsScoredFrom3RodStuff >> sequence [
^'2|.|3u|#'
]

{ #category : #generation }
PSGoalsScoredFrom3RodStuff >> shouldReverseTeamResults [
"Some statistics are computed from the perspective of the other team, in which case the order of the reults must be reversed"

^true
]

{ #category : #UI }
PSGoalsScoredFrom3RodStuff >> statisticBalloonMacro [
^'In <g> <tt> scored a total of <s> goals by stuffing the ball back into the goal from the 3-rod.'
]

{ #category : #UI }
PSGoalsScoredFrom3RodStuff >> statisticName [
^'3-rod stuffs'
]

{ #category : #UI }
PSGoalsScoredFrom3RodStuff >> statisticNameBalloonText [
^'The number of 3-rod goals scored by stuffing the ball back into the opposing team''s goal. A 3-rod stuff is detected by a controlled possession on the opposing team''s 2-rod followed by an uncontrolled possession on the 3-rod immediately followed by a goal.'
]
