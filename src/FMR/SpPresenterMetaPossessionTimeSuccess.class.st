Class {
	#name : #SpPresenterMetaPossessionTimeSuccess,
	#superclass : #'SpPresenterFMR_',
	#instVars : [
		'success'
	],
	#category : #FMR
}

{ #category : #drawing }
SpPresenterMetaPossessionTimeSuccess >> createChart [
| minValue maxValue chart lp1 popup data plot vertical horizontal successes possessions t |

minValue := 30.
maxValue := 50.

self success: self trawlForSuccess.
data := Array new: self success last key withAll: #(0 0).
self success do: [ :e | data at: e key put: (data at: e key) + {1.e value} ].
data doWithIndex: [ :e :i |	i=1 ifFalse: [ data at: i put: (data at: i)+(data at: i-1) ]].
plot := data collect: [ :e | ((100.0 * (e second divideBy: e first)) round: 1) max: minValue ].

chart := RSChart new.
lp1 := RSLinePlot new x: (1 to: plot size) y: plot; color: Color red.

popup := RSPopupDecoration new.
popup chartPopupBuilder for: lp1 text: 'Passing rate at this time' color: #red.

chart addPlot: lp1; addDecoration: popup.
chart minValueY: minValue; maxValueY: maxValue.

vertical := RSVerticalTick new
	numberOfTicks: 10;
	labelConversion: [ :value | value asString,'%' ]
	yourself.
vertical shape dashed width: 1.
vertical configuration tickSize: chart extent x negated.
chart addDecoration: vertical.

horizontal := RSHorizontalTick new
	numberOfTicks: 18;
	labelConversion: [ :value | (value / 1000) rounded asDuration humanAbbreviatedReadablePrintString ]
	yourself.
horizontal shape width: 1.
horizontal configuration tickSize: chart extent y negated.	
chart addDecoration: horizontal.

successes := (self success collect:[ :e |e value]) sum.
possessions := self success size.
t := '5-rod passing success by time of possession (',successes asString,' passes from ',possessions asString,' possessions = ',(100.0*successes/possessions) rounded asString,'%)'.

chart addDecoration: (RSChartTitleDecoration new fontSize: 8; title: t).
chart addDecoration: (RSYLabelDecoration new title: '5-rod pass success rate'; fontSize: 10).
chart addDecoration: (RSXLabelDecoration new title: '5-rod possession time'; fontSize: 10).

chart build.

^chart
]

{ #category : #drawing }
SpPresenterMetaPossessionTimeSuccess >> drawOnCanvas: aCanvas charts: charts [
"Render the four charts on aCanvas"
| compositeShapes |

"Create a composite from each chart canvas and add to rendering canvas"
compositeShapes := charts collect:[ :eachChart | eachChart container asShape ].
aCanvas addAll: compositeShapes.

"Layout 2x2"
RSGridLayout new lineItemsCount: 2; gapSize: 10; on: compositeShapes.

aCanvas when: RSMouseClick do: [ :event |  ].
aCanvas @ RSCanvasController
]

{ #category : #initialization }
SpPresenterMetaPossessionTimeSuccess >> initializePresenters [
| charts rp |

charts := OrderedCollection new
	add: self createChart;
	yourself.

rp := self instantiate: SpRoassalPresenter.
rp script: [ :canvas | self drawOnCanvas: canvas charts: charts ].

self layout: (SpBoxLayout newLeftToRight hAlignStart
	add: rp withConstraints: [ :c | c width: 1800 ];
	yourself)

]

{ #category : #drawing }
SpPresenterMetaPossessionTimeSuccess >> possessionTimeAndSuccess: aMatchState [
"Answer a collection of associations
	- each key a possession time
	- each value a flag indicating whether the transition was a success or a fail"

| sg ps r c d |

sg := aMatchState statisticsGenerator generate.
ps := sg at: self statisticClass.
c := ps sequences collect: [ :eachSequence |
	r := (ps scanner sequence: eachSequence) scanScalar scalarSequence.
	r collect: [ :e | e key durationOrZero -> e value notNil asBit ]].
d := (c collect: [ :ec | ec collect: [ :e | e value ]]) sum.

^c first with: d collect: [ :a :b | a key -> b ]
]

{ #category : #drawing }
SpPresenterMetaPossessionTimeSuccess >> statisticClass [
^self subclassResponsibility  
]

{ #category : #accessing }
SpPresenterMetaPossessionTimeSuccess >> success [

	^ success
]

{ #category : #accessing }
SpPresenterMetaPossessionTimeSuccess >> success: anObject [

	success := anObject
]

{ #category : #drawing }
SpPresenterMetaPossessionTimeSuccess >> trawl [
"Trawl the meta data and answer data for plotting"

| data |

self success: self trawlForSuccess.

data := Array new: self success last key withAll: #(0 0).
self success do: [ :e | data at: e key put: (data at: e key) + {1.e value} ].
data doWithIndex: [ :e :i |	i=1 ifFalse: [ data at: i put: (data at: i)+(data at: i-1) ]].
^data collect: [ :e | ((100.0 * (e second divideBy: e first)) round: 1) max: self minValue ].

]

{ #category : #drawing }
SpPresenterMetaPossessionTimeSuccess >> trawlForSuccess [
| possessionTimeAndSuccess |

possessionTimeAndSuccess := SortedCollection new.
MatchStateEnumerator new allCompletedStandardMatchesDo: [ :eachMatchState |
	possessionTimeAndSuccess addAll: (self possessionTimeAndSuccess: eachMatchState) ].
^possessionTimeAndSuccess asArray
]
