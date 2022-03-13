Class {
	#name : #SpPresenterPossessionScoringCorrelation,
	#superclass : #'SpPresenterFMR_',
	#instVars : [
		'success',
		'fail'
	],
	#category : #FMR
}

{ #category : #drawing }
SpPresenterPossessionScoringCorrelation >> bucket: data [
| m |
m := (data / (self maxValue / self numberOfBuckets)) ceiling.
^(1 to: self numberOfBuckets) collect:[:e| m occurrencesOf: e ]
]

{ #category : #drawing }
SpPresenterPossessionScoringCorrelation >> code [
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
SpPresenterPossessionScoringCorrelation >> createChartForScoring [
| chart lp1 popup data plot minValue vertical horizontal goals possessions t |

self success: self trawlForScoring.
data := Array new: self success last key withAll: #(0 0).
self success do: [ :e | data at: e key put: (data at: e key) + {1.e value} ].
data doWithIndex: [ :e :i |	i=1 ifFalse: [ data at: i put: (data at: i)+(data at: i-1) ]].
minValue := 30.
plot := data collect: [ :e | ((100.0 * (e second divideBy: e first)) round: 1) max: minValue ].

chart := RSChart new.
lp1 := RSLinePlot new x: (1 to: plot size) y: plot; color: Color red.

popup := RSPopupDecoration new.
popup chartPopupBuilder for: lp1 text: 'Conversion rate at this time' color: #red.

chart addPlot: lp1; addDecoration: popup.

chart minValueY: minValue; maxValueY: 45.
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
chart addDecoration: (RSYLabelDecoration new title: '3-rod conversion rate'; fontSize: 10).
chart addDecoration: (RSXLabelDecoration new title: '3-rod possession time'; fontSize: 10).
goals := (self success collect:[ :e |e value])sum.
possessions := self success size.
t := goals asString,' goals from ',possessions asString,' controlled possessions (',(100.0*goals/possessions) rounded asString,'%)'.
chart addDecoration: (RSChartTitleDecoration new fontSize: 10; title: t).
chart build.

^chart
]

{ #category : #drawing }
SpPresenterPossessionScoringCorrelation >> drawOnCanvas: aCanvas charts: charts [
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

{ #category : #accessing }
SpPresenterPossessionScoringCorrelation >> fail [

	^ fail
]

{ #category : #accessing }
SpPresenterPossessionScoringCorrelation >> fail: anObject [

	fail := anObject
]

{ #category : #initialization }
SpPresenterPossessionScoringCorrelation >> initializePresenters [
| charts rp |

charts := OrderedCollection new
	add: self createChartForScoring;
	yourself.

rp := self instantiate: SpRoassalPresenter.
rp script: [ :canvas | self drawOnCanvas: canvas charts: charts ].

self layout: (SpBoxLayout newLeftToRight hAlignStart
	add: rp withConstraints: [ :c | c width: 1800 ];
	yourself)

]

{ #category : #drawing }
SpPresenterPossessionScoringCorrelation >> maxValue [
^self success max max: self fail max
]

{ #category : #drawing }
SpPresenterPossessionScoringCorrelation >> numberOfBuckets [
^200
]

{ #category : #accessing }
SpPresenterPossessionScoringCorrelation >> success [

	^ success
]

{ #category : #accessing }
SpPresenterPossessionScoringCorrelation >> success: anObject [

	success := anObject
]

{ #category : #drawing }
SpPresenterPossessionScoringCorrelation >> trawlForScoring [
| durationsAndSuccessFlag r c d |

durationsAndSuccessFlag := SortedCollection new.
MatchStateEnumerator new allCompletedStandardMatchesDo: [ :eachMatchState |
	| sg ps s |
	sg := eachMatchState statisticsGenerator generate.
	ps := sg at: PSScoringFrom3Rod.
	s := ps scanner.
	c := ps sequences collect: [ :eachSequence |
		r := (s sequence: eachSequence) scanScalar scalarSequence.
		r collect: [ :e | e key durationOrZero -> e value notNil asBit ]].
	d := (c collect: [ :ec | ec collect:[:e | e value ]]) sum.
	r := c first with: d collect: [ :a :b | a key -> b ].
	r do: [ :e | durationsAndSuccessFlag add: e key -> e value ]].
^durationsAndSuccessFlag asArray
]
