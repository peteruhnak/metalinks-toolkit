Class {
	#name : #MTMetaLinksInferenceTest,
	#superclass : #TestCase,
	#instVars : [
		'inference'
	],
	#category : 'MetaLinks-Toolkit-Tests'
}

{ #category : #running }
MTMetaLinksInferenceTest >> setUp [
	super setUp.
	inference := MTMetaLinksInference new
]

{ #category : #'as yet unclassified' }
MTMetaLinksInferenceTest >> testAdditions [
	self assert: (inference additionsIn: MTElement) equals: #().
	self assert: (inference additionsIn: MTContainer) equals: #(add:)
]

{ #category : #'as yet unclassified' }
MTMetaLinksInferenceTest >> testExample [
	MTMetaLinksInference example
]

{ #category : #'as yet unclassified' }
MTMetaLinksInferenceTest >> testIgnoredVariables [
	self
		assert: (inference filterInstanceVariables: #(announcer hello world))
		equals: #(hello world).
	inference ignoredInstanceVariables: #(hello world).
	self
		assert: (inference filterInstanceVariables: #(announcer hello world))
		equals: #(announcer)
]

{ #category : #'as yet unclassified' }
MTMetaLinksInferenceTest >> testInferContainer [
	| observation |
	observation := inference inferClass: MTContainer.
	self assert: observation target equals: MTContainer.
	self assert: observation add equals: #(add:).
	self assert: observation remove equals: #(remove:).
	self assert: observation change equals: #(elements)
]

{ #category : #'as yet unclassified' }
MTMetaLinksInferenceTest >> testInferElement [
	| observation |
	observation := inference inferClass: MTElement.
	self assert: observation target equals: MTElement.
	self assert: observation add equals: #().
	self assert: observation remove equals: #().
	self assert: observation change equals: #(name owner uuid)
]

{ #category : #'as yet unclassified' }
MTMetaLinksInferenceTest >> testInferTargets [
	| observations |
	observations := inference inferClasses: (Set with: MTElement with: MTContainer).
	self assert: observations keys asSet equals: (Set with: MTElement with: MTContainer)
]

{ #category : #'as yet unclassified' }
MTMetaLinksInferenceTest >> testRemovals [
	self assert: (inference removalsIn: MTElement) equals: #().
	self assert: (inference removalsIn: MTContainer) equals: #(remove:)
]
