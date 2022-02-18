Class {
	#name : #SpPresenterDNA,
	#superclass : #'SpPresenterFMR_',
	#instVars : [
		'matchState'
	],
	#category : #FMR
}

{ #category : #initialization }
SpPresenterDNA >> colourForTeam: aTeamNumber [
^self matchState colourForTeam: aTeamNumber inGame: 0
]

{ #category : #drawing }
SpPresenterDNA >> createShapes [
^(1 to: self matchState numberOfGames )
	collect: [ :eachGameNumber | self createShapesForGame: eachGameNumber ]
]

{ #category : #drawing }
SpPresenterDNA >> createShapesForGame: aGameNumber [
| gameEvents gameShapes gameLabel |

gameEvents := (self matchState matchplayEvents piecesCutWhere: [ :a :b | a isEndGame ]) at: aGameNumber.

gameShapes := gameEvents
	inject: RSGroup new
	into: [ :group :eachMatchplayEvent |
		group addAll: eachMatchplayEvent asShapes; yourself ].
	
gameLabel := RSLabel new
	text: 'Game ',aGameNumber asString,': ';
	fontSize: 16;
	yourself.

RSLocation new left; outer; offset: -50@0; stick: gameLabel on: gameShapes first.

^{gameLabel.gameShapes}
]

{ #category : #drawing }
SpPresenterDNA >> drawShapes: shapes onCanvas: aCanvas [
aCanvas addAll: shapes flattened.
aCanvas @ RSCanvasController.
]

{ #category : #initialization }
SpPresenterDNA >> initializePresenters [
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
SpPresenterDNA >> legendTeams [
| legend |

legend := RSLegend new.
legend layout horizontal.
legend location above offset: 0@(-50).
legend text: self matchState teamOne teamName withBoxColor: (self colourForTeam: 1).
legend text: self matchState teamTwo teamName withBoxColor: (self colourForTeam: 2).
^legend
]

{ #category : #accessing }
SpPresenterDNA >> matchState [

	^ matchState
]

{ #category : #accessing }
SpPresenterDNA >> matchState: anObject [

	matchState := anObject
]

{ #category : #drawing }
SpPresenterDNA >> shapeForTitle [
^RSLabel new
	text: 'DNA for match where ',self matchState matchProgressSummary;
	fontSize: 16;
	translateTo: 500@(-250);
	yourself
]
