Class {
	#name : #SpPresenterMetaPossessionScoringSuccess,
	#superclass : #SpPresenterMetaPossessionTimeSuccess,
	#category : #FMR
}

{ #category : #drawing }
SpPresenterMetaPossessionScoringSuccess >> createChartShape [
| chart lb |

chart := self createChart.
chart title: '3-rod conversion rate'.
chart addDecoration: (RSYLabelDecoration new title: '3-rod conversion rate').
chart addDecoration: (RSXLabelDecoration new title: '3-rod possession time').
chart build.

lb := RSLegend new.
lb container: chart canvas.
lb text: self successes asString,' goals from ',self possessions asString,' controlled possessions = ',(100.0 * self successes / self possessions) rounded asString,'%'.
lb legendDo: [ :l | l withBorder; padding: 2 ].
lb location below offset: 0@8.
lb build.

^chart canvas asShape
]

{ #category : #access }
SpPresenterMetaPossessionScoringSuccess >> maxValue [
^50
]

{ #category : #access }
SpPresenterMetaPossessionScoringSuccess >> minValue [
^30
]

{ #category : #access }
SpPresenterMetaPossessionScoringSuccess >> statisticClass [
^PSScoringFrom3Rod
]
