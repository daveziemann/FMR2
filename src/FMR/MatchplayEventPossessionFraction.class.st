Class {
	#name : #MatchplayEventPossessionFraction,
	#superclass : #MatchplayEventWrapper,
	#instVars : [
		'fraction'
	],
	#category : #FMR
}

{ #category : #accessing }
MatchplayEventPossessionFraction >> fraction [

	^ fraction
]

{ #category : #accessing }
MatchplayEventPossessionFraction >> fraction: anObject [

	fraction := anObject
]

{ #category : #printing }
MatchplayEventPossessionFraction >> printOn: aStream [
aStream
	<< 'Game ';
	<< self matchplayEvent gameNumber asString;
	space;
	<< self matchplayEvent asString;
	<< ' = ';
	<< self fraction asString;
	<< $%
]
