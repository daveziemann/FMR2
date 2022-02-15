"
A StatisticsMergerTest is a test class for testing the behavior of StatisticsMerger
"
Class {
	#name : #StatisticsMergerTest,
	#superclass : #FMRTestCase,
	#category : #'FMR-Tests'
}

{ #category : #tests }
StatisticsMergerTest >> testMerge [
| merger |

merger := StatisticsMerger new merge.
self assert: merger statisticsGenerator presentableStatistics size equals: 7

]
