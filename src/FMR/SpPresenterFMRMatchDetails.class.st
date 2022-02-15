Class {
	#name : #SpPresenterFMRMatchDetails,
	#superclass : #'SpPresenterFMR_',
	#instVars : [
		'presenterFMR',
		'matchState',
		'tournament',
		'event',
		'match',
		'team1',
		'team2',
		'urlVideo',
		'urlChart',
		'matchDate',
		'actionBar',
		'action',
		'tableTypeDropList',
		'tableColourMorph',
		'recorder',
		'explainer',
		'lastSaveDate',
		'comment',
		'videoMatchStartOffset',
		'statePack'
	],
	#category : #FMR
}

{ #category : #configuration }
SpPresenterFMRMatchDetails class >> defaultExtent [
^760@660
]

{ #category : #'instance creation' }
SpPresenterFMRMatchDetails class >> open [
^self new openWithSpec
	extent: self defaultExtent;
	yourself
]

{ #category : #'instance creation' }
SpPresenterFMRMatchDetails class >> openOn: presenter [
| p |
p := self new
	presenterFMR: presenter;
	matchState: presenter matchState.
p openWithSpec extent: self defaultExtent.
p postOpenMods.
^p
]

{ #category : #configuration }
SpPresenterFMRMatchDetails class >> title [
^'Foosball Match Recorder - Match Details'
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> action [

	^ action
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> action: anObject [

	action := anObject
]

{ #category : #action }
SpPresenterFMRMatchDetails >> actionAccept [

self matchState updateMatchDetailsFrom: self.
self presenterFMR updateMatchSummary; updateUIState.
self action: #actionAccept.
self window close.
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> actionBar [

	^ actionBar
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> actionBar: anObject [

	actionBar := anObject
]

{ #category : #action }
SpPresenterFMRMatchDetails >> actionCancel [
self action: #actionCancel.
self window close.
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> comment [

	^ comment
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> comment: anObject [

	comment := anObject
]

{ #category : #initialization }
SpPresenterFMRMatchDetails >> connectPresenters [
self matchDate eventHandler whenFocusLostDo: [ self validateMatchDate ]
]

{ #category : #initialization }
SpPresenterFMRMatchDetails >> createActionBar [

actionBar := self newActionBar
	add: (self newButton
		label: 'Accept'; 
		icon: (self iconNamed: #smallOk);
		help: 'Accept.';
		action: [ UIManager default defer: [ self actionAccept ] ];
		yourself);
	add: (self newButton
		label: 'Cancel'; 
		icon: (self iconNamed: #smallCancel);
		help: 'Cancel.';
		action: [ UIManager default defer: [ self actionCancel ] ];
		yourself);
	yourself.
]

{ #category : #initialization }
SpPresenterFMRMatchDetails >> createTableDropList [

tableColourMorph := self newMorph.
tableColourMorph morph: PanelMorph new.
tableColourMorph morph changeTableLayout.
tableColourMorph morph listDirection: #bottomToLeft.

tableTypeDropList := self newDropList.
tableTypeDropList
	items: self tableTypeAndColourOptions;
	display: [ :e | e ];
	whenSelectedItemChangedDo: [ :m | 
		tableColourMorph morph
			removeAllMorphs;
			addMorph: (self morphRight: m);
			addMorph: (self morphLeft: m) ];
	help: self helpTableTypeDropList

]

{ #category : #date }
SpPresenterFMRMatchDetails >> dateFromDayMonthYear: aString [
"Answer the Date represented by aString
	- if it's not valid date then answer nil"

| string date |

string := aString trim.
date := [ string asDate ] onErrorDo: [ :ex |
	"Deal with DD-MM-YYYY"
	[ ($- join: (string substrings: '-. ') reversed) asDate ] onErrorDo: [ :ex2 | nil ]].
^date ifNotNil: [ date year > 1900 ifTrue: [ date ]]
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> event [

	^ event
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> event: anObject [

	event := anObject
]

{ #category : #help }
SpPresenterFMRMatchDetails >> helpEvent [
^'Enter the name of the event here, e.g. Open Singles, Open Doubles.'
]

{ #category : #help }
SpPresenterFMRMatchDetails >> helpExplainer [
^'Please enter the table type, the puppet colours, and the names of the two teams. This information will help with matchplay
recording. Then identify the tournament, event, match and match date. This information will be used to save and later
identify the matchplay recording. You can also enter the URL of the video from which the recording was made, and the name
of the person who made this FMR matchplay recording. More help is avilable by hovering the cursor over each field.'
]

{ #category : #help }
SpPresenterFMRMatchDetails >> helpMatch [
^'Identify the match by entering which stage of the tournament it occcurred in, e.g.: Winner Bracket Round of 16.'
]

{ #category : #help }
SpPresenterFMRMatchDetails >> helpMatchDate [
^'Enter the date that this match occurred. Example formats: 3Apr2021, 3-Apr-2021, 3-4-2021.'
]

{ #category : #help }
SpPresenterFMRMatchDetails >> helpRecorder [
^'Identify the person who made this matchplay recording.'
]

{ #category : #help }
SpPresenterFMRMatchDetails >> helpTableTypeDropList [
^'Please select the table type and table orientation. The first colour is for the puppets on the left of the table, and the second colour is for the puppets on the right side of the table.'
]

{ #category : #help }
SpPresenterFMRMatchDetails >> helpTeam1 [
^'Enter the name of the team starting on the left side of the table. For a singles match enter the name of the player. For a doubles match enter the names of both players separated by an ampersand (&). The first name should be that of the player who starts in the forward position.'

]

{ #category : #help }
SpPresenterFMRMatchDetails >> helpTeam2 [
^'Enter the name of the team starting on the right side of the table. For a singles match enter the name of the player. For a doubles match enter the names of both players separated by an ampersand (&). The first name should be that of the player who starts in the forward position.'

]

{ #category : #help }
SpPresenterFMRMatchDetails >> helpTournament [
^'Enter the name of the tournament.'
]

{ #category : #help }
SpPresenterFMRMatchDetails >> helpURLChart [
^'If the match you are recording has an event chart or bracket on a publically available website, enter the URL here.'
]

{ #category : #help }
SpPresenterFMRMatchDetails >> helpURLVideo [
^'If you are recording this match from a publically available video, enter the URL of the video here. With this information you can play the video directly from the FMR window.'
]

{ #category : #initialization }
SpPresenterFMRMatchDetails >> initializePresenters [

explainer := self newText withoutScrollBars beNotEditable beWrapWord; text: self helpExplainer.

tournament := self newTextInput help: self helpTournament; placeholder: 'Enter the name of tournament here...'.
event := self newTextInput help: self helpEvent; placeholder: 'Enter the name of event here, e.g. Open Singles...'.
match := self newTextInput help: self helpMatch; placeholder: 'Enter the name of match here, e.g. WB Round of 16...'.
matchDate := self newTextInput help: self helpMatchDate; placeholder: 'Enter the date that the match took place...'.
team1 := self newTextInput help: self helpTeam1; placeholder: 'Enter the name of the team on the left here...'.
team2 := self newTextInput help: self helpTeam2; placeholder: 'Enter the name of the team on the right team here...'.
urlVideo := self newTextInput help: self helpURLVideo; placeholder: 'Enter a link to the source video...'.
urlChart := self newTextInput help: self helpURLChart; placeholder: 'Enter a link to the event chart...'.
videoMatchStartOffset := self newTextInput help: ''; placeholder: 'Enter the time in the video when the match starts (e.g. 7m42s)'.
comment := self newTextInput help: ''; placeholder: 'Any comment about the match or the recording'.
recorder := self newTextInput help: self helpRecorder; placeholder: 'Enter the name of the person who recorded this match...'.
lastSaveDate := self newLabel help: 'This is the date on which this matchplay recording was last saved.'.

self createActionBar.
self createTableDropList.

self layout: (SpBoxLayout newTopToBottom vAlignStart;
	add: (SpBoxLayout newLeftToRight
	add: explainer withConstraints: [ :c | c padding: 10; width: 710; height: 110; expand: false ];
	yourself)
	withConstraints: [ :c | c padding: 10; height: 110; expand: false ];
	
	add: (SpBoxLayout newLeftToRight
		add: 'Table type :' withConstraints: [ :c | c width: 100; expand: false ];
		add: #tableTypeDropList withConstraints: [ :c | c width: 200; expand: false ];
		add: #tableColourMorph withConstraints: [ :c | c width: 100; expand: false ];
		yourself)
	withConstraints: [ :c | c height: self class toolbarHeight+8; padding: 4; expand: false ];
	add: (SpBoxLayout newLeftToRight 
		add: 'Team on left :' withConstraints: [ :c | c width: 100; expand: false ];
		add: team1 withConstraints: [ :c | c width: 600; expand: false ];
		yourself)
	withConstraints: [ :c | c padding: 4; expand: false ];
	add: (SpBoxLayout newLeftToRight 
		add: 'Team on right :' withConstraints: [ :c | c width: 100; expand: false ];
		add: team2 withConstraints: [ :c | c width: 600; expand: false ];
		yourself)
	withConstraints: [ :c | c padding: 4; expand: false ];
	
	add: (SpBoxLayout newLeftToRight   
		add: 'Tournament :' withConstraints: [ :c | c width: 100; expand: false ];
		add: tournament withConstraints: [ :c | c width: 600; expand: false ];
		yourself)
	withConstraints: [ :c | c padding: 4; expand: false ];
	add: (SpBoxLayout newLeftToRight
		add: 'Event :' withConstraints: [ :c | c width: 100; expand: false ];
		add: event withConstraints: [ :c | c width: 600; expand: false ];
		yourself)
	withConstraints: [ :c | c padding: 4; expand: false ];
	add: (SpBoxLayout newLeftToRight 
		add: 'Match :' withConstraints: [ :c | c width: 100; expand: false ];
		add: match withConstraints: [ :c | c width: 600; expand: false ];
		yourself)
	withConstraints: [ :c | c padding: 4; expand: false ];
	add: (SpBoxLayout newLeftToRight 
		add: 'Match date :' withConstraints: [ :c | c width: 100; expand: false ];
		add: self matchDate withConstraints: [ :c | c width: 300; expand: false ];
		yourself)
	withConstraints: [ :c | c padding: 4; expand: false ];

	add: '' withConstraints: [ :c | c padding: 4; expand: false ];
	add: 'Optional:' withConstraints: [ :c | c padding: 4; expand: false ];

	add: (SpBoxLayout newLeftToRight 
		add: 'Video URL :' withConstraints: [ :c | c width: 100; expand: false ];
		add: urlVideo withConstraints: [ :c | c width: 600; expand: false ];
		yourself)
	withConstraints: [ :c | c padding: 4; expand: false ];
	
	add: (SpBoxLayout newLeftToRight 
		add: 'Video offset :' withConstraints: [ :c | c width: 100; expand: false ];
		add: videoMatchStartOffset withConstraints: [ :c | c width: 600; expand: false ];
		yourself)
	withConstraints: [ :c | c padding: 4; expand: false ];
	
	add: (SpBoxLayout newLeftToRight 
		add: 'Chart URL :' withConstraints: [ :c | c width: 100; expand: false ];
		add: urlChart withConstraints: [ :c | c width: 600; expand: false ];
		yourself)
	withConstraints: [ :c | c padding: 4; expand: false ];

	add: (SpBoxLayout newLeftToRight 
		add: 'Comment: ' withConstraints: [ :c | c width: 100; expand: false ];
		add: comment withConstraints: [ :c | c width: 600; expand: false ];
		yourself)
	withConstraints: [ :c | c padding: 4; expand: false ];
	
	add: (SpBoxLayout newLeftToRight 
		add: 'Recorder:' withConstraints: [ :c | c width: 100; expand: false ];
		add: recorder withConstraints: [ :c | c width: 600; expand: false ];
		yourself)
	withConstraints: [ :c | c padding: 4; expand: false ];

	add: '' withConstraints: [ :c | c padding: 4; expand: false ];
	
	add: (SpBoxLayout newLeftToRight 
		add: 'Last save date :' withConstraints: [ :c | c width: 100; expand: false ];
		add: lastSaveDate withConstraints: [ :c | c width: 150; expand: false ];
		yourself)
	withConstraints: [ :c | c padding: 14; expand: false ];

	add: #actionBar expand: false fill: false padding: 8;
	yourself).
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> lastSaveDate [

	^ lastSaveDate
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> lastSaveDate: anObject [

	lastSaveDate := anObject
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> match [

	^ match
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> match: anObject [

	match := anObject
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> matchDate [

	^ matchDate
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> matchDate: anObject [

	matchDate := anObject
]

{ #category : #date }
SpPresenterFMRMatchDetails >> matchDateAsDate [
"Answer the Date represented by entered match date
	- if it's not valid date then answer nil"

^MatchState dateFromDayMonthYear: self matchDate text 
]

{ #category : #date }
SpPresenterFMRMatchDetails >> matchDateString [
"Answer a String, the canonical respresentation of the entered date
	- if it's not a valid date then answer the entered text"

^(MatchState dateFromDayMonthYear: self matchDate text)
	ifNil: [ self matchDate text ]
	ifNotNil:[ :date | date yyyymmdd ]
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> matchState [

	^ matchState
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> matchState: anObject [

	matchState := anObject
]

{ #category : #initialization }
SpPresenterFMRMatchDetails >> morphLeft: aTableTypeAndColour [

^Morph new
	color: (FMRColour colorFromColourName: (aTableTypeAndColour tokensBasedOn: ',') second);
	width: 30;
	height: 30;
	yourself
]

{ #category : #initialization }
SpPresenterFMRMatchDetails >> morphRight: aTableTypeAndColour [

^Morph new
	color: (FMRColour colorFromColourName: (aTableTypeAndColour tokensBasedOn: ',') third);
	width: 30;
	height: 30;
	yourself
]

{ #category : #initialization }
SpPresenterFMRMatchDetails >> postOpenMods [
| index |
index := self tableTypeAndColourOptions indexOf: self matchState table asString.
index isZero ifFalse: [ tableTypeDropList selectIndex: index ].
self tournament text: self matchState tournament.
self event text: self matchState event.
self match text: self matchState match.
self matchDate text: self matchState matchDate.
self team1 text: self matchState teamOne teamName.
self team2 text: self matchState teamTwo teamName.
self urlVideo text: self matchState urlVideo.
self urlChart text: self matchState urlChart.
self videoOffset text: self matchState videoOffset.
self comment text: self matchState comment.
self recorder text: self matchState recorder.
self lastSaveDate label: (self matchState lastSaveDate ifNil: [ '' ] ifNotNil: [ :d | d asString ]).

self presenterFMR feedbackLabel label: self matchState matchStatusSummary.
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> presenterFMR [

	^ presenterFMR
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> presenterFMR: anObject [

	presenterFMR := anObject
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> recorder [

	^ recorder
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> recorder: anObject [

	recorder := anObject
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> statePack [

	^ statePack
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> statePack: anObject [

	statePack := anObject
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> tableColourMorph [

	^ tableColourMorph
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> tableColourMorph: anObject [

	tableColourMorph := anObject
]

{ #category : #initialization }
SpPresenterFMRMatchDetails >> tableTypeAndColourOptions [
^MatchState tableTypesAndColours
	inject: OrderedCollection new
	into: [  :c :e |
		c
			add: (e first,',',e second,',',e third);
			add: (e first,',',e third,',',e second);
			yourself ]
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> tableTypeDropList [

	^ tableTypeDropList
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> tableTypeDropList: anObject [

	tableTypeDropList := anObject
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> team1 [

	^ team1
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> team1: anObject [

	team1 := anObject
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> team2 [

	^ team2
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> team2: anObject [

	team2 := anObject
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> tournament [

	^ tournament
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> tournament: anObject [

	tournament := anObject
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> urlChart [

	^ urlChart
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> urlChart: anObject [

	urlChart := anObject
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> urlVideo [

	^ urlVideo
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> urlVideo: anObject [

	urlVideo := anObject
]

{ #category : #date }
SpPresenterFMRMatchDetails >> validateMatchDate [
self matchDateAsDate ifNil: [
	FMRGrowlMorph
		growlWarningFor: 'Match Details - Match Date'
		message: 'Enter exact match date if possible.'.
	"UIManager default defer: [ self matchDate takeKeyboardFocus ]" ]
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> videoOffset [

	^ videoMatchStartOffset
]

{ #category : #accessing }
SpPresenterFMRMatchDetails >> videoOffset: anObject [

	videoMatchStartOffset := anObject
]
