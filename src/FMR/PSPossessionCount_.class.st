Class {
	#name : #'PSPossessionCount_',
	#superclass : #'PresentableTeamStatistic_',
	#category : #FMR
}

{ #category : #UI }
PSPossessionCount_ >> displayResult: aTeamResult [
"Override me"

^aTeamResult printAsNumber
]

{ #category : #generation }
PSPossessionCount_ >> extractScannerResult [

^self scanner lastSequenceSize
]

{ #category : #UI }
PSPossessionCount_ >> statisticBalloonMacro [
^'In <g> <tt> had a total of <s> controlled possessions on their <r1>.'
]

{ #category : #UI }
PSPossessionCount_ >> statisticCategory [ 
^'Possessions'
]

{ #category : #UI }
PSPossessionCount_ >> statisticCategoryBalloonText [
^'How many times did each team have controlled possession of the ball?'
]

{ #category : #UI }
PSPossessionCount_ >> statisticName [
"^'Possession count on <1p>-rod' expandMacrosWithArguments: self rods"
^self expandMacros: '<r1> controlled possessions'
]

{ #category : #UI }
PSPossessionCount_ >> statisticNameBalloonText [
^self expandMacros: 'The number of times that each team had a controlled possession on their <r1>.'
]
