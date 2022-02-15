Class {
	#name : #'SpPresenterFMR_',
	#superclass : #SpPresenter,
	#category : #FMR
}

{ #category : #'menu actions' }
SpPresenterFMR_ >> openSettings [
(SettingBrowser forKeywords: #('fmrsettings')) open
]

{ #category : #'menu actions' }
SpPresenterFMR_ >> openStatistics [

self openStatisticsPictures.
self openStatisticsNumbers.

]

{ #category : #'menu actions' }
SpPresenterFMR_ >> openStatisticsNumbers [
"SpStatisticsPresenterNumbers openOnStatisticsGenerator: (StatisticsGenerator new matchState: self matchState) generate"

(SpStatisticsPresenterNumbers new
	gameNumbersToShow: nil;
	statisticsGenerator: self matchState statisticsGenerator generate)
		open
]

{ #category : #'menu actions' }
SpPresenterFMR_ >> openStatisticsPictures [
"SpStatisticsPresenterPictures openOnStatisticsGenerator: (StatisticsGenerator new matchState: self matchState) generate"

(SpStatisticsPresenterPictures new
	gameNumbersToShow: nil;
	statisticsGenerator: self matchState statisticsGenerator generate)
		open
]

{ #category : #'menu actions' }
SpPresenterFMR_ >> showHeadlineStatisticsChart [
"Show the headline stats for each game in turn"

self headlinePresenter ifNotNil: [
	self headlinePresenter window close.
	self headlinePresenter: nil ].

1 to: self matchState numberOfGames do: [ :eachGameNumber |
	self showHeadlineStatisticsChartForGame: eachGameNumber ]
]

{ #category : #'processing - real time' }
SpPresenterFMR_ >> showHeadlineStatisticsChartForGame: aGameNumber [
"Show headline stats for game aGameNumber"

self headlinePresenter ifNil: [
	self headlinePresenter: (SpPresenterHeadlineCharts newOn: self matchState) ].

(self headlinePresenter window isNil or: [ self headlinePresenter window isOpen not ])
	ifTrue: [ self headlinePresenter open ].

self headlinePresenter addPageForGameNumber: aGameNumber.
self headlinePresenter updateWindowTitle
]

{ #category : #menu }
SpPresenterFMR_ >> subMenuStatistics [
	^ self newMenu
		addItem: [ :item | 
			item
				name: 'Show';
				icon: (self iconNamed: #transcript);
				subMenu: self subMenuStatisticsShow ];
		addItem: [ :item | 
			item
				name: 'Statistics Settings';
				icon: (self iconNamed: #configuration);
				action: [ self openSettings ] ];
		yourself
]

{ #category : #menu }
SpPresenterFMR_ >> subMenuStatisticsShow [
	^ self newMenu
		addItem: [ :item | 
			item
				name: 'Pictures';
				icon: (self iconNamed: #paint);
				action: [ self openStatisticsPictures ] ];
		addItem: [ :item | 
			item
				name: 'Numbers';
				icon: (self iconNamed: #glamorousTable);
				action: [ self openStatisticsNumbers ] ];
		addItem: [ :item | 
			item
				name: 'Game Headlines';
				icon: (self iconNamed: #glamorousBrowse);
				action: [ self showHeadlineStatisticsChart ] ];		
		yourself
]
