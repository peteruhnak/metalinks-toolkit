tests
testUninstallMethod
	metaLink := MetaLink new.
	installer installPermanent: metaLink toMethod: #name of: target class.
	installer uninstallMethod: #name of: target class.
	self assert: (target class >> #name) ast links equals: nil.
	self array: (installer methodLinksAt: target class at: #name) equals: #()