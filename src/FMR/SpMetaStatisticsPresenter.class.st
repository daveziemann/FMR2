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
		| merger awardsPresenter window |
		merger := StatisticsMerger new merge.
		awardsPresenter := SpStatisticsPagePresenter basicNew 
			statisticsGenerator: merger statisticsGenerator;
			modelClass: PSMorphTreeModelAwards;
			initialize.
		window := awardsPresenter openWithSpec.
		window title: 'FMR Awards - The Best Ever!'.
		window extent: 1800@500.
		awardsPresenter ];
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
