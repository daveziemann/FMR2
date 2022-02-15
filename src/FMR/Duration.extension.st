Extension { #name : #Duration }

{ #category : #'*FMR' }
Duration >> divideBy: numberOrMagnitude [
"Safely divide by zero"

^numberOrMagnitude divideIntoMagnitude: self
]

{ #category : #'*FMR' }
Duration >> divideIntoMagnitude: aMagnitude [
^self isZero
	ifTrue: [ 0 ]
	ifFalse: [ aMagnitude / self ]
]

{ #category : #'*FMR' }
Duration >> divideIntoNumber: aNumber [
^self isZero
	ifTrue: [ 0 ]
	ifFalse: [ aNumber / self asMinutes ]
]

{ #category : #'*FMR' }
Duration >> humanAbbreviatedReadablePrintString [
	"Return a String with a human readable representation of me"

	"99999 atRandom seconds humanReadablePrintString"
	"99999999 atRandom milliSeconds humanReadablePrintString"	
	"99999999999999 atRandom nanoSeconds humanReadablePrintString"
	
	^ String streamContents: [ :out | 
		self printHumanAbbreviatedReadableOn: out ]
]

{ #category : #'*FMR' }
Duration >> prettyPrintToCompleteSeconds [
"Pretty print the receiver to its number of complete seconds"

^self asSeconds asDuration humanAbbreviatedReadablePrintString
]

{ #category : #'*FMR' }
Duration >> prettyPrintToRoundedSeconds [
"Pretty print the receiver to its number of rounded seconds"

^(self asMilliSeconds / 1000) rounded asDuration humanAbbreviatedReadablePrintString
]

{ #category : #'*FMR' }
Duration >> printHumanAbbreviatedReadableOn: stream [
| outputWritten count |

outputWritten := false.
self negative ifTrue: [ 
	stream << '- '. 
	^self abs printHumanAbbreviatedReadableOn: stream ].
#(
	(days 'd') 
	(hours 'h') 
	(minutes 'm') 
	(seconds 's') 
	(wholeMilliseconds 'ms') 
	(wholeMicroseconds 'mic') 
	(wholeNanoseconds 'ns')) do: [ :each |
		count := (self perform: each first) truncated.
		count > 0 ifTrue: [
			count printWithCommasOn: stream.
			stream << each second.
			outputWritten := true ]].
outputWritten ifFalse: [ stream << '0s' ]
]
