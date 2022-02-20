Class {
	#name : #PseudoRodTransition1,
	#superclass : #FMRObject,
	#instVars : [
		'fromEvent',
		'toEvent'
	],
	#category : #FMR
}

{ #category : #drawing }
PseudoRodTransition1 >> asLine [
| popup line |
popup := RSPopup text: self popupTextBlock.	
line := RSLine new
	model: self;
	color: self colour;
	startPoint: self fromRodLocation@self fromElapsedTimeDisplacement;
	endPoint: self toRodLocation@self toElapsedTimeDisplacement;
	width: 2;	
	@ popup;
	when: RSMouseClick do: self mouseClickBlock;
	yourself.
line markerEnd: self lineEndMarker.
^line
]

{ #category : #drawing }
PseudoRodTransition1 >> colour [
"Answer the colour of the line representing this transition"

^self fromEvent isGoal 
	ifTrue: [ Color transparent ]
	ifFalse: [ self fromEvent colour ]
]

{ #category : #drawing }
PseudoRodTransition1 >> elapsedTimeDisplacement: aPseudoRod [
^aPseudoRod startTime / 1000.0
]

{ #category : #drawing }
PseudoRodTransition1 >> fromElapsedTimeDisplacement [
^self elapsedTimeDisplacement: self fromEvent
]

{ #category : #accessing }
PseudoRodTransition1 >> fromEvent [

	^ fromEvent
]

{ #category : #accessing }
PseudoRodTransition1 >> fromEvent: anObject [

	fromEvent := anObject
]

{ #category : #drawing }
PseudoRodTransition1 >> fromRodLocation [
^self rodLocation: self fromEvent
]

{ #category : #drawing }
PseudoRodTransition1 >> lineEndMarker [
"Answer the line end marker shape according to the to event type:
	Goal - circle"

^self toEvent isGoal ifTrue: [ ^RSEllipse new radius: 10; color: self colour ].
]

{ #category : #drawing }
PseudoRodTransition1 >> mouseClickBlock [
"Open the owning match state UI and highlight the matchplay event underlying the clicked shape"

^[ :event | event shape model fromEvent matchState open highlightMatchplayEvent: event shape model fromEvent ]
]

{ #category : #drawing }
PseudoRodTransition1 >> popupTextBlock [
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
PseudoRodTransition1 >> rodLocation: aPseudoRodEvent [
"Answer the horizontal displacement of the specified pseudoRod from the origin, team left's goal"

^(aPseudoRodEvent distanceToRodOrGoal: (Goal new
	matchState: self fromEvent matchState;
	teamWithPossession_: self fromEvent matchState teamLeft;
	yourself)) * 20
		 
]

{ #category : #drawing }
PseudoRodTransition1 >> toElapsedTimeDisplacement [
^self elapsedTimeDisplacement: self toEvent
]

{ #category : #accessing }
PseudoRodTransition1 >> toEvent [

	^ toEvent
]

{ #category : #accessing }
PseudoRodTransition1 >> toEvent: anObject [

	toEvent := anObject
]

{ #category : #drawing }
PseudoRodTransition1 >> toRodLocation [
^self rodLocation: self toEvent
]
