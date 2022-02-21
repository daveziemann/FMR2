Class {
	#name : #PSMorphTreeModelTransitionTable,
	#superclass : #'PSMorphTreeModel_',
	#instVars : [
		'transitionTableGenerator'
	],
	#category : #FMR
}

{ #category : #building }
PSMorphTreeModelTransitionTable >> buildColumnsDynamic [

self generate. 
^self toRods collect: [ :eachToRod |
	| mtc |
	mtc := MorphTreeColumn new
		startWidth: 100;
		rowMorphGetSelector: [ :node | node toRodMorph: eachToRod ];
		headerButtonLabel: (self printPseudoRod: eachToRod) font: self headerFont.
	mtc header
		"color: (self matchState colourForTeam: eachToRod key inGame: 0);"
		borderWidth: 2;
		borderColor: nil.
	mtc ]
]

{ #category : #building }
PSMorphTreeModelTransitionTable >> buildColumnsLeadingStatic [
^OrderedCollection new
	add: (MorphTreeColumn new
		startWidth: 100;
		rowMorphGetSelector: #fromTeamNameMorph;
		headerButtonLabel: 'Team Name' font: self headerFont);
	add: (MorphTreeColumn new
		startWidth: 100;
		rowMorphGetSelector: #fromTeamNumberMorph;
		headerButtonLabel: 'Team No.' font: self headerFont);
	add: (MorphTreeColumn new
		startWidth: 100;
		rowMorphGetSelector: #fromRodMorph;
		headerButtonLabel: 'From rod' font: self headerFont);
	yourself
]

{ #category : #building }
PSMorphTreeModelTransitionTable >> fromRods [
^self transitionTableGenerator transitionTable transitionTable keys
]

{ #category : #building }
PSMorphTreeModelTransitionTable >> generate [
self transitionTableGenerator: (InstanceTransitionTableGenerator new matchState: self matchState) generateTransitionTable
]

{ #category : #UI }
PSMorphTreeModelTransitionTable >> headerFont [
^LogicalFont familyName: 'Source Sans Pro' pointSize: 10
]

{ #category : #building }
PSMorphTreeModelTransitionTable >> matchState [ 
^self statisticsGenerator matchState 
]

{ #category : #UI }
PSMorphTreeModelTransitionTable >> mouseDown: aRod [
self transitionTableGenerator inspect
]

{ #category : #building }
PSMorphTreeModelTransitionTable >> printPseudoRod: aPseudoRod [
^self transitionTable printPseudoRod: aPseudoRod
]

{ #category : #building }
PSMorphTreeModelTransitionTable >> rootItems [
^rootItems ifNil: [ rootItems := self generate; fromRods ]
]

{ #category : #building }
PSMorphTreeModelTransitionTable >> rootNodeClassFromItem: anItem [
^PSMorphTreeNodeModelTransitionTable
]

{ #category : #building }
PSMorphTreeModelTransitionTable >> toRods [
^self transitionTableGenerator transitionTable transitionTable values first keys
]

{ #category : #building }
PSMorphTreeModelTransitionTable >> transitionTable [
^self transitionTableGenerator transitionTable
]

{ #category : #accessing }
PSMorphTreeModelTransitionTable >> transitionTableGenerator [

	^ transitionTableGenerator
]

{ #category : #accessing }
PSMorphTreeModelTransitionTable >> transitionTableGenerator: anObject [

	transitionTableGenerator := anObject
]

{ #category : #building }
PSMorphTreeModelTransitionTable >> transitions [
self transitionTableGenerator: (TransitionTableGenerator new matchState: self matchState).
^self transitionTableGenerator generateTransitionTable transitionTable transitionTable
]
