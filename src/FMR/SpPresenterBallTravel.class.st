Class {
	#name : #SpPresenterBallTravel,
	#superclass : #'SpPresenterFMR_',
	#instVars : [
		'matchState'
	],
	#category : #FMR
}

{ #category : #drawing }
SpPresenterBallTravel >> colourForTeam: aTeamNumber [
^self matchState colourForTeam: aTeamNumber inGame: 0
]

{ #category : #drawing }
SpPresenterBallTravel >> createLineForHandle: aRod [
| popup line |
popup := RSPopup text: [''].	
line := RSLine new
	model: aRod;
	color: aRod colour;
	startPoint: 0 @ (self matchState table rodLocation: aRod);
	endPoint: 100 @ (self matchState table rodLocation: aRod);
	width: 10;	
	@ popup;
	when: RSMouseClick do: [];
	yourself.
^line
]

{ #category : #drawing }
SpPresenterBallTravel >> createLineForRod: aRod [
| popup line startTime endTime |
popup := RSPopup text: [''].	
startTime := aRod matchState matchplayEvents first startTime - 50000 / 1000.0.
endTime := aRod matchState matchplayEvents last startTime + 50000 / 1000.0.
line := RSLine new
	model: aRod;
	color: aRod colour;
	startPoint: startTime @ (self matchState table rodLocation: aRod);
	endPoint: endTime @ (self matchState table rodLocation: aRod);
	width: 2;	
	@ popup;
	when: RSMouseClick do: [];
	yourself.
"line markerEnd: self lineEndMarker."
^line
]

{ #category : #drawing }
SpPresenterBallTravel >> createRodLines [
| rodLines |

rodLines := OrderedCollection new.
{ Rod2.Rod5.Rod3 } do: [ :eachRodClass |
	| teamLeftRod teamLeftRodLine teamRightRod teamRightRodLine |
	teamLeftRod := eachRodClass new
		matchState: self matchState;
		teamWithPossession_: self matchState teamLeft;
		yourself.
	teamLeftRodLine := self createLineForRod: teamLeftRod.
	teamLeftRodLine markerStart: (self createLineForHandle: teamLeftRod).
	teamRightRod := eachRodClass new
		matchState: self matchState;
		teamWithPossession_: self matchState teamRight;
		yourself.
	teamRightRodLine := self createLineForRod: teamRightRod.	
	teamRightRodLine markerStart: (self createLineForHandle: teamRightRod).
	rodLines add: teamLeftRodLine; add: teamRightRodLine ].
^rodLines


]

{ #category : #drawing }
SpPresenterBallTravel >> createShapes [
^{self createTransitionLines.self createRodLines}
]

{ #category : #drawing }
SpPresenterBallTravel >> createTransitionLines [
^self transitions collect: [ :eachTransition | eachTransition asLine ]
]

{ #category : #drawing }
SpPresenterBallTravel >> drawShapes: shapes onCanvas: aCanvas [
aCanvas addAll: shapes flattened.
aCanvas @ RSCanvasController.
aCanvas @ RSScrollBarsCanvasInteraction
]

{ #category : #initialization }
SpPresenterBallTravel >> initializePresenters [
| rp |
rp := self instantiate: SpRoassalPresenter.
rp script: [ :canvas | self drawShapes: self createShapes flattened onCanvas: canvas.
	(self legendTeams container: canvas) build.
	canvas add: self shapeForTitle ].
self layout: (SpBoxLayout newLeftToRight hAlignStart
	add: rp withConstraints: [ :c | c width: 1800 ];
	yourself)
]

{ #category : #drawing }
SpPresenterBallTravel >> legendTeams [
| legend |

legend := RSLegend new.
legend layout horizontal.
legend location above offset: 0@(-50).
legend text: self matchState teamOne teamName withBoxColor: (self colourForTeam: 1).
legend text: self matchState teamTwo teamName withBoxColor: (self colourForTeam: 2).
^legend
]

{ #category : #accessing }
SpPresenterBallTravel >> matchState [

	^ matchState
]

{ #category : #accessing }
SpPresenterBallTravel >> matchState: anObject [

	matchState := anObject
]

{ #category : #drawing }
SpPresenterBallTravel >> shapeForTitle [
^RSLabel new
	text: 'DNA for match where ',self matchState matchProgressSummary;
	fontSize: 16;
	translateTo: 500@(-250);
	yourself
]

{ #category : #drawing }
SpPresenterBallTravel >> transitions [
| transitions fromEvent toEvent |

transitions := OrderedCollection new.

fromEvent := self matchState matchplayEvents first nextPseudoRodEvent.
[ (toEvent := fromEvent nextPseudoRodEvent) notNil ]	 
	whileTrue: [ 
		transitions add: (PseudoRodTransition new
			fromEvent: fromEvent;
			toEvent: toEvent;
			yourself).
		fromEvent := toEvent ].
^transitions
]
