Class {
	#name : #'PSPossessionTotalDuration_',
	#superclass : #'PresentableTeamStatistic_',
	#category : #FMR
}

{ #category : #UI }
PSPossessionTotalDuration_ >> displayResult: aTeamResult [
"Override me"

^aTeamResult prettyPrintToRoundedSeconds
]

{ #category : #generation }
PSPossessionTotalDuration_ >> extractScannerResult [

^self scanner lastSequenceTotalDuration
]

{ #category : #UI }
PSPossessionTotalDuration_ >> mouseDown [
SpPresenterFMRPiePossessionSpread basicNew 
	matchState: self matchState;
	initialize;
	open	

]

{ #category : #UI }
PSPossessionTotalDuration_ >> statisticBalloonMacro [
^'In <g> <tt> had controlled possession of the ball for a cumulative total of <s> on their <r1>.'
]

{ #category : #UI }
PSPossessionTotalDuration_ >> statisticCategory [ 
^'Possession Time Total'
]

{ #category : #UI }
PSPossessionTotalDuration_ >> statisticCategoryBalloonText [
^'Over the whole game or match, what was the total cumulative time that each team had controlled possession of the ball on each of their rods?'
]

{ #category : #UI }
PSPossessionTotalDuration_ >> statisticName [
"^'Total time on <1p>-rod' expandMacrosWithArguments: self rods"
^self expandMacros: '<r1> total possession time'

]

{ #category : #UI }
PSPossessionTotalDuration_ >> statisticNameBalloonText [
^self expandMacros: 'Over the whole game or match, what was the total cumulative time that each team had controlled possession of the ball on their <r1>?'
]
