Class {
	#name : #SpPresenterMatchplayFileFinder,
	#superclass : #'SpPresenterFMR_',
	#instVars : [
		'filesMatchingLabelField',
		'filesNotMatchingLabelField',
		'filesMatchingInputField',
		'filesNotMatchingInputField',
		'fileSelectionTallyLabelField',
		'filesFoundListField',
		'fileContentsField',
		'openFileButton',
		'closeButton',
		'lastSelectedFile'
	],
	#category : #FMR
}

{ #category : #API }
SpPresenterMatchplayFileFinder class >> defaultExtent [
^900@800
]

{ #category : #API }
SpPresenterMatchplayFileFinder class >> open [
| sp |

sp := self new.
sp openWithSpec extent: self defaultExtent.
sp postOpenMods.
^sp
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder >> closeButton [

	^ closeButton
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder >> closeButton: anObject [

	closeButton := anObject
]

{ #category : #initialization }
SpPresenterMatchplayFileFinder >> connectPresenters [

self filesMatchingInputField eventHandler whenFocusLostDo: [ self updateFilesFoundListField ].
self filesNotMatchingInputField eventHandler whenFocusLostDo: [ self updateFilesFoundListField ].
self filesMatchingInputField whenSubmitDo: [ self updateFilesFoundListField. self filesFoundListField takeKeyboardFocus ].
self filesNotMatchingInputField whenSubmitDo: [ self updateFilesFoundListField. self filesFoundListField takeKeyboardFocus ].

self filesFoundListField whenSelectionChangedDo: [ :selection | self updateFileContentsField ].
self filesFoundListField
	activateOnDoubleClick;
	whenActivatedDo: [ :selection | self openMatchplayFile: selection selectedItem ]

]

{ #category : #filtering }
SpPresenterMatchplayFileFinder >> file: aMatchplayFile matchesFilterField: aFilterField [
"We might be able to make the match on the name of the file without having to read it"

^(aFilterField text match: aMatchplayFile basename)
	ifTrue: [ true ]
	ifFalse: [ (aFilterField text tokensBasedOn: ',')
		anySatisfy: [ :eachCriterion | '*',eachCriterion,'*' match: aMatchplayFile contents ]] 

]

{ #category : #accessing }
SpPresenterMatchplayFileFinder >> fileContentsField [

	^ fileContentsField
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder >> fileContentsField: anObject [

	fileContentsField := anObject
]

{ #category : #filtering }
SpPresenterMatchplayFileFinder >> fileMatchesExclusionFilter: aMatchplayFile [
^self filesNotMatchingInputField text
	ifEmpty: [ false ]
	ifNotEmpty: [ self file: aMatchplayFile matchesFilterField: self filesNotMatchingInputField ]
]

{ #category : #filtering }
SpPresenterMatchplayFileFinder >> fileMatchesInclusionFilter: aMatchplayFile [
^self file: aMatchplayFile matchesFilterField: self filesMatchingInputField
]

{ #category : #filtering }
SpPresenterMatchplayFileFinder >> fileMatchesSelectionCriteria: aMatchplayFile [
^(self fileMatchesExclusionFilter: aMatchplayFile) not and: [ self fileMatchesInclusionFilter: aMatchplayFile ]
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder >> fileSelectionTallyLabelField [

	^ fileSelectionTallyLabelField
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder >> fileSelectionTallyLabelField: anObject [

	fileSelectionTallyLabelField := anObject
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder >> filesFoundListField [

	^ filesFoundListField
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder >> filesFoundListField: anObject [

	filesFoundListField := anObject
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder >> filesMatchingInputField [

	^ filesMatchingInputField
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder >> filesMatchingInputField: anObject [

	filesMatchingInputField := anObject
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder >> filesMatchingLabelField [

	^ filesMatchingLabelField
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder >> filesMatchingLabelField: anObject [

	filesMatchingLabelField := anObject
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder >> filesNotMatchingInputField [

	^ filesNotMatchingInputField
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder >> filesNotMatchingInputField: anObject [

	filesNotMatchingInputField := anObject
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder >> filesNotMatchingLabelField [

	^ filesNotMatchingLabelField
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder >> filesNotMatchingLabelField: anObject [

	filesNotMatchingLabelField := anObject
]

{ #category : #initialization }
SpPresenterMatchplayFileFinder >> initializePresenters [
| layoutInputs layoutButtons |

self filesMatchingLabelField: (self newLabel label: 'Include files matching:').
self filesNotMatchingLabelField: (self newLabel label: 'Exclude files matching:').

self filesMatchingInputField: self newTextInput.
self filesNotMatchingInputField: self newTextInput.

self fileSelectionTallyLabelField: (self newLabel label: 'Files selected: ').

self filesFoundListField: self newList.
self filesFoundListField
	disableSearch;
	withScrollBars;
	display: [ :aFileReference | aFileReference basename ].

self fileContentsField: self newText beNotEditable.

self openFileButton: self newButton.
self openFileButton
	label: 'Open Matchplay File';
	action: [ self openSelectedMatchplayFile ].
self closeButton: self newButton.
self closeButton
	label: 'Close';
	action: [ self window close ].

self focusOrder addAll: {self filesMatchingInputField.self filesNotMatchingInputField.self filesFoundListField}.

layoutInputs := SpBoxLayout newTopToBottom
	add: (SpBoxLayout newLeftToRight
		add: self filesMatchingLabelField withConstraints: [ :c | c width: 130 ];
		add: self filesMatchingInputField withConstraints: [ :c | c width: 200 ];
		add: ' ' withConstraints: [ :c | c width: 50 ];
		add: self filesNotMatchingLabelField withConstraints: [ :c | c width: 130 ];
		add: self filesNotMatchingInputField withConstraints: [ :c | c width: 200 ];
		yourself);
	yourself.
	
layoutButtons := SpBoxLayout newLeftToRight
	add: self openFileButton;
	add: self closeButton;
	yourself.
		
self layout: (SpBoxLayout newTopToBottom
	add: layoutInputs 	withConstraints: [ :c | c padding: 10; height: 40  ];
	add: self fileSelectionTallyLabelField withConstraints: [ :c | c width: 130 ];
	add: self filesFoundListField withConstraints: [ :c | c padding: 4 ];
	add: self fileContentsField withConstraints: [ :c | c padding: 4 ];
	add: layoutButtons withConstraints: [ :c | c padding: 4; height: StandardFonts defaultFont height + 15 ];
	yourself).
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder >> lastSelectedFile [

	^ lastSelectedFile
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder >> lastSelectedFile: anObject [

	lastSelectedFile := anObject
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder >> openFileButton [

	^ openFileButton
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder >> openFileButton: anObject [

	openFileButton := anObject
]

{ #category : #actions }
SpPresenterMatchplayFileFinder >> openMatchplayFile: aFileReference [

aFileReference ifNotNil: [ (MatchState readFile: aFileReference) open ]

]

{ #category : #actions }
SpPresenterMatchplayFileFinder >> openSelectedMatchplayFile [

self openMatchplayFile: self selectedFile
]

{ #category : #initialization }
SpPresenterMatchplayFileFinder >> postOpenMods [
self window title: 'FMR Matchplay File Finder'.
self updateFilesFoundListField
]

{ #category : #access }
SpPresenterMatchplayFileFinder >> selectedFile [
^self filesFoundListField selectedItem
]

{ #category : #access }
SpPresenterMatchplayFileFinder >> selectedMatchState [

^MatchState readFile: self lastSelectedFile
]

{ #category : #updating }
SpPresenterMatchplayFileFinder >> updateFileContentsField [
"One file was selected; show its contents"

self selectedFile
	ifNil: [ self fileContentsField text: 'No selection' ]
	ifNotNil: [ :aFileReference |
		self lastSelectedFile: aFileReference.
		self fileContentsField text: aFileReference contents ]
]

{ #category : #updating }
SpPresenterMatchplayFileFinder >> updateFilesFoundListField [
"One of the selection criteria changed; update the files selected"
| fileTally files |

fileTally := 0.
files := MatchStateEnumerator new allFilesSelect: [ :eachMatchplayFile |
	fileTally := fileTally + 1.
	self fileMatchesSelectionCriteria: eachMatchplayFile ].
self filesFoundListField items: files.

self fileSelectionTallyLabelField label: 'Files selected: ',files size asString,'/',fileTally asString

]
