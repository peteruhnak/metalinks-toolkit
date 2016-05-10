tests
testNoAttributeLinkToInitialize
	target primitiveChangeClassTo: target class newAnonymousSubclass new.
	metaLink := MetaLink new.
	installer installPermanent: metaLink toAttribute: #name of: target class.
	target class
		compile:
			'initialize
	super initialize.
	name := '''''.
	self assert: (target class >> #initialize) ast assignmentNodes first links equals: nil.
	self deny: (target class >> #initialize) hasLinks