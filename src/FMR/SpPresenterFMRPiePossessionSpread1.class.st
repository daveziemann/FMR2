Class {
	#name : #SpPresenterFMRPiePossessionSpread1,
	#superclass : #'SpPresenterFMRPie_',
	#category : #FMR
}

{ #category : #initialization }
SpPresenterFMRPiePossessionSpread1 >> computeExtent [
^(self matchState numberOfGames + 1 * 300)@650
]

{ #category : #initialization }
SpPresenterFMRPiePossessionSpread1 >> initializePresenters [

self statisticCategory: 'Possession Time Total'.
self statistics: ( self matchState statisticsGenerator generate presentableStatistics select: [ :e | e statisticCategory = self statisticCategory ]).

self pies1: (self piesForTeam: 1).
self pies2: (self piesForTeam: 2).

self layout: (SpBoxLayout newTopToBottom 
	add: (self pies1 inject: SpBoxLayout newLeftToRight into: [ :c :e | c add: e ]) withConstraints: [ :c | c height: 300; padding: 2 ];
	add: (self pies2 inject: SpBoxLayout newLeftToRight into: [ :c :e | c add: e ]) withConstraints: [ :c | c height: 300; padding: 2 ];
	yourself)
]

{ #category : #initialization }
SpPresenterFMRPiePossessionSpread1 >> piesForTeam: teamNumber [

^self matchState gameNumbers collect: [ :g |
	| p objects |
	p := self instantiate: SpRoassalPresenter.
	objects := self statistics collect: [ :e | e copy gameNumber: g; teamNumber: teamNumber ].
	p script: [ :canvas | self seePie: canvas numbers: objects ]]
]

{ #category : #initialization }
SpPresenterFMRPiePossessionSpread1 >> seePie: canvas numbers: share [
| pie borderWin borderLose border pieLabel |

pie := RSPie new
	objects: share;
	slice: [ :obj | obj getResult result asSeconds ];
	yourself.

borderWin := RSBorder new width: 5; color: #brown.
borderLose := RSBorder new width: 2.
border := share first teamNumber = (self matchState teamThatWonGame: share first gameNumber)
	ifTrue: [ borderWin  ]
	ifFalse: [ borderLose ].

pie sliceShape
	border: border;
	innerRadius: 1;
	externalRadius: 200.

pie container: canvas.

pieLabel := RSPieLabeledInteraction new.
pieLabel labelShape fontSize: 16.
pieLabel labelText: [ :obj | obj statisticGroup, ' - ',(obj getResult result * 100 / pie totalSum) asSeconds rounded asString, '%' ].

pie sliceColor: NSScale category10; build.

"self animationBounce: pie."
self animationOutin: pie.
"pie canvas zoomToFit."
pie canvas when: RSExtentChangedEvent do: [ pie canvas zoomToFit ].
pie shapes @ pieLabel.
pie canvas @ RSCanvasController.
^pie
]

{ #category : #initialization }
SpPresenterFMRPiePossessionSpread1 >> title [
^'Spread of possession time across each team''s rods in each game'
]
