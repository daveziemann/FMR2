Class {
	#name : #PSPassingSuccess5To3,
	#superclass : #'PSPassingSuccess_',
	#category : #FMR
}

{ #category : #interestingness }
PSPassingSuccess5To3 class >> absoluteInterestingnessTriggerForGameDefault [
^70
]

{ #category : #interestingness }
PSPassingSuccess5To3 class >> absoluteInterestingnessTriggerForMatchDefault [
^60
]

{ #category : #interestingness }
PSPassingSuccess5To3 class >> interestingnessSettingsOn: aBuilder [
<fmrsettings>

self interestingnessSettingsOn: aBuilder forClass: self
]

{ #category : #awards }
PSPassingSuccess5To3 >> awardName [
^'Best Ever 5-rod to 3-rod Passing Rate'
]

{ #category : #'headline statistics' }
PSPassingSuccess5To3 >> headlineStatisticName [
"Only statsitics which return a non-empty string here are used for headline results,
	in which case the string is used in place of the normal statistic name"

^self statisticName
]

{ #category : #generation }
PSPassingSuccess5To3 >> sequence [
^'5c|3c'
]
