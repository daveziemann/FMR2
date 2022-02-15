Class {
	#name : #MatchplayComment,
	#superclass : #MatchplayEvent,
	#category : #FMR
}

{ #category : #accessing }
MatchplayComment class >> representation [ 
^$"
]

{ #category : #printing }
MatchplayComment >> colour [

^Color lightGray 
]

{ #category : #testing }
MatchplayComment >> isMatchplayComment [
^true
]

{ #category : #testing }
MatchplayComment >> isMatchplayEvent [
"Instances of some subclasses aren't actually events in the match but meta-events"
^false
]

{ #category : #printing }
MatchplayComment >> printDetail [
^String streamContents: [ :s | s << $"; << self detail asString; << $" ]
]

{ #category : #printing }
MatchplayComment >> printForFile [
^String streamContents: [ :s |
	s
		<< self representation;
		<< self detail asString;
		<< self representation ]
]

{ #category : #printing }
MatchplayComment >> printOn: aStream [ 

aStream space.
aStream nextPut: self representation.
aStream nextPutAll: self detail asString.
aStream nextPut: self representation.

]

{ #category : #printing }
MatchplayComment >> printRep [

^String tab
]

{ #category : #'UI - graphics' }
MatchplayComment >> shouldShowLine [
^true
]
