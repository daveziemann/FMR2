Class {
	#name : #PSMaximumConsecutiveGoals,
	#superclass : #'PSTable_',
	#category : #FMR
}

{ #category : #UI }
PSMaximumConsecutiveGoals >> displayResult: aTeamResult [
"Override me"

^aTeamResult printAsNumber
]

{ #category : #generation }
PSMaximumConsecutiveGoals >> extractScannerResult [

^self scanner maximumConsecutiveGoals
]

{ #category : #generation }
PSMaximumConsecutiveGoals >> sequence [
"Overidden when needed"

^'#'
]

{ #category : #UI }
PSMaximumConsecutiveGoals >> statisticBalloonMacro [
^'In <g> the largest number of consecutive goals scored by <tt> was <s>.'

]

{ #category : #UI }
PSMaximumConsecutiveGoals >> statisticCategory [ 
^'Goals Scored'
]

{ #category : #UI }
PSMaximumConsecutiveGoals >> statisticCategoryBalloonText [
^'What was the largest number of consecutive goals scored by each team?'
]

{ #category : #UI }
PSMaximumConsecutiveGoals >> statisticName [
^'Maximum consecutive goals'
]

{ #category : #UI }
PSMaximumConsecutiveGoals >> statisticNameBalloonText [
^'What was the largest number of consecutive goals scored by each team?'
]
