Class {
	#name : #SpStatisticsTabPresenter,
	#superclass : #'SpPresenterFMR_',
	#instVars : [
		'notebook',
		'statisticsGenerator',
		'gameNumbersToShow',
		'modelClass'
	],
	#category : #FMR
}

{ #category : #specs }
SpStatisticsTabPresenter class >> defaultSpec [

^SpBoxLayout newTopToBottom
	add: #notebook;
	yourself
]

{ #category : #'instance creation' }
SpStatisticsTabPresenter class >> openOnStatisticsGenerator: aStatisticsGenerator [
| sp |
sp := self basicNew
	statisticsGenerator: aStatisticsGenerator;
	initialize.
sp openWithSpec extent: 1400@800.
^sp postOpenMods

]

{ #category : #access }
SpStatisticsTabPresenter >> filterBlockFor: aTabName [
^self subclassResponsibility 
]

{ #category : #accessing }
SpStatisticsTabPresenter >> gameNumbersToShow [

	^ gameNumbersToShow
]

{ #category : #accessing }
SpStatisticsTabPresenter >> gameNumbersToShow: anObject [

	gameNumbersToShow := anObject
]

{ #category : #initialization }
SpStatisticsTabPresenter >> initializePresenters [

self notebook: self newNotebook.
self tabNames do: [ :eachTabFilter |
	| page |
	page := SpNotebookPage 
		title: eachTabFilter
		"icon: (self iconNamed: #workspace)" 
		provider: [
			SpStatisticsPagePresenter basicNew
				gameNumbersToShow: self gameNumbersToShow;
				instanceFilterBlock: (self filterBlockFor: eachTabFilter);
				statisticsGenerator: self statisticsGenerator;
				modelClass: self modelClass;
				initialize ].	
	self notebook addPage: page ].
]

{ #category : #access }
SpStatisticsTabPresenter >> matchState [
^self statisticsGenerator matchState 
]

{ #category : #accessing }
SpStatisticsTabPresenter >> modelClass [

	^ modelClass
]

{ #category : #accessing }
SpStatisticsTabPresenter >> modelClass: anObject [

	modelClass := anObject
]

{ #category : #accessing }
SpStatisticsTabPresenter >> notebook [

	^ notebook
]

{ #category : #accessing }
SpStatisticsTabPresenter >> notebook: anObject [

	notebook := anObject
]

{ #category : #initialization }
SpStatisticsTabPresenter >> postOpenMods [

self window title: 'FMR Statistics - ',self matchState matchDescriptionWithoutTeamName,' - ',self matchState matchProgressSummary.

]

{ #category : #accessing }
SpStatisticsTabPresenter >> statisticsGenerator [

	^ statisticsGenerator
]

{ #category : #accessing }
SpStatisticsTabPresenter >> statisticsGenerator: anObject [

	statisticsGenerator := anObject
]

{ #category : #access }
SpStatisticsTabPresenter >> tabNames [
^self subclassResponsibility 
]
