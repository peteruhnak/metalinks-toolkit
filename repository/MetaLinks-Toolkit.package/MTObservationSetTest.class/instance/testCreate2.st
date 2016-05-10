tests
testCreate2
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