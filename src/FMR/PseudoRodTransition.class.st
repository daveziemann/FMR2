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
| popup line |
popup := RSPopup text: self popupTextBlock.	
line := RSLine new
	model: self;
	color: self colour;
	startPoint: self fromElapsedTimeDisplacement @ self fromRodLocation;
	endPoint: self toElapsedTimeDisplacement @ self toRodLocation;
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
^aPseudoRod startTime / 1000.0
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
^self rodLocation: self fromEvent
]

{ #category : #drawing }
PseudoRodTransition >> lineEndMarker [
"Answer the line end marker shape according to the to event type:
	Goal - circle"

^self toEvent isGoal ifTrue: [ ^RSEllipse new radius: 10; color: self colour ].
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
PseudoRodTransition >> rodLocation: aPseudoRodEvent [
"Answer the horizontal displacement of the specified pseudoRod from the origin, team left's goal"

^self fromEvent matchState table rodLocation: aPseudoRodEvent
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
^self rodLocation: self toEvent
]
