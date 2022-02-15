Class {
	#name : #'PSTimeOuts_',
	#superclass : #'PresentableTeamStatistic_',
	#category : #FMR
}

{ #category : #UI }
PSTimeOuts_ >> displayResult: aTeamResult [
"Override me"

^aTeamResult printAsNumber
]

{ #category : #generation }
PSTimeOuts_ >> extractScannerResult [

^self scanner lastSequenceSize
]

{ #category : #UI }
PSTimeOuts_ >> statisticBalloonMacro [
^'In <g> <tt> took <s> time-outs during active play on their <r1>.'
]

{ #category : #UI }
PSTimeOuts_ >> statisticCategory [ 
^'Time-outs'
]

{ #category : #UI }
PSTimeOuts_ >> statisticCategoryBalloonText [
^'How many time-outs did each team take, and on which rods?'
]

{ #category : #UI }
PSTimeOuts_ >> statisticName [
"^'Time-outs on the <1p>-rod' expandMacrosWithArguments: self rods"
^self expandMacros: '<r1> time-outs'

]

{ #category : #UI }
PSTimeOuts_ >> statisticNameBalloonText [
^self expandMacros: 'How many time-outs did each team take during active play on their <r1>?'
]
