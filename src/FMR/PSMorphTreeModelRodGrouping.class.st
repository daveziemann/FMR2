Class {
	#name : #PSMorphTreeModelRodGrouping,
	#superclass : #'PSMorphTreeModel_',
	#category : #FMR
}

{ #category : #building }
PSMorphTreeModelRodGrouping >> buildColumnsDynamic [
| headerFont |

headerFont := self headerFont.
^self gameNumbers collect: [ :eachGameNumber |
	| winningTeam heading mtc colour |
	winningTeam := self matchState teamThatWonGame: eachGameNumber.
	heading := self matchState printHeadingForGame: eachGameNumber.
	mtc := MorphTreeColumn new
		startWidth: 100;
		rowMorphGetSelector: [ :node | node resultForTeamInGame: eachGameNumber ];
		headerButtonLabel: heading font: headerFont.
	mtc header borderWidth: 2.
	colour := self matchState colourForTeam: winningTeam inGame: eachGameNumber.
	mtc header borderColor: colour.
	mtc ]
]

{ #category : #building }
PSMorphTreeModelRodGrouping >> buildColumnsLeadingStatic [
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
		rowMorphGetSelector: #statisticName;
		headerButtonLabel: 'Statistic' font: nil);
	add: (MorphTreeColumn new
		startWidth: 100;
		rowMorphGetSelector: #teamID;
		headerButtonLabel: 'Team' font: nil);
	yourself
		
]

{ #category : #building }
PSMorphTreeModelRodGrouping >> rootItems [
^rootItems ifNil: [ rootItems := self statisticsByGroups ]
]

{ #category : #building }
PSMorphTreeModelRodGrouping >> statisticsByGroups [
^self statisticsGenerator sortByCategory teamStatistics
	inject: self statisticsGenerator matchStatistics copy
	into: [ :c :e | 
		c
			add: (e teamNumber: 1);
			add: (e copy teamNumber: 2);
			yourself ]
]
