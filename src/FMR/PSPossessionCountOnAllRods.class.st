Class {
	#name : #PSPossessionCountOnAllRods,
	#superclass : #'PSPossessionCount_',
	#category : #FMR
}

{ #category : #generation }
PSPossessionCountOnAllRods >> sequence [
^'?c'
]

{ #category : #UI }
PSPossessionCountOnAllRods >> statisticBalloonMacro [
^'In <g> <tt> had a total of <s> controlled possessions.'
]

{ #category : #UI }
PSPossessionCountOnAllRods >> statisticName [
^self expandMacros: 'Controlled possessions'
]

{ #category : #UI }
PSPossessionCountOnAllRods >> statisticNameBalloonText [
^self expandMacros: 'The number of times that each team had a controlled possession on one of their rods.'
]
