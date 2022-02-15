Class {
	#name : #PSMorphTreeNodeModel,
	#superclass : #MorphTreeNodeModel,
	#instVars : [
		'bodyFont'
	],
	#category : #FMR
}

{ #category : #access }
PSMorphTreeNodeModel >> awardName [
^TextMorph new
	contents: self statistic awardName;
	font: self bodyFont;
	setBalloonText: nil
]

{ #category : #accessing }
PSMorphTreeNodeModel >> bodyFont [
^bodyFont ifNil: [ self bodyFontDefault ]
]

{ #category : #accessing }
PSMorphTreeNodeModel >> bodyFont: anObject [

	bodyFont := anObject
]

{ #category : #access }
PSMorphTreeNodeModel >> bodyFontDefault [
^LogicalFont familyName: 'Source Sans Pro' pointSize: 16.
]

{ #category : #access }
PSMorphTreeNodeModel >> descriptionForTeamNumber [
^self teamNumber in: [ :tn |
	tn isZero
		ifTrue: [ 'Both' ]
		ifFalse: [ 'Team ',tn asString,': ',(self matchState teams at: tn) teamName ]]

]

{ #category : #access }
PSMorphTreeNodeModel >> matchDescription [
^TextMorph new
	contents: self matchState matchDescriptionWithoutTeamName;
	font: self bodyFont;
	setBalloonText: nil
]

{ #category : #access }
PSMorphTreeNodeModel >> matchState [
^self statistic matchState
]

{ #category : #events }
PSMorphTreeNodeModel >> mouseDown: event [
self model mouseDown: self item
]

{ #category : #access }
PSMorphTreeNodeModel >> resultForTeam: eachTeamNumber inGame: eachGameNumber [
self statistic teamNumber: eachTeamNumber; gameNumber: eachGameNumber.

^TextMorph new
	contents: self statistic displayResultForTeamAndGame;
	font: self bodyFont;
	color: self statistic getColour;
	setBalloonText: self statistic statisticBalloonTexts;
	backgroundColor: self statistic getBackgroundColour;
	yourself

]

{ #category : #access }
PSMorphTreeNodeModel >> resultForTeamInGame: eachGameNumber [
^self resultForTeam: self teamNumber inGame: eachGameNumber
]

{ #category : #access }
PSMorphTreeNodeModel >> resultWithDeltaForTeam: eachTeamNumber inGame: eachGameNumber [
self statistic teamNumber: eachTeamNumber; gameNumber: eachGameNumber.

^TextMorph new
	contents: self statistic displayResultForWithDeltaTeamAndGame;
	font: self bodyFont;
	color: self statistic getColour;
	setBalloonText: self statistic statisticBalloonTexts;
	backgroundColor: self statistic getBackgroundColour;
	yourself
]

{ #category : #access }
PSMorphTreeNodeModel >> statistic [
^self item
]

{ #category : #access }
PSMorphTreeNodeModel >> statisticCategory [
^TextMorph new
	contents: self statistic statisticCategory;
	font: self bodyFont;
	setBalloonText: self statistic statisticCategoryBalloonText
]

{ #category : #access }
PSMorphTreeNodeModel >> statisticGroup [
^TextMorph new
	contents: self statistic statisticGroup;
	font: self bodyFont;
	setBalloonText: self statistic statisticGroupBalloonText
]

{ #category : #access }
PSMorphTreeNodeModel >> statisticName [
^TextMorph new
	contents: self statistic statisticName;
	font: self bodyFont;
	setBalloonText: self statistic statisticNameBalloonTextWithTechnical
]

{ #category : #access }
PSMorphTreeNodeModel >> teamID [
^TextMorph new
	contents: self descriptionForTeamNumber;
	font: self bodyFont;
	color: (self matchState colourForTeam: self teamNumber inGame: 0);
	setBalloonText: self statistic teamIDBalloonText
]

{ #category : #access }
PSMorphTreeNodeModel >> teamNumber [
^self item teamNumber
]
