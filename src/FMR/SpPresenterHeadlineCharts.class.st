Class {
	#name : #SpPresenterHeadlineCharts,
	#superclass : #'SpPresenterFMR_',
	#instVars : [
		'matchState',
		'notebook'
	],
	#category : #FMR
}

{ #category : #specs }
SpPresenterHeadlineCharts class >> defaultSpec [

^SpBoxLayout newTopToBottom
	add: #notebook;
	yourself
]

{ #category : #specs }
SpPresenterHeadlineCharts class >> newOn: aMatchState [
^(self basicNew matchState: aMatchState) initialize
]

{ #category : #specs }
SpPresenterHeadlineCharts class >> openOn: aMatchState [
^(self newOn: aMatchState) open
]

{ #category : #initialization }
SpPresenterHeadlineCharts >> addPageForEachGame [
self matchState gameNumbers do: [ :eachGameNumber | self addPageForGameNumber: eachGameNumber ]
]

{ #category : #initialization }
SpPresenterHeadlineCharts >> addPageForGameNumber: aGameNumber [
| page |

page := SpNotebookPage 
	title: (aGameNumber isZero ifTrue: [ 'Match' ] ifFalse: [ 'Game ', aGameNumber asString ])
	icon: (self iconNamed: #smallObjects)
	provider: [
		SpPresenterHeadlineChart new
			matchState: self matchState;
			gameNumber: aGameNumber;
			yourself ].

self notebook
	addPage: page;
	selectPage: page.
]

{ #category : #initialization }
SpPresenterHeadlineCharts >> defaultExtent [

	^ 450@300
]

{ #category : #initialization }
SpPresenterHeadlineCharts >> initializePresenters [
self notebook: self newNotebook
]

{ #category : #accessing }
SpPresenterHeadlineCharts >> matchState [

	^ matchState
]

{ #category : #accessing }
SpPresenterHeadlineCharts >> matchState: anObject [

	matchState := anObject
]

{ #category : #accessing }
SpPresenterHeadlineCharts >> notebook [

	^ notebook
]

{ #category : #accessing }
SpPresenterHeadlineCharts >> notebook: anObject [

	notebook := anObject
]

{ #category : #initialization }
SpPresenterHeadlineCharts >> open [
self openWithSpec extent: self defaultExtent.
self postOpenMods.

]

{ #category : #initialization }
SpPresenterHeadlineCharts >> postOpenMods [

self updateWindowTitle
]

{ #category : #initialization }
SpPresenterHeadlineCharts >> statisticsGenerator [
^(StatisticsGenerator new matchState: self matchState) beForHeadlineChart generate
]

{ #category : #initialization }
SpPresenterHeadlineCharts >> updateWindowTitle [

self window title: 'FMR Headline Chart - ',self matchState matchDescriptionWithoutTeamName,' - ',self matchState matchProgressSummary.

]
