Extension { #name : #Number }

{ #category : #'*FMR' }
Number >> divideBy: numberOrMagnitude [
"Safely divide by zero"

^numberOrMagnitude divideIntoNumber: self
]

{ #category : #'*FMR' }
Number >> divideIntoMagnitude: aMagnitude [
^self isZero
	ifTrue: [ Duration zero ]
	ifFalse: [ aMagnitude / self ]
]

{ #category : #'*FMR' }
Number >> divideIntoNumber: aNumber [
^self isZero
	ifTrue: [ 0 ]
	ifFalse: [ aNumber / self ]
]
