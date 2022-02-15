"
This is the main package for the Foosball Matchplay Recorder application
"
Class {
	#name : #ManifestFMR,
	#superclass : #PackageManifest,
	#category : #'FMR-Manifest'
}

{ #category : #'code-critics' }
ManifestFMR class >> ruleGuardingClauseRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#FMR)) #'2022-01-14T18:29:45.087+00:00') )
]

{ #category : #'code-critics' }
ManifestFMR class >> ruleReGuardClauseRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#FMR)) #'2022-01-14T18:29:08.399+00:00') )
]

{ #category : #'code-critics' }
ManifestFMR class >> ruleReturnsIfTrueRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#FMR)) #'2022-01-09T18:56:47.502+00:00') )
]

{ #category : #'code-critics' }
ManifestFMR class >> ruleYourselfNotUsedRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#SpStatisticsPresenter #initializePresenters #false)) #'2022-01-13T23:16:40.095+00:00') )
]
