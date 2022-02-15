"
A StatisticsGeneratorTest is a test class for testing the behavior of StatisticsGenerator
"
Class {
	#name : #StatisticsGeneratorTest,
	#superclass : #FMRTestCase,
	#category : #'FMR-Tests'
}

{ #category : #tests }
StatisticsGeneratorTest >> testStatisticsGeneration [
| sg |

sg := self statisticsGenerator generate.
self assert: sg presentableStatistics size equals: 54
]

{ #category : #tests }
StatisticsGeneratorTest >> testStatisticsGenerationOnAll [
MatchStateEnumerator new
	allMatchesDo: [ :eachMatchState |
		eachMatchState statisticsGenerator generate ]
]
