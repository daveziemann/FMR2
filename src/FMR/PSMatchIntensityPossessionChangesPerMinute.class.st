Class {
	#name : #PSMatchIntensityPossessionChangesPerMinute,
	#superclass : #'PSMatchIntensity_',
	#category : #FMR
}

{ #category : #interestingness }
PSMatchIntensityPossessionChangesPerMinute class >> absoluteInterestingnessTriggerForGameDefault [
^15
]

{ #category : #interestingness }
PSMatchIntensityPossessionChangesPerMinute class >> absoluteInterestingnessTriggerForMatchDefault [
^12
]

{ #category : #interestingness }
PSMatchIntensityPossessionChangesPerMinute class >> interestingnessSettingsOn: aBuilder [
<fmrsettings>

(aBuilder setting: #absoluteInterestingnessTriggerForGame)
	parent: #interestingness;
	label: 'Possession Changes per Minute for Game'; 
	target: self;
	default: self absoluteInterestingnessTriggerForGameDefault;
	description: 'The Possession Changes per Minute shows how frequently possession changed from one team to the other and is a measure of matchplay intensity. Set the value to be exceeded at game level for the statistic to become interesting.'.

(aBuilder setting: #absoluteInterestingnessTriggerForMatch)
	parent: #interestingness;
	label: 'Possession Changes per Minute for Match'; 
	target: self;
	default: self absoluteInterestingnessTriggerForMatchDefault;
	description: 'The Possession Changes per Minute shows how frequently possession changed from one team to the other and is a measure of matchplay intensity. Set the value to be exceeded at match level for the statistic to become interesting.'.

]

{ #category : #interestingness }
PSMatchIntensityPossessionChangesPerMinute >> absoluteInterestingnessMacro [
"Interesting if the possession changes per minute exceeds a critical value"

^self absoluteInterestingnessTrigger in: [ :trigger |
	self possessionChangesPerMinute >= trigger
		ifTrue: [ 'The possession change rate in <g> exceeded <ai> possession changes per minute.' ]]
]

{ #category : #generation }
PSMatchIntensityPossessionChangesPerMinute >> computeResult [
"Answer the number of possession changes per minute of active play"
| possessionFlipTally |

possessionFlipTally := self scanner scan; lastSequenceSize.
^{self totalActivePlayTime.possessionFlipTally}
]

{ #category : #UI }
PSMatchIntensityPossessionChangesPerMinute >> displayResult: aMatchResult [

^self displayRatioAsInteger: aMatchResult
]

{ #category : #UI }
PSMatchIntensityPossessionChangesPerMinute >> possessionChangesPerMinute [
^self numberPerMinute rounded
]

{ #category : #generation }
PSMatchIntensityPossessionChangesPerMinute >> sequence [
^'.'
]

{ #category : #UI }
PSMatchIntensityPossessionChangesPerMinute >> statisticBalloonMacro [
^'During <g> the teams were exchanging possession of the ball at a rate of <d> possession changes per minute.'
]

{ #category : #UI }
PSMatchIntensityPossessionChangesPerMinute >> statisticName [
^'Possession changes per minute'
]

{ #category : #UI }
PSMatchIntensityPossessionChangesPerMinute >> statisticNameBalloonText [
^'This statistic shows how often the possession of the ball switched from one team to the other, and is a measure of matchplay intensity. It''s computed as the ratio of the number of the of the number of possession flips to the total duration of the active play time.'
]
