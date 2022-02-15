Class {
	#name : #MatchplayTimer,
	#superclass : #FMRObject,
	#instVars : [
		'timeAtLastQuery',
		'timeWhenStopped'
	],
	#category : #FMR
}

{ #category : #API }
MatchplayTimer >> durationSinceLastQuery [
"Answer the duration since the last time this message was sent, or nil if it never was"

| duration |

duration := self peekDurationSinceLastQuery.
self reset.
^duration 



]

{ #category : #API }
MatchplayTimer >> isRunning [
"Answer if the timer is currently running"

^self timeWhenStopped isNil
]

{ #category : #API }
MatchplayTimer >> peekDurationSinceLastQuery [
"Answer the duration that #durationSinceLastQuery would answer, but don't reset the timer"

| currentTime |

currentTime := self timeWhenStopped ifNil: [ DateAndTime now ].
^self timeAtLastQuery ifNotNil: [ currentTime - self timeAtLastQuery ].
]

{ #category : #private }
MatchplayTimer >> reset [
"Reset the timer"

self timeAtLastQuery: DateAndTime now.
self timeWhenStopped: nil.


]

{ #category : #API }
MatchplayTimer >> start [
"Start the timer"

self timeAtLastQuery: DateAndTime now - (self peekDurationSinceLastQuery ifNil: [ 0 asDuration ]).
self timeWhenStopped: nil
]

{ #category : #API }
MatchplayTimer >> stop [
"Stop the timer. The next duration query result will be as if made now"

self timeWhenStopped: DateAndTime now
]

{ #category : #accessing }
MatchplayTimer >> timeAtLastQuery [

	^ timeAtLastQuery
]

{ #category : #accessing }
MatchplayTimer >> timeAtLastQuery: anObject [

	timeAtLastQuery := anObject
]

{ #category : #accessing }
MatchplayTimer >> timeWhenStopped [

	^ timeWhenStopped
]

{ #category : #accessing }
MatchplayTimer >> timeWhenStopped: anObject [

	timeWhenStopped := anObject
]
