tests
testInstallObservations
	self deny: (MTElement >> #name:) hasLinks.
	self deny: (MTContainer >> #add:) hasLinks.
	installer
		install:
			{MTObservationSet new
				target: MTElement;
				change: #(name).
			MTObservationSet new
				target: MTContainer;
				add: #(add:)}.
	self assert: (MTElement >> #name:) hasLinks.
	self assert: (MTContainer >> #add:) hasLinks