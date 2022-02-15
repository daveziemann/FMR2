Class {
	#name : #'PSPossessionShare_',
	#superclass : #'PresentableTeamStatistic_',
	#category : #FMR
}

{ #category : #UI }
PSPossessionShare_ >> displayResult: aTeamResult [
"Override me"

^aTeamResult prettyPrintToRoundedSeconds
]

{ #category : #generation }
PSPossessionShare_ >> extractScannerResult [

^self scanner lastSequenceTotalDuration
]

{ #category : #UI }
PSPossessionShare_ >> mouseDown [
SpPresenterFMRPiePossessionShare basicNew 
	matchState: self matchState;
	initialize;
	open	

]

{ #category : #UI }
PSPossessionShare_ >> statisticCategory [ 
^'Possession Share'
]

{ #category : #UI }
PSPossessionShare_ >> statisticCategoryBalloonText [
^'Over the whole game or match, how did the two teams share the total amount of time the ball was under controlled possession?'
]
