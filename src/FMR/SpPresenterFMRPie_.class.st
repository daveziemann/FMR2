Class {
	#name : #'SpPresenterFMRPie_',
	#superclass : #'SpPresenterFMR_',
	#instVars : [
		'matchState',
		'statisticCategory',
		'statistics',
		'pies1',
		'pies2'
	],
	#category : #FMR
}

{ #category : #'instance creation' }
SpPresenterFMRPie_ class >> open [
	<script>
	self new openWithSpec extent: 1800@700
]

{ #category : #UI }
SpPresenterFMRPie_ >> animationBounce: pie [
pie shapes doWithIndex: [ :shape :index | | a b |
	a := shape alphaAngle.
	b := shape betaAngle.
	pie canvas animationFrom: { 
		(pie canvas transitionAnimation 
			duration: 2 seconds;
			easing: RSEasingInterpolator bounceOut;
			onStepDo: [ :t |
				shape 
					alphaAngle: a * t;
					betaAngle: b * t ])} ]
]

{ #category : #UI }
SpPresenterFMRPie_ >> animationOutin: pie [
| outin |

outin := pie canvas transitionAnimation
	delay: 0 second;
	easing: RSEasingInterpolator elasticOut;
	onStepDo: [ :t |
		pie shapes do: [ :shape | | p a b att |
			att := shape properties.
			p := att at: #position ifAbsentPut: [ 
				| angle |
				angle := (shape alphaAngle + shape betaAngle)/2 + 180.
				angle := angle degreesToRadians.
				NSScale linear range: {300*(angle cos@angle sin negated). 0@0 } ].
			a := att at: #alpha ifAbsentPut: [ 
				NSScale linear range: { shape alphaAngle + 180. shape alphaAngle } ].
			b := att at: #beta ifAbsentPut: [ 
				NSScale linear from: shape betaAngle + 180; to: shape betaAngle; yourself ].
			shape position: (p scale: t).
			shape alphaAngle: (a scale: t).
			shape betaAngle: (b scale: t).
			 ] ].
pie canvas animationFrom: { outin }
]

{ #category : #UI }
SpPresenterFMRPie_ >> computeExtent [
^self subclassResponsibility 
]

{ #category : #accessing }
SpPresenterFMRPie_ >> matchState [

	^ matchState
]

{ #category : #accessing }
SpPresenterFMRPie_ >> matchState: anObject [

	matchState := anObject
]

{ #category : #UI }
SpPresenterFMRPie_ >> open [
self openWithSpec extent: self computeExtent
]

{ #category : #accessing }
SpPresenterFMRPie_ >> pies1 [

	^ pies1
]

{ #category : #accessing }
SpPresenterFMRPie_ >> pies1: anObject [

	pies1 := anObject
]

{ #category : #accessing }
SpPresenterFMRPie_ >> pies2 [

	^ pies2
]

{ #category : #accessing }
SpPresenterFMRPie_ >> pies2: anObject [

	pies2 := anObject
]

{ #category : #accessing }
SpPresenterFMRPie_ >> statisticCategory [

	^ statisticCategory
]

{ #category : #accessing }
SpPresenterFMRPie_ >> statisticCategory: anObject [

	statisticCategory := anObject
]

{ #category : #accessing }
SpPresenterFMRPie_ >> statistics [

	^ statistics
]

{ #category : #accessing }
SpPresenterFMRPie_ >> statistics: anObject [

	statistics := anObject
]
