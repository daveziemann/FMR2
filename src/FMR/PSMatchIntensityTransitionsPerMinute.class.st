Class {
	#name : #PSMatchIntensityTransitionsPerMinute,
	#superclass : #'PSMatchIntensity_',
	#category : #FMR
}

{ #category : #interestingness }
PSMatchIntensityTransitionsPerMinute class >> absoluteInterestingnessTriggerForGameDefault [
^16
]

{ #category : #interestingness }
PSMatchIntensityTransitionsPerMinute class >> absoluteInterestingnessTriggerForMatchDefault [
^14
]

{ #category : #interestingness }
PSMatchIntensityTransitionsPerMinute class >> interestingnessSettingsOn: aBuilder [
<fmrsettings>

(aBuilder setting: #absoluteInterestingnessTriggerForGame)
	parent: #interestingness;
	label: 'Transitions per Minute for Game'; 
	target: self;
	default: self absoluteInterestingnessTriggerForGameDefault;
	description: 'The Transitions per Minute statistic shows how frequently the ball left the rod of possession, and is a measure of matchplay intensity. Set the value to be exceeded at game level for the statistic to become interesting.'.

(aBuilder setting: #absoluteInterestingnessTriggerForMatch)
	parent: #interestingness;
	label: 'Transitions per Minute for Match'; 
	target: self;
	default: self absoluteInterestingnessTriggerForMatchDefault;
	description: 'The Transitions per Minute statistic shows how frequently the ball left the rod of possession, and is a measure of matchplay intensity. Set the value to be exceeded at match level for the statistic to become interesting.'.

]

{ #category : #interestingness }
PSMatchIntensityTransitionsPerMinute >> absoluteInterestingnessMacro [
"Interesting if the possession changes per minute exceeds a critical value"

^self absoluteInterestingnessTrigger in: [ :trigger |
	self transitionsPerMinute >= trigger
		ifTrue: [ 'The number of transitions in <g> exceeded <ai> transitions per minute.' ]]
]

{ #category : #generation }
PSMatchIntensityTransitionsPerMinute >> computeResult [
"Answer the number of transitions per minute of active play"
| transitionTally |

transitionTally := self scanner scan; lastSequenceSize.
^{self totalActivePlayTime.transitionTally}
]

{ #category : #UI }
PSMatchIntensityTransitionsPerMinute >> displayResult: aMatchResult [

^self displayRatioAsInteger: aMatchResult
]

{ #category : #generation }
PSMatchIntensityTransitionsPerMinute >> sequence [
^'?'
]

{ #category : #UI }
PSMatchIntensityTransitionsPerMinute >> statisticBalloonMacro [
^'During <g> the ball was moving between the rods at a rate of <d> transitions per minute.'
]

{ #category : #UI }
PSMatchIntensityTransitionsPerMinute >> statisticName [
^'Transitions per minute'
]

{ #category : #UI }
PSMatchIntensityTransitionsPerMinute >> statisticNameBalloonText [
^'This statistic shows how often the possession of the ball switched from one rod to another rod, regardless of the team, and is a measure of matchplay intensity. It''s computed as the ratio of the number of transitions (from one rod to another) to the total duration of the active play time.'
]

{ #category : #UI }
PSMatchIntensityTransitionsPerMinute >> transitionsPerMinute [
^self numberPerMinute rounded
]
