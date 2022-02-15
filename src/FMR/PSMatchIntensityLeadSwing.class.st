Class {
	#name : #PSMatchIntensityLeadSwing,
	#superclass : #'PSMatchIntensity_',
	#category : #FMR
}

{ #category : #generation }
PSMatchIntensityLeadSwing >> computeResult [
"Answer the number of times the lead swung between the teams"
| leadSwing pointTarget |

leadSwing := self scanner leadSwingTally.
pointTarget := self scanner pointTarget.
^{pointTarget.leadSwing}
]

{ #category : #UI }
PSMatchIntensityLeadSwing >> displayResult: aMatchResult [
"Override me"

^aMatchResult printAsRatioAndPercentage 
]

{ #category : #generation }
PSMatchIntensityLeadSwing >> sequence [
^'#'
]

{ #category : #UI }
PSMatchIntensityLeadSwing >> statisticBalloonMacro [
^'<g> saw the lead swing back and forth between the teams <s2> times out of a theoretical maximum of <s1> times, for a lead swing ratio of <%>.'
]

{ #category : #UI }
PSMatchIntensityLeadSwing >> statisticName [
^'Lead swing factor'
]

{ #category : #UI }
PSMatchIntensityLeadSwing >> statisticNameBalloonText [
^'The Lead Swing Factor shows how often one team took the lead over the other team as a fraction of the maximum possible number of lead swings, and is a measure of matchplay intensity. The smallest possible number of lead swings in a game is 1, meaning that team took the lead and never lost it. The largest possible number in each game is equal to the game point target. The Lead Swing Factor is the number of lead swings divided by the maximum number possible, and is a measure of how exciting the gameplay is.'
]
