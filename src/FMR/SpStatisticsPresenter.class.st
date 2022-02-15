Class {
	#name : #SpStatisticsPresenter,
	#superclass : #'SpPresenterFMR_',
	#instVars : [
		'statisticsGenerator',
		'mainMenu',
		'noteBook',
		'gameNumbersToShow'
	],
	#category : #FMR
}

{ #category : #'instance creation' }
SpStatisticsPresenter class >> openOnStatisticsGenerator: aStatisticsGenerator [

(self new statisticsGenerator: aStatisticsGenerator) open
]

{ #category : #accessing }
SpStatisticsPresenter >> gameNumbersToShow [

	^ gameNumbersToShow
]

{ #category : #accessing }
SpStatisticsPresenter >> gameNumbersToShow: anObject [

	gameNumbersToShow := anObject
]

{ #category : #initialization }
SpStatisticsPresenter >> initializePresenters [

self subclassResponsibility 
]

{ #category : #accessing }
SpStatisticsPresenter >> mainMenu [

	^ mainMenu
]

{ #category : #accessing }
SpStatisticsPresenter >> mainMenu: anObject [

	mainMenu := anObject
]

{ #category : #accessing }
SpStatisticsPresenter >> matchState [
^self statisticsGenerator matchState
]

{ #category : #menu }
SpStatisticsPresenter >> menuBar [
^ self newMenuBar
	addGroup: [ :group |
		group
			addItem: [ :item | 
				item
					name: 'Statistics';
					icon: (self iconNamed: #glamorousTable);
					subMenu: self statisticsMenu ] ];
		yourself
]

{ #category : #UI }
SpStatisticsPresenter >> newPresenter: aClass [
^(aClass basicNew matchState: self matchState) initialize
]

{ #category : #initialization }
SpStatisticsPresenter >> newStatisticsPageForModelClass: aClass [
^SpStatisticsPagePresenter basicNew
	gameNumbersToShow: self gameNumbersToShow;
	instanceFilterBlock: nil;
	statisticsGenerator: self statisticsGenerator;
	modelClass: aClass;
	initialize
]

{ #category : #initialization }
SpStatisticsPresenter >> newStatisticsPageForModelClass: aModelClass tabClass: aTabClass [
^aTabClass basicNew
	gameNumbersToShow: self gameNumbersToShow;
	statisticsGenerator: self statisticsGenerator;
	modelClass: aModelClass;
	initialize
]

{ #category : #initialization }
SpStatisticsPresenter >> newStatisticsPageForTabClass: aClass [
^aClass basicNew
	gameNumbersToShow: self gameNumbersToShow;
	statisticsGenerator: self statisticsGenerator;
	initialize
]

{ #category : #accessing }
SpStatisticsPresenter >> noteBook [

	^ noteBook
]

{ #category : #accessing }
SpStatisticsPresenter >> noteBook: anObject [

	noteBook := anObject
]

{ #category : #UI }
SpStatisticsPresenter >> open [
self openWithSpec extent: 1900@800.
self postOpenMods
]

{ #category : #'menu actions' }
SpStatisticsPresenter >> openStatistics [ 
self class openOnStatisticsGenerator: self statisticsGenerator 
]

{ #category : #initialization }
SpStatisticsPresenter >> postOpenMods [

self window title: 'FMR Statistics - ',self matchState matchDescriptionWithoutTeamName,' - ',self matchState matchProgressSummary.

]

{ #category : #accessing }
SpStatisticsPresenter >> statisticsGenerator [

	^ statisticsGenerator
]

{ #category : #accessing }
SpStatisticsPresenter >> statisticsGenerator: anObject [

	statisticsGenerator := anObject
]

{ #category : #menu }
SpStatisticsPresenter >> statisticsMenu [
^self subMenuStatistics
]
