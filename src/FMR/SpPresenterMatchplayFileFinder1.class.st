Class {
	#name : #SpPresenterMatchplayFileFinder1,
	#superclass : #'SpPresenterFMR_',
	#instVars : [
		'filesMatchingLabelField',
		'filesNotMatchingLabelField',
		'filesMatchingInputField',
		'filesNotMatchingInputField',
		'filesFoundListField',
		'fileContentsField',
		'openFileButton',
		'closeButton'
	],
	#category : #FMR
}

{ #category : #accessing }
SpPresenterMatchplayFileFinder1 >> closeButton [

	^ closeButton
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder1 >> closeButton: anObject [

	closeButton := anObject
]

{ #category : #initialization }
SpPresenterMatchplayFileFinder1 >> connectPresenters [

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
SpPresenterMatchplayFileFinder1 >> file: aMatchplayFile matchesFilterField: aFilterField [
"We might be able to make the match on the name of the file without having to read it"

^(aFilterField text match: aMatchplayFile basename)
	ifTrue: [ true ]
	ifFalse: [ (aFilterField text tokensBasedOn: ',')
		anySatisfy: [ :eachCriterion | '*',eachCriterion,'*' match: aMatchplayFile contents ]] 

]

{ #category : #accessing }
SpPresenterMatchplayFileFinder1 >> fileContentsField [

	^ fileContentsField
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder1 >> fileContentsField: anObject [

	fileContentsField := anObject
]

{ #category : #filtering }
SpPresenterMatchplayFileFinder1 >> fileMatchesExclusionFilter: aMatchplayFile [
^self filesNotMatchingInputField text
	ifEmpty: [ false ]
	ifNotEmpty: [ self file: aMatchplayFile matchesFilterField: self filesNotMatchingInputField ]
]

{ #category : #filtering }
SpPresenterMatchplayFileFinder1 >> fileMatchesInclusionFilter: aMatchplayFile [
^self file: aMatchplayFile matchesFilterField: self filesMatchingInputField
]

{ #category : #filtering }
SpPresenterMatchplayFileFinder1 >> fileMatchesSelectionCriteria: aMatchplayFile [
^(self fileMatchesExclusionFilter: aMatchplayFile) not and: [ self fileMatchesInclusionFilter: aMatchplayFile ]
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder1 >> filesFoundListField [

	^ filesFoundListField
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder1 >> filesFoundListField: anObject [

	filesFoundListField := anObject
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder1 >> filesMatchingInputField [

	^ filesMatchingInputField
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder1 >> filesMatchingInputField: anObject [

	filesMatchingInputField := anObject
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder1 >> filesMatchingLabelField [

	^ filesMatchingLabelField
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder1 >> filesMatchingLabelField: anObject [

	filesMatchingLabelField := anObject
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder1 >> filesNotMatchingInputField [

	^ filesNotMatchingInputField
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder1 >> filesNotMatchingInputField: anObject [

	filesNotMatchingInputField := anObject
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder1 >> filesNotMatchingLabelField [

	^ filesNotMatchingLabelField
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder1 >> filesNotMatchingLabelField: anObject [

	filesNotMatchingLabelField := anObject
]

{ #category : #initialization }
SpPresenterMatchplayFileFinder1 >> initializePresenters [
| layoutInputs layoutButtons |

self filesMatchingLabelField: (self newLabel label: 'Include files matching:').
self filesNotMatchingLabelField: (self newLabel label: 'Exclude files matching:').

self filesMatchingInputField: self newTextInput.
self filesNotMatchingInputField: self newTextInput.

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
	add: self filesFoundListField withConstraints: [ :c | c padding: 4 ];
	add: self fileContentsField withConstraints: [ :c | c padding: 4 ];
	add: layoutButtons withConstraints: [ :c | c padding: 4; height: StandardFonts defaultFont height + 15 ];
	yourself).
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder1 >> openFileButton [

	^ openFileButton
]

{ #category : #accessing }
SpPresenterMatchplayFileFinder1 >> openFileButton: anObject [

	openFileButton := anObject
]

{ #category : #actions }
SpPresenterMatchplayFileFinder1 >> openMatchplayFile: aFileReference [

aFileReference ifNotNil: [ (MatchState readFile: aFileReference) open ]

]

{ #category : #actions }
SpPresenterMatchplayFileFinder1 >> openSelectedMatchplayFile [

self openMatchplayFile: self selectedFile
]

{ #category : #initialization }
SpPresenterMatchplayFileFinder1 >> postOpenMods [
self window title: 'FMR Matchplay File Finder'.
self updateFilesFoundListField
]

{ #category : #access }
SpPresenterMatchplayFileFinder1 >> selectedFile [
^self filesFoundListField selectedItem
]

{ #category : #updating }
SpPresenterMatchplayFileFinder1 >> updateFileContentsField [
"One file was selected; show its contents"

self selectedFile
	ifNil: [ self fileContentsField text: 'No selection' ]
	ifNotNil: [ :aFileReference | self fileContentsField text: aFileReference contents ]
]

{ #category : #updating }
SpPresenterMatchplayFileFinder1 >> updateFilesFoundListField [
"One of the selection criteria changed; update the files selected"
| files |

files := MatchStateEnumerator new allFilesSelect: [ :eachMatchplayFile | self fileMatchesSelectionCriteria: eachMatchplayFile ].
self filesFoundListField items: files

]
