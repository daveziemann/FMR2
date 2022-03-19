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
				name: 'Match Statistics';
				icon: (self iconNamed: #transcript);
				subMenu: (self newMenu
					addItem: [ :i | i
						name: 'Graphics';
						icon: (self iconNamed: #paint);
						action: [ self openStatisticsPictures ] ];
					addItem: [ :i | i
						name: 'Numbers';
						icon: (self iconNamed: #glamorousTable);
						action: [ self openStatisticsNumbers ] ];
					addItem: [ :i | i
						name: 'Game Headlines';
						icon: (self iconNamed: #glamorousBrowse);
						action: [ self showHeadlineStatisticsChart ] ];		
					yourself) ];
		addItem: [ :item | 
			item
				name: 'Meta Statistics';
				icon: (self iconNamed: #database);
				action: [
					(SpMetaStatisticsPresenter basicNew 
						mainPresenter: self;
						initialize;
						openWithSpec) extent: 1800@1000 ]];
		addItem: [ :item | 
			item
				name: 'Statistics Settings';
				icon: (self iconNamed: #configuration);
				action: [ self openSettings ] ];
		yourself
]
