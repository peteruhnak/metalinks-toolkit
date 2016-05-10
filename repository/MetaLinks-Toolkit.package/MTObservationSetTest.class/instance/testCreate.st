tests
testCreate
	| observation |
	observation := MTObservationSet
		fromAssociation:
			MTContainer
				-> (Array with: #change -> #(elements) with: #add -> #(add:) with: #remove -> #(remove:)).
	self assert: observation target equals: MTContainer.
	self assert: observation change equals: #(elements).
	self assert: observation add equals: #(add:).
	self assert: observation remove equals: #(remove:)