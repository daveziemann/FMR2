Class {
	#name : #'PSBallOffTable_',
	#superclass : #'PresentableTeamStatistic_',
	#category : #FMR
}

{ #category : #UI }
PSBallOffTable_ >> displayResult: aTeamResult [
"Override me"

^aTeamResult printAsNumber
]

{ #category : #generation }
PSBallOffTable_ >> extractScannerResult [

^self scanner lastSequenceSize
]

{ #category : #UI }
PSBallOffTable_ >> statisticBalloonMacro [
^'In <g> <tt> shot the ball off the table <s> times from their <r1>.'
]

{ #category : #UI }
PSBallOffTable_ >> statisticCategory [ 
^'Ball Off Table'
]

{ #category : #UI }
PSBallOffTable_ >> statisticCategoryBalloonText [
^'How many times was the ball shot off the table? FMR detects a ball-off-table event by looking for a controlled possession followed by an uncontrolled possession by the opposing team followed by the ball-off-table event (^) followed by a controlled possession on the opposing team''s 2-rod.'
]

{ #category : #UI }
PSBallOffTable_ >> statisticName [
^self expandMacros: 'Ball off table from <r1>'
]

{ #category : #UI }
PSBallOffTable_ >> statisticNameBalloonText [
^self expandMacros: 'How many times did each team shoot the ball off the table from their <r1>?'
]
