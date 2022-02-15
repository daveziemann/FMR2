Class {
	#name : #SpPresenterFMRAbout,
	#superclass : #'SpPresenterFMR_',
	#instVars : [
		'about',
		'link'
	],
	#category : #FMR
}

{ #category : #'instance creation' }
SpPresenterFMRAbout class >> defaultExtent [
^400@200
]

{ #category : #specs }
SpPresenterFMRAbout class >> defaultSpec [
	^ SpBoxLayout newTopToBottom
		add: #about withConstraints: [ :c | c height: 50 ];
		add: #link withConstraints: [ :c | c height: 15 ];
		yourself
]

{ #category : #'instance creation' }
SpPresenterFMRAbout class >> open [
	<script>
	self new openWithSpec extent: self defaultExtent
]

{ #category : #specs }
SpPresenterFMRAbout class >> title [
^'About Foosball Matchplay Recorder'
]

{ #category : #accessing }
SpPresenterFMRAbout >> about [

	^ about
]

{ #category : #accessing }
SpPresenterFMRAbout >> about: anObject [

	about := anObject
]

{ #category : #initialization }
SpPresenterFMRAbout >> initializePresenters [
self about: self newText beNotEditable beWrapWord.
self about text: 'Foosball Matchplay Recorder © 2021 by David Ziemann
is licensed under Attribution-NoDerivatives 4.0 International.'.
self link: self newLink.
self link
	url: 'http://creativecommons.org/licenses/by-nd/4.0/';
	label: 'Click here to view a copy of this license.';
	color: Color red.
]

{ #category : #accessing }
SpPresenterFMRAbout >> link [

	^ link
]

{ #category : #accessing }
SpPresenterFMRAbout >> link: anObject [

	link := anObject
]
