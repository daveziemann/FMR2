Class {
	#name : #PSRetainOn2Rod,
	#superclass : #'PSBlockingAndStealing_',
	#category : #FMR
}

{ #category : #interestingness }
PSRetainOn2Rod class >> absoluteInterestingnessTriggerForGameDefault [
^90
]

{ #category : #interestingness }
PSRetainOn2Rod class >> absoluteInterestingnessTriggerForMatchDefault [
^80
]

{ #category : #interestingness }
PSRetainOn2Rod class >> interestingnessSettingsOn: aBuilder [
<fmrsettings>

(aBuilder setting: #absoluteInterestingnessTriggerForGame)
	parent: #interestingness;
	label: 'Retention on 2-rod for Game'; 
	target: self;
	default: self absoluteInterestingnessTriggerForGameDefault;
	description: 'The 2-rod Retention shows how well each team retained the ball after it entered the area behind their 2-rod. Set the percentage to be exceeded at game level for the statistic to become interesting.'.

(aBuilder setting: #absoluteInterestingnessTriggerForMatch)
	parent: #interestingness;
	label: 'Retention on 2-rod for Match'; 
	target: self;
	default: self absoluteInterestingnessTriggerForMatchDefault;
	description: 'The 2-rod Retention shows how well each team retained the ball after it entered the area behind their 2-rod. Set the percentage to be exceeded at match level for the statistic to become interesting.'.

(aBuilder setting: #relativeInterestingnessTrigger)
	parent: #interestingness;
	label: 'Retention on 2-rod - Relative'; 
	target: self;
	default: self relativeInterestingnessTriggerDefault;
	description: 'A team''s 2-rod retention rate is also interesting if it is much higher than the other team''s. Set the factor to be exceeded at which this statistic becomes interesting.'.

]

{ #category : #interestingness }
PSRetainOn2Rod class >> relativeInterestingnessTriggerDefault [
^2.0
]

{ #category : #interestingness }
PSRetainOn2Rod >> absoluteInterestingnessMacro [
^self absoluteInterestingnessTrigger in: [ :trigger | | possessionCount |
	possessionCount := self getResult result first.
	^(self getResultPercentage > trigger & (possessionCount > 4))
		ifTrue: [ '<tt>''s 2-rod retention rate exceeded <ai%>.' ]]
]

{ #category : #awards }
PSRetainOn2Rod >> awardName [
^'Best Ever 2-rod Retention Rate'
]

{ #category : #generation }
PSRetainOn2Rod >> computeResult [
| allPossessions controlledPossessions |

"This assumes that momentary possessions in the defence are are recorded"
allPossessions := self scanner sequence: self sequences first; scan; lastSequenceSize.
controlledPossessions := self scanner sequence: self sequences second; scan; lastSequenceSize.
^{allPossessions.controlledPossessions}

]

{ #category : #interestingness }
PSRetainOn2Rod >> relativeInterestingnessMacro [
| thisTeamResult thisTeamPossessionCount otherTeamResult otherTeamPossessionCount |
"Interesting if the passing rate was n times higher than the other team's"

^self relativeInterestingnessTrigger in: [ :trigger |
	thisTeamResult := self getResult.
	thisTeamPossessionCount := thisTeamResult result first.
	otherTeamResult := self getResultForOtherTeamAndGame.
	otherTeamPossessionCount := otherTeamResult result first.

	((thisTeamResult ratio divideBy: otherTeamResult ratio) >= trigger & (thisTeamPossessionCount > 4) & (otherTeamPossessionCount > 4))
		ifTrue: [ '<tt>''s <r1> retention rate was ',trigger asString,' times higher than <ot>''s.' ]]


]

{ #category : #generation }
PSRetainOn2Rod >> sequences [ 
^#(
	'?|.|2'	"Enter the defence area from an enemy rod"
	'?|.|2c'	"Enter the defence area from an enemy rod and then controlled"
)

]

{ #category : #UI }
PSRetainOn2Rod >> statisticBalloonMacro [
^'In <g> <tt> retained the ball on their <r1> <s2> times out of the <s1> times that the ball entered their goalie area, for a retention rate of <%d>.'
]

{ #category : #generation }
PSRetainOn2Rod >> statisticName [
^'2-rod retention'
]

{ #category : #generation }
PSRetainOn2Rod >> statisticName1 [
^'Balls in goalie area'
]

{ #category : #generation }
PSRetainOn2Rod >> statisticName2 [
^'2-rod controlled possessions'
]

{ #category : #UI }
PSRetainOn2Rod >> statisticNameBalloonText [
^'The statistics shows how well each defender retained the ball when it entered their goalie area. It is computed as the ratio of the number of controlled possession on the 2-rod to the total number of controlled or uncontrolled possessions on the same rod. This statistic relies on consistent recording of momentary possessions on the 2-rod whenever the ball enters the goalie area, even if the defender does not make contact with the ball.'
]
