tests
testUninstallAttribute
	metaLink := MetaLink new.
	installer installPermanent: metaLink toAttribute: #name of: target class.
	installer uninstallAttribute: #name of: target class.
	self assert: (target class >> #name:) ast assignmentNodes first links equals: nil.
	self array: (installer attributeLinksAt: target class at: #name) equals: #()