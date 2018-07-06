"
I am a dummy target for MetaLinks installer tests.
"
Class {
	#name : #MTContainer,
	#superclass : #MTElement,
	#instVars : [
		'elements'
	],
	#category : 'MetaLinks-Toolkit-Tests'
}

{ #category : #adding }
MTContainer >> add: anElement [
	elements add: anElement.
	anElement owner: self
]

{ #category : #accessing }
MTContainer >> elements [
	^ elements
]

{ #category : #initialization }
MTContainer >> initialize [
	super initialize.
	elements := OrderedCollection new
]

{ #category : #removing }
MTContainer >> remove: anElement [
	elements remove: anElement.
	anElement owner: nil
]
