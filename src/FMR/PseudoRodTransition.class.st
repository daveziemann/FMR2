Class {
	#name : #PseudoRodTransition,
	#superclass : #FMRObject,
	#instVars : [
		'fromEvent',
		'toEvent'
	],
	#category : #FMR
}

{ #category : #drawing }
PseudoRodTransition class >> pseudoRodLocation: aPseudoRodEvent [
"Answer the vertical displacement of the specified pseudoRod from the origin, team two's goal"

^aPseudoRodEvent pseudoRodLocation * self pseudoRodLocationScale
]

{ #category : #drawing }
PseudoRodTransition class >> pseudoRodLocationScale [
^5
]

{ #category : #tuning }
PseudoRodTransition class >> timeScale [
^1200.0
]

{ #category : #drawing }
PseudoRodTransition >> asLine [
| popup lineStopShortBy line |
popup := RSPopup text: self popupText.
lineStopShortBy := (self toRodLocation - self fromRodLocation) sign * 10. "make room for arrow"
line := RSLine new
	model: self;
	color: self colour;
	startPoint: self fromElapsedTimeDisplacement @ self fromRodLocation;
	endPoint: self toElapsedTimeDisplacement @ (self toRodLocation - lineStopShortBy);
	width: 3;	
	@ popup;
	when: RSMouseClick do: self mouseClickBlock;
	yourself.
line markerEnd: self lineEndMarker.
^line
]

{ #category : #drawing }
PseudoRodTransition >> colour [
"Answer the colour of the line representing this transition"

^self fromEvent matchState colourForTeam: self fromEvent teamWithOwnershipIndex inGame: 0
]

{ #category : #drawing }
PseudoRodTransition >> elapsedTimeDisplacement: aPseudoRod [
^aPseudoRod startTime / self class timeScale
]

{ #category : #printing }
PseudoRodTransition >> explainTransition [
^String streamContents: [  :s | | prep |
	prep := #(' on ' ' in ') at: self toEvent isGoal asBit + 1.
	s
		<< 'The ball started on ';
		<< self fromEvent teamWithOwnership teamName;
		<< '''s ';
		<< self fromEvent printPseudoRod;
		<< ' and after the transition it was';
		<< prep;
		<< self toEvent teamWithOwnership teamName;
		<< '''s ';
		<< self toEvent printPseudoRod;
		<< ' at which time ';
		<< self toEvent matchProgressSummary;
		cr; << Character null; cr; "Dumb way to get a blank line"
		<< 'The angle of the line is proportional to the possession time on the rod the transition is coming from.';
		cr; << Character null; cr. "Dumb way to get a blank line"
		self printOn: s ]
]

{ #category : #drawing }
PseudoRodTransition >> fromElapsedTimeDisplacement [
^self elapsedTimeDisplacement: self fromEvent
]

{ #category : #accessing }
PseudoRodTransition >> fromEvent [

	^ fromEvent
]

{ #category : #accessing }
PseudoRodTransition >> fromEvent: anObject [

	fromEvent := anObject
]

{ #category : #drawing }
PseudoRodTransition >> fromRodLocation [
^self class pseudoRodLocation: self fromEvent
]

{ #category : #drawing }
PseudoRodTransition >> lineEndMarker [
"Answer the line end marker shape according to the to event type:
	Goal - circle"

^self toEvent isGoal
	ifTrue: [ RSEllipse new radius: 10; color: self colour ]
	ifFalse: [ RSPolygon new points: { -10@0 . 0@ -10 . 10@0 }; color: self colour; size: 20 ]

]

{ #category : #drawing }
PseudoRodTransition >> mouseClickBlock [
"Open the owning match state UI and highlight the matchplay event underlying the clicked shape"

^[ :event | event shape model fromEvent matchState open highlightMatchplayEvent: event shape model fromEvent ]
]

{ #category : #drawing }
PseudoRodTransition >> popupText [
^self explainTransition withNoLineLongerThan: 60
]

{ #category : #drawing }
PseudoRodTransition >> printOn: aStream [
aStream
	<< 'A transition from ';
	<< self fromEvent printBriefly;
	<< ' to ';
	<< self toEvent printBriefly
]

{ #category : #drawing }
PseudoRodTransition >> toElapsedTimeDisplacement [
^self elapsedTimeDisplacement: self toEvent
]

{ #category : #accessing }
PseudoRodTransition >> toEvent [

	^ toEvent
]

{ #category : #accessing }
PseudoRodTransition >> toEvent: anObject [

	toEvent := anObject
]

{ #category : #drawing }
PseudoRodTransition >> toRodLocation [
^self class pseudoRodLocation: self toEvent
]
