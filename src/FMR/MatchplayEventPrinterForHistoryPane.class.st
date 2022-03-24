Class {
	#name : #MatchplayEventPrinterForHistoryPane,
	#superclass : #MatchplayEventPrinter,
	#instVars : [
		'isFormatCompact',
		'isFormatLines',
		'isTimeNone',
		'isTimeDurationS',
		'isTimeDurationMS',
		'isTimeElapsed',
		'isTimeElapsedMatch',
		'isTimeElapsedVideo'
	],
	#category : #FMR
}

{ #category : #accessing }
MatchplayEventPrinterForHistoryPane >> isFormatCompact [

	^ isFormatCompact
]

{ #category : #accessing }
MatchplayEventPrinterForHistoryPane >> isFormatCompact: anObject [

	isFormatCompact := anObject
]

{ #category : #accessing }
MatchplayEventPrinterForHistoryPane >> isFormatLines [

	^ isFormatLines
]

{ #category : #accessing }
MatchplayEventPrinterForHistoryPane >> isFormatLines: anObject [

	isFormatLines := anObject
]

{ #category : #accessing }
MatchplayEventPrinterForHistoryPane >> isTimeDurationMS [

	^ isTimeDurationMS
]

{ #category : #accessing }
MatchplayEventPrinterForHistoryPane >> isTimeDurationMS: anObject [

	isTimeDurationMS := anObject
]

{ #category : #accessing }
MatchplayEventPrinterForHistoryPane >> isTimeDurationS [

	^ isTimeDurationS
]

{ #category : #accessing }
MatchplayEventPrinterForHistoryPane >> isTimeDurationS: anObject [

	isTimeDurationS := anObject
]

{ #category : #accessing }
MatchplayEventPrinterForHistoryPane >> isTimeElapsedMatch [

	^ isTimeElapsedMatch
]

{ #category : #accessing }
MatchplayEventPrinterForHistoryPane >> isTimeElapsedMatch: anObject [

	isTimeElapsedMatch := anObject
]

{ #category : #accessing }
MatchplayEventPrinterForHistoryPane >> isTimeElapsedVideo [

	^ isTimeElapsedVideo
]

{ #category : #accessing }
MatchplayEventPrinterForHistoryPane >> isTimeElapsedVideo: anObject [

	isTimeElapsedVideo := anObject
]

{ #category : #accessing }
MatchplayEventPrinterForHistoryPane >> isTimeNone [

	^ isTimeNone
]

{ #category : #accessing }
MatchplayEventPrinterForHistoryPane >> isTimeNone: anObject [

	isTimeNone := anObject
]

{ #category : #printing }
MatchplayEventPrinterForHistoryPane >> printMatchplayEvent: aMatchplayEvent [
| string |

string := String streamContents: [ :s |
	s << aMatchplayEvent printRep.
	self isTimeDurationS ifTrue: [ s << aMatchplayEvent printDurationToS ].
	self isTimeDurationMS ifTrue: [ s << aMatchplayEvent printDurationToMS ].
	self isTimeElapsedMatch ifTrue: [ s << aMatchplayEvent printElapsedTimeFromMatchStart ].
	self isTimeElapsedVideo ifTrue: [ s << aMatchplayEvent printElapsedTimeFromVideoStart ].
	s << aMatchplayEvent printDetail ].
	
self << (aMatchplayEvent asTextWithAttributes: string).


]

{ #category : #printing }
MatchplayEventPrinterForHistoryPane >> printMatchplayEvents: matchplayEvents [

matchplayEvents do: [ :eachMatchplayEvent |
	self isFormatLines
		ifTrue: [
			self << eachMatchplayEvent eventIndexText.
			self printMatchplayEvent: eachMatchplayEvent.
			self tab; tab; tab; << eachMatchplayEvent printCurrentScore.
			self tab; tab; << eachMatchplayEvent explainEvent.
			self tab; tab; << eachMatchplayEvent printFlagIndicator.
			self cr ]
	ifFalse: [ 
		self printMatchplayEvent: eachMatchplayEvent.
		eachMatchplayEvent shouldCR ifTrue: [ self cr ]]]
]

{ #category : #printing }
MatchplayEventPrinterForHistoryPane >> printMatchplayEventsUpToFirstError [
"Print all the matchplay events up until the first bad one
	- the index of the last good matchplay event will be in the command processor"
	
self printMatchplayEvents: (self matchState matchplayEvents
	copyFrom: 1
	to: self matchState commandProcessor lastGoodEventIndex)
]
