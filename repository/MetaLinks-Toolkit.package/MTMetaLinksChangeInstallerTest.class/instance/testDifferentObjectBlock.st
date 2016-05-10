tests
testDifferentObjectBlock
	installer changeMetaObjectBlock: [ :obj :args | executed := #change ].
	installer addMetaObjectBlock: [ :obj :args | executed := #add ].
	installer removeMetaObjectBlock: [ :obj :args | executed := #remove ].
	installer installChangeObserverFor: #name to: MTElement.
	installer installAddObserverFor: #add: to: MTContainer.
	installer installRemoveObserverFor: #remove: to: MTContainer.
	self assert: executed equals: nil.
	element name: 'new name'.
	self assert: executed equals: #change.
	container add: element.
	self assert: executed equals: #add.
	container remove: element.
	self assert: executed equals: #remove