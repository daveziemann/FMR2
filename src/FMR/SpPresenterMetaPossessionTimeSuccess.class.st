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
^self subclassResponsibility  
]

{ #category : #drawing }
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
	add: self createChart container asShape;
	yourself.

rp := self instantiate: SpRoassalPresenter.
rp script: [ :canvas | self drawOnCanvas: canvas shapes: shapes ].

self layout: (SpBoxLayout newLeftToRight hAlignStart
	add: rp withConstraints: [ :c | c width: 1800 ];
	yourself)

]

{ #category : #drawing }
SpPresenterMetaPossessionTimeSuccess >> maxValue [
^self subclassResponsibility  
]

{ #category : #drawing }
SpPresenterMetaPossessionTimeSuccess >> minValue [
^self subclassResponsibility  
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
SpPresenterMetaPossessionTimeSuccess >> possessionTimeDistributionShape [
| possessionTimes numberOfBuckets group chart plot |

possessionTimes := self possessionTimes.
numberOfBuckets := (possessionTimes max/500) ceiling.
group := RSGroup new.
chart := RSChart new.
chart container: group.
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
chart title: self printRod,' possession time distribution'. 
chart addDecoration: (RSYLabelDecoration new title: 'Number of possessions').
chart build.
^group asShapeFor: numberOfBuckets.

]

{ #category : #drawing }
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

{ #category : #drawing }
SpPresenterMetaPossessionTimeSuccess >> printRod [ 
^self statisticClass new rods first asString,'-rod'
]

{ #category : #drawing }
SpPresenterMetaPossessionTimeSuccess >> statisticClass [
^self subclassResponsibility  
]

{ #category : #drawing }
SpPresenterMetaPossessionTimeSuccess >> trawl [
"Trawl and capture the meta data"

self possessionTimesAndSuccess: self trawlForSuccess
]

{ #category : #drawing }
SpPresenterMetaPossessionTimeSuccess >> trawlForSuccess [
| possessionTimeAndSuccess |

possessionTimeAndSuccess := SortedCollection new.
MatchStateEnumerator new allCompletedStandardMatchesDo: [ :eachMatchState |
	possessionTimeAndSuccess addAll: (self possessionTimeAndSuccess: eachMatchState) ].
^possessionTimeAndSuccess asArray
]
