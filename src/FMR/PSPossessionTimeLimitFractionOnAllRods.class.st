Class {
	#name : #PSPossessionTimeLimitFractionOnAllRods,
	#superclass : #'PSPossessionTimeLimitFraction_',
	#category : #FMR
}

{ #category : #generation }
PSPossessionTimeLimitFractionOnAllRods >> extractScannerResult [
^self scanner lastSequenceTimeLimitFraction average asFloat rounded
]

{ #category : #generation }
PSPossessionTimeLimitFractionOnAllRods >> sequence [
^'?c'
]

{ #category : #UI }
PSPossessionTimeLimitFractionOnAllRods >> statisticBalloonMacro [
^'In <g> <tt> held the ball on average for <%> of the possession time limit.'
]

{ #category : #generation }
PSPossessionTimeLimitFractionOnAllRods >> statisticName [
^self expandMacros: 'Possession time limit fraction'
]

{ #category : #UI }
PSPossessionTimeLimitFractionOnAllRods >> statisticNameBalloonText [
^self expandMacros: 'When the team had controlled possession of the ball on any of their rods, how close were they to the time limit on that rod? For each controlled possession the statistic is computed as the ratio of the possession time on the rod to the possession time limit for that rod, expressed as a percentage. The cumulative statistic is computed by taking the ratio of the cumulative controlled possession time to the cumulative possession time limit over all controlled possessions on all that team''s rods.'
]
