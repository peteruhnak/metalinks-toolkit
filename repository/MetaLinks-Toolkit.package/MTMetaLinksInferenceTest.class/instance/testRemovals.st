as yet unclassified
testRemovals
	self assert: (inference removalsIn: MTElement) equals: #().
	self assert: (inference removalsIn: MTContainer) equals: #(remove:)