tests
testInstallMethod
	metaLink := MetaLink new.
	self assert: (target class >> #name) ast links equals: nil.
	self array: (installer methodLinksAt: target class at: #name) equals: #().
	installer installPermanent: metaLink toMethod: #name of: target class.
	self set: (target class >> #name) ast links equals: {metaLink}.
	self array: (installer methodLinksAt: target class at: #name) equals: {metaLink}