Extension { #name : #Collection }

{ #category : #'*FMR' }
Collection >> sumDurations [
^ self 
	inject: Duration zero
	into: [ :sum :each | sum + each ]
]
