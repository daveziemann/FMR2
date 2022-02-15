Class {
	#name : #'PSBlockingAndStealing_',
	#superclass : #'PresentableTeamStatistic_',
	#category : #FMR
}

{ #category : #UI }
PSBlockingAndStealing_ >> displayResult: aTeamResult [
"Override me"

^aTeamResult printAsRatioAndPercentage
]

{ #category : #generation }
PSBlockingAndStealing_ >> extractScannerResult [

^self scanner firstAndLastSequenceSize
]

{ #category : #generation }
PSBlockingAndStealing_ >> shouldReverseTeamResults [
"Some statistics are computed from the perspective of the other team, in which case the order of the reults must be reversed"

^true
]

{ #category : #UI }
PSBlockingAndStealing_ >> statisticBalloonMacro [
^'In <g> <tt> stole the ball <s2> times on their <r2> following <s1> controlled possessions on <ot>''s <r1>, for a block and steal rate of <%d>.'
]

{ #category : #UI }
PSBlockingAndStealing_ >> statisticCategory [ 
^'Block and Steal'
]

{ #category : #UI }
PSBlockingAndStealing_ >> statisticCategoryBalloonText [
^'How good is the team at blocking and then stealing the ball from the opposition? This is computed by looking for a controlled possession on the opposing team''s rod followed by a controlled possession on the adjacent stealing rod.'
]

{ #category : #UI }
PSBlockingAndStealing_ >> statisticNameBalloonText [
^self expandMacros: 'How successful is the team at blocking and stealing the ball onto their <r2>? This is computed from the number of controlled possessions on the stealing <r2> that resulted directly from a transition following a controlled possession on the other team''s adjacent <r1>.' 
]
