Extension { #name : #String }

{ #category : #'*FMR' }
String >> prettyAsDuration [
"Convert the receiver, a pretty printed Duration consisting of minutes and seconds, back into a Duration
	- answer nil if it's not legal
	- legal examples: 3m17s 10m 55s"

| letters colonFormat |

letters := self reject: [ :e | e isDigit ].
colonFormat := (self copyReplaceAll: 'm' with: ':') copyReplaceAll: 's' with: ':'.
(letters size = 2 and: [ letters = 'ms' ]) ifTrue: [ ^('0:0:',colonFormat) asDuration ].
(letters size = 1 and: [ letters first = $m ]) ifTrue: [ ^('0:0:',colonFormat,':0') asDuration ].
(letters size = 1 and: [ letters first = $s ]) ifTrue: [ ^('0:0:0:',colonFormat) asDuration ].
^nil


]

{ #category : #'*FMR' }
String >> tokensBasedOn: separators [
| s c |
s := self readStream.
c := OrderedCollection new.
[ s atEnd ] whileFalse: [ c add: (s upToAnyOf: separators) ].
(self isEmpty or: [ separators includes: self last ]) ifTrue: [ c add: '' ].
^c
]
