as yet unclassified
testAdditions
	self assert: (inference additionsIn: MTElement) equals: #().
	self assert: (inference additionsIn: MTContainer) equals: #(add:)