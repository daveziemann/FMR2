Class {
	#name : #SpPresenterFMRPiePossessionShare1,
	#superclass : #'SpPresenterFMRPie_',
	#category : #FMR
}

{ #category : #initialization }
SpPresenterFMRPiePossessionShare1 >> computeExtent [
^(self matchState numberOfGames + 1 * 300)@320
]

{ #category : #initialization }
SpPresenterFMRPiePossessionShare1 >> initializePresenters [

self statisticCategory: 'Possession Share'.
self statistics: (self matchState statisticsGenerator generate presentableStatistics select: [ :e | e statisticCategory = self statisticCategory ]).

self pies1: (self matchState gameNumbers collect: [ :g |
	| p objects |
	p := self instantiate: SpRoassalPresenter.
	objects := {
		self statistics first copy gameNumber: g; teamNumber: 1 .
		self statistics first  copy gameNumber: g; teamNumber: 2}.
	p script: [ :canvas | self seePie: canvas numbers: objects ]]).

self layout: (SpBoxLayout newTopToBottom 
	add: (self pies1 inject: SpBoxLayout newLeftToRight into: [ :c :e | c add: e ]) withConstraints: [ :c | c height: 300; padding: 2 ];
	yourself)
]

{ #category : #initialization }
SpPresenterFMRPiePossessionShare1 >> seePie: canvas numbers: share [
| pie pieLabel |

pie := RSPie new
	objects: share;
	slice: [ :obj | obj getResult result second asSeconds ];
	yourself.
pie sliceShape
	border: (RSBorder new width: 2);
	innerRadius: 1;
	externalRadius: 200.

pie container: canvas.

pieLabel := RSPieLabeledInteraction new.
pieLabel labelShape fontSize: 16.
pieLabel labelText: [ :obj | obj thisTeamName , ' - ',(obj getResult result second * 100 / pie totalSum) asSeconds rounded asString, '%' ].

pie sliceColor: NSScale category10; build.

"Thick border around winning team segment"
(pie shapes at: (self matchState teamThatWonGame: share first gameNumber))
	border: (RSBorder new width: 4; color: #brown).

"self animationBounce: pie."
self animationOutin: pie.
"pie canvas zoomToFit."
pie canvas when: RSExtentChangedEvent do: [ pie canvas zoomToFit ].
pie shapes @ pieLabel.
pie canvas @ RSCanvasController.
^pie
]

{ #category : #initialization }
SpPresenterFMRPiePossessionShare1 >> title [
^'How the teams shared the total possession time in each game'
]
