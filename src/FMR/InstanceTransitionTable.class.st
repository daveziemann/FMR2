Class {
	#name : #InstanceTransitionTable,
	#superclass : #FMRTransitionTable,
	#category : #FMR
}

{ #category : #access }
InstanceTransitionTable >> allTeams [ 
^#(1 2)
]

{ #category : #access }
InstanceTransitionTable >> fromTeams [ 
^self allTeams
]

{ #category : #printing }
InstanceTransitionTable >> printPseudoRod: aPseudoRod [
^'Team ',aPseudoRod key asString,' ',aPseudoRod value printPseudoRod
]

{ #category : #access }
InstanceTransitionTable >> toTeams [ 
^self allTeams
]

{ #category : #'instance creation' }
InstanceTransitionTable >> transitionClass [
^InstanceTransition
]
