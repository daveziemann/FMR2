Class {
	#name : #MatchplayEventPrinterForFile,
	#superclass : #MatchplayEventPrinter,
	#category : #FMR
}

{ #category : #printing }
MatchplayEventPrinterForFile >> printMatchplayEvent: aMatchplayEvent [

self << aMatchplayEvent printFully

]

{ #category : #printing }
MatchplayEventPrinterForFile >> printMatchplayEvents: matchplayEvents [

matchplayEvents doWithIndex: [ :eachMatchplayEvent :index |
	self printMatchplayEvent: eachMatchplayEvent.
	self cr ]
]
