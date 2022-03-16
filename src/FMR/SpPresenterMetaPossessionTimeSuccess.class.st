Class {
	#name : #SpPresenterMetaPossessionTimeSuccess,
	#superclass : #'SpPresenterFMR_',
	#instVars : [
		'possessionTimesAndSuccess'
	],
	#category : #FMR
}

{ #category : #drawing }
SpPresenterMetaPossessionTimeSuccess >> createChart [
| chart canvas lp1 popup plot vertical horizontal |

plot := self dataToPlot.

chart := RSChart new.
canvas := RSCanvas new.
chart container: canvas.
lp1 := RSLinePlot new x: (1 to: plot size) y: plot; color: Color red.

popup := RSPopupDecoration new.
chart addDecoration: popup.
popup chartPopupBuilder: (RSBlockChartPopupBuilder new
	rowShapeBlock: [ :thePlot :point |
		RSLabel new text: point y asString,'% success after ',point x asString,'ms'; bold ]).

chart addPlot: lp1.
chart minValueY: self minValue; maxValueY: self maxValue.

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

^chart
]

{ #category : #drawing }
SpPresenterMetaPossessionTimeSuccess >> createChartShape [
^self subclassResponsibility  
]

{ #category : #access }
SpPresenterMetaPossessionTimeSuccess >> dataToPlot [
| data |

data := Array new: self possessionTimesAndSuccess last key withAll: #(0 0).
self possessionTimesAndSuccess do: [ :e | data at: e key put: (data at: e key) + {1.e value} ].
data doWithIndex: [ :e :i |	i=1 ifFalse: [ data at: i put: (data at: i)+(data at: i-1) ]].
^data collect: [ :e | ((100.0 * (e second divideBy: e first)) round: 1) max: self minValue ]

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

{ #category : #drawing }
SpPresenterMetaPossessionTimeSuccess >> drawOnCanvas: aCanvas shapes: shapes [
"Render the four charts on aCanvas"

aCanvas addAll: shapes.

"Layout 2x2"
RSGridLayout new lineItemsCount: 2; gapSize: 10; on: shapes.

aCanvas when: RSMouseClick do: [ :event |  ].
aCanvas @ RSCanvasController
]

{ #category : #initialization }
SpPresenterMetaPossessionTimeSuccess >> initializePresenters [
| shapes rp |

self trawl.

shapes := OrderedCollection new
	add: self possessionTimeDistributionShape;
	add: self createChartShape;
	yourself.

rp := self instantiate: SpRoassalPresenter.
rp script: [ :canvas | self drawOnCanvas: canvas shapes: shapes ].

self layout: (SpBoxLayout newLeftToRight hAlignStart
	add: rp withConstraints: [ :c | c width: 1800 ];
	yourself)

]

{ #category : #access }
SpPresenterMetaPossessionTimeSuccess >> maxValue [
^self subclassResponsibility  
]

{ #category : #access }
SpPresenterMetaPossessionTimeSuccess >> minValue [
^self subclassResponsibility  
]

{ #category : #drawing }
SpPresenterMetaPossessionTimeSuccess >> possessionTimeDistributionShape [
| possessionTimes numberOfBuckets canvas chart plot lb |

possessionTimes := self possessionTimes.
numberOfBuckets := (possessionTimes max/500) ceiling.
canvas := RSCanvas new.
chart := RSChart new.
chart container: canvas.
plot := RSHistogramPlot new
	x: possessionTimes;
	bins: numberOfBuckets.
chart addPlot: plot.
chart addDecoration: (RSVerticalTick new
	labelConversion: [ :value | value asInteger asString ];
	yourself).
chart addDecoration: (RSHorizontalTick new
	numberOfTicks: numberOfBuckets/2;
	labelConversion: [ :value | (value/1000) rounded asDuration humanAbbreviatedReadablePrintString ]
	yourself).		
chart title: self printRod,' possession time'. 
chart addDecoration: (RSYLabelDecoration new title: 'Number of controlled possessions').
chart addDecoration: (RSXLabelDecoration new title: self printRod,' possession time').
chart build.

lb := RSLegend new.
lb container: canvas.
lb text: 'Total ',self printRod,' controlled possessions = ',possessionTimes size asString.
lb legendDo: [ :l | l withBorder; padding: 2 ].
lb location below offset: 0@8.
lb build.

^canvas shapes asShapeFor: numberOfBuckets.

]

{ #category : #access }
SpPresenterMetaPossessionTimeSuccess >> possessionTimes [
^self possessionTimesAndSuccess collect: [ :e | e key ]
]

{ #category : #accessing }
SpPresenterMetaPossessionTimeSuccess >> possessionTimesAndSuccess [

	^ possessionTimesAndSuccess
]

{ #category : #accessing }
SpPresenterMetaPossessionTimeSuccess >> possessionTimesAndSuccess: anObject [

	possessionTimesAndSuccess := anObject
]

{ #category : #trawling }
SpPresenterMetaPossessionTimeSuccess >> possessionTimesAndSuccessForMatchState: aMatchState [
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

{ #category : #access }
SpPresenterMetaPossessionTimeSuccess >> possessions [
^self possessionTimesAndSuccess size
]

{ #category : #access }
SpPresenterMetaPossessionTimeSuccess >> printRod [ 
^self statisticClass new rods first asString,'-rod'
]

{ #category : #access }
SpPresenterMetaPossessionTimeSuccess >> statisticClass [
^self subclassResponsibility  
]

{ #category : #access }
SpPresenterMetaPossessionTimeSuccess >> successes [
^(self possessionTimesAndSuccess collect:[ :e |e value]) sum
]

{ #category : #trawling }
SpPresenterMetaPossessionTimeSuccess >> trawl [
"Trawl and capture the meta data"

self possessionTimesAndSuccess: self trawlForSuccess
]

{ #category : #trawling }
SpPresenterMetaPossessionTimeSuccess >> trawlForSuccess [
| possessionTimeAndSuccess |

possessionTimeAndSuccess := SortedCollection new.
MatchStateEnumerator new allCompletedStandardMatchesDo: [ :eachMatchState |
	possessionTimeAndSuccess addAll: (self possessionTimesAndSuccessForMatchState: eachMatchState) ].
^possessionTimeAndSuccess asArray
]
