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
SpPresenterBallTravel >> createHandle: aRod [
| popup handle |
popup := RSPopup text: [ :rod | rod teamWithOwnership teamName,'''s ',rod printPseudoRod].	
handle := RSBox new
	model: aRod;
	color: (self colourForTeam: aRod teamWithOwnershipIndex);
	size: 20@100;
	@ popup;
	"when: RSMouseClick do: [];"
	yourself.
^handle
]

{ #category : #drawing }
SpPresenterBallTravel >> createLineForRod: aRod [
| popup line startTime endTime |
popup := RSPopup text: [ :rod | rod teamWithOwnership teamName,'''s ',rod printPseudoRod].	
startTime := aRod matchState matchplayEvents first startTime - 50000 / self timeScale.
endTime := aRod matchState matchplayEvents last startTime + 50000 / self timeScale.
line := RSLine new
	model: aRod;
	color: (self colourForTeam: aRod teamWithOwnershipIndex);
	startPoint: startTime @ (self pseudoRodLocation: aRod);
	endPoint: endTime @ (self pseudoRodLocation: aRod);
	width: 4;	
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
	| teamOneRod teamOneRodLine teamTwoRod teamTwoRodLine |
	teamOneRod := eachRodClass new
		matchState: self matchState;
		teamWithPossession_: self matchState teamOne;
		yourself.
	teamOneRodLine := self createLineForRod: teamOneRod.
	teamOneRodLine markerStart: (self createHandle: teamOneRod).
	teamTwoRod := eachRodClass new
		matchState: self matchState;
		teamWithPossession_: self matchState teamTwo;
		yourself.
	teamTwoRodLine := self createLineForRod: teamTwoRod.	
	teamTwoRodLine markerEnd: (self createHandle: teamTwoRod).
	rodLines add: teamOneRodLine; add: teamTwoRodLine ].
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
SpPresenterBallTravel >> pseudoRodLocation: aPseudoRodEvent [
"Answer the vertical displacement of the specified pseudoRod from the origin, team two's goal"

^aPseudoRodEvent pseudoRodLocation * 20
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
SpPresenterBallTravel >> timeScale [
^300.0
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
