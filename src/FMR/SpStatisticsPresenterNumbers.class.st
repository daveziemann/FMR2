Class {
	#name : #SpStatisticsPresenterNumbers,
	#superclass : #SpStatisticsPresenter,
	#category : #FMR
}

{ #category : #initialization }
SpStatisticsPresenterNumbers >> initializePresenters [

self mainMenu: self menuBar.
self noteBook: self newNotebook.
self noteBook
	addPageTitle: 'Tab Levels'
	provider: [ self newStatisticsPageForModelClass: PSMorphTreeModelRodGrouping tabClass: SpStatisticsTabGroupsPresenter];

	addPageTitle: 'Tab Categories'
	provider: [ self newStatisticsPageForModelClass: PSMorphTreeModelRodGrouping tabClass: SpStatisticsTabCategoriesPresenter ];

	addPageTitle: 'Tab Levels - teams in columns'
	provider: [ self newStatisticsPageForModelClass: PSMorphTreeModelTeamColumns tabClass: SpStatisticsTabGroupsPresenter];

	addPageTitle: 'Tab Categories - teams in columns'
	provider: [ self newStatisticsPageForModelClass: PSMorphTreeModelTeamColumns tabClass: SpStatisticsTabCategoriesPresenter ];

	addPageTitle: 'All stats with no tabs'
	provider: [ self newStatisticsPageForModelClass: PSMorphTreeModelRodGrouping ];
	
	addPageTitle: 'Tab Game Headlines'
	provider: [ (SpPresenterFMRHeadlines newOn: self matchState) addPageForEachGame ];
	
	addPageTitle: 'Transition Table'
	provider: [ self newStatisticsPageForModelClass: PSMorphTreeModelTransitionTable ].
	
self layout: (SpBoxLayout newTopToBottom
	add: self mainMenu expand: false;
	add: noteBook;
	yourself).
	

]
