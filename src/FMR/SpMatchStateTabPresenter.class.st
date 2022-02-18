Class {
	#name : #SpMatchStateTabPresenter,
	#superclass : #'SpPresenterFMR_',
	#instVars : [
		'notebook'
	],
	#category : #FMR
}

{ #category : #'instance creation' }
SpMatchStateTabPresenter class >> defaultExtent [
^1400@800
]

{ #category : #specs }
SpMatchStateTabPresenter class >> defaultSpec [

^SpBoxLayout newTopToBottom
	add: #notebook;
	yourself
]

{ #category : #'instance creation' }
SpMatchStateTabPresenter class >> openOnStatisticsGenerator: aStatisticsGenerator [
| sp |
sp := self basicNew
	statisticsGenerator: aStatisticsGenerator;
	initialize.
sp openWithSpec extent: self defaultExtent.
^sp postOpenMods

]

{ #category : #initialization }
SpMatchStateTabPresenter >> initializePresenters [
| n |
self notebook: self newNotebook.
n := 0.
MatchStateEnumerator new allMatchesDo: [ :eachMatchState |
	n := n+1.
	self notebook
		addPageTitle: n asString
		provider: [ SpPresenterPossessionFraction basicNew matchState: eachMatchState; initialize ]]



]

{ #category : #accessing }
SpMatchStateTabPresenter >> notebook [

	^ notebook
]

{ #category : #accessing }
SpMatchStateTabPresenter >> notebook: anObject [

	notebook := anObject
]
