Class {
	#name : #SpStatisticsPresenterPictures,
	#superclass : #SpStatisticsPresenter,
	#category : #FMR
}

{ #category : #initialization }
SpStatisticsPresenterPictures >> initializePresenters [

self mainMenu: self menuBar.
self noteBook: self newNotebook.
self noteBook
	addPageTitle: 'Goal Ladder'
	provider: [ SpPresenterGoalLadder basicNew matchState: self matchState; initialize ];
	
	addPageTitle: 'Match DNA'
	provider: [ SpPresenterDNA basicNew matchState: self matchState; initialize ];

	addPageTitle: 'Transitions'
	provider: [ SpPresenterPseudoRodTransitionChart basicNew matchState: self matchState; initialize ];

	addPageTitle: 'Headline Charts'
	provider: [ (SpPresenterHeadlineCharts newOn: self matchState) addPageForEachGame ];

	addPageTitle: 'Possession Share Pie'
	provider: [ self newPresenter: SpPresenterFMRPiePossessionShare ];
	
	addPageTitle: 'Possession Spread Pie'
	provider: [ self newPresenter: SpPresenterFMRPiePossessionSpread ];
	
	addPageTitle: 'Possession Time Limit Fraction'
	provider: [ self newPresenter: SpPresenterPossessionFraction ];
	
	yourself.
	
self layout: (SpBoxLayout newTopToBottom
	add: self mainMenu expand: false;
	add: noteBook;
	yourself).
	

]
