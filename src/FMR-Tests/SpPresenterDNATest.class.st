Class {
	#name : #SpPresenterDNATest,
	#superclass : #FMRTestCase,
	#category : #'FMR-Tests'
}

{ #category : #tests }
SpPresenterDNATest >> testShapeCreationAndHoverMethod [
| spDNA |

spDNA := SpPresenterDNA basicNew matchState: self matchState; initialize.
spDNA createShapes do: [ :eachPair |
	eachPair second do: [ :eachShape | eachShape model shapeHoverText ]]
]
