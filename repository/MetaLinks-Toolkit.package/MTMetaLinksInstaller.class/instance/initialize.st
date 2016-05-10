initialization
initialize
	super initialize.
	attributeLinks := Dictionary new.
	methodLinks := Dictionary new.
	ignoredSelectors := #(initialize).
	self registerToSystemAnnouncer