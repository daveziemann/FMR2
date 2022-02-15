Class {
	#name : #'PSScoringSuccess_',
	#superclass : #'PresentableTeamStatistic_',
	#category : #FMR
}

{ #category : #interestingness }
PSScoringSuccess_ class >> interestingnessSettingsOn: aBuilder forClass: aClass [

(aBuilder setting: #absoluteInterestingnessTriggerForGame)
	parent: #interestingness;
	label: (aClass new expandMacros: 'Conversion Rate on <r1> for Game'); 
	target: aClass;
	default: aClass absoluteInterestingnessTriggerForGameDefault;
	description: 'The Conversion rate from a rod is the percentage of controlled possessions on that rod divided by the number of goals scored from that rod, expressed as a percentage. Enter the minimum % at which it becomes interesting for a game.'.

(aBuilder setting: #absoluteInterestingnessTriggerForMatch)
	parent: #interestingness;
	label: (aClass new expandMacros: 'Conversion Rate on <r1> for Game'); 
	target: aClass;
	default: aClass absoluteInterestingnessTriggerForMatchDefault;
	description: 'The Conversion rate from a rod is the percentage of controlled possessions on that rod divided by the number of goals scored from that rod, expressed as a percentage. Enter the minimum % at which it becomes interesting for a match.'.

]

{ #category : #UI }
PSScoringSuccess_ >> absoluteInterestingnessMacro [
"Interesting if the scoring rate exceeds a critical value"

^self absoluteInterestingnessTrigger in: [ :trigger | | possessionCount |
	possessionCount := self getResult result first.
	^(self getResultPercentage > trigger & (possessionCount > 3))
		ifTrue: [ '<tt>''s scoring rate on the <r1> exceeded <ai%>.' ]]
]

{ #category : #UI }
PSScoringSuccess_ >> displayResult: aTeamResult [
"Override me"

^aTeamResult printAsRatioAndPercentage
]

{ #category : #generation }
PSScoringSuccess_ >> extractScannerResult [
^self scanner firstAndLastSequenceSize
]

{ #category : #UI }
PSScoringSuccess_ >> relativeInterestingnessMacro [
"Interesting if the conversion rate was n times better than the other team's"

| thisTeamResult thisTeamPossessions thisTeamConversionRate otherTeamConversionRate factor |

thisTeamResult := self getResult.
thisTeamPossessions := thisTeamResult result first.
thisTeamConversionRate := thisTeamResult ratio.
otherTeamConversionRate := self getResultForOtherTeamAndGame ratio.
factor := (thisTeamConversionRate divideBy: otherTeamConversionRate) asFloat round: 1.
^(factor >= 2) & (thisTeamPossessions > 4) ifTrue: [
	'<tt>''s <r1> conversion rate was ',factor asString,' times higher than <ot>''s.' ]

]

{ #category : #UI }
PSScoringSuccess_ >> statisticBalloonMacro [
^'In <g> <tt> scored a total of <s2> goals out of <s1> possessions on the <r1> for a conversion rate of <%d>.'
]

{ #category : #UI }
PSScoringSuccess_ >> statisticCategory [ 
^'Conversion'
]

{ #category : #UI }
PSScoringSuccess_ >> statisticCategoryBalloonText [
^'How good was each team at scoring clean goals from each of their rods?'
]

{ #category : #UI }
PSScoringSuccess_ >> statisticName [
^self expandMacros: '<r1> conversion rate'

]

{ #category : #UI }
PSScoringSuccess_ >> statisticName1 [
^self expandMacros: '<r1> controlled possessions'

]

{ #category : #UI }
PSScoringSuccess_ >> statisticName2 [
^self expandMacros: '<r1> goals scored'

]

{ #category : #UI }
PSScoringSuccess_ >> statisticNameBalloonText [
^self expandMacros: 'How successful was each team in scoring clean goals from their <r1>? The statistic is generated from the ratio of the number of clean goals scored to the number of controlled possessions on the <r1>.'
]
