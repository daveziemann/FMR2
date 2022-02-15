Class {
	#name : #TeamEvent,
	#superclass : #MatchplayEvent,
	#instVars : [
		'sideIndicated'
	],
	#category : #FMR
}

{ #category : #'UI - graphics' }
TeamEvent >> boxColour [
"Answer the colour for the box, generally the colour of the owning event, except all pauses are neutral"

^FMRColour neutralColour
]

{ #category : #printing }
TeamEvent >> colour [ 

^self side colour
]

{ #category : #printing }
TeamEvent >> printRep [
^self sideIndicator asText,self representation asText
]

{ #category : #'UI - graphics' }
TeamEvent >> shouldShowLine [
^true
]

{ #category : #access }
TeamEvent >> side [ 
"TeamEvents can be created during active play recording and during pauses in active play 
	- during active play the side with possession is the relevant side
	- during a pause the side is indicated specifically"
	
^self sideIndicated ifNil: [ self sideWithPossession ]
]

{ #category : #accessing }
TeamEvent >> sideIndicated [

	^ sideIndicated
]

{ #category : #accessing }
TeamEvent >> sideIndicated: anObject [

	sideIndicated := anObject
]

{ #category : #printing }
TeamEvent >> sideIndicator [
^self sideIndicated
	ifNil: [ '' ]
	ifNotNil: [ :side | side sideIndicator ]
]

{ #category : #accessing }
TeamEvent >> teamLeft [ 
"Answer the team playing the left side of the table during this event"

^self matchState teamLeft
]

{ #category : #accessing }
TeamEvent >> teamRight [
"Answer the team playing the left side of the table during this event"

^self matchState teamRight
]

{ #category : #access }
TeamEvent >> teamWithOwnership [
"Answer the team that 'owns' the event - for Team events it's the team on the indicated side"

^self matchState teamOnSide: self side atEvent: self

]
