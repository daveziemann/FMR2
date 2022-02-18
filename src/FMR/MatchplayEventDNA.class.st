Class {
	#name : #MatchplayEventDNA,
	#superclass : #MatchplayEventWrapper,
	#category : #FMR
}

{ #category : #shapes }
MatchplayEventDNA >> asBox [
"Answer a rectangular Box that represents the receiver, an event with duration
	colour - colour of the table side for the team owning the event (brown for neutral events)
	size x - the duration of the event
	size y - fixed
	position x - the LHS at the elapsed timepoint in the game of the event start
	position y - the RHS at the elapsed timepoint in the game of the event end"

| arrowAlignment gameDisplacementY start width popup labeled |

arrowAlignment := 1.
gameDisplacementY := self gameNumber - 1 * self gameDisplacement.
start := (self startTimeInGame / self scale) rounded.
width := self durationOrZero / self scale.
popup := RSPopup text: self popupTextBlock.	
	
labeled := RSLabeled new fontSize: 12.
labeled location middle.
labeled shapeBuilder textBlock: [ :aMatchplayEvent | aMatchplayEvent printRep ].
	
^RSBox new
	model: self matchplayEvent;
	color: self boxColour;
	size: width@self boxHeight;
	translateTo: (width / 2 + start - arrowAlignment)@gameDisplacementY;
	border: (RSBorder new width: 1);
	@ popup;
	@ labeled;
	when: RSMouseClick do: self mouseClickBlock;
	yourself
]

{ #category : #shapes }
MatchplayEventDNA >> asLine [
"Answer a Line that represents the receiver, either an event with no duration, or the start if the event
	colour - colour of the table side for the team owning the event (brown for neutral events)
	size x - the duration of the event
	size y - fixed
	position x - the LHS at the elapsed timepoint in the game of the event start
	position y - the RHS at the elapsed timepoint in the game of the event end"

| gameDisplacementY start popup teamSign line arrow arrowOffset |

gameDisplacementY := self gameNumber - 1 * self gameDisplacement.
arrowOffset := 10.
start := (self startTimeInGame / self scale) rounded.
popup := RSPopup text: self popupTextBlock.	
teamSign := #(-1 1) at: self teamWithOwnershipIndex .
line := RSLine new
	model: self matchplayEvent;
	color: self colour;
	startPoint: start@(self boxHeight / 2 + arrowOffset * teamSign + gameDisplacementY);
	endPoint: start@(100 * teamSign + gameDisplacementY);
	width: 2;	
	@ popup;
	when: RSMouseClick do: self mouseClickBlock;
	yourself.
arrow := RSPolygon new points: { -10@0 . 0@ -10 . 10@0 }; color: self colour; size: 20.
line markerStart: arrow.
line markerEnd: self lineEndMarker.
^line
]

{ #category : #shapes }
MatchplayEventDNA >> asShapes [
"Answer a collection of shapes that represents the receiver"

^OrderedCollection new
	in: [ :shapes |
		self shouldShowLine ifTrue: [ shapes add: self asLine ].
		self shouldShowBox ifTrue: [ shapes add: self asBox ].
		shapes ]
	

]

{ #category : #divert }
MatchplayEventDNA >> boxColour [
^self matchplayEvent boxColour
]

{ #category : #tuning }
MatchplayEventDNA >> boxHeight [
^60
]

{ #category : #divert }
MatchplayEventDNA >> colour [
^self matchplayEvent colour
]

{ #category : #divert }
MatchplayEventDNA >> detail [
^self matchplayEvent detail
]

{ #category : #divert }
MatchplayEventDNA >> durationOrZero [
^self matchplayEvent durationOrZero
]

{ #category : #tuning }
MatchplayEventDNA >> gameDisplacement [
^250
]

{ #category : #divert }
MatchplayEventDNA >> gameNumber [
^self matchplayEvent gameNumber
]

{ #category : #shapes }
MatchplayEventDNA >> lineEndMarker [
"Answer the line end marker shape acoording to the matchplay event type:
	Goal - circle
	Other - square"

| scale |

"Increase the size of the line end marker if there is detail on the event"
scale := self detail ifNil:[ 1 ] ifNotNil: [ 1.2 ].

self matchplayEvent isGoal ifTrue: [ ^RSEllipse new radius: 10*scale; color: self colour ].
self matchplayEvent class == Infraction ifTrue: [ ^RSShapeFactory octagon size: 25*scale; color: self colour ].
^RSBox new size: 20@20*scale; color: self colour
]

{ #category : #divert }
MatchplayEventDNA >> matchState [
^self matchplayEvent matchState
]

{ #category : #shapes }
MatchplayEventDNA >> mouseClickBlock [
"Open the owning match state UI and highlight the matchplay event underlying the clicked shape"

^[ :event | event shape model matchState open highlightMatchplayEvent: event shape model ]
]

{ #category : #shapes }
MatchplayEventDNA >> popupTextBlock [
^[ :aMatchplayEvent | aMatchplayEvent shapeHoverText ]
]

{ #category : #tuning }
MatchplayEventDNA >> scale [
^200
]

{ #category : #divert }
MatchplayEventDNA >> shouldShowBox [
^self matchplayEvent shouldShowBox
]

{ #category : #divert }
MatchplayEventDNA >> shouldShowLine [
^self matchplayEvent shouldShowLine
]

{ #category : #divert }
MatchplayEventDNA >> startTimeInGame [
^self matchplayEvent startTimeInGame
]

{ #category : #divert }
MatchplayEventDNA >> teamWithOwnershipIndex [
^self matchplayEvent teamWithOwnershipIndex
]
