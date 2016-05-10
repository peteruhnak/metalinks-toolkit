tests
testInstallObservation
	observation := self newContainerObservation.
	self deny: (MTContainer >> #add:) hasLinks.
	self deny: (MTContainer >> #remove:) hasLinks.
	installer installObservation: observation.
	self assert: (MTContainer >> #add:) hasLinks.
	self assert: (MTContainer >> #remove:) hasLinks