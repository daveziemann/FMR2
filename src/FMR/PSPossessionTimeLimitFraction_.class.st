Class {
	#name : #'PSPossessionTimeLimitFraction_',
	#superclass : #'PresentableTeamStatistic_',
	#category : #FMR
}

{ #category : #generation }
PSPossessionTimeLimitFraction_ >> computeResult [
| totalDuration rodTimeLimits |

self scanner scan.
totalDuration := self scanner lastSequenceTotalDuration.
rodTimeLimits := self scanner lastSequenceTimeLimits.
^{rodTimeLimits sumDurations . totalDuration}

]

{ #category : #UI }
PSPossessionTimeLimitFraction_ >> displayResult: aTeamResult [
"Override me"

^aTeamResult printRatioAsPercentage
]

{ #category : #generation }
PSPossessionTimeLimitFraction_ >> extractScannerResult [

]

{ #category : #UI }
PSPossessionTimeLimitFraction_ >> statisticBalloonMacro [
^'In <g> <tt> held the ball on their <r1> on average for <%> of the possession time limit.'
]

{ #category : #UI }
PSPossessionTimeLimitFraction_ >> statisticCategory [ 
^'Possession Fraction'
]

{ #category : #UI }
PSPossessionTimeLimitFraction_ >> statisticCategoryBalloonText [
^'When the team had controlled possession of the ball, how close were they to the time limit on that rod? For each controlled possession the statistic is computed as the ratio of the possession time to the possession time limit on that rod, expressed as a percentage. The cumulative statistic is computed by taking the ratio of the cumulative controlled possession time to the cumulative possession time limit over all controlled possessions.'
]

{ #category : #UI }
PSPossessionTimeLimitFraction_ >> statisticName [
^self expandMacros: '<r1> possession time limit fraction'
]

{ #category : #UI }
PSPossessionTimeLimitFraction_ >> statisticNameBalloonText [
^self expandMacros: 'When the team had controlled possession of the ball on their <r1>, how close were they to the time limit on that rod? For each controlled possession the statistic is computed as the ratio of the possession time to the <r1> possession time limit, expressed as a percentage.

The cumulative statistic is computed by taking the ratio of the cumulative controlled possession time to the cumulative possession time limit over all controlled possessions on the <r1>.'
]
