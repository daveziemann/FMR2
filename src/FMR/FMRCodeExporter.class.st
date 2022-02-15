Class {
	#name : #FMRCodeExporter,
	#superclass : #CodeExporter,
	#category : #FMR
}

{ #category : #'file-out' }
FMRCodeExporter class >> fileOut [
| packagesFMR |

packagesFMR := #('FMR' 'FMR-Tests' 'BaselineOfFMR') collect: [ :e | self packageNamed: e].
packagesFMR do: [ :eachPackage | eachPackage fileOutFMR ]
]

{ #category : #'file-out' }
FMRCodeExporter class >> packageNamed: aString [
^RPackage allInstances detect: [ :eachPackage | eachPackage name = aString ]
]

{ #category : #'test runner' }
FMRCodeExporter class >> runTests [

ClyRunTestsForPackageOrClassGroupCommand new runTestsOf: (self packageNamed: 'FMR-Tests')

]

{ #category : #'file-out' }
FMRCodeExporter class >> writeSourceCodeFrom: aStream baseName: baseName isSt: stOrCsFlag [

	| extension targetFile |
	extension := stOrCsFlag ifTrue: ['st'] ifFalse: ['cs'].
	targetFile := 'C:\Data\Foosball\FMR\Code' asFileReference / baseName asFileName, extension.

	self writeSourceCodeFrom: aStream toFileReference: targetFile
]
