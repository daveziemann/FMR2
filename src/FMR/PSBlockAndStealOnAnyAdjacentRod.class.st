Class {
	#name : #PSBlockAndStealOnAnyAdjacentRod,
	#superclass : #'PSBlockingAndStealing_',
	#category : #FMR
}

{ #category : #generation }
PSBlockAndStealOnAnyAdjacentRod >> computeResult [
| blockAndStealResults |

blockAndStealResults := self sequences collect: [ :eachSequence |
	(self scanner sequence: eachSequence) scan firstAndLastSequenceSize ].

^blockAndStealResults sum
]

{ #category : #UI }
PSBlockAndStealOnAnyAdjacentRod >> rods [
"The superclass algorithm incorrectly classifies this as a 3-rod rather than a Team statistic"

^#()
]

{ #category : #generation }
PSBlockAndStealOnAnyAdjacentRod >> sequences [
^#(
	'2c|.|3c'
	'5c|.|5c'
	'3c|.|2c'
	'3c|.|?u|^|2c'
)
]

{ #category : #UI }
PSBlockAndStealOnAnyAdjacentRod >> statisticBalloonMacro [
^'In <g> <tt> stole the ball <s2> times from <s1> controlled possessions on an adjacent rod on team <ot>, for an adjacent rod block and steal rate of <%d>.'
]

{ #category : #generation }
PSBlockAndStealOnAnyAdjacentRod >> statisticName [
^'Block and steal from adjacent rod'
]

{ #category : #UI }
PSBlockAndStealOnAnyAdjacentRod >> statisticNameBalloonText [
^self expandMacros: 'How successful is the team at blocking and stealing the ball? This is computed from the number of controlled possessions on the stealing rod that resulted directly from a transition following a controlled possession on the adjacent rod of the other team.' 
]
