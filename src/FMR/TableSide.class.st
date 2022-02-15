Class {
	#name : #TableSide,
	#superclass : #FMRObject,
	#instVars : [
		'sideIndicator',
		'colourName'
	],
	#category : #FMR
}

{ #category : #printing }
TableSide >> asText: aString [
"Answer a Text, the appropriately coloured version of aString"

^aString asText
	addAttribute: (TextColor color: self colour);
	"addAttribute: TextEmphasis bold;"
	yourself

]

{ #category : #accessing }
TableSide >> colour [
^FMRColour colorFromColourName: self colourName
]

{ #category : #accessing }
TableSide >> colourName [

	^ colourName
]

{ #category : #accessing }
TableSide >> colourName: anObject [

	colourName := anObject
]

{ #category : #testing }
TableSide >> isLHS [
^self sideIndicator = $<
]

{ #category : #testing }
TableSide >> isRHS [
^self sideIndicator = $>
]

{ #category : #printing }
TableSide >> printOn: aStream [

aStream
	<< self sideIndicator asText;
	<< (self colourName asText addAttribute: (TextColor color: self colour))
]

{ #category : #accessing }
TableSide >> sideIndicator [

	^ sideIndicator
]

{ #category : #accessing }
TableSide >> sideIndicator: anObject [

	sideIndicator := anObject
]
