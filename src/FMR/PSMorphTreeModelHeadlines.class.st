Class {
	#name : #PSMorphTreeModelHeadlines,
	#superclass : #'PSMorphTreeModel_',
	#category : #FMR
}

{ #category : #UI }
PSMorphTreeModelHeadlines >> bodyFontDefault [
^LogicalFont familyName: 'Source Sans Pro' pointSize: 24
]

{ #category : #building }
PSMorphTreeModelHeadlines >> buildColumnsDynamic [
| headerFont columns gameOrMatch heading |
headerFont := self headerFont.
columns :=  OrderedCollection new.
self gameNumbers do: [ :eachGameNumber | | winningTeam |
	winningTeam := self matchState teamThatWonGame: eachGameNumber.
	gameOrMatch := eachGameNumber isZero ifTrue: [ 'Match' ] ifFalse: [ 'Game ', eachGameNumber asString ].
	#(1 2) do: [ :eachTeamNumber | | mtc |
		"heading := gameOrMatch,' Team ',eachTeamNumber asString."
		heading := (self matchState teams at: eachTeamNumber) teamName.
		mtc := MorphTreeColumn new
			startWidth: 100;
			rowMorphGetSelector: [ :node |
				node bodyFont: self bodyFont.
				node resultWithDeltaForTeam: eachTeamNumber inGame: eachGameNumber ];
			headerButtonLabel: heading font: headerFont.
		mtc header borderWidth: 2.
		eachTeamNumber = winningTeam ifTrue: [ | colour |
			colour := self matchState colourForTeam: eachTeamNumber inGame: eachGameNumber.
			mtc header borderColor: colour ].
		columns add: mtc ]].
^columns
]

{ #category : #building }
PSMorphTreeModelHeadlines >> buildColumnsLeadingStatic [
^OrderedCollection new
	"add: (MorphTreeColumn new
		startWidth: 100;
		rowMorphGetSelector: #statisticCategory;
		headerButtonLabel: 'Category' font: nil);"
	add: (MorphTreeColumn new
		startWidth: 100;
		"rowMorphGetSelector: #statisticName;"
		rowMorphGetSelector: [ :node |
			node bodyFont: self bodyFont.
			node statisticName ];
		headerButtonLabel: 'Statistic' font: self headerFont);
	yourself
		
]

{ #category : #UI }
PSMorphTreeModelHeadlines >> defaultExtent [
^1600@700
]

{ #category : #UI }
PSMorphTreeModelHeadlines >> mouseDown: aPresentableStatistic [
(FMRDocument new
	title: 'Game ',aPresentableStatistic gameNumber asString,' Headline Statistics';
	documentString: (self statisticsGenerator printSummaryForGame: aPresentableStatistic gameNumber);
	extent: 1600@700)
		openTextWindow



]

{ #category : #building }
PSMorphTreeModelHeadlines >> rootItems [
^rootItems ifNil: [ rootItems := self statisticsGenerator beForHeadlineStatistics generate presentableStatisticsFiltered ] 
]
