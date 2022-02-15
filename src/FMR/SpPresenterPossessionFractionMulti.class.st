Class {
	#name : #SpPresenterPossessionFractionMulti,
	#superclass : #'SpPresenterFMR_',
	#instVars : [
		'matchState',
		'fractionStatistics'
	],
	#category : #FMR
}

{ #category : #creating }
SpPresenterPossessionFractionMulti >> buildEventWrappersForFractionStatistic: aPossessionTimeLimitFractionStatistic teamNumber: aTeamNumber [
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

fractions := matchplayEvents collect:[ :eachMatchplayEvent | (assocs detect: [ :e | e key = eachMatchplayEvent] ifNone:[0]) value ].
last:=0. fractions doWithIndex: [ :e :i | e isZero ifTrue: [ fractions at: i put: last ] ifFalse:[ last:=e ]].

^matchplayEvents
	with: fractions
	collect: [ :eachMatchplayEvent :eachFraction |
		(MatchplayEventPossessionFraction new matchplayEvent: eachMatchplayEvent) fraction: eachFraction ].
]

{ #category : #drawing }
SpPresenterPossessionFractionMulti >> colourForTeam: aTeamNumber [
^self matchState colourForTeam: aTeamNumber inGame: 0
]

{ #category : #drawing }
SpPresenterPossessionFractionMulti >> drawOnCanvas: aCanvas fractionStatistic: aPSPossessionTimeLimitFractionStatistic [
| chart lp1 lp2 team1Wrappers team2Wrappers popup title lb |

chart := RSChart new.
chart container: aCanvas.
chart extent: 400@150.
popup := RSPopupDecoration new.
chart addDecoration: popup.

team1Wrappers := self buildEventWrappersForFractionStatistic: aPSPossessionTimeLimitFractionStatistic teamNumber: 1.
lp1 := self linePlotForWrappers: team1Wrappers teamNumber: 1.
chart addPlot: lp1.
popup chartPopupBuilder for: lp1 text: self matchState teamOne teamName color: (self colourForTeam: 1).

team2Wrappers := self buildEventWrappersForFractionStatistic: aPSPossessionTimeLimitFractionStatistic teamNumber: 2.
lp2 := self linePlotForWrappers: team2Wrappers teamNumber: 2.
chart addPlot: lp2.
popup chartPopupBuilder for: lp2 text: self matchState teamTwo teamName color: (self colourForTeam: 2).

chart minValueY: 0; maxValueY: 110.
chart addDecoration: (RSVerticalTick new
	numberOfTicks: 10;
	labelConversion: [ :value | value asString,'%' ];
	yourself).

chart addDecoration: (RSHorizontalTick new
	fromNames: (self showNewGames: team1Wrappers);
	useDiagonalLabel).

title := chart title: aPSPossessionTimeLimitFractionStatistic statisticName.

chart build.

title label addInteraction: (RSPopup text: (aPSPossessionTimeLimitFractionStatistic statisticNameBalloonText withNoLineLongerThan: 50)).

lb := RSLegend new.
lb container: chart canvas.
lb layout horizontal.
lb location middle offset: 0@120.

lb text: self matchState teamOne teamName withBoxColor: lp1 computeColor.
lb text: self matchState teamTwo teamName withBoxColor: lp2 computeColor.

lb build.

chart shapes do: [ :e | e when: RSMouseClick do: [ :evt | self matchState open ]].
aCanvas when: RSMouseClick do: [ :evt | self matchState open ].
aCanvas @ RSCanvasController
]

{ #category : #creating }
SpPresenterPossessionFractionMulti >> fractionClasses [
^{
	.PSPossessionTimeLimitFractionOn2Rod
	.PSPossessionTimeLimitFractionOn5Rod
	.PSPossessionTimeLimitFractionOn3Rod
	.PSPossessionTimeLimitFractionOnAllRods
}

]

{ #category : #creating }
SpPresenterPossessionFractionMulti >> fractionStatistics [
^self fractionClasses collect: [ :eachFractionClass | eachFractionClass new matchState: self matchState ]
]

{ #category : #initialization }
SpPresenterPossessionFractionMulti >> initializePresenters [
| rp p |

rp := self fractionStatistics collect: [ :eachFractionStatistic |
	p := self instantiate: SpRoassalPresenter.
	p script: [ :canvas | self drawOnCanvas: canvas fractionStatistic: eachFractionStatistic ]].

self layout: (SpBoxLayout newTopToBottom 
	add: (SpBoxLayout newLeftToRight add: rp first; add: rp second; yourself) withConstraints: [ :c | c height: 400; padding: 2 ];
	add: (SpBoxLayout newLeftToRight add: rp third; add: rp fourth; yourself) withConstraints: [ :c | c height: 400; padding: 2 ];
	yourself)	
]

{ #category : #drawing }
SpPresenterPossessionFractionMulti >> linePlotForWrappers: matchplayEventWrappers teamNumber: aTeamNumber [

^RSLinePlot new
	x: (1 to: matchplayEventWrappers size)
	y: (matchplayEventWrappers collect: #fraction);
	color: (self matchState colourForTeam: aTeamNumber inGame: 0)

]

{ #category : #accessing }
SpPresenterPossessionFractionMulti >> matchState [

	^ matchState
]

{ #category : #accessing }
SpPresenterPossessionFractionMulti >> matchState: anObject [

	matchState := anObject
]

{ #category : #initialization }
SpPresenterPossessionFractionMulti >> open [
self openWithSpec extent: 1800@900.
]

{ #category : #drawing }
SpPresenterPossessionFractionMulti >> showNewGames: matchplayEventWrappers [
^matchplayEventWrappers collectWithIndex: [ :e :i |
	i = 1
		ifTrue: [ 'Game 1' ]
		ifFalse: [ (matchplayEventWrappers at: i - 1) matchplayEvent gameNumber < e matchplayEvent gameNumber
			ifTrue: [ 'Game ',e matchplayEvent gameNumber asString ]
			ifFalse: [ '' ]]]
]
