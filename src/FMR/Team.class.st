Class {
	#name : #Team,
	#superclass : #FMRObject,
	#instVars : [
		'teamName'
	],
	#category : #FMR
}

{ #category : #initialization }
Team class >> clean: aString [
"Answer a cleaned team name"

^' & ' join: ((aString substrings: '&') collect: [ :e | e trim ])
]

{ #category : #initialization }
Team class >> newFromString: aString [

^self new
	teamName: (self clean: aString);
	yourself
]

{ #category : #access }
Team >> backPlayer [
"Answer the name of the back player at the start of the match
	- make it work for singles too"

^(self teamName tokensBasedOn: '&') last trim
]

{ #category : #access }
Team >> forwardPlayer [
"Answer the name of the back player at the start of the match
	- make it work for singles too"

^(self teamName tokensBasedOn: '&') first trim
]

{ #category : #testing }
Team >> isDoubles [
^self teamName includes: $&
]

{ #category : #testing }
Team >> isSingles [
^self isDoubles not
]

{ #category : #printing }
Team >> printOn: aStream [

aStream nextPutAll: teamName
]

{ #category : #accessing }
Team >> teamName [

	^ teamName
]

{ #category : #accessing }
Team >> teamName: anObject [

	teamName := anObject
]
