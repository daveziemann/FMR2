Class {
	#name : #SpPresenterMetaPossessionPassingSuccess,
	#superclass : #SpPresenterMetaPossessionTimeSuccess,
	#category : #FMR
}

{ #category : #drawing }
SpPresenterMetaPossessionPassingSuccess >> createChart [
| chart lp1 popup plot vertical horizontal successes possessions t |

plot := self trawl.

chart := RSChart new.
lp1 := RSLinePlot new x: (1 to: plot size) y: plot; color: Color red.

popup := RSPopupDecoration new.
chart addDecoration: popup.
popup chartPopupBuilder: (RSBlockChartPopupBuilder new
	rowShapeBlock: [ :thePlot :point |
		RSLabel new text: point y asString,'% success after ',point x asString,'ms'; bold ]).

chart addPlot: lp1.
chart minValueY: self minValue; maxValueY: self maxValue.

vertical := RSVerticalTick new
	numberOfTicks: 10;
	labelConversion: [ :value | value asString,'%' ]
	yourself.
vertical shape dashed width: 1.
vertical configuration tickSize: chart extent x negated.
chart addDecoration: vertical.

horizontal := RSHorizontalTick new
	numberOfTicks: 18;
	labelConversion: [ :value | (value / 1000) rounded asDuration humanAbbreviatedReadablePrintString ]
	yourself.
horizontal shape width: 1.
horizontal configuration tickSize: chart extent y negated.	
chart addDecoration: horizontal.

successes := (self success collect:[ :e |e value]) sum.
possessions := self success size.
t := '5-rod passing success by time of possession (',successes asString,' passes from ',possessions asString,' possessions = ',(100.0*successes/possessions) rounded asString,'%)'.

chart addDecoration: (RSChartTitleDecoration new fontSize: 8; title: t).
chart addDecoration: (RSYLabelDecoration new title: '5-rod pass success rate'; fontSize: 10).
chart addDecoration: (RSXLabelDecoration new title: '5-rod possession time'; fontSize: 10).

chart build.

^chart
]

{ #category : #drawing }
SpPresenterMetaPossessionPassingSuccess >> maxValue [
^50
]

{ #category : #drawing }
SpPresenterMetaPossessionPassingSuccess >> minValue [
^30
]

{ #category : #drawing }
SpPresenterMetaPossessionPassingSuccess >> statisticClass [
^PSPassingSuccess5To3
]
