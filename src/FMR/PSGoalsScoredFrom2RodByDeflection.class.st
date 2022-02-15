Class {
	#name : #PSGoalsScoredFrom2RodByDeflection,
	#superclass : #'PSGoalsScoredByDeflection_',
	#category : #FMR
}

{ #category : #generation }
PSGoalsScoredFrom2RodByDeflection >> computeResult [
| oneDeflectionResults |

"Scored from 2-rod but with a momentary deflection from friend or enemy rod"
oneDeflectionResults := self sequences collect: [ :eachSequence |
	(self scanner sequence: eachSequence) scan lastSequenceSize ].

^oneDeflectionResults sum

]

{ #category : #generation }
PSGoalsScoredFrom2RodByDeflection >> sequences [
^#(
	'2|?u|#'		"Scored from 2-rod but with a momentary deflection from one friend rod"
	'2|.|?u|#'	"Scored from 2-rod but with a momentary deflection from one enemy rod"
)
]
