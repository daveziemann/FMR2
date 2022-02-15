Class {
	#name : #MatchStateEnumerator,
	#superclass : #FMRObject,
	#instVars : [
		'sourceDirectory',
		'matchState'
	],
	#category : #FMR
}

{ #category : #enumeration }
MatchStateEnumerator >> allCompletedMatchesDo: aOneArgBlock [
self allMatchesDo: [ :eachMatchState |
	eachMatchState isEndMatch
		ifTrue: [ aOneArgBlock value: eachMatchState ]]
]

{ #category : #enumeration }
MatchStateEnumerator >> allCompletedStandardMatchesDo: aOneArgBlock [
"Enumerate all completed Standard matches. Here Standard means
	- first game finished when the winner reached 5 points"

self allCompletedMatchesDo: [ :eachMatchState |
	eachMatchState pointTarget = 5 ifTrue: [ aOneArgBlock value: eachMatchState ]]
]

{ #category : #access }
MatchStateEnumerator >> allFiles [
^(self sourceDirectory asFileReference filesMatching: 'FMR*.txt') asSortedCollection asArray
]

{ #category : #enumeration }
MatchStateEnumerator >> allFilesDo: aOneArgBlock [
self allFiles do: [ :eachSourceFile | aOneArgBlock value: eachSourceFile ]
]

{ #category : #enumeration }
MatchStateEnumerator >> allFilesSelect: aOneArgBlock [
^self allFiles select: [ :eachSourceFile | aOneArgBlock value: eachSourceFile ]
]

{ #category : #validation }
MatchStateEnumerator >> allMatchStateSizes [
^self allMatchesCollect: [ :eachMatchState | eachMatchState matchplayEvents size ]
]

{ #category : #enumeration }
MatchStateEnumerator >> allMatchesCollect: aOneArgBlock [
| d |

d := OrderedDictionary new.
self allMatchesDo: [ :aMatchState | d at: aMatchState put: (aOneArgBlock value: aMatchState) ].
^d

]

{ #category : #enumeration }
MatchStateEnumerator >> allMatchesDo: aOneArgBlock [
self allFilesDo: [ :eachSourceFile |
	self matchState: (MatchState readFile: eachSourceFile).
	aOneArgBlock value: self matchState ]
]

{ #category : #enumeration }
MatchStateEnumerator >> allMatchesWithGamesDo: aOneArgBlock [
self allMatchesDo: [ :eachMatchState |
	eachMatchState hasGames
		ifTrue: [ aOneArgBlock value: eachMatchState ]]
]

{ #category : #initialize }
MatchStateEnumerator >> initialize [ 
super initialize.
self sourceDirectory: MatchState directoryForMatchplayFiles.
]

{ #category : #accessing }
MatchStateEnumerator >> matchState [

	^ matchState
]

{ #category : #accessing }
MatchStateEnumerator >> matchState: anObject [

	matchState := anObject
]

{ #category : #accessing }
MatchStateEnumerator >> sourceDirectory [

	^ sourceDirectory
]

{ #category : #accessing }
MatchStateEnumerator >> sourceDirectory: anObject [

	sourceDirectory := anObject
]
