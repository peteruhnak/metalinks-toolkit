as yet unclassified
testInferContainer
	| observation |
	observation := inference inferClass: MTContainer.
	self assert: observation target equals: MTContainer.
	self assert: observation add equals: #(add:).
	self assert: observation remove equals: #(remove:).
	self assert: observation change equals: #(elements)