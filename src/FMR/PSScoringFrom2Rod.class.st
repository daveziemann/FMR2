Class {
	#name : #PSScoringFrom2Rod,
	#superclass : #'PSScoringSuccess_',
	#category : #FMR
}

{ #category : #interestingness }
PSScoringFrom2Rod class >> absoluteInterestingnessTriggerForGameDefault [
^20
]

{ #category : #interestingness }
PSScoringFrom2Rod class >> absoluteInterestingnessTriggerForMatchDefault [
^25
]

{ #category : #interestingness }
PSScoringFrom2Rod class >> interestingnessSettingsOn: aBuilder [
<fmrsettings>

self interestingnessSettingsOn: aBuilder forClass: self
]

{ #category : #awards }
PSScoringFrom2Rod >> awardName [
^'Best Ever 2-rod Scoring Rate'
]

{ #category : #generation }
PSScoringFrom2Rod >> sequence [
^'2c|#'
]
