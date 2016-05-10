tests
testReinstallAttribute
	target primitiveChangeClassTo: target class newAnonymousSubclass new.
	metaLink := MetaLink new.
	installer installPermanent: metaLink toAttribute: #name of: target class.
	target class compile: 'resetName name := ''some name'''.
	self set: (target class >> #resetName) ast assignmentNodes first links equals: {metaLink}