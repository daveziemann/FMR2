Class {
	#name : #SchemaChangeChecker,
	#superclass : #FMRObject,
	#instVars : [
		'sourceDirectory',
		'targetDirectory',
		'backupDirectory',
		'sourceFileContents',
		'targetFileContents',
		'fileUpdateBlocks'
	],
	#category : #FMR
}

{ #category : #'schema update' }
SchemaChangeChecker >> applyFileUpdatesTo: oldMatchplayString [
| newMatchplayString |
newMatchplayString := oldMatchplayString.
self fileUpdateBlocks do: [ :eachBlock | newMatchplayString := eachBlock value: newMatchplayString ].
^newMatchplayString
]

{ #category : #accessing }
SchemaChangeChecker >> backupDirectory [

	^ backupDirectory
]

{ #category : #accessing }
SchemaChangeChecker >> backupDirectory: anObject [

	backupDirectory := anObject
]

{ #category : #comparing }
SchemaChangeChecker >> clean: aString [
^(self stripIndex: aString) trim
]

{ #category : #comparing }
SchemaChangeChecker >> compareFileContents [
self sourceFileContents with: self targetFileContents do: [ :eachSourceLine :eachTargetLine |
	self compareSource: (self clean: eachSourceLine) withTarget: (self clean: eachTargetLine) ]
]

{ #category : #comparing }
SchemaChangeChecker >> compareFiles [
self sourceDirectoryEnumerator allFilesDo: [ :eachSourceFile |
	self sourceFileContents: (eachSourceFile contents tokensBasedOn: String cr).
	self targetFileContents: ((self targetDirectory asFileReference / eachSourceFile basename) contents tokensBasedOn: String cr).
	self compareFileContents ]

]

{ #category : #comparing }
SchemaChangeChecker >> compareMatchStates [
^self sourceDirectoryEnumerator allMatchesCollect: [ :aSourceMatchState |
	| targetMatchState |
	targetMatchState := MatchState readFile: (self sourceFileInTargetDirectory: aSourceMatchState sourceFileName asFileReference).
	aSourceMatchState matchplayEvents size -> targetMatchState matchplayEvents size ]
]

{ #category : #comparing }
SchemaChangeChecker >> compareSource: aSourceLine withTarget: aTargetLine [
(aSourceLine beginsWith: '@lastSaveDate') & (aTargetLine beginsWith: '@lastSaveDate') ifTrue: [ ^true ].
^aSourceLine = aTargetLine
]

{ #category : #'schema update' }
SchemaChangeChecker >> deployFromTargetDirectory [
"Deploy the files in the target directory:
	- backup the matchplay files from the MatchplayFiles directory to MatchplayFiles3
	- delete all files in the MatchplayFiles directory
	- copy the matchplay files from MatchplayFiles2 directory to MatchplayFiles"

| sourceChildren targetChildren |

"Backup - MatchplayFiles -> MatchplayFilesBackup"
self backupDirectory deleteAllChildren.
sourceChildren := self sourceDirectory children.
sourceChildren do: [ :eachSourceFile | eachSourceFile copyTo: self backupDirectory / eachSourceFile basename ].

"Assertions"
self assert: sourceChildren size = self backupDirectory children size.
self assert: sourceChildren size = self targetDirectory children size.

"Delete - MatchplayFiles"
self sourceDirectory deleteAllChildren.

"Deploy - MatchplayFiles2 -> MatchplayFiles"
targetChildren := self targetDirectory children.
targetChildren do: [ :eachTargetFile | eachTargetFile copyTo: self sourceDirectory / eachTargetFile basename ].


]

{ #category : #'schema update' }
SchemaChangeChecker >> doFileUpdate [

self emptyTargetDirectory.
self sourceDirectoryEnumerator allFilesDo: [ :eachSourceFile |
	| oldMatchplayString newMatchplayString targetFile |
	oldMatchplayString := eachSourceFile readStream contents.
	newMatchplayString := self applyFileUpdatesTo: oldMatchplayString.
	targetFile := self sourceFileInTargetDirectory: eachSourceFile.
	targetFile writeStreamDo: [ :s | s << newMatchplayString ]]

]

{ #category : #'schema update' }
SchemaChangeChecker >> doMatchStateUpdate [

self emptyTargetDirectory.
self sourceDirectoryEnumerator allMatchesDo: [ :eachMatchState |
	eachMatchState writeFile: (self sourceFileInTargetDirectory: eachMatchState sourceFileName) ]

]

{ #category : #comparing }
SchemaChangeChecker >> emptyBackupDirectory [
self backupDirectory asFileReference deleteAllChildren
]

{ #category : #comparing }
SchemaChangeChecker >> emptyTargetDirectory [
self assert: self sourceDirectory ~= self targetDirectory.
self targetDirectory asFileReference deleteAllChildren
]

{ #category : #accessing }
SchemaChangeChecker >> fileUpdateBlocks [

	^ fileUpdateBlocks
]

{ #category : #accessing }
SchemaChangeChecker >> fileUpdateBlocks: anObject [

	fileUpdateBlocks := anObject
]

{ #category : #initialization }
SchemaChangeChecker >> initialize [ 
self
	sourceDirectory: MatchState directoryForMatchplayFiles asFileReference;
	targetDirectory: (MatchState directoryForMatchplayFiles,'2') asFileReference;
	backupDirectory: (MatchState directoryForMatchplayFiles,'Backup') asFileReference.
]

{ #category : #'schema update' }
SchemaChangeChecker >> schemaBlocks_092 [
^{
	[ :s | s copyReplaceAll: '@url[' with: '@urlVideo[' ]
}

]

{ #category : #accessing }
SchemaChangeChecker >> sourceDirectory [

	^ sourceDirectory
]

{ #category : #accessing }
SchemaChangeChecker >> sourceDirectory: anObject [

	sourceDirectory := anObject
]

{ #category : #comparing }
SchemaChangeChecker >> sourceDirectoryEnumerator [
^MatchStateEnumerator new sourceDirectory: self sourceDirectory

]

{ #category : #accessing }
SchemaChangeChecker >> sourceFileContents [

	^ sourceFileContents
]

{ #category : #accessing }
SchemaChangeChecker >> sourceFileContents: anObject [

	sourceFileContents := anObject
]

{ #category : #access }
SchemaChangeChecker >> sourceFileInTargetDirectory: aSourceFile [
^self targetDirectory asFileReference ensureCreateDirectory / aSourceFile asFileReference basename

]

{ #category : #comparing }
SchemaChangeChecker >> stripIndex: aString [
^aString copyAfter: Character space
]

{ #category : #accessing }
SchemaChangeChecker >> targetDirectory [

	^ targetDirectory
]

{ #category : #accessing }
SchemaChangeChecker >> targetDirectory: anObject [

	targetDirectory := anObject
]

{ #category : #accessing }
SchemaChangeChecker >> targetFileContents [

	^ targetFileContents
]

{ #category : #accessing }
SchemaChangeChecker >> targetFileContents: anObject [

	targetFileContents := anObject
]

{ #category : #validation }
SchemaChangeChecker >> validTargetMatchplayRecordings [
"Make sure we can read all the new recordings"

(MatchStateEnumerator new sourceDirectory: self targetDirectory)
	allMatchesDo: [ :eachMatchState | ]
]
