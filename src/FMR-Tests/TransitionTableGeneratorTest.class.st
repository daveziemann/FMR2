"
A TransitionTableGeneratorTest is a test class for testing the behavior of TransitionTableGenerator
"
Class {
	#name : #TransitionTableGeneratorTest,
	#superclass : #FMRTestCase,
	#category : #'FMR-Tests'
}

{ #category : #tests }
TransitionTableGeneratorTest >> testGenericTransitionTableGeneration [
| ttg |

ttg := GenericTransitionTableGenerator new matchState: self matchState.

self
	assert: ttg generateTransitionTable transitionTable transitionTable flattened size
	equals: 32
]

{ #category : #tests }
TransitionTableGeneratorTest >> testInstanceTransitionTableGeneration [
| ttg |

ttg := InstanceTransitionTableGenerator new matchState: self matchState.

self
	assert: ttg generateTransitionTable transitionTable transitionTable flattened size
	equals: 64
]

{ #category : #tests }
TransitionTableGeneratorTest >> testTransitionTableGenerationOverAllMatches [
self assert:
	GenericTransitionTableGeneratorForMatches new generateTransitionTable transitionTable transitionTable flattened size
	equals: 32.
]
