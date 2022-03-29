Class {
	#name : #SpMetaStatisticsPresenter,
	#superclass : #'SpPresenterFMR_',
	#instVars : [
		'mainPresenter',
		'notebook'
	],
	#category : #FMR
}

{ #category : #initialization }
SpMetaStatisticsPresenter >> initializePresenters [

self notebook: (self instantiate: SpNotebookPresenter).
self notebook
	addPageTitle: 'GOAT Awards!'
	provider: [
		| merger awardsPresenter |
		merger := StatisticsMerger new merge.
		awardsPresenter := SpStatisticsPagePresenter basicNew 
			statisticsGenerator: merger statisticsGenerator;
			modelClass: PSMorphTreeModelAwards;
			initialize.
		awardsPresenter ];

	addPageTitle: 'View all Goal Ladders'
	provider: [SpPresenterGoalLadder new];
	
	addPageTitle: 'View all Possession Time Fractions'
	provider: [(SpMatchStateTabPresenter basicNew modelClass: SpPresenterPossessionFraction) initialize];	
	
	addPageTitle: 'View all Transition Charts'
	provider: [(SpMatchStateTabPresenter basicNew modelClass: SpPresenterPseudoRodTransitionChart) initialize];	

	addPageTitle: 'Win/Lose Correlates'
	provider: [SpStatisticsPagePresenter basicNew 
		statisticsGenerator:StatisticsGenerator new;
		modelClass: PSMorphTreeModelTrawlWinCorrrelates;
		initialize ];	

	addPageTitle: '5-rod Possession Time and Passing Success'
	provider: [SpPresenterMetaPossessionPassing53Success new];	

	addPageTitle: '3-rod Possession Time and Scoring Success'
	provider: [SpPresenterMetaPossessionScoring3Success new];	

	addPageTitle: '2-rod Possession Time and Scoring Success'
	provider: [SpPresenterMetaPossessionScoring2Success new];	

	yourself.
	
	
self layout: (SpBoxLayout newTopToBottom
	"add: self mainMenu expand: false;"
	add: self notebook;
	yourself).
	

]

{ #category : #accessing }
SpMetaStatisticsPresenter >> mainPresenter [

	^ mainPresenter
]

{ #category : #accessing }
SpMetaStatisticsPresenter >> mainPresenter: anObject [

	mainPresenter := anObject
]

{ #category : #accessing }
SpMetaStatisticsPresenter >> notebook [

	^ notebook
]

{ #category : #accessing }
SpMetaStatisticsPresenter >> notebook: anObject [

	notebook := anObject
]
