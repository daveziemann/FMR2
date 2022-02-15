Class {
	#name : #'PSMorphTreeModel_',
	#superclass : #MorphTreeModel,
	#instVars : [
		'statisticsGenerator',
		'gameNumbersToShow',
		'bodyFont'
	],
	#category : #FMR
}

{ #category : #UI }
PSMorphTreeModel_ >> bodyFont [
^bodyFont ifNil: [ self bodyFontDefault ]
]

{ #category : #UI }
PSMorphTreeModel_ >> bodyFontDefault [
^LogicalFont familyName: 'Source Sans Pro' pointSize: 16
]

{ #category : #building }
PSMorphTreeModel_ >> buildColumns [
^self buildColumnsLeadingStatic,self buildColumnsDynamic
]

{ #category : #building }
PSMorphTreeModel_ >> buildColumnsDynamic [
^self subclassResponsibility 
]

{ #category : #building }
PSMorphTreeModel_ >> buildColumnsLeadingStatic [
^self subclassResponsibility 
]

{ #category : #UI }
PSMorphTreeModel_ >> gameNumbers [ 
^self gameNumbersToShow ifNil: [ self matchState gameNumbers ]
]

{ #category : #accessing }
PSMorphTreeModel_ >> gameNumbersToShow [

	^ gameNumbersToShow
]

{ #category : #accessing }
PSMorphTreeModel_ >> gameNumbersToShow: anObject [

	gameNumbersToShow := anObject
]

{ #category : #UI }
PSMorphTreeModel_ >> headerFont [
"^LogicalFont familyName: 'Source Sans Pro' pointSize: 7."
^nil
]

{ #category : #access }
PSMorphTreeModel_ >> matchState [ 
^self statisticsGenerator matchState
]

{ #category : #UI }
PSMorphTreeModel_ >> mouseDown: aPresentableStatistic [
aPresentableStatistic mouseDown
]

{ #category : #UI }
PSMorphTreeModel_ >> open [
	(self treeMorph buildContents;
		embeddedInMorphicWindowLabeled: 'Stats prototype') openInWorld
]

{ #category : #building }
PSMorphTreeModel_ >> rootNodeClassFromItem: anItem [
^PSMorphTreeNodeModel
]

{ #category : #accessing }
PSMorphTreeModel_ >> statisticsGenerator [

	^ statisticsGenerator
]

{ #category : #accessing }
PSMorphTreeModel_ >> statisticsGenerator: anObject [

	statisticsGenerator := anObject
]

{ #category : #building }
PSMorphTreeModel_ >> treeMorph [
| treeMorph |

treeMorph := (self treeMorphClass on: self)
	columns: self buildColumns;
	columnInset: 3;
	rowInset: 1;
	preferedPaneColor: Color white;
	rowColorForEven:  Color veryLightGray muchLighter odd: Color white.
treeMorph columnResizers do: [ :eachColumnResizer | eachColumnResizer resizeColumnToFit ].
^treeMorph 
]
