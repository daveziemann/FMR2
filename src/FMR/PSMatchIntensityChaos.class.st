Class {
	#name : #PSMatchIntensityChaos,
	#superclass : #'PSMatchIntensity_',
	#category : #FMR
}

{ #category : #interestingness }
PSMatchIntensityChaos class >> absoluteInterestingnessTriggerForGameDefault [
^30
]

{ #category : #interestingness }
PSMatchIntensityChaos class >> absoluteInterestingnessTriggerForMatchDefault [
^30
]

{ #category : #interestingness }
PSMatchIntensityChaos class >> interestingnessSettingsOn: aBuilder [
<fmrsettings>

(aBuilder setting: #absoluteInterestingnessTriggerForGame)
	parent: #interestingness;
	label: 'Chaos for Game'; 
	target: self;
	default: self absoluteInterestingnessTriggerForGameDefault;
	description: 'The Chaos is the ratio of the number of uncontrolled possessions divided by the total number of possession, controlled or uncontrolled, expressed as a percentage. Set the percentage to be exceeded at game level for the statistic to become interesting.'.

(aBuilder setting: #absoluteInterestingnessTriggerForMatch)
	parent: #interestingness;
	label: 'Chaos for Match'; 
	target: self;
	default: self absoluteInterestingnessTriggerForMatchDefault;
	description: 'The Chaos is the ratio of the number of uncontrolled possessions divided by the total number of possession, controlled or uncontrolled, expressed as a percentage. Set the percentage to be exceeded at match level for the statistic to become interesting.'.

]

{ #category : #interestingness }
PSMatchIntensityChaos >> absoluteInterestingnessMacro [
"Interesting if the active play fraction exceeds a critical value"

^self absoluteInterestingnessTrigger in: [ :trigger |
	self getResultPercentage >= trigger
		ifTrue: [ 'The chaos in <g> exceeded <ai%>.' ]]
]

{ #category : #generation }
PSMatchIntensityChaos >> computeResult [
"Chaos is the ratio of the number of uncontrolled possessions to the total number of possessions"

| uncontrolledPossessions totalPossessions |

uncontrolledPossessions := self scanner sequence: '?u'; scan; lastSequenceSize.
totalPossessions := self scanner sequence: '?'; scan; lastSequenceSize.
^{totalPossessions.uncontrolledPossessions}
]

{ #category : #UI }
PSMatchIntensityChaos >> displayResult: aMatchResult [

^aMatchResult printAsRatioAndPercentage
]

{ #category : #generation }
PSMatchIntensityChaos >> sequence [
^'?u'
]

{ #category : #UI }
PSMatchIntensityChaos >> statisticBalloonMacro [
^'During <g> there were <s2> uncontrolled possessions out of a total of <s1> possessions (controlled and uncontrolled), for a chaos figure of <%>.'
]

{ #category : #UI }
PSMatchIntensityChaos >> statisticName [
^'Chaos'
]

{ #category : #UI }
PSMatchIntensityChaos >> statisticNameBalloonText [
^'The number of uncontrolled possessions is a measure of the how chaotic the matchplay is. The statistic is computed by dividing the total number of uncontrolled possessions by the total number of possessions, both controlled and uncontrolled, expressed as a percentage to give a chaos value.'
]
