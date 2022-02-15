Class {
	#name : #SpPresenterGoalLadder,
	#superclass : #'SpPresenterFMR_',
	#instVars : [
		'matchState'
	],
	#category : #FMR
}

{ #category : #drawing }
SpPresenterGoalLadder >> colourForTeam: aTeamNumber [
^self matchState colourForTeam: aTeamNumber inGame: 0
]

{ #category : #initialization }
SpPresenterGoalLadder >> initializePresenters [
| rp |
rp := self instantiate: SpRoassalPresenter.
rp script: [ :canvas |
	(FMRGoalLadder new matchState: self matchState) drawOnCanvas: canvas.
	(self legendTeams container: canvas) build.
	canvas add: self shapeForTitle ].
self layout: (SpBoxLayout newLeftToRight hAlignStart
	add: rp withConstraints: [ :c | c width: 1000 ];
	yourself)
]

{ #category : #drawing }
SpPresenterGoalLadder >> legendTeams [
| legend |

legend := RSLegend new.
legend layout horizontal.
legend location above offset: 0@(-20).
legend text: self matchState teamOne teamName withBoxColor: (self colourForTeam: 1).
legend text: self matchState teamTwo teamName withBoxColor: (self colourForTeam: 2).
^legend
]

{ #category : #accessing }
SpPresenterGoalLadder >> matchState [

	^ matchState
]

{ #category : #accessing }
SpPresenterGoalLadder >> matchState: anObject [

	matchState := anObject
]

{ #category : #drawing }
SpPresenterGoalLadder >> shapeForTitle [
^RSLabel new
	text: 'Goal Ladder for match where ',self matchState matchProgressSummary;
	fontSize: 12;
	translateTo: 0@(-80);
	yourself
]
