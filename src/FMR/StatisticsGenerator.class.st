Class {
	#name : #StatisticsGenerator,
	#superclass : #FMRStatistics,
	#instVars : [
		'matchState',
		'statisticsClasses',
		'presentableStatistics',
		'preFilterBlock',
		'instanceFilterBlock',
		'includeBoringStatistics',
		'isCumulativeGames'
	],
	#classVars : [
		'MinimumDurationForControlledPossession',
		'ShouldShowBoringStatistics'
	],
	#category : #FMR
}

{ #category : #accessing }
StatisticsGenerator class >> minimumDurationForControlledPossession [

^MinimumDurationForControlledPossession ifNil: [ self minimumDurationForControlledPossessionDefault ]
]

{ #category : #accessing }
StatisticsGenerator class >> minimumDurationForControlledPossession: anObject [

	MinimumDurationForControlledPossession := anObject
]

{ #category : #accessing }
StatisticsGenerator class >> minimumDurationForControlledPossessionDefault [
"Default value for the minimum duration for controlled possession (ms)"

^800
]

{ #category : #accessing }
StatisticsGenerator class >> shouldShowBoringStatistics [

^ShouldShowBoringStatistics ifNil: [ self shouldShowBoringStatisticsDefault ]
]

{ #category : #accessing }
StatisticsGenerator class >> shouldShowBoringStatistics: anObject [

	ShouldShowBoringStatistics := anObject
]

{ #category : #accessing }
StatisticsGenerator class >> shouldShowBoringStatisticsDefault [

^false
]

{ #category : #accessing }
StatisticsGenerator class >> statisticsSettingsOn: aBuilder [
<fmrsettings>
(aBuilder group: #statistics)
	label: 'Statistics';  
	description: 'All settings concerned with Statistics generation and UI';
	with: [
		(aBuilder setting: #minimumDurationForControlledPossession)
			label: 'Minimum duration for controlled possession (ms)'; 
			target: self;
			default: self minimumDurationForControlledPossessionDefault;
			description: 'FMR statistics rely on being able to distinguish between a controlled possession and an uncontrolled possession. FMR doesn''t know what ''control'' means, so it uses possession time as a proxy. Any rod possession whose duration is at least this number of millseconds is considered to be a controlled possession. Any rod possession duration less than this this number of millseconds is considered to be an uncontrolled possession.'.
			
		(aBuilder setting: #shouldShowBoringStatistics)
			label: 'Show ''boring'' statistics'; 
			target: self;
			default: self shouldShowBoringStatisticsDefault;
			description: 'By default statistics considered to be ''boring'' are not shown. A boring statistic is one which has a zero value for the overall match. Check this box to see these statistics.'
		]

		
]

{ #category : #API }
StatisticsGenerator >> at: aPresentableStatisticClass [
^self presentableStatisticsFiltered detect: [ :e | e class = aPresentableStatisticClass ]
]

{ #category : #API }
StatisticsGenerator >> beForAllStatistics [
self statisticsClasses: PresentableStatistic_ subclassesAll asOrderedCollection
]

{ #category : #API }
StatisticsGenerator >> beForHeadlineChart [
self statisticsClasses: PresentableStatistic_ subclassesHeadlineChart asOrderedCollection
]

{ #category : #API }
StatisticsGenerator >> beForHeadlineStatistics [
self statisticsClasses: PresentableStatistic_ subclassesHeadline asOrderedCollection
]

{ #category : #generation }
StatisticsGenerator >> createStatistics [
self presentableStatistics: (self statisticsClasses collect: [ :eachClass | eachClass new matchState: self matchState ])
]

{ #category : #API }
StatisticsGenerator >> filterForAwardStatistics [
self preFilterBlock: [ :aPresentableStatistic | aPresentableStatistic awardName notEmpty ]
]

{ #category : #API }
StatisticsGenerator >> generate [
self createStatistics.
self preFilterStatistics.
self generateStatistics.
]

{ #category : #generation }
StatisticsGenerator >> generateStatistics [
presentableStatistics do: [ :eachStatistic | eachStatistic generateUsing: self ]
]

{ #category : #filtering }
StatisticsGenerator >> includeBoringStatistics [

	^ includeBoringStatistics
]

{ #category : #filtering }
StatisticsGenerator >> includeBoringStatistics: anObject [

	includeBoringStatistics := anObject
]

{ #category : #initialization }
StatisticsGenerator >> initialize [
self beForAllStatistics.
self includeBoringStatistics: self class shouldShowBoringStatistics 
]

{ #category : #filtering }
StatisticsGenerator >> instanceFilterBlock [

	^ instanceFilterBlock
]

{ #category : #filtering }
StatisticsGenerator >> instanceFilterBlock: anObject [

	instanceFilterBlock := anObject
]

{ #category : #accessing }
StatisticsGenerator >> isCumulativeGames [

^isCumulativeGames ifNil: [ false ]
]

{ #category : #accessing }
StatisticsGenerator >> isCumulativeGames: anObject [

	isCumulativeGames := anObject
]

{ #category : #accessing }
StatisticsGenerator >> matchState [

	^ matchState
]

{ #category : #accessing }
StatisticsGenerator >> matchState: anObject [

	matchState := anObject
]

{ #category : #API }
StatisticsGenerator >> matchStatistics [

^self presentableStatisticsFilteredNoBoring select: [ :eachPresentableStatistic | eachPresentableStatistic isMatchStatistic ]
]

{ #category : #filtering }
StatisticsGenerator >> passesBoringFilter: eachPresentableStatistic [
"Boring filtering is performed after computation"

^self includeBoringStatistics or: [ eachPresentableStatistic isBoring not ]
]

{ #category : #filtering }
StatisticsGenerator >> passesSelectionFilter: aPresentableStatistic [
"Selection filtering is perform after instance creation but before computation"

^self instanceFilterBlock
	ifNil: [ true ]
	ifNotNil: [ :block | block value: aPresentableStatistic ]
]

{ #category : #filtering }
StatisticsGenerator >> preFilterBlock [

	^ preFilterBlock
]

{ #category : #filtering }
StatisticsGenerator >> preFilterBlock: anObject [

	preFilterBlock := anObject
]

{ #category : #generation }
StatisticsGenerator >> preFilterStatistics [
self preFilterBlock ifNotNil: [
	presentableStatistics := presentableStatistics select: [ :eachPresentableStatistic | self preFilterBlock value: eachPresentableStatistic ]]
]

{ #category : #accessing }
StatisticsGenerator >> presentableStatistics [
^presentableStatistics
]

{ #category : #accessing }
StatisticsGenerator >> presentableStatistics: anObject [

	presentableStatistics := anObject
]

{ #category : #API }
StatisticsGenerator >> presentableStatisticsFiltered [
^self presentableStatistics select: [ :eachPresentableStatistic | self passesSelectionFilter: eachPresentableStatistic ]


]

{ #category : #API }
StatisticsGenerator >> presentableStatisticsFilteredNoBoring [
^self presentableStatisticsFiltered select: [ :eachPresentableStatistic | self passesBoringFilter: eachPresentableStatistic ]


]

{ #category : #printing }
StatisticsGenerator >> printSummary [
^String streamContents: [ :s |
	1 to: self matchState numberOfGames do: [ :eachGameNumber |
	self presentableStatisticsFiltered do: [ :eachPresentableStatistic |
		eachPresentableStatistic gameNumber: eachGameNumber.
		s << eachPresentableStatistic printGameSummary.
		s cr ]]]
	
]

{ #category : #printing }
StatisticsGenerator >> printSummaryForGame: aGameNumber [
^String streamContents: [ :s |
	self presentableStatisticsFiltered do: [ :eachPresentableStatistic |
		eachPresentableStatistic gameNumber: aGameNumber.
		s << eachPresentableStatistic printGameSummary.
		s cr; cr ]]
	
]

{ #category : #sorting }
StatisticsGenerator >> sortByCategory [
self presentableStatistics:
	(self presentableStatistics sorted: [ :a :b |
		(PresentableStatistic_ statisticCategories indexOf: a statisticCategory)
			<=
		(PresentableStatistic_ statisticCategories indexOf: b statisticCategory) ])
]

{ #category : #sorting }
StatisticsGenerator >> sortByGroup [
self presentableStatistics:
	(self presentableStatistics sorted: [ :a :b |
		(PresentableStatistic_ statisticGroups indexOf: a statisticGroup)
			<=
		(PresentableStatistic_ statisticGroups indexOf: b statisticGroup) ])
]

{ #category : #accessing }
StatisticsGenerator >> statisticsClasses [

	^ statisticsClasses
]

{ #category : #accessing }
StatisticsGenerator >> statisticsClasses: anObject [

	statisticsClasses := anObject
]

{ #category : #API }
StatisticsGenerator >> teamStatistics [

^self presentableStatisticsFilteredNoBoring select: [ :eachPresentableStatistic | eachPresentableStatistic isTeamStatistic ]
]
