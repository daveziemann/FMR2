Class {
	#name : #PSSwitchPositionsTally,
	#superclass : #'PSSwitchPositions_',
	#category : #FMR
}

{ #category : #generation }
PSSwitchPositionsTally >> sequence [
^':'
]

{ #category : #UI }
PSSwitchPositionsTally >> statisticBalloonMacro [
^'In <g> <tt> switched positions a total of <s> times.'
]

{ #category : #UI }
PSSwitchPositionsTally >> statisticName [
^'Total switches'
]

{ #category : #UI }
PSSwitchPositionsTally >> statisticNameBalloonText [
^'How many times did the forward and the defender switch positions?'
]
