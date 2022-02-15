Class {
	#name : #'PSGoalsScored_',
	#superclass : #'PresentableTeamStatistic_',
	#category : #FMR
}

{ #category : #UI }
PSGoalsScored_ >> displayResult: aTeamResult [
"Override me"

^aTeamResult printAsNumber
]

{ #category : #generation }
PSGoalsScored_ >> extractScannerResult [

^self scanner lastSequenceSize
]

{ #category : #'UI - delta' }
PSGoalsScored_ >> getDelta [
^self rawDelta rounded
]

{ #category : #'UI - delta' }
PSGoalsScored_ >> printDelta [
self gameNumber < 2 ifTrue: [ ^'' ].
^self getDelta in: [ :delta |
	delta isZero
		ifTrue: [ ' (=)' ]
		ifFalse: [ ' (',('-=+' at: delta sign + 2) asString,delta abs asString,')' ]]

]

{ #category : #UI }
PSGoalsScored_ >> statisticCategory [ 
^'Goals Scored'
]

{ #category : #UI }
PSGoalsScored_ >> statisticCategoryBalloonText [
^'How many goals were scored from each rod?'
]
