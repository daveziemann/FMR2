Class {
	#name : #MatchDetailsPack,
	#superclass : #FMRObject,
	#instVars : [
		'pack'
	],
	#category : #FMR
}

{ #category : #access }
MatchDetailsPack >> asCommandLineStrings [
^self canonicalKeys collect: [ :eachKey |
	String streamContents: [ :s | s
		<< $@;
		<< 	eachKey;
		<< $[;
		<< (self at: eachKey ifAbsent: [ '' ]) asString;
		<< $] ]]
]

{ #category : #access }
MatchDetailsPack >> at: aSymbol ifAbsent: aBlock [
^self pack at: aSymbol ifAbsent: aBlock
]

{ #category : #access }
MatchDetailsPack >> at: aSymbol put: aString [
self pack at: aSymbol put: aString
]

{ #category : #access }
MatchDetailsPack >> canonicalKeys [
"Answer the keys in their canonical order; mandatory keys first"

^#(
	#version
	#recordingDate
	#lastSaveDate
	#tournament
	#event
	#match
	#table
	#teams
	#matchDate

	#urlVideo
	#videoOffset
	#urlChart
	#comment
	#recorder
)
]

{ #category : #initialization }
MatchDetailsPack >> initialize [ 
self pack: OrderedDictionary new
]

{ #category : #accessing }
MatchDetailsPack >> pack [

	^ pack
]

{ #category : #accessing }
MatchDetailsPack >> pack: anObject [

	pack := anObject
]
