Class {
	#name : #PSMatchIntensityTimeInTransition,
	#superclass : #'PSMatchIntensity_',
	#category : #FMR
}

{ #category : #generation }
PSMatchIntensityTimeInTransition >> computeResult [
"Answer a duration, the amount of time that the the ball is in Active Play but not in possession of any rod, i.e. the time in transition
	- this is the total time recorded for the duration of all of the Possession Flip events"

^self scanner scan lastSequenceTotalDuration
]

{ #category : #UI }
PSMatchIntensityTimeInTransition >> displayResult: aMatchResult [
"Override me"

^aMatchResult prettyPrintToRoundedSeconds
]

{ #category : #generation }
PSMatchIntensityTimeInTransition >> extractScannerResult [
"Answer a duration, the amount of time that the the ball is in Active Play but not in possession of any rod, i.e. the time in transition
	- this is the total time recorded for the duration of all of the Possession Flip events"

^self scanner lastSequenceTotalDuration
]

{ #category : #generation }
PSMatchIntensityTimeInTransition >> sequence [
^'.'
]

{ #category : #UI }
PSMatchIntensityTimeInTransition >> statisticBalloonMacro [
^'During <g> the ball was in transition between the rods for <s>.'
]

{ #category : #UI }
PSMatchIntensityTimeInTransition >> statisticName [
^'Time in transition'
]

{ #category : #UI }
PSMatchIntensityTimeInTransition >> statisticNameBalloonText [
^'The Time in Transition is the total amount of time that the the ball is in Active Play but not under possession by any rod.

This is computed as the total time recorded for the duration of all of the Possession Change events. For expert players the value is generally expected to be quite low. High values could indicate mistakes in the matchplay recording caused by prematurely typing the Possession Change character (.), and so this statistic is also a measure of matchplay recording fidelity.'
]
