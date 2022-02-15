Class {
	#name : #MatchplayEventPrinter,
	#superclass : #FMRObject,
	#instVars : [
		'matchState',
		'outputStream'
	],
	#category : #FMR
}

{ #category : #'instance creation' }
MatchplayEventPrinter class >> forDocumentation [
^MatchplayEventPrinterForDocumentation new
	outputStream: (WriteStream on: Text new);
	yourself
]

{ #category : #'instance creation' }
MatchplayEventPrinter class >> forFile [
^MatchplayEventPrinterForFile new
	outputStream: (WriteStream on: String new);
	yourself
]

{ #category : #'instance creation' }
MatchplayEventPrinter class >> forHistoryPane [
^MatchplayEventPrinterForHistoryPane new
	outputStream: (WriteStream on: Text new);
	yourself
]

{ #category : #'instance creation' }
MatchplayEventPrinter class >> forRecordingOutput [
^MatchplayEventPrinterForRecordingOutput new
	outputStream: (WriteStream on: Text new);
	yourself
]

{ #category : #printing }
MatchplayEventPrinter >> << aStringOrText [
self outputStream << aStringOrText
]

{ #category : #copying }
MatchplayEventPrinter >> copyFor: aMatchState [
"Answer a copy a different MatchState but preserving all the receiver's state"

^self copy matchState: aMatchState
]

{ #category : #printing }
MatchplayEventPrinter >> cr [
self outputStream cr
]

{ #category : #accessing }
MatchplayEventPrinter >> matchState [

	^ matchState
]

{ #category : #accessing }
MatchplayEventPrinter >> matchState: anObject [

	matchState := anObject
]

{ #category : #accessing }
MatchplayEventPrinter >> outputStream [

	^ outputStream
]

{ #category : #accessing }
MatchplayEventPrinter >> outputStream: anObject [

	outputStream := anObject
]

{ #category : #printing }
MatchplayEventPrinter >> printMatchplayEvents [

self printMatchplayEvents: matchState matchplayEvents
]

{ #category : #access }
MatchplayEventPrinter >> string [
^self outputStream flush contents
]

{ #category : #printing }
MatchplayEventPrinter >> tab [
self outputStream tab
]

{ #category : #access }
MatchplayEventPrinter >> text [
^self outputStream flush contents
]
