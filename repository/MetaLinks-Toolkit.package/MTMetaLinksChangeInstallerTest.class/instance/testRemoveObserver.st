tests
testRemoveObserver
	self deny: (MTContainer >> #remove:) hasLinks.
	installer installRemoveObserverFor: #remove: to: MTContainer.
	self assert: (MTContainer >> #remove:) linkCount equals: 1.
	container add: element.
	container when: ValueRemoved do: [ :evt | executed := evt oldValue ].
	self assert: executed equals: nil.
	container remove: element.
	self assert: executed equals: element