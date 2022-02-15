Class {
	#name : #PSPass2To3AndScore,
	#superclass : #'PSGoalsScoredCleanPassAndScore_',
	#category : #FMR
}

{ #category : #generation }
PSPass2To3AndScore >> sequences [
^#(
	'2c|3c|#'			"Controlled 2-rod clean pass to controlled 3-rod possession to clean goal"
	'2c|3|t|3c|#'	"With a time-out on the 3-rod"
)
]
