Class {
	#name : #'PSMatchIntensity_',
	#superclass : #'PresentableTableStatistic_',
	#category : #FMR
}

{ #category : #UI }
PSMatchIntensity_ >> displayRatioAsInteger: aMatchResult [

^aMatchResult ratio rounded asString
]

{ #category : #UI }
PSMatchIntensity_ >> numberPerMinute [
"Answer the result as a number divided by a duration in minutes"

^self getResult in: [ :aMatchResult |
	(aMatchResult result second divideBy: aMatchResult result first asMinutes) round: 1 ]
]

{ #category : #UI }
PSMatchIntensity_ >> statisticCategory [ 
^'Matchplay Intensity'
]

{ #category : #UI }
PSMatchIntensity_ >> statisticCategoryBalloonText [
^'These statistics capture the overall intensity of the matchplay.'
]

{ #category : #generation }
PSMatchIntensity_ >> totalActivePlayTime [
"Answer the total amount of time spent in Active Play during the game/match
	- ask my scanner"
	
^self scanner totalActivePlayTime
]
