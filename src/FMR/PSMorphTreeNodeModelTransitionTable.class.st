Class {
	#name : #PSMorphTreeNodeModelTransitionTable,
	#superclass : #MorphTreeNodeModel,
	#instVars : [
		'bodyFont'
	],
	#category : #FMR
}

{ #category : #access }
PSMorphTreeNodeModelTransitionTable >> balloonTextForTransitionTo: toRod [

^(self transitionTable transitionAtFromRod: self fromRod toRod: toRod) explainText

]

{ #category : #accessing }
PSMorphTreeNodeModelTransitionTable >> bodyFont [
^bodyFont ifNil: [ self bodyFontDefault ]
]

{ #category : #accessing }
PSMorphTreeNodeModelTransitionTable >> bodyFont: anObject [

	bodyFont := anObject
]

{ #category : #access }
PSMorphTreeNodeModelTransitionTable >> bodyFontDefault [
^LogicalFont familyName: 'Source Sans Pro' pointSize: 14
]

{ #category : #access }
PSMorphTreeNodeModelTransitionTable >> colourForFromRodTeam [
^self matchState colourForTeam: self fromRodTeamNumber inGame: 0
]

{ #category : #access }
PSMorphTreeNodeModelTransitionTable >> colourForTeam: toRod [
^self fromRod key = toRod key
	ifTrue: [ self matchState colourForTeam: toRod key inGame: 0 ]
	ifFalse: [ FMRColour neutralColour ]
]

{ #category : #access }
PSMorphTreeNodeModelTransitionTable >> fromRod [
^self item
]

{ #category : #access }
PSMorphTreeNodeModelTransitionTable >> fromRodClass [
^self fromRod value
]

{ #category : #access }
PSMorphTreeNodeModelTransitionTable >> fromRodMorph [
"The text in the first column, the from rod"

^TextMorph new
	contents: self fromRodClass printPseudoRod;
	font: self bodyFont;
	color: self colourForFromRodTeam;
	"backgroundColor: (self model matchState colourForTeam: self fromRod key inGame: 0);"
	setBalloonText: 'The rod that the transition starts from'
]

{ #category : #access }
PSMorphTreeNodeModelTransitionTable >> fromRodTeamNumber [
^self fromRod key
]

{ #category : #access }
PSMorphTreeNodeModelTransitionTable >> fromTeamNameMorph [

^TextMorph new
	contents: (self matchState teams at: self fromRodTeamNumber) teamName;
	font: self bodyFont;
	color: self colourForFromRodTeam;
	setBalloonText: 'Team name owning the rod that the transition starts from'
]

{ #category : #access }
PSMorphTreeNodeModelTransitionTable >> fromTeamNumberMorph [

^TextMorph new
	contents: 'Team ',self fromRodTeamNumber asString;
	font: self bodyFont;
	color: self colourForFromRodTeam;
	setBalloonText: 'Team number owning the rod that the transition starts from'
]

{ #category : #access }
PSMorphTreeNodeModelTransitionTable >> matchState [
^self model transitionTableGenerator matchState 
]

{ #category : #events }
PSMorphTreeNodeModelTransitionTable >> mouseDown: event [
self model mouseDown: self item
]

{ #category : #access }
PSMorphTreeNodeModelTransitionTable >> resultForToRod: toRod [
^(self transitionTable transitionAtFromRod: item toRod: toRod) transitionProbability
]

{ #category : #access }
PSMorphTreeNodeModelTransitionTable >> statisticName [
^TextMorph new
	contents: self item key new statisticName;
	font: self bodyFont;
	setBalloonText: self item key new statisticNameBalloonText
]

{ #category : #access }
PSMorphTreeNodeModelTransitionTable >> toRodMorph: toRod [
| result resultPrinted textColour |

result := self resultForToRod: toRod.
resultPrinted := self fromRod = toRod
	ifTrue: [ '-' ]
	ifFalse: [ result printShowingDecimalPlaces: 2 ].
textColour := self colourForTeam: toRod.
result isZero ifTrue: [ textColour := textColour muchLighter ].

^TextMorph new
	contents: resultPrinted;
	font: self bodyFont;
	color: textColour;
	backgroundColor: Color transparent;	
	setBalloonText: (self balloonTextForTransitionTo: toRod)
]

{ #category : #access }
PSMorphTreeNodeModelTransitionTable >> transitionTable [
^self model transitionTableGenerator transitionTable
]
