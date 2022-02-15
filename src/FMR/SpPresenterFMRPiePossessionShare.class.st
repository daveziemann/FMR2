Class {
	#name : #SpPresenterFMRPiePossessionShare,
	#superclass : #'SpPresenterFMRPie_',
	#category : #FMR
}

{ #category : #tuning }
SpPresenterFMRPiePossessionShare >> computeExtent [
^(self matchState numberOfGames + 1 * 300)@320
]

{ #category : #drawing }
SpPresenterFMRPiePossessionShare >> drawOnCanvas: aCanvas piesForGameStatistics: statsPerGame [
| pies compositeShapes |

"Create pies"
pies := statsPerGame collect: [ :eachStatisticsPair | self pieForTwoStatistics: eachStatisticsPair ].

"Build composites from each pie's canvas"
compositeShapes := pies collect: [ :e | e container asShape ].

"Add composites to canvas to render on"
aCanvas addAll: compositeShapes.

"Stick a label above each composite"
compositeShapes do: [ :e | | label |
		label := RSLabeled new
			text: (self pieTitle: e);
			fontSize: 20.
		label location above offset: 0@(-20).
		e @ label ].

"Layout pies"
RSHorizontalLineLayout on: compositeShapes.
"RSGridLayout new lineItemsCount: 3; on: compositeShapes."

"Point the pies at the new canvas for the animation to work"
pies do: [ :e | e container: aCanvas ].
pies do: [ :e | self animationOutin: e ].

aCanvas when: RSExtentChangedEvent do: [ aCanvas zoomToFit ].
aCanvas @ RSCanvasController.

]

{ #category : #initialization }
SpPresenterFMRPiePossessionShare >> initializePresenters [
| statsPerGame sp |

self statisticCategory: 'Possession Share'.
self statistics: (self matchState statisticsGenerator generate presentableStatistics select: [ :e | e statisticCategory = self statisticCategory ]).

statsPerGame := self matchState gameNumbers collect: [ :eachGameNumber |
	{	.self statistics first copy gameNumber: eachGameNumber; teamNumber: 1
		.self statistics first copy gameNumber: eachGameNumber; teamNumber: 2 } ].
	
sp := self instantiate: SpRoassalPresenter.
sp script: [ :canvas | self drawOnCanvas: canvas piesForGameStatistics: statsPerGame ].

self layout: (SpBoxLayout newLeftToRight hAlignStart
	add: sp withConstraints: [ :c | c width: 1800 ];
	yourself)
]

{ #category : #generating }
SpPresenterFMRPiePossessionShare >> pieForTwoStatistics: twoStatistics [
| pie pieLabel |

pie := RSPie new
	objects: twoStatistics;
	slice: [ :obj | obj getResult result second asSeconds ];
	yourself.
pie sliceShape
	border: (RSBorder new width: 2);
	innerRadius: 1;
	externalRadius: 200.

pieLabel := RSPieLabeledInteraction new.
pieLabel labelShape fontSize: 16.
pieLabel labelText: [ :obj | obj thisTeamName , ' - ',(obj getResult result second * 100 / pie totalSum) asSeconds rounded asString, '%' ].

pie sliceColor: [ :slice | slice model getColour ]; build.

"Thick border around winning team segment"
(pie shapes at: (self matchState teamThatWonGame: twoStatistics first gameNumber))
	border: (RSBorder new width: 4; color: FMRColour neutralColour).

pie shapes @ pieLabel.
self animationOutin: pie.

^pie

]

{ #category : #generating }
SpPresenterFMRPiePossessionShare >> pieTitle: aComposite [

^aComposite shapes first model gameNumber in: [ :aGameNumber |
	aGameNumber isZero 
		ifTrue: [ 'Match' ]
		ifFalse: [ 'Game ', aGameNumber asString ]]
]

{ #category : #tuning }
SpPresenterFMRPiePossessionShare >> title [
^'How the teams shared the total possession time in each game'
]
