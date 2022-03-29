Class {
	#name : #SpPresenterMetaPossessionScoring2Success,
	#superclass : #SpPresenterMetaPossessionTimeSuccess,
	#category : #FMR
}

{ #category : #drawing }
SpPresenterMetaPossessionScoring2Success >> createChartShape [
| chart lb |

chart := self createChart.
chart title: self printRod,' scoring rate'.
chart addDecoration: (RSYLabelDecoration new title: self printRod,' scoring rate').
chart addDecoration: (RSXLabelDecoration new title: self printRod,' possession time').
chart build.

lb := RSLegend new.
lb container: chart canvas.
lb text: self successes asString,' goals from ',self possessions asString,' controlled possessions = ',(100.0 * self successes / self possessions) rounded asString,'%'.
lb legendDo: [ :l | l withBorder; padding: 2 ].
lb location below offset: 0@11.
lb build.

^chart canvas asShape
]

{ #category : #access }
SpPresenterMetaPossessionScoring2Success >> maxValueY [
^10
]

{ #category : #access }
SpPresenterMetaPossessionScoring2Success >> minValueY [
^0
]

{ #category : #access }
SpPresenterMetaPossessionScoring2Success >> statisticClass [
^PSScoringFrom2Rod
]
