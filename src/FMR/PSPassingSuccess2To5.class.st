Class {
	#name : #PSPassingSuccess2To5,
	#superclass : #'PSPassingSuccess_',
	#category : #FMR
}

{ #category : #interestingness }
PSPassingSuccess2To5 class >> absoluteInterestingnessTriggerForGameDefault [
^60
]

{ #category : #interestingness }
PSPassingSuccess2To5 class >> absoluteInterestingnessTriggerForMatchDefault [
^30
]

{ #category : #interestingness }
PSPassingSuccess2To5 class >> interestingnessSettingsOn: aBuilder [
<fmrsettings>

self interestingnessSettingsOn: aBuilder forClass: self
]

{ #category : #generation }
PSPassingSuccess2To5 >> sequence [
^'2c|5c'
]
