Class {
	#name : #SpPresenterMetaPossessionPassing53Success,
	#superclass : #SpPresenterMetaPossessionTimeSuccess,
	#category : #FMR
}

{ #category : #drawing }
SpPresenterMetaPossessionPassing53Success >> createChartShape [
| chart lb |

chart := self createChart.
chart title: self printRod,' passing success'.
chart addDecoration: (RSYLabelDecoration new title: self printRod,' pass success rate').
chart addDecoration: (RSXLabelDecoration new title: self printRod,' possession time').
chart build.

lb := RSLegend new.
lb container: chart canvas.
lb text: self successes asString,' passes from ',self possessions asString,' controlled possessions = ',(100.0 * self successes / self possessions) rounded asString,'%'.
lb legendDo: [ :l | l withBorder; padding: 2 ].
lb location below offset: 0@11.
lb build.

^chart canvas asShape
]

{ #category : #access }
SpPresenterMetaPossessionPassing53Success >> maxValue [
^50
]

{ #category : #access }
SpPresenterMetaPossessionPassing53Success >> minValue [
^30
]

{ #category : #access }
SpPresenterMetaPossessionPassing53Success >> statisticClass [
^PSPassingSuccess5To3
]
