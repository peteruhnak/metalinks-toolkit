as yet unclassified
testInferTargets
	| observations |
	observations := inference inferClasses: (Set with: MTElement with: MTContainer).
	self assert: observations keys asSet equals: (Set with: MTElement with: MTContainer)