Class {
	#name : #StatisticsMerger,
	#superclass : #FMRStatistics,
	#instVars : [
		'statisticsGenerator'
	],
	#category : #FMR
}

{ #category : #action }
StatisticsMerger >> merge [
 
MatchStateEnumerator new allCompletedStandardMatchesDo: [ :eachMatchState |
	self merge: (eachMatchState statisticsGenerator filterForAwardStatistics; generate) ]
	
]

{ #category : #action }
StatisticsMerger >> merge: aStatisticsGenerator [
 
self statisticsGenerator
	ifNil: [ self statisticsGenerator: aStatisticsGenerator copy ]
	ifNotNil: [ self statisticsGenerator presentableStatistics:
		(self statisticsGenerator presentableStatistics
			with: aStatisticsGenerator presentableStatistics
			collect: [ :statistic1 :statistic2 | statistic1 pickBest: statistic2 ]) ]
]

{ #category : #accessing }
StatisticsMerger >> statisticsGenerator [

	^ statisticsGenerator
]

{ #category : #accessing }
StatisticsMerger >> statisticsGenerator: anObject [

	statisticsGenerator := anObject
]
