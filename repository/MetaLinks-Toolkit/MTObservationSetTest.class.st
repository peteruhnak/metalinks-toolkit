Class {
	#name : #MTObservationSetTest,
	#superclass : #TestCase,
	#category : 'MetaLinks-Toolkit-Tests'
}

{ #category : #tests }
MTObservationSetTest >> testCreate [
	| observation |
	observation := MTObservationSet
		fromAssociation:
			MTContainer
				-> (Array with: #change -> #(elements) with: #add -> #(add:) with: #remove -> #(remove:)).
	self assert: observation target equals: MTContainer.
	self assert: observation change equals: #(elements).
	self assert: observation add equals: #(add:).
	self assert: observation remove equals: #(remove:)
]

{ #category : #tests }
MTObservationSetTest >> testCreate2 [
	| observation |
	observation := MTObservationSet
		target: MTContainer
		change: #(elements)
		add: #(add:)
		remove: #(remove:).
	self assert: observation target equals: MTContainer.
	self assert: observation change equals: #(elements).
	self assert: observation add equals: #(add:).
	self assert: observation remove equals: #(remove:)
]

{ #category : #tests }
MTObservationSetTest >> testPrint [
	| observation |
	observation := MTObservationSet
		target: MTContainer
		change: #(elements)
		add: #(add:)
		remove: #(remove:).
	self
		assert: observation asString
		equals: 'a MTObservationSet(
	#change -> #(#elements).
	#add -> #(#add:).
	#remove -> #(#remove:)
)'
]
