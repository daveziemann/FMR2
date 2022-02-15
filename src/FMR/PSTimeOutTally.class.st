Class {
	#name : #PSTimeOutTally,
	#superclass : #'PSTimeOuts_',
	#category : #FMR
}

{ #category : #generation }
PSTimeOutTally >> sequence [
^'t'
]

{ #category : #UI }
PSTimeOutTally >> statisticBalloonMacro [
^'In <g> <tt> took a total of <s> time-outs.'
]

{ #category : #UI }
PSTimeOutTally >> statisticName [
^'Total time-outs'
]

{ #category : #UI }
PSTimeOutTally >> statisticNameBalloonText [
^'How many time-outs did each team take alltogether, including time-outs taken during active play or in pauses?'
]
