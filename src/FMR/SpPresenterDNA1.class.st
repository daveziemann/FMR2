Class {
	#name : #SpPresenterDNA1,
	#superclass : #'SpPresenterFMR_',
	#instVars : [
		'matchState'
	],
	#category : #FMR
}

{ #category : #drawing }
SpPresenterDNA1 >> createShapes [
^self matchState matchplayEvents
	inject: RSGroup new
	into: [ :shapes :eachMatchplayEvent |
		shapes addAll: eachMatchplayEvent asShapes; yourself ]
]

{ #category : #drawing }
SpPresenterDNA1 >> drawOnCanvas: aCanvas [
aCanvas addAll: self createShapes.
aCanvas @ RSCanvasController
]

{ #category : #initialization }
SpPresenterDNA1 >> initializePresenters [
| rp |
rp := self instantiate: SpRoassalPresenter.
rp script: [ :canvas | self drawOnCanvas: canvas ].
self layout: (SpBoxLayout newLeftToRight hAlignStart
	add: rp withConstraints: [ :c | c width: 1800 ];
	yourself)
]

{ #category : #accessing }
SpPresenterDNA1 >> matchState [

	^ matchState
]

{ #category : #accessing }
SpPresenterDNA1 >> matchState: anObject [

	matchState := anObject
]
