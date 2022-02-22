Class {
	#name : #SpPresenterPseudoRodTransitionChart,
	#superclass : #'SpPresenterFMR_',
	#instVars : [
		'matchState'
	],
	#category : #FMR
}

{ #category : #access }
SpPresenterPseudoRodTransitionChart >> colourForTeam: aTeamNumber [
^self matchState colourForTeam: aTeamNumber inGame: 0
]

{ #category : #creation }
SpPresenterPseudoRodTransitionChart >> createGoalLines [
| teamOneGoal teamOneGoalLine teamTwoGoal teamTwoGoalLine |

teamOneGoal := Goal new
	matchState: self matchState;
	teamWithPossession_: self matchState teamOne;
	yourself.
teamOneGoalLine := (self createLineForRod: teamOneGoal) dashed; width: 8.
teamTwoGoal := Goal new
	matchState: self matchState;
	teamWithPossession_: self matchState teamTwo;
	yourself.
teamTwoGoalLine := (self createLineForRod: teamTwoGoal) dashed; width: 8.

^{teamOneGoalLine.teamTwoGoalLine}

]

{ #category : #creation }
SpPresenterPseudoRodTransitionChart >> createHandleBox: aRod [
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

{ #category : #creation }
SpPresenterPseudoRodTransitionChart >> createLineForRod: aRod [
| popup line rodStart rodEnd |
popup := RSPopup text: [ :rod | rod teamWithOwnership teamName,'''s ',rod printPseudoRod].	
rodStart := aRod matchState matchplayEvents first startTime - 100000 / PseudoRodTransition timeScale.
rodEnd := aRod matchState matchplayEvents last startTime + 100000 / PseudoRodTransition timeScale.
line := RSLine new
	model: aRod;
	color: (self colourForTeam: aRod teamWithOwnershipIndex);
	startPoint: rodStart @ (PseudoRodTransition pseudoRodLocation: aRod);
	endPoint: rodEnd @ (PseudoRodTransition pseudoRodLocation: aRod);
	width: 4;	
	@ popup;
	when: RSMouseClick do: [];
	yourself.
"line markerEnd: self lineEndMarker."
^line
]

{ #category : #creation }
SpPresenterPseudoRodTransitionChart >> createRodLines [
| rodLines |

rodLines := OrderedCollection new.
{ Rod2.Rod5.Rod3 } do: [ :eachRodClass |
	| teamOneRod teamOneRodLine teamTwoRod teamTwoRodLine |
	teamOneRod := eachRodClass new
		matchState: self matchState;
		teamWithPossession_: self matchState teamOne;
		yourself.
	teamOneRodLine := self createLineForRod: teamOneRod.
	teamOneRodLine markerStart: (self createHandleBox: teamOneRod).
	teamTwoRod := eachRodClass new
		matchState: self matchState;
		teamWithPossession_: self matchState teamTwo;
		yourself.
	teamTwoRodLine := self createLineForRod: teamTwoRod.	
	teamTwoRodLine markerEnd: (self createHandleBox: teamTwoRod).
	rodLines add: teamOneRodLine; add: teamTwoRodLine ].
^rodLines


]

{ #category : #creation }
SpPresenterPseudoRodTransitionChart >> createShapes [
^{self createTransitionLines.self createRodLines.self createGoalLines}
]

{ #category : #creation }
SpPresenterPseudoRodTransitionChart >> createTransitionLines [
^self createTransitions collect: [ :eachTransition | eachTransition asLine ]
]

{ #category : #creation }
SpPresenterPseudoRodTransitionChart >> createTransitions [
| transitions fromEvent toEvent |

transitions := OrderedCollection new.

fromEvent := self matchState matchplayEvents first nextPseudoRodEvent.
[ (toEvent := fromEvent nextPseudoRodEvent) notNil ]	 
	whileTrue: [
		fromEvent isGoal ifFalse: [ 
			transitions add: (PseudoRodTransition new
				fromEvent: fromEvent;
				toEvent: toEvent;
				yourself) ].
		fromEvent := toEvent ].
^transitions
]

{ #category : #drawing }
SpPresenterPseudoRodTransitionChart >> drawShapes: shapes onCanvas: aCanvas [
aCanvas addAll: shapes flattened.
aCanvas @ RSCanvasController.
aCanvas @ RSScrollBarsCanvasInteraction
]

{ #category : #initialization }
SpPresenterPseudoRodTransitionChart >> initializePresenters [
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
SpPresenterPseudoRodTransitionChart >> legendTeams [
| legend |

legend := RSLegend new.
legend layout horizontal.
legend location above offset: 0@(-50).
legend text: self matchState teamOne teamName withBoxColor: (self colourForTeam: 1).
legend text: self matchState teamTwo teamName withBoxColor: (self colourForTeam: 2).
^legend
]

{ #category : #accessing }
SpPresenterPseudoRodTransitionChart >> matchState [

	^ matchState
]

{ #category : #accessing }
SpPresenterPseudoRodTransitionChart >> matchState: anObject [

	matchState := anObject
]

{ #category : #drawing }
SpPresenterPseudoRodTransitionChart >> shapeForTitle [
^RSLabel new
	text: 'Ball Transitions for match where ',self matchState matchProgressSummary;
	fontSize: 16;
	translateTo: 500@(-120);
	yourself
]
