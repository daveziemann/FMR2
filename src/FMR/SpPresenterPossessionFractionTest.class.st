Class {
	#name : #SpPresenterPossessionFractionTest,
	#superclass : #'SpPresenterFMR_',
	#category : #FMR
}

{ #category : #drawing }
SpPresenterPossessionFractionTest >> code [
| charts canvas compositeShapes |
charts := (1 to: 4) collect: [ :e |
	| chart lp1 popup |
	chart := RSChart new.
	lp1 := RSLinePlot new
		x: (1 to: 30)
		y: (Array new: 30 withAll: 50);
		color: Color red.
	popup := RSPopupDecoration new.
	popup chartPopupBuilder for: lp1 text: 'Plot 1' color: #red.
	chart addPlot: lp1; addDecoration: popup.
	chart minValueY: 0; maxValueY: 110.
	chart addDecoration: (RSVerticalTick new
		numberOfTicks: 10;
		labelConversion: [ :value | value asString,'%' ];
		yourself).
	chart build.
	chart ].
canvas := RSCanvas new.
compositeShapes := charts collect:[ :eachChart | eachChart container asShape ].
canvas addAll: compositeShapes.
RSGridLayout new lineItemsCount: 2; gapSize: 10; on: compositeShapes.
canvas @ RSCanvasController.
canvas open
]

{ #category : #drawing }
SpPresenterPossessionFractionTest >> createChartForFractionStatistic: n [
| chart lp1 lp2 popup |

chart := RSChart new.

lp1 := RSLinePlot new
	x: (1 to: 30)
	y: (Array new: 30 withAll: 50);
	color: Color red.
lp2 := RSLinePlot new
	x: (1 to: 30)
	y: (Array new: 30 withAll: 70);
	color: Color blue.

popup := RSPopupDecoration new.
popup chartPopupBuilder for: lp1 text: 'Plot 1' color: #red.
popup chartPopupBuilder for: lp2 text: 'Plot 2' color: #blue.

chart addPlot: lp1; addPlot: lp2; addDecoration: popup.

chart minValueY: 0; maxValueY: 110.
chart addDecoration: (RSVerticalTick new
	numberOfTicks: 10;
	labelConversion: [ :value | value asString,'%' ]
	yourself).

chart build.

^chart
]

{ #category : #drawing }
SpPresenterPossessionFractionTest >> drawOnCanvas: aCanvas charts: charts [
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
SpPresenterPossessionFractionTest >> initializePresenters [
| charts rp |

charts := (1 to: 4) collect: [ :e | self createChartForFractionStatistic: e ].

rp := self instantiate: SpRoassalPresenter.
rp script: [ :canvas | self drawOnCanvas: canvas charts: charts ].

self layout: (SpBoxLayout newLeftToRight hAlignStart
	add: rp withConstraints: [ :c | c width: 1800 ];
	yourself)

]
