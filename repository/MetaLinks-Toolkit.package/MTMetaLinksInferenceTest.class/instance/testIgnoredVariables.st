as yet unclassified
testIgnoredVariables
	self
		assert: (inference filterInstanceVariables: #(announcer hello world))
		equals: #(hello world).
	inference ignoredInstanceVariables: #(hello world).
	self
		assert: (inference filterInstanceVariables: #(announcer hello world))
		equals: #(announcer)