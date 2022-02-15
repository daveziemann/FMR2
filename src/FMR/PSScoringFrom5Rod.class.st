Class {
	#name : #PSScoringFrom5Rod,
	#superclass : #'PSScoringSuccess_',
	#category : #FMR
}

{ #category : #interestingness }
PSScoringFrom5Rod class >> absoluteInterestingnessTriggerForGameDefault [
^20
]

{ #category : #interestingness }
PSScoringFrom5Rod class >> absoluteInterestingnessTriggerForMatchDefault [
^10
]

{ #category : #interestingness }
PSScoringFrom5Rod class >> interestingnessSettingsOn: aBuilder [
<fmrsettings>

self interestingnessSettingsOn: aBuilder forClass: self
]

{ #category : #generation }
PSScoringFrom5Rod >> sequence [
^'5c|#'
]
