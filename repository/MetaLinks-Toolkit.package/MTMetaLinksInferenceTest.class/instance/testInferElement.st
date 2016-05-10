as yet unclassified
testInferElement
	| observation |
	observation := inference inferClass: MTElement.
	self assert: observation target equals: MTElement.
	self assert: observation add equals: #().
	self assert: observation remove equals: #().
	self assert: observation change equals: #(name owner uuid)