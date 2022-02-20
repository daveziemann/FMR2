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
SpPresenterBallTravel >> createShapes [
^self createTransitions collect: [ :eachTransition | eachTransition asLine ]
]

{ #category : #drawing }
SpPresenterBallTravel >> createTransitions [
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
rp script: [ :canvas | self drawShapes: self createShapes onCanvas: canvas.
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
