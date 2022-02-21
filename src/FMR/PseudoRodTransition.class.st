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
PseudoRodTransition >> asLine [
| popup lineStopShortBy line |
popup := RSPopup text: self popupTextBlock.	
lineStopShortBy := (self toRodLocation - self fromRodLocation) sign * 10.
line := RSLine new
	model: self;
	color: self colour;
	startPoint: self fromElapsedTimeDisplacement @ self fromRodLocation;
	endPoint: self toElapsedTimeDisplacement @ (self toRodLocation - lineStopShortBy);
	width: 2;	
	@ popup;
	when: RSMouseClick do: self mouseClickBlock;
	yourself.
line markerEnd: self lineEndMarker.
^line
]

{ #category : #drawing }
PseudoRodTransition >> colour [
"Answer the colour of the line representing this transition"

^self fromEvent isGoal 
	ifTrue: [ Color transparent ]
	ifFalse: [ self fromEvent colour ]
]

{ #category : #drawing }
PseudoRodTransition >> elapsedTimeDisplacement: aPseudoRod [
^aPseudoRod startTime / self timeScale
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
^self pseudoRodLocation: self fromEvent
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
PseudoRodTransition >> popupTextBlock [
^[ :aTransition |
	String streamContents: [  :s |
		s
			<< aTransition fromEvent shapeHoverText;
			cr; cr;
			<< ' to ';
			cr; cr;			
			<< aTransition toEvent shapeHoverText ]]
]

{ #category : #drawing }
PseudoRodTransition >> printOn: aStream [
self fromEvent printOn: aStream.
aStream << ' -> '.
self toEvent printOn: aStream.
]

{ #category : #drawing }
PseudoRodTransition >> pseudoRodLocation: aPseudoRodEvent [
"Answer the vertical displacement of the specified pseudoRod from the origin, team two's goal"

^aPseudoRodEvent pseudoRodLocation * 20
]

{ #category : #tuning }
PseudoRodTransition >> timeScale [
^300.0
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
^self pseudoRodLocation: self toEvent
]
