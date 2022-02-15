Class {
	#name : #SpPresenterDNA,
	#superclass : #'SpPresenterFMR_',
	#instVars : [
		'matchState'
	],
	#category : #FMR
}

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
rp script: [ :canvas | self drawShapes: self createShapes onCanvas: canvas ].
self layout: (SpBoxLayout newLeftToRight hAlignStart
	add: rp withConstraints: [ :c | c width: 1800 ];
	yourself)
]

{ #category : #accessing }
SpPresenterDNA >> matchState [

	^ matchState
]

{ #category : #accessing }
SpPresenterDNA >> matchState: anObject [

	matchState := anObject
]
