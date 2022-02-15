Class {
	#name : #PSMatchIntensityActivePlay,
	#superclass : #'PSMatchIntensity_',
	#category : #FMR
}

{ #category : #interestingness }
PSMatchIntensityActivePlay class >> absoluteInterestingnessTriggerForGameDefault [
^90
]

{ #category : #interestingness }
PSMatchIntensityActivePlay class >> absoluteInterestingnessTriggerForMatchDefault [
^80
]

{ #category : #interestingness }
PSMatchIntensityActivePlay class >> interestingnessSettingsOn: aBuilder [
<fmrsettings>

(aBuilder setting: #absoluteInterestingnessTriggerForGame)
	parent: #interestingness;
	label: 'Active Play for Game'; 
	target: self;
	default: self absoluteInterestingnessTriggerForGameDefault;
	description: 'The Active Play ratio is the total time spent in active play in the game divided by the total duration of the game, expressed as a percentage. Enter the minimum % at which it becomes interesting for a game.'.

(aBuilder setting: #absoluteInterestingnessTriggerForMatch)
	parent: #interestingness;
	label: 'Active Play for Match'; 
	target: self;
	default: self absoluteInterestingnessTriggerForMatchDefault;
	description: 'The Active Play ratio is the total time spent in active play in the match divided by the total duration of the match, expressed as a percentage. Enter the minimum % at which it becomes interesting for a match.'

]

{ #category : #interestingness }
PSMatchIntensityActivePlay >> absoluteInterestingnessMacro [
"Interesting if the active play fraction exceeds a critical value"

^self absoluteInterestingnessTrigger in: [ :trigger |
	self getResultPercentage >= trigger
		ifTrue: [ 'The active play ratio in <g> exceeded <ai%>.' ]]
]

{ #category : #generation }
PSMatchIntensityActivePlay >> computeResult [
"The ratio of Active Play to the total duration of the game/match"

| durationOfSequence durationBetweenGames durationOfGame |

"Do not count the time between games except for the match result"
durationOfSequence := self scanner scan; lastSequenceTotalDuration.
durationBetweenGames := self scanner lastEventDuration.
durationOfGame := durationOfSequence - durationBetweenGames.

^{durationOfGame.self totalActivePlayTime}
]

{ #category : #UI }
PSMatchIntensityActivePlay >> displayResult: aMatchResult [

^aMatchResult printDurationsAsRatioAndPercentage
]

{ #category : #generation }
PSMatchIntensityActivePlay >> sequence [
^'*'
]

{ #category : #UI }
PSMatchIntensityActivePlay >> statisticBalloonMacro [
^'<g> took <s1> out of which <s2> was spent in active play, so that <%> of the time was spent in active play.'
]

{ #category : #UI }
PSMatchIntensityActivePlay >> statisticName [
^'Active play ratio'
]

{ #category : #UI }
PSMatchIntensityActivePlay >> statisticNameBalloonText [
^'A foosball match consists of alternating periods of active play (when the ball is in play on the table) and Pauses (when active play is suspended). Pauses include the time between goals, between games, during time-outs, and while the ball is dead or off the table.

This statistic shows how much of the elapsed time of the game or match was spent in active play, and is a measure of matchplay intensity. The time between games is only taken into consideration for the overall match statistic.'
]
