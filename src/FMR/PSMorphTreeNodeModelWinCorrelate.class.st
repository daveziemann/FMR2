Class {
	#name : #PSMorphTreeNodeModelWinCorrelate,
	#superclass : #MorphTreeNodeModel,
	#instVars : [
		'bodyFont'
	],
	#category : #FMR
}

{ #category : #accessing }
PSMorphTreeNodeModelWinCorrelate >> bodyFont [
^bodyFont ifNil: [ self bodyFontDefault ]
]

{ #category : #accessing }
PSMorphTreeNodeModelWinCorrelate >> bodyFont: anObject [

	bodyFont := anObject
]

{ #category : #access }
PSMorphTreeNodeModelWinCorrelate >> bodyFontDefault [
^LogicalFont familyName: 'Source Sans Pro' pointSize: 14.
]

{ #category : #access }
PSMorphTreeNodeModelWinCorrelate >> correlation [
^TextMorph new
	contents: self item value asString,'%';
	font: self bodyFont;
	setBalloonText: 'How often out of all the recorded matches does the winning team have the higher value than the losing team, for this statistic? Expressed as a % of the total number of recorded matches, a high % (>60%) implies that having the higher statistic value correlates well with winning, while a low % (<40%) implies that having the higher statistic value correlates well with losing.'
]

{ #category : #events }
PSMorphTreeNodeModelWinCorrelate >> mouseDown: event [
self model mouseDown: self item
]

{ #category : #access }
PSMorphTreeNodeModelWinCorrelate >> statisticName [
^TextMorph new
	contents: self item key new statisticName;
	font: self bodyFont;
	setBalloonText: self item key new statisticNameBalloonText
]
