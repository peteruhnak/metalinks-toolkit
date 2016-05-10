tests
testChangeObserver
	self deny: (MTElement >> #name:) hasLinks.
	installer installChangeObserverFor: #name to: MTElement.
	self assert: (MTElement >> #name:) linkCount equals: 1.
	element when: ValueChanged do: [ :evt | executed := evt newValue ].
	self assert: executed equals: nil.
	element name: 'new name'.
	self assert: executed equals: 'new name'