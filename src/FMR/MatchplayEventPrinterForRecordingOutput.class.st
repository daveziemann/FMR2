Class {
	#name : #MatchplayEventPrinterForRecordingOutput,
	#superclass : #MatchplayEventPrinter,
	#category : #FMR
}

{ #category : #printing }
MatchplayEventPrinterForRecordingOutput >> printCurrentMatchplayEvents: n [
| c |

"Nothing to show"
self matchState matchplayEvents ifEmpty: [ ^self ].

"The last event was a submitted paused play event - show just the event and its current duration"
self matchState matchplayEvents size = n ifTrue: [ ^self printLatestMatchplayEvents: 2 ].

"Show the current sequence of active play events"
c := self matchState matchplayEvents copyFrom: n + 1 to: self matchState matchplayEvents size.
self printMatchplayEvents: c.

]

{ #category : #printing }
MatchplayEventPrinterForRecordingOutput >> printForSequence: aString [
^(self matchState: (MatchState fromString: aString)) printMatchplayEvents text
]

{ #category : #printing }
MatchplayEventPrinterForRecordingOutput >> printLatestMatchplayEvents: n [
"Print the latest n matchplay events only"

self matchState latestMatchplayEventThatRecordsDuration
	ifNotNil: [ :aMatchplayEvent | self printMatchplayEvents: {aMatchplayEvent previousEvent.aMatchplayEvent} ]
]

{ #category : #printing }
MatchplayEventPrinterForRecordingOutput >> printMatchplayEvent: aMatchplayEvent [
| string |

string := String streamContents: [ :s |
	s << aMatchplayEvent printRep.
	"Show the ticking matchplay event with its current duration"	
	aMatchplayEvent isTicking
		ifTrue: [ s << aMatchplayEvent copyWithCurrentDuration printDurationToS ]
		ifFalse: [
			"Show a recent matchplay event with its finalised duration"
			aMatchplayEvent isRecent
				ifTrue: [ s << aMatchplayEvent printDurationToS ]].
	s << aMatchplayEvent printDetail ].

self << (aMatchplayEvent asTextWithAttributes: string)




]

{ #category : #printing }
MatchplayEventPrinterForRecordingOutput >> printMatchplayEvents: matchplayEvents [

matchplayEvents do: [ :eachMatchplayEvent | self printMatchplayEvent: eachMatchplayEvent ].

]
