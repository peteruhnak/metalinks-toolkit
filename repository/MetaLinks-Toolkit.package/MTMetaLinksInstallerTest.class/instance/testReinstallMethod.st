tests
testReinstallMethod
	target primitiveChangeClassTo: target class newAnonymousSubclass new.
	target class compile: 'name ^ name'.
	metaLink := MetaLink new.
	installer installPermanent: metaLink toMethod: #name of: target class.
	target class removeSelector: #name.
	self deny: (target class selectors includes: #name).
	target class compile: 'name ^ name'.
	self set: (target class >> #name) ast links equals: {metaLink}.
	self array: (installer methodLinksAt: target class at: #name) equals: {metaLink}