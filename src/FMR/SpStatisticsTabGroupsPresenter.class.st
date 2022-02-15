Class {
	#name : #SpStatisticsTabGroupsPresenter,
	#superclass : #SpStatisticsTabPresenter,
	#category : #FMR
}

{ #category : #initialization }
SpStatisticsTabGroupsPresenter >> filterBlockFor: aTabName [
^[ :aPresentableStatistic | aPresentableStatistic statisticGroup = aTabName ]
]

{ #category : #initialization }
SpStatisticsTabGroupsPresenter >> tabNames [
^PresentableStatistic_ statisticGroups
]
