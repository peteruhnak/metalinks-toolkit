"
I hold targets for a particular class.
"
Class {
	#name : #MTObservationSet,
	#superclass : #Object,
	#instVars : [
		'target',
		'add',
		'remove',
		'change'
	],
	#category : 'MetaLinks-Toolkit'
}

{ #category : #'instance creation' }
MTObservationSet class >> fromAssociation: anAssociation [
	^ self
		target: anAssociation key
		change: (anAssociation value asDictionary at: #change ifAbsent: [ #() ])
		add: (anAssociation value asDictionary at: #add ifAbsent: [ #() ])
		remove: (anAssociation value asDictionary at: #remove ifAbsent: [ #() ])
]

{ #category : #'instance creation' }
MTObservationSet class >> target: aTarget change: aChangeSet add: anAddSet remove: aRemoveSet [
	^ self new
		target: aTarget;
		change: aChangeSet;
		add: anAddSet;
		remove: aRemoveSet;
		yourself
]

{ #category : #accessing }
MTObservationSet >> add [
	^ add
]

{ #category : #accessing }
MTObservationSet >> add: aCollection [
	add := aCollection
]

{ #category : #accessing }
MTObservationSet >> change [
	^ change
]

{ #category : #accessing }
MTObservationSet >> change: aCollection [
	change := aCollection
]

{ #category : #initialization }
MTObservationSet >> initialize [
	super initialize.
	add := #().
	remove := #().
	change := #()
]

{ #category : #printing }
MTObservationSet >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: '(';  cr; tab.
	aStream nextPutAll: '#change -> '.
	self change printOn: aStream.
	aStream nextPutAll: '.'; cr; tab.
	aStream nextPutAll: '#add -> '.
	self add printOn: aStream.
	aStream nextPutAll: '.'; cr; tab.
	aStream nextPutAll: '#remove -> '.
	self remove printOn: aStream.
	aStream nextPutAll: ''; cr.
	aStream nextPutAll: ')'
]

{ #category : #accessing }
MTObservationSet >> remove [
	^ remove
]

{ #category : #accessing }
MTObservationSet >> remove: aCollection [
	remove := aCollection
]

{ #category : #accessing }
MTObservationSet >> target [
	^ target
]

{ #category : #accessing }
MTObservationSet >> target: aClass [
	target := aClass
]
