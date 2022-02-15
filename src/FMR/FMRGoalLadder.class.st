Class {
	#name : #FMRGoalLadder,
	#superclass : #FMRObject,
	#instVars : [
		'matchState',
		'gameDisplacementX'
	],
	#category : #FMR
}

{ #category : #tuning }
FMRGoalLadder >> boxSize [
^20@20
]

{ #category : #tuning }
FMRGoalLadder >> boxTextFontSize [
^10
]

{ #category : #UI }
FMRGoalLadder >> createCanvas [

^self drawOnCanvas: RSCanvas new
]

{ #category : #drawing }
FMRGoalLadder >> createShapes [
| boxes |

boxes := OrderedCollection new.
1 to: self matchState numberOfGames do: [ :gameNumber | | goals |
	goals := self matchState matchplayEvents select:[ :e | e isGoal & (e gameNumber = gameNumber) ].
	1 to: goals size do: [ :level |
		1 to: level do: [ :n | | goal labeled popup box |
			goal := goals at: n.
			labeled := RSLabeled new fontSize: self boxTextFontSize.
			labeled location middle.
			labeled shapeBuilder textBlock: [ :g | self printScoreForGoal: g if: level = n ].
			popup := RSPopup text: [ :g | g matchProgressSummary ].
			box := RSBox new
				model: goal;
				size: self boxSize;
				position: (self positionOfBoxForGoal: goal atLevel: level);
				color: goal sideWithPossession colour;
				border: (RSBorder new width: 1);
				@ labeled;
				@ popup;
				yourself.
			box when: RSMouseClick do: self mouseClickBlock.
			boxes add: box ]]].
^boxes
]

{ #category : #drawing }
FMRGoalLadder >> drawOnCanvas: aCanvas [

aCanvas addAll: self createShapes asGroup.
aCanvas @ RSCanvasController.
^aCanvas   
]

{ #category : #accessing }
FMRGoalLadder >> gameDisplacementX [

	^ gameDisplacementX
]

{ #category : #accessing }
FMRGoalLadder >> gameDisplacementX: anObject [

	gameDisplacementX := anObject
]

{ #category : #access }
FMRGoalLadder >> goalsScoredInPreviousGames: aGoal [
^(aGoal matchState matchplayEvents select: [ :e | e isGoal & (e gameNumber < aGoal gameNumber) ]) size
]

{ #category : #initialization }
FMRGoalLadder >> initialize [ 
self gameDisplacementX: 0
]

{ #category : #accessing }
FMRGoalLadder >> matchState [

	^ matchState
]

{ #category : #accessing }
FMRGoalLadder >> matchState: anObject [

	matchState := anObject
]

{ #category : #tuning }
FMRGoalLadder >> mouseClickBlock [
"Open the owning match state UI and highlight the matchplay event underlying the clicked shape"

^[ :event | event shape model matchState open highlightMatchplayEvent: event shape model ]
]

{ #category : #UI }
FMRGoalLadder >> open [
^self createCanvas openWithTitle: self title
]

{ #category : #access }
FMRGoalLadder >> positionOfBoxForGoal: aGoal atLevel: level [
| gameDisplacement teamNumber sign gameScore xOffset symmetryShift position |

gameDisplacement := self gameDisplacementX @ (self goalsScoredInPreviousGames: aGoal) * self boxSize y.
teamNumber := aGoal teamWithOwnershipIndex.
sign := #(-1 1) at: teamNumber.
gameScore := aGoal score currentGameScore.
xOffset := gameScore pointScore at: teamNumber.
symmetryShift := (teamNumber - 1) * self boxSize x.
position := (self boxSize x * xOffset * sign - symmetryShift + gameDisplacement x) @ (self boxSize y * (level - 1) + gameDisplacement y).
^position
]

{ #category : #drawing }
FMRGoalLadder >> printScoreForGoal: aGoal if: aBoolean [
^aBoolean
	ifTrue: [ aGoal score currentGameScore printPointScore ]
	ifFalse: [ '' ]
]

{ #category : #UI }
FMRGoalLadder >> title [
^'FMR Goal Ladder - ',self matchState matchDescriptionWithTeamName,' - ',self matchState matchStatusSummary
]
