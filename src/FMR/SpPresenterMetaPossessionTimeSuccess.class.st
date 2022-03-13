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
^self subclassResponsibility  
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
