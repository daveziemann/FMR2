Class {
	#name : #PSBlock2RodStealOn5RodInstaPassTo3Rod,
	#superclass : #'PSBlockingAndStealing_',
	#category : #FMR
}

{ #category : #UI }
PSBlock2RodStealOn5RodInstaPassTo3Rod >> rods [
"The superclass algorithm incorrectly classifies this as a 3-rod rather than a 5-rod statistic"

^#(2 5)
]

{ #category : #generation }
PSBlock2RodStealOn5RodInstaPassTo3Rod >> sequence [
^'2c|.|5u|3c'
]

{ #category : #UI }
PSBlock2RodStealOn5RodInstaPassTo3Rod >> statisticBalloonMacro [
^'In <g> <tt> blocked plays from <s1> controlled possessions on <ot>''s <r1> with their 5-rod and instantly passed the ball to their 3-rod <s2> times giving a block, steal and pass rate of <%>.'
]

{ #category : #generation }
PSBlock2RodStealOn5RodInstaPassTo3Rod >> statisticName [
^'5-rod blocks 2-rod and reaction pass to 3-rod'
]

{ #category : #generation }
PSBlock2RodStealOn5RodInstaPassTo3Rod >> statisticNameBalloonText [
^self expandMacros: 'How successful is the team at blocking a 2-rod play on their 5-rod and instantly passing the ball to their 3-rod? This is computed from the number of controlled possessions on the opposing 2-rod that are followed by an uncontrolled possession on the 5-rod followed by a controlled possesion on the 3-rod.'
]
