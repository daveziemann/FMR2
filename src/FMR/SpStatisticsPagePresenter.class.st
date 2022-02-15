Class {
	#name : #SpStatisticsPagePresenter,
	#superclass : #'SpPresenterFMR_',
	#instVars : [
		'statisticsGenerator',
		'modelClass',
		'instanceFilterBlock',
		'gameNumbersToShow'
	],
	#category : #FMR
}

{ #category : #accessing }
SpStatisticsPagePresenter >> gameNumbersToShow [

	^ gameNumbersToShow
]

{ #category : #accessing }
SpStatisticsPagePresenter >> gameNumbersToShow: anObject [

	gameNumbersToShow := anObject
]

{ #category : #initialization }
SpStatisticsPagePresenter >> initializePresenters [
| morphTreeModel morphTreeMorph morph |
self statisticsGenerator instanceFilterBlock: self instanceFilterBlock.
morphTreeModel := self modelClass new
	gameNumbersToShow: self gameNumbersToShow;
	statisticsGenerator: self statisticsGenerator.
"morphTreeModel rootItems ifEmpty: [ self halt ]."
morphTreeMorph := morphTreeModel treeMorph buildContents.

morph := self newMorph.
morph morph: morphTreeMorph.
self layout: (SpBoxLayout newTopToBottom
	add: morph;
	yourself )
]

{ #category : #accessing }
SpStatisticsPagePresenter >> instanceFilterBlock [

	^ instanceFilterBlock
]

{ #category : #accessing }
SpStatisticsPagePresenter >> instanceFilterBlock: anObject [

	instanceFilterBlock := anObject
]

{ #category : #accessing }
SpStatisticsPagePresenter >> modelClass [

	^ modelClass
]

{ #category : #accessing }
SpStatisticsPagePresenter >> modelClass: anObject [

	modelClass := anObject
]

{ #category : #accessing }
SpStatisticsPagePresenter >> statisticsGenerator [

	^ statisticsGenerator
]

{ #category : #accessing }
SpStatisticsPagePresenter >> statisticsGenerator: anObject [

	statisticsGenerator := anObject
]
