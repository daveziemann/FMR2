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

{ #category : #access }
PSMorphTreeNodeModelWinCorrelate >> correlationLose [
^TextMorph new
	contents: self item fourth asString,'%';
	font: self bodyFont;
	setBalloonText: 'How often out of all the recorded matches does the losing team have the higher value than the winning team, for this statistic? Expressed as a % of the total number of recorded matches, a high % (>70%) implies that having the higher statistic value correlates well with losing, while a low % (<30%) implies that having the higher statistic value correlates well with winning.'
]

{ #category : #access }
PSMorphTreeNodeModelWinCorrelate >> correlationWin [
^TextMorph new
	contents: self item second asString,'%';
	font: self bodyFont;
	setBalloonText: 'How often out of all the recorded matches does the winning team have the higher value than the losing team, for this statistic? Expressed as a % of the total number of recorded matches, a high % (>70%) implies that having the higher statistic value correlates well with winning, while a low % (<30%) implies that having the higher statistic value correlates well with losing.'
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

{ #category : #access }
PSMorphTreeNodeModelWinCorrelate >> statisticNameLose [
^TextMorph new
	contents: self item third new statisticName;
	font: self bodyFont;
	setBalloonText: self item third new statisticNameBalloonText
]

{ #category : #access }
PSMorphTreeNodeModelWinCorrelate >> statisticNameWin [
^TextMorph new
	contents: self item first new statisticName;
	font: self bodyFont;
	setBalloonText: self item first new statisticNameBalloonText
]
