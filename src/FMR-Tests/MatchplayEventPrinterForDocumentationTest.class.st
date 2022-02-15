"
A MatchplayEventPrinterForDocumentationTest is a test class for testing the behavior of MatchplayEventPrinterForDocumentation
"
Class {
	#name : #MatchplayEventPrinterForDocumentationTest,
	#superclass : #FMRTestCase,
	#category : #'FMR-Tests'
}

{ #category : #tests }
MatchplayEventPrinterForDocumentationTest >> testSequencePrint [
| sequence text |
sequence := '5.3.2!.2'.
text := MatchplayEventPrinter forDocumentation printForSequence: sequence.
self assert: text asString equals: sequence.
self assert: (text attributesAt: 1) first color ~= (text attributesAt: 8) first color
]
