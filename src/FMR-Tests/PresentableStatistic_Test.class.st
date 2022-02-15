"
A PresentableStatistic_Test is a test class for testing the behavior of PresentableStatistic_
"
Class {
	#name : #'PresentableStatistic_Test',
	#superclass : #FMRTestCase,
	#category : #'FMR-Tests'
}

{ #category : #utilities }
PresentableStatistic_Test class >> compileTestValues [
"self compileTestValues"
^String streamContents: [ :s |
		self new statisticsGenerator generate presentableStatisticsFiltered do: [ :e |
			s
				<< 'self
	assert: (sg at: ';
				<< e class name;
				<< ') primitiveResults
	equals: ';
				<< e primitiveResults asString;
				<< '.';
				cr ]]
]

{ #category : #tests }
PresentableStatistic_Test >> testCategoryIntegrity [
| sg categorySet |

sg := self statisticsGenerator createStatistics.

categorySet := (sg presentableStatistics collect: [ :e | e statisticCategory ]) asSet.
self assert: (categorySet \ PresentableStatistic_ statisticCategories) isEmpty.
self assert: (PresentableStatistic_ statisticCategories \ categorySet) isEmpty.
]

{ #category : #tests }
PresentableStatistic_Test >> testClassIntegrity [
| allClasses orderedClasses |

"Tailor this"
orderedClasses := PresentableStatistic_ subclassesAll.

allClasses := PresentableStatistic_ allConcreteSubclasses.
self assert: (allClasses \ orderedClasses) isEmpty.
self assert: (orderedClasses \ allClasses) isEmpty.
]

{ #category : #tests }
PresentableStatistic_Test >> testGroupIntegrity [
| sg groupSet |

sg := self statisticsGenerator createStatistics.

groupSet := (sg presentableStatistics collect: [ :e | e statisticGroup ]) asSet.
self assert: (groupSet \ PresentableStatistic_ statisticGroups) isEmpty.
self assert: (PresentableStatistic_ statisticGroups \ groupSet) isEmpty
]

{ #category : #tests }
PresentableStatistic_Test >> testIntegrity [
| sg categorySet groupSet |

sg := self statisticsGenerator createStatistics.

categorySet := (sg presentableStatistics collect: [ :e | e statisticCategory ]) asSet.
self assert: (categorySet \ PresentableStatistic_ statisticCategories) isEmpty.
self assert: (PresentableStatistic_ statisticCategories \ categorySet) isEmpty.

groupSet := (sg presentableStatistics collect: [ :e | e statisticGroup ]) asSet.
self assert: (groupSet \ PresentableStatistic_ statisticGroups) isEmpty.
self assert: (PresentableStatistic_ statisticGroups \ groupSet) isEmpty
]

{ #category : #tests }
PresentableStatistic_Test >> testPrintSummary [

self assert: self statisticsGenerator generate printSummary size equals: 76091
]

{ #category : #tests }
PresentableStatistic_Test >> testStatisticValues [
| sg |

sg := self statisticsGenerator generate.
self
	assert: (sg at: PSMatchIntensityActivePlay) primitiveResults
	equals: #(#(319988 207918) #(298015 224529) #(203667 153550) #(257769 175977) #(245609 171745) #(1500659 933719)).
self
	assert: (sg at: PSMatchIntensityGoalsPerMinute) primitiveResults
	equals: #(#(207918 7) #(224529 9) #(153550 7) #(175977 8) #(171745 6) #(933719 37)).
self
	assert: (sg at: PSMatchIntensityPossessionChangesPerMinute) primitiveResults
	equals: #(#(207918 32) #(224529 34) #(153550 23) #(175977 30) #(171745 23) #(933719 142)).
self
	assert: (sg at: PSMatchIntensityTransitionsPerMinute) primitiveResults
	equals: #(#(207918 46) #(224529 47) #(153550 36) #(175977 41) #(171745 35) #(933719 205)).
self
	assert: (sg at: PSMatchIntensityLeadSwing) primitiveResults
	equals: #(#(5 3) #(5 2) #(5 3) #(5 4) #(5 2) #(25 14)).
self
	assert: (sg at: PSMatchIntensityTimeInTransition) primitiveResults
	equals: #(#(12013) #(12729) #(10084) #(11038) #(7865) #(53729)).
self
	assert: (sg at: PSMatchIntensityBallTravelDistance) primitiveResults
	equals: #(#(1256) #(1459) #(1136) #(960) #(998) #(5809)).
self
	assert: (sg at: PSGoalsScoredFromAnyRod) primitiveResults
	equals: #(#(#(5) #(2)) #(#(4) #(4)) #(#(2) #(5)) #(#(3) #(4)) #(#(5) #(1)) #(#(19) #(16))).
self
	assert: (sg at: PSPossessionCountOnAllRods) primitiveResults
	equals: #(#(#(19) #(19)) #(#(19) #(22)) #(#(15) #(16)) #(#(19) #(15)) #(#(15) #(14)) #(#(87) #(86))).
self
	assert: (sg at: PSPossessionShareOnAllRods) primitiveResults
	equals: #(#(#(193048 85499) #(193048 107549)) #(#(210188 82177) #(210188 128011)) #(#(142095 58148) #(142095 83947)) #(#(162707 82196) #(162707 80511)) #(#(162311 74011) #(162311 88300)) #(#(870349 382031) #(870349 488318))).
self
	assert: (sg at: PSBlockAndStealOnAnyAdjacentRod) primitiveResults
	equals: #(#(#(25 6) #(26 3)) #(#(29 5) #(27 4)) #(#(23 2) #(19 4)) #(#(20 5) #(28 4)) #(#(19 4) #(21 0)) #(#(116 22) #(121 15))).
self
	assert: (sg at: PSLeadSwing) primitiveResults
	equals: #(#(#(1) #(2)) #(#(1) #(1)) #(#(1) #(2)) #(#(2) #(2)) #(#(2) #(0)) #(#(7) #(7))).
self
	assert: (sg at: PSMaximumConsecutiveGoals) primitiveResults
	equals: #(#(#(4) #(1)) #(#(4) #(2)) #(#(2) #(4)) #(#(1) #(2)) #(#(4) #(1)) #(#(4) #(4))).
self
	assert: (sg at: PSGoalsScoredInOwnGoal) primitiveResults
	equals: #(#(#(0) #(0)) #(#(0) #(1)) #(#(0) #(0)) #(#(1) #(0)) #(#(0) #(0)) #(#(1) #(1))).
self
	assert: (sg at: PSTimeOutTally) primitiveResults
	equals: #(#(#(1) #(1)) #(#(0) #(1)) #(#(0) #(1)) #(#(2) #(0)) #(#(0) #(1)) #(#(3) #(4))).
self
	assert: (sg at: PSSwitchPositionsTally) primitiveResults
	equals: #(#(#(0) #(0)) #(#(0) #(0)) #(#(0) #(0)) #(#(0) #(2)) #(#(0) #(0)) #(#(0) #(2))).
self
	assert: (sg at: PSGoalsScoredFrom3Rod) primitiveResults
	equals: #(#(#(5) #(2)) #(#(4) #(3)) #(#(2) #(5)) #(#(3) #(4)) #(#(5) #(1)) #(#(19) #(15))).
self
	assert: (sg at: PSGoalsScoredFrom3RodStuff) primitiveResults
	equals: #(#(#(0) #(0)) #(#(0) #(0)) #(#(0) #(0)) #(#(0) #(1)) #(#(0) #(0)) #(#(0) #(1))).
self
	assert: (sg at: PSScoringFrom3Rod) primitiveResults
	equals: #(#(#(7 5) #(6 2)) #(#(8 4) #(7 3)) #(#(4 2) #(7 5)) #(#(9 3) #(5 3)) #(#(6 5) #(5 1)) #(#(34 19) #(30 14))).
self
	assert: (sg at: PSBlock2RodAndStealOn3Rod) primitiveResults
	equals: #(#(#(3 1) #(3 0)) #(#(7 1) #(5 0)) #(#(3 0) #(4 0)) #(#(4 3) #(2 0)) #(#(1 0) #(6 0)) #(#(18 5) #(20 0))).
self
	assert: (sg at: PSPossessionCountOn3Rod) primitiveResults
	equals: #(#(#(7) #(6)) #(#(8) #(7)) #(#(4) #(7)) #(#(9) #(5)) #(#(6) #(5)) #(#(34) #(30))).
self
	assert: (sg at: PSPossessionTotalDurationOn3Rod) primitiveResults
	equals: #(#(#(42825) #(49060)) #(#(42480) #(54919)) #(#(23957) #(41936)) #(#(47290) #(34592)) #(#(39286) #(43757)) #(#(195838) #(224264))).
self
	assert: (sg at: PSPossessionMeanDurationOn3Rod) primitiveResults
	equals: #(#(#(6117) #(8176)) #(#(5310) #(7845)) #(#(5989) #(5990)) #(#(5254) #(6918)) #(#(6547) #(8751)) #(#(5759) #(7475))).
self
	assert: (sg at: PSBallOffTableFrom3Rod) primitiveResults
	equals: #(#(#(0) #(1)) #(#(0) #(0)) #(#(0) #(0)) #(#(1) #(0)) #(#(0) #(1)) #(#(1) #(2))).
self
	assert: (sg at: PSTimeOutsOn3Rod) primitiveResults
	equals: #(#(#(0) #(0)) #(#(0) #(1)) #(#(0) #(0)) #(#(1) #(0)) #(#(0) #(1)) #(#(1) #(2))).
self
	assert: (sg at: PSGoalsScoredFrom5Rod) primitiveResults
	equals: #(#(#(0) #(0)) #(#(0) #(1)) #(#(0) #(0)) #(#(0) #(0)) #(#(0) #(0)) #(#(0) #(1))).
self
	assert: (sg at: PSScoringFrom5Rod) primitiveResults
	equals: #(#(#(9 0) #(10 0)) #(#(6 0) #(8 1)) #(#(7 0) #(6 0)) #(#(8 0) #(6 0)) #(#(3 0) #(8 0)) #(#(33 0) #(38 1))).
self
	assert: (sg at: PSPassingSuccess5To3) primitiveResults
	equals: #(#(#(9 4) #(10 5)) #(#(6 6) #(8 4)) #(#(7 3) #(6 3)) #(#(8 4) #(6 5)) #(#(3 3) #(8 4)) #(#(33 20) #(38 21))).
self
	assert: (sg at: PSPass5To3AndScore) primitiveResults
	equals: #(#(#(3) #(2)) #(#(3) #(2)) #(#(1) #(3)) #(#(1) #(3)) #(#(2) #(1)) #(#(10) #(11))).
self
	assert: (sg at: PSBlock2RodStealOn5RodInstaPassTo3Rod) primitiveResults
	equals: #(#(#(3 0) #(3 0)) #(#(7 0) #(5 0)) #(#(3 0) #(4 1)) #(#(4 0) #(2 0)) #(#(1 0) #(6 0)) #(#(18 0) #(20 1))).
self
	assert: (sg at: PSBlock5RodAndStealOn5Rod) primitiveResults
	equals: #(#(#(10 2) #(9 2)) #(#(8 1) #(6 0)) #(#(6 0) #(7 2)) #(#(6 1) #(8 1)) #(#(8 1) #(3 0)) #(#(38 5) #(33 5))).
self
	assert: (sg at: PSPossessionCountOn5Rod) primitiveResults
	equals: #(#(#(9) #(10)) #(#(6) #(8)) #(#(7) #(6)) #(#(8) #(6)) #(#(3) #(8)) #(#(33) #(38))).
self
	assert: (sg at: PSPossessionTotalDurationOn5Rod) primitiveResults
	equals: #(#(#(30996) #(40299)) #(#(13292) #(41381)) #(#(20827) #(24786)) #(#(23157) #(22085)) #(#(16160) #(41213)) #(#(104432) #(169764))).
self
	assert: (sg at: PSPossessionMeanDurationOn5Rod) primitiveResults
	equals: #(#(#(3444) #(4029)) #(#(2215) #(5172)) #(#(2975) #(4131)) #(#(2894) #(3680)) #(#(5386) #(5151)) #(#(3164) #(4467))).
self
	assert: (sg at: PSTimeOutsOn5Rod) primitiveResults
	equals: #(#(#(1) #(0)) #(#(0) #(0)) #(#(0) #(0)) #(#(0) #(0)) #(#(0) #(0)) #(#(1) #(0))).
self
	assert: (sg at: PSGoalsScoredFrom2RodByDeflection) primitiveResults
	equals: #(#(#(0) #(0)) #(#(0) #(0)) #(#(0) #(0)) #(#(1) #(0)) #(#(0) #(0)) #(#(1) #(0))).
self
	assert: (sg at: PSPassingSuccess2To5) primitiveResults
	equals: #(#(#(3 0) #(3 0)) #(#(5 0) #(7 0)) #(#(4 0) #(3 0)) #(#(2 0) #(4 0)) #(#(6 0) #(1 1)) #(#(20 0) #(18 1))).
self
	assert: (sg at: PSPassingSuccess2To3) primitiveResults
	equals: #(#(#(3 0) #(3 1)) #(#(5 0) #(7 2)) #(#(4 1) #(3 3)) #(#(2 0) #(4 0)) #(#(6 2) #(1 0)) #(#(20 3) #(18 6))).
self
	assert: (sg at: PSPass2To3AndScore) primitiveResults
	equals: #(#(#(0) #(0)) #(#(0) #(1)) #(#(1) #(1)) #(#(0) #(0)) #(#(2) #(0)) #(#(3) #(2))).
self
	assert: (sg at: PSBlock3RodAndStealOn2Rod) primitiveResults
	equals: #(#(#(6 2) #(7 1)) #(#(7 3) #(8 4)) #(#(7 2) #(4 2)) #(#(5 1) #(9 2)) #(#(5 2) #(6 0)) #(#(30 10) #(34 9))).
self
	assert: (sg at: PSRetainOn2Rod) primitiveResults
	equals: #(#(#(3 2) #(5 3)) #(#(5 5) #(7 7)) #(#(3 3) #(3 3)) #(#(2 1) #(5 3)) #(#(6 5) #(2 1)) #(#(19 16) #(22 17))).
self
	assert: (sg at: PSPossessionCountOn2Rod) primitiveResults
	equals: #(#(#(3) #(3)) #(#(5) #(7)) #(#(4) #(3)) #(#(2) #(4)) #(#(6) #(1)) #(#(20) #(18))).
self
	assert: (sg at: PSPossessionTotalDurationOn2Rod) primitiveResults
	equals: #(#(#(11678) #(18190)) #(#(26405) #(31711)) #(#(13364) #(17225)) #(#(11749) #(23834)) #(#(18565) #(3330)) #(#(81761) #(94290))).
self
	assert: (sg at: PSPossessionMeanDurationOn2Rod) primitiveResults
	equals: #(#(#(3892) #(6063)) #(#(5281) #(4530)) #(#(3341) #(5741)) #(#(5874) #(5958)) #(#(3094) #(3330)) #(#(4088) #(5238))).

]
