tests
testPrint
	| observation |
	observation := MTObservationSet
		target: MTContainer
		change: #(elements)
		add: #(add:)
		remove: #(remove:).
	self
		assert: observation asString
		equals: 'a MTObservationSet{#change -> #(#elements). #add -> #(#add:). #remove -> #(#remove:)}'