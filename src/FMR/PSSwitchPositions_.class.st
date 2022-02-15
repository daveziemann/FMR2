Class {
	#name : #'PSSwitchPositions_',
	#superclass : #'PresentableTeamStatistic_',
	#category : #FMR
}

{ #category : #UI }
PSSwitchPositions_ >> displayResult: aTeamResult [
"Override me"

^aTeamResult printAsNumber
]

{ #category : #generation }
PSSwitchPositions_ >> extractScannerResult [

^self scanner lastSequenceSize
]

{ #category : #UI }
PSSwitchPositions_ >> statisticCategory [ 
^'Switch Positions'
]

{ #category : #UI }
PSSwitchPositions_ >> statisticCategoryBalloonText [
^'How many times did the forward and the defender switch positions?'
]
