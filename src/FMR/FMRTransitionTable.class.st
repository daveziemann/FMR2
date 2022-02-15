Class {
	#name : #FMRTransitionTable,
	#superclass : #FMRObject,
	#instVars : [
		'matchState',
		'transitionTable'
	],
	#category : #FMR
}

{ #category : #adding }
FMRTransitionTable >> addTransition: aTransition [
"Update the receiver's version of aTransition with its tally"

(self atTransition: aTransition) addToTally: aTransition transitionTally
]

{ #category : #adding }
FMRTransitionTable >> addTransitionTable: aTransitionTable [
"Add all the tallies in the transitions in aTransitionTable to the receiver's versions"

aTransitionTable transitionsDo: [ :eachTransition | self addTransition: eachTransition ]
]

{ #category : #access }
FMRTransitionTable >> allRods [
^{Rod2.Rod5.Rod3.Goal}
]

{ #category : #access }
FMRTransitionTable >> atTransition: aTransition [
^(self transitionTable at: aTransition fromRod) at: aTransition toRod

]

{ #category : #initializing }
FMRTransitionTable >> bind: teams with: rods [
^OrderedCollection new
	in: [ :keys |
		teams do: [ :eachTeam | rods do: [ :eachRod | keys add: eachTeam->eachRod ]].
		keys ]

]

{ #category : #access }
FMRTransitionTable >> fromTeams [
^self subclassResponsibility 
]

{ #category : #accessing }
FMRTransitionTable >> matchState [

	^ matchState
]

{ #category : #accessing }
FMRTransitionTable >> matchState: anObject [

	matchState := anObject
]

{ #category : #initializing }
FMRTransitionTable >> newLeafTransitionDictionaryFor: anAssociation [
^(self bind: self toTeams with: self allRods)
	inject: OrderedDictionary new
	into: [ :theDictionary :eachAssociation | | transition |
		transition := (self transitionClass fromRod: anAssociation toRod: eachAssociation)
			matchState: self matchState;
			yourself.
		theDictionary
			at: eachAssociation
			put: transition;
		yourself ]
]

{ #category : #initializing }
FMRTransitionTable >> newTransitionDictionary [
^(self bind: self fromTeams with: self allRods)
	inject: OrderedDictionary new
	into: [ :theDictionary :eachAssociation |
		theDictionary
			at: eachAssociation
			put: (self newLeafTransitionDictionaryFor: eachAssociation);
			yourself ]
]

{ #category : #arithmetic }
FMRTransitionTable >> normalise [
"Compute and store the normalised probability of each transition over the sum of all the tallies
	- also store the number of controlled possessions on the fromRod in each transition"

self transitionTable keysAndValuesDo: [ :fromKey :dictionary |
	| sum |
	sum := dictionary values inject: 0 into: [ :c :e | c + e transitionTallyNonSelf ].
	dictionary keysAndValuesDo: [ :toKey :transition |
		transition fromRodTally: sum.
		transition transitionProbability: ((transition transitionTally asFloat / sum) round: 2) ]]
		
]

{ #category : #initializing }
FMRTransitionTable >> populate [ 
self transitionTable: self newTransitionDictionary
]

{ #category : #access }
FMRTransitionTable >> toTeams [
^self subclassResponsibility 
]

{ #category : #access }
FMRTransitionTable >> transitionAtFromRod: fromRod toRod: toRod [
^(self transitionTable at: fromRod) at: toRod

]

{ #category : #'instance creation' }
FMRTransitionTable >> transitionClass [
^self subclassResponsibility 
]

{ #category : #accessing }
FMRTransitionTable >> transitionTable [

	^ transitionTable
]

{ #category : #accessing }
FMRTransitionTable >> transitionTable: anObject [

	transitionTable := anObject
]

{ #category : #enumerating }
FMRTransitionTable >> transitionsDo: aOneArgBlock [
self transitionTable valuesDo: [ :dictionary |
	dictionary valuesDo: [ :instanceTransition | 
		aOneArgBlock value: instanceTransition ]]
]
