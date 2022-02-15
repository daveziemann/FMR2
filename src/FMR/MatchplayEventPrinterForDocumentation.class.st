Class {
	#name : #MatchplayEventPrinterForDocumentation,
	#superclass : #MatchplayEventPrinter,
	#category : #FMR
}

{ #category : #printing }
MatchplayEventPrinterForDocumentation >> printCurrentMatchplayEvents: n [
| c |

self matchState matchplayEvents ifEmpty: [ ^self ].
self matchState matchplayEvents size = n ifTrue: [ ^self ].

c := self matchState matchplayEvents copyFrom: n + 1 to: self matchState matchplayEvents size.
self printMatchplayEvents: c.

]

{ #category : #printing }
MatchplayEventPrinterForDocumentation >> printForSequence: aString [
^(self matchState: (MatchState fromString: aString)) printMatchplayEvents text
]

{ #category : #printing }
MatchplayEventPrinterForDocumentation >> printMatchplayEvent: aMatchplayEvent [
| string |

string := String streamContents: [ :s |
	s << aMatchplayEvent printRep.
	s << aMatchplayEvent printDetail ].
	
self << (aMatchplayEvent asTextWithAttributes: string)




]

{ #category : #printing }
MatchplayEventPrinterForDocumentation >> printMatchplayEventWithDurationToS: aMatchplayEvent [
| string |

string := String streamContents: [ :s |
	s << aMatchplayEvent printRep.
	s << aMatchplayEvent printDurationToS.
	s << aMatchplayEvent printDetail ].
	
self << (aMatchplayEvent asTextWithAttributes: string)


]

{ #category : #printing }
MatchplayEventPrinterForDocumentation >> printMatchplayEvents: matchplayEvents [

matchplayEvents do: [ :eachMatchplayEvent | self printMatchplayEvent: eachMatchplayEvent ].

]
