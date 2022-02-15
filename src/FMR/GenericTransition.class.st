Class {
	#name : #GenericTransition,
	#superclass : #FMRTransition,
	#category : #FMR
}

{ #category : #'instance creation' }
GenericTransition class >> newFromInstanceTransition: anInstanceTransition [
"Answer a new GenericTransition instance created from anInstanceTransition"

| genericTeamKey |

genericTeamKey := #(#otherTeam #sameTeam) at: (anInstanceTransition fromRod key = anInstanceTransition toRod key) asBit + 1.
^(self 
	fromRod: #eitherTeam -> anInstanceTransition fromRod value
	toRod: genericTeamKey -> anInstanceTransition toRod value)
		matchState: anInstanceTransition matchState;
		transitionTally: anInstanceTransition transitionTally;
		yourself
	

]

{ #category : #printing }
GenericTransition >> printOn: aStream [
aStream
	<< self fromRod key asString;
	space;
	<< self fromRod value printPseudoRod;
	<< ' to ';
	<< self toRod key asString;
	space;
	<< self toRod value printPseudoRod;	
	<< ' - ';
	<< self transitionTally asString;
	<< ' [';
	<< self transitionProbability asString;
	<< ']'

]
