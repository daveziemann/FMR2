Class {
	#name : #FMRGrowlMorph,
	#superclass : #GrowlMorph,
	#classVars : [
		'ShouldGrowlDebuggingMessages'
	],
	#category : #FMR
}

{ #category : #API }
FMRGrowlMorph class >> growlDebugFor: label message: aString [
self shouldGrowlDebuggingMessages ifTrue: [ 
	self
		openWithLabel: 'FMR Debugging - ',label
		contents: aString value
		color: Color blue ]
]

{ #category : #API }
FMRGrowlMorph class >> growlErrorFor: label message: aString [

self
	openWithLabel: 'FMR Error - ',label
	contents: aString
	color: Color red
]

{ #category : #API }
FMRGrowlMorph class >> growlProgressFor: label message: aString [

self
	openWithLabel: 'FMR Progress - ',label
	contents: aString
	color: Color green muchDarker
]

{ #category : #API }
FMRGrowlMorph class >> growlWarningFor: label message: aString [

self
	openWithLabel: 'FMR Warning - ',label
	contents: aString
	color: FMRColour yellow
]

{ #category : #settings }
FMRGrowlMorph class >> messageSettingsOn: aBuilder [
<fmrsettings>
(aBuilder group: #messages)
	label: 'Messages';  
	description: 'All settings concerned with Statistics generation and UI';
	with: [
		(aBuilder setting: #shouldGrowlDebuggingMessages)
			label: 'Show debugging messages?'; 
			target: self;
			default: self shouldGrowlDebuggingMessagesDefault;
			description: 'Show debugging messages or not'.
		]

		
]

{ #category : #accessing }
FMRGrowlMorph class >> shouldGrowlDebuggingMessages [

^ShouldGrowlDebuggingMessages ifNil: [ self shouldGrowlDebuggingMessagesDefault ]
]

{ #category : #accessing }
FMRGrowlMorph class >> shouldGrowlDebuggingMessages: anObject [

	ShouldGrowlDebuggingMessages := anObject
]

{ #category : #accessing }
FMRGrowlMorph class >> shouldGrowlDebuggingMessagesDefault [

^false
]

{ #category : #default }
FMRGrowlMorph >> defaultVanishDelay [
^2 seconds
]

{ #category : #initialization }
FMRGrowlMorph >> initialize [
super initialize.
self class position: #topRight.
]
