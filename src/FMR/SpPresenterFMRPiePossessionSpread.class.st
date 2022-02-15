Class {
	#name : #SpPresenterFMRPiePossessionSpread,
	#superclass : #'SpPresenterFMRPie_',
	#category : #FMR
}

{ #category : #tuning }
SpPresenterFMRPiePossessionSpread >> computeExtent [
^(self matchState numberOfGames + 1 * 300)@650
]

{ #category : #drawing }
SpPresenterFMRPiePossessionSpread >> drawOnCanvas: aCanvas piesForGameStatistics: statsPerRodPerGamePerTeam [
| piesTeam1 piesTeam2 compositesTeam1 compositesTeam2 |

piesTeam1 := self piesForTeamStatistics: statsPerRodPerGamePerTeam first.
piesTeam2 := self piesForTeamStatistics: statsPerRodPerGamePerTeam second.

compositesTeam1 := piesTeam1 collect: [ :e | e container asShape ].
compositesTeam2 := piesTeam2 collect: [ :e | e container asShape ].

"Add composites to canvas to render on"
aCanvas addAll: compositesTeam1.
aCanvas addAll: compositesTeam2.

"Stick a label above each composite"
compositesTeam1 do: [ :e | | label |
		label := RSLabeled new
			text: (self pieTitle: e);
			fontSize: 20.
		label location above offset: 0@(-20).
		e @ label ].

"Layout pies"
RSGridLayout new lineItemsCount: compositesTeam1 size; on: compositesTeam1,compositesTeam2.

"Point the pies at the new canvas for the animation to work"
piesTeam1 do: [ :e | e container: aCanvas ].
piesTeam2 do: [ :e | e container: aCanvas ].

piesTeam1 do: [ :e | self animationOutin: e ].
piesTeam2 do: [ :e | self animationOutin: e ].

aCanvas when: RSExtentChangedEvent do: [ aCanvas zoomToFit ].
aCanvas @ RSCanvasController.

]

{ #category : #initialization }
SpPresenterFMRPiePossessionSpread >> initializePresenters [
| statsPerRodPerGamePerTeam sp |

self statisticCategory: 'Possession Time Total'.
self statistics: ( self matchState statisticsGenerator generate presentableStatistics select: [ :e | e statisticCategory = self statisticCategory ]).

statsPerRodPerGamePerTeam := #(1 2) collect: [ :eachTeamNumber |
	self matchState gameNumbers collect: [ :eachGameNumber |
		self statistics collect: [ :e | e copy gameNumber: eachGameNumber; teamNumber: eachTeamNumber ]]].

sp := self instantiate: SpRoassalPresenter.
sp script: [ :canvas | self drawOnCanvas: canvas piesForGameStatistics: statsPerRodPerGamePerTeam ].

self layout: (SpBoxLayout newLeftToRight hAlignStart
	add: sp withConstraints: [ :c | c width: 1800 ];
	yourself)
]

{ #category : #generating }
SpPresenterFMRPiePossessionSpread >> pieForRodStatistics: rodStatistics [
| pie winningColour borderWin borderLose border pieLabel |

pie := RSPie new
	objects: rodStatistics;
	slice: [ :obj | obj getResult result asSeconds ];
	sliceColor: NSScale category10;
	yourself.
winningColour := self matchState colourForTeam: (self matchState teamThatWonGame: rodStatistics first gameNumber) inGame: rodStatistics first gameNumber.
borderWin := RSBorder new width: 5; color: winningColour.
borderLose := RSBorder new width: 2.
border := rodStatistics first teamNumber = (self matchState teamThatWonGame: rodStatistics first gameNumber)
	ifTrue: [ borderWin  ]
	ifFalse: [ borderLose ].

pie sliceShape
	border: border;
	innerRadius: 1;
	externalRadius: 200.

pieLabel := RSPieLabeledInteraction new.
pieLabel labelShape fontSize: 16.
pieLabel labelText: [ :obj | obj statisticGroup, ' - ',(obj getResult result * 100 / pie totalSum) asSeconds rounded asString, '%' ].

pie build.

pie shapes @ pieLabel.
self animationOutin: pie.

^pie
]

{ #category : #generating }
SpPresenterFMRPiePossessionSpread >> pieTitle: aComposite [

^aComposite shapes first model gameNumber in: [ :aGameNumber |
	aGameNumber isZero 
		ifTrue: [ 'Match' ]
		ifFalse: [ 'Game ', aGameNumber asString ]]
]

{ #category : #generating }
SpPresenterFMRPiePossessionSpread >> piesForTeamStatistics: statsPerRodPerGame [

^statsPerRodPerGame collect: [ :eachRodStats | self pieForRodStatistics: eachRodStats ]
]

{ #category : #tuning }
SpPresenterFMRPiePossessionSpread >> title [
^'Spread of possession time across each team''s rods in each game'
]
