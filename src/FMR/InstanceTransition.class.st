Class {
	#name : #InstanceTransition,
	#superclass : #FMRTransition,
	#category : #FMR
}

{ #category : #'instance creation' }
InstanceTransition class >> fromEvent: fromEvent toEvent: toEvent [
"Anser a new instance of the receiver created from the from and to PseudoRod events"

^(self
	fromRod: fromEvent teamWithOwnershipIndex -> fromEvent class
	toRod: toEvent teamWithOwnershipIndex -> toEvent class)
		transitionTally: 1;
		yourself

]

{ #category : #printing }
InstanceTransition >> explainText [
^self isSelfTransition 
	ifTrue: [ self explainTextForSelfTranstion ]
	ifFalse: [ self explainTextForNonSelfTransition ]
]

{ #category : #printing }
InstanceTransition >> explainTextForNonSelfTransition [
| fromTeam toTeam fRod tRod prob sense |

fromTeam := (self matchState teams at: self fromRod key) teamName.
toTeam := (self matchState teams at: self toRod key) teamName.
fRod := self fromRod value printPseudoRod.
tRod := self toRod value printPseudoRod.
prob := self transitionProbability printShowingDecimalPlaces: 2.
sense := (self isSameTeamTransition xor: (self toRod value=Goal))
	ifTrue: [ 'their own ' ] ifFalse: [ 'the other team''s ' ].

^String streamContents: [ :s |
	s
		<< 'Out of a total of ';
		<< self fromRodTally asString;
		<< ' controlled possessions on ';
		<< fromTeam;
		<< '''s ';
		<< fRod;
		<< ' there were ';
		<< self transitionTally asString;
		<< ' transitions to ';
		<< sense;
		<< tRod;
		<< ', for a transition probability of ';
		<< prob;
		yourself ]
		
	

]

{ #category : #printing }
InstanceTransition >> explainTextForSelfTranstion [
| fromTeam fRod |

fromTeam := (self matchState teams at: self fromRod key) teamName.
fRod := self fromRod value printPseudoRod.

^String streamContents: [ :s |
	s
		<< 'Only controlled possessions are counted when computing the Transition Table. It is possible for FMR to record a transition from one rod to the same rod for the same team. This can happen when a Time-out is called during active play, or if there is an intervening uncontrolled possession on an another rod. FMR will record such transitions, but they are excluded from the total number of controlled possessions that is used to calculate the transition probabilities for the other to-rods.';
		cr; cr;
		<< 'Out of a total of ';
		<< self fromRodTally asString;
		<< ' controlled possessions on ';
		<< fromTeam;
		<< '''s ';
		<< fRod;
		<< ' ';
		<< self transitionTally asString;
		<< ' self transitions were recorded. ';
		yourself ]
		
	

]

{ #category : #access }
InstanceTransition >> genericTransition [
^GenericTransition newFromInstanceTransition: self

]

{ #category : #printing }
InstanceTransition >> printOn: aStream [
aStream
	<< 'Team';
	<< self fromRod key asString;
	space;
	<< self fromRod value printPseudoRod;
	<< ' to ';
	<< 'Team';
	<< self toRod key asString;
	space;
	<< self toRod value printPseudoRod;	
	<< ' - ';
	<< self transitionTally asString;
	<< ' [';
	<< self transitionProbability asString;
	<< ']'
	
]
