Class {
	#name : #PSLeadSwing,
	#superclass : #'PSTable_',
	#category : #FMR
}

{ #category : #UI }
PSLeadSwing >> displayResult: aTeamResult [
"Override me"

^aTeamResult printAsNumber
]

{ #category : #generation }
PSLeadSwing >> extractScannerResult [

^self scanner leadSwingTally
]

{ #category : #generation }
PSLeadSwing >> sequence [
"Overidden when needed"

^'#'
]

{ #category : #UI }
PSLeadSwing >> statisticBalloonMacro [
^'In <g> <tt> took the lead from <ot> <s> times.'

]

{ #category : #UI }
PSLeadSwing >> statisticCategory [ 
^'Goals Scored'
]

{ #category : #UI }
PSLeadSwing >> statisticCategoryBalloonText [
^'How often did the lead swing from one team to the other?'
]

{ #category : #UI }
PSLeadSwing >> statisticName [
^'Lead swing'
]

{ #category : #UI }
PSLeadSwing >> statisticNameBalloonText [
^'How many times did the team take the lead?'
]
