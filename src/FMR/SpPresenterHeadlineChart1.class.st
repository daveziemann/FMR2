Class {
	#name : #SpPresenterHeadlineChart1,
	#superclass : #'SpPresenterFMR_',
	#instVars : [
		'matchState',
		'statisticsGenerator',
		'gameNumber'
	],
	#category : #FMR
}

{ #category : #generating }
SpPresenterHeadlineChart1 >> barHeight [
^30
]

{ #category : #drawing }
SpPresenterHeadlineChart1 >> barTextFor: aPS [

^aPS getResult primitiveResults size = 2
	ifTrue: [ self printRatioAsPercentage: aPS ]
	ifFalse: [ '' ]
]

{ #category : #generating }
SpPresenterHeadlineChart1 >> createShapes [
| shapeTeam1 shapeTeam2 ps shapes shapesP3 shapesS3 shapesP5 shapesP53 shapesP2 shapesS2 shapesE2 rowTitleP3 rowTitleS3 rowTitleP5 rowTitleP53 rowTitleE2 rowTitleP2 rowTitleS2 rowTitles bars rowTitleP25 shapesP25 rowTitleP23 shapesP23 rowTitleS5 shapesS5 row |

row := 3.
ps := self statisticsGenerator at: PSPossessionCountOn3Rod.
rowTitleP3 := self title: ps statisticName onRow: row.
shapesP3 := self shapesFor: ps result: 1 showLabel: false onRow: row.

shapeTeam1 := RSLabel new
	text: self matchState teamOne teamName;
	fontSize: 14;
	yourself.
shapeTeam2 := RSLabel new
	text: self matchState teamTwo teamName;
	fontSize: 14;
	yourself.
RSLocation new	above; right; offset: 10@(-20); stick: shapeTeam2 on: shapesP3 first.
RSLocation new above; left; offset: -10@(-20); stick: shapeTeam1 on: shapesP3 fourth.

row := row+1.
ps := self statisticsGenerator at: PSScoringFrom3Rod.
rowTitleS3 := self title: ps statisticName2 onRow: row.
shapesS3 := self shapesFor: ps result: 2 showLabel: true onRow: row.

row := row+2.
ps := self statisticsGenerator at: PSPossessionCountOn5Rod.
rowTitleP5 := self title: ps statisticName onRow: row.
shapesP5 := self shapesFor: ps result: 1 showLabel: false onRow: row.

row := row+1.
ps := self statisticsGenerator at: PSPassingSuccess5To3.
rowTitleP53 := self title: ps statisticName2 onRow: row.
shapesP53 := self shapesFor: ps result: 2 showLabel: true onRow: row.

row := row+1.
ps := self statisticsGenerator at: PSScoringFrom5Rod.
rowTitleS5 := self title: ps statisticName2 onRow: row.
shapesS5 := self shapesFor: ps result: 2 showLabel: true onRow: row.

row := row+2.
ps := self statisticsGenerator at: PSRetainOn2Rod.
rowTitleE2 := self title: ps statisticName1 onRow: row.
shapesE2 := self shapesFor: ps result: 1 showLabel: false onRow: row. 

row := row+1.
rowTitleP2 := self title: ps statisticName2 onRow: row.
shapesP2 := self shapesFor: ps result: 2 showLabel: true onRow: row.

row := row+1.
ps := self statisticsGenerator at: PSScoringFrom2Rod.
rowTitleS2 := self title: ps statisticName2 onRow: row.
shapesS2 := self shapesFor: ps result: 2 showLabel: false onRow: row.

row := row+1.
ps := self statisticsGenerator at: PSPassingSuccess2To3.
rowTitleP23 := self title: ps statisticName2 onRow: row.
shapesP23 := self shapesFor: ps result: 2 showLabel: true onRow: row.

row := row+1.
ps := self statisticsGenerator at: PSPassingSuccess2To5.
rowTitleP25 := self title: ps statisticName2 onRow: row.
shapesP25 := self shapesFor: ps result: 2 showLabel: true onRow: row.

rowTitles := {rowTitleP3.rowTitleS3.rowTitleP5.rowTitleS5.rowTitleP53.rowTitleE2.rowTitleP2.rowTitleS2.rowTitleP25.rowTitleP23}.
bars := {shapesP3.shapesS3.shapesP5.shapesS5.shapesP53.shapesE2.shapesP2.shapesS2.shapesP25.shapesP23} flattened.

"Stick the row titles to the left of the bars"
RSLocation new left; outer; offset: -50@0; stick: rowTitles asGroup on: bars asGroup.

shapes := OrderedCollection new
	add: shapeTeam1;
	add: shapeTeam2;
	addAll: rowTitles;
	addAll: bars;
	yourself.

^shapes




]

{ #category : #drawing }
SpPresenterHeadlineChart1 >> drawOnCanvas: aCanvas [
aCanvas addAll: self createShapes.
aCanvas @ RSCanvasController
]

{ #category : #accessing }
SpPresenterHeadlineChart1 >> gameNumber [

	^ gameNumber
]

{ #category : #accessing }
SpPresenterHeadlineChart1 >> gameNumber: anObject [

	gameNumber := anObject
]

{ #category : #initialization }
SpPresenterHeadlineChart1 >> initializePresenters [
| rp |
rp := self instantiate: SpRoassalPresenter.
rp script: [ :canvas | self drawOnCanvas: canvas ].
self layout: (SpBoxLayout newLeftToRight hAlignStart
	add: rp withConstraints: [ :c | c width: 1800 ];
	yourself)
]

{ #category : #tuning }
SpPresenterHeadlineChart1 >> labelFontSize [
^10
]

{ #category : #tuning }
SpPresenterHeadlineChart1 >> lineOffset [
^200
]

{ #category : #accessing }
SpPresenterHeadlineChart1 >> matchState [

	^ matchState
]

{ #category : #accessing }
SpPresenterHeadlineChart1 >> matchState: anObject [

	matchState := anObject
]

{ #category : #tuning }
SpPresenterHeadlineChart1 >> numberFontSize [
^12
]

{ #category : #drawing }
SpPresenterHeadlineChart1 >> openBallonTextWindow: aPS [
(FMRDocument new
	title: 'Headline Bar';
	documentString: aPS statisticBalloonTexts)
		openTextWindow



]

{ #category : #drawing }
SpPresenterHeadlineChart1 >> printRatioAsPercentage: aPS [
"Only print the % if the bar is wide enough contain it"

^aPS getResult result second > 2
	ifTrue: [ aPS getResult printRatioAsPercentage  ]
	ifFalse: [ '' ]
]

{ #category : #tuning }
SpPresenterHeadlineChart1 >> scale [ 
^10
]

{ #category : #generating }
SpPresenterHeadlineChart1 >> shapeForTeamNumber: aTeamNumber onRow: aRowNumber [
| teamSign |

teamSign := #(1 -1) at: aTeamNumber.
^RSLabel new
	text: (self matchState teams at: aTeamNumber) teamName;
	fontSize: 12;
	translateTo: (0*teamSign negated)@(aRowNumber-1*self barHeight);
	yourself
]

{ #category : #generating }
SpPresenterHeadlineChart1 >> shapesFor: aPS result: n showLabel: aBoolean onRow: row [
^OrderedCollection new
	addAll: (self shapesForConfigured: (aPS copy gameNumber: self gameNumber; teamNumber: 1) result: n showLabel: aBoolean onRow: row);
	addAll: (self shapesForConfigured: (aPS copy gameNumber: self gameNumber; teamNumber: 2) result: n showLabel: aBoolean onRow: row);
	yourself
]

{ #category : #generating }
SpPresenterHeadlineChart1 >> shapesForConfigured: aPS result: n showLabel: aBoolean onRow: row [
| barWidth barText teamSign popup bar statistic floatingStatisticLabel floatingStatisticLocation icon floatingThumb floatingStatisticOffset floatingThumbOffset |

statistic := aPS getResult primitiveResults at: n.
barText := RSLabeled new fontSize: self labelFontSize.
barText shapeBuilder textBlock: [ :ps | aBoolean ifTrue: [ self barTextFor: ps ] ifFalse: ['']].
barWidth := statistic * self scale.
teamSign := #(1 -1) at: aPS teamNumber.
barText location middle offset: barWidth/2-16*teamSign@0.
popup := RSPopup text: (aPS statisticBalloonTexts withNoLineLongerThan: 50).

bar := RSBox new
	model: aPS;
	color: (self matchState colourForTeam: aPS teamNumber inGame: aPS gameNumber);
	size: barWidth@self barHeight;
	translateTo: (barWidth/2*teamSign negated+self lineOffset)@(row-1 * self barHeight);
	border: (RSBorder new width: 1; color: Color black);
	@ barText;
	@ popup;
	when: RSMouseClick do: [ :event | self openBallonTextWindow: event shape model ];
	yourself.

floatingStatisticOffset := 10.
floatingStatisticLabel := RSLabel new text: statistic asString; fontSize: self numberFontSize.
floatingStatisticLocation := aPS teamNumber = 1 ifTrue: [ RSLocation new left ] ifFalse: [ RSLocation new right ].
floatingStatisticLocation
	outer;
	offset: (floatingStatisticOffset*teamSign negated)@0;
	stick: floatingStatisticLabel on: bar.

icon := self iconNamed: (#(#thumbsDown #blank #thumbsUp) at: aPS getDelta sign + 2).
floatingThumb := RSBitmap new form: icon.
floatingThumbOffset := 20.
floatingStatisticLocation
	offset: (floatingStatisticOffset+floatingThumbOffset*teamSign negated)@0;
	stick: floatingThumb on: bar.

^{bar.floatingStatisticLabel.floatingThumb}




]

{ #category : #accessing }
SpPresenterHeadlineChart1 >> statisticsGenerator [

^statisticsGenerator ifNil: [ statisticsGenerator := self matchState statisticsGenerator generate ]
]

{ #category : #accessing }
SpPresenterHeadlineChart1 >> statisticsGenerator: anObject [

	statisticsGenerator := anObject
]

{ #category : #generating }
SpPresenterHeadlineChart1 >> title: aString onRow: aRowNumber [ 
^RSLabel new
	text: aString;
	fontSize: 12;
	translateMiddleRightTo: 0@(aRowNumber-1*self barHeight);
	yourself
]
