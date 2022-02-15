Class {
	#name : #TransitionTableGenerator,
	#superclass : #FMRStatistics,
	#instVars : [
		'matchState',
		'transitionTable'
	],
	#category : #FMR
}

{ #category : #arithmetic }
TransitionTableGenerator >> addDictionary: aDictionary to: anotherDictionary [
| summedDictionary |

summedDictionary := aDictionary veryDeepCopy.
anotherDictionary keysAndValuesDo: [ :key :number |
	| oldNumber |
	oldNumber := summedDictionary at: key ifAbsent: [ 0 ].	 
	summedDictionary at: key	put: oldNumber + number ].
^summedDictionary
]

{ #category : #generating }
TransitionTableGenerator >> generateTransitionTable [
^self subclassResponsibility 
]

{ #category : #initializing }
TransitionTableGenerator >> initialize [ 

]

{ #category : #accessing }
TransitionTableGenerator >> matchState [

	^ matchState
]

{ #category : #accessing }
TransitionTableGenerator >> matchState: anObject [

	matchState := anObject
]

{ #category : #accessing }
TransitionTableGenerator >> transitionTable [

	^ transitionTable
]

{ #category : #accessing }
TransitionTableGenerator >> transitionTable: anObject [

	transitionTable := anObject
]

{ #category : #arithmetic }
TransitionTableGenerator >> transitionTable: aTransitionTable plusTransitionTable: anotherTransitionTable [
| summedTransitionTable |

aTransitionTable ifNil: [ ^anotherTransitionTable veryDeepCopy ].

summedTransitionTable := OrderedDictionary new.
aTransitionTable keysAndValuesDo: [ :thisKey :dictionary |
	summedTransitionTable
		at: thisKey 
		put: (	self
			addDictionary: dictionary
			to: (anotherTransitionTable at: thisKey ifAbsent: [ OrderedDictionary new ])) ].
^summedTransitionTable
]
