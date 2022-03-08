Class {
	#name : #PSScoringFrom3Rod,
	#superclass : #'PSScoringSuccess_',
	#category : #FMR
}

{ #category : #interestingness }
PSScoringFrom3Rod class >> absoluteInterestingnessTriggerForGameDefault [
^80
]

{ #category : #interestingness }
PSScoringFrom3Rod class >> absoluteInterestingnessTriggerForMatchDefault [
^65
]

{ #category : #interestingness }
PSScoringFrom3Rod class >> interestingnessSettingsOn: aBuilder [
<fmrsettings>

self interestingnessSettingsOn: aBuilder forClass: self
]

{ #category : #awards }
PSScoringFrom3Rod >> awardName [
^'Best Ever 3-rod Scoring Rate'
]

{ #category : #generation }
PSScoringFrom3Rod >> computeResult [
| results |

results := self sequences collect: [ :eachSequence |
	(self scanner sequence: eachSequence) scan firstAndLastSequenceSize ].

^{results first first.results sum second}
]

{ #category : #'headline statistics' }
PSScoringFrom3Rod >> headlineStatisticName [
"Only statsitics which return a non-empty string here are used for headline results,
	in which case the string is used in place of the normal statistic name"

^self statisticName
]

{ #category : #generation }
PSScoringFrom3Rod >> sequences [
^#(
	'3c|#'				"Clean goal from a controlled possession"
	'3c|2u|.|#'		"Deflection goal from a controlled possession"
)
]
