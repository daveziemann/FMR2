Class {
	#name : #CommandProcessor,
	#superclass : #FMRObject,
	#instVars : [
		'matchState',
		'isCommentMode',
		'lastGoodEventIndex',
		'shouldGrowlErrors'
	],
	#category : #FMR
}

{ #category : #commands }
CommandProcessor >> command_endGame [

^self newEventOfType: EndGame
]

{ #category : #commands }
CommandProcessor >> command_endMatch [

^EndMatch new matchState: self matchState
]

{ #category : #commands }
CommandProcessor >> command_sideLeft_infraction [
"Team on left did an infraction"

^(self newEventOfType: Infraction)
	sideIndicated: self matchState table sideLeft
]

{ #category : #commands }
CommandProcessor >> command_sideLeft_r [
"Team on left called a referee"

^(self newEventOfType: Referee)
	sideIndicated: self matchState table sideLeft
]

{ #category : #commands }
CommandProcessor >> command_sideLeft_swapPositions [
"Team on left swapped positions"

^(self newEventOfType: SwapPositions)
	sideIndicated: self matchState table sideLeft
]

{ #category : #commands }
CommandProcessor >> command_sideLeft_t [
"Team on left took a time-out"

^(self newEventOfType: TimeOut)
	sideIndicated: self matchState table sideLeft
]

{ #category : #commands }
CommandProcessor >> command_sideRight_infraction [
"Team on left did an infraction"

^(self newEventOfType: Infraction)
	sideIndicated: self matchState table sideRight
]

{ #category : #commands }
CommandProcessor >> command_sideRight_r [
"Team on right called a referee"

^(self newEventOfType: Referee)
	sideIndicated: self matchState table sideRight
]

{ #category : #commands }
CommandProcessor >> command_sideRight_swapPositions [
"Team on right swapped positions"

^(self newEventOfType: SwapPositions)
	sideIndicated: self matchState table sideRight
]

{ #category : #commands }
CommandProcessor >> command_sideRight_t [
"Team on left took a time-out"

^(self newEventOfType: TimeOut)
	sideIndicated: self matchState table sideRight
]

{ #category : #commands }
CommandProcessor >> command_swapSides [
"Create a matchplay event which signifies that the teams swapped sides"

^self newEventOfType: SwapSides
]

{ #category : #executing }
CommandProcessor >> executeCommandLine: aCommandLine [
"Execute the command and answer the command line MatchplayEvent"

| statePackKey commandSelector |

statePackKey := aCommandLine representation allButFirst asSymbol.
commandSelector := ('command_',statePackKey) asSymbol.
self matchState statePack at: statePackKey put: aCommandLine detail.
(aCommandLine respondsTo: commandSelector) ifTrue: [ aCommandLine perform: commandSelector ].
^aCommandLine
]

{ #category : #'processing - recorded' }
CommandProcessor >> finaliseMatchplayEvent: aMatchplayEvent fromStream: eventStream [

eventStream peek = ${ ifTrue: [ aMatchplayEvent duration: (self readDurationFromStream: eventStream) ].
eventStream peek = $[ ifTrue: [ aMatchplayEvent detail: (self readDetailFromStream: eventStream) ].
]

{ #category : #testing }
CommandProcessor >> hasRecordingErrors [
^self lastGoodEventIndex notNil
]

{ #category : #access }
CommandProcessor >> isActivePlay: newString [
"Answer if the input string is part of active play recording"

^'.253' includes: newString first
]

{ #category : #access }
CommandProcessor >> isCommandLine: newString [
^(self isActivePlay: newString) not
]

{ #category : #accessing }
CommandProcessor >> isCommentMode [
^ isCommentMode ifNil: [ false ]
]

{ #category : #accessing }
CommandProcessor >> isCommentMode: anObject [

	isCommentMode := anObject
]

{ #category : #accessing }
CommandProcessor >> lastGoodEventIndex [
^lastGoodEventIndex
]

{ #category : #accessing }
CommandProcessor >> lastGoodEventIndex: anObject [

	lastGoodEventIndex := anObject
]

{ #category : #logging }
CommandProcessor >> logError: aString [

"Remember the current size of the matchplay events collection"
self lastGoodEventIndex ifNil: [ self lastGoodEventIndex: self matchState matchplayEvents size ].

self shouldGrowlErrors ifTrue: [ FMRGrowlMorph growlErrorFor: 'Event Processor' message: aString ].
Transcript cr; show: aString; flush.
	
^nil
]

{ #category : #executing }
CommandProcessor >> mapPausedEventToExecutableSelectorFragment: aString [
"Translate the special characters in the paused event string to produce a valid selector fragment"

| map fragment |

map := Dictionary new
	at: '/' put: 'endGame';
	at: '//' put: 'endMatch';
	at: '<>' put: 'swapSides';
	yourself.

map at: aString ifPresent: [ :f | ^f ].

fragment := aString copyReplaceAll: '!' with: 'infraction'.
fragment := fragment copyReplaceAll: ':' with: 'swapPositions'.

fragment first = $< ifTrue: [ ^'sideLeft_',fragment allButFirst ].
fragment first = $> ifTrue: [ ^'sideRight_',fragment allButFirst ].
^fragment 
]

{ #category : #accessing }
CommandProcessor >> matchState [

	^ matchState
]

{ #category : #accessing }
CommandProcessor >> matchState: anObject [

	matchState := anObject
]

{ #category : #executing }
CommandProcessor >> newCommandLine [
^CommandLine new
	matchState: self matchState;
	yourself
]

{ #category : #executing }
CommandProcessor >> newComment [
^MatchplayComment new
	matchState: self matchState;
	yourself
]

{ #category : #commands }
CommandProcessor >> newEventOfType: aMatchplayEventClass [

^aMatchplayEventClass new matchState: self matchState
]

{ #category : #executing }
CommandProcessor >> processCommand: aString [
"Process the command string"
 
| commandLine |

"Construct the command"
commandLine := self newCommandLine fromString: aString.

"Execute the command and add the resulting matchplay event to my collection"
(self executeCommandLine: commandLine) ifNotNil: [ :aMatchplayEvent |
		self matchState addMatchplayEvent: aMatchplayEvent ].
]

{ #category : #'processing - recorded' }
CommandProcessor >> processComment: aString [

(aString copyAfter: $") ifNotEmpty: [ :string |
	self matchState addMatchplayEvent: (self newComment detail: (string copyUpTo: $")) ].

]

{ #category : #'processing - recorded' }
CommandProcessor >> processRecordedActivePlayLine: aString [
| eventStream |

eventStream := aString readStream.
[ eventStream atEnd ] whileFalse: [ 
	(MatchplayEvent newFromCharacter: eventStream next inMatchState: self matchState)
		ifNil: [ self logError: 'Ignoring unrecognised event: ',eventStream peekBack asString ]
		ifNotNil: [ :aMatchplayEvent |
			self finaliseMatchplayEvent: aMatchplayEvent fromStream: eventStream.
			self matchState addMatchplayEvent: aMatchplayEvent ]]
]

{ #category : #'processing - recorded' }
CommandProcessor >> processRecordedLine: line [
"Process the input line
	- ignore anything from a tab onwards
	- expect a matchplay event followed by an optional comment"
	
((line copyUpTo: Character tab) copyUpTo: $") trim
	ifNotEmpty: [ :body | self processRecordedLineWithoutComment: body ].
self processComment: line
]

{ #category : #'processing - recorded' }
CommandProcessor >> processRecordedLineWithoutComment: line [
line first = $@ ifTrue: [ ^self processCommand: line ].
(MatchplayEvent activeRecordingCharacters includes: line first) ifTrue: [ ^self processRecordedActivePlayLine: line ].
('/<>' includes: line first) ifTrue: [ ^self processRecordedPausedPlayLine: line ].
self logError: 'Ignoring unrecognised event: ',line
]

{ #category : #'processing - recorded' }
CommandProcessor >> processRecordedPausedPlayLine: aString [
| commandSelector matchplayEvent eventStream |

eventStream := aString readStream.
commandSelector := ('command_',(self mapPausedEventToExecutableSelectorFragment: (eventStream upToAnyOf: '{['))) asSymbol.
(self respondsTo: commandSelector) ifFalse: [ ^self logError: 'Ignoring unknown paused play event: ',commandSelector ].
FMRGrowlMorph
	growlDebugFor: 'Matchplay Events'
	message: [ 'Executing paused play event method: #',commandSelector ].
matchplayEvent := self perform: commandSelector.
eventStream back.
self finaliseMatchplayEvent: matchplayEvent fromStream: eventStream.
FMRGrowlMorph
	growlDebugFor: 'Matchplay Events'
	message: [ 'Paused play event result: ',matchplayEvent asString ].
self matchState addMatchplayEvent: matchplayEvent.

]

{ #category : #'processing - recorded' }
CommandProcessor >> processRecordedString: aString [

"Error management"
self lastGoodEventIndex: nil.

(aString substrings: String cr)
	do: [ :eachLineWithIndex |
		"Strip matchplay event index"
		self processRecordedLine: (self trimIndex: (self trimIndex: eachLineWithIndex)) ]
]

{ #category : #'processing - recorded' }
CommandProcessor >> readDetailFromStream: aStream [

aStream next. "swallow open bracket"
^aStream upTo: $]

]

{ #category : #'processing - recorded' }
CommandProcessor >> readDurationFromStream: aStream [
"Read the duration in ms from the stream and log any error"

| durationString |
aStream next. "swallow left brace"
durationString := aStream upTo: $}.
durationString isAllDigits ifFalse:[ ^self logError: 'Ignoring bad duration: ',durationString ].
^durationString asInteger

]

{ #category : #accessing }
CommandProcessor >> shouldGrowlErrors [
^shouldGrowlErrors ifNil: [ true ]
]

{ #category : #accessing }
CommandProcessor >> shouldGrowlErrors: anObject [

	shouldGrowlErrors := anObject
]

{ #category : #'processing - recorded' }
CommandProcessor >> trimIndex: aString [
"If aString looks like it starts with a matchplay event index then get rid of it"

^aString first = $[
	ifTrue: [ (aString copyAfter: $]) trim ]
	ifFalse: [ aString trim ]
]
