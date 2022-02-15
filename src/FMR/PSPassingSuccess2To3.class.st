Class {
	#name : #PSPassingSuccess2To3,
	#superclass : #'PSPassingSuccess_',
	#category : #FMR
}

{ #category : #interestingness }
PSPassingSuccess2To3 class >> absoluteInterestingnessTriggerForGameDefault [
^20
]

{ #category : #interestingness }
PSPassingSuccess2To3 class >> absoluteInterestingnessTriggerForMatchDefault [
^20
]

{ #category : #interestingness }
PSPassingSuccess2To3 class >> interestingnessSettingsOn: aBuilder [
<fmrsettings>

self interestingnessSettingsOn: aBuilder forClass: self
]

{ #category : #generation }
PSPassingSuccess2To3 >> sequence [
^'2c|3c'
]
