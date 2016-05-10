tests
testInstallAttribute
	metaLink := MetaLink new.
	self deny: (target class >> #name:) hasLinks.
	self assert: (target class >> #name:) ast assignmentNodes first links equals: nil.
	self array: (installer attributeLinksAt: target class at: #name) equals: #().
	installer installPermanent: metaLink toAttribute: #name of: target class.
	self array: (installer attributeLinksAt: target class at: #name) equals: {metaLink}.
	self set: (target class >> #name:) ast assignmentNodes first links equals: {metaLink}