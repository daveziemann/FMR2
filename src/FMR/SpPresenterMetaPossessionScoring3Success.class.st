Class {
	#name : #SpPresenterMetaPossessionScoring3Success,
	#superclass : #SpPresenterMetaPossessionTimeSuccess,
	#category : #FMR
}

{ #category : #drawing }
SpPresenterMetaPossessionScoring3Success >> createChartShape [
| chart lb |

chart := self createChart.
chart title: self printRod,' conversion rate'.
chart addDecoration: (RSYLabelDecoration new title: self printRod,' conversion rate').
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
SpPresenterMetaPossessionScoring3Success >> maxValue [
^50
]

{ #category : #access }
SpPresenterMetaPossessionScoring3Success >> minValue [
^30
]

{ #category : #access }
SpPresenterMetaPossessionScoring3Success >> statisticClass [
^PSScoringFrom3Rod
]
