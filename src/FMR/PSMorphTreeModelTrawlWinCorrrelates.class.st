Class {
	#name : #PSMorphTreeModelTrawlWinCorrrelates,
	#superclass : #'PSMorphTreeModel_',
	#category : #FMR
}

{ #category : #building }
PSMorphTreeModelTrawlWinCorrrelates >> buildColumnsDynamic [
^{}
]

{ #category : #building }
PSMorphTreeModelTrawlWinCorrrelates >> buildColumnsLeadingStatic [
^OrderedCollection new
	add: (MorphTreeColumn new
		startWidth: 100;
		rowMorphGetSelector: #statisticName;
		headerButtonLabel: 'Statistic' font: nil);
	add: (MorphTreeColumn new
		startWidth: 100;
		rowMorphGetSelector: #correlation;
		headerButtonLabel: 'Win Correlation' font: nil);
	yourself
		
]

{ #category : #UI }
PSMorphTreeModelTrawlWinCorrrelates >> mouseDown: aThing [
aThing inspect
]

{ #category : #building }
PSMorphTreeModelTrawlWinCorrrelates >> rootItems [
^rootItems ifNil: [ rootItems := self trawlForWinCorrelation ]
]

{ #category : #building }
PSMorphTreeModelTrawlWinCorrrelates >> rootNodeClassFromItem: anItem [
^PSMorphTreeNodeModelWinCorrelate
]

{ #category : #building }
PSMorphTreeModelTrawlWinCorrrelates >> trawlForWinCorrelation [
|  teamClasses results matchTally winningTeamHadHigherValue |

teamClasses := PresentableStatistic_ subclassesAll select: [ :e| e isTeamStatistic ].
results := Dictionary new.
matchTally := 0.
MatchStateEnumerator new allCompletedStandardMatchesDo: [ :eachMatchState |
	matchTally := matchTally + 1.
	teamClasses do: [ :eachClass |
		winningTeamHadHigherValue := (eachClass new matchState: eachMatchState) trawlForWinCorrelation.
		results at: eachClass put: (results at: eachClass ifAbsent: 0)+winningTeamHadHigherValue asBit ]].
^(results associations collect: [ :e | e key -> ((e value asFloat divideBy: matchTally) * 100) rounded ])
	asSortedCollection: [ :a :b | a value > b value ]
]
