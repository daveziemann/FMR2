Class {
	#name : #SpPresenterMetaPossessionPassingSuccess,
	#superclass : #SpPresenterMetaPossessionTimeSuccess,
	#category : #FMR
}

{ #category : #drawing }
SpPresenterMetaPossessionPassingSuccess >> createChartShape [
| chart lb |

chart := self createChart.
chart title: '5-rod passing success'.
chart addDecoration: (RSYLabelDecoration new title: '5-rod pass success rate').
chart addDecoration: (RSXLabelDecoration new title: '5-rod possession time').
chart build.

lb := RSLegend new.
lb container: chart canvas.
lb text: self successes asString,' passes from ',self possessions asString,' possessions = ',(100.0 * self successes / self possessions) rounded asString,'%'.
lb legendDo: [ :l | l withBorder; padding: 2 ].
lb location below offset: 0@8.
lb build.

^chart canvas asShape
]

{ #category : #access }
SpPresenterMetaPossessionPassingSuccess >> maxValue [
^50
]

{ #category : #access }
SpPresenterMetaPossessionPassingSuccess >> minValue [
^30
]

{ #category : #access }
SpPresenterMetaPossessionPassingSuccess >> statisticClass [
^PSPassingSuccess5To3
]
