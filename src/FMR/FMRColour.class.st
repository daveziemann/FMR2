Class {
	#name : #FMRColour,
	#superclass : #FMRObject,
	#category : #FMR
}

{ #category : #colours }
FMRColour class >> black [ 
"Answer FMR black"

^self colorFromColourName: '1A1A1A'
]

{ #category : #colours }
FMRColour class >> blue [ 
"Answer FMR blue"

^self colorFromColourName: '2166AC'
]

{ #category : #colours }
FMRColour class >> brown [ 
"Answer FMR brown"

^self colorFromColourName: '8C510A'
]

{ #category : #API }
FMRColour class >> colorFromColourName: aColorName [

^(self respondsTo: aColorName asSymbol)
	ifTrue: [ aColorName asSymbol value: self ]
	ifFalse: [ Color colorFrom: aColorName ]
]

{ #category : #colours }
FMRColour class >> green [ 
"Answer FMR green"

^self colorFromColourName: '006837'
]

{ #category : #colours }
FMRColour class >> neutralColour [
^self brown
]

{ #category : #colours }
FMRColour class >> neutralColour: teamNumber [
^{self brown.self purple} at: teamNumber
]

{ #category : #colours }
FMRColour class >> purple [ 
"Answer FMR brown"

^self colorFromColourName: '8E0152'
]

{ #category : #colours }
FMRColour class >> red [ 
"Answer FMR red"

^self colorFromColourName: 'D7191C'
]

{ #category : #colours }
FMRColour class >> yellow [
"Answer the FMR colour called yellow, which is easier to read than regular yellow"

^Color r: 0.7839687194525904 g: 0.7644183773216031 b: 0.08895405669599218 alpha: 1.0
]
