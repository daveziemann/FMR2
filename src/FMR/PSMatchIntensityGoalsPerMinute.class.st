Class {
	#name : #PSMatchIntensityGoalsPerMinute,
	#superclass : #'PSMatchIntensity_',
	#category : #FMR
}

{ #category : #interestingness }
PSMatchIntensityGoalsPerMinute class >> absoluteInterestingnessTriggerForGameDefault [
^2.5
]

{ #category : #interestingness }
PSMatchIntensityGoalsPerMinute class >> absoluteInterestingnessTriggerForMatchDefault [
^2.0
]

{ #category : #interestingness }
PSMatchIntensityGoalsPerMinute class >> interestingnessSettingsOn: aBuilder [
<fmrsettings>

(aBuilder setting: #absoluteInterestingnessTriggerForGame)
	parent: #interestingness;
	label: 'Goals per Minute for Game'; 
	target: self;
	default: self absoluteInterestingnessTriggerForGameDefault;
	description: 'The Goals per Minute shows how often a goal was scored during active play and is a measure of matchplay intensity. It''s computed as the ratio of the number of goals scored to the total duration of the active play time. Set the value to be exceeded at game level for the statistic to become interesting.'.

(aBuilder setting: #absoluteInterestingnessTriggerForMatch)
	parent: #interestingness;
	label: 'Goals per Minute for Match'; 
	target: self;
	default: self absoluteInterestingnessTriggerForMatchDefault;
	description: 'The Goals per Minute shows how often a goal was scored during active play and is a measure of matchplay intensity. It''s computed as the ratio of the number of goals scored to the total duration of the active play time. Set the value to be exceeded at match level for the statistic to become interesting.'.

]

{ #category : #interestingness }
PSMatchIntensityGoalsPerMinute >> absoluteInterestingnessMacro [
"Interesting if the goals per minute exceeds a critical value"

^self absoluteInterestingnessTrigger in: [ :trigger |
	self goalsPerMinute >= trigger
		ifTrue: [ 'The goal scoring rate in <g> exceeded <ai> goals per minute.' ]]
]

{ #category : #generation }
PSMatchIntensityGoalsPerMinute >> computeResult [
"Answer the goals scored per minute of active play"

| goalTally |

goalTally := self scanner scan; lastSequenceSize.
^{self totalActivePlayTime.goalTally}
]

{ #category : #UI }
PSMatchIntensityGoalsPerMinute >> displayResult: aMatchResult [

^self goalsPerMinute asString
]

{ #category : #UI }
PSMatchIntensityGoalsPerMinute >> goalsPerMinute [
^self numberPerMinute
]

{ #category : #generation }
PSMatchIntensityGoalsPerMinute >> sequence [
^'#'
]

{ #category : #UI }
PSMatchIntensityGoalsPerMinute >> statisticBalloonMacro [
^'During <g> the teams were scoring at a rate of <d> goals per minute.'
]

{ #category : #UI }
PSMatchIntensityGoalsPerMinute >> statisticName [
^'Goals per minute'
]

{ #category : #UI }
PSMatchIntensityGoalsPerMinute >> statisticNameBalloonText [
^'This statistic shows how often a goal was scored during active play and is a measure of matchplay intensity. It''s computed as the ratio of the number of goals scored to the total duration of the active play time.'
]
