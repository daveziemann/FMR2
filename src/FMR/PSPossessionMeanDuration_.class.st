Class {
	#name : #'PSPossessionMeanDuration_',
	#superclass : #'PresentableTeamStatistic_',
	#category : #FMR
}

{ #category : #UI }
PSPossessionMeanDuration_ >> displayResult: aTeamResult [
"Override me"

^aTeamResult prettyPrintToRoundedSeconds
]

{ #category : #generation }
PSPossessionMeanDuration_ >> extractScannerResult [
^self scanner lastSequenceMeanDuration
]

{ #category : #UI }
PSPossessionMeanDuration_ >> statisticBalloonMacro [
^'In <g> <tt> held the ball on average for <s> on their <r1>.'
]

{ #category : #UI }
PSPossessionMeanDuration_ >> statisticCategory [ 
^'Possession Time Average'
]

{ #category : #UI }
PSPossessionMeanDuration_ >> statisticCategoryBalloonText [
^'When a team had controlled possession of the ball on one of their rods, how long did they hold the ball for on that rod, on average?'
]

{ #category : #UI }
PSPossessionMeanDuration_ >> statisticName [
"^'Average time on <1p>-rod' expandMacrosWithArguments: self rods"
^self expandMacros: '<r1> average possession time'
]

{ #category : #UI }
PSPossessionMeanDuration_ >> statisticNameBalloonText [
^self expandMacros: 'When each team had a controlled possession on their <r1>, how long did they hold the ball on average?'
]
