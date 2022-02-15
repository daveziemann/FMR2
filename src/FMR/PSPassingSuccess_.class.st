Class {
	#name : #'PSPassingSuccess_',
	#superclass : #'PresentableTeamStatistic_',
	#category : #FMR
}

{ #category : #interestingness }
PSPassingSuccess_ class >> interestingnessSettingsOn: aBuilder forClass: aClass [

(aBuilder setting: #absoluteInterestingnessTriggerForGame)
	parent: #interestingness;
	label: (aClass new expandMacros: 'Passing Success <r1> to <r2> for Game'); 
	target: aClass;
	default: aClass absoluteInterestingnessTriggerForGameDefault;
	description: 'The Passing Success rate is the percentage of controlled possessions on the passing rod divided by the number for successful clean passes to the catching rod, expressed as a percentage. Enter the minimum % at which it becomes interesting for a game.'.

(aBuilder setting: #absoluteInterestingnessTriggerForMatch)
	parent: #interestingness;
	label: (aClass new expandMacros: 'Passing Success <r1> to <r2> for Match'); 
	target: aClass;
	default: aClass absoluteInterestingnessTriggerForMatchDefault;
	description: 'The Passing Success rate is the percentage of controlled possessions on the passing rod divided by the number for successful clean passes to the catching rod, expressed as a percentage. Enter the minimum % at which it becomes interesting for a match.'.

]

{ #category : #interestingness }
PSPassingSuccess_ >> absoluteInterestingnessMacro [
"Interesting if the passing rate exceeds a critical value"

^self absoluteInterestingnessTrigger in: [ :trigger | | possessionCount |
	possessionCount := self getResult result first.
	^(self getResultPercentage > trigger & (possessionCount > 2))
		ifTrue: [ 'Their passing success rate from the <r1> to the <r2> exceeded <ai%>.' ]]

]

{ #category : #UI }
PSPassingSuccess_ >> displayResult: aTeamResult [
"Override me"

^aTeamResult printAsRatioAndPercentage
]

{ #category : #generation }
PSPassingSuccess_ >> extractScannerResult [

^self scanner firstAndLastSequenceSize
]

{ #category : #UI }
PSPassingSuccess_ >> statisticBalloonMacro [
^'In <g> <tt> made a total of <s2> successful passes to the <r2> out of <s1> possessions on the <r1> for a pass success rate rate of <%d>.'
]

{ #category : #UI }
PSPassingSuccess_ >> statisticCategory [ 
^'Pass Success'
]

{ #category : #UI }
PSPassingSuccess_ >> statisticCategoryBalloonText [
^'How successful was each team at passing the ball? FMR does not know if a pass was intended, and only knows if there was in fact a pass. FMR considers a pass to have occurred when a controlled possession on the source rod is immediately followed by a controlled possession on another rod on the same team.'
]

{ #category : #UI }
PSPassingSuccess_ >> statisticName [
^self expandMacros: '<r1> pass to <r2>'
]

{ #category : #UI }
PSPassingSuccess_ >> statisticName1 [
^self expandMacros: '<r1> controlled possessions'
]

{ #category : #UI }
PSPassingSuccess_ >> statisticName2 [
^self expandMacros: '<r1> passes to <r2>'
]

{ #category : #UI }
PSPassingSuccess_ >> statisticNameBalloonText [
^self expandMacros: 'Pass Success from the <r1> to the <r2>. This is computed by considering the number of controlled possessions on the <r1> followed by controlled possessions on the <r2>.'
]
