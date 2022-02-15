Class {
	#name : #PSMatchIntensityBallTravelDistance,
	#superclass : #'PSMatchIntensity_',
	#category : #FMR
}

{ #category : #interestingness }
PSMatchIntensityBallTravelDistance class >> absoluteInterestingnessTriggerForGameDefault [
^40
]

{ #category : #interestingness }
PSMatchIntensityBallTravelDistance class >> absoluteInterestingnessTriggerForMatchDefault [
^100
]

{ #category : #interestingness }
PSMatchIntensityBallTravelDistance class >> interestingnessSettingsOn: aBuilder [
<fmrsettings>

(aBuilder setting: #absoluteInterestingnessTriggerForGame)
	parent: #interestingness;
	label: 'Ball Travel Distance for Game'; 
	target: self;
	default: self absoluteInterestingnessTriggerForGameDefault;
	description: 'The Ball Travel Distance statistic will become interesting at the game level when it exceeds this value, in meters.'.
	
(aBuilder setting: #absoluteInterestingnessTriggerForMatch)
	parent: #interestingness;
	label: 'Ball Travel Distance for Match'; 
	target: self;
	default: self absoluteInterestingnessTriggerForMatchDefault;
	description: 'The Ball Travel Distance statistic will become interesting at the match level when it exceeds this value, in meters.'.

]

{ #category : #interestingness }
PSMatchIntensityBallTravelDistance >> absoluteInterestingnessMacro [
"Interesting if the ball travel distance in metres exceeds a critical value"

^self absoluteInterestingnessTrigger in: [ :trigger |
	self ballTravelDistance >= trigger
		ifTrue: [ 'The ball traveled over <ai>m during <g>.' ]]
		
]

{ #category : #awards }
PSMatchIntensityBallTravelDistance >> awardName [
^'Furthest ever ball travel distance'
]

{ #category : #UI }
PSMatchIntensityBallTravelDistance >> ballTravelDistance [
"Answer the ball travel distance in m"

^(self getResult result / 100) rounded
]

{ #category : #generation }
PSMatchIntensityBallTravelDistance >> computeResult [
"Answer the total ball travel distance during active play"

^self scanner ballTravelDistance
]

{ #category : #UI }
PSMatchIntensityBallTravelDistance >> displayResult: aMatchResult [

^(aMatchResult result / 100) rounded asString,'m'
]

{ #category : #UI }
PSMatchIntensityBallTravelDistance >> statisticBalloonMacro [
^'During <g> the ball travelled a distance of <d> up and down the table.'
]

{ #category : #UI }
PSMatchIntensityBallTravelDistance >> statisticName [
^'Ball travel distance'
]

{ #category : #UI }
PSMatchIntensityBallTravelDistance >> statisticNameBalloonText [
^'This statistic shows how far the ball travelled up and down the table during active play. FMR doesn''t record transfers between figures on a rod, so the distance the ball travelled relates only to motion up and down the table.'
]
