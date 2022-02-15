Class {
	#name : #PSPass5To3AndScore,
	#superclass : #'PSGoalsScoredCleanPassAndScore_',
	#category : #FMR
}

{ #category : #'headline statistics' }
PSPass5To3AndScore >> headlineStatisticName [
"Only statsitics which return a non-empty string here are used for headline results,
	in which case the string is used in place of the normal statistic name"

^self statisticName
]

{ #category : #generation }
PSPass5To3AndScore >> sequences [
^#(
	'5c|3c|#'			"Controlled 5-rod clean pass to controlled 3-rod possession to clean goal"
	'5c|3|t|3c|#'	"With a time-out on the 3-rod"
)

]
