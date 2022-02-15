Class {
	#name : #CommandLine,
	#superclass : #MatchplayEvent,
	#category : #FMR
}

{ #category : #'instance initialization' }
CommandLine >> arguments [
^((self detail ifNil: [ '' ]) tokensBasedOn: ',') collect: [ :e | e trim ]
]

{ #category : #printing }
CommandLine >> colour [

^FMRColour neutralColour
]

{ #category : #access }
CommandLine >> commandName [ 
^self representation
]

{ #category : #commands }
CommandLine >> command_table [
"Slot the new table args into their respective locations
	table[Leonhart,green,black]		"

self matchState table updateFrom: self arguments
]

{ #category : #commands }
CommandLine >> command_teams [
"Plug the team names ino their respective locations
	teams[Fred & Joe,Mary & Keith]		"

self matchState teamOne teamName: self arguments first.
self matchState teamTwo teamName: self arguments second.

]

{ #category : #accessing }
CommandLine >> duration [
^nil
]

{ #category : #'instance initialization' }
CommandLine >> fromString: aString [
| commandAndArgs |

"Find the command arguments"
commandAndArgs := aString tokensBasedOn: '[]'.

"Store the cleaned command in the representation"
self representation: (commandAndArgs first reject: [ :e | e = $ ]).

"Store the cleaned optional arguments in the detail"
commandAndArgs size > 1 ifTrue: [ self detail: commandAndArgs second ]

]

{ #category : #access }
CommandLine >> gameNumber [
^0
]

{ #category : #testing }
CommandLine >> isCommandLine [
^true
]

{ #category : #testing }
CommandLine >> isMatchplayEvent [
"Instances of some subclasses aren't actually events in the match but meta-events"
^false
]

{ #category : #printing }
CommandLine >> printCurrentScore [
^''
]

{ #category : #'UI - graphics' }
CommandLine >> shouldShowLine [
"By default, only show a line if the receiver has detail"

^false
]

{ #category : #access }
CommandLine >> teamWithPossession [
"Answer the team which has possession during this event
	- consider the parity of the possession flips in my parent's matchplay events"
	
^nil
]
