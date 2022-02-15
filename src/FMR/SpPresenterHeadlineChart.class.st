Class {
	#name : #SpPresenterHeadlineChart,
	#superclass : #'SpPresenterFMR_',
	#instVars : [
		'matchState',
		'statisticsGenerator',
		'gameNumber',
		'teamNumber'
	],
	#category : #FMR
}

{ #category : #tuning }
SpPresenterHeadlineChart >> barHeight [
^30
]

{ #category : #tuning }
SpPresenterHeadlineChart >> barTextFontSize [
^10
]

{ #category : #drawing }
SpPresenterHeadlineChart >> barTextFor: aPS [

^aPS getResult primitiveResults size = 2
	ifTrue: [ self printRatioAsPercentage: aPS ]
	ifFalse: [ '' ]
]

{ #category : #generating }
SpPresenterHeadlineChart >> colourForTeam: aTeamNumber [
^self matchState colourForTeam: aTeamNumber inGame: self gameNumber
]

{ #category : #generating }
SpPresenterHeadlineChart >> createShapes [
| shapesForTeam1 shapesForTeam2 labelTeam1 labelTeam2 |

shapesForTeam1 := self createShapesForTeam: 1.
shapesForTeam2 := self createShapesForTeam: 2.

labelTeam1 := RSLabel new
	text: (self matchState teamOnSide: self matchState table sideLeft inGame: self gameNumber) teamName;
	fontSize: self teamNameFontSize;
	yourself.
labelTeam2 := RSLabel new
	text: (self matchState teamOnSide: self matchState table sideRight inGame: self gameNumber) teamName;
	fontSize: self teamNameFontSize;
	yourself.
RSLocation new	above; right; offset: 10@(-20); stick: labelTeam2 on: shapesForTeam1 second first.
RSLocation new above; left; offset: -10@(-20); stick: labelTeam1 on: shapesForTeam2 second first.

^{labelTeam1.shapesForTeam1.labelTeam2.shapesForTeam2 second} flattened




]

{ #category : #generating }
SpPresenterHeadlineChart >> createShapesForTeam: aTeamNumber [
| ps shapesP3 shapesS3 shapesP5 shapesP53 shapesP2 shapesS2 shapesE2 rowTitleP3 rowTitleS3 rowTitleP5 rowTitleP53 rowTitleE2 rowTitleP2 rowTitleS2 rowTitles bars rowTitleP25 shapesP25 rowTitleP23 shapesP23 rowTitleS5 shapesS5 row |

self teamNumber: aTeamNumber.
row := 2.
ps := self statisticAt: PSPossessionCountOn3Rod.
rowTitleP3 := self heading: ps statisticName onRow: row.
shapesP3 := self shapesForConfigured: ps result: 1 showLabel: false onRow: row.

row := row+1.
ps := self statisticAt: PSScoringFrom3Rod.
rowTitleS3 := self heading: ps statisticName2 onRow: row.
shapesS3 := self shapesForConfigured: ps result: 2 showLabel: true onRow: row.

row := row+2.
ps := self statisticAt: PSPossessionCountOn5Rod.
rowTitleP5 := self heading: ps statisticName onRow: row.
shapesP5 := self shapesForConfigured: ps result: 1 showLabel: false onRow: row.

row := row+1.
ps := self statisticAt: PSPassingSuccess5To3.
rowTitleP53 := self heading: ps statisticName2 onRow: row.
shapesP53 := self shapesForConfigured: ps result: 2 showLabel: true onRow: row.

row := row+1.
ps := self statisticAt: PSScoringFrom5Rod.
rowTitleS5 := self heading: ps statisticName2 onRow: row.
shapesS5 := self shapesForConfigured: ps result: 2 showLabel: true onRow: row.

row := row+2.
ps := self statisticAt: PSRetainOn2Rod.
rowTitleE2 := self heading: ps statisticName1 onRow: row.
shapesE2 := self shapesForConfigured: ps result: 1 showLabel: false onRow: row. 

row := row+1.
rowTitleP2 := self heading: ps statisticName2 onRow: row.
shapesP2 := self shapesForConfigured: ps result: 2 showLabel: true onRow: row.

row := row+1.
ps := self statisticAt: PSScoringFrom2Rod.
rowTitleS2 := self heading: ps statisticName2 onRow: row.
shapesS2 := self shapesForConfigured: ps result: 2 showLabel: false onRow: row.

row := row+1.
ps := self statisticAt: PSPassingSuccess2To3.
rowTitleP23 := self heading: ps statisticName2 onRow: row.
shapesP23 := self shapesForConfigured: ps result: 2 showLabel: true onRow: row.

row := row+1.
ps := self statisticAt: PSPassingSuccess2To5.
rowTitleP25 := self heading: ps statisticName2 onRow: row.
shapesP25 := self shapesForConfigured: ps result: 2 showLabel: true onRow: row.

rowTitles := {rowTitleP3.rowTitleS3.rowTitleP5.rowTitleS5.rowTitleP53.rowTitleE2.rowTitleP2.rowTitleS2.rowTitleP25.rowTitleP23}.
bars := {shapesP3.shapesS3.shapesP5.shapesS5.shapesP53.shapesE2.shapesP2.shapesS2.shapesP25.shapesP23} flattened.

"Stick the row titles to the left of the bars"
RSLocation new left; outer; offset: -50@0; stick: rowTitles asGroup on: bars asGroup.

^{rowTitles.bars}

]

{ #category : #drawing }
SpPresenterHeadlineChart >> drawOnCanvas: aCanvas [
"(self legendTeams container: aCanvas) build."
aCanvas addAll: self createShapes.
aCanvas @ RSCanvasController
]

{ #category : #tuning }
SpPresenterHeadlineChart >> floatingStatisticOffset [
^10
]

{ #category : #tuning }
SpPresenterHeadlineChart >> floatingThumbOffset [
^20
]

{ #category : #accessing }
SpPresenterHeadlineChart >> gameNumber [

	^ gameNumber
]

{ #category : #accessing }
SpPresenterHeadlineChart >> gameNumber: anObject [

	gameNumber := anObject
]

{ #category : #generating }
SpPresenterHeadlineChart >> heading: aString onRow: aRowNumber [ 
^RSLabel new
	text: aString;
	fontSize: self rowHeadingFontSize;
	translateMiddleRightTo: 0@(aRowNumber-1*self barHeight);
	yourself
]

{ #category : #initialization }
SpPresenterHeadlineChart >> initializePresenters [
| rp |
rp := self instantiate: SpRoassalPresenter.
rp script: [ :canvas | self drawOnCanvas: canvas ].
self layout: (SpBoxLayout newLeftToRight hAlignStart
	add: rp withConstraints: [ :c | c width: 1800 ];
	yourself)
]

{ #category : #accessing }
SpPresenterHeadlineChart >> matchState [

	^ matchState
]

{ #category : #accessing }
SpPresenterHeadlineChart >> matchState: anObject [

	matchState := anObject
]

{ #category : #tuning }
SpPresenterHeadlineChart >> numberFontSize [
^12
]

{ #category : #drawing }
SpPresenterHeadlineChart >> openBallonTextWindow: aPresentableStatistic [
(FMRDocument new
	title: 'Headline Bar';
	documentString: (self statisticsGenerator printSummaryForGame: aPresentableStatistic gameNumber);
	extent: 1400@700)
		openTextWindow 



]

{ #category : #drawing }
SpPresenterHeadlineChart >> printRatioAsPercentage: aPS [
"Only print the % if the bar is wide enough contain it"

^aPS getResult result second > 2
	ifTrue: [ aPS getResult printRatioAsPercentage  ]
	ifFalse: [ '' ]
]

{ #category : #tuning }
SpPresenterHeadlineChart >> rowHeadingFontSize [
^12
]

{ #category : #tuning }
SpPresenterHeadlineChart >> scale [ 
^10
]

{ #category : #generating }
SpPresenterHeadlineChart >> shapesForConfigured: aPS result: n showLabel: aBoolean onRow: row [
| barWidth barText teamSign popup bar statistic floatingStatisticLabel floatingStatisticLocation icon floatingThumb |

statistic := aPS getResult primitiveResults at: n.
barText := RSLabeled new fontSize: self barTextFontSize.
barText shapeBuilder textBlock: [ :ps | aBoolean ifTrue: [ self barTextFor: ps ] ifFalse: ['']].
barWidth := statistic * self scale.
teamSign := #(1 -1) at: aPS teamNumber.
barText location middle offset: barWidth/2-16*teamSign@0.
popup := RSPopup text: (aPS statisticBalloonTexts withNoLineLongerThan: 50).

bar := RSBox new
	model: aPS;
	color: (self matchState colourForTeam: aPS teamNumber inGame: aPS gameNumber);
	size: barWidth@self barHeight;
	translateTo: (barWidth / 2 * teamSign negated)@(row - 1 * self barHeight);
	border: (RSBorder new width: 1; color: Color black);
	@ barText;
	@ popup;
	when: RSMouseClick do: [ :event | self openBallonTextWindow: event shape model ];
	yourself.

floatingStatisticLabel := RSLabel new text: statistic asString; fontSize: self numberFontSize.
floatingStatisticLocation := aPS teamNumber = 1 ifTrue: [ RSLocation new left ] ifFalse: [ RSLocation new right ].
floatingStatisticLocation
	outer;
	offset: (self floatingStatisticOffset*teamSign negated)@0;
	stick: floatingStatisticLabel on: bar.

icon := self iconNamed: (#(#thumbsDown #blank #thumbsUp) at: aPS getDelta sign + 2).
floatingThumb := RSBitmap new form: icon.

floatingStatisticLocation
	offset: (self floatingStatisticOffset + self floatingThumbOffset * teamSign negated)@0;
	stick: floatingThumb on: bar.

^{bar.floatingStatisticLabel.floatingThumb}




]

{ #category : #generating }
SpPresenterHeadlineChart >> statisticAt: aPresentableStatisticClass [
^(self statisticsGenerator at: aPresentableStatisticClass) copy
	gameNumber: self gameNumber;
	teamNumber: self teamNumber;
	yourself.

]

{ #category : #accessing }
SpPresenterHeadlineChart >> statisticsGenerator [

^statisticsGenerator ifNil: [ statisticsGenerator := self matchState statisticsGenerator beForHeadlineChart generate ]
]

{ #category : #accessing }
SpPresenterHeadlineChart >> statisticsGenerator: anObject [

	statisticsGenerator := anObject
]

{ #category : #tuning }
SpPresenterHeadlineChart >> teamNameFontSize [
^14
]

{ #category : #accessing }
SpPresenterHeadlineChart >> teamNumber [

	^ teamNumber
]

{ #category : #accessing }
SpPresenterHeadlineChart >> teamNumber: anObject [

	teamNumber := anObject
]
