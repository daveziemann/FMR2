Class {
	#name : #BaselineOfFMR,
	#superclass : #BaselineOf,
	#category : #BaselineOfFMR
}

{ #category : #baselines }
BaselineOfFMR >> baseline: spec [
	<baseline>
	"subclasses should redefine me"
	
	"Here is a typical package and its tests
	spec for: #'common' do: [
		spec 
			package: #'XXX-Core';
			package: #'XXX-Core-Tests' with: [
				spec requires: #('XXX-Core' ) ].
		spec 
			group: 'Core' with: #('XXX-Core' );
			group: 'CoreTests' with: #('XXX-Core' 'XXX-Core-Tests');
			group: 'default' with: #('Beacon-XXX' 'Beacon-XXX-Tests') ]
	"
spec
	for: #common
	do: [
		"Dependencies"
		spec
			baseline: 'Roassal3'
			with: [ spec repository: 'github://ObjectProfile/Roassal3' ].

		"Packages"
		spec
			package: 'FMR' with: [ spec requires: #('Roassal3') ]	;
			package: 'FMR-Tests' with: [ spec requires: #('FMR') ]].
		
	
"
Metacello new
    repository: 'github://daveziemann/FMR/src';
    baseline: 'FMR';
    load
"

"	[Metacello new
		baseline: 'Roassal3';
		repository: 'github://ObjectProfile/Roassal3';
		load: 'Full' ] on: MCMergeOrLoadWarning do: [:warning | warning load ]
"
]

{ #category : #accessing }
BaselineOfFMR >> projectClass [
	^ MetacelloCypressBaselineProject
]
