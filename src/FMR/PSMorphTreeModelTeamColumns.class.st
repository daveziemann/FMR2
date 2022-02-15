Class {
	#name : #PSMorphTreeModelTeamColumns,
	#superclass : #'PSMorphTreeModel_',
	#category : #FMR
}

{ #category : #building }
PSMorphTreeModelTeamColumns >> buildColumnsDynamic [
| headerFont columns gameOrMatch heading |
headerFont := self headerFont.
columns :=  OrderedCollection new.
self gameNumbers do: [ :eachGameNumber | | winningTeam |
	winningTeam := self matchState teamThatWonGame: eachGameNumber.
	gameOrMatch := eachGameNumber isZero ifTrue: [ 'Match' ] ifFalse: [ 'Game ', eachGameNumber asString ].
	#(1 2) do: [ :eachTeamNumber | | mtc |
		heading := gameOrMatch,' Team ',eachTeamNumber asString.
		mtc := MorphTreeColumn new
			startWidth: 100;
			rowMorphGetSelector: [ :node | node resultForTeam: eachTeamNumber inGame: eachGameNumber ];
			headerButtonLabel: heading font: headerFont.
		mtc header borderWidth: 2.
		eachTeamNumber = winningTeam ifTrue: [ | colour |
			colour := self matchState colourForTeam: eachTeamNumber inGame: eachGameNumber.
			mtc header borderColor: colour ].
		columns add: mtc ]].
^columns
]

{ #category : #building }
PSMorphTreeModelTeamColumns >> buildColumnsLeadingStatic [
^OrderedCollection new
	add: (MorphTreeColumn new
		startWidth: 100;
		rowMorphGetSelector: #statisticCategory;
		headerButtonLabel: 'Category' font: nil);
	add: (MorphTreeColumn new
		startWidth: 100;
		rowMorphGetSelector: #statisticName;
		headerButtonLabel: 'Statistic' font: nil);
	yourself
		
]

{ #category : #building }
PSMorphTreeModelTeamColumns >> rootItems [
^rootItems ifNil: [ rootItems := self statisticsGenerator teamStatistics ]
]
