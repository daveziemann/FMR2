Class {
	#name : #MatchplayEvent,
	#superclass : #FMRObject,
	#instVars : [
		'representation',
		'duration',
		'detail',
		'creationTime',
		'matchState',
		'teamWithPossession_',
		'gameNumber_',
		'eventIndex_',
		'score_',
		'flagged'
	],
	#classVars : [
		'CharacterToClassMap'
	],
	#category : #FMR
}

{ #category : #accessing }
MatchplayEvent class >> activeRecordingCharacters [ 
"Answer the set of characters which will be recognised during Active Recording
	- each character will be mapped onto one of my subclasses"
	
^'532.#^_ts!:'
]

{ #category : #accessing }
MatchplayEvent class >> allConcreteSubclasses [
^self withAllSubclasses reject: [:ea | ea representation isNil ]
]

{ #category : #accessing }
MatchplayEvent class >> characterToClassMap [

^CharacterToClassMap ifNil: [ CharacterToClassMap := self mapCharacterToClass ]
]

{ #category : #accessing }
MatchplayEvent class >> characterToClassMap: anObject [

	CharacterToClassMap := anObject
]

{ #category : #accessing }
MatchplayEvent class >> mapCharacterToClass [

^self allConcreteSubclasses
	inject: Dictionary new
	into: [ :dict :eachClass |
		(self activeRecordingCharacters includes: eachClass representation)
			ifTrue: [
				dict
					at: eachClass representation
					put: eachClass ].
				dict ]
]

{ #category : #'instance creation' }
MatchplayEvent class >> newFromCharacter: aCharacter inMatchState: aMatchState [
			
^(self characterToClassMap at: aCharacter ifAbsent: [ ^nil ]) new
	matchState: aMatchState;
	representation: aCharacter;
	yourself

		
		
		
]

{ #category : #accessing }
MatchplayEvent class >> representation [ 
^nil 
]

{ #category : #stats }
MatchplayEvent >> adjustScore: aMatchScore [
^aMatchScore
]

{ #category : #access }
MatchplayEvent >> asDuration [
^Duration milliSeconds: self durationOrZero
]

{ #category : #'UI - graphics' }
MatchplayEvent >> asShapes [
"Answer a collection of shapes that represents the receiver"

^(MatchplayEventDNA new matchplayEvent: self) asShapes
]

{ #category : #printing }
MatchplayEvent >> asTextWithAttributes: aString [

^aString asText in: [ :text |
	text addAttribute: (TextColor new color: self colour).
	self isBold ifTrue: [ text addAttribute: TextEmphasis bold ].
	text ]
]

{ #category : #'UI - graphics' }
MatchplayEvent >> boxColour [
"Answer the colour for the box, generally the colour of the owning event, except all pauses are neutral"

^self colour
]

{ #category : #printing }
MatchplayEvent >> colour [ 

^self sideWithPossession colour
]

{ #category : #copying }
MatchplayEvent >> copyWithCurrentDuration [
"Answer a copy of the recevier, a duration-recording matchplay event, with its current duration burned in, for display"

^self copy
	eventIndex_: nil;
	duration: self matchState matchplayTimer peekDurationSinceLastQuery asMilliSeconds
]

{ #category : #accessing }
MatchplayEvent >> creationTime [

	^ creationTime
]

{ #category : #accessing }
MatchplayEvent >> creationTime: anObject [

	creationTime := anObject
]

{ #category : #access }
MatchplayEvent >> currentlyWinningTeamInGame [
^self score currentGameScore currentlyWinningTeam
]

{ #category : #accessing }
MatchplayEvent >> detail [

	^ detail
]

{ #category : #accessing }
MatchplayEvent >> detail: anObject [

	detail := anObject
]

{ #category : #accessing }
MatchplayEvent >> duration [

	^ duration
]

{ #category : #accessing }
MatchplayEvent >> duration: anObject [
"anObject ifNotNil:[ anObject negative ifTrue: [ self halt ]]."

duration := anObject.
self hasEventIndex ifTrue: [ Transcript crShow: 'Duration set: ',self printFully ]

]

{ #category : #access }
MatchplayEvent >> durationOrZero [
"Answer the duration of this event in milliSeconds, 0 if no dureation recorded"

^self duration ifNil: [ 0 ]
]

{ #category : #printing }
MatchplayEvent >> durationOverrunFactor [
"Answer the factor by which the receiver's duration overran its expected reasonable maximum"

^self durationOrZero divideBy: self reasonableMaximumDuration asMilliSeconds
]

{ #category : #comparing }
MatchplayEvent >> equals: anotherMatchplayEvent [

^self class = anotherMatchplayEvent class 
	and: [ self representation = anotherMatchplayEvent representation
		and: [ self detail = anotherMatchplayEvent detail
			and: [ self duration = anotherMatchplayEvent duration ]]]
]

{ #category : #access }
MatchplayEvent >> eventIndex [
"Event index is nil or 0 before the event has been added to the list"

^self hasEventIndex
	ifTrue: [ eventIndex_ ]
	ifFalse: [ eventIndex_ := self matchState matchplayEvents identityIndexOf: self ]

]

{ #category : #printing }
MatchplayEvent >> eventIndexText [
"Answer the receiver's event index indicator text appropiately coloured
	- warning colour if duration might be incorrectly large"
	
| colour |

colour := Color lightGray.
self durationOverrunFactor > 1.5 ifTrue: [ colour := Color orange ].
self durationOverrunFactor > 2.0 ifTrue: [ colour := Color red ].
^self printIndex asText addAttribute: (TextColor new color: colour).

]

{ #category : #accessing }
MatchplayEvent >> eventIndex_ [

	^ eventIndex_
]

{ #category : #accessing }
MatchplayEvent >> eventIndex_: anObject [

	^ eventIndex_ := anObject
]

{ #category : #'UI - graphics' }
MatchplayEvent >> explainEvent [
^''
]

{ #category : #'UI - graphics' }
MatchplayEvent >> explainEventWithDetail [

^self explainEvent,' ',self printDetail
]

{ #category : #action }
MatchplayEvent >> finaliseDuration [
"I am a matchplay event that's already been added to the collection, and I now need to have my duration finalised"

"The duration will already be set if we are processing a recorded event; do not overwrite it"
"self duration ifNil: [ self duration: self durationSinceCreation ]"
self duration ifNil: [ self duration: self matchState durationSinceLastQuery asMilliSeconds ]

]

{ #category : #action }
MatchplayEvent >> finaliseDurationOfLatest [
"Conditionally finalise the latest preceeding duration-recording event:
	- if the receiver is a duration-recording event then fix the duration of the latest previous duration-recording event
	- answer the event whose duration was finalised, or nil if none"

"If the receiver doesn't record its duration, then it's too soon to finalise the latest preceeding duration-recording event"
self isDurationRecordingEvent ifFalse: [ ^nil ].

"For real-time recording we need to set the duration of the previous event"
^self matchState latestMatchplayEventThatRecordsDuration
	ifNil: [ self matchState durationSinceLastQuery ]	"if the receiver is the first duration-recording event, start the timer"
	ifNotNil: [ :oldMatchplayEvent | oldMatchplayEvent finaliseDuration ]

]

{ #category : #access }
MatchplayEvent >> firstMatchplayEventInGame [
^self matchState matchplayEvents detect: [ :e | e gameNumber = self gameNumber ]
]

{ #category : #accessing }
MatchplayEvent >> flagged [
^flagged ifNil: [ false ]
]

{ #category : #accessing }
MatchplayEvent >> flagged: anObject [

	flagged := anObject
]

{ #category : #action }
MatchplayEvent >> flushCaches [ 
teamWithPossession_ := gameNumber_ := eventIndex_ := score_ := nil
]

{ #category : #access }
MatchplayEvent >> gameNumber [ 
"Answer the number of the game that the receiver is in, or 0 if the event is not in any game, e.g. a command"

^gameNumber_ ifNil: [ gameNumber_ := self gameNumber_ ]
]

{ #category : #access }
MatchplayEvent >> gameNumber_ [
"Answer the number of the game that the receiver is in, or 0 if the event is not in any game, e.g. a command"

| gameNumber |

gameNumber := 1.
self matchState matchplayEvents do: [ :eachMatchplayEvent |
	self == eachMatchplayEvent ifTrue: [ ^gameNumber ].
	gameNumber := gameNumber + eachMatchplayEvent isEndGame asBit ].
^nil


]

{ #category : #testing }
MatchplayEvent >> hasDetail [
^self detail notNil
]

{ #category : #access }
MatchplayEvent >> hasEventIndex [
"Answer if the event index cache has been set with a non-zero value"

^eventIndex_ notNil & (eventIndex_ ~= 0)
]

{ #category : #comparing }
MatchplayEvent >> hash [

^self class hash + self representation hash + self detail hash + self duration hash
]

{ #category : #initialization }
MatchplayEvent >> initialize [ 

self representation: self class representation.

"Only set the current time if the receiver is supposed to record its duration"
self creationTime: (self isDurationRecordingEvent ifTrue: [ DateAndTime now ]).
]

{ #category : #testing }
MatchplayEvent >> isActivePlay [
^false
]

{ #category : #testing }
MatchplayEvent >> isBold [
"Answer if the event should be displayed using bold font"
^false
]

{ #category : #testing }
MatchplayEvent >> isCommandLine [
^false
]

{ #category : #access }
MatchplayEvent >> isControlledPossessionEvent [
"Answer if I am a controlled possession event; this includes being in the Goal"

^false
]

{ #category : #testing }
MatchplayEvent >> isDurationRecordingEvent [
"Most actual matchplay events record their duration"

^self isMatchplayEvent
]

{ #category : #testing }
MatchplayEvent >> isEndGame [
^false
]

{ #category : #testing }
MatchplayEvent >> isEndMatch [
^false
]

{ #category : #testing }
MatchplayEvent >> isEndOfMatch [
"Answer true if we can infer from the receiver that the match is over"

^false
]

{ #category : #testing }
MatchplayEvent >> isGoal [
^false
]

{ #category : #testing }
MatchplayEvent >> isLastGoalOfGame [
^false
]

{ #category : #testing }
MatchplayEvent >> isLatestMatchplayEventWithDuration [

^self == self matchState latestMatchplayEventWithDuration
]

{ #category : #testing }
MatchplayEvent >> isMatchplayComment [
^false
]

{ #category : #testing }
MatchplayEvent >> isMatchplayEvent [
"Instances of some subclasses aren't actually events in the match but meta-events"
^true
]

{ #category : #testing }
MatchplayEvent >> isPossessionFlip [

^false
]

{ #category : #testing }
MatchplayEvent >> isPseudoRod [
^false

]

{ #category : #testing }
MatchplayEvent >> isRecent [
"Answer if this is a recent matchplay event"

^self matchState matchplayEvents size - self eventIndex < 3
]

{ #category : #testing }
MatchplayEvent >> isRod [
^false

]

{ #category : #testing }
MatchplayEvent >> isSideSwap [
^false
]

{ #category : #testing }
MatchplayEvent >> isTicking [
"Answer if this is the matchpay event against which we are currently recording duration"

^self isDurationRecordingEvent & self duration isNil
]

{ #category : #access }
MatchplayEvent >> latestRodOfPossession [
^self isRod
	ifTrue: [ self ]
	ifFalse: [ self previousEvent ifNotNil: [ :pe | pe latestRodOfPossession ]]

]

{ #category : #printing }
MatchplayEvent >> matchProgressSummary [
"Answer a single line match progress summary"

^String streamContents: [ :s |
	| score winningTeam losingTeam sod bod beatText |
	score := self score currentlyWinningTeam.
	winningTeam := self matchState teams at: score + score isZero asBit.
	losingTeam := self matchState otherTeam: winningTeam.
	sod := self matchState isDoubles ifTrue: [ ' are' ] ifFalse: [ ' is' ].
	bod := {' drawn with '.' beating '} at: score sign + 1.
	beatText := self isEndOfMatch
		ifTrue: [ ' beat ' ]
		ifFalse: [ sod,bod ].
	s << winningTeam teamName; << beatText; << losingTeam teamName.
	s << ' '; << self printCurrentScore ]
]

{ #category : #accessing }
MatchplayEvent >> matchState [

	^ matchState
]

{ #category : #accessing }
MatchplayEvent >> matchState: anObject [

	matchState := anObject
]

{ #category : #access }
MatchplayEvent >> nextControlledPossessionEvent [
"Answer the next controlled possession event, including Goal as a pseudo rod"

^self nextEvent ifNotNil: [ :ne |
	ne isControlledPossessionEvent
		ifTrue: [ ne ]
		ifFalse: [ ne nextControlledPossessionEvent ]]
]

{ #category : #access }
MatchplayEvent >> nextEvent [
| i |

i := self eventIndex.
^i < self matchState matchplayEvents size ifTrue: [ self matchState matchplayEvents at: i+1 ]
]

{ #category : #access }
MatchplayEvent >> nextMatchplayEvent [
"Skip over CommandLine and MatchplayComment events"

^self nextEvent ifNotNil: [ :ne |
	ne isMatchplayEvent
		ifTrue: [ ne ]
		ifFalse: [ ne nextMatchplayEvent ]]
]

{ #category : #access }
MatchplayEvent >> nextPseudoRodEvent [
"Answer the next pseudorod event"

^self nextEvent ifNotNil: [ :ne |
	ne isPseudoRod 
		ifTrue: [ ne ]
		ifFalse: [ ne nextPseudoRodEvent ]]
]

{ #category : #action }
MatchplayEvent >> prepareToAdd [
"Let the receiver have something to say before being added to the collection of events"

^self finaliseDurationOfLatest
]

{ #category : #access }
MatchplayEvent >> previousEvent [
| i |

i := self eventIndex.
^i > 1 ifTrue: [ self matchState matchplayEvents at: i-1 ]
]

{ #category : #'UI - graphics' }
MatchplayEvent >> printBriefly [
^String streamContents: [ :s |
	s << self printIndex; << self printRep.
	self durationOrZero isZero ifFalse: [ s space; << 'Duration: '; << self asDuration prettyPrintToCompleteSeconds ]]
]

{ #category : #printing }
MatchplayEvent >> printCurrentGameScore [
| ps |

^Text streamContents: [ :s |
	ps := self score currentGameScore pointScore.
		(self matchState sideSwapParityAtEvent: self ) ifTrue: [ ps := ps reversed ].
		s << '('.
		s << (self matchState sideLeft asText: ps first asString).
		s << '-'.
		s << (self matchState sideRight asText: ps second asString).
		s << ')' ]

]

{ #category : #printing }
MatchplayEvent >> printCurrentScore [
"Pretty print the full game and point score at the receiver event"

| completed current |

^Text streamContents: [ :s |
	completed := self score printCompletedGameScores.
	current := self printCurrentGameScore.
	s << completed.
	completed notEmpty & current notEmpty ifTrue: [ s << ',' ].
	s << current ]



]

{ #category : #printing }
MatchplayEvent >> printDetail [
^String streamContents: [ :s |
	self detail ifNotNil: [ s << $[; << self detail asString; << $] ]]
]

{ #category : #printing }
MatchplayEvent >> printDurationToMS [
^String streamContents: [  :s |
	self duration ifNotNil: [
		s
			<< ${;
			<< self duration asString;
			<< $} ]]
]

{ #category : #printing }
MatchplayEvent >> printDurationToS [
^String streamContents: [ :s |
	self duration ifNotNil: [
		s
			<< ${;
			<< self asDuration prettyPrintToCompleteSeconds;
			<< $} ]]
]

{ #category : #printing }
MatchplayEvent >> printElapsedTime [
^String streamContents: [  :s |
	self duration ifNotNil: [
		s
		<< ${;
		<< self startDuration prettyPrintToCompleteSeconds;
		<< $} ]]
]

{ #category : #printing }
MatchplayEvent >> printElapsedTimeVideo [
"Print the elapsed time, the time from the start of the video to the start of this event"

^String streamContents: [  :s |
	self duration ifNotNil: [
		s
		<< ${;
		<< self startDurationFromVideo prettyPrintToCompleteSeconds;
		<< $} ]]
]

{ #category : #printing }
MatchplayEvent >> printFlagIndicator [
^Text streamContents: [ :s |
	self flagged ifTrue: [ s << '<--------- FLAGGED' ]]
]

{ #category : #printing }
MatchplayEvent >> printFully [
^String streamContents: [ :s |
	s << self printIndex; << self printRep.
	self duration ifNotNil: [ s << ${; << self duration asString; << $} ].
	self detail ifNotNil: [ s << $[; << self detail asString; << $] ]].
]

{ #category : #printing }
MatchplayEvent >> printIndex [
^String streamContents: [ :s | s << $[; << self eventIndex asString; << '] ' ]
]

{ #category : #printing }
MatchplayEvent >> printOn: aStream [ 
aStream << self printFully
]

{ #category : #printing }
MatchplayEvent >> printRep [

^self representation asText
]

{ #category : #printing }
MatchplayEvent >> printTimeOutTallyForSide: aTableSide [
^String streamContents: [ :s |
	(self timeOutTallyForSide: aTableSide) timesRepeat: [ s << 'T ' ]]
]

{ #category : #access }
MatchplayEvent >> reasonableMaximumDuration [
^99 years
]

{ #category : #accessing }
MatchplayEvent >> representation [

	^ representation
]

{ #category : #accessing }
MatchplayEvent >> representation: anObject [

	representation := anObject
]

{ #category : #stats }
MatchplayEvent >> score [
^score_ ifNil: [ score_ := self scoreAtEvent ]
]

{ #category : #stats }
MatchplayEvent >> scoreAtEvent [
^self matchState scoreAtEvent: self
]

{ #category : #action }
MatchplayEvent >> setFlag [
"Set a flag on this event"

self flagged: true
]

{ #category : #'UI - graphics' }
MatchplayEvent >> shapeHoverText [
^String streamContents: [ :s |
	s
		<< self explainEventWithDetail; cr; space; cr;
		<< self matchProgressSummary; cr;
		<< self printBriefly ]
]

{ #category : #testing }
MatchplayEvent >> shouldCR [
"answer if I should print a CR after printing myself"

^self isActivePlay not and: [ self nextEvent class ~= MatchplayComment ]
]

{ #category : #'UI - graphics' }
MatchplayEvent >> shouldShowBox [
"By default, show a box if the receiver has duration"

^self durationOrZero isZero not
]

{ #category : #'UI - graphics' }
MatchplayEvent >> shouldShowLine [
"By default, only show a line if the receiver has detail"

^self hasDetail
]

{ #category : #access }
MatchplayEvent >> sideWithPossession [
"Answer the side which has possession during this event
	- consider the parity of the possession flips in my parent's matchplay events"
	
^self matchState sideWithPossessionInEvent: self
]

{ #category : #access }
MatchplayEvent >> startDuration [
"Answer a Duration, the time that has elapsed since the start of the match until the beginning of this event"

^Duration milliSeconds: self startTime
]

{ #category : #access }
MatchplayEvent >> startDurationFromVideo [
"Answer a Duration, the time that has elapsed since the start of the video from which this recording was made, until the beginning of this event"

^self startDuration + self matchState videoOffsetDuration
]

{ #category : #access }
MatchplayEvent >> startTime [
"Answer the number of milliseconds from the start of the match until the beginning of this event"

^self eventIndex = 1
	ifTrue: [ 0 ]
	ifFalse: [ (1 to: self eventIndex - 1)
		inject: 0
		into: [ :c :e | c + (self matchState matchplayEvents at: e) durationOrZero ]]
]

{ #category : #access }
MatchplayEvent >> startTimeInGame [
"Answer elapsed time from the start of the current game until the start of this event"

^self startTime - self firstMatchplayEventInGame startTime
]

{ #category : #printing }
MatchplayEvent >> storeOn: aStream [ 
	"Append to the argument aStream a sequence of characters that is an 
	expression whose evaluation creates an object similar to the receiver."

	aStream nextPut: self representation.
	aStream nextPut: ${.
	aStream nextPutAll: self duration asString.
	aStream nextPut: $}.
	
	aStream nextPut: $[.
	aStream nextPutAll: self detail asString.
	aStream nextPut: $].
	
]

{ #category : #access }
MatchplayEvent >> teamWithOwnership [
"Answer the team that 'owns' the event - start here by assuming it's the team with possession that owns it"

^self teamWithPossession

]

{ #category : #access }
MatchplayEvent >> teamWithOwnershipIndex [
"Answer the index of team that 'owns' the event"

^self matchState teams indexOf: self teamWithOwnership
]

{ #category : #access }
MatchplayEvent >> teamWithPossession [
"Answer the team which has possession during this event
	- consider the parity of the possession flips in my parent's matchplay events"
	
^teamWithPossession_ ifNil:[ teamWithPossession_ := self matchState teamWithPossessionInEvent: self ]
]

{ #category : #accessing }
MatchplayEvent >> teamWithPossession_ [

	^ teamWithPossession_
]

{ #category : #accessing }
MatchplayEvent >> teamWithPossession_: anObject [

	^ teamWithPossession_ := anObject
]

{ #category : #access }
MatchplayEvent >> timeLimit [
"Answer the maximum duration allowed for this event in the rules"

^nil
]

{ #category : #printing }
MatchplayEvent >> timeOutTallyForSide: aTableSide [
"Answer the number of time-outs at this point in the game by the team on the specified side"
| tos tot |

self gameNumber isZero ifTrue: [ ^0 ].

tos := self matchState teamOnSide: aTableSide atEvent: self.
tot := PSTimeOutTally new
	matchState: self matchState;
	gameNumber: self gameNumber;
	teamNumber: (self matchState teams indexOf: tos) ;
	yourself.
tot generate.
^tot getResult result
]
