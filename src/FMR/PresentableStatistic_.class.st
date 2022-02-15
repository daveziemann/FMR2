Class {
	#name : #'PresentableStatistic_',
	#superclass : #FMRObject,
	#instVars : [
		'matchState',
		'scanner',
		'resultsPerGame',
		'gameNumber',
		'isCumulativeGames'
	],
	#classInstVars : [
		'AbsoluteInterestingnessTriggerForGame',
		'AbsoluteInterestingnessTriggerForMatch',
		'RelativeInterestingnessTrigger'
	],
	#category : #FMR
}

{ #category : #interestingness }
PresentableStatistic_ class >> absoluteInterestingnessTriggerForGame [
^AbsoluteInterestingnessTriggerForGame ifNil: [ self absoluteInterestingnessTriggerForGameDefault ]
	
]

{ #category : #interestingness }
PresentableStatistic_ class >> absoluteInterestingnessTriggerForGame: aFloat [
AbsoluteInterestingnessTriggerForGame := aFloat 

	
]

{ #category : #interestingness }
PresentableStatistic_ class >> absoluteInterestingnessTriggerForGameDefault [
^nil
]

{ #category : #interestingness }
PresentableStatistic_ class >> absoluteInterestingnessTriggerForMatch [
^AbsoluteInterestingnessTriggerForMatch ifNil: [ self absoluteInterestingnessTriggerForMatchDefault ]
	
]

{ #category : #interestingness }
PresentableStatistic_ class >> absoluteInterestingnessTriggerForMatch: aFloat [ 
^AbsoluteInterestingnessTriggerForMatch := aFloat 
	
]

{ #category : #interestingness }
PresentableStatistic_ class >> absoluteInterestingnessTriggerForMatchDefault [
^nil
]

{ #category : #'instance creation' }
PresentableStatistic_ class >> allConcreteSubclasses [

^self allSubclasses reject: [ :e | e name last = $_ ]

]

{ #category : #interestingness }
PresentableStatistic_ class >> interestingnessSettingsOn: aBuilder [
<fmrsettings>

(aBuilder group: #interestingness)
	label: 'Interestingness';  
	description: 'All settings concerned with Statistics interestingness';
	parent: #statistics
]

{ #category : #testing }
PresentableStatistic_ class >> isMatchStatistic [
^false
]

{ #category : #testing }
PresentableStatistic_ class >> isTeamStatistic [
^false
]

{ #category : #interestingness }
PresentableStatistic_ class >> relativeInterestingnessTrigger [
^RelativeInterestingnessTrigger ifNil: [ self relativeInterestingnessTriggerDefault ]
	
]

{ #category : #interestingness }
PresentableStatistic_ class >> relativeInterestingnessTrigger: aFloat [
RelativeInterestingnessTrigger := aFloat 

	
]

{ #category : #interestingness }
PresentableStatistic_ class >> relativeInterestingnessTriggerDefault [
^nil
]

{ #category : #interestingness }
PresentableStatistic_ class >> resetInterestingnessTriggers [
"self resetInterestingnessTriggers"
"Reset the interestingness class instance variable values to nil,
	so that the next reference pulls the default value"

self allSubclasses do: [ :eachPresentableStatisticClass |
	eachPresentableStatisticClass absoluteInterestingnessTriggerForGame: nil.
	eachPresentableStatisticClass absoluteInterestingnessTriggerForMatch: nil.
	eachPresentableStatisticClass relativeInterestingnessTrigger: nil ]
]

{ #category : #'instance creation' }
PresentableStatistic_ class >> statisticCategories [
"If you edit this you you should probably also edit #statisticCategory"

^#(
	'Matchplay Intensity'
	'Goals Scored'
	'Conversion'
	'Pass Success'
	'Possessions'
	'Possession Time Total'
	'Possession Time Average'
	'Possession Fraction'
	'Possession Share'
	'Block and Steal'
	'Time-outs'
	'Switch Positions'
	'Ball Off Table'
)
]

{ #category : #'instance creation' }
PresentableStatistic_ class >> statisticGroups [
^#(
	'Table'
	'Team'
	'3-rod'
	'5-rod'
	'2-rod'
)
]

{ #category : #'instance creation' }
PresentableStatistic_ class >> subclassesAll [
"Answer all the subclasses in preferred presentation order"

^{
"Table"
.PSMatchIntensityActivePlay
.PSMatchIntensityGoalsPerMinute
.PSMatchIntensityPossessionChangesPerMinute
.PSMatchIntensityTransitionsPerMinute
.PSMatchIntensityChaos
.PSMatchIntensityLeadSwing
.PSMatchIntensityTimeInTransition
.PSMatchIntensityBallTravelDistance

"Team"
.PSGoalsScoredFromAnyRod
.PSPossessionCountOnAllRods
.PSPossessionShareOnAllRods
.PSPossessionTimeLimitFractionOnAllRods
.PSBlockAndStealOnAnyAdjacentRod
.PSLeadSwing
.PSMaximumConsecutiveGoals
.PSGoalsScoredInOwnGoal
.PSTimeOutTally
.PSSwitchPositionsTally

"3-rod"
.PSGoalsScoredFrom3Rod
.PSGoalsScoredFrom3RodStuff
.PSScoringFrom3Rod
.PSBlock2RodAndStealOn3Rod
.PSPossessionCountOn3Rod
.PSPossessionTotalDurationOn3Rod
.PSPossessionMeanDurationOn3Rod
.PSPossessionTimeLimitFractionOn3Rod
.PSBallOffTableFrom3Rod
.PSTimeOutsOn3Rod

"5-rod"
.PSGoalsScoredFrom5Rod
.PSScoringFrom5Rod
.PSPassingSuccess5To3
.PSPass5To3AndScore
.PSBlock2RodStealOn5RodInstaPassTo3Rod
.PSBlock5RodAndStealOn5Rod
.PSPossessionCountOn5Rod
.PSPossessionTotalDurationOn5Rod
.PSPossessionMeanDurationOn5Rod
.PSPossessionTimeLimitFractionOn5Rod
.PSBallOffTableFrom5Rod
.PSTimeOutsOn5Rod

"2-rod"
.PSGoalsScoredFrom2Rod
.PSScoringFrom2Rod
.PSGoalsScoredFrom2RodByDeflection
.PSPassingSuccess2To5
.PSPassingSuccess2To3
.PSPass2To3AndScore
.PSBlock3RodAndStealOn2Rod
.PSRetainOn2Rod
.PSPossessionCountOn2Rod
.PSPossessionTotalDurationOn2Rod
.PSPossessionMeanDurationOn2Rod
.PSPossessionTimeLimitFractionOn2Rod
.PSBallOffTableFrom2Rod
.PSTimeOutsOn2Rod
} 























]

{ #category : #'instance creation' }
PresentableStatistic_ class >> subclassesHeadline [
"Answer the headline subclasses in preferred presentation order"

^{
.PSScoringFrom3Rod
.PSPassingSuccess5To3
.PSBlock5RodAndStealOn5Rod
.PSPass5To3AndScore
.PSRetainOn2Rod
.PSPossessionShareOnAllRods
}
]

{ #category : #'instance creation' }
PresentableStatistic_ class >> subclassesHeadlineChart [
"Answer the headline subclasses for chart in preferred presentation order"

^{
.PSPossessionCountOn3Rod
.PSScoringFrom3Rod
.PSPossessionCountOn5Rod
.PSPassingSuccess5To3
.PSScoringFrom5Rod
.PSRetainOn2Rod
.PSScoringFrom2Rod
.PSPassingSuccess2To3
.PSPassingSuccess2To5
}
]

{ #category : #interestingness }
PresentableStatistic_ class >> tuneInterestingnessTriggers [
"This allows you to tune the interestingess trigger values according to how many games/matches
across all the recordings are interesting with respect to the receiver statistic class"
| cc |

"Ensure that values in modified default value methods get used"
self resetInterestingnessTriggers.

cc := OrderedCollection new.
MatchStateEnumerator new allMatchesDo: [ :eachMatchState |
	| sg ps c |
	sg := eachMatchState statisticsGenerator generate.
	ps := sg at: self.
	"tailor to one of: absoluteInterestingnessText / relativeInterestingnessText / interestingnessText"
	c := ps configuredCopiesWhere: [ ps relativeInterestingnessText notEmpty ]. 
	"tailor to one of: statisticBalloonText / interestingnessText"
	c do: [ :e | cc add: e statisticBalloonTexts ]].
cc inspect
]

{ #category : #interestingness }
PresentableStatistic_ >> absoluteInterestingnessMacro [
^nil
]

{ #category : #interestingness }
PresentableStatistic_ >> absoluteInterestingnessText [
^self absoluteInterestingnessMacro
	ifNil: [ '' ]
	ifNotNil: [ :macro | self expandMacros: macro ]
]

{ #category : #interestingness }
PresentableStatistic_ >> absoluteInterestingnessTrigger [
"Answer the value at which the absolute interestingness is triggered, a funtion of:
	- whether the receiver is configured for game or match level
	- whether the receiver's class has a match-level value"

^self gameNumber isZero
	ifTrue: [ self class absoluteInterestingnessTriggerForMatch ifNil: [ self class absoluteInterestingnessTriggerForGame ]]
	ifFalse: [ self class absoluteInterestingnessTriggerForGame ]
]

{ #category : #enumerating }
PresentableStatistic_ >> allConfigurationsDo: aBlock [
^self subclassResponsibility 
]

{ #category : #enumerating }
PresentableStatistic_ >> allGamesDo: aBlock [
self matchState gameNumbers do: [ :eachGameNumber |
	self gameNumber: eachGameNumber.
	aBlock value ]
]

{ #category : #awards }
PresentableStatistic_ >> awardName [
^''
]

{ #category : #UI }
PresentableStatistic_ >> categoryBalloonText [
^'Implement #categoryBalloonText'
]

{ #category : #UI }
PresentableStatistic_ >> colourForTeam: aTeamNumber inGame: aGameNumber [
"Let the statistic affect the colour"

^(self matchState colourForTeam: aTeamNumber inGame: aGameNumber) in: [ :colour |
	self getResult isBoring
			ifTrue:[ colour muchLighter ]
			ifFalse: [ colour ]]
]

{ #category : #generation }
PresentableStatistic_ >> computeResult [
^self subclassResponsibility 
]

{ #category : #enumerating }
PresentableStatistic_ >> configuredCopiesWhere: aBlock [
| copies |
copies := OrderedCollection new.
self allConfigurationsDo: [ aBlock value ifTrue: [ copies add: self copy ]].
^copies
]

{ #category : #UI }
PresentableStatistic_ >> displayResult: aResult [
"Override me"

^aResult asString
]

{ #category : #'UI - macros' }
PresentableStatistic_ >> expand: aString macro: aMacro with: aBlock [

^(aString indexOfSubCollection: aMacro) isZero
	ifTrue: [ aString ]
	ifFalse: [ aString copyReplaceAll: aMacro with: aBlock value ]

]

{ #category : #'UI - macros' }
PresentableStatistic_ >> expandMacros: aString [
"The methods in the blocks are only defined for statistics that can use the corresponding macros"

| newString |

newString := aString.

newString := self expand: newString macro: '<g>' with: [ self printGameOrMatch ].
newString := self expand: newString macro: '<tt>' with: [ self thisTeamName ].
newString := self expand: newString macro: '<ot>' with: [ self otherTeamName ].
newString := self expand: newString macro: '<d>' with: [ self displayResult: self getResult ].
newString := self unpluralise: '<s>' in: newString with: [ self getResult printResult ].
newString := self unpluralise: '<s1>' in: newString with: [ self getResult printResult1 ].
newString := self unpluralise: '<s2>' in: newString with: [ self getResult printResult2 ].
newString := self expand: newString macro: '<%>' with: [ self getResult printRatioAsPercentage ].
newString := self expand: newString macro: '<r1>' with: [ self rods first asString,'-rod' ].
newString := self expand: newString macro: '<r2>' with: [ self rods second asString,'-rod' ].
newString := self expand: newString macro: '<%d>' with: [ self printDeltaText ].
newString := self expand: newString macro: '<ai>' with: [ self absoluteInterestingnessTrigger asString ].
newString := self expand: newString macro: '<ai%>' with: [ self absoluteInterestingnessTrigger asString,'%' ].
^self postProcessMacros: newString


]

{ #category : #access }
PresentableStatistic_ >> gameIndex: eachGameNumber [
^eachGameNumber + eachGameNumber isZero asBit
]

{ #category : #accessing }
PresentableStatistic_ >> gameNumber [

	^ gameNumber
]

{ #category : #accessing }
PresentableStatistic_ >> gameNumber: anObject [

	gameNumber := anObject
]

{ #category : #generation }
PresentableStatistic_ >> generate [

self resultsPerGame:
	(self matchState gameNumbers
		collect: [ :eachGameNumber | self generateForGame: eachGameNumber ])
	
]

{ #category : #generation }
PresentableStatistic_ >> generateForGame: aGameNumber [
^self subclassResponsibility 
]

{ #category : #generation }
PresentableStatistic_ >> generateUsing: aStatisticsGenerator [

self isCumulativeGames: aStatisticsGenerator isCumulativeGames.
self generate.
]

{ #category : #UI }
PresentableStatistic_ >> getBackgroundColour [
"get the statistic text colour for the game/team configured in the receiver"

^self isInteresting ifTrue: [ Color brown muchLighter ]
]

{ #category : #UI }
PresentableStatistic_ >> getColour [
"get the statistic text colour for the game/team configured in the receiver"

^self colourForTeam: self teamNumber inGame: self gameNumber
]

{ #category : #access }
PresentableStatistic_ >> getResult [
"get the result for the game configured in the receiver"

^self subclassResponsibility 
]

{ #category : #access }
PresentableStatistic_ >> getResultForGame: eachGameNumber [
^self resultsPerGame
	at: eachGameNumber + (self resultsPerGame size * eachGameNumber isZero asBit)
	ifAbsent: [ ]
]

{ #category : #access }
PresentableStatistic_ >> getResultForMatch [
^self getResultForGame: 0
]

{ #category : #access }
PresentableStatistic_ >> getResultPercentage [
"get the ratio result for the game/match and express it as an integer percentage"

^(self getResult ratio * 100) rounded
]

{ #category : #'headline statistics' }
PresentableStatistic_ >> headlineStatisticName [
"Only statsitics which return a non-empty string here are used for headline results,
	in which case the string is used in place of the normal statistic name"

^''
]

{ #category : #interestingness }
PresentableStatistic_ >> interestingnessText [
^(String streamContents: [ :s |
	s << self absoluteInterestingnessText.
	s cr; cr.
	s << self relativeInterestingnessText ])
		trim


]

{ #category : #testing }
PresentableStatistic_ >> isBoring [
"Answer if this statistic is boring; boring statistics are suppressed by default
	- in general a statistic is boring if its match result is boring"

^self getResultForMatch
	ifNil: [ true ]
	ifNotNil: [ :ps | ps isBoring ]
]

{ #category : #accessing }
PresentableStatistic_ >> isCumulativeGames [

	^ isCumulativeGames
]

{ #category : #accessing }
PresentableStatistic_ >> isCumulativeGames: anObject [

	isCumulativeGames := anObject
]

{ #category : #interestingness }
PresentableStatistic_ >> isInteresting [
^self absoluteInterestingnessMacro notNil | self relativeInterestingnessMacro notNil
		
]

{ #category : #testing }
PresentableStatistic_ >> isMatchStatistic [
^self class isMatchStatistic
]

{ #category : #testing }
PresentableStatistic_ >> isTeamStatistic [
^self class isTeamStatistic
]

{ #category : #access }
PresentableStatistic_ >> lastCompletedGameScore [
"Answer the score at the end of the configured game"

^(self matchState endGameEvents at: self gameNumber) score lastCompletedGameScore
]

{ #category : #accessing }
PresentableStatistic_ >> matchState [

	^ matchState
]

{ #category : #accessing }
PresentableStatistic_ >> matchState: anObject [

	matchState := anObject
]

{ #category : #UI }
PresentableStatistic_ >> mean: aCollectionOfPSResults [
| sum |
sum := (aCollectionOfPSResults collect: [:e | e result ]) sum.
^sum isCollection 
	ifTrue: [ sum second divideBy: sum first ]
	ifFalse: [ sum divideBy: aCollectionOfPSResults size ]
]

{ #category : #UI }
PresentableStatistic_ >> mouseDown [
self inspect
]

{ #category : #comparing }
PresentableStatistic_ >> pickBest: aSimilarPresentableStatistic [

^self getResultForMatch largestValue > aSimilarPresentableStatistic getResultForMatch largestValue
	ifTrue: [ self ]
	ifFalse: [ aSimilarPresentableStatistic ]
]

{ #category : #'UI - macros' }
PresentableStatistic_ >> postProcessMacros: aString [
^aString capitalized
]

{ #category : #access }
PresentableStatistic_ >> primitiveResults [
"Answer an Array of the receiver's primitive results"

^self resultsPerGame collect: [ :e | e primitiveResults ]
]

{ #category : #UI }
PresentableStatistic_ >> printGameOrMatch [
^self gameNumber isZero
	ifTrue: [ 'the whole match' ]
	ifFalse: [ 'game ',self gameNumber asString ]
]

{ #category : #UI }
PresentableStatistic_ >> printGameSummary [
^String streamContents: [ :s |
	self gameNumber isZero ifTrue: [ s << 'Match' ] ifFalse: [ s << 'Game '; << self gameNumber asString ].
	s << ': '; << self statisticCategory; << ': '; << self statisticName.
	self teamNumber: 1. s cr; << self statisticBalloonText; space; << self absoluteInterestingnessText.
	self teamNumber: 2. s cr; << self statisticBalloonText; space; << self absoluteInterestingnessText.
	self teamNumber: 1. self relativeInterestingnessText ifNotEmpty: [ :t | s cr; << t ].
	self teamNumber: 2. self relativeInterestingnessText ifNotEmpty: [ :t | s cr; << t ]]
]

{ #category : #access }
PresentableStatistic_ >> printScoreFromWinnersPerspective [
"Answer a string, the score from the winner's perspective, at the end of the configured game"

^String streamContents: [ :s |
	self lastCompletedGameScore pointScore asSortedCollection reversed
		do: [ :e | s << e asString ]
		separatedBy: [ s << $- ]]
]

{ #category : #interestingness }
PresentableStatistic_ >> relativeInterestingnessMacro [
^nil
]

{ #category : #interestingness }
PresentableStatistic_ >> relativeInterestingnessText [
^self relativeInterestingnessMacro
	ifNil: [ '' ]
	ifNotNil: [ :macro | self expandMacros: macro ]
]

{ #category : #interestingness }
PresentableStatistic_ >> relativeInterestingnessTrigger [
"Answer the value at which the relative interestingness is triggered:
	- the ratio of the metric of the two teams
	- here assumed to be the same for each game and the whole match"

^self class relativeInterestingnessTrigger
]

{ #category : #accessing }
PresentableStatistic_ >> resultsPerGame [

	^ resultsPerGame
]

{ #category : #accessing }
PresentableStatistic_ >> resultsPerGame: anObject [

	resultsPerGame := anObject
]

{ #category : #generation }
PresentableStatistic_ >> scanner [
^scanner ifNil: [ scanner := self scanner_ ]
]

{ #category : #accessing }
PresentableStatistic_ >> scanner: anObject [

	scanner := anObject
]

{ #category : #generation }
PresentableStatistic_ >> scanner_ [
^MatchplayEventScanner new
	matchState: self matchState;
	isCumulativeGames: self isCumulativeGames;
	sequence: self sequence;
	yourself
]

{ #category : #generation }
PresentableStatistic_ >> sequence [
"Overidden when needed"

^''
]

{ #category : #generation }
PresentableStatistic_ >> sequences [
"Overidden when needed"

^{self sequence}
]

{ #category : #UI }
PresentableStatistic_ >> statisticBalloonMacro [
"self expandMacros: '<g> <tt> <ot> <s> <s1> <s2> <r1> <r2> <%>' "

^'Implement #statisticBalloonText'

]

{ #category : #UI }
PresentableStatistic_ >> statisticBalloonMacros [
^{self statisticBalloonMacro.self absoluteInterestingnessMacro.self relativeInterestingnessMacro}
]

{ #category : #UI }
PresentableStatistic_ >> statisticBalloonText [
^self statisticBalloonMacro
	ifNil: [ '' ]
	ifNotNil: [ :macro | self expandMacros: macro ]
]

{ #category : #UI }
PresentableStatistic_ >> statisticBalloonTexts [
^String streamContents: [ :s |
	s << self statisticBalloonText.
	self interestingnessText ifNotEmpty: [ :t | s cr; cr; << t ]]

]

{ #category : #UI }
PresentableStatistic_ >> statisticCategory [ 
^'Statistic Category'
]

{ #category : #UI }
PresentableStatistic_ >> statisticCategoryBalloonText [
^'Implement #statisticCategoryBalloonText'
]

{ #category : #UI }
PresentableStatistic_ >> statisticGroup [
^'Statistic Group'
]

{ #category : #UI }
PresentableStatistic_ >> statisticGroupBalloonText [
^self statisticGroupBalloonText: self statisticGroup 
]

{ #category : #UI }
PresentableStatistic_ >> statisticGroupBalloonText: aString [
aString = 'Table'
	ifTrue: [ ^'Table statistics quantify aspects of matchplay that don''t relate to an individual team, but to both teams taken together. Table statistics do not compare the two teams.' ].
	
aString = 'Team'
	ifTrue: [ ^'Team statistics provide a comparison between the two teams for a specific aspect of matchplay. Team statistics apply to each team as a whole, and do not drill down to the level of a specific rod.' ].
	
^aString,' statistics compare the two teams in relation to activity that occurs specifically on the ',aString
]

{ #category : #UI }
PresentableStatistic_ >> statisticName [
^self class name
]

{ #category : #UI }
PresentableStatistic_ >> statisticNameBalloonText [
^'Implement #statisticNameBalloonText'
]

{ #category : #UI }
PresentableStatistic_ >> statisticNameBalloonTextWithTechnical [
^String streamContents: [ :s |
	s << self statisticNameBalloonText.
	self sequences size = 1 ifTrue: [ s cr; cr; << 'Technical: Detection sequence is: '; << self sequence ].
	self sequences size > 1 ifTrue: [ s cr; cr; << 'Technical: Detection sequences are: '; << (Character tab join: self sequences) ]]
	
]

{ #category : #UI }
PresentableStatistic_ >> teamIDBalloonText [
^'#teamIDBalloonText'
]

{ #category : #access }
PresentableStatistic_ >> teamNumber [
^self subclassResponsibility 
]

{ #category : #'UI - macros' }
PresentableStatistic_ >> unpluralise: aMacro in: string with: aBlock [
"Unpluralise the word following the macro by removing the trailing 's' if the macro value is = 1"

| index result sIndex betterString |

(index := string indexOfSubCollection: aMacro) isZero ifTrue: [ ^string ].
result := aBlock value.
sIndex := string indexOfSubCollection: 's ' startingAt: index + aMacro size.
sIndex isZero ifTrue: [
	sIndex := string indexOfSubCollection: 's.' startingAt: index + aMacro size ].
betterString := (sIndex > 0) & (result asNumber = 1)
	ifTrue: [ (string copyFrom: 1 to: sIndex - 1),(string copyFrom: sIndex + 1 to: string size) ]
	ifFalse: [ string ].
^betterString copyReplaceAll: aMacro with: result.

]
