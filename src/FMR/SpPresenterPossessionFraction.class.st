Class {
	#name : #SpPresenterPossessionFraction,
	#superclass : #'SpPresenterFMR_',
	#instVars : [
		'matchState',
		'fractionStatistics'
	],
	#category : #FMR
}

{ #category : #creating }
SpPresenterPossessionFraction >> buildEventWrappersForFractionStatistic: aPossessionTimeLimitFractionStatistic teamNumber: aTeamNumber [
| scanner matchplayEvents teamFractions last teamFractionCumulativeAverage assocs fractions |

scanner := aPossessionTimeLimitFractionStatistic scanner.
matchplayEvents := scanner teamNumber: 0; gameNumber: 0; scan; lastSequence.

scanner teamNumber: aTeamNumber; scan.
teamFractions := scanner lastSequenceDurations / scanner lastSequenceTimeLimits.
teamFractionCumulativeAverage := ((teamFractions collectWithIndex: [ :e :i |
	last:= i=1
		ifTrue:[ e asFloat ]
		ifFalse:[ last+e ]])/(1 to: teamFractions size) * 100) rounded.
	
assocs := scanner lastSequence
	with: teamFractionCumulativeAverage
	collect: [ :eachMatchplayEvent :fraction | eachMatchplayEvent -> fraction ]. 

fractions := matchplayEvents collect:[ :eachMatchplayEvent | (assocs detect: [ :e | e key = eachMatchplayEvent] ifNone: [0]) value ].
last:=0. fractions doWithIndex: [ :e :i | e isZero ifTrue: [ fractions at: i put: last ] ifFalse: [ last:=e ]].

^matchplayEvents
	with: fractions
	collect: [ :eachMatchplayEvent :eachFraction |
		(MatchplayEventPossessionFraction new matchplayEvent: eachMatchplayEvent) fraction: eachFraction ].
]

{ #category : #drawing }
SpPresenterPossessionFraction >> colourForTeam: aTeamNumber [
^self matchState colourForTeam: aTeamNumber inGame: 0
]

{ #category : #drawing }
SpPresenterPossessionFraction >> createChartForFractionStatistic: aPSPossessionTimeLimitFractionStatistic [
| chart lp1 lp2 team1Wrappers team2Wrappers popup title |

chart := RSChart new.
chart extent: 400@150.

team1Wrappers := self buildEventWrappersForFractionStatistic: aPSPossessionTimeLimitFractionStatistic teamNumber: 1.
lp1 := self linePlotForWrappers: team1Wrappers teamNumber: 1.
chart addPlot: lp1.

team2Wrappers := self buildEventWrappersForFractionStatistic: aPSPossessionTimeLimitFractionStatistic teamNumber: 2.
lp2 := self linePlotForWrappers: team2Wrappers teamNumber: 2.
chart addPlot: lp2.

popup := RSPopupDecoration new.
popup chartPopupBuilder for: lp1 text: self matchState teamOne teamName color: (self colourForTeam: 1).
popup chartPopupBuilder for: lp2 text: self matchState teamTwo teamName color: (self colourForTeam: 2).
chart addDecoration: popup.

chart minValueY: 0; maxValueY: 110.
chart addDecoration: (RSVerticalTick new
	numberOfTicks: 10;
	doNotUseNiceLabel;
	labelConversion: [ :value | value asString,'%' ];
	yourself).

chart addDecoration: (RSHorizontalTick new
	fromNames: (self showNewGames: team1Wrappers);
	useDiagonalLabel).

title := chart title: aPSPossessionTimeLimitFractionStatistic statisticName.

chart build.

title label addInteraction: (RSPopup text: (aPSPossessionTimeLimitFractionStatistic statisticNameBalloonText withNoLineLongerThan: 50)).

^chart
]

{ #category : #drawing }
SpPresenterPossessionFraction >> drawOnCanvas: aCanvas charts: charts [
"Render the four charts on aCanvas"
| compositeShapes |

"Create a composite from each chart canvas and add to rendering canvas"
compositeShapes := charts collect:[ :eachChart | eachChart container asShape ].
aCanvas addAll: compositeShapes.

"Layout 2x2"
RSGridLayout new lineItemsCount: 2; gapSize: 10; on: compositeShapes.

"Add teams legend above"
(self legendTeams container: aCanvas) build.

aCanvas when: RSMouseClick do: [ :event | self matchState open ].
aCanvas @ RSCanvasController
]

{ #category : #creating }
SpPresenterPossessionFraction >> fractionClasses [
^{
	.PSPossessionTimeLimitFractionOn3Rod
	.PSPossessionTimeLimitFractionOn5Rod
	.PSPossessionTimeLimitFractionOn2Rod
	.PSPossessionTimeLimitFractionOnAllRods
}

]

{ #category : #creating }
SpPresenterPossessionFraction >> fractionStatistics [
^self fractionClasses collect: [ :eachFractionClass | eachFractionClass new matchState: self matchState ]
]

{ #category : #initialization }
SpPresenterPossessionFraction >> initializePresenters [
| charts rp |

charts := self fractionStatistics collect: [ :eachFractionStatistic |
	self createChartForFractionStatistic: eachFractionStatistic ].

rp := self instantiate: SpRoassalPresenter.
rp script: [ :canvas | self drawOnCanvas: canvas charts: charts ].

self layout: (SpBoxLayout newLeftToRight hAlignStart
	add: rp withConstraints: [ :c | c width: 1800 ];
	yourself)

]

{ #category : #initialization }
SpPresenterPossessionFraction >> legendTeams [
| legend |

legend := RSLegend new.
legend layout horizontal.
legend location above offset: 0@(-10).
legend text: self matchState teamOne teamName withBoxColor: (self colourForTeam: 1).
legend text: self matchState teamTwo teamName withBoxColor: (self colourForTeam: 2).
^legend
]

{ #category : #drawing }
SpPresenterPossessionFraction >> linePlotForWrappers: matchplayEventWrappers teamNumber: aTeamNumber [

^RSLinePlot new
	x: (1 to: matchplayEventWrappers size)
	y: (matchplayEventWrappers collect: #fraction);
	width: 2;
	color: (self matchState colourForTeam: aTeamNumber inGame: 0)

]

{ #category : #accessing }
SpPresenterPossessionFraction >> matchState [

	^ matchState
]

{ #category : #accessing }
SpPresenterPossessionFraction >> matchState: anObject [

	matchState := anObject
]

{ #category : #initialization }
SpPresenterPossessionFraction >> open [
self openWithSpec extent: 1800@900.
]

{ #category : #drawing }
SpPresenterPossessionFraction >> showNewGames: matchplayEventWrappers [
^matchplayEventWrappers collectWithIndex: [ :e :i |
	i = 1
		ifTrue: [ 'Game 1' ]
		ifFalse: [ (matchplayEventWrappers at: i - 1) matchplayEvent gameNumber < e matchplayEvent gameNumber
			ifTrue: [ 'Game ',e matchplayEvent gameNumber asString ]
			ifFalse: [ '' ]]]
]
