Class {
	#name : #SpStatisticsTabCategoriesPresenter,
	#superclass : #SpStatisticsTabPresenter,
	#category : #FMR
}

{ #category : #access }
SpStatisticsTabCategoriesPresenter >> filterBlockFor: aTabName [
^[ :aPresentableStatistic | aPresentableStatistic statisticCategory = aTabName ]
]

{ #category : #access }
SpStatisticsTabCategoriesPresenter >> tabNames [
^PresentableStatistic_ statisticCategories
]
