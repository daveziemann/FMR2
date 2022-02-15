Class {
	#name : #SpPresenterGoalLadderTest,
	#superclass : #FMRTestCase,
	#category : #'FMR-Tests'
}

{ #category : #tests }
SpPresenterGoalLadderTest >> testShapeCreationAndHoverMethod [
(FMRGoalLadder new matchState: self matchState) createShapes
	do: [ :eachShape | eachShape model matchProgressSummary ]
]
