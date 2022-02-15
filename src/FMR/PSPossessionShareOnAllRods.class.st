Class {
	#name : #PSPossessionShareOnAllRods,
	#superclass : #'PSPossessionShare_',
	#category : #FMR
}

{ #category : #interestingness }
PSPossessionShareOnAllRods class >> absoluteInterestingnessTriggerForGameDefault [
^60
]

{ #category : #interestingness }
PSPossessionShareOnAllRods class >> absoluteInterestingnessTriggerForMatchDefault [
^60
]

{ #category : #interestingness }
PSPossessionShareOnAllRods class >> interestingnessSettingsOn: aBuilder [
<fmrsettings>

(aBuilder setting: #absoluteInterestingnessTriggerForGame)
	parent: #interestingness;
	label: 'Possession Share for Game'; 
	target: self;
	default: self absoluteInterestingnessTriggerForGameDefault;
	description: 'The Possession Share shows how the teams shared the total possession time across all of the rods. Set the percentage to be exceeded at game level for the statistic to become interesting.'.

(aBuilder setting: #absoluteInterestingnessTriggerForMatch)
	parent: #interestingness;
	label: 'Possession Share for Match'; 
	target: self;
	default: self absoluteInterestingnessTriggerForMatchDefault;
	description: 'The Possession Share shows how the teams shared the total possession time across all of the rods. Set the percentage to be exceeded at match level for the statistic to become interesting.'.

]

{ #category : #interestingness }
PSPossessionShareOnAllRods >> absoluteInterestingnessMacro [
^self absoluteInterestingnessTrigger in: [ :trigger |
	^self getResultPercentage > trigger
		ifTrue: [ '<tt> had more than <ai%> of the total possession time across all of the rods.' ]]
]

{ #category : #UI }
PSPossessionShareOnAllRods >> asString [
^String streamContents: [ :s | s
	<< self statisticCategory;
	cr;
	<< ' for ';
	<< self thisTeamName;
	cr;
	<< ' in ';
	<< self printGameOrMatch;
	cr;
	<< ' was ';
	<< self displayResultForTeamAndGame ]
	
]

{ #category : #generation }
PSPossessionShareOnAllRods >> computeResult [
| thisTeamDuration otherTeamDuration |

thisTeamDuration := self scanner scan; lastSequenceTotalDuration.
otherTeamDuration := self scanner beForOtherTeam scan; lastSequenceTotalDuration.
^{thisTeamDuration + otherTeamDuration . thisTeamDuration}

]

{ #category : #UI }
PSPossessionShareOnAllRods >> displayResult: aTeamResult [
"Override me"

^aTeamResult printDurationsAsRatioAndPercentage
]

{ #category : #'headline statistics' }
PSPossessionShareOnAllRods >> headlineStatisticName [
"Only statsitics which return a non-empty string here are used for headline results,
	in which case the string is used in place of the normal statistic name"

^self statisticName
]

{ #category : #generation }
PSPossessionShareOnAllRods >> sequence [
^'?c'
]

{ #category : #UI }
PSPossessionShareOnAllRods >> statisticBalloonMacro [
^'In <g> <tt> had controlled possession of the ball for a total of <s2> out of a total of <s1> for both teams, which was <%> of the total controlled possession time.'
]

{ #category : #UI }
PSPossessionShareOnAllRods >> statisticName [
^'Possession share across all rods'
]

{ #category : #UI }
PSPossessionShareOnAllRods >> statisticNameBalloonText [
^self expandMacros: 'Over the whole game or match, how did the two teams share the total amount of time the ball was under controlled possession on any of their rods?'
]
