Class {
	#name : #MatchplayEventScanner,
	#superclass : #FMRStatistics,
	#instVars : [
		'matchState',
		'minimumDurationForControlledPossession',
		'gameNumber',
		'teamNumber',
		'sequence',
		'sequenceCollection',
		'sequenceEvents',
		'isCumulativeGames'
	],
	#category : #FMR
}

{ #category : #'calculations - specific' }
MatchplayEventScanner >> ballTravelDistance [
"Answer the ball travel distance in cm"

^self ballTravelDistances sumNumbers rounded

]

{ #category : #'calculations - specific' }
MatchplayEventScanner >> ballTravelDistances [
"Answer the ball travel distances in cm"

"Select all Rod and Goal events for the receiver's game configuration"
self sequenceEvents: {(self selectForConfiguration select: [ :eachMatchplayEvent | eachMatchplayEvent isPseudoRod ])}.
^(1 to: self lastSequenceSize - 1) collect: [ :i |
		(self lastSequence at: i) distanceToRodOrGoal: (self lastSequence at: i+1) ].

]

{ #category : #scanning }
MatchplayEventScanner >> beForOtherTeam [
"The receiver has already been configured for one team; flip it"

self teamNumber: 3-self teamNumber
]

{ #category : #copying }
MatchplayEventScanner >> copyForSequence: aString [
"Be careful not to harm my sequence configuration"

^self copy sequence: aString
]

{ #category : #scanning }
MatchplayEventScanner >> filterGameNumber: aMatchplayEvent [
"Game 0 means the entire match"

self gameNumber = 0 ifTrue: [ ^true ].
^self isCumulativeGames
	ifTrue: [ aMatchplayEvent gameNumber <= self gameNumber ]
	ifFalse: [ aMatchplayEvent gameNumber = self gameNumber ]
]

{ #category : #scanning }
MatchplayEventScanner >> filterTeamNumber: aMatchplayEvent [
"Team 0 means either team. For rods the team that owns the event is the same as Possession, but for other events the owning team is determined according to the class of event"

^self teamNumber = 0 or: [ aMatchplayEvent teamWithOwnershipIndex = self teamNumber ]
]

{ #category : #'calculations - generic' }
MatchplayEventScanner >> firstAndLastSequenceSize [

^{self firstSequenceSize.self lastSequenceSize}
]

{ #category : #'calculations - generic' }
MatchplayEventScanner >> firstSequence [

^self sequenceEvents first
]

{ #category : #'calculations - generic' }
MatchplayEventScanner >> firstSequenceSize [

^self firstSequence size
]

{ #category : #accessing }
MatchplayEventScanner >> gameNumber [

	^ gameNumber
]

{ #category : #accessing }
MatchplayEventScanner >> gameNumber: anObject [

	gameNumber := anObject
]

{ #category : #scanning }
MatchplayEventScanner >> generateSequenceEvents [
| nextSequence |

"Filter the matchplay events in the initial sequence to the transition event for the configured game and team"
nextSequence := self selectForConfiguration.

^self sequenceCollection collect: [ :eachEventSpec |
	| interimSequence |
	interimSequence := nextSequence select: [ :eachMatchplayEvent | self matchplayEvent: eachMatchplayEvent matches: eachEventSpec ].
	nextSequence := interimSequence collect: [ :eachMatchplayEvent | eachMatchplayEvent nextMatchplayEvent ].
	interimSequence ]
]

{ #category : #initialization }
MatchplayEventScanner >> initialize [ 

"Set the minimum duration for possession to be considered controlled, in msecs"
self minimumDurationForControlledPossession: StatisticsGenerator minimumDurationForControlledPossession
]

{ #category : #accessing }
MatchplayEventScanner >> isCumulativeGames [

^isCumulativeGames ifNil: [ false ]
]

{ #category : #accessing }
MatchplayEventScanner >> isCumulativeGames: anObject [

	isCumulativeGames := anObject
]

{ #category : #'calculations - generic' }
MatchplayEventScanner >> lastEvent [
"Answer the last event in the last sequence"

^self lastSequence last
]

{ #category : #'calculations - generic' }
MatchplayEventScanner >> lastEventDuration [

^Duration milliSeconds: (self lastSequence last durationOrZero)
]

{ #category : #'calculations - generic' }
MatchplayEventScanner >> lastSequence [

^self sequenceEvents last
]

{ #category : #'calculations - generic' }
MatchplayEventScanner >> lastSequenceDurations [
"For each event in the last sequence, answer its duration"

^self lastSequence collect: [ :eachMatchplayEvent | Duration milliSeconds: eachMatchplayEvent durationOrZero ]
]

{ #category : #'calculations - generic' }
MatchplayEventScanner >> lastSequenceMeanDuration [
^self lastSequenceTotalDuration divideBy: self lastSequenceSize
]

{ #category : #'calculations - generic' }
MatchplayEventScanner >> lastSequenceSize [

^self lastSequence size
]

{ #category : #'calculations - generic' }
MatchplayEventScanner >> lastSequenceTimeLimits [
"For each event in the last sequence answer a Duration, the time limit for that event"

^self lastSequence collect: [ :eachMatchplayEvent | eachMatchplayEvent timeLimit ]
]

{ #category : #'calculations - generic' }
MatchplayEventScanner >> lastSequenceTotalDuration [

^Duration milliSeconds: (self lastSequence inject: 0 into: [ :c :e | c+e durationOrZero ])
]

{ #category : #'calculations - specific' }
MatchplayEventScanner >> leadSwingTally [
"Answer the total amount of times that the configured team took the lead"
	
"Be careful not to harm my sequence configuration"
^((self copyForSequence: '#') scan lastSequence
	collect: [ :eachGoalEventForTeam | eachGoalEventForTeam takesTheLead asBit ]) sumNumbers
]

{ #category : #accessing }
MatchplayEventScanner >> matchState [

	^ matchState
]

{ #category : #accessing }
MatchplayEventScanner >> matchState: anObject [

	matchState := anObject
]

{ #category : #scanning }
MatchplayEventScanner >> matchplayEvent: aMatchplayEvent matches: eachEventSpec [

aMatchplayEvent ifNil: [ ^false ].

"Asterisk selects any duration recording event"
eachEventSpec first = $* ifTrue: [  ^true ].

"Special processing for any Rod specification"
('253?' includes: eachEventSpec first) ifTrue: [ ^self rodPossessionEvent: aMatchplayEvent matches: eachEventSpec ].

"Looking for something that isn't a Rod"
^aMatchplayEvent representation = eachEventSpec first





]

{ #category : #'calculations - specific' }
MatchplayEventScanner >> maximumConsecutiveGoals [
"Answer the maximum number of consecutive goals scored by the configured team in this game"
| maximumConsecutiveGoals |

maximumConsecutiveGoals := 0.
(RunArray newFrom: self teamScoringEachGoal) runsAndValuesDo: [ :goals :team |
	self teamNumber = team ifTrue: [ maximumConsecutiveGoals := maximumConsecutiveGoals max: goals ]].
^maximumConsecutiveGoals
	
]

{ #category : #accessing }
MatchplayEventScanner >> minimumDurationForControlledPossession [

	^ minimumDurationForControlledPossession
]

{ #category : #accessing }
MatchplayEventScanner >> minimumDurationForControlledPossession: anObject [

	minimumDurationForControlledPossession := anObject
]

{ #category : #'calculations - specific' }
MatchplayEventScanner >> pointTarget [
"Answer the point target in the configured game, or for the match, the sum of the game point targets
	- FMR doesn't know what the game point target actually is, so infer it by the score at the end of each game"

^(self copyForSequence: '/') scan lastSequence
	inject: 0 
	into: [ :pointTarget :eachEndGameEvent |
		pointTarget + eachEndGameEvent score lastCompletedGameScore maximum ]
]

{ #category : #printing }
MatchplayEventScanner >> printOn: aStream [

aStream << self sequence asString.
aStream << ' G:'.
self gameNumber printOn: aStream.
aStream << ' T:'.
self teamNumber printOn: aStream.
aStream << ' : '.
self sequenceEvents ifNotNil: [ 
	aStream << (self sequenceEvents asArray collect: [ :e | e size ]) asString ].
aStream flush.
]

{ #category : #scanning }
MatchplayEventScanner >> rodPossessionEvent: aMatchplayEvent matches: eachEventSpec [

"Continue if matchplay event is a Rod possession"
('253' includes: aMatchplayEvent representation) ifFalse: [ ^false ].

"Continue if event spec is the wild rod or the matchplay event Rod"
(eachEventSpec first = $?) | (eachEventSpec first = aMatchplayEvent representation) ifFalse: [ ^false ].

"We have a match if we don't care about possession duration"		
eachEventSpec size = 1 ifTrue: [ ^true ].

"Match if we are looking for an uncontrolled possession and the Rod duration < the critical value"
eachEventSpec second = $u ifTrue: [ ^aMatchplayEvent isUncontrolledPossessionEvent ].

"Match if we are looking for a controlled possession and the Rod duration >= the critical value"
eachEventSpec second = $c ifTrue: [ ^aMatchplayEvent isControlledPossessionEvent ].

self error: 'oops'

]

{ #category : #scanning }
MatchplayEventScanner >> scan [
self sequenceEvents: self generateSequenceEvents
]

{ #category : #scanning }
MatchplayEventScanner >> selectForConfiguration [
"Answer those matchplay events which are selected for by the receiver's configuration"

"Select those duration-recording events (not commands or comments) which occur in the configured game and are 'owned' by the configured team"
^self matchState matchplayEvents select: [ :eachMatchplayEvent |
	eachMatchplayEvent isMatchplayEvent and: [ 
		(self filterGameNumber: eachMatchplayEvent) & (self filterTeamNumber: eachMatchplayEvent) ]]
]

{ #category : #accessing }
MatchplayEventScanner >> sequence [

	^ sequence
]

{ #category : #scanning }
MatchplayEventScanner >> sequence: anObject [
sequence := anObject.
self sequenceCollection: (self sequence tokensBasedOn: '|')
]

{ #category : #accessing }
MatchplayEventScanner >> sequenceCollection [

	^ sequenceCollection
]

{ #category : #accessing }
MatchplayEventScanner >> sequenceCollection: anObject [

	sequenceCollection := anObject
]

{ #category : #accessing }
MatchplayEventScanner >> sequenceEvents [

	^ sequenceEvents
]

{ #category : #accessing }
MatchplayEventScanner >> sequenceEvents: anObject [

	sequenceEvents := anObject
]

{ #category : #accessing }
MatchplayEventScanner >> teamNumber [

	^ teamNumber
]

{ #category : #accessing }
MatchplayEventScanner >> teamNumber: anObject [

	teamNumber := anObject
]

{ #category : #'calculations - specific' }
MatchplayEventScanner >> teamScoringEachGoal [
"Answer the team number that scored each of the goals in the configured game"
	
"Be careful not to harm my sequence configuration"
^(self copyForSequence: '#') in: [ :scanner |
	scanner teamNumber: 0; scan.
	scanner lastSequence collect: [:eachGoalEventForTeam | eachGoalEventForTeam teamWithOwnershipIndex ]]

]

{ #category : #'calculations - specific' }
MatchplayEventScanner >> totalActivePlayTime [
"Answer the total amount of time spent in Active Play during the game/match
	- the total amount of time on all the rods plus the total time in transition"
	
^self totalPossessionTime + self totalTransitionTime
]

{ #category : #'calculations - specific' }
MatchplayEventScanner >> totalPossessionTime [
"Answer the total amount of time spent on all of the rods during Active Play in the game/match"
	
"Be careful not to harm my sequence configuration"
^(self copyForSequence: '?') scan lastSequenceTotalDuration
]

{ #category : #'calculations - specific' }
MatchplayEventScanner >> totalTransitionTime [
"Answer the total amount of time spent in transition during Active Play in the game/match
	- this is the time allocated to Possession Flip and it should be relatively small"
	
"Be careful not to harm my sequence configuration"
^(self copyForSequence: '.') scan lastSequenceTotalDuration
]
