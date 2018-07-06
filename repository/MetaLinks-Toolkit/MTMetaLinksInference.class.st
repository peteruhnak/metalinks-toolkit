"
Provide me with a package or a set of classes, and I will try to guess where Change Metalinks should be installed.

!! Example

see class-side for example
"
Class {
	#name : #MTMetaLinksInference,
	#superclass : #Object,
	#instVars : [
		'ignoredInstanceVariables'
	],
	#category : 'MetaLinks-Toolkit'
}

{ #category : #example }
MTMetaLinksInference class >> example [
	<playgroundExample>
MTMetaLinksInference new inferClasses: { MTElement . MTContainer }
"((RPackage organizer packageNamed: 'Borm-Model')
	classTagNamed: 'Models') classes"
]

{ #category : #'inferring - private' }
MTMetaLinksInference >> additionsIn: aClass [
	^ (self instanceMessagesIn: aClass)
		select: [ :each | each selector = #add: ]
		thenCollect: #selector
]

{ #category : #filtering }
MTMetaLinksInference >> filterInstanceVariables: aCollection [
	^ aCollection copyWithoutAll: ignoredInstanceVariables
]

{ #category : #accessing }
MTMetaLinksInference >> ignoredInstanceVariables: aCollection [
	ignoredInstanceVariables := aCollection
]

{ #category : #inferring }
MTMetaLinksInference >> inferClass: aClass [
	| observations |
	observations := MTObservationSet new.
	observations target: aClass.
	observations add: (self additionsIn: aClass).
	observations remove: (self removalsIn: aClass).
	observations change: (self instanceVariablesIn: aClass).
	^ observations
]

{ #category : #inferring }
MTMetaLinksInference >> inferClasses: classes [
	^ (classes collect: [ :each | each -> (self inferClass: each) ]) asDictionary
]

{ #category : #initialization }
MTMetaLinksInference >> initialize [
	super initialize.
	ignoredInstanceVariables := #(announcer)
]

{ #category : #'inferring - private' }
MTMetaLinksInference >> instanceMessagesIn: aClass [
	| vars messages |
	vars := self instanceVariablesIn: aClass.
	messages := aClass methods
		flatCollect: [ :each | each ast allChildren select: #isMessage ].
	^ messages
		select: [ :each | each receiver isVariable and: [ vars includes: each receiver name ] ]
]

{ #category : #'inferring - private' }
MTMetaLinksInference >> instanceVariablesIn: aClass [
	^ self filterInstanceVariables: aClass instVarNames
]

{ #category : #'inferring - private' }
MTMetaLinksInference >> removalsIn: aClass [
	^ (self instanceMessagesIn: aClass)
		select: [ :each | each selector = #remove: ]
		thenCollect: #selector
]
