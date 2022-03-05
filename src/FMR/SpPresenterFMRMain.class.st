Class {
	#name : #SpPresenterFMRMain,
	#superclass : #'SpPresenterFMR_',
	#instVars : [
		'matchState',
		'recordingInputField',
		'recordingOutputField',
		'currentGame',
		'historyPaneField',
		'isDetailMode',
		'currentEventsSize',
		'leftTeamLabel',
		'rightTeamLabel',
		'leftScoreLabel',
		'rightScoreLabel',
		'gameScoreLabel',
		'leftPointScore',
		'rightPointScore',
		'pointScore',
		'oldInputString',
		'newInputString',
		'menuBar',
		'tournament',
		'controls',
		'statusBar',
		'timerProcess',
		'feedbackLabel',
		'radioButtonCompact',
		'radioButtonLines',
		'radioButtonNone',
		'radioButtonDurationS',
		'radioButtonDurationMS',
		'radioButtonElapsed',
		'matchplayEventPrinterHistoryPane',
		'ignoreSpuriousActivation',
		'headlinePresenter',
		'historyPaneEditState',
		'leftTimeOutLabel',
		'rightTimeOutLabel'
	],
	#classVars : [
		'ShouldOpenHeadlineStatisticsAfterEachGame',
		'ShouldOpenStatisticsAfterMatch'
	],
	#category : #FMR
}

{ #category : #'instance creation' }
SpPresenterFMRMain class >> defaultExtent [
^1200@800
]

{ #category : #'instance creation' }
SpPresenterFMRMain class >> open [
^self openOn: MatchState new
]

{ #category : #'instance creation' }
SpPresenterFMRMain class >> openOn: aMatchState [
| spFMR |

spFMR := self new matchState: aMatchState.
spFMR openWithSpec extent: self defaultExtent.
^spFMR postOpenMods.

]

{ #category : #settings }
SpPresenterFMRMain class >> recordingSettingsOn: aBuilder [
<fmrsettings>
(aBuilder group: #recording)
	label: 'Matchplay Recording';  
	description: 'All settings concerned with Matchplay Recording';
	with: [
		(aBuilder setting: #shouldOpenHeadlineStatisticsAfterEachGame)
			label: 'Open Headline statistics after each game'; 
			target: self;
			default: self shouldOpenHeadlineStatisticsAfterEachGameDefault;
			description: 'Headline statistics are key commentary statistics that can be generated immediately after each game. If you check this the Headline statistics will be generated and opened when you type / to indicate the end of the game.'.
			
		(aBuilder setting: #shouldOpenStatisticsAfterMatch)
			label: 'Open the statistics window after the match'; 
			target: self;
			default: self shouldOpenStatisticsAfterMatchDefault;
			description: 'The statistics window can be opened automatically immediately after the match ends. If you check this the statistics will be generated and opened when you type // to indicate the end of the match.'
		]

		
]

{ #category : #settings }
SpPresenterFMRMain class >> shouldOpenHeadlineStatisticsAfterEachGame [
^ShouldOpenHeadlineStatisticsAfterEachGame ifNil: [ self shouldOpenHeadlineStatisticsAfterEachGameDefault ]
]

{ #category : #settings }
SpPresenterFMRMain class >> shouldOpenHeadlineStatisticsAfterEachGame: aBoolean [
ShouldOpenHeadlineStatisticsAfterEachGame := aBoolean
]

{ #category : #settings }
SpPresenterFMRMain class >> shouldOpenHeadlineStatisticsAfterEachGameDefault [
^false
]

{ #category : #settings }
SpPresenterFMRMain class >> shouldOpenStatisticsAfterMatch [
^ShouldOpenStatisticsAfterMatch ifNil: [ self shouldOpenStatisticsAfterMatchDefault ]
]

{ #category : #settings }
SpPresenterFMRMain class >> shouldOpenStatisticsAfterMatch: aBoolean [
^ShouldOpenStatisticsAfterMatch := aBoolean
]

{ #category : #settings }
SpPresenterFMRMain class >> shouldOpenStatisticsAfterMatchDefault [
^true
]

{ #category : #versions }
SpPresenterFMRMain class >> versionNumber [
"Answer a string, the version number of the FMR software"
"0.9 - initial version"

^'0.9.1'		"Possession Flip attracts duration"
]

{ #category : #processing }
SpPresenterFMRMain >> addMatchplayEvent: matchplayEvent [
"Add the new matchplay event and then modify the duration of the finalised event if the timer was stopped"

self matchState addMatchplayEvent: matchplayEvent



]

{ #category : #'processing - real time' }
SpPresenterFMRMain >> beginActiveRecording [

self ensureTimerProcess.
self updateMatchSummary.
]

{ #category : #'menu actions - history pane editing' }
SpPresenterFMRMain >> cancelHistoryPaneEdit [

self historyPaneEditState: nil.
self historyPaneField beNotEditable.
self radioButtonCompact state: true.
self radioButtonNone state: true.
self updateUIState.
]

{ #category : #'input field processing' }
SpPresenterFMRMain >> characterAdded [
"Answer the new character added at the end of the input field, or nil if one was not added"

^self oldInputString size + 1 = self newInputString size
	ifTrue: [
		self oldInputString = self newInputString allButLast
			ifTrue: [ self newInputString last ]]
		

	
]

{ #category : #'input field processing' }
SpPresenterFMRMain >> characterDeleted [
"Answer the character which was deleted from the end of the input field, or nil if one was not"

^self newInputString size + 1 = self oldInputString size
	ifTrue: [
		self newInputString = self oldInputString allButLast
			ifTrue: [ self oldInputString last ]]
]

{ #category : #accessing }
SpPresenterFMRMain >> commandProcessor [
^self matchState commandProcessor
]

{ #category : #'menu actions - history pane editing' }
SpPresenterFMRMain >> confirmUpdateWith: aNewMatchState [
| query originalSize newSize|

query := String streamContents: [ :s |
	originalSize := self matchState matchplayEvents size.
	newSize := aNewMatchState matchplayEvents size.
		s << 'The original recording had '; << originalSize asString; << ' events, and the edited one '.
		originalSize = newSize ifTrue: [ s << 'also ' ].
		s << 'has '; << newSize asString; << ' events.

Do you want to keep the new one?' ].

^self confirm: query
]

{ #category : #initialization }
SpPresenterFMRMain >> connectPresenters [

self recordingInputField whenTextChangedDo: [ :newString :oldString | self processOldString: oldString newString: newString ].
self recordingInputField eventHandler whenKeyDownDo: [ :anEvent | self keyDown: anEvent].
self recordingInputField whenSubmitDo: [ :text | self processSubmit: text ].
"self recordingInputField transmitTo: self recordingOutputField transform: [ :aThing | self currentLine ]."

"self historyPaneField eventHandler whenFocusReceivedDo: [ self halt ]."

radioButtonCompact associatedRadioButtons: {radioButtonLines}; state: true.
radioButtonNone associatedRadioButtons: {radioButtonDurationS.radioButtonDurationMS.radioButtonElapsed}; state: true.

self currentGame: '' asText.
]

{ #category : #accessing }
SpPresenterFMRMain >> controls [

	^ controls
]

{ #category : #accessing }
SpPresenterFMRMain >> controls: anObject [

	controls := anObject
]

{ #category : #timer }
SpPresenterFMRMain >> createTimerProcess [

self terminateTimerProcess.
self timerProcess: (
	[ | delay |
		delay := Delay forMilliseconds: 500.
		[ self updateCurrentEventDuration. delay wait ] repeat ])
			fork.
FMRGrowlMorph growlDebugFor: 'Timer' message: 'Timer process created.'
]

{ #category : #accessing }
SpPresenterFMRMain >> currentEventsSize [

	^ currentEventsSize
]

{ #category : #accessing }
SpPresenterFMRMain >> currentEventsSize: anObject [

	currentEventsSize := anObject
]

{ #category : #accessing }
SpPresenterFMRMain >> currentGame [

	^ currentGame
]

{ #category : #accessing }
SpPresenterFMRMain >> currentGame: anObject [

	currentGame := anObject
]

{ #category : #processing }
SpPresenterFMRMain >> deleteLastCharacter [
"Quietly delete the last character entered"

self recordingInputField text ifEmpty: [ ^self ].

self ignoreSpuriousActivation: true.

UIManager default defer: [
	self recordingInputField text: self recordingInputField text allButLast.
	self setCursorToEnd ]
]

{ #category : #'menu actions - history pane editing' }
SpPresenterFMRMain >> editHistoryPane [
"Open the history pane for editing using the file MS duration format"

self historyPaneEditState: #editing.
self radioButtonLines state: true.
self radioButtonDurationMS state: true.
self historyPaneField beEditable.
self updateUIState.
]

{ #category : #'menu actions' }
SpPresenterFMRMain >> editMatchDetails [

SpPresenterFMRMatchDetails openOn: self
]

{ #category : #initialization }
SpPresenterFMRMain >> elapsedRelativity [
^self matchState videoOffsetDuration
	ifNil: [ 'match' ]
	ifNotNil: [ 'video' ]
]

{ #category : #menu }
SpPresenterFMRMain >> enable: aBoolean menuItemAtName: aString [

(self menuItemAtName: aString) enabled: aBoolean
]

{ #category : #timer }
SpPresenterFMRMain >> ensureTimerProcess [
"Create and start the timer process if it's not already running"

self timerProcess ifNil: [ self createTimerProcess ].
]

{ #category : #accessing }
SpPresenterFMRMain >> feedbackLabel [

	^ feedbackLabel
]

{ #category : #accessing }
SpPresenterFMRMain >> feedbackLabel: anObject [

	feedbackLabel := anObject
]

{ #category : #'processing - real time' }
SpPresenterFMRMain >> flagLatestEvent [
"Flag event"

self matchState
	latestMatchplayEventDo: [ :lme |
		lme setFlag.
		self feedbackLabel label: 'Event flagged: ',lme printFully ]
	ifNone: []
]

{ #category : #accessing }
SpPresenterFMRMain >> flushCaches [
self matchplayEventPrinterHistoryPane: nil
]

{ #category : #'update UI' }
SpPresenterFMRMain >> gameOrMatchScore [
"Answer the point score in the current game if recording is in progress, or the game score if the match is complete"

^self matchState isEndMatch 
	ifTrue: [ self matchState score completedMatchScore ]
	ifFalse: [ self matchState currentGameScore ]
]

{ #category : #accessing }
SpPresenterFMRMain >> gameScoreLabel [

	^ gameScoreLabel
]

{ #category : #accessing }
SpPresenterFMRMain >> gameScoreLabel: anObject [

	gameScoreLabel := anObject
]

{ #category : #'menu actions' }
SpPresenterFMRMain >> generateAndOpenAwards [
| merger awardsPresenter window |

merger := StatisticsMerger new merge.
awardsPresenter := SpStatisticsPagePresenter basicNew 
	statisticsGenerator: merger statisticsGenerator;
	modelClass: PSMorphTreeModelAwards;
	initialize.
window := awardsPresenter openWithSpec.
window title: 'FMR Awards - The Best Ever!'.
window extent: 1800@500.


]

{ #category : #'menu actions' }
SpPresenterFMRMain >> generateAndOpenWinCorrelates [
| presenter window |

presenter := SpStatisticsPagePresenter basicNew
	statisticsGenerator:StatisticsGenerator new;
	modelClass: PSMorphTreeModelTrawlWinCorrrelates;
	initialize.
window := presenter openWithSpec.
window title: 'FMR - Top Win-correlating Statistics'.
window extent: 1100@800.

]

{ #category : #accessing }
SpPresenterFMRMain >> headlinePresenter [

	^ headlinePresenter
]

{ #category : #accessing }
SpPresenterFMRMain >> headlinePresenter: anObject [

	headlinePresenter := anObject
]

{ #category : #help }
SpPresenterFMRMain >> helpHints [
^' Type ? for help, z to zero the timer, p to pause the timer.'
]

{ #category : #help }
SpPresenterFMRMain >> helpHistoryFormat [
^'Choose the format to use to display the matchplay events in the Recording History:

Compact - do not show event details and keep each active play sequence on a single line

Lines - show each event on a separate line with the event number, score at the event, and flag indicator'
]

{ #category : #help }
SpPresenterFMRMain >> helpHistoryPaneField [
^'Matchplay Recording History.

The large pane on the left is the History pane. Matchplay events are submitted into the Recording History pane when you press the Enter key in the Recording Input Field.

You can use the controls below to change the way that the historic events are displayed; hover your mouse over each control for more help.

To correct errors in the Recording Input Field use the Edit Matchplay History menu point to open up the History pane for editing. During editing the events are displayed in full, with all durations displayed in microseconds inside braces. Events which have suspciously long durations may indicate recording errors; their event numbers are coloured in orange or red. Be careful when you make changes in the history pane. When you are finished, use the Accept Matchplay History Edits menu point. If everything is OK you will prompted to replace the current recording with the edited one. If there''s an error in your changes, the edit will not be accepted and you will be prompted to correct the mistake at the highlighted location. If you mess up you can use the Cancel Matchplay History Edits menu point to throw the changes away and start again. Event flags are removed when the edits are accepted.'
]

{ #category : #help }
SpPresenterFMRMain >> helpHistoryShowTime [
^'With these controls you can choose how to display the time associated with each matchplay event:

None - no time shown

Duation (s) - show the duration of the event to the nearest whole number of seconds

Duration (ms) - show the duration of the event in milliseconds

Elapsed - show the elapsed time from the start of the match to this event'

]

{ #category : #help }
SpPresenterFMRMain >> helpOpenChart [
^'If the Match Details include a URL to the event chart or hosting website, this button will open that page in your web browser.'

]

{ #category : #help }
SpPresenterFMRMain >> helpPlayVideo [
^'If the Match Details include a URL to the source video, this button will play the video in your web browser.'

]

{ #category : #help }
SpPresenterFMRMain >> helpRecordingInputField [
^'Matchplay Recording Input.

This is the place to enter matchplay recording events. Type matchplay event keystrokes during Active Play in sequence on the same line. If you make a mistake use the Backspace key to delete the latest entry. Duplicated and unrecognised characters will be ignored.

When a goal is scored (#) or there''s a stoppage in play (s), press the Enter key to clear the field and submit the events to the main History Pane below. You can also press the Enter key after other pauses in Active Play, but you don''t have to (e.g. time-out, ball-off-table, dead ball, infraction).

At any time you can type a question mark (?) to bring up the hint sheet for the complete recording lexicon.'
]

{ #category : #help }
SpPresenterFMRMain >> helpRecordingOutputField [
^'Matchplay Recording Output.

Every matchplay event that you type in the input field will be reflected here in large type, coloured according to the owning puppet. If the colour is wrong press the Backspace key to delete the entry and make the appropriate correction, typically by adding or deleting a Possession Change event (.).

Each time you enter a matchplay event the timer will restart to track the duration of that event. The current duration of the latest event is displayed in braces at the end of the line, e.g. 5{3s} which means that the ball has been on the 5-rod for 3 seconds so far, or t{21s} which means that the time-out has lasted 21 seconds so far. When you type the next event, the duration of the previous one is finalised and will no longer change, e.g. 5{3s}3{1s}. To keep the Recording Output line short and easy to read the duration of the preceding events is not shown.'
]

{ #category : #'menu actions - history pane editing' }
SpPresenterFMRMain >> highlightMatchplayEvent: aMatchplayEvent [
"Highlight aMatchplayEvent in the History Pane"

| string startIndex stopIndex |

self radioButtonLines state: true.
self radioButtonDurationMS state: true.

string := self historyPaneField text asString.
startIndex := string indexOfSubCollection: aMatchplayEvent printFully.
stopIndex := string indexOf: Character cr startingAt: startIndex.
self historyPaneField selectionInterval: (startIndex to: stopIndex).


]

{ #category : #accessing }
SpPresenterFMRMain >> historyPaneEditState [

	^ historyPaneEditState
]

{ #category : #accessing }
SpPresenterFMRMain >> historyPaneEditState: anObject [

	historyPaneEditState := anObject
]

{ #category : #accessing }
SpPresenterFMRMain >> historyPaneField [

	^ historyPaneField
]

{ #category : #accessing }
SpPresenterFMRMain >> historyPaneField: anObject [

	historyPaneField := anObject
]

{ #category : #accessing }
SpPresenterFMRMain >> ignoreSpuriousActivation [

	^ ignoreSpuriousActivation
]

{ #category : #accessing }
SpPresenterFMRMain >> ignoreSpuriousActivation: anObject [

	ignoreSpuriousActivation := anObject
]

{ #category : #initialization }
SpPresenterFMRMain >> initialize [
super initialize.

"I see no easy alternative to modifying the Smalltalk ui theme"
self theme settings balloonHelpDelayTime: 100.

self ignoreSpuriousActivation: false

]

{ #category : #initialization }
SpPresenterFMRMain >> initializeControls [

| controlsFormat controlsTime queryHP formatLabel showTimeLabel |

formatLabel := self newLabel label: 'Format'; help: self helpHistoryFormat.
showTimeLabel := self newLabel label: 'Show Time'; help: self helpHistoryShowTime.

queryHP := self newImage
	help: self helpHistoryPaneField;
	image: (self iconNamed: #smallQuestion);
	yourself.
queryHP eventHandler whenMouseDownDo: [ :anEvent | anEvent isPrimaryButton ifTrue: [ FMRDocument openHelpWindowWith: self helpHistoryPaneField extent: 800@320 ]].	

radioButtonCompact := (self newHistoryPaneRadioButton: 'Compact') help: 'Show events in compact format'.
radioButtonLines := (self newHistoryPaneRadioButton: 'Lines') help: 'Show each event on its own line'.

radioButtonNone := (self newHistoryPaneRadioButton: 'None') help: 'Don''t show event durations'.
radioButtonDurationS := (self newHistoryPaneRadioButton: 'Duration (s)') help: 'Show event durations to the nearest complete second'.
radioButtonDurationMS := (self newHistoryPaneRadioButton: 'Duration (ms)') help: 'Show event durations in milliseconds'.
radioButtonElapsed := (self newHistoryPaneRadioButton: 'Elapsed') help: 'Show the start time of each event relative to the start of the video/match'.

controlsFormat := SpBoxLayout newTopToBottom 
	add: queryHP withConstraints: [ :c | c padding: 0; height: StandardFonts defaultFont height ];
	add: formatLabel withConstraints: [ :c | c padding: 0; height: StandardFonts defaultFont height ];
	add: radioButtonCompact withConstraints: [ :c | c padding: 0; height: StandardFonts defaultFont height ];
	add: radioButtonLines withConstraints: [ :c | c padding: 0; height: StandardFonts defaultFont height ];
	yourself.
	
controlsTime := SpBoxLayout newTopToBottom
	add: showTimeLabel withConstraints: [ :c | c padding: 0; height: StandardFonts defaultFont height ];
	add: radioButtonNone withConstraints: [ :c | c padding: 0; height: StandardFonts defaultFont height ];
	add: radioButtonDurationS withConstraints: [ :c | c padding: 0; height: StandardFonts defaultFont height ];
	add: radioButtonDurationMS withConstraints: [ :c | c padding: 0; height: StandardFonts defaultFont height ];
	add: radioButtonElapsed withConstraints: [ :c | c padding: 0; height: StandardFonts defaultFont height ];
	yourself.

controls := SpBoxLayout newTopToBottom vAlignStart
	add: controlsFormat withConstraints: [ :c | c padding: 0; height: 80 ];
	add: controlsTime withConstraints: [ :c | c padding: 0; height: 100 ];
	add: (self newButton label: 'Play video'; help: self helpPlayVideo; action: [ self playVideo ]; enable; yourself)
	withConstraints: [ :c |c padding: 2; height: StandardFonts defaultFont height + 15 ];
	add: (self newButton label: 'Open chart'; help: self helpOpenChart; action: [ self openChart ]; enable; yourself)
	withConstraints: [ :c |c padding: 2; height: StandardFonts defaultFont height + 15 ];
	yourself

]

{ #category : #initialization }
SpPresenterFMRMain >> initializePresenters [

| ltl rtl gsl rip queryRIP queryROP rop |

self menuBarCreate.
self recordingOutputField: self newText beNotEditable.
self recordingInputField: self newTextInput.
self recordingInputField removeEntryCompletion.
self feedbackLabel: self newLabel.

self leftTeamLabel: (self newTeamLabel: 'Team 1').
ltl := (SpBoxLayout newLeftToRight hAlignCenter; vAlignEnd; add: self leftTeamLabel; yourself).
self pointScore: (self newText beNotEditable withoutScrollBars beNotWrapWord propagateNaturalWidth: false).

self rightTeamLabel: (self newTeamLabel: 'Team 2').
rtl := (SpBoxLayout newLeftToRight hAlignCenter; vAlignStart; add: self rightTeamLabel; yourself).
self gameScoreLabel: (self newText beNotEditable withoutScrollBars beNotWrapWord propagateNaturalWidth: true).
gsl := (SpBoxLayout newLeftToRight hAlignCenter; vAlignCenter; add: self gameScoreLabel; yourself).

leftTimeOutLabel := (self newText beNotEditable withoutScrollBars beNotWrapWord propagateNaturalWidth: true).
rightTimeOutLabel := (self newText beNotEditable withoutScrollBars beNotWrapWord propagateNaturalWidth: true).

self historyPaneField: self newText beNotEditable.
self statusBar: self newStatusBar.

self initializeControls. 

queryROP := self newImage
	help: self helpRecordingOutputField;
	image: (self iconNamed: #smallQuestion);
	yourself.
queryROP eventHandler whenMouseDownDo: [ :anEvent | 	anEvent isPrimaryButton ifTrue: [ FMRDocument openHelpWindowWith: self helpRecordingOutputField extent: 800@300 ]].
	
rop := SpBoxLayout newLeftToRight
	add: recordingOutputField withConstraints: [ :c | c padding: 2; width: 1000; expand: true ];
	add: queryROP withConstraints: [ :c | c padding: 2; height: StandardFonts defaultFont height ];
	yourself.

queryRIP := self newImage
	help: self helpRecordingInputField;
	image: (self iconNamed: #smallQuestion);
	yourself.
queryRIP eventHandler whenMouseDownDo: [ :anEvent | 	anEvent isPrimaryButton ifTrue: [ FMRDocument openHelpWindowWith: self helpRecordingInputField extent: 800@300 ]].	
	
rip := SpBoxLayout newLeftToRight
	add: recordingInputField withConstraints: [ :c | c padding: 2; width: 1000; expand: true ];
	add: queryRIP withConstraints: [ :c | c padding: 2; height: StandardFonts defaultFont height ];
	yourself.

self layout: (SpBoxLayout newTopToBottom
	add: #menuBar withConstraints: [ :c | c height: self class toolbarHeight ];
	add: rop withConstraints: [ :c | c padding: 2; height: StandardFonts defaultFont height + 62 ];
	add: rip withConstraints: [ :c | c padding: 2; height: StandardFonts defaultFont height + 15 ];

	add: self feedbackLabel withConstraints: [ :c | c width: 80; padding: 2 ];
	
	add: gsl
	withConstraints: [ :c | c padding: 2; height: StandardFonts defaultFont height + 15];

	add: (SpBoxLayout newLeftToRight hAlignCenter;
		add: ltl withConstraints: [ :c | c width: 350; expand: false ];
		add: self leftTimeOutLabel withConstraints: [ :c | c width: 80; padding: 5 ];
		add: self pointScore;
		add: self rightTimeOutLabel withConstraints: [ :c | c width: 80; padding: 5 ];
		add: rtl withConstraints: [ :c | c width: 350; expand: false ];
		yourself)
	withConstraints: [ :c | c height: StandardFonts defaultFont height + 15 ];

	add: '' withConstraints: [ :c | c padding: 2; height: 4 ];

	add: (SpBoxLayout newLeftToRight
		add: self historyPaneField withConstraints: [ :c | c padding: 2 ];
		add: self controls withConstraints: [ :c | c padding: 2; width: 110 ];
		yourself)
	withConstraints: [ :c | c padding: 2 ];
	add: self statusBar
	withConstraints: [ :c | c height: StandardFonts defaultFont height ];
	yourself).

self focusOrder add: self recordingInputField.
self recordingInputField takeKeyboardFocus.

self currentEventsSize: 0.
]

{ #category : #testing }
SpPresenterFMRMain >> isActivePlayRecording [
"Answer if we are currently in Active Play Recording mode"

"We decide that we are Active Play Recording one the basis of the 1st character of the input string,
	or if it's empty, the character which was deleted"

^self newInputString
	ifEmpty: [ self oldInputString
		ifEmpty: [ false ]
		ifNotEmpty: [ :s | '.523' includes: s first ] ]
	ifNotEmpty: [ :s | '.523' includes: s first ]
]

{ #category : #testing }
SpPresenterFMRMain >> isCommandMode [
^self newInputString
	ifEmpty: [ false ]
	ifNotEmpty: [ self newInputString first = $@ ]
]

{ #category : #testing }
SpPresenterFMRMain >> isDetailMode [
^isDetailMode ifNil: [ false ]
]

{ #category : #accessing }
SpPresenterFMRMain >> isDetailMode: anObject [

	isDetailMode := anObject
]

{ #category : #testing }
SpPresenterFMRMain >> isFirstCharacterOfLine [
"Answer if the input field was empty and a new character has been typed"

^self newInputString size = 1 & self oldInputString isEmpty
]

{ #category : #testing }
SpPresenterFMRMain >> isMagicKey [
"Answer if the added character is a magic key"

^'pzf?' includes: self characterAdded
]

{ #category : #testing }
SpPresenterFMRMain >> isPausedPlayRecording [
^self newInputString
	ifEmpty: [ false ]
	ifNotEmpty: [ 's/<>@"' includes: self newInputString first ]
]

{ #category : #'update UI' }
SpPresenterFMRMain >> keyDown: anEvent [
"Undo cursor movement which would moe the cursor before the last character
	- only allow deletion of the last character using Backspace"

"Disallow
	80 Cursor LEFT
	82 Cursor UP
Empty clipboard if CTRL- to prevent pasting"

(#(80 82) includes: anEvent scanCode) ifTrue: [ ^self setCursorToEnd ].
(#(224 228) includes: anEvent scanCode) ifTrue: [ ^Clipboard clipboardText: '' ].
]

{ #category : #accessing }
SpPresenterFMRMain >> leftPointScore [

	^ leftPointScore
]

{ #category : #accessing }
SpPresenterFMRMain >> leftPointScore: anObject [

	leftPointScore := anObject
]

{ #category : #accessing }
SpPresenterFMRMain >> leftScoreLabel [

	^ leftScoreLabel
]

{ #category : #accessing }
SpPresenterFMRMain >> leftScoreLabel: anObject [

	leftScoreLabel := anObject
]

{ #category : #accessing }
SpPresenterFMRMain >> leftTeamLabel [

	^ leftTeamLabel
]

{ #category : #accessing }
SpPresenterFMRMain >> leftTeamLabel: anObject [

	leftTeamLabel := anObject
]

{ #category : #accessing }
SpPresenterFMRMain >> leftTimeOutLabel [

	^ leftTimeOutLabel
]

{ #category : #accessing }
SpPresenterFMRMain >> leftTimeOutLabel: anObject [

	leftTimeOutLabel := anObject
]

{ #category : #logging }
SpPresenterFMRMain >> logClear [

Transcript clear
]

{ #category : #'update UI' }
SpPresenterFMRMain >> matchResultSummary [
^self matchState isEndMatch 
	ifTrue: [ self matchState matchStatusSummary,': ',self matchState matchProgressSummary ]
	ifFalse: [ self matchState matchStatusSummary,'. ',self matchState matchDetailsStatus,self helpHints ]
]

{ #category : #accessing }
SpPresenterFMRMain >> matchState [

	^ matchState
]

{ #category : #accessing }
SpPresenterFMRMain >> matchState: anObject [
matchState := anObject.
self flushCaches.

]

{ #category : #'UI - history pane' }
SpPresenterFMRMain >> matchplayEventPrinterHistoryPane [
^(MatchplayEventPrinter forHistoryPane matchState: self matchState)
	isFormatCompact: radioButtonCompact state;
	isFormatLines: radioButtonLines state;
	isTimeNone: radioButtonNone state;
	isTimeDurationS: radioButtonDurationS state;
	isTimeDurationMS: radioButtonDurationMS state;
	isTimeElapsed: radioButtonElapsed state;
	yourself
]

{ #category : #'UI - history pane' }
SpPresenterFMRMain >> matchplayEventPrinterHistoryPane: anObject [
matchplayEventPrinterHistoryPane := anObject
]

{ #category : #accessing }
SpPresenterFMRMain >> menuBar [

	^ menuBar
]

{ #category : #accessing }
SpPresenterFMRMain >> menuBar: anObject [

	menuBar := anObject
]

{ #category : #menu }
SpPresenterFMRMain >> menuBarCreate [

menuBar := self newMenuBar
	addGroup: [ :group | 
		group
			addItem: [ :item | 
				item
					name: 'File';
					icon: (self iconNamed: #smallSave);
					subMenu: self subMenuFile ]];
	addGroup: [ :group | 
		group
			addItem: [ :item | 
				item
					name: 'Recording';
					icon: (self iconNamed: #glamorousBrowse);
					subMenu: self subMenuRecording ]
				];
	addGroup: [ :group | 
		group
			addItem: [ :item | 
				item
					name: 'Matchplay History';
					icon: (self iconNamed: #history);
					subMenu: self subMenuHistory ]
				];
	addGroup: [ :group | 
		group
			addItem: [ :item | 
				item
					name: 'Statistics';
					icon: (self iconNamed: #transcript);
					subMenu: self subMenuStatistics ]
				];
	addGroup: [ :group | 
		group
			addItem: [ :item | 
				item
					name: 'Meta Statistics';
					icon: (self iconNamed: #database);
					subMenu: self subMenuAnalyseDatabase ]
				];
	addGroup: [ :group | 
		group
			addItem: [ :item | 
				item
					name: 'Help';
					icon: (self iconNamed: #help);
					subMenu: self subMenuHelp ]
				];
	addGroup: [ :group | 
		group
			addItem: [ :item | 
				item
					name: 'Debug';
					icon: (self iconNamed: #smallDebug);
					subMenu: self subMenuDebug ]
				].						
menuBar addKeybindingsTo: self.
]

{ #category : #'menu actions - history pane editing' }
SpPresenterFMRMain >> menuEnableHistory [
"Ensure that the matchplay history menu points are enabled/disabled according to the receiver's state"

self enable: (self historyPaneEditState isNil) menuItemAtName: 'Edit Matchplay History'.
self enable: (self historyPaneEditState = #editing) menuItemAtName: 'Cancel Matchplay History'.
self enable: (self historyPaneEditState = #editing) menuItemAtName: 'Accept Matchplay History'.
]

{ #category : #menu }
SpPresenterFMRMain >> menuItemAtName: aString [
self menuBar menuGroups do: [ :e1 |
	e1 menuItems first subMenu menuGroups first menuItems do: [:e2 |
		(e2 name beginsWith: aString) ifTrue: [ ^e2 ]]].
^nil

]

{ #category : #'input field processing' }
SpPresenterFMRMain >> newFirstCharacter [

^self newInputString
	ifEmpty: [ '' ]
	ifNotEmpty: [ :cit | cit first ]
]

{ #category : #initialization }
SpPresenterFMRMain >> newHistoryPaneRadioButton: label [
^(self newRadioButton label: label)
	"whenActivatedDo: [ self refreshHistoryPane ];"
	whenDeactivatedDo: [ self refreshHistoryPane ]
]

{ #category : #accessing }
SpPresenterFMRMain >> newInputString [

	^ newInputString
]

{ #category : #accessing }
SpPresenterFMRMain >> newInputString: anObject [

	newInputString := anObject
]

{ #category : #'menu actions' }
SpPresenterFMRMain >> newMatch [

self headlinePresenter: nil.
self matchState: MatchState new.
self terminateTimerProcess.
self updateMatchSummary.
self updateUIState.
self statusBarMessage: 'New matchplay recording. Ready to start recording, or use the Match Details>>View/Edit menu to enter the Match Details...'
]

{ #category : #initialization }
SpPresenterFMRMain >> newTeamLabel: aString [

^self newText
	beNotEditable;
	withoutScrollBars;
	beNotWrapWord;
	propagateNaturalWidth: true;
	text: aString;
	yourself
]

{ #category : #accessing }
SpPresenterFMRMain >> oldInputString [

	^ oldInputString
]

{ #category : #accessing }
SpPresenterFMRMain >> oldInputString: anObject [

	oldInputString := anObject
]

{ #category : #'menu actions' }
SpPresenterFMRMain >> openBriefHintSheet [
FMRDocument openBriefHintSheet
]

{ #category : #'menu actions' }
SpPresenterFMRMain >> openChart [

self matchState openWebBrowserOnURLChart.
self recordingInputField takeKeyboardFocus.
]

{ #category : #'menu actions' }
SpPresenterFMRMain >> openCommonSequences [
FMRDocument openCommonSequences
]

{ #category : #'menu actions' }
SpPresenterFMRMain >> openFMRFeatures [
FMRDocument openFMRFeatures
]

{ #category : #'menu actions' }
SpPresenterFMRMain >> openFileFinder [
SpPresenterMatchplayFileFinder open
]

{ #category : #'menu actions' }
SpPresenterFMRMain >> openHintSheet [
FMRDocument openHintSheet
]

{ #category : #'menu actions' }
SpPresenterFMRMain >> openRecordingFundamentals [
FMRDocument openRecordingFundamentals
]

{ #category : #'menu actions' }
SpPresenterFMRMain >> openRecordingHelps [
self
	openFMRFeatures;
	openRecordingFundamentals;
	openBriefHintSheet;
	openHintSheet;
	openCommonSequences
]

{ #category : #'processing - real time' }
SpPresenterFMRMain >> pauseTimer [

self matchState matchplayTimer isRunning
	ifTrue: [
		self matchState matchplayTimer stop.
		self feedbackLabel label: 'Timer paused while you rewind the video. Timer will restart when you type p again or enter the next matchplay event.' ]
	ifFalse: [
		self matchState matchplayTimer start.
		self feedbackLabel label: 'Timer restarted.' ]
		
]

{ #category : #'menu actions' }
SpPresenterFMRMain >> playVideo [

self matchState openWebBrowserOnURLVideo.
self recordingInputField takeKeyboardFocus.
]

{ #category : #accessing }
SpPresenterFMRMain >> pointScore [

	^ pointScore
]

{ #category : #accessing }
SpPresenterFMRMain >> pointScore: anObject [

	pointScore := anObject
]

{ #category : #initialization }
SpPresenterFMRMain >> postOpenMods [
| font |

font := LogicalFont familyName: 'Source Sans Pro' pointSize: 36.
self recordingOutputField adapter widget font: font; scrollbarsShowNever.

font := LogicalFont familyName: 'Source Sans Pro' pointSize: 14.
self pointScore adapter widget scrollbarsShowNever; font: font.
self leftTeamLabel adapter widget scrollbarsShowNever; font: font.
self rightTeamLabel adapter widget scrollbarsShowNever; font: font.
self leftTimeOutLabel adapter widget scrollbarsShowNever; font: font.
self rightTimeOutLabel adapter widget scrollbarsShowNever; font: font.

self updateUIState.
self logClear.

self updateMatchSummary.
]

{ #category : #'input field processing' }
SpPresenterFMRMain >> previousCharacter [

^self oldInputString
	ifEmpty: [ '' ]
	ifNotEmpty: [ :cit | cit last ]
]

{ #category : #'update UI' }
SpPresenterFMRMain >> printCurrentLine [
^((MatchplayEventPrinter forRecordingOutput matchState: self matchState)
	printCurrentMatchplayEvents: self currentEventsSize) text
]

{ #category : #'processing - real time' }
SpPresenterFMRMain >> processCharacterAdded: characterAdded [
| matchplayEvent detailText |

"Command mode - during - Ignore characters"
self isCommandMode ifTrue: [ ^self ].

"Detail mode - entering - set comment mode ON"
self isDetailMode not & (characterAdded=$[) ifTrue: [ ^self isDetailMode: true ].
"Detail mode - during - Ignore characters"
self isDetailMode & (characterAdded~=$]) ifTrue: [ ^self ].
"Detail mode - exiting - modify the last event with the specified detail"
self isDetailMode & (characterAdded=$]) ifTrue: [
	self isDetailMode: false.
	detailText := self recordingInputField text allButLast copyAfterLast: $[.
	^self matchState latestMatchplayEventDo: [ :lme | lme detail: detailText ] ifNone: []].

"Undo anything we don't recognise and quit"
(MatchplayEvent activeRecordingCharacters includes: characterAdded)
	ifFalse: [
		self feedbackLabel label: 'Character ignored: ',characterAdded asString.
		^self deleteLastCharacter ].

"Undo anything we recognise but don't like and quit"
(self previousCharacter = characterAdded)
	ifTrue: [
		self feedbackLabel label: 'Repeated event ignored: ',characterAdded asString.
		^self deleteLastCharacter ].

"Create the matchplay event for the entered character"
matchplayEvent := MatchplayEvent newFromCharacter: characterAdded inMatchState: self matchState.
self addMatchplayEvent: matchplayEvent.
self feedbackLabel label: ''.


]

{ #category : #'processing - real time' }
SpPresenterFMRMain >> processCharacterAddedOrDeleted [
"we come in here when a character has been added to or deleted from the end of the input field"

self characterAdded ifNotNil: [ :char | ^self processCharacterAdded: char ].
self characterDeleted ifNotNil: [ :char | ^self processCharacterDeleted: char ].

"If we get here then something else happened - restore the old input and set cursor to end"
self restoreOldInput.
self setCursorToEnd.


]

{ #category : #processing }
SpPresenterFMRMain >> processCharacterDeleted: deletedCharacter [

"If we get here we think we need to delete the last matchplay event - sanity check this"
(MatchplayEvent newFromCharacter: deletedCharacter inMatchState: self matchState)
	ifNil: [ "self error: 'The deleted character doesn''t have an event'" ]
	ifNotNil: [
		self matchState latestMatchplayEvent
			ifNil: [ self error: 'Wants to delete an event we don''t have' ]
			ifNotNil: [ :lme | lme representation = deletedCharacter
				ifTrue: [ self matchState deleteLatestMatchplayEvent ]
				ifFalse: [ self error: 'Wants to delete an event that doesn''t match the deleted character' ]]]
		
		
		
]

{ #category : #processing }
SpPresenterFMRMain >> processInputString: aString [
"If the input begins with an active play character then it's already been processed as a sequence of active play events.
Otherwise, process it as we would for a recorded input line"

aString ifNotEmpty: [
	(self commandProcessor isActivePlay: aString)
		ifFalse: [ self commandProcessor processRecordedLine: aString ]].
	
self updateUIState.

]

{ #category : #'processing - real time' }
SpPresenterFMRMain >> processMagicKey [
"Process a magic key"

"p to pause the timer so you can rewind the video"
self characterAdded = $p ifTrue: [ ^self pauseTimer; deleteLastCharacter ].

"z to reset the timer on the ticking event"
self characterAdded = $z ifTrue: [ ^self resetTimer; deleteLastCharacter ].

"f to flag the event"
self characterAdded = $f ifTrue: [ ^self flagLatestEvent; deleteLastCharacter ].

"? to open the hint sheet"
self characterAdded = $? ifTrue: [ ^self openHintSheet; deleteLastCharacter ].

]

{ #category : #'processing - real time' }
SpPresenterFMRMain >> processOldString: oldString newString: newString [
"Process the newString by comparing it with the oldString to see if a character got added or deleted"

self ignoreSpuriousActivation ifTrue: [ ^self ignoreSpuriousActivation: false ].

FMRGrowlMorph growlDebugFor: 'Recording Input' message: [ oldString -> newString ].
"Transcript crShow: oldString -> newString."

self oldInputString: oldString.
self newInputString: newString.

self oldInputString = self newInputString ifTrue: [ ^self ].

self isMagicKey & (self isDetailMode not) & (self isCommandMode not) ifTrue: [ ^self processMagicKey ].

"If we are not in Active Recording mode, then ignore keystrokes until CR pressed"
self isActivePlayRecording ifFalse: [
	self isPausedPlayRecording ifFalse: [
		"Ignore illegal paused play entry"
		self characterAdded ifNotNil: [ 
			self feedbackLabel label: 'Character ignored: ',self characterAdded asString.
			self deleteLastCharacter ]].
	^self ].

self processCharacterAddedOrDeleted.

"After typing the first the character, start the event timer process"
self isFirstCharacterOfLine ifTrue: [ self beginActiveRecording ].

"Pretty print"
self recordingOutputFieldUpdate.

self updateUI.

]

{ #category : #'processing - real time' }
SpPresenterFMRMain >> processSubmit: textPresenter [

"Disallow Enter after an active play event"
self matchState latestMatchplayEvent ifNotNil: [ :aMatchplayEvent |
	aMatchplayEvent isActivePlay ifTrue: [
		^self feedbackLabel label: 'Press Enter after a goal (#) or play stoppage (s).' ]].

self processInputString: textPresenter getText asString.

self matchState isEndGame & self class shouldOpenHeadlineStatisticsAfterEachGame ifTrue: [ self showHeadlineStatisticsForCompletedGame ].
self matchState isEndMatch ifTrue: [
	self matchState recordingComplete.
	self updateUIState.
	self terminateTimerProcess.
	self class shouldOpenStatisticsAfterMatch ifTrue: [ self openStatistics ]].

self updateMatchSummary.
]

{ #category : #accessing }
SpPresenterFMRMain >> radioButtonCompact [

	^ radioButtonCompact
]

{ #category : #accessing }
SpPresenterFMRMain >> radioButtonCompact: anObject [

	radioButtonCompact := anObject
]

{ #category : #accessing }
SpPresenterFMRMain >> radioButtonDurationMS [

	^ radioButtonDurationMS
]

{ #category : #accessing }
SpPresenterFMRMain >> radioButtonDurationMS: anObject [

	radioButtonDurationMS := anObject
]

{ #category : #accessing }
SpPresenterFMRMain >> radioButtonDurationS [

	^ radioButtonDurationS
]

{ #category : #accessing }
SpPresenterFMRMain >> radioButtonDurationS: anObject [

	radioButtonDurationS := anObject
]

{ #category : #accessing }
SpPresenterFMRMain >> radioButtonElapsed [

	^ radioButtonElapsed
]

{ #category : #accessing }
SpPresenterFMRMain >> radioButtonElapsed: anObject [

	radioButtonElapsed := anObject
]

{ #category : #accessing }
SpPresenterFMRMain >> radioButtonLines [

	^ radioButtonLines
]

{ #category : #accessing }
SpPresenterFMRMain >> radioButtonLines: anObject [

	radioButtonLines := anObject
]

{ #category : #accessing }
SpPresenterFMRMain >> radioButtonNone [

	^ radioButtonNone
]

{ #category : #accessing }
SpPresenterFMRMain >> radioButtonNone: anObject [

	radioButtonNone := anObject
]

{ #category : #'menu actions' }
SpPresenterFMRMain >> readFile [

MatchState readFile ifNotNil: [ :ms |
	self matchState: ms.
	self terminateTimerProcess.
	self updateMatchSummary.
	self updateUIState.
	self statusBarMessage: self matchState matchplayEvents size asString,' matchplay events read in from file: ',self matchState sourceFileName ]
]

{ #category : #accessing }
SpPresenterFMRMain >> recordingInputField [

	^ recordingInputField
]

{ #category : #accessing }
SpPresenterFMRMain >> recordingInputField: anObject [

	recordingInputField := anObject
]

{ #category : #accessing }
SpPresenterFMRMain >> recordingOutputField [

	^ recordingOutputField
]

{ #category : #accessing }
SpPresenterFMRMain >> recordingOutputField: anObject [

	recordingOutputField := anObject
]

{ #category : #'update UI' }
SpPresenterFMRMain >> recordingOutputFieldText: aText [

self recordingOutputField text: aText.
self recordingOutputField adapter widget scrollToEndOfText.

]

{ #category : #'update UI' }
SpPresenterFMRMain >> recordingOutputFieldUpdate [
"Update the recording output field
	- if we are in Active Play then show the current sequence of Active Play events
	- if we are in Paused Play then show the lastest Paused Play event"

self recordingOutputFieldText: self printCurrentLine
]

{ #category : #'UI - history pane' }
SpPresenterFMRMain >> refreshHistoryPane [
self matchState ifNil: [ ^self ].

self historyPaneField text: self matchplayEventPrinterHistoryPane printMatchplayEvents text.
self matchState isEndMatch
	ifTrue: [ self historyPaneField adapter widget scrollToBeginningOfText ]
	ifFalse: [
		self historyPaneField adapter widget scrollToEndOfText.
		self recordingInputField takeKeyboardFocus ]
]

{ #category : #'processing - real time' }
SpPresenterFMRMain >> resetTimer [

self matchState matchplayTimer isRunning
	ifTrue: [
		self matchState durationSinceLastQuery.
		self feedbackLabel label: 'Timer reset to zero.' ]
]

{ #category : #'menu actions' }
SpPresenterFMRMain >> restartRecording [
"Throw away all events that are not Commands"

self matchState restartRecording.
self updateUIState
]

{ #category : #'update UI' }
SpPresenterFMRMain >> restoreOldInput [

self recordingInputField text: ''; text: self oldInputString; updateText
]

{ #category : #accessing }
SpPresenterFMRMain >> rightPointScore [

	^ rightPointScore
]

{ #category : #accessing }
SpPresenterFMRMain >> rightPointScore: anObject [

	rightPointScore := anObject
]

{ #category : #accessing }
SpPresenterFMRMain >> rightScoreLabel [

	^ rightScoreLabel
]

{ #category : #accessing }
SpPresenterFMRMain >> rightScoreLabel: anObject [

	rightScoreLabel := anObject
]

{ #category : #accessing }
SpPresenterFMRMain >> rightTeamLabel [

	^ rightTeamLabel
]

{ #category : #accessing }
SpPresenterFMRMain >> rightTeamLabel: anObject [

	rightTeamLabel := anObject
]

{ #category : #accessing }
SpPresenterFMRMain >> rightTimeOutLabel [

	^ rightTimeOutLabel
]

{ #category : #accessing }
SpPresenterFMRMain >> rightTimeOutLabel: anObject [

	rightTimeOutLabel := anObject
]

{ #category : #'menu actions' }
SpPresenterFMRMain >> saveFile [

self matchState sourceFileName ifNotNil: [ 
	(self confirm: 'This will overwrite the saved file with the same name. Please confirm that this is what you want to do.')
		ifTrue: [ self matchState sourceFileName asFileReference delete ]
		ifFalse: [ ^nil ]].
self matchState saveFile.
self statusBarMessage: self matchState matchplayEvents size asString,' matchplay events written to file: ',self matchState sourceFileName.
]

{ #category : #'menu actions' }
SpPresenterFMRMain >> saveFileAs [

self matchState saveFileAs ifNotNil: [
		self statusBarMessage:
			self matchState matchplayEvents size asString,' matchplay events written to file: ',self matchState sourceFileName ]
]

{ #category : #initialization }
SpPresenterFMRMain >> set: aTextPresenter text: aText [
"Fix a bug in the Sp code. Modifying the attribute only works if the text is different"

(aTextPresenter text isEmpty or: [ aTextPresenter text last = Character space ])
	ifTrue: [ aTextPresenter text: ' ' asText,aText,Character null asString ]
	ifFalse: [ aTextPresenter text: Character null asText,aText,' ' ]
]

{ #category : #'update UI' }
SpPresenterFMRMain >> setCursorToEnd [
"Insane"

"^self textField adapter widget cursorEnd: anEvent."
self recordingInputField adapter widget textMorph editor selectAt: self newInputString size + 1


]

{ #category : #menu }
SpPresenterFMRMain >> setTableTypeTo: tableSpec [
self matchState setTableType: tableSpec.
self updateMatchSummary.
self updateUIState
]

{ #category : #'processing - real time' }
SpPresenterFMRMain >> showHeadlineStatisticsForCompletedGame [
"Game just ended - generate some real-time headline stats"

self showHeadlineStatisticsChartForGame: self matchState numberOfGames
]

{ #category : #'processing - real time' }
SpPresenterFMRMain >> showHeadlineStatisticsForGame: aGameNumber [
"Show headline stats for game aGameNumber"

self headlinePresenter ifNil: [
	self headlinePresenter: (SpPresenterHeadlineCharts newOn: self matchState) ].

(self headlinePresenter window isNil or: [ self headlinePresenter window isOpen not ])
	ifTrue: [ self headlinePresenter open ].

self headlinePresenter addPageForGameNumber: aGameNumber.
self headlinePresenter updateWindowTitle
]

{ #category : #'menu actions' }
SpPresenterFMRMain >> showHeadlineStatisticsNumbers [
"Show the headline stats for each game in turn"

self headlinePresenter ifNotNil: [
	self headlinePresenter window close.
	self headlinePresenter: nil ].

1 to: self matchState numberOfGames do: [ :eachGameNumber |
	self showHeadlineStatisticsNumbersForGame: eachGameNumber ]
]

{ #category : #'processing - real time' }
SpPresenterFMRMain >> showHeadlineStatisticsNumbersForGame: aGameNumber [
"Show headline stats for game aGameNumber"

self headlinePresenter ifNil: [
	self headlinePresenter: (SpPresenterFMRHeadlines newOn: self matchState) ].

(self headlinePresenter window isNil or: [ self headlinePresenter window isOpen not ])
	ifTrue: [ self headlinePresenter open ].

self headlinePresenter addPageForGameNumber: aGameNumber.
self headlinePresenter updateWindowTitle
]

{ #category : #accessing }
SpPresenterFMRMain >> statusBar [

	^ statusBar
]

{ #category : #accessing }
SpPresenterFMRMain >> statusBar: anObject [

	statusBar := anObject
]

{ #category : #logging }
SpPresenterFMRMain >> statusBarMessage: aText [

self statusBar pushMessage: aText.
FMRGrowlMorph growlProgressFor: 'Information' message: aText asString
]

{ #category : #menu }
SpPresenterFMRMain >> subMenuAnalyseDatabase [
	^ self newMenu
		addItem: [ :item | 
			item
				name: 'Generate and Open GOAT Awards';
				icon: (self iconNamed: #database);
				action: [ self generateAndOpenAwards ] ];
		addItem: [ :item | 
			item
				name: 'View all Goal Ladders';
				icon: (self iconNamed: #database);
				action: [ self viewAllGoatLadders ] ];
		addItem: [ :item | 
			item
				name: 'View all Possession Time Fractions';
				icon: (self iconNamed: #database);
				action: [ self viewAllPossessionTimeFractions ] ];
		addItem: [ :item | 
			item
				name: 'View all Transition Charts';
				icon: (self iconNamed: #database);
				action: [ self viewAllTransitionCharts ] ];
		addItem: [ :item | 
			item
				name: 'Top Win-correlating Statistics';
				icon: (self iconNamed: #database);
				action: [ self generateAndOpenWinCorrelates ] ];
		yourself
		


]

{ #category : #menu }
SpPresenterFMRMain >> subMenuDebug [
	^ self newMenu
		addItem: [ :item | 
			item
				name: 'Inspect Presenter';
				icon: (self iconNamed: #jump);
				action: [ self inspect ] ];
		addItem: [ :item | 
			item
				name: 'Inspect MatchState';
				icon: (self iconNamed: #jump);
				action: [ self matchState inspect ] ];
				addItem: [ :item | 
			item
				name: 'Inspect Statistics';
				icon: (self iconNamed: #jump);
				action: [ self matchState statisticsGenerator inspect ] ];		
		addItem: [ :item | 
			item
				name: 'Run Tests';
				icon: (self iconNamed: #testRunner);
				action: [ FMRCodeExporter runTests ] ];			
		yourself
		
	

]

{ #category : #menu }
SpPresenterFMRMain >> subMenuFile [
	^ self newMenu
		addItem: [ :item | 
			item
				name: 'Open matchplay recording finder...';
				icon: (self iconNamed: #smallLoadProject);
				action: [ self openFileFinder ] ];
		addItem: [ :item | 
			item
				name: 'Open matchplay recording...';
				icon: (self iconNamed: #smallLoadProject);
				action: [ self readFile ] ];
		addItem: [ :item | 
			item
				name: 'Save matchplay recording';
				icon: (self iconNamed: #smallSaveIcon);
				action: [ self saveFile ] ];
		addItem: [ :item | 
			item
				name: 'Save matchplay recording As...';
				icon: (self iconNamed: #smallSaveAs);
				action: [ self saveFileAs ] ];
		addItem: [ :item | 
			item
				name: 'Settings';
				icon: (self iconNamed: #configuration);
				action: [ self openSettings ] ];
		addItem: [ :item | 
			item
				name: 'Quit';
				icon: (self iconNamed: #smallQuit);
				action: [ self window close ] ];
		yourself
]

{ #category : #menu }
SpPresenterFMRMain >> subMenuHelp [
	^self newMenu
		addGroup: [ :aGroup |
			aGroup 
				addItem: [ :item |
					item
						name: 'FMR Licence';
						icon: (self iconNamed: #book);
						action: [ SpPresenterFMRAbout open ]];
				addItem: [ :item |
					item
						name: 'Features of the FMR System';
						icon: (self iconNamed: #book);
						action: [ self openFMRFeatures ]];
				addItem: [ :item |
					item
						name: 'Matchplay Recording Fundamentals';
						icon: (self iconNamed: #book);
						action: [ self openRecordingFundamentals ]];
				addItem: [ :item |
					item
						name: 'Recording Hint Sheet (Brief)';
						icon: (self iconNamed: #book);
						action: [ self openBriefHintSheet ]];
				addItem: [ :item |
					item
						name: 'Recording Hint Sheet (Complete)';
						icon: (self iconNamed: #book);
						action: [ self openHintSheet ]];
				addItem: [ :item |
					item
						name: 'Common Matchplay Idioms';
						icon: (self iconNamed: #book);
						action: [ self openCommonSequences ]];					
		
				addItem: [ :item |
					item
						name: 'Open All Help Windows';
						icon: (self iconNamed: #book);
						action: [ self openRecordingHelps ]];
				yourself ]
]

{ #category : #menu }
SpPresenterFMRMain >> subMenuHistory [
	^ self newMenu
		addItem: [ :item | 
			item
				name: 'Edit Matchplay History...';
				icon: (self iconNamed: #edit);
				action: [ self editHistoryPane ] ];
		addItem: [ :item | 
			item
				name: 'Cancel Matchplay History editing';
				icon: (self iconNamed: #delete);
				action: [ self cancelHistoryPaneEdit ] ];
		addItem: [ :item | 
			item
				name: 'Accept Matchplay History edits';
				icon: (self iconNamed: #glamorousRefresh);
				action: [ self updateRecording ] ];
		yourself
]

{ #category : #menu }
SpPresenterFMRMain >> subMenuRecording [
	^ self newMenu
		addItem: [ :item | 
			item
				name: 'New Matchplay Recording';
				icon: (self iconNamed: #smallNew);
				action: [ self newMatch ] ];
		addItem: [ :item | 
			item
				name: 'Table Type and Orientation';
				icon: (self iconNamed: #glamorousBrowse);
				subMenu: self subMenuTableType ];
		addItem: [ :item | 
			item
				name: 'Enter or Edit Match Details...';
				icon: (self iconNamed: #glamorousBrowse);
				action: [ self editMatchDetails ] ];
		addItem: [ :item | 
			item
				name: 'Restart Matchplay Recording (keep details)';
				icon: (self iconNamed: #refresh);
				action: [ self restartRecording ] ];

		yourself
		
	
]

{ #category : #menu }
SpPresenterFMRMain >> subMenuTableType [

^MatchState tableTypesAndColours
	inject: self newMenu
	into: [ :menu :ttac |
		menu
			addItem: [ :item |
				item
					name: ttac first;
					icon: (self iconNamed: #diff);
					subMenu: (self newMenu
						addItem: [ :subItem |
							subItem
								name: ttac second,' on left and ',ttac third,' on right';
								icon: (self iconNamed: #diff);
								action: [ self setTableTypeTo: ($, join: ttac) ]];
						addItem: [ :subItem |
							subItem
								name: ttac third,' on left and ',ttac second,' on right';
								icon: (self iconNamed: #diff);
								action: [ self setTableTypeTo: ($, join: {ttac first.ttac third.ttac second}) ]])	];
				yourself ]
]

{ #category : #timer }
SpPresenterFMRMain >> terminateTimerProcess [
"Ensure timer process terminated and update label"

self timerProcess
	ifNotNil: [ :process |
		process terminate.
		self timerProcess: nil.
		FMRGrowlMorph growlDebugFor: 'Timer' message: 'Timer process terminated.' ].

]

{ #category : #accessing }
SpPresenterFMRMain >> timerProcess [

	^ timerProcess
]

{ #category : #accessing }
SpPresenterFMRMain >> timerProcess: anObject [

	timerProcess := anObject
]

{ #category : #accessing }
SpPresenterFMRMain >> tournament [

	^ tournament
]

{ #category : #accessing }
SpPresenterFMRMain >> tournament: anObject [

	tournament := anObject
]

{ #category : #timer }
SpPresenterFMRMain >> updateCurrentEventDuration [

self timerProcess ifNotNil: [
	self matchState matchplayTimer isRunning ifTrue: [
		self recordingOutputFieldUpdate ]]

]

{ #category : #'update UI' }
SpPresenterFMRMain >> updateMatchSummary [
self window title: 'FMR Recording - ',self matchState matchDescriptionWithTeamName,' - ',self matchState matchStatusSummary.
self feedbackLabel label: self matchResultSummary.

self radioButtonElapsed help: 'Show the start time of each event relative to the start of the ',self elapsedRelativity

]

{ #category : #'menu actions - history pane editing' }
SpPresenterFMRMain >> updateRecording [
| newMatchState editedString errorStartIndex errorStopIndex |

newMatchState := MatchState new.
editedString := self historyPaneField text asString.
newMatchState commandProcessor shouldGrowlErrors: false; processRecordedString: editedString.
newMatchState commandProcessor hasRecordingErrors
	ifTrue: [
		"The size of the print string of all the events up to the last good one
		is the point where we want to start highlighting the error"
		errorStartIndex := (self matchplayEventPrinterHistoryPane copyFor: newMatchState) printMatchplayEventsUpToFirstError string size + 1.
		errorStopIndex := editedString indexOf: $} startingAt: errorStartIndex.
		self historyPaneField selectionInterval: (errorStartIndex to: errorStopIndex).
		FMRGrowlMorph
			growlErrorFor: 'Error in Recording Edit'
			message: 'Please fix the error at the highlighted location, or cancel the editing operation from the menu.' ]
	ifFalse: [
		(self confirmUpdateWith: newMatchState)
			ifTrue: [
				self historyPaneEditState: nil.
				self matchState: newMatchState flushCaches.
				self statusBarMessage: 'The new recording has ',self matchState matchplayEvents size asString,' events - remember to save it if necessary.'.
				self radioButtonNone state: true.
				self historyPaneField beNotEditable.
				self updateUIState ]
			ifFalse: [ self historyPaneEditState: #editing ]].
self menuEnableHistory 



]

{ #category : #'update UI' }
SpPresenterFMRMain >> updateUI [

| ps |

ps := self matchState latestMatchplayEventDo: [ :lme | lme printCurrentGameScore ] ifNone: [ '' ].
self pointScore text: ps.

self set: self leftTeamLabel text: self matchState leftSideTeamNameText.
self set: self rightTeamLabel text: self matchState rightSideTeamNameText.

self gameScoreLabel text: self matchState score printCompletedGameScores.

self matchState
	latestMatchplayEventDo: [ :lme |
		self leftTimeOutLabel text: (self matchState sideLeft asText: (lme printTimeOutTallyForSide: self matchState sideLeft)).
		self rightTimeOutLabel text: (self matchState sideRight asText: (lme printTimeOutTallyForSide: self matchState sideRight)) ]
	ifNone: [ ]
]

{ #category : #'update UI' }
SpPresenterFMRMain >> updateUIState [

self currentEventsSize: self matchState matchplayEvents size.

UIManager default defer: [self recordingInputField text: ''].

self recordingOutputField text: ''.
self matchState isEndMatch
	ifTrue: [	 self recordingInputField disable; placeholder: '' ]
	ifFalse: [ self recordingInputField enable; placeholder: 'Enter matchplay events here or ? for help...' ].	

self refreshHistoryPane.
self menuEnableHistory.
self updateUI

]

{ #category : #'menu actions' }
SpPresenterFMRMain >> viewAllGoatLadders [
| canvas gameDisplacementX gl |

canvas := RSCanvas new.
gameDisplacementX := 0.
MatchStateEnumerator new allMatchesDo: [ :eachMatchState |
	gl := FMRGoalLadder new matchState: eachMatchState.
	gl gameDisplacementX: gameDisplacementX.
	canvas := gl drawOnCanvas: canvas.
	gameDisplacementX := gameDisplacementX + 12 ].

canvas openWithTitle: 'Viewing Goal Ladders for All Recordings'
]

{ #category : #'menu actions' }
SpPresenterFMRMain >> viewAllPossessionTimeFractions [
(SpMatchStateTabPresenter basicNew modelClass: SpPresenterPossessionFraction) initialize openWithSpec
	title: 'Trawl Possession Time Limit Fraction';
	extent: 1800@900.
]

{ #category : #'menu actions' }
SpPresenterFMRMain >> viewAllTransitionCharts [
(SpMatchStateTabPresenter basicNew modelClass: SpPresenterPseudoRodTransitionChart) initialize openWithSpec
	title: 'Transition Charts';
	extent: 1800@900.
]

{ #category : #'update UI' }
SpPresenterFMRMain >> windowIsClosing [
self terminateTimerProcess
]
