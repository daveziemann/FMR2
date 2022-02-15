Class {
	#name : #PSMorphTreeModelAwards,
	#superclass : #'PSMorphTreeModel_',
	#category : #FMR
}

{ #category : #building }
PSMorphTreeModelAwards >> buildColumnsDynamic [
^{}
]

{ #category : #building }
PSMorphTreeModelAwards >> buildColumnsLeadingStatic [
^OrderedCollection new
	add: (MorphTreeColumn new
		startWidth: 100;
		rowMorphGetSelector: #statisticGroup;
		headerButtonLabel: 'Level' font: nil);
	add: (MorphTreeColumn new
		startWidth: 100;
		rowMorphGetSelector: #statisticCategory;
		headerButtonLabel: 'Category' font: nil);
	add: (MorphTreeColumn new
		startWidth: 100;
		rowMorphGetSelector: #awardName;
		headerButtonLabel: 'Award' font: nil);
	add: self buildMatchStatisticColumn;
	add: (MorphTreeColumn new
		startWidth: 100;
		rowMorphGetSelector: #teamID;
		headerButtonLabel: 'Team' font: nil);
	add: (MorphTreeColumn new
		startWidth: 100;
		rowMorphGetSelector: #matchDescription;
		headerButtonLabel: 'Match Description' font: nil);
	yourself
		
]

{ #category : #building }
PSMorphTreeModelAwards >> buildMatchStatisticColumn [
| winningTeam mtc colour |

winningTeam := self matchState teamThatWonGame: 0.
mtc := MorphTreeColumn new
	startWidth: 100;
	rowMorphGetSelector: [ :node | node resultForTeamInGame: 0 ];
	headerButtonLabel: 'Match' font: nil.
mtc header borderWidth: 2.
colour := self matchState colourForTeam: winningTeam inGame: 0.
mtc header borderColor: colour.
^mtc
]

{ #category : #UI }
PSMorphTreeModelAwards >> mouseDown: aPresentableStatistic [
aPresentableStatistic matchState open
]

{ #category : #building }
PSMorphTreeModelAwards >> rootItems [
^rootItems ifNil: [ rootItems := self statisticsByGroups ]
]

{ #category : #building }
PSMorphTreeModelAwards >> statisticsByGroups [
^self statisticsGenerator teamStatistics
	inject: self statisticsGenerator matchStatistics copy
	into: [ :c :e | 
		c
			add: (e teamNumber: e bestTeam);
			yourself ]
]
