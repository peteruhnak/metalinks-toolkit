tests
newContainerObservation
	^ MTObservationSet
		target: MTContainer
		change: #(elements)
		add: #(add:)
		remove: #(remove:)