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
	provider: [];
	
	addPageTitle: 'View all Possession Time Fractions'
	provider: [(SpMatchStateTabPresenter basicNew modelClass: SpPresenterPossessionFraction) initialize];	
	
	addPageTitle: 'View all Transition Charts'
	provider: [(SpMatchStateTabPresenter basicNew modelClass: SpPresenterPseudoRodTransitionChart) initialize];	

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
