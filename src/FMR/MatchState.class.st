Class {
	#name : #MatchState,
	#superclass : #FMRObject,
	#instVars : [
		'table',
		'teams',
		'matchplayEvents',
		'commandProcessor',
		'recordingDate',
		'sourceFileName',
		'statePack',
		'matchplayTimer'
	],
	#classVars : [
		'DirectoryForMatchplayFiles',
		'DirectoryForSystemFiles'
	],
	#category : #FMR
}

{ #category : #date }
MatchState class >> dateFromDayMonthYear: aString [
"Answer the Date represented by aString
	- if it's not valid date then answer nil"

| string array |

string := aString trim.
string size < 4 ifTrue: [ ^nil ].
(string last: 4) isAllDigits ifFalse: [ ^nil ].
(string includesAnyOf: '-. ') ifFalse: [ ^[ string asDate ] onErrorDo: [ :ex | nil ]]. "e.g. 3Apr2021"
array := string substrings: '-. '.
array size = 3 ifFalse: [ ^nil ].
(array allSatisfy: [ :e | e isAllDigits ]) ifFalse: [ ^[ string asDate ] onErrorDo: [ :ex | nil ]]. "e.g. 3-Apr-2021"
^[ Date year: array third asInteger month: array second asInteger day: array first asInteger ] onErrorDo: [  :ex | nil ]. "e.g. 3-4-2021"
]

{ #category : #accessing }
MatchState class >> directoryForMatchplayFiles [

^DirectoryForMatchplayFiles ifNil: [ self directoryForMatchplayFilesDefault ]
]

{ #category : #accessing }
MatchState class >> directoryForMatchplayFiles: anObject [

	DirectoryForMatchplayFiles := anObject
]

{ #category : #configuration }
MatchState class >> directoryForMatchplayFilesDefault [

^'C:\Data\Foosball\FMR\MatchplayFiles'
]

{ #category : #accessing }
MatchState class >> directoryForSystemFiles [

^DirectoryForSystemFiles ifNil: [ self directoryForSystemFilesDefault ]
]

{ #category : #accessing }
MatchState class >> directoryForSystemFiles: anObject [

	DirectoryForSystemFiles := anObject
]

{ #category : #configuration }
MatchState class >> directoryForSystemFilesDefault [

^'C:\Data\Foosball\FMR\System'
]

{ #category : #'instance creation' }
MatchState class >> fromString: aString [
^(aString tokensBasedOn: '\')
	inject: self new
	into: [ :c :e | c processRecordedLine: e ]
]

{ #category : #configuration }
MatchState class >> matchplayFilePrefix [
^'FMR_'
]

{ #category : #settings }
MatchState class >> persistenceSettingsOn: aBuilder [
<fmrsettings>  

(aBuilder group: #fmr)
	label: 'Persistence';  
	description: 'All settings concerned with persistance, e.g. where files are stored';
	with: [
		(aBuilder setting: #directoryForSystemFiles)
			type: #Directory;
			target: self;
			default: self directoryForSystemFilesDefault;
			description: 'The path of a directory where FMR will store system files' ;
			label: 'FMR system files directory'.
		(aBuilder setting: #directoryForMatchplayFiles)
			type: #Directory;
			target: self;
			default: self directoryForMatchplayFilesDefault;
			description: 'The path of a directory where FMR  will store Matchplay recording files' ;
			label: 'Matchplay recording files directory'. ]
]

{ #category : #files }
MatchState class >> readFile [
"Answer a new instance popoulated by reading the specified file"

^self readFileLocation ifNotNil: [ :fileLocation | self readFileNamed: fileLocation ]

]

{ #category : #files }
MatchState class >> readFile: fileName [
"Answer a new instance popoulated by reading the specified file"

^self new readFile: fileName

]

{ #category : #files }
MatchState class >> readFileLocation [

| dialog |

dialog := (FMRFileDialogWindow newWithTheme: UIManager default theme)
	title: 'Choose the FMR matchplay file to read';
	fileNameText: self matchplayFilePrefix;
	answerPathName.
dialog validExtensions: #('txt').
dialog selectPath: self directoryForMatchplayFiles.
^dialog openModal answer ifNotNil: [ :fileLocation |
	fileLocation asFileReference isFile ifTrue: [ fileLocation ]]

]

{ #category : #files }
MatchState class >> readFileNamed: fileName [
"Answer a new instance populated by reading the specified file"

^self new readFileNamed: fileName

]

{ #category : #configuration }
MatchState class >> tableTypesAndColours [
^OrderedCollection new
	add: #('Unknown' #blue #red);
	add: #('Bonzini' #blue #red);
	add: #('Fireball' #black #red);
	add: #('Garlando' #blue #red);
	add: #('Leonhart' #black #green);
	add: #('Roberto' #blue #red);
	add: #('Tornado' #black #yellow);
	yourself
]

{ #category : #'actions - updating' }
MatchState >> addMatchplayEvent: aMatchplayEvent [
"Add a new matchplay event to my record. Answer the previous event whose duration was finalised"
| finalisedEvent |

finalisedEvent := self prepareToAddMatchplayEvent: aMatchplayEvent.
self matchplayEvents addLast: aMatchplayEvent.
"Transcript crShow: 'Added: ',aMatchplayEvent printFully."
FMRGrowlMorph
	growlDebugFor: 'Matchplay Events'
	message: [ 'Added #',self matchplayEvents size asString,': ',aMatchplayEvent printString,' ',aMatchplayEvent score asString ].
^finalisedEvent
]

{ #category : #printing }
MatchState >> areMatchDetailsComplete [

self tournament isEmptyOrNil ifTrue: [ ^false ].
self event isEmptyOrNil ifTrue: [ ^false ].
self match isEmptyOrNil ifTrue: [ ^false ].
self teamOne teamName = 'Team 1' ifTrue: [ ^false ].
self teamTwo teamName = 'Team 2' ifTrue: [ ^false ].
^true
]

{ #category : #'actions - updating' }
MatchState >> cleanMatchplayEventCommandLines [
"Refresh the match details command events in the matchplay events
	- first remove all the match details commands
	- and then add back the refreshed ones at the start of the matchplay events collection"

| newMatchDetails newMatchplayEvents |

newMatchDetails := self matchDetailsCommandsFromStatePack.
newMatchplayEvents := newMatchDetails, (self matchplayEvents reject: [ :eachMatchplayEvent | eachMatchplayEvent isCommandLine ]).
self matchplayEvents removeAll; addAll: newMatchplayEvents.
"Inserting events eans we must clear the event indices"
self flushCaches.
]

{ #category : #files }
MatchState >> cleanseFileName: aString [
^aString copy replaceAll: $/ with: $-
]

{ #category : #UI }
MatchState >> colourForTeam: aTeamNumber inGame: aGameNumber [

^aTeamNumber isZero
	ifTrue: [ FMRColour neutralColour ]
	ifFalse: [ (self sideForTeam: aTeamNumber inGame: aGameNumber)
		ifNil: [ FMRColour neutralColour: aTeamNumber ]
		ifNotNil: [ :side | side colour ]]
]

{ #category : #accessing }
MatchState >> commandProcessor [

^commandProcessor ifNil:[ commandProcessor := CommandProcessor new matchState: self ]
]

{ #category : #accessing }
MatchState >> commandProcessor: anObject [

	commandProcessor := anObject
]

{ #category : #accessing }
MatchState >> comment [
^self statePackAt: #comment
]

{ #category : #accessing }
MatchState >> comment: anObject [
^self statePackAt: #comment put: anObject
]

{ #category : #access }
MatchState >> completedGameScores [

| completedGameScores team1Wins team2Wins result |

completedGameScores := self score gameScores.

"Remove the latest game, which is not a completed game unless the match is over"
self isEndMatch ifFalse: [ completedGameScores removeLast ].
team1Wins := completedGameScores select: [ :e | e team1Score > e team2Score ].
team2Wins := completedGameScores select: [ :e | e team1Score < e team2Score ].

result := Array with: (', ' join: team1Wins) with: (', ' join: team2Wins).

^self sideSwapParity
	ifTrue:[ result reversed ]
	ifFalse:[ result ]
]

{ #category : #access }
MatchState >> currentGameScore [

| pointScore |

pointScore := self score currentGameScore pointScore.
^self sideSwapParity
	ifTrue: [ pointScore reversed ]
	ifFalse: [ pointScore ]

]

{ #category : #'actions - updating' }
MatchState >> deleteLatestMatchplayEvent [

self matchplayEvents removeLast in: [ :gone |
	FMRGrowlMorph
		growlDebugFor: 'Matchplay Events'
		message: [ 'Removed last: ',gone printString ]]
]

{ #category : #configuration }
MatchState >> directoryForMatchplayFiles [

^self class directoryForMatchplayFiles
]

{ #category : #access }
MatchState >> durationSinceLastQuery [
^self matchplayTimer durationSinceLastQuery
]

{ #category : #access }
MatchState >> endGameEvents [
"Answer the End Game events"

^self matchplayEvents select: [ :eachMatchplayEvent | eachMatchplayEvent isEndGame ]
]

{ #category : #accessing }
MatchState >> event [
^self statePackAt: #event
]

{ #category : #accessing }
MatchState >> event: anObject [
^self statePackAt: #event put: anObject
]

{ #category : #actions }
MatchState >> flushCaches [ 
self matchplayEvents do: [ :eachMatchplayEvent | eachMatchplayEvent flushCaches ]
]

{ #category : #access }
MatchState >> gameNumbers [
"Answer the index position of each game, followed by 0 for the match"

^(1 to: self numberOfGames)
	ifEmpty: [ {} ]
	ifNotEmpty: [ :nog | nog,{0} ]
]

{ #category : #testing }
MatchState >> hasGames [
"Answer if I have completed games"

^self numberOfGames > 0
]

{ #category : #initialization }
MatchState >> initialize [
"Create the main state objects, e.g. Team, Table, TableSide instances and the matchplay events collection
	- these instances will get replaced/reconfigured by incoming matchplay events"

self statePack: MatchDetailsPack new.

self teams: (Array
	with: (Team new teamName: 'Team 1')
	with: (Team new teamName: 'Team 2')).
	
self table: (Table new updateFrom: self class tableTypesAndColours first).

self matchplayEvents: OrderedCollection new.
]

{ #category : #testing }
MatchState >> isDoubles [
^self teamOne isDoubles
]

{ #category : #testing }
MatchState >> isEndGame [
"Answer if the latest event is the end of a game"

^self latestMatchplayEventDo: [ :aMatchplayEvent | aMatchplayEvent isEndGame ] ifNone: [ false ] 
]

{ #category : #testing }
MatchState >> isEndMatch [

^self latestMatchplayEventDo: [ :aMatchplayEvent | aMatchplayEvent isEndMatch ] ifNone: [ false ] 
]

{ #category : #testing }
MatchState >> isSideSwap [
"Answer if the teams swapped sides at any point"

^self matchplayEvents anySatisfy: [ :aMatchplayEvent | aMatchplayEvent isSideSwap ] 
]

{ #category : #testing }
MatchState >> isSingles [
^self teamOne isSingles
]

{ #category : #accessing }
MatchState >> lastSaveDate [
^self statePackAt: #lastSaveDate
]

{ #category : #accessing }
MatchState >> lastSaveDate: aDate [
^self statePackAt: #lastSaveDate put: aDate asString
]

{ #category : #access }
MatchState >> latestMatchplayEvent [

^self matchplayEvents
	ifEmpty: []
	ifNotEmpty: [ self matchplayEvents last ]
]

{ #category : #access }
MatchState >> latestMatchplayEventDo: aDoBlock ifNone: aNoneBlock [

^self matchplayEvents
	ifEmpty: aNoneBlock
	ifNotEmpty: [ aDoBlock value: self matchplayEvents last ]
]

{ #category : #access }
MatchState >> latestMatchplayEventThatRecordsDuration [
"Answer the latest matchplay event which records its duration, or nil if none"

self matchplayEvents reverseDo: [ :eachMatchplayEvent |
	eachMatchplayEvent isDurationRecordingEvent ifTrue: [ ^eachMatchplayEvent ]].
^nil
]

{ #category : #access }
MatchState >> latestMatchplayEventWithDuration [
"Answer the latest matchplay event which has a duration, or nil if none"

self matchplayEvents reverseDo: [ :eachMatchplayEvent |
	eachMatchplayEvent duration ifNotNil: [ ^eachMatchplayEvent ]].
^nil
]

{ #category : #printing }
MatchState >> leftSideTeamNameText [

^self sideLeft asText: self teamLeft teamName 

]

{ #category : #accessing }
MatchState >> match [
^self statePackAt: #match
]

{ #category : #accessing }
MatchState >> match: anObject [
^self statePackAt: #match put: anObject
]

{ #category : #accessing }
MatchState >> matchDate [
^self statePackAt: #matchDate
]

{ #category : #accessing }
MatchState >> matchDate: anObject [
^self statePackAt: #matchDate put: anObject
]

{ #category : #printing }
MatchState >> matchDatePrinted [
"If the matchDate, a String, is valid, print it in a standardised format"

self matchDate ifNil: [ ^'' ].
self matchDate = '' ifTrue: [ ^'' ].
^(self class dateFromDayMonthYear: self matchDate)
	ifNil: [ self matchDate ]
	ifNotNil:[ :date | date yyyymmdd ]
]

{ #category : #printing }
MatchState >> matchDescriptionWithTeamName [
"Answer a single line match summary description"

^String streamContents: [ :s |
	s << self matchDescriptionWithoutTeamName; << ', '.
	s << self teamOne teamName; << ' vs '; << self teamTwo teamName ]
]

{ #category : #printing }
MatchState >> matchDescriptionWithoutTeamName [
"Answer a single line match summary description"

^String streamContents: [ :s |
	self tournament ifNotEmpty: [ s << self tournament; << ', ' ].
	self event ifNotEmpty: [ s << self event; << ', ' ].
	self match ifNotEmpty: [ s << self match; << ' on ' ].
	s << self table type ]
]

{ #category : #'command lines' }
MatchState >> matchDetailsCommandsFromStatePack [
"Answer a collection of command lines that when processed would reconstruct my match details"

^self statePack asCommandLineStrings collect: [ :eachString | self newCommandLine: eachString ]
]

{ #category : #printing }
MatchState >> matchDetailsStatus [
"Answer a single line match details status summary"
| t |

t := 'Table type is ',self table asString,'.'.
^self areMatchDetailsComplete
	ifTrue: [ t ]
	ifFalse: [ t,' Match Details are incomplete.' ]
]

{ #category : #printing }
MatchState >> matchProgressSummary [
"Answer a single line match progress summary"

^self
	latestMatchplayEventDo: [ :e | e matchProgressSummary,' on ',self table type ]
	ifNone: [ 'Table type is ',self table type ] 
]

{ #category : #printing }
MatchState >> matchStatusSummary [
"Answer a single line match status summary"

^self latestMatchplayEvent
	ifNil: [ 'Matchplay recording not started' ]
	ifNotNil: [ :lme | lme isEndMatch
		ifTrue: [ 'Matchplay recording complete' ]
		ifFalse: [ lme explainEventWithDetail ]]
]

{ #category : #accessing }
MatchState >> matchplayEvents [

	^ matchplayEvents
]

{ #category : #accessing }
MatchState >> matchplayEvents: anObject [

	matchplayEvents := anObject
]

{ #category : #accessing }
MatchState >> matchplayTimer [

^matchplayTimer ifNil: [ matchplayTimer := MatchplayTimer new ]
]

{ #category : #accessing }
MatchState >> matchplayTimer: anObject [

	matchplayTimer := anObject
]

{ #category : #'command lines' }
MatchState >> newCommandLine: aString [
"Answer a new CommandLine created from aString"

^self commandProcessor newCommandLine fromString: aString
]

{ #category : #actions }
MatchState >> newMatchScore [
^MatchScore new matchState: self
]

{ #category : #access }
MatchState >> numberOfGames [
^self latestMatchplayEvent
	ifNil: [ 0 ]
	ifNotNil: [ :lme | lme gameNumber ]
]

{ #category : #UI }
MatchState >> open [
^SpPresenterFMRMain openOn: self
]

{ #category : #actions }
MatchState >> openWebBrowserOnURLChart [

"A weird bug. Some URLs get corrupted if there isn't a space at the end"
self urlChart ifNotNil: [ self urlChart ifNotEmpty: [ WebBrowser openOn: self urlChart,' ' ]]
]

{ #category : #actions }
MatchState >> openWebBrowserOnURLVideo [

"A weird bug. Some URLs get corrupted if there isn't a space at the end"
self urlVideo ifNotNil: [ self urlVideo ifNotEmpty: [ WebBrowser openOn: self urlVideo,' ' ]]
]

{ #category : #access }
MatchState >> otherTeam: aTeam [

^self teamOne = aTeam
	ifTrue: [ self teamTwo ]
	ifFalse: [ self teamOne ]
]

{ #category : #access }
MatchState >> pointTarget [
"Answer the game point target
	- FMR doesn't know what the game point target actually is, so infer it from the score at the end of the first game"

^self matchplayEvents
	detect: [ :eachMatchplayEvent | eachMatchplayEvent isEndGame ]
	ifFound: [ :firstEndGame | firstEndGame score lastCompletedGameScore maximum ]
	ifNone: []
]

{ #category : #access }
MatchState >> positionSwapParityForTeam: aTeam atEvent: aMatchplayEvent [
| parityFlip |

parityFlip := false.
self matchplayEvents do: [ :eachMatchplayEvent |
	(eachMatchplayEvent isPositionSwap and: [ eachMatchplayEvent teamWithOwnership = aTeam ])
		ifTrue: [ parityFlip := parityFlip not ].
	eachMatchplayEvent == aMatchplayEvent ifTrue: [ ^parityFlip ]].
^parityFlip

]

{ #category : #access }
MatchState >> possessionFlipParityAtEvent: aMatchplayEvent [
| parityFlip |

parityFlip := false.
self matchplayEvents do: [ :eachMatchplayEvent |
	eachMatchplayEvent isPossessionFlip ifTrue: [ parityFlip := parityFlip not ].
	eachMatchplayEvent == aMatchplayEvent ifTrue: [ ^parityFlip ]].
^parityFlip

]

{ #category : #'actions - updating' }
MatchState >> prepareToAddMatchplayEvent: newMatchplayEvent [
"We are about to add newMatchplayEvent; answer the previous event whose duration was finalised"

^newMatchplayEvent prepareToAdd

]

{ #category : #UI }
MatchState >> printHeadingForGame: aGameNumber [

^aGameNumber isZero
		ifTrue: [ 'Match ', self score printCompletedMatchScore ]
		ifFalse: [ 'Game ', aGameNumber asString,' ',(self score gameScores at: aGameNumber) asString ]
]

{ #category : #printing }
MatchState >> printOn: aStream [

aStream
	<< 'a MatchState with ';
	<< self matchplayEvents size asString;
	<< ' events'
]

{ #category : #'actions - updating' }
MatchState >> processRecordedLine: line [

self commandProcessor processRecordedLine: line
]

{ #category : #files }
MatchState >> readFile: aFileReference [
"Populate the receiver, a new instance, with the events from the specified file, and set the source file name"

self sourceFileName: aFileReference fullName.
self readFromString: aFileReference readStream contents.
]

{ #category : #files }
MatchState >> readFileNamed: fileName [
"Populate the receiver, a new instance, with the events from the specified file, and set the source file name"

self readFile: (self resolveFile: fileName)
]

{ #category : #files }
MatchState >> readFromString: aString [
"Populate the receiver, a new instance, with the events from the specified string"

self commandProcessor processRecordedString: aString
]

{ #category : #accessing }
MatchState >> recorder [
^self statePackAt: #recorder
]

{ #category : #accessing }
MatchState >> recorder: anObject [
^self statePackAt: #recorder put: anObject
]

{ #category : #'actions - updating' }
MatchState >> recordingComplete [
"The match recording is complete"

self version: SpPresenterFMRMain versionNumber.
self recordingDate: Date today.
self cleanMatchplayEventCommandLines.
]

{ #category : #accessing }
MatchState >> recordingDate [

	^ recordingDate
]

{ #category : #accessing }
MatchState >> recordingDate: anObject [
^self statePackAt: #recordingDate put: anObject
]

{ #category : #accessing }
MatchState >> representation [ 
^Character cr
]

{ #category : #files }
MatchState >> resolveFile: fileName [

^self directoryForMatchplayFiles asFileReference / fileName

]

{ #category : #actions }
MatchState >> restartRecording [
"Restart recording - throw away all events that are not Commands"

self matchplayEvents removeAllSuchThat: [ :eachEvent | eachEvent isCommandLine not ]
]

{ #category : #printing }
MatchState >> rightSideTeamNameText [

^self sideRight asText: self teamRight teamName 

]

{ #category : #files }
MatchState >> saveFile [
"Save the receiver without prompting the user 
	- if there is no source file name then save the receiver back into the same file that it came from
	- if there is no source file name then use the suggestedFileName"

self sourceFileName
	ifNil: [ self writeFileNamed: self suggestedFileName ]
	ifNotNil: [ self writeFileNamed: self sourceFileName ].

]

{ #category : #'files with UI' }
MatchState >> saveFileAs [
"Prompt the user to save the receiver using the suggested file name"

^self saveFileAs: self suggestedFileName
]

{ #category : #'files with UI' }
MatchState >> saveFileAs: aFileName [
"Prompt the user to save the receiver using the suggested file name
	- it the file name is empty then the user sees all the existing files"

^(self saveFileLocation: aFileName)
	ifNotNil: [ :fileLocation | self writeFileNamed: fileLocation fullName ]
]

{ #category : #'files with UI' }
MatchState >> saveFileLocation: fileNameSuggestion [
"Prompt the user to save the receiver using the suggested file name
	- it the file name is empty then the user sees all the existing files"

| path pathFileReference dialog |

path := self directoryForMatchplayFiles.
pathFileReference := path asFileReference.
dialog := (FMRFileDialogWindow newWithTheme: UIManager default theme)
	title: 'Choose the location to write the FMR match file';
	fileNameText: fileNameSuggestion;
	answerSaveFile.
dialog validExtensions: #('txt').
dialog selectPath: path.
^dialog openModal answer
]

{ #category : #statistics }
MatchState >> score [
^self scoreAtEvent: self latestMatchplayEvent
]

{ #category : #statistics }
MatchState >> scoreAtEvent: aMatchplayEvent [
| score |

score := self newMatchScore.
self matchplayEvents do: [ :eachMatchplayEvent |
	eachMatchplayEvent adjustScore: score.
	eachMatchplayEvent == aMatchplayEvent ifTrue: [ ^score ]].
^score
		 
]

{ #category : #'actions - updating' }
MatchState >> setTableType: tableSpec [

self statePackAt: #table put: tableSpec.
self table updateFrom: (tableSpec tokensBasedOn: ',')

]

{ #category : #UI }
MatchState >> sideForTeam: aTeamNumber inGame: aGameNumber [
"Answer the side the specifed team was playing on during the specified game
	- if there was no side-swapping then Team 1 played on the Left side for all games
	- if there was side-swapping then Team 1 played on the Left side every other game
		- in this case for game 0 (the match) there is no definitive side, so answer nil
		- assumes that side-swapping occurred after every game"

^self isSideSwap
	ifTrue: [
		aGameNumber isZero ifFalse: [ 
			aGameNumber even
				ifTrue: [ self table sides at: 3 - aTeamNumber ]
				ifFalse: [ self table sides at: aTeamNumber ]]]
	ifFalse: [ self table sides at: aTeamNumber ]
]

{ #category : #access }
MatchState >> sideLeft [

^self table sideLeft
]

{ #category : #access }
MatchState >> sideRight [

^self table sideRight
]

{ #category : #access }
MatchState >> sideSwapParity [
"Answer the current side swap parity. False means Team1 on left"

^self sideSwapParityAtEvent: self latestMatchplayEvent
]

{ #category : #access }
MatchState >> sideSwapParityAtEvent: aMatchplayEvent [
| parityFlip |

parityFlip := false.
self matchplayEvents do: [ :eachMatchplayEvent |
	eachMatchplayEvent isSideSwap ifTrue: [ parityFlip := parityFlip not ].
	eachMatchplayEvent == aMatchplayEvent ifTrue: [ ^parityFlip ]].
^parityFlip

]

{ #category : #access }
MatchState >> sideWithPossession [

^self sideWithPossessionInEvent: self latestMatchplayEvent
]

{ #category : #access }
MatchState >> sideWithPossessionInEvent: aMatchplayEvent [

^(self possessionFlipParityAtEvent: aMatchplayEvent)
	ifTrue:[ self table sideRight ]
	ifFalse: [ self table sideLeft ]
]

{ #category : #files }
MatchState >> sourceFileName [

	^ sourceFileName
]

{ #category : #files }
MatchState >> sourceFileName: anObject [

	sourceFileName := anObject
]

{ #category : #accessing }
MatchState >> statePack [

	^ statePack
]

{ #category : #accessing }
MatchState >> statePack: anObject [

	statePack := anObject
]

{ #category : #accessing }
MatchState >> statePackAt: aSymbol [
^(self statePack at: aSymbol ifAbsent: [ ]) ifNil: [ '' ]
]

{ #category : #accessing }
MatchState >> statePackAt: aSymbol put: anObject [
^self statePack at: aSymbol put: anObject
]

{ #category : #access }
MatchState >> statisticsGenerator [
^StatisticsGenerator new matchState: self
]

{ #category : #printing }
MatchState >> storeOn: aStream [
| storeString |

storeString := (MatchplayEventPrinter forFile matchState: self) printMatchplayEvents string.
aStream nextPutAll: storeString; flush
]

{ #category : #files }
MatchState >> suggestedFileName [
| fragments |

fragments := OrderedCollection new
	add: 'FMR';
	add: self matchDatePrinted; 
	add: self tournament;
	add: self event;
	add: self match;
	add: self teamOne teamName;
	add: self teamTwo teamName;
	yourself.

^self cleanseFileName: ('_' join: (fragments collect: [ :e | e ifNil: ['']])),'.txt'
]

{ #category : #accessing }
MatchState >> table [

	^ table
]

{ #category : #accessing }
MatchState >> table: anObject [

	table := anObject
]

{ #category : #'actions - updating' }
MatchState >> tableUpdateFrom: aMatchDetailPresenter [

self setTableType: aMatchDetailPresenter tableTypeDropList selectedItem
]

{ #category : #access }
MatchState >> teamLeft [
"Answer the team currently on the left side of the table"

^self teamOnSide: self table sideLeft
]

{ #category : #access }
MatchState >> teamOnSide: aSide [
^self teamOnSide: aSide atEvent: self latestMatchplayEvent

]

{ #category : #access }
MatchState >> teamOnSide: aSide atEvent: aMatchplayEvent [

^(aSide isLHS xor: (self sideSwapParityAtEvent: aMatchplayEvent))
	ifTrue: [ self teams first ]
	ifFalse: [ self teams second ]
	

]

{ #category : #access }
MatchState >> teamOnSide: aSide inGame: aGameNumber [
"Answer the team that was on the specified table side during game aGameNumber
	- if aGameNumber=0 (meaning the entire match) then answer the team who started on the left"

^self teamOnSide: aSide atEvent: (self endGameEvents at: (aGameNumber max: 1))

]

{ #category : #accessing }
MatchState >> teamOne [
^self teams first
]

{ #category : #access }
MatchState >> teamRight [
"Answer the team currently on the right side of the table"

^self teamOnSide: self table sideRight 
]

{ #category : #statistics }
MatchState >> teamThatWonGame: aGameNumber [
"Answer the team that won the specified game, if 0 the team that won the match"

^aGameNumber isZero
	ifTrue: [ self score currentlyWinningTeam ]
	ifFalse: [ (self score gameScores at: aGameNumber) currentlyWinningTeam ]
]

{ #category : #accessing }
MatchState >> teamTwo [
^self teams second
]

{ #category : #access }
MatchState >> teamWithPossession [

^self teamWithPossessionInEvent: self latestMatchplayEvent
]

{ #category : #access }
MatchState >> teamWithPossessionInEvent: aMatchplayEvent [

^self teamOnSide: (self sideWithPossessionInEvent: aMatchplayEvent) atEvent: aMatchplayEvent
]

{ #category : #accessing }
MatchState >> teams [

	^ teams
]

{ #category : #accessing }
MatchState >> teams: anObject [

	teams := anObject
]

{ #category : #'actions - updating' }
MatchState >> teamsUpdateFrom: aMatchDetailPresenter [
self statePackAt: #teams put: aMatchDetailPresenter team1 text,',',aMatchDetailPresenter team2 text.
self teamOne teamName: aMatchDetailPresenter team1 text.
self teamTwo teamName: aMatchDetailPresenter team2 text.

]

{ #category : #accessing }
MatchState >> tournament [
^self statePackAt: #tournament
]

{ #category : #accessing }
MatchState >> tournament: anObject [
^self statePackAt: #tournament put: anObject
]

{ #category : #'actions - updating' }
MatchState >> updateMatchDetailsFrom: aMatchDetailPresenter [
"Update my match details from the presenter's input fields and then cleanse the matchplay events"

self tableUpdateFrom: aMatchDetailPresenter.
self teamsUpdateFrom: aMatchDetailPresenter.

self tournament: aMatchDetailPresenter tournament text.
self event: aMatchDetailPresenter event text.
self match: aMatchDetailPresenter match text.
self matchDate: aMatchDetailPresenter matchDateString.
self urlVideo: aMatchDetailPresenter urlVideo text.
self urlChart: aMatchDetailPresenter urlChart text.
self comment: aMatchDetailPresenter comment text.
self videoOffset: aMatchDetailPresenter videoOffset text.
self recorder: aMatchDetailPresenter recorder text.

"The file name is a function of some of the above"
self sourceFileName: nil.

self cleanMatchplayEventCommandLines.

 
]

{ #category : #accessing }
MatchState >> urlChart [
^self statePackAt: #urlChart
]

{ #category : #accessing }
MatchState >> urlChart: anObject [
^self statePackAt: #urlChart put: anObject
]

{ #category : #accessing }
MatchState >> urlVideo [
^self statePackAt: #urlVideo
]

{ #category : #accessing }
MatchState >> urlVideo: anObject [
^self statePackAt: #urlVideo put: anObject
]

{ #category : #accessing }
MatchState >> version [
^self statePackAt: #version
]

{ #category : #accessing }
MatchState >> version: anObject [
^self statePackAt: #version put: anObject
]

{ #category : #accessing }
MatchState >> videoOffset [
^self statePackAt: #videoOffset
]

{ #category : #accessing }
MatchState >> videoOffset: anObject [
^self statePackAt: #videoOffset put: anObject
]

{ #category : #access }
MatchState >> videoOffsetDuration [
"Answer a Duration, the offset of the start of the match from the start of the video from which it was recorded"

^self videoOffset prettyAsDuration ifNil: [ Duration zero ]
]

{ #category : #files }
MatchState >> writeFile: aFileReference [
"Write the receivers matchplay events to the specified file, and set it as the source file name"

"Set the last save date and rebuild all the match detail command lines"
self lastSaveDate: Date today.
self cleanMatchplayEventCommandLines.

"Write the file"
aFileReference writeStreamDo: [ :s | self storeOn: s ].
self sourceFileName: aFileReference fullName.
]

{ #category : #files }
MatchState >> writeFileNamed: fileName [
"Write the receivers matchplay events to the specified file, and set it as the source file name"

self writeFile: (self resolveFile: fileName)
]
