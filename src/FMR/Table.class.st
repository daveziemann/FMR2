Class {
	#name : #Table,
	#superclass : #FMRObject,
	#instVars : [
		'type',
		'sideLeft',
		'sideRight'
	],
	#category : #FMR
}

{ #category : #access }
Table >> goalOffsetFraction [
"The distance from goalkeeper to goal as a fraction of one rod-distance-unit
	- it depends on table type"
	
^self type = 'Garlando'
	ifTrue: [ 0.5 ]
	ifFalse: [ 0.25 ]
]

{ #category : #initialization }
Table >> initialize [ 
self sideLeft: (TableSide new sideIndicator: $<).
self sideRight: (TableSide new sideIndicator: $>).
]

{ #category : #printing }
Table >> printOn: aStream [

aStream
	<< (self type,' (') asText;
	<< (self sideLeft asText: self sideLeft asString);
	<< ',' asText;
	<< (self sideRight asText: self sideRight asString);
	<< ')' asText
]

{ #category : #access }
Table >> rduSize [
"Answer the size of the rod displacement unit in cm
	- same for all tables"
	
^15
]

{ #category : #accessing }
Table >> sideLeft [

	^ sideLeft
]

{ #category : #accessing }
Table >> sideLeft: anObject [

	sideLeft := anObject
]

{ #category : #accessing }
Table >> sideRight [

	^ sideRight
]

{ #category : #accessing }
Table >> sideRight: anObject [

	sideRight := anObject
]

{ #category : #access }
Table >> sides [
^{self sideLeft.self sideRight}
]

{ #category : #printing }
Table >> tableSpec [
^String streamContents: [ :s |
	s
		<< self type;
		<< ',';
		<< self sideLeft colourName;
		<< ',';
		<< self sideRight colourName ]
]

{ #category : #accessing }
Table >> type [

	^ type
]

{ #category : #accessing }
Table >> type: anObject [
type := anObject.
]

{ #category : #updating }
Table >> updateFrom: aTriple [

self type: aTriple first.
self sideLeft colourName: aTriple second.
self sideRight colourName: aTriple third.
]
