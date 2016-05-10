tests
testAddObserver
	self deny: (MTContainer >> #add:) hasLinks.
	installer installAddObserverFor: #add: to: MTContainer.
	self assert: (MTContainer >> #add:) linkCount equals: 1.
	container when: ValueAdded do: [ :evt | executed := evt newValue ].
	self assert: executed equals: nil.
	container add: element.
	self assert: executed equals: element