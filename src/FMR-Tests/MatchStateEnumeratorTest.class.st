"
A MatchStateEnumeratorTest is a test class for testing the behavior of MatchStateEnumerator
"
Class {
	#name : #MatchStateEnumeratorTest,
	#superclass : #FMRTestCase,
	#category : #'FMR-Tests'
}

{ #category : #accessing }
MatchStateEnumeratorTest class >> defaultTimeLimit [
	^2 minutes
]

{ #category : #tests }
MatchStateEnumeratorTest >> testTestFiles [
| mse |

mse := MatchStateEnumerator new sourceDirectory: 'C:\Data\Foosball\FMR\MatchplayFilesForTesting'.
self assert: mse allMatchStateSizes values equals: #(442 574 488 418 281 404 434 339)

]
