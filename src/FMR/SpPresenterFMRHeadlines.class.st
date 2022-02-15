Class {
	#name : #SpPresenterFMRHeadlines,
	#superclass : #'SpPresenterFMR_',
	#instVars : [
		'matchState',
		'notebook'
	],
	#category : #FMR
}

{ #category : #specs }
SpPresenterFMRHeadlines class >> defaultSpec [

^SpBoxLayout newTopToBottom
	add: #notebook;
	yourself
]

{ #category : #specs }
SpPresenterFMRHeadlines class >> newOn: aMatchState [
^(self basicNew matchState: aMatchState) initialize
]

{ #category : #specs }
SpPresenterFMRHeadlines class >> openOn: aMatchState [
^(self newOn: aMatchState) open
]

{ #category : #initialization }
SpPresenterFMRHeadlines >> addPageForEachGame [
1 to: self matchState numberOfGames do: [ :eachGameNumber | self addPageForGameNumber: eachGameNumber ]
]

{ #category : #initialization }
SpPresenterFMRHeadlines >> addPageForGameNumber: aGameNumber [
| page |

page := SpNotebookPage 
	title: 'Game ',aGameNumber asString
	"icon: (self iconNamed: #workspace)" 
	provider: [
		SpStatisticsPagePresenter basicNew
			gameNumbersToShow: {aGameNumber};
			instanceFilterBlock: nil;
			statisticsGenerator: self statisticsGenerator;
			modelClass: PSMorphTreeModelHeadlines;
			initialize ].

self notebook
	addPage: page;
	selectPage: page.
]

{ #category : #initialization }
SpPresenterFMRHeadlines >> defaultExtent [
^1400@400
]

{ #category : #initialization }
SpPresenterFMRHeadlines >> initializePresenters [
self notebook: self newNotebook
]

{ #category : #accessing }
SpPresenterFMRHeadlines >> matchState [

	^ matchState
]

{ #category : #accessing }
SpPresenterFMRHeadlines >> matchState: anObject [

	matchState := anObject
]

{ #category : #accessing }
SpPresenterFMRHeadlines >> notebook [

	^ notebook
]

{ #category : #accessing }
SpPresenterFMRHeadlines >> notebook: anObject [

	notebook := anObject
]

{ #category : #initialization }
SpPresenterFMRHeadlines >> open [
self openWithSpec extent: self defaultExtent.
self postOpenMods.

]

{ #category : #initialization }
SpPresenterFMRHeadlines >> postOpenMods [

self updateWindowTitle
]

{ #category : #initialization }
SpPresenterFMRHeadlines >> statisticsGenerator [
^(StatisticsGenerator new matchState: self matchState) beForHeadlineStatistics generate
]

{ #category : #initialization }
SpPresenterFMRHeadlines >> updateWindowTitle [

self window title: 'FMR Headline Statistics - ',self matchState matchDescriptionWithoutTeamName,' - ',self matchState matchProgressSummary.

]
